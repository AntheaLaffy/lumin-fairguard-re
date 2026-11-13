# IL2CPP 符号与资源恢复记录

验证日期：2026-11-13。样本：客户端 1.0.2、build 12450、native build 11974、Unity 2022.3.62f2、Win64/bilibili。

本轮目标是取得可供任意目标语言使用的代码与资源证据。Python 只用于离线分析，未开展 Python 客户端重写。下面的地址属于保存的进程快照，不能直接套到另一次启动。

## 1. 已确认的结果

| 产物 | 数量与检查 | 路径 |
| --- | --- | --- |
| AOT 类型与方法声明 | 139 个 image、20,189 个 TypeDef；最后索引 20,188；Dumper 完整结束 | `recon/il2cpp_verified/dump.cs` |
| 结构、符号与字符串映射 | `il2cpp.h`、`script.json`、`stringliteral.json` 均生成完成 | `recon/il2cpp_verified/` |
| DummyDll | 139 个 DLL；这是声明占位程序集，不包含恢复的 AOT 方法 IL | `recon/il2cpp_verified/DummyDll/` |
| HybridCLR DLL | 48 个，按 TextAsset 长度完整导出；SHA-256、PE 节末端与文件长度相符 | `recon/unpacked/Dll/BundleFiles/7c/7cffd28bf51ff3182f6232eadb296126/TextAssets/` |
| ClientStatic | 377 个 bundle 全部恢复；374 个 TextAsset 全部通过 JSON 解析，其余 bundle 没有 TextAsset | `recon/unpacked/ClientStatic/BundleFiles/` |
| Assets | 实际恢复并读取 745 个 bundle，零失败；包含网格、材质、纹理、动画、场景对象等 | `recon/unpacked/Assets/BundleFiles/` |

批处理共验证 **1,123 个 bundle**。当时冻结的输入清单含 12,883 项，游戏仍在下载，因此不能把本次抽样说成所有远端资源已全部导出。已按用户要求停止扩大批处理，转入资料整理；清单 `complete=false` 表示未遍历整个输入清单，`failures=[]` 表示已处理项没有失败。

`recon/unpacked/manifest.json` 保存输入与恢复文件的哈希、对象种类、TextAsset 名称/长度/哈希。`recon/verification/artifact-checks.json` 是 DLL 与 JSON 的汇总检查；`recon/artifacts.json` 是主要大文件和 DummyDll 的完整性目录。

## 2. metadata registration 为什么一直扫描不到

原扫描脚本要求 `typesCount=64275`、`fieldOffsetsCount=89583`。这两个条件都不符合样本：89,583 是元数据里的字段总量，而 registration 的 fieldOffsets 是**按类型索引的字段偏移表指针数组**。

真实结构位于保存的 `.rdata`，并不需要继续全进程搜 heap：

| 字段 | 实测值 |
| --- | --- |
| 解密 GameAssembly 映像基址 | `0x6fffee6c0000` |
| CodeRegistration | `0x6ffff249b210` |
| MetadataRegistration | `0x6ffff2ccd910` |
| typesCount | **75,408** |
| fieldOffsetsCount | **20,189** |
| typeDefinitionsSizesCount | **20,189** |
| codeGenModulesCount | **139** |

完整 qword 字段、139 个模块名称见 `recon/il2cpp_verified/registrations.json`。其中包含特殊模块名 `__Generated`，不能把“所有模块都必须以 .dll 结尾”作为识别条件。

定位方法：从 v31 metadata 头读取 typeDefinitions 表大小并除以 88，得到 20,189；在 rdata 内以原生 `bytes.find` 搜索其 64 位模式，只对少量命中检查相邻计数、表指针边界和全部模块名。注册结构的定义对照 [Il2CppDumper 源码](https://github.com/Perfare/Il2CppDumper/blob/master/Il2CppDumper/Il2Cpp/Il2CppClass.cs)。完整重建与搜索一次实测约 **0.84 秒**，没有暂停游戏。

原 GDB Python 脚本逐 4/8 字节扫描全内存，消耗单核并长时间暂停了目标进程。接手时已发送中断，使 GDB 脱离；后续资源恢复完全离线。

## 3. Il2CppDumper 输入重建

先前镜像把基址设成了磁盘保护壳映射所在的 `0x6ffff446b000`，而解密映像实际从 `0x6fffee6c0000` 开始。镜像修正如下：

| 保存的快照 | 写入 RVA |
| --- | --- |
| `recon/dump/rx_region.bin` | `0x1000` |
| `recon/dump/rdata_region.bin` | `0x3d20000` |
| `recon/dump/data_region.bin` | `0x4e31000` |

PE 的 ImageBase 改成解密基址，节的 raw offset 设为对应 RVA。metadata 使用已有的 `recon/dump/global-metadata.dec.dat`。这份 metadata 是 32 MiB 内存窗口，不应把整个窗口大小当成原始文件的精确长度；Dumper 已成功解析其有效表。

`GameAssembly.dll` 重建文件**只作为分析输入**：未保存的节/不可读区域仍然缺失，不能拿它替换游戏二进制运行。

Il2CppDumper 6.7.46 自动识别两张注册表，依次输出 Dumping / Generate struct / Generate dummy dll 的 Done；完整日志为 `recon/il2cpp_verified/dumper.log`。实际耗时数分钟，主要是输出大量符号，不是注册表搜索。

从项目根目录重建输入：

```sh
python3 recon/rebuild_il2cpp.py \
  lvmeng-prefix/drive_c/Games/Lvmeng/app/Lumin/Bin/GameAssembly.dll
```

重新生成符号时，在 `recon/il2cppdumper/config.json` 中把 `RequireAnyKey` 临时设为 `false`，执行：

```sh
dotnet recon/il2cppdumper/Il2CppDumper.dll \
  recon/il2cpp_verified/GameAssembly.dll \
  recon/dump/global-metadata.dec.dat \
  recon/il2cpp_verified
```

本轮使用默认版本识别即成功，无须强制更改 IL2CPP 版本。运行后已恢复原配置；已有产物无需再次生成。

## 4. 第 0 块：真实格式与恢复方法

### 4.1 外层是标准 UnityFS

header、blocksinfo、block/node 表的大端字段是 UnityFS 的标准格式，不是 FairGuard 的特殊改写。`CAB-*` 是 Unity 的 SerializedFile 节点名，不是另一个专有 CAB 压缩格式；里面的 DLL 是普通 TextAsset 对象。

本地 [UnityPy BundleFile 实现](../.venv/lib/python3.14/site-packages/UnityPy/files/BundleFile.py) 可直接对照。原报告以“不是 16 字节倍数”排除 CBC、再认定固定 CTR 密钥流的推断没有充分依据，已撤回。

### 4.2 前 8 字节不是额外魔数

常见密文前缀 `b0 a6 a7 a6 b0 b0 ad a6` 异或 `0xA6` 后是：

```text
16 00 01 00 16 16 0b 00
```

这就是原始 LZ4 压缩流的一部分。**不能剥掉这 8 字节。** 样本的前 32 字节经该异或可恢复压缩头，但后续字节不能沿用同一个常量密钥。

### 4.3 找到转换入口与调用长度

在可执行内存中搜索 `b0 a6 a7 a6` 的常量，定位到 FairGuard 的压缩头识别函数；沿交叉引用取得转换函数和 read hook：

| 位置 | 保存快照中的地址 | 相对 FairGuard 基址的 RVA |
| --- | --- | --- |
| FairGuard 映像基址 | `0x6ffff6f20000` | `0` |
| 头识别函数 | `0x6ffff6f84240` | `0x64240` |
| 转换原入口跳板 | `0x6ffff6f84550` | `0x64550` |
| 可直接模拟的展开入口 | `0x6ffff774120b` | `0x82120b` |
| read hook 调用处 | `0x6ffff6f53a6a` | `0x33a6a` |

调用处的关键行为是：

```text
buffer = read 返回的目标缓冲区
length = min(read 请求长度, 0x500)
transform(buffer, length)
```

因此要原位转换开头**最多 1,280 字节**，保持压缩块长度和剩余字节不变。把整个 1,398 字节小包都传给转换函数曾导致 LZ4 在 byte 50 附近失败；传入正确上限后恢复成功。这是调用契约问题，不是继续猜密钥的问题。

“block 0 已破解”在本报告中的含义：现有样本可**无损、完整、离线恢复**，而不是已经用目标语言重写全部密码实现。对不同 bundle 的模拟输出比较显示，32 字节之后的异或差值并不相同，不能缓存一个全局固定密钥流。

### 4.4 离线快照与独立性

`recon/dump/FairGuard.mem.bin` 捕获了必要的保护模块映像；同名 `.json` 保存 SHA-256、基址、入口和辅助函数 RVA。Unicorn 执行该映像，仅用等价桩替代分配、释放、栈 cookie 检查；不执行 Windows 进程注入，也不访问实时游戏内存。

每次转换恢复初始寄存器、清空临时栈/堆并恢复被写过的映像页；仅复用已翻译的机器码。新建模拟器与复用模拟器在 11 个代表输入上逐字节相同；热调用约 16–26 ms，测量记录见 `recon/dump/emulator-reuse-benchmark.json`。速度只是批处理优化，**正确性依据仍是完整 LZ4 长度及 Unity 对象解析**。

配置和映像必须配对。它们适用于保存的这个构建；没有宣称未来游戏更新后不经重新捕获仍可使用。

## 5. 资源恢复复现

现有 `.venv` 已装好 `UnityPy`、`lz4`、`unicorn`。另建分析环境时只需这些分析依赖；它们不是原生客户端依赖。

单包恢复为标准 UnityFS，并按真实 TextAsset 长度导出内容：

```sh
.venv/bin/python recon/unpack_resources.py \
  recon/bundles/cs_vol/__data /tmp/lumin-bundle-check
```

整个本地资源目录的可选批处理：

```sh
.venv/bin/python recon/unpack_resources.py \
  lvmeng-prefix/drive_c/Games/Lvmeng/app/Lumin/Bin/Lumin_Data/yoo \
  recon/unpacked --resume
```

输出每个目录的 `restored.bundle` 可由普通 Unity 资源工具打开。`TextAssets/` 中内容是序列化对象的精确字节；DLL 不再通过扫描 MZ 标记和相邻文件边界猜长度。中断批处理时会完成当前包并写清单，不能把 `complete=false` 理解为解密失败。

首个实证为配置 `rogueArtifacts`：LZ4 输出精确 3,980 字节，UnityPy 得到 AssetBundle 与 TextAsset，TextAsset 为 1,042 字节 JSON。DLL 包恢复后得到 48 个 DLL，包括旧切片遗漏的 **Cinemachine.dll（256,000 字节）**；`Assembly-ACT.dll` 为 **14,600,704 字节**。

## 6. 旧结论修正与清理

| 旧说法 | 核实后的结论 |
| --- | --- |
| 大端 header 是保护改写 | 标准 UnityFS 本来如此 |
| 首块有额外 8 字节魔数 | 是加密后的 LZ4 字节，不能删 |
| 固定密钥流/CTR 已确定 | 未证明；实测不同包的差值不同 |
| 需要继续 hook LZ4 才能解包 | 保存的代码快照已能离线完成 |
| metadataReg 不在 rdata，判别数值已锁定 | 原计数假设错误；结构就在保存的 rdata |
| 47 个 DLL 全部完整提取 | 实际 48 个；旧切片还夹带了对象间数据 |
| 加固已“全面破解” | 本轮完成了样本符号、DLL、资源恢复；未覆盖所有安全机制 |

已删除 14 个重复/失效/试错脚本，以及旧的 PE 猜测切片算法和临时仿真脚本。Python 启动器及 API 示例压缩到 `recon/archive/python-launcher.tar.gz`，不再作为活动客户端项目。活动分析脚本仅保留两个入口及两个 helper：

```text
recon/rebuild_il2cpp.py
recon/unpack_resources.py
recon/analysis_tools/fairguard.py
recon/analysis_tools/fairguard_runtime.py
```

Il2CppDumper 自带的 IDA/Ghidra Python 导入脚本属于第三方工具，保留以便导入符号。

## 7. 原生客户端重写的边界

这些结果消除了“看不到 AOT 声明、热更程序集和配置/资源”的障碍，且与最终实现语言无关。它们不等于可直接重编译的官方完整工程：AOT 声明缺少方法实现，恢复的 GameAssembly 仍是 Windows 原生代码，Unity 对象也需要目标运行时理解或转换。

完整原生客户端还需要确定渲染/引擎替代方案，梳理 48 个程序集中的业务逻辑及其 Unity/平台依赖，并按实际功能验证登录、会话、游戏业务网络协议和服务端兼容性。本轮没有证明这些部分已经完成；启动器 HTTP 分发协议与游戏业务协议应分别看待。

历史 Proton 运行截图只证明 Windows 客户端在兼容层中渲染成功，不能当作原生 Linux 客户端重写已完成的证据。继续工作应围绕目标语言和具体功能切片展开，而不是扩大 Python 启动器或为已可读取的资源重复写解密算法。
