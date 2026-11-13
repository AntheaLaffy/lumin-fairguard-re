
ì
gm.protopb"!
GmActionProcessReq
cmd (	"$
GmActionProcessAck
result (	"-
GmChat

ts (
msg (	

gm ("

GmChatsReq"'

GmChatsAck
chats (2
.pb.GmChat"
	GmChatReq
msg (	"
	GmChatAck"%
	GmChatNtf
chat (2
.pb.GmChatbproto3
ç
match.protopb"D
EnterMatchReq
openId (	
loginKey (	
	accountId ("
EnterMatchAck
ret ("
MatchMsgStart"
MatchMsgEnd")
MatchForwardMessageReq
payload ("
MatchForwardMessageAck")
MatchForwardMessageNtf
payload (bproto3
ø

room.protopb"G
Room

id (
ownerPID (
pids (
createStamp ("
RoomInfoReq"%
RoomInfoAck
room (2.pb.Room"
RoomCreateReq"
RoomCreateAck
roomId ("
RoomJoinReq
roomId ("
RoomJoinAck
roomId ("
RoomLeaveReq
roomId ("
RoomLeaveAck"
RoomJoinNtf
roomId ("3
RoomJoinConfirmReq
	joinerPID (

ok ("
RoomJoinConfirmAck" 
RoomJoinConfirmNtf

ok ("
RoomKickoutReq
pid ("
RoomKickoutAck"*
RoomSetPermissionReq

permission ("
RoomSetPermissionAck"!
RoomNtf
room (2.pb.Room"
RoomSyncReq
bytes ("
RoomSyncAck"5
RoomForwardingMessageNtf
pid (
data (bproto3
õœ
common.protopb"C

ErrorParam
uid (
banEndTimestamp (
fairTag ("ê
ErrorAck
code (
message (	
errCode (	
codeType (

codeModule (
subCode (
param (2.pb.ErrorParam"2
DemandDataReq
indexs (	
	tableName (	"!
DemandDataAck
contexts (	"ú
AttributeNtf

id (.
changes (2.pb.AttributeNtf.ChangesEntry 
	changeWay (2.pb.ItemsWays.
ChangesEntry
key (
value (:8"	
PingReq"
PingAck

ts ("J
KickUserNtf
reason (	
errCode (	
info (2.pb.ErrorAck"ﬁ
DetailUserInfo 
brief (2.pb.BriefUserInfo6

attributes (2".pb.DetailUserInfo.AttributesEntry.
counts (2.pb.DetailUserInfo.CountsEntry8
dailyCounts (2#.pb.DetailUserInfo.DailyCountsEntry6

conditions (2".pb.DetailUserInfo.ConditionsEntry@
dailyConditions (2'.pb.DetailUserInfo.DailyConditionsEntry6

weekCounts (2".pb.DetailUserInfo.WeekCountsEntry"
profile (2.pb.PlayerProfile1
AttributesEntry
key (
value (:8-
CountsEntry
key (
value (:82
DailyCountsEntry
key (
value (:81
ConditionsEntry
key (
value (:86
DailyConditionsEntry
key (
value (:81
WeekCountsEntry
key (
value (:8"Ω
BriefUserInfo

id (
nickname (	

createTime (
serverIndex (
gender (
openId (	
level (
combat (
OfflineTime	 (
	accountId
 ("T
UserServerInfo
serverIndex (
nickname (	
lvl (
userId ("∞
CountNtf(
counts (2.pb.CountNtf.CountsEntry2
dailyCounts (2.pb.CountNtf.DailyCountsEntry0

weekCounts (2.pb.CountNtf.WeekCountsEntry-
CountsEntry
key (
value (:82
DailyCountsEntry
key (
value (:81
WeekCountsEntry
key (
value (:8"Ô
ConditionNtf4

conditions (2 .pb.ConditionNtf.ConditionsEntry>
dailyConditions (2%.pb.ConditionNtf.DailyConditionsEntry1
ConditionsEntry
key (
value (:86
DailyConditionsEntry
key (
value (:8"J

RankMember 
brief (2.pb.BriefUserInfo
data (
rank ("
ResetDailyNtf"@
 ExpiredTimeLimitItemAutoUseEntry
item_id (
uid ("U
ExpiredTimeLimitItemAutoUseNtf3
items (2$.pb.ExpiredTimeLimitItemAutoUseEntry"4
ItemDestroyedEntry
item_id (
count ("9
ItemDestroyedNtf%
items (2.pb.ItemDestroyedEntry"Ã
UniversalItem#
type (2.pb.UniversalItemType
uid (
index (
count (
isNew (%

extraItems (2.pb.UniversalItem

expireTime (!
tag (2.pb.UniversalItemTag"Q
Item

id (
count (
isNew (

expireTime (
uid ("O
SkinInfo
uid (
skinId (

obtainTime (

expireTime ("]
EffectDressInfo
uid (
effectDressId (

obtainTime (

expireTime ("ù
MonthlyPassEntry
passId (
expireTimeUnix (
lastDailyRewardUnix (
lastPopTimeUnix (
checkedDays (
totalCycleDays ("c
MonthlyPassPurchaseNtf"
pass (2.pb.MonthlyPassEntry%

extraItems (2.pb.UniversalItem"M
MonthlyPassDailyRewardNtf
passId ( 
items (2.pb.UniversalItem"B
MonthlyPassRecordPopReq
passId (
lastPopTimeUnix ("
MonthlyPassRecordPopAck":
MonthlyPassSyncNtf$
passes (2.pb.MonthlyPassEntry"O
OperationItem
index (
count (
chooseIndex (
uid ("0
BloodBottleItem

id (
	usedCount ("H
LittleItemsShortcutInfo
shortcutItems (
curShortcutIdx ("ì
LittleItems1
shortcutInfo (2.pb.LittleItemsShortcutInfo-
bloodBottleItems (2.pb.BloodBottleItem"

potionInfo (2.pb.PotionInfo"\

PotionItem

id (
level (
	additives (
useCount (
maxUse ("Ü

PotionInfo4
potionItems (2.pb.PotionInfo.PotionItemsEntryB
PotionItemsEntry
key (
value (2.pb.PotionItem:8"!
	PBVector2	
x (	
y ("$
PBVector2Int	
x (	
y ("2
PBVector2IntList
vecs (2.pb.PBVector2Int",
	PBVector3	
x (	
y (	
z ("%
Property

id (
value ("1
ChipSideProperties
indexes (

id (""
Skill

id (
level ("t
CharacterStatus

hp (
exPower (
assistPower (
energyPower (
specialEnergyPower ("(
ChipPosition
uid (
idx ("/
ChipSideSlot
chips (2.pb.ChipPosition"D
ChipSlot
coreChipUid (#
	sideSlots (2.pb.ChipSideSlot"Ü
CharacterEliteInfo
point (2
levels (2".pb.CharacterEliteInfo.LevelsEntry-
LevelsEntry
key (
value (:8"ì
	Character

id (
level (
exp (
stage (
	weaponUid ()
skills (2.pb.Character.SkillsEntry5
stageRewards (2.pb.Character.StageRewardsEntry#
status	 (2.pb.CharacterStatus=
skillGroupLevels
 (2#.pb.Character.SkillGroupLevelsEntry
constellation (Q
constellationEnabledStatus (2-.pb.Character.ConstellationEnabledStatusEntry

skillPoint (
chipSlot (2.pb.ChipSlot)
equips (2.pb.Character.EquipsEntry)
	eliteInfo (2.pb.CharacterEliteInfo
likeabilityExp (
likeabilityLevel (
skinId (
gotTime (
effectDressId (8
SkillsEntry
key (
value (2	.pb.Skill:83
StageRewardsEntry
key (
value (:87
SkillGroupLevelsEntry
key (
value (:8A
ConstellationEnabledStatusEntry
key (
value (:8-
EquipsEntry
key (
value (:8"è
Weapon
uid (
weaponId (
level (
exp (
refine (
stage (
lock (
source (2.pb.ItemsWays"ø
Chip
uid (

id (
level (
exp (
mainPropertyId (
lock (
source	 (2.pb.ItemsWays.
sideProperties
 (2.pb.ChipSideProperties
isNew ("â
Equip
uid (

id (
isLock (
wearCharacter (
type (2.pb.EquipType
quality (
level (!

attributes (2.pb.EquipAttr"
features	 (2.pb.EquipFeature
gemSlots
 (2.pb.GemSlot
source (2.pb.ItemsWays"&
	EquipAttr

id (
value (")
EquipFeature

id (
level (";
GemSlot
slotId (
	slotLevel (
gemId ("î
Gem
uid (

id (
isLock (
level (

inlayEquip ("
features (2.pb.EquipFeature
source (2.pb.ItemsWays"å
	Inventory
items (2.pb.Item
chips (2.pb.Chip
weapons (2
.pb.Weapon
equips (2	.pb.Equip
gems (2.pb.Gem"©
MissionState

id (
ready (
finished (
subMissionId (
subMissionProgress (
submitItems (2.pb.Item
bluePrintIds (H
completedSubmissions (2*.pb.MissionState.CompletedSubmissionsEntry;
CompletedSubmissionsEntry
key (
value (:8"
MissionSubState"Ç
EscInfo
	accountId (
nickName (	
	signature (	-
	avatarIds (2.pb.EscInfo.AvatarIdsEntry
curAvatarId (7
avatarFrameIds (2.pb.EscInfo.AvatarFrameIdsEntry
curAvatarFrameId (+
titleIds (2.pb.EscInfo.TitleIdsEntry

curTitleId	 (
showCharacterIds
 (
changeNameTime (
changeSignatureTime (0
AvatarIdsEntry
key (
value (:85
AvatarFrameIdsEntry
key (
value (:8/
TitleIdsEntry
key (
value (:8"X
SceneSpawnInfo
pos (2.pb.PBVector3
interactionObjUID (
chunkID ("C
SceneTempArchiveInfo
pos (2.pb.PBVector3
chunkID ("Q
ScenePosParam
gameworldID (
chunkID (
pos (2.pb.PBVector3"π
	SceneInfo
worldID (
lastPos (2.pb.PBVector3
checkPosUid (
playingMusic (
InstId (
transNo (	%
	spawnInfo	 (2.pb.SceneSpawnInfo
chunkID
 (
configID (0
tmpArchiveInfo (2.pb.SceneTempArchiveInfo'

worldLayer (2.pb.SceneWorldLayerJJ	"-
BuffWithRate

id (
	valueRate ("¢
FoodBuff#
	mainBuffs (2.pb.BuffWithRate$

minorBuffs (2.pb.BuffWithRate
startEffectTs (

minorItems (2.pb.Item
cookWay (2.pb.CookWay
	mainItems (2.pb.Item
menuID (
customWayNameID (
resetMinorBuffNum	 (
savedCustomMenu
 ("&
Buff
foodBuff (2.pb.FoodBuff"7

RedeemCode
	usedCodes (	
usedCodeBatchs ("ä
PlayerProfile
powerRecoverTs (
powerDailyBuyNum (
escInfo (2.pb.EscInfo$
sceneStatus (2.pb.SceneStatus5

sceneInfos (2!.pb.PlayerProfile.SceneInfosEntry
buff	 (2.pb.Buff
playingMusic
 (
settingOptions (	
roomId ("

redeemCode (2.pb.RedeemCode@
SceneInfosEntry
key (
value (2.pb.SceneInfo:8JJJ"c

PresetTeam
characterIds (
name (	
battleCharacterIdx (
equipPotionId ("†
CharacterRepository;

characters (2'.pb.CharacterRepository.CharactersEntry<
characterDependSnapshot (2.pb.CharacterDependSnapshotE
extraCharacters (2,.pb.CharacterRepository.ExtraCharactersEntryA
extraCharacterDependSnapshot (2.pb.CharacterDependSnapshot5
potions (2$.pb.CharacterRepository.PotionsEntry?
trialPotions (2).pb.CharacterRepository.TrialPotionsEntry@
CharactersEntry
key (
value (2.pb.Character:8E
ExtraCharactersEntry
key (
value (2.pb.Character:8>
PotionsEntry
key (
value (2.pb.PotionItem:8C
TrialPotionsEntry
key (
value (2.pb.PotionItem:8"°
CharacterDependSnapshotE
equipSnapshot (2..pb.CharacterDependSnapshot.EquipSnapshotEntryA
gemSnapshot (2,.pb.CharacterDependSnapshot.GemSnapshotEntry?
EquipSnapshotEntry
key (
value (2	.pb.Equip:8;
GemSnapshotEntry
key (
value (2.pb.Gem:8"á
Team
characterIds (
battleCharacterIdx (
extraCharacterIds (
equipPotionId (
equippedTrialPotion ("A
TeamList
teams (2.pb.Team
currentBattleTeamIdx ("¡
TeamInfo#
presetTeams (2.pb.PresetTeam
mainTeamIdx (&
teams (2.pb.TeamInfo.TeamsEntryB
characterRepository (2%.pb.TeamInfo.CharacterRepositoryEntry:

TeamsEntry
key (
value (2.pb.TeamList:8S
CharacterRepositoryEntry
key (&
value (2.pb.CharacterRepository:8":
TeamCharacterUsage
characterId (
isTrial ("Ö
	TeamUsage.
characterUsage (2.pb.TeamCharacterUsage
battleCharacterIdx (
equipPotionId (
isTrialPotion ("i
TempTeam!

characters (2.pb.Character
battleCharacterIdx (
potion (2.pb.PotionItem"`
AbyssTeamInfo
characterIds (
potion (2.pb.PotionItem
potionCurUseCount ("Z
HandbookInfo

id (
maxSize (
maxTs (
minSize (
minTs ("Ù	
Player"
profile (2.pb.PlayerProfile 
	inventory (2.pb.Inventory"
missions (2.pb.MissionState#
	handbooks (2.pb.HandbookInfo
npcs (2.pb.NPCInfo
robots (2
.pb.Assist"
maps (2.pb.Player.MapsEntry
openSystems	 (
takeRewardLevels
 (,
	raidInfos (2.pb.Player.RaidInfosEntry,
	shopInfos (2.pb.Player.ShopInfosEntry
	abyssInfo (2	.pb.Abyss
	mailInfos (2.pb.Mail
lockMailTemplateIDs (&
achievements (2.pb.Achievements
cook (2.pb.Cook
raidId (*
gotItems (2.pb.Player.GotItemsEntry6
interfaceGuide (2.pb.Player.InterfaceGuideEntry 
	dailyData (2.pb.DailyData,
answerQuestions (2.pb.AnswerQuestions
friends (2.pb.Friends 
mapView (2.pb.MapViewInfo
raidMultiple (,
assistantSystem (2.pb.AssistantSystem>
systemGuideChapter (2".pb.Player.SystemGuideChapterEntry4
	MapsEntry
key (
value (2.pb.Map:8:
RaidInfosEntry
key (
value (2.pb.Raid:8:
ShopInfosEntry
key (
value (2.pb.Shop:8/
GotItemsEntry
key (
value (:85
InterfaceGuideEntry
key (
value (:89
SystemGuideChapterEntry
key (
value (:8J"a
NPCInfo
npcId (
overrideStateId (
overrideMissionId (
baseStateId ("Ç

AssistSkin

id (*
colors (2.pb.AssistSkin.ColorsEntry
color (-
ColorsEntry
key (
value (:8"Ü
Assist

id ($
skins (2.pb.Assist.SkinsEntry
skin (<

SkinsEntry
key (
value (2.pb.AssistSkin:8"ƒ
Map
wid (-
customFlags (2.pb.Map.CustomFlagsEntry=
serviceSaveStateIds (2 .pb.Map.ServiceSaveStateIdsEntry7
serviceBehaveIds (2.pb.Map.ServiceBehaveIdsEntry7
serviceCleanedTs (2.pb.Map.ServiceCleanedTsEntry)
	dropItems (2.pb.Map.DropItemsEntry7
lightedMapBlocks (2.pb.Map.LightedMapBlocksEntryE
CustomFlagsEntry
key ( 
value (2.pb.MapCustomFlag:8:
ServiceSaveStateIdsEntry
key (
value (:87
ServiceBehaveIdsEntry
key (
value (:87
ServiceCleanedTsEntry
key (
value (:8>
DropItemsEntry
key (
value (2.pb.DropItem:87
LightedMapBlocksEntry
key (
value (:8"Á

MapDbModel)
	areaFlags (2.pb.AreaMapCustomFlags)
mapTracePoint (2.pb.MapTrancePoint.
areaDivinePupils (2.pb.AreaDivinePupilsN
areaExploreClaimedReward (2,.pb.MapDbModel.AreaExploreClaimedRewardEntryT
subAreaExploreClaimedReward (2/.pb.MapDbModel.SubAreaExploreClaimedRewardEntry8
unlockedAreas (2!.pb.MapDbModel.UnlockedAreasEntry\
AreaExploreClaimedRewardEntry
key (*
value (2.pb.MapExploreClaimedReward:8_
 SubAreaExploreClaimedRewardEntry
key (*
value (2.pb.MapExploreClaimedReward:84
UnlockedAreasEntry
key (
value (:8"C
DivinePupil
curLv (
curExp (
claimedReward ("Å
AreaDivinePupils.
areas (2.pb.AreaDivinePupils.AreasEntry=

AreasEntry
key (
value (2.pb.DivinePupil:8"
MapCustomFlags,
flags (2.pb.MapCustomFlags.FlagsEntry?

FlagsEntry
key ( 
value (2.pb.MapCustomFlag:8"à
AreaMapCustomFlags0
areas (2!.pb.AreaMapCustomFlags.AreasEntry@

AreasEntry
key (!
value (2.pb.MapCustomFlags:8"T
MapCustomFlag

id (
tid (
pos (2.pb.PBVector3
areaID ("[
MapTrancePoint
areaID (
pointID ((
	pointType (2.pb.MapTracePointEnum"K
MapExploreGroupProgress
groupId (
progress (
total ("∆
MapSubAreaExplore

id (=
groupExplore (2'.pb.MapSubAreaExplore.GroupExploreEntry
totalExplore (?
claimedReward (2(.pb.MapSubAreaExplore.ClaimedRewardEntry=
chunkExplore (2'.pb.MapSubAreaExplore.ChunkExploreEntryP
GroupExploreEntry
key (*
value (2.pb.MapExploreGroupProgress:84
ClaimedRewardEntry
key (
value (:8H
ChunkExploreEntry
key ("
value (2.pb.MapChunkExplore:8"¬
MapChunkExplore

id (;
groupExplore (2%.pb.MapChunkExplore.GroupExploreEntry
totalExplore (P
GroupExploreEntry
key (*
value (2.pb.MapExploreGroupProgress:8"¥
MapAreaExplore

id (>
subAreaExplore (2&.pb.MapAreaExplore.SubAreaExploreEntry
totalExplore (<
claimedReward (2%.pb.MapAreaExplore.ClaimedRewardEntryL
SubAreaExploreEntry
key ($
value (2.pb.MapSubAreaExplore:84
ClaimedRewardEntry
key (
value (:8"ñ
MapExploreClaimedRewardE
claimedReward (2..pb.MapExploreClaimedReward.ClaimedRewardEntry4
ClaimedRewardEntry
key (
value (:8"U
ServiceSaveState
uid (
stateId (
behaveId (
	cleanedTs (".
ServiceBehave
uid (
behaveId ("6
DropItem
uid (
itemId (
count ("¶
DropPackage

id ()
items (2.pb.DropPackage.ItemsEntry
source (
collectionID (:

ItemsEntry
key (
value (2.pb.DropItem:8"π
Mail

id (

templateID (
priority (
createTs (
expireTs (
type (
sender (	
title (	
content	 (	
state
 (
rewards (2.pb.Item
tag (
questionnaireUrl (	
questionnaireTitle (	"
linkType (2.pb.MailLinkType
link ("B
	Commodity
idx (
	boughtNum (
lastRefreshTs ("å
SubShop
idx (1
Commodities (2.pb.SubShop.CommoditiesEntryA
CommoditiesEntry
key (
value (2.pb.Commodity:8"z
Shop

id ((
subShops (2.pb.Shop.SubShopsEntry<
SubShopsEntry
key (
value (2.pb.SubShop:8"ô
CharacterSyncInfo)
cs (2.pb.CharacterSyncInfo.CsEntry
battleCharacterId (>
CsEntry
key ("
value (2.pb.CharacterStatus:8"¥

AchievementSyncInfoG
fightTypeCntInfo (2-.pb.AchievementSyncInfo.FightTypeCntInfoEntry?
bossKillTime (2).pb.AchievementSyncInfo.BossKillTimeEntryA
useSkillCount (2*.pb.AchievementSyncInfo.UseSkillCountEntryO
characterDieOnOneHit (21.pb.AchievementSyncInfo.CharacterDieOnOneHitEntryS
damageAccumulateByType (23.pb.AchievementSyncInfo.DamageAccumulateByTypeEntry
interactedNPCs (Q
damageTypeDieOnOneHit (22.pb.AchievementSyncInfo.DamageTypeDieOnOneHitEntryc
characterKillMonsterInAirCount (2;.pb.AchievementSyncInfo.CharacterKillMonsterInAirCountEntry[
playerDeadByMonsterPointID	 (27.pb.AchievementSyncInfo.PlayerDeadByMonsterPointIDEntryU
damageOnceMaximumByType
 (24.pb.AchievementSyncInfo.DamageOnceMaximumByTypeEntry7
FightTypeCntInfoEntry
key (
value (:83
BossKillTimeEntry
key (
value (:84
UseSkillCountEntry
key (
value (:8;
CharacterDieOnOneHitEntry
key (
value (:8=
DamageAccumulateByTypeEntry
key (
value (:8<
DamageTypeDieOnOneHitEntry
key (
value (:8E
#CharacterKillMonsterInAirCountEntry
key (
value (:8A
PlayerDeadByMonsterPointIDEntry
key (
value (:8>
DamageOnceMaximumByTypeEntry
key (
value (:8"
CommonStart"
	CommonEnd"
LoginMsgStart"
LoginMsgEnd"
GateMsgStart"

GateMsgEnd"
GameMsgStart"

GameMsgEnd"%
GameBatchPacket

packetData ("¯
TookLevelRewards0
levels (2 .pb.TookLevelRewards.LevelsEntryH
systemGuideChapter (2,.pb.TookLevelRewards.SystemGuideChapterEntry-
LevelsEntry
key (
value (:89
SystemGuideChapterEntry
key (
value (:8"›
OpenedSystems/
systems (2.pb.OpenedSystems.SystemsEntry7
readSystems (2".pb.OpenedSystems.ReadSystemsEntry.
SystemsEntry
key (
value (:82
ReadSystemsEntry
key (
value (:8"g
Items%
values (2.pb.Items.ValuesEntry7
ValuesEntry
key (
value (2.pb.Item:8"´
BagChestRewardSelectRecordR
rewardSelectCounts (26.pb.BagChestRewardSelectRecord.RewardSelectCountsEntry9
RewardSelectCountsEntry
key (
value (:8"µ
BagChestRewardSelectDataD
chestRecords (2..pb.BagChestRewardSelectData.ChestRecordsEntryS
ChestRecordsEntry
key (-
value (2.pb.BagChestRewardSelectRecord:8"8
TimeLimitItems
items (2.pb.Item
maxID ("g

Attributes*
values (2.pb.Attributes.ValuesEntry-
ValuesEntry
key (
value (:8"v

Characters*
values (2.pb.Characters.ValuesEntry<
ValuesEntry
key (
value (2.pb.Character:8"m
Weapons'
values (2.pb.Weapons.ValuesEntry9
ValuesEntry
key (
value (2
.pb.Weapon:8"g
Chips%
values (2.pb.Chips.ValuesEntry7
ValuesEntry
key (
value (2.pb.Chip:8"j
Equips&
values (2.pb.Equips.ValuesEntry8
ValuesEntry
key (
value (2	.pb.Equip:8"d
Gems$
values (2.pb.Gems.ValuesEntry6
ValuesEntry
key (
value (2.pb.Gem:8"ó
MonsterHandbookA
typeKilledCount (2(.pb.MonsterHandbook.TypeKilledCountEntryG
unlockedMonsterIds (2+.pb.MonsterHandbook.UnlockedMonsterIdsEntryI
unlockedWildbossIds (2,.pb.MonsterHandbook.UnlockedWildbossIdsEntry6
TypeKilledCountEntry
key (
value (:89
UnlockedMonsterIdsEntry
key (
value (:8:
UnlockedWildbossIdsEntry
key (
value (:8"´
PlayerGrowthGuideM
claimedMissionReward (2/.pb.PlayerGrowthGuide.ClaimedMissionRewardEntryM
claimedChapterReward (2/.pb.PlayerGrowthGuide.ClaimedChapterRewardEntry;
ClaimedMissionRewardEntry
key (
value (:8;
ClaimedChapterRewardEntry
key (
value (:8"Ã
Handbook&
infos (2.pb.Handbook.InfosEntry,
monsterHandbook (2.pb.MonsterHandbook*
growthGuide (2.pb.PlayerGrowthGuide>

InfosEntry
key (
value (2.pb.HandbookInfo:8"?
ArchiveItem

id (
firstTimestamp (
read ("”
Archive%
items (2.pb.Archive.ItemsEntry/

characters (2.pb.Archive.CharactersEntry+
monsters (2.pb.Archive.MonstersEntry=

ItemsEntry
key (
value (2.pb.ArchiveItem:8B
CharactersEntry
key (
value (2.pb.ArchiveItem:8@
MonstersEntry
key (
value (2.pb.ArchiveItem:8"d

SubMission

id (
startTs (
completedTs (
progress (

bluePrints ("d
Shops#
value (2.pb.Shops.ValueEntry6

ValueEntry
key (
value (2.pb.Shop:8"ù
AbyssBattleReportM
characterBattleCount (2/.pb.AbyssBattleReport.CharacterBattleCountEntrya
characterUsePotionMaximumCount (29.pb.AbyssBattleReport.CharacterUsePotionMaximumCountEntryQ
characterMaximumDamage (21.pb.AbyssBattleReport.CharacterMaximumDamageEntry]
characterMaximumExSkillCount (27.pb.AbyssBattleReport.CharacterMaximumExSkillCountEntryY
characterMaximumDodgeCount (25.pb.AbyssBattleReport.CharacterMaximumDodgeCountEntry;
CharacterBattleCountEntry
key (
value (:8E
#CharacterUsePotionMaximumCountEntry
key (
value (:8=
CharacterMaximumDamageEntry
key (
value (:8C
!CharacterMaximumExSkillCountEntry
key (
value (:8A
CharacterMaximumDodgeCountEntry
key (
value (:8"…

AbyssStage
index (
isUnlock ( 
teams (2.pb.AbyssTeamInfo
completedTargetsNum (
completedNum (
curChallengeSubStage (
latestUseSeconds (
entryWorldId (
enterSubStageTs	 (
subStageRestartCount (
stageRestartCount (
subStageTransNo (	F
evaluationClaimState (2(.pb.AbyssStage.EvaluationClaimStateEntryD
subStageMinimumSecs (2'.pb.AbyssStage.SubStageMinimumSecsEntry!
state (2.pb.StageStateEnum4
subStageBattleReports (2.pb.AbyssBattleReport0
stageBattleReport (2.pb.AbyssBattleReport
stageMinimumSecs ((
target (2.pb.StageChallengeTarget0
aggregateSettleInfo (2.pb.StageSettleInfo;
EvaluationClaimStateEntry
key (
value (:8:
SubStageMinimumSecsEntry
key (
value (:8J
"˚
Abyss
stages (2.pb.AbyssStage1
takenRewards (2.pb.Abyss.TakenRewardsEntry

id (
curChallengeStage (
lastChallengeStage (
recycle (
jumpStartFloor (3
TakenRewardsEntry
key (
value (:8"–
Abysses%
value (2.pb.Abysses.ValueEntry

curAbyssId (
curChallengeAbyssId (
oneTimeAbyssId (
lastChallengeAbyssID (7

ValueEntry
key (
value (2	.pb.Abyss:8"ô
Temple

id (
	completed (
gotStars (
lastTeam (2.pb.TeamUsage
collectTreasureNum (!
state (2.pb.StageStateEnum
entryGameWID (
obtainRobots ("
thisTimeCollectTreasureNum	 (4
selectedBuffs
 (2.pb.Temple.SelectedBuffsEntry(
target (2.pb.StageChallengeTarget
stageMinimumSecs (4
SelectedBuffsEntry
key (
value (:8"©
TempleStage
templeId (
teamCharacterIds (
entryWorldId (#
state (2.pb.TempleStageState
obtainRobots (
openTreasureNum (J"ˇ

TempleArea
areaId (,
temples (2.pb.TempleArea.TemplesEntry>
takenStarRewards (2$.pb.TempleArea.TakenStarRewardsEntry:
TemplesEntry
key (
value (2
.pb.Temple:87
TakenStarRewardsEntry
key (
value (:8"Ö

TempleInfo.
areaInfo (2.pb.TempleInfo.AreaInfoEntry,
temples (2.pb.TempleInfo.TemplesEntry
curChallengeId (?
AreaInfoEntry
key (
value (2.pb.TempleArea:8:
TemplesEntry
key (
value (2
.pb.Temple:8J"(
CookItemInfo
unlockedSkillIdx ("ø
Cook
potLevel (2
unlockedMenus (2.pb.Cook.UnlockedMenusEntry!
customMenus (2.pb.CookMenu2
cookItemInfos (2.pb.Cook.CookItemInfosEntry
curRecommendTemplate (4
UnlockedMenusEntry
key (
value (:8F
CookItemInfosEntry
key (
value (2.pb.CookItemInfo:8"W
CookMenu
	mainItems (2.pb.Item

minorItems (2.pb.Item
menuName (	"x
TmplMailIDs5
tmplMailIDs (2 .pb.TmplMailIDs.TmplMailIDsEntry2
TmplMailIDsEntry
key (
value (:8"˜
Mails/
lockMailIDs (2.pb.Mails.LockMailIDsEntry=
generatedMailTmpls (2!.pb.Mails.GeneratedMailTmplsEntry2
LockMailIDsEntry
key (
value (:8J
GeneratedMailTmplsEntry
key (
value (2.pb.TmplMailIDs:8"¥
HandbookRewardStatusH
dailyPointReward (2..pb.HandbookRewardStatus.DailyPointRewardEntryX
dailyConditionTaskReward (26.pb.HandbookRewardStatus.DailyConditionTaskRewardEntry7
DailyPointRewardEntry
key (
value (:8?
DailyConditionTaskRewardEntry
key (
value (:8"ﬂ
	DailyData
lastUpdateTS (
gachaNum (
loginDayCount (
lastWeeklyUpdateTS (#
dailySentCharacterGiftCount (6
handbookRewardStatus	 (2.pb.HandbookRewardStatus
wildBossTakeRewardCount
 (!
wildBossRewardBoughtCount ( 
wildBossRewardExtraCount (A
collectionGetItems (2%.pb.DailyData.CollectionGetItemsEntry$
wildBossRewardCycleTakeCount (9
CollectionGetItemsEntry
key (
value (:8JJJ"Q
GachaHistoryItem
item (2.pb.Item
drawTimestamp (
poolId ("8
GachaHistoryItems#
items (2.pb.GachaHistoryItem"€
GachaLimitedGuaranteedPool

totalCount (*
"countForNotExchangeFinalGuaranteed (
countForNotTarget (
countForNotHighQuality ( 
exchangedFinalGuaranteed ( 
countForNotHighQualityUp ("ô
GachaLimitedUpPool

totalCount (!
countForNotHighestQuality (
countForNotUpTarget (
countForNotHighQuality (*
"countForNotExchangeFinalGuaranteed ( 
exchangedFinalGuaranteed (
drawCountForNotUpTarget ( 
countForNotHighQualityUp ("ø
GachaResidentPool

totalCount (&
countForTenConsecutiveDiscount (!
countForNotHighestQuality (
countForNotHighQuality (*
"countForNotExchangeFinalGuaranteed (
gotNewbieGuaranteed ( 
exchangedFinalGuaranteed ( 
countForNotHighQualityUp (
latestDrawItemTypeList	 ("ù
GachaNewbiePool

totalCount (&
countForTenConsecutiveDiscount (!
countForNotHighestQuality (
countForNotHighQuality (*
"countForNotExchangeFinalGuaranteed (
gotNewbieGuaranteed ( 
exchangedFinalGuaranteed ( 
countForNotHighQualityUp ("Å
GachaTestRoundTwoPool

totalCount (&
countForTenConsecutiveDiscount (!
countForNotHighestQuality (
countForNotHighQuality (*
"countForNotExchangeFinalGuaranteed (
gotNewbieGuaranteed ( 
exchangedFinalGuaranteed ("ç
GachaPoolShareData=
limitedGuaranteedPool (2.pb.GachaLimitedGuaranteedPool-
limitedUpPool (2.pb.GachaLimitedUpPool+
residentPool (2.pb.GachaResidentPool3
testRoundTwoPool (2.pb.GachaTestRoundTwoPool'

newbiePool (2.pb.GachaNewbiePool"õ
GachaPoolUniqueData

totalCount (;

takenBonus (2'.pb.GachaPoolUniqueData.TakenBonusEntry
poolId (
hasTakenMilestoneReward (
tiggeredFirstGuaranteed (
targetGachaItemId (
targetPoint (1
TakenBonusEntry
key (
value (:8"u
GachaPoolEffectiveInfo

id (
beginTimestamp (
endTimestamp (!
state (2.pb.GachaPoolState"Ÿ
	GachaDataC
cardPoolDatasByType (2&.pb.GachaData.CardPoolDatasByTypeEntry?
cardPoolDatasById (2$.pb.GachaData.CardPoolDatasByIdEntry-
poolShareData (2.pb.GachaPoolShareData9
poolUniqueData (2!.pb.GachaData.PoolUniqueDataEntry3
poolHistory (2.pb.GachaData.PoolHistoryEntryM
CardPoolUniqueData"
hasDrewNotChoseFiveStarNum (
choseItemID (É
CardPoolShareData
drawNum (
hasDrewNotFiveStarNum (
hasDrewNotFourStarNum (
hasDrewNotUpFiveStarNum ([
CardPoolDatasByTypeEntry
key (.
value (2.pb.GachaData.CardPoolShareData:8Z
CardPoolDatasByIdEntry
key (/
value (2 .pb.GachaData.CardPoolUniqueData:8N
PoolUniqueDataEntry
key (&
value (2.pb.GachaPoolUniqueData:8I
PoolHistoryEntry
key ($
value (2.pb.GachaHistoryItems:8"o
ItemGotLogs/
gotItems (2.pb.ItemGotLogs.GotItemsEntry/
GotItemsEntry
key (
value (:8"ï
ItemMonitorDailyData
periodStartTs (<

itemCounts (2(.pb.ItemMonitorDailyData.ItemCountsEntry@
alertedItems (2*.pb.ItemMonitorDailyData.AlertedItemsEntry1
ItemCountsEntry
key (
value (:83
AlertedItemsEntry
key (
value (:8"8
	GuideItem
firstTriggerTs (
firstReadTs (";

GuideState

id (!
state (2.pb.GuideStateEnum"Â
	GuideLogs9
interfaceGuide (2!.pb.GuideLogs.InterfaceGuideEntry1

guideItems (2.pb.GuideLogs.GuideItemsEntry/
	allGuides (2.pb.GuideLogs.AllGuidesEntry5
InterfaceGuideEntry
key (
value (:8@
GuideItemsEntry
key (
value (2.pb.GuideItem:8@
AllGuidesEntry
key (
value (2.pb.GuideState:8"7
DisplayOrderInfo#
gotItems (2.pb.UniversalItem"ã
BillData4
billBuyCount (2.pb.BillData.BillBuyCountEntry
isRebate (6
displayOrders (2.pb.BillData.DisplayOrdersEntry3
BillBuyCountEntry
key (
value (:8J
DisplayOrdersEntry
key (	#
value (2.pb.DisplayOrderInfo:8"Ä
AnswerQuestions9
tookRewards (2$.pb.AnswerQuestions.TookRewardsEntry2
TookRewardsEntry
key (
value (:8"|
FriendProfile
uid (
nickname (	

worldLevel (
playerLevel (
	signature (	
avatarId ("t
Friends'
values (2.pb.Friends.ValuesEntry@
ValuesEntry
key ( 
value (2.pb.FriendProfile:8"{
ClientComponentState4
states (2$.pb.ClientComponentState.StatesEntry-
StatesEntry
key (
value (:8"≠
ClientModuleComponentStateB

components (2..pb.ClientModuleComponentState.ComponentsEntryK
ComponentsEntry
key ('
value (2.pb.ClientComponentState:8"F
ReviewPromptChannelData
lastNotifyTs (
isNeedDisplay ("Ã
ReviewPromptData
lastNotifyTs (
isNeedDisplay (:
channelData (2%.pb.ReviewPromptData.ChannelDataEntryO
ChannelDataEntry
key (*
value (2.pb.ReviewPromptChannelData:8"Ü
ReminderData>
expirationMails (2%.pb.ReminderData.ExpirationMailsEntry6
ExpirationMailsEntry
key (	
value (:8"™

Bloodstain"
state (2.pb.BloodstainState

id (	
ownerAccountId (
chunkID (
position (2.pb.PBVector3
createTs (
expireTs ("g
BloodstainChunkInfo&
selfBloodstain (2.pb.Bloodstain(
otherBloodstains (2.pb.Bloodstain"∫
BloodstainInfoB
chunkBloodstains (2(.pb.BloodstainInfo.ChunkBloodstainsEntry&
selfBloodstain (2.pb.Bloodstain(
otherBloodstains (2.pb.Bloodstain
otherBloodstainDisabled (
interactedBloodstainIds (	P
ChunkBloodstainsEntry
key (&
value (2.pb.BloodstainChunkInfo:8"É
PlayerComposeData
configVersion (	6
operationTs (2!.pb.PlayerComposeData.OperationTs
shops (2	.pb.Shops
raidInfo (2.pb.Raid&
achievements (2.pb.Achievements
cook (2.pb.Cook
mails (2	.pb.Mails 
	dailyData (2.pb.DailyData 
	gachaData	 (2.pb.GachaData$
itemGotLogs
 (2.pb.ItemGotLogs 
	guideLogs (2.pb.GuideLogs
billData (2.pb.BillData,
answerQuestions (2.pb.AnswerQuestions
friends (2.pb.Friends$
littleItems (2.pb.LittleItems 
	redPoints (2.pb.RedPoints?
questionnaire (2(.pb.PlayerComposeData.QuestionnaireEntry 
	rogueInfo (2.pb.RogueInfo,
assistantSystem (2.pb.AssistantSystem"

templeInfo (2.pb.TempleInfo
contact (2.pb.Contact&
activityInfo (2.pb.ActivityInfo
raids (2	.pb.Raids
abysses (2.pb.Abysses&
treasureInfo (2.pb.TreasureInfo&
itemDistInfo (2.pb.ItemDistInfo
taskInfo (2.pb.TaskInfo
teamInfo (2.pb.TeamInfo8
tempArchiveManagement (2.pb.TempArchiveManagementB
clientModuleComponentState (2.pb.ClientModuleComponentState
patchVersion (
archive  (2.pb.Archive*
reviewPrompt! (2.pb.ReviewPromptData&
reminderData" (2.pb.ReminderData*
bloodstainInfo# (2.pb.BloodstainInfo6
itemMonitorDailyData$ (2.pb.ItemMonitorDailyData>
bagChestRewardSelectData% (2.pb.BagChestRewardSelectData.
messageBoardInfo& (2.pb.MessageBoardInfo
preHandlerVersion' (a
OperationTs
acceptedDailyMissionTs (
adjustWorldLevelTs (
changeGenderTs (4
QuestionnaireEntry
key (
value (:8"í
TempArchiveBackupData
position (2.pb.PBVector3;
	potionSet (2(.pb.TempArchiveBackupData.PotionSetEntryM
characterStatusSet (21.pb.TempArchiveBackupData.CharacterStatusSetEntry)
sceneResources (2.pb.SceneResource
chunkID (@
PotionSetEntry
key (
value (2.pb.PotionItem:8N
CharacterStatusSetEntry
key ("
value (2.pb.CharacterStatus:8"W
TempArchiveManagement
enabled (-

backupData (2.pb.TempArchiveBackupData"z
SubMissionAppliedItem3
items (2$.pb.SubMissionAppliedItem.ItemsEntry,

ItemsEntry
key (
value (:8"]
TriggerCondition

id (
type (
done (
progress (
startTs ("K
TriggerAction

id (
type (

beforeData (
done ("ì
TriggerConditionActionPair'
	condition (2.pb.TriggerCondition"
actions (2.pb.TriggerAction(

conditions (2.pb.TriggerCondition"•
MissionFlow
curConditionGroupIdx (<
conditionActionPairs (2.pb.TriggerConditionActionPair'
finalActions (2.pb.TriggerAction
	doneCount ("π
MissionR

id (
flows (2.pb.MissionFlow#
state (2.pb.MissionStateEnum
completedNum (#

extraFlows (2.pb.MissionFlow!
failFlow (2.pb.MissionFlow"‚
Mission

id (
state (%
curSubMission (2.pb.SubMission3
appliedItems (2.pb.Mission.AppliedItemsEntryC
completedSubMissions (2%.pb.Mission.CompletedSubMissionsEntryN
AppliedItemsEntry
key ((
value (2.pb.SubMissionAppliedItem:8K
CompletedSubMissionsEntry
key (
value (2.pb.SubMission:8"≠
Missions(
values (2.pb.Missions.ValuesEntry
lastGenDailyMissionTS (0

allMission (2.pb.Missions.AllMissionEntry
trackingMission (Å
TypeMissions5
values (2%.pb.Missions.TypeMissions.ValuesEntry:
ValuesEntry
key (
value (2.pb.Mission:8H
ValuesEntry
key ((
value (2.pb.Missions.TypeMissions:8?
AllMissionEntry
key (
value (2.pb.MissionR:8"m
Assists'
values (2.pb.Assists.ValuesEntry9
ValuesEntry
key (
value (2
.pb.Assist:8"~
SceneResourceWildBossExtraInfo
playerWorldLvOnDied (
wildBossMonsterPointID (
wildBossMonsterPointUID ("⁄
SceneResource

id (
state (
middleState (

behaviorID (
cleaned (
	cleanedTs	 (
stopRefresh
 (
	extraInfo (
lastRefreshTs (
rewarded (JJJ"´
MapViewChunkInfo
chunkID (.
grids (2.pb.MapViewChunkInfo.GridsEntry

isComplete (B

GridsEntry
key (	#
value (2.pb.PBVector2IntList:8"´
MapViewAreaInfo
areaID (/
chunks (2.pb.MapViewAreaInfo.ChunksEntry

isComplete (C
ChunksEntry
key (#
value (2.pb.MapViewChunkInfo:8"É
MapViewFullInfo-
areas (2.pb.MapViewFullInfo.AreasEntryA

AreasEntry
key ("
value (2.pb.MapViewAreaInfo:8"A
MapViewRecordPositionParam#
	positions (2.pb.PBVector2Int"°
MapViewRecordChunkParam7
chunks (2'.pb.MapViewRecordChunkParam.ChunksEntryM
ChunksEntry
key (-
value (2.pb.MapViewRecordPositionParam:8"ë
MapViewRecordParam0
areas (2!.pb.MapViewRecordParam.AreasEntryI

AreasEntry
key (*
value (2.pb.MapViewRecordChunkParam:8"¶
MapViewGridInfo3
gridInfo (2!.pb.MapViewGridInfo.GridInfoEntry
layerIsComplete (E
GridInfoEntry
key (	#
value (2.pb.PBVector2IntList:8"á
MapViewInfo1
	layerInfo (2.pb.MapViewInfo.LayerInfoEntryE
LayerInfoEntry
key (	"
value (2.pb.MapViewGridInfo:8"C
MapViewLogInfo
layer (	"
position (2.pb.PBVector2Int"Á
Scene

id (/
customFlags (2.pb.Scene.CustomFlagsEntry+
	resources (2.pb.Scene.ResourcesEntry9
lightedMapBlocks (2.pb.Scene.LightedMapBlocksEntry 
mapView (2.pb.MapViewInfo(
mapViewFull (2.pb.MapViewFullInfo1
dropPackages (2.pb.Scene.DropPackagesEntry
dropPackageIDSeq (
dropItemIDSeq	 (E
CustomFlagsEntry
key ( 
value (2.pb.MapCustomFlag:8C
ResourcesEntry
key ( 
value (2.pb.SceneResource:87
LightedMapBlocksEntry
key (
value (:8D
DropPackagesEntry
key (
value (2.pb.DropPackage:8"F
RaidTeamCharacter 
	character (2.pb.Character
isTrial ("»
StageSettleCharacterInfo
characterID (
characterLv (
damage (
	hpPercent (
duration (
potionUseCount (
exSkillUseCount (

dodgeCount (P
triggeredNodeCount	 (24.pb.StageSettleCharacterInfo.TriggeredNodeCountEntryj
breakDiffTypeMonsterShieldCount
 (2A.pb.StageSettleCharacterInfo.BreakDiffTypeMonsterShieldCountEntryx
&killDiffTypeMonsterOnShieldBrokenCount (2H.pb.StageSettleCharacterInfo.KillDiffTypeMonsterOnShieldBrokenCountEntry9
TriggeredNodeCountEntry
key (
value (:8F
$BreakDiffTypeMonsterShieldCountEntry
key (
value (:8M
+KillDiffTypeMonsterOnShieldBrokenCountEntry
key (
value (:8"¶
StageSettleInfo3
characterInfo (2.pb.StageSettleCharacterInfo
duration (
dieCount (
	trapCount (

pointCount (
assistSkillCount (m
%killDiffTypeMonsterByAssistSkillCount (2>.pb.StageSettleInfo.KillDiffTypeMonsterByAssistSkillCountEntry
triggeredTrapCount ( 
completedChallengeTarget	 (L
*KillDiffTypeMonsterByAssistSkillCountEntry
key (
value (:8"†
StageChallengeTarget@
targetReward (2*.pb.StageChallengeTarget.TargetRewardEntry
	isPerfect (3
TargetRewardEntry
key (
value (:8"
BossRaid
raidId ("è
Raid

id (
cleanNum (
rate (
entryWorldId (
enterTs (
instId	 (
takeRewardCount
 (
playerDeathCount (
maximumScore (
boosRaid (2.pb.BossRaid
firstRewardDone (
fastestClearTime (!
state (2.pb.StageStateEnum(
target (2.pb.StageChallengeTarget
	enterByGM (JJJ	JJJJ"l
	TypeRaids'
raids (2.pb.TypeRaids.RaidsEntry6

RaidsEntry
key (
value (2.pb.Raid:8"r

MainScenes*
values (2.pb.MainScenes.ValuesEntry8
ValuesEntry
key (
value (2	.pb.Scene:8"i
RaidCycleUpdateTime
lastDailyUpdateTS (
lastWeeklyUpdateTS (
lastMonthlyUpdateTS ("∫
Raids%
values (2.pb.Raids.ValuesEntry)
updateTS (2.pb.RaidCycleUpdateTime
curChallengeRaidId (7
ValuesEntry
key (
value (2.pb.Raid:8JJ"8
Scenes"

mainScenes (2.pb.MainScenesJJ"Ö
ItemQualityCount<
qualityCount (2&.pb.ItemQualityCount.QualityCountEntry3
QualityCountEntry
key (
value (:8"Î
AchievementProgressDataS
achievementsProgress (25.pb.AchievementProgressData.AchievementsProgressEntrya
tookAchievementGroupRewards (2<.pb.AchievementProgressData.TookAchievementGroupRewardsEntryT
AchievementsProgressEntry
key (&
value (2.pb.AchievementProgress:8B
 TookAchievementGroupRewardsEntry
key (
value (:8"b
AchievementProgress

completeTS (
hasTakenReward (
tag (2.pb.AchievementTag"¢
ChapterRaidPassCountN
difficultyPassCount (21.pb.ChapterRaidPassCount.DifficultyPassCountEntry:
DifficultyPassCountEntry
key (
value (:8"ú
SubareaMajorBeaconCountI
weberCabinCount (20.pb.SubareaMajorBeaconCount.WeberCabinCountEntry6
WeberCabinCountEntry
key (
value (:8"å
InteractByItemType<
unlockCount (2'.pb.InteractByItemType.UnlockCountEntry2
UnlockCountEntry
key (
value (:8J"õ
CharacterKilledMonsterCountG
monsterCount (21.pb.CharacterKilledMonsterCount.MonsterCountEntry3
MonsterCountEntry
key (
value (:8"¨
"GachaCharacterQualityCompleteCountP
completeCount (29.pb.GachaCharacterQualityCompleteCount.CompleteCountEntry4
CompleteCountEntry
key (
value (:8"ï
AreaSubAreaCompleteCountD
subAreaCount (2..pb.AreaSubAreaCompleteCount.SubAreaCountEntry3
SubAreaCountEntry
key (
value (:8"≈4
AchievementInfo
maximumWorldLevel (E
completedMissions (2*.pb.AchievementInfo.CompletedMissionsEntry3
gotItems (2!.pb.AchievementInfo.GotItemsEntryI
gotItemsWithQuality (2,.pb.AchievementInfo.GotItemsWithQualityEntry;
levelWeapons (2%.pb.AchievementInfo.LevelWeaponsEntry?
fightTypeCount (2'.pb.AchievementInfo.FightTypeCountEntryM
conversationKeyPoints (2..pb.AchievementInfo.ConversationKeyPointsEntry7

countDatas	 (2#.pb.AchievementInfo.CountDatasEntryK
completedAbyssStages
 (2-.pb.AchievementInfo.CompletedAbyssStagesEntryO
completedRaidTypeCount (2/.pb.AchievementInfo.CompletedRaidTypeCountEntryO
conversationOptionInfo (2/.pb.AchievementInfo.ConversationOptionInfoEntry7

gotWeapons (2#.pb.AchievementInfo.GotWeaponsEntryI
openedTreasureChest (2,.pb.AchievementInfo.OpenedTreasureChestEntry;
bossKillTime (2%.pb.AchievementInfo.BossKillTimeEntryC
activityLoginDay (2).pb.AchievementInfo.ActivityLoginDayEntry3
useItems (2!.pb.AchievementInfo.UseItemsEntryE
tiggerInteraction (2*.pb.AchievementInfo.TiggerInteractionEntryE
passRaidByIdCount (2*.pb.AchievementInfo.PassRaidByIdCountEntryI
passRaidByMarkCount (2,.pb.AchievementInfo.PassRaidByMarkCountEntryQ
passRaidByEntranceCount (20.pb.AchievementInfo.PassRaidByEntranceCountEntryW
characterLevelUpSkillCount (23.pb.AchievementInfo.CharacterLevelUpSkillCountEntrye
!characterEliteMaximumHistoryLevel (2:.pb.AchievementInfo.CharacterEliteMaximumHistoryLevelEntryE
levelUpCharacters (2*.pb.AchievementInfo.LevelUpCharactersEntryK
chapterRaidPassCount (2-.pb.AchievementInfo.ChapterRaidPassCountEntryY
completedAbyssStagesByStars (24.pb.AchievementInfo.CompletedAbyssStagesByStarsEntry;
shopBuyCount (2%.pb.AchievementInfo.ShopBuyCountEntry=
useSkillCount (2&.pb.AchievementInfo.UseSkillCountEntryG
killMonsterIDCount (2+.pb.AchievementInfo.KillMonsterIDCountEntryO
openSubareaMajorBeacon (2/.pb.AchievementInfo.OpenSubareaMajorBeaconEntry?
openWeberCabin (2'.pb.AchievementInfo.OpenWeberCabinEntry9
areaVisited  (2$.pb.AchievementInfo.AreaVisitedEntryM
interactByAreaAndType! (2..pb.AchievementInfo.InteractByAreaAndTypeEntryY
characterKilledMonsterCount" (24.pb.AchievementInfo.CharacterKilledMonsterCountEntryQ
damageOnceMaximumByType# (20.pb.AchievementInfo.DamageOnceMaximumByTypeEntryE
damageTotalByType$ (2*.pb.AchievementInfo.DamageTotalByTypeEntrye
!gachaTenPullCharacterQualityCount% (2:.pb.AchievementInfo.GachaTenPullCharacterQualityCountEntryk
$gachaSinglePullCharacterQualityCount& (2=.pb.AchievementInfo.GachaSinglePullCharacterQualityCountEntry=
npcInteracted' (2&.pb.AchievementInfo.NpcInteractedEntryC
interactByItemID( (2).pb.AchievementInfo.InteractByItemIDEntry[
roguelikeDifficultyPassCount) (25.pb.AchievementInfo.RoguelikeDifficultyPassCountEntryA
openStoneTablet* (2(.pb.AchievementInfo.OpenStoneTabletEntry[
completeTreasureDecryptCount+ (25.pb.AchievementInfo.CompleteTreasureDecryptCountEntry_
completeLimitTimeTreasureCount, (27.pb.AchievementInfo.CompleteLimitTimeTreasureCountEntry_
characterKillMonsterInAirCount- (27.pb.AchievementInfo.CharacterKillMonsterInAirCountEntryM
killMonsterPointCount. (2..pb.AchievementInfo.KillMonsterPointCountEntryS
unlockXinxiangSkillCount/ (21.pb.AchievementInfo.UnlockXinxiangSkillCountEntryW
playerDeadByMonsterPointID0 (23.pb.AchievementInfo.PlayerDeadByMonsterPointIDEntryK
giftToCharacterCount1 (2-.pb.AchievementInfo.GiftToCharacterCountEntry8
CompletedMissionsEntry
key (
value (:8/
GotItemsEntry
key (
value (:8P
GotItemsWithQualityEntry
key (#
value (2.pb.ItemQualityCount:83
LevelWeaponsEntry
key (
value (:85
FightTypeCountEntry
key (
value (:8<
ConversationKeyPointsEntry
key (
value (:81
CountDatasEntry
key (
value (:8;
CompletedAbyssStagesEntry
key (
value (:8=
CompletedRaidTypeCountEntry
key (
value (:8=
ConversationOptionInfoEntry
key (
value (:81
GotWeaponsEntry
key (
value (:8:
OpenedTreasureChestEntry
key (
value (:83
BossKillTimeEntry
key (
value (:87
ActivityLoginDayEntry
key (
value (:8/
UseItemsEntry
key (
value (:88
TiggerInteractionEntry
key (
value (:88
PassRaidByIdCountEntry
key (
value (:8:
PassRaidByMarkCountEntry
key (
value (:8>
PassRaidByEntranceCountEntry
key (
value (:8A
CharacterLevelUpSkillCountEntry
key (
value (:8H
&CharacterEliteMaximumHistoryLevelEntry
key (
value (:88
LevelUpCharactersEntry
key (
value (:8U
ChapterRaidPassCountEntry
key ('
value (2.pb.ChapterRaidPassCount:8B
 CompletedAbyssStagesByStarsEntry
key (
value (:83
ShopBuyCountEntry
key (
value (:84
UseSkillCountEntry
key (
value (:89
KillMonsterIDCountEntry
key (
value (:8=
OpenSubareaMajorBeaconEntry
key (
value (:8R
OpenWeberCabinEntry
key (*
value (2.pb.SubareaMajorBeaconCount:82
AreaVisitedEntry
key (
value (:8T
InteractByAreaAndTypeEntry
key (%
value (2.pb.InteractByItemType:8c
 CharacterKilledMonsterCountEntry
key (.
value (2.pb.CharacterKilledMonsterCount:8>
DamageOnceMaximumByTypeEntry
key (
value (:88
DamageTotalByTypeEntry
key (
value (:8p
&GachaTenPullCharacterQualityCountEntry
key (5
value (2&.pb.GachaCharacterQualityCompleteCount:8K
)GachaSinglePullCharacterQualityCountEntry
key (
value (:84
NpcInteractedEntry
key (
value (:87
InteractByItemIDEntry
key (
value (:8C
!RoguelikeDifficultyPassCountEntry
key (
value (:86
OpenStoneTabletEntry
key (
value (:8a
!CompleteTreasureDecryptCountEntry
key (+
value (2.pb.AreaSubAreaCompleteCount:8c
#CompleteLimitTimeTreasureCountEntry
key (+
value (2.pb.AreaSubAreaCompleteCount:8E
#CharacterKillMonsterInAirCountEntry
key (
value (:8<
KillMonsterPointCountEntry
key (
value (:8?
UnlockXinxiangSkillCountEntry
key (
value (:8A
PlayerDeadByMonsterPointIDEntry
key (
value (:8;
GiftToCharacterCountEntry
key (
value (:8"d
Achievements1
progressData (2.pb.AchievementProgressData!
info (2.pb.AchievementInfo"y
RaidRateRedPoint4
rateInfo (2".pb.RaidRateRedPoint.RateInfoEntry/
RateInfoEntry
key (
value (:8"<
AreaExploreRedPoint

id (
typ (
show ("®
	RedPoints-
missions (2.pb.RedPoints.MissionsEntry'
items (2.pb.RedPoints.ItemsEntry?
customerComplaint (2$.pb.RedPoints.CustomerComplaintEntry/
	activitys (2.pb.RedPoints.ActivitysEntry)
equips (2.pb.RedPoints.EquipsEntry%
gems (2.pb.RedPoints.GemsEntry1

characters (2.pb.RedPoints.CharactersEntryA
activityChallenges (2%.pb.RedPoints.ActivityChallengesEntry+
systems	 (2.pb.RedPoints.SystemsEntry-
raidRate
 (2.pb.RedPoints.RaidRateEntry1

battlePass (2.pb.RedPoints.BattlePassEntryC
AreaExploreRedPoint (2&.pb.RedPoints.AreaExploreRedPointEntry+
avatars (2.pb.RedPoints.AvatarsEntry5
avatarFrames (2.pb.RedPoints.AvatarFramesEntry)
titles (2.pb.RedPoints.TitlesEntry/
MissionsEntry
key (
value (:8,

ItemsEntry
key (
value (:88
CustomerComplaintEntry
key (
value (:80
ActivitysEntry
key (
value (:8-
EquipsEntry
key (
value (:8+
	GemsEntry
key (
value (:81
CharactersEntry
key (
value (:89
ActivityChallengesEntry
key (
value (:8.
SystemsEntry
key (
value (:8E
RaidRateEntry
key (#
value (2.pb.RaidRateRedPoint:81
BattlePassEntry
key (
value (:8S
AreaExploreRedPointEntry
key (&
value (2.pb.AreaExploreRedPoint:8.
AvatarsEntry
key (
value (:83
AvatarFramesEntry
key (
value (:8-
TitlesEntry
key (
value (:8"ñ
NormalUserProfile
uid (
nickname (	
gender (
playerLevel (
playerWorldLevel (
	signature (	
avatarId ("4
RankInfo
score (
rank (
uid ("8
Rank
rankInfo (2.pb.RankInfo
totalNum ("%
RogueTalentTreeCode
coreId ("4
RogueTalentTreeNode
nodeId (
level ("ê
RogueTalentTree-
codes (2.pb.RogueTalentTree.CodesEntry-
nodes (2.pb.RogueTalentTree.NodesEntry
	usedPoint (E

CodesEntry
key (&
value (2.pb.RogueTalentTreeCode:8E

NodesEntry
key (&
value (2.pb.RogueTalentTreeNode:8"-
	RogueItem
itemId (
position ("≠
RogueRoomInfo
gameWorldId (#
roomType (2.pb.RogueRoomType(
nextRoomTypes (2.pb.RogueRoomType
rewards ('

roomStatus (2.pb.RogueRoomStatus"K
RogueRoomRecord#
roomType (2.pb.RogueRoomType
gameWorldId ("Û
RogueTempInfo
reward (
gainCoin (
costCoin ()
item (2.pb.RogueTempInfo.ItemEntry
teamList (2.pb.TeamList0
battleCharacter (2.pb.CharacterRepository5

groundItem (2!.pb.RogueTempInfo.GroundItemEntry
choiceRewardId (
autoChoiceId	 (
roomMonsterList
 (5
elementChangeInfo (2.pb.RogueElementChangeInfo:
	ItemEntry
key (
value (2.pb.RogueItem:8@
GroundItemEntry
key (
value (2.pb.RogueItem:8"b
RogueElementChangeInfo
	elementId (
elementType (
	eventType (
value ("≥
RogueGameInfo
seed (
modeId (
index (
coreId (#
roomInfo (2.pb.RogueRoomInfo
coin ()
item (2.pb.RogueGameInfo.ItemEntry/
leftUse	 (2.pb.RogueGameInfo.LeftUseEntry0
battleCharacter
 (2.pb.CharacterRepository
gainCoin (
costCoin (5

roomRecord (2!.pb.RogueGameInfo.RoomRecordEntry5

battleInfo (2!.pb.RogueGameInfo.BattleInfoEntry5

effectInfo (2!.pb.RogueGameInfo.EffectInfoEntry#
tempInfo (2.pb.RogueTempInfo
characterProbationId (:
	ItemEntry
key (
value (2.pb.RogueItem:8.
LeftUseEntry
key (
value (:8F
RoomRecordEntry
key ("
value (2.pb.RogueRoomRecord:81
BattleInfoEntry
key (
value (:81
EffectInfoEntry
key (
value (:8"
	RogueInfo
seasonId (%
	gameState (2.pb.StageStateEnum
clearedMode (
talentTreePoint ('

talentTree (2.pb.RogueTalentTree#
gameInfo (2.pb.RogueGameInfo
weeklyCoinGain (
lastUpdateTime ("P
OperationalActivityInfo
timeTpye (
	beginTime (
timeLong ("]
	TipNotice

id (
content (	
	beginTime (
endTime (
showNum ("4
AssistantNpc

id (
effectiveWorldId ("1
AssistantSystem
npcs (2.pb.AssistantNpc"E
ContactPlayerMessage
uid (
content (	
emojiId ("™
ContactCharacterSession

id (&
state (2.pb.ContactSessionState
generateTimeStamp (
messages (
updateTimeStamp (
messagesInt64 ("¡
Contact=
characterSessions (2".pb.Contact.CharacterSessionsEntry 
lastRandomDailyMessageTs (U
CharacterSessionsEntry
key (*
value (2.pb.ContactCharacterSession:8"à
OperationalActivityData

activityId (
activityType (
priority (
	startTime (
endTime (7
groups (2'.pb.OperationalActivityData.GroupsEntry
isHide (D
GroupsEntry
key ($
value (2.pb.ActivityGroupData:8"H
ActivityGroupData
groupId (
	startTime (
endTime ("c
ActivityBaseInfo
	startTime (
periodStartTime (
endTime (

endHandled ("˙
ActivityInfoN
ActivitLevelRewardInfos (2-.pb.ActivityInfo.ActivitLevelRewardInfosEntryR
ActivitDoubleDungeonInfos (2/.pb.ActivityInfo.ActivitDoubleDungeonInfosEntryD
ActivitSignInInfos (2(.pb.ActivityInfo.ActivitSignInInfosEntryB
ActivitAbyssInfos (2'.pb.ActivityInfo.ActivitAbyssInfosEntryN
ActivitCombinationInfos (2-.pb.ActivityInfo.ActivitCombinationInfosEntryV
ActivitTempleChallengeInfos (21.pb.ActivityInfo.ActivitTempleChallengeInfosEntryJ
ActivitRoleTrialInfos (2+.pb.ActivityInfo.ActivitRoleTrialInfosEntryR
ActivityDailyLotteryInfos (2/.pb.ActivityInfo.ActivityDailyLotteryInfosEntryJ
ActivitSkinTrialInfos	 (2+.pb.ActivityInfo.ActivitSkinTrialInfosEntryT
ActivityTotalRechargeInfos
 (20.pb.ActivityInfo.ActivityTotalRechargeInfosEntryB
ActivityKujiInfos (2'.pb.ActivityInfo.ActivityKujiInfosEntryL
ActivityMainStoryInfos (2,.pb.ActivityInfo.ActivityMainStoryInfosEntryN
ActivityMapExploreInfos (2-.pb.ActivityInfo.ActivityMapExploreInfosEntryP
ActivityMultiDeviceInfos (2..pb.ActivityInfo.ActivityMultiDeviceInfosEntryL
ActivityCompanionInfos (2,.pb.ActivityInfo.ActivityCompanionInfosEntryF
FinishedActivityIdsd (2).pb.ActivityInfo.FinishedActivityIdsEntryZ
ActivitLevelRewardInfosEntry
key ()
value (2.pb.ActivitLevelRewardInfo:8^
ActivitDoubleDungeonInfosEntry
key (+
value (2.pb.ActivitDoubleDungeonInfo:8P
ActivitSignInInfosEntry
key ($
value (2.pb.ActivitSignInInfo:8N
ActivitAbyssInfosEntry
key (#
value (2.pb.ActivitAbyssInfo:8Z
ActivitCombinationInfosEntry
key ()
value (2.pb.ActivitCombinationInfo:8b
 ActivitTempleChallengeInfosEntry
key (-
value (2.pb.ActivitTempleChallengeInfo:8V
ActivitRoleTrialInfosEntry
key ('
value (2.pb.ActivitRoleTrialInfo:8^
ActivityDailyLotteryInfosEntry
key (+
value (2.pb.ActivityDailyLotteryInfo:8V
ActivitSkinTrialInfosEntry
key ('
value (2.pb.ActivitSkinTrialInfo:8`
ActivityTotalRechargeInfosEntry
key (,
value (2.pb.ActivityTotalRechargeInfo:8N
ActivityKujiInfosEntry
key (#
value (2.pb.ActivityKujiInfo:8X
ActivityMainStoryInfosEntry
key ((
value (2.pb.ActivityMainStoryInfo:8Z
ActivityMapExploreInfosEntry
key ()
value (2.pb.ActivityMapExploreInfo:8\
ActivityMultiDeviceInfosEntry
key (*
value (2.pb.ActivityMultiDeviceInfo:8X
ActivityCompanionInfosEntry
key ((
value (2.pb.ActivityCompanionInfo:8:
FinishedActivityIdsEntry
key (
value (:8"å
ActivitLevelRewardInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"Ô
ActivitDoubleDungeonInfo

activityId (.
activityBaseInfo (2.pb.ActivityBaseInfoB
dungeonInfo (2-.pb.ActivitDoubleDungeonInfo.DungeonInfoEntryK
DungeonInfoEntry
key (&
value (2.pb.ActivityDungeonInfo:8"‹
ActivitSignInInfo

activityId (=
signInGroups (2'.pb.ActivitSignInInfo.SignInGroupsEntry.
activityBaseInfo (2.pb.ActivityBaseInfoD
SignInGroupsEntry
key (
value (2.pb.SignInGroup:8"F
ActivityGroup
activityGroupId (
activityChallengeIds ("B
ActivityDungeonInfo
challengeGroup (
finishCount ("U
ActivityEggInfo 
type (2.pb.ActivitEggType
params (
isFinish ("ß
SignInGroup
groupId (;
challengeInfos (2#.pb.SignInGroup.ChallengeInfosEntryJ
ChallengeInfosEntry
key ("
value (2.pb.SignInChallenge:8"I
SignInChallenge
challengeId (
isGained (
rewards ("Ü
ActivitAbyssInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"å
ActivitCombinationInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"`
ActivitTempleChallengeInfo

activityId (.
activityBaseInfo (2.pb.ActivityBaseInfo"ä
ActivitRoleTrialInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"ä
ActivitSkinTrialInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"ä
ActivityLotteryInfo
lotteryPoolId (
totalGachaConut (
todayGachaConut (
leftGachaConut (

gachaConut (
	pityConut (9
	prizeInfo (2&.pb.ActivityLotteryInfo.PrizeInfoEntry0
PrizeInfoEntry
key (
value (:8"Û
ActivityDailyLotteryInfo

activityId (D
lotteryInfos (2..pb.ActivityDailyLotteryInfo.LotteryInfosEntryH
taskFinishInfo (20.pb.ActivityDailyLotteryInfo.TaskFinishInfoEntry.
activityBaseInfo (2.pb.ActivityBaseInfoL
LotteryInfosEntry
key (&
value (2.pb.ActivityLotteryInfo:85
TaskFinishInfoEntry
key (
value (:8"¶
ActivityTotalRechargeInfo

activityId (.
activityBaseInfo (2.pb.ActivityBaseInfo
totalRecharge (.
gainedActivityGroup (2.pb.ActivityGroup"
ActivityKujiInfo

activityId (.
activityBaseInfo (2.pb.ActivityBaseInfo.
gainedActivityGroup (2.pb.ActivityGroup6
	prizeInfo (2#.pb.ActivityKujiInfo.PrizeInfoEntry0
PrizeInfoEntry
key (
value (:8"ã
ActivityMainStoryInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"å
ActivityMapExploreInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"ç
ActivityMultiDeviceInfo

activityId (.
gainedActivityGroup (2.pb.ActivityGroup.
activityBaseInfo (2.pb.ActivityBaseInfo"[
ActivityCompanionInfo

activityId (.
activityBaseInfo (2.pb.ActivityBaseInfo"á
TDClientData

os (	
	osVersion (	
bundleId (	
deviceId (	
deviceModel (	
screenHeight (
screenWidth (
	systemLan (	
cpu	 (	
gpu
 (	
	channelId (	
cps (	
platform (	
clientVersion (	"*
ViolationRecord

id (
num ("h
DeviceLoginObservation
deviceId (	
lastIp (	
lastPlatform (	
lastObservedAt ("Å
OperationalInfo
platform (	
device (	
operatingSystem (	
clientVersion (	
deviceId (	-
violationRecords (2.pb.ViolationRecord
countedBlackAccountIds (;
deviceLoginObservations (2.pb.DeviceLoginObservation".
MaintainInfo
title (	
content (	";
QuestionnaireInfo

id (
title (	
url (	"Ç
TreasureInfo2
	treasures (2.pb.TreasureInfo.TreasuresEntry>
TreasuresEntry
key (
value (2.pb.Treasure:8"0
Treasure

treasureId (
gainTime ("n
ItemDistInfo.
distIds (2.pb.ItemDistInfo.DistIdsEntry.
DistIdsEntry
key (
value (:8"ﬁ
TaskInfo&
tasks (2.pb.TaskInfo.TasksEntry0

taskGroups (2.pb.TaskInfo.TaskGroupsEntry6

TasksEntry
key (
value (2.pb.Task:8@
TaskGroupsEntry
key (
value (2.pb.TaskGroup:8"4
Task

id (
progress (
status ("'
	TaskGroup

id (
status ("?
PayGoods
goodsId (
	beginTime (
endTime ("õ
LoungeInteractPoint

id (
	character (
	waitStory (
	performID (
idleID (/
useType (2.pb.LoungeInteractPointUseType"Å
LoungeCharacterGreetInfo 
todayConditionGreetCount (#
todayNotConditionGreetCount (
lastNotTriggerGreetID (H
triggeredGreet (20.pb.LoungeCharacterGreetInfo.TriggeredGreetEntry5
TriggeredGreetEntry
key (
value (:8"◊
Lounge
currentGlobalStoryID (B
loungeInteractPoints (2$.pb.Lounge.LoungeInteractPointsEntry:
triggeredStories (2 .pb.Lounge.TriggeredStoriesEntry
todayInvitationCount (,
	greetInfo (2.pb.Lounge.GreetInfoEntryT
LoungeInteractPointsEntry
key (&
value (2.pb.LoungeInteractPoint:87
TriggeredStoriesEntry
key (
value (:8N
GreetInfoEntry
key (+
value (2.pb.LoungeCharacterGreetInfo:8J"A
LoungeNormalIdleRecord

lastRandTs (
streakCount ("Ú
LoungeDbModel
lastRefreshTs (
	lobbyInfo (2
.pb.LoungeA
normalIdleRecord (2'.pb.LoungeDbModel.NormalIdleRecordEntry
lastResetTs (S
NormalIdleRecordEntry
key ()
value (2.pb.LoungeNormalIdleRecord:8"?
SystemStatus
mainID (
subID (
disabled ("!
ClaimedTask

subTaskIds ("£
BattlePassDbModel

id (
level (
exp (
	weeklyExp (
premium (=
claimedTasks (2'.pb.BattlePassDbModel.ClaimedTasksEntryI
claimedFreeRewards (2-.pb.BattlePassDbModel.ClaimedFreeRewardsEntryO
claimedPremiumRewards (20.pb.BattlePassDbModel.ClaimedPremiumRewardsEntry(
payLevel	 (2.pb.BattlePassPayLevelD
ClaimedTasksEntry
key (
value (2.pb.ClaimedTask:89
ClaimedFreeRewardsEntry
key (
value (:8<
ClaimedPremiumRewardsEntry
key (
value (:8"D
TextLibraryContent

id (
isRead (

unlockTime ("˛
VocabularyDbModel9

GroupState (2%.pb.VocabularyDbModel.GroupStateEntry=
ContentState (2'.pb.VocabularyDbModel.ContentStateEntry;
ContentInfo (2&.pb.VocabularyDbModel.ContentInfoEntry1
GroupStateEntry
key (
value (:83
ContentStateEntry
key (
value (:8J
ContentInfoEntry
key (%
value (2.pb.TextLibraryContent:8"ü
DiamondInfo
goodsId (
firstBuyTime (5
limitDouble (2 .pb.DiamondInfo.LimitDoubleEntry2
LimitDoubleEntry
key (
value (:8"â
DiamondData5
diamondInfo (2 .pb.DiamondData.DiamondInfoEntryC
DiamondInfoEntry
key (
value (2.pb.DiamondInfo:8"¡

BundleInfo
goodsId (
buyCount (
lastRefreshTs (.
shipDays (2.pb.BundleInfo.ShipDaysEntry
specialRefreshId (/
ShipDaysEntry
key (
value (:8"É

BundleData2

bundleInfo (2.pb.BundleData.BundleInfoEntryA
BundleInfoEntry
key (
value (2.pb.BundleInfo:8"ö
SceneMessageInfo
	messageId (
	accountId (
syntaxId (

contentIds (
styleId (
chunkId (
position (2.pb.PBVector3
expireTs (4
likeInfo	 (2".pb.SceneMessageInfo.LikeInfoEntry/
LikeInfoEntry
key (
value (:8"Ñ
MessageBoardInfo>
ownedMessages (2'.pb.MessageBoardInfo.OwnedMessagesEntry6
	syntaxIds (2#.pb.MessageBoardInfo.SyntaxIdsEntry8

contentIds (2$.pb.MessageBoardInfo.ContentIdsEntryB
likedMessageIds (2).pb.MessageBoardInfo.LikedMessageIdsEntry
	isRefresh (J
OwnedMessagesEntry
key (#
value (2.pb.SceneMessageInfo:80
SyntaxIdsEntry
key (
value (:81
ContentIdsEntry
key (
value (:86
LikedMessageIdsEntry
key (
value (:8*ã
StageStateEnum
STAGE_STATE_OUT 
STAGE_STATE_ONGOING
STAGE_STATE_FAILURE
STAGE_STATE_SUCCESS
STAGE_STATE_TMP_LEAVE*Î&
	ItemsWays
ITEMSWAY_ENTERGAME 
ITEMSWAY_GET_TOPUP"
ITEMSWAY_GET_MENGJING_EXCHANGE
ITEMSWAY_GET_MONTHLY_PASS
ITEMSWAY_GET_PASS$
 ITEMSWAY_GET_WEAPON_MONTHLY_PASS!
ITEMSWAY_GET_XINGHUI_EXCHANGE
ITEMSWAY_GET_YUHUI_EXCHANGE
ITEMSWAY_GET_SHOP_GIFT%
!ITEMSWAY_GET_ABYSS_FIRST_COMPLETE	
ITEMSWAY_GET_ROGUE

ITEMSWAY_GET_DAILY_MISSION
ITEMSWAY_GET_ACTIVITY
ITEMSWAY_GET_MAIL"
ITEMSWAY_GET_MAIN_MISSION_GUID
ITEMSWAY_GET_MISSION
ITEMSWAY_GET_MONSTER_KILL
ITEMSWAY_GET_TREASURE
ITEMSWAY_GET_DAILY_RAID
ITEMSWAY_GET_ACTIVITY_RAID
ITEMSWAY_GET_BOSS_RAID
ITEMSWAY_GET_MISSION_RAID
ITEMSWAY_GET_ONCE_RAID
ITEMSWAY_GET_SHOP_EXCHANGE
ITEMSWAY_GET_ACHIEVEMENT&
"ITEMWAYS_GET_CHARACTER_INIT_WEAPON
ITEMSWAY_GET_COLLECTION
ITEMSWAY_GET_DESTROY
ITEMSWAY_GET_GM
ITEMSWAY_GET_ABYSS_STARS 
ITEMWAYS_GET_OVER_PLAYER_EXP
ITEMWAYS_GET_GACHA
ITEMWAYS_GET_ITEM_USE 
ITEMWAYS_GET_ITEM_COMPOSE!'
#ITEMWAYS_GET_CHARACTER_STAGE_REWARD"$
 ITEMWAYS_GET_PLAYER_LEVEL_REWARD#
ITEMWAYS_GET_POWER_BUY$$
 ITEMWAYS_GET_RAID_FIRST_COMPLETE%&
"ITEMWAYS_GET_DAILY_PLAYER_ACTIVITY&
ITEMWAYS_GET_GUIDE_REWARDS'+
'ITEMWAYS_GET_ACTIVE_POINT_DAILY_REWARDS(+
'ITEMWAYS_GET_ACTIVE_POINT_EXTRA_REWARDS)#
ITEMWAYS_GET_WORLD_BOSS_REWARDS*'
#ITEMWAYS_GET_WORLD_TREASURE_REWARDS+
ITEMWAYS_GET_CHIP_DECOMPOSE,
ITEMWAYS_GET_REDEEM_CODE-
ITEMWAYS_GET_EQUIP_CREATE. 
ITEMWAYS_GET_EQUIP_DISMANTLE/
ITEMWAYS_GET_GEM_FUSION0#
ITEMWAYS_GET_TEMPLE_STAR_REWARD1*
&ITEMWAYS_GET_GACHA_ACCUMULATIVE_REWARD2.
*ITEMWAYS_GET_GACHA_CUSTOM_FINAL_GUARANTEED3,
(ITEMWAYS_GET_GACHA_ROLL_FINAL_GUARANTEED4
ITEMWAYS_GET_POWER_CONSUME5&
"ITEMWAYS_GET_POWER_NATURAL_RECOVER6
ITEMWAYS_GET_RAID_SWEEP7&
"ITEMWAYS_GET_ACTIVITY_LEVEL_REWARD8(
$ITEMWAYS_GET_ACTIVITY_DOUBLE_DUNGEON9!
ITEMWAYS_GET_ACTIVITY_SIGN_IN:
ITEMWAYS_GET_ACTIVITY_ABYSS;%
!ITEMWAYS_GET_ACTIVITY_COMBINATION<
ITEMWAYS_GET_MESSAGE_REWARD=&
"ITEMWAYS_GET_GACHA_EXCHANGE_TICKET>&
"ITEMWAYS_GET_CHARACTER_ELITE_RESET?*
&ITEMWAYS_GET_WORLD_LEVEL_BREAK_THROUGH@,
(ITEMWAYS_GET_SYSTEM_GUIDE_CHAPTER_REWARDA$
 ITEMWAYS_GET_ACTIVITY_ROLE_TRIALB
ITEMSWAY_GET_WEEKLY_RAIDC*
&ITEMSWAY_GET_DIVINE_PUPIL_CLAIM_REWARDD'
#ITEMWAYS_GET_ACTIVITY_DAILY_LOTTERYE$
 ITEMWAYS_GET_AREA_EXPLORE_REWARDF(
$ITEMWAYS_GET_SUB_AREA_EXPLORE_REWARDG#
ITEMWAYS_GET_BATTLE_PASS_REWARDH
ITEMWAYS_GET_ITEM_RECYCLEI*
&ITEMWAYS_GET_MAIN_GUIDE_MISSION_REWARDJ*
&ITEMWAYS_GET_MAIN_GUIDE_CHAPTER_REWARDK!
ITEMWAYS_GET_BAG_CHEST_REWARDL!
ITEMWAYS_GET_WILD_BOSS_REWARDM!
ITEMWAYS_GET_MONTHLY_PASS_BUYN'
#ITEMWAYS_GET_GACHA_MILESTONE_REWARDO.
*ITEMWAYS_GET_CHARACTER_CONSTELLATION_RESETP$
 ITEMWAYS_GET_ACTIVITY_SKIN_TRIALQ#
ITEMWAYS_GET_BLOOD_STAIN_REWARDR(
$ITEMWAYS_GET_ACTIVITY_TOTAL_RECHARGES
ITEMWAYS_GET_ACTIVITY_KUJIT$
 ITEMWAYS_GET_ACTIVITY_MAIN_STORYU+
'ITEMWAYS_GET_STATE_OBJECT_UNLOCK_REWARDV
ITEMWAYS_GET_POWER_EXCHANGEW%
!ITEMWAYS_GET_ACTIVITY_MAP_EXPLOREX&
"ITEMWAYS_GET_ACTIVITY_MULTI_DEVICEY!
ITEMWAYS_GET_EXCHANGE_DIAMONDZ#
ITEMWAYS_GET_SKILLGROUP_LEVELUP[
ITEMWAYS_COST_GMõ 
ITEMWAYS_COST_SHOP_EXCHANGEú$
ITEMWAYS_COST_MENGJING_EXCHANGEù
ITEMWAYS_COST_QUICK_BUYû
ITEMWAYS_COST_POWER_BUYü!
ITEMWAYS_COST_PASS_LEVEL_BUY†%
 ITEMWAYS_COST_CHARACTER_LEVEL_UP°%
 ITEMWAYS_COST_CHARACTER_STAGE_UP¢%
 ITEMWAYS_COST_CHARACTER_SKILL_UP£"
ITEMWAYS_COST_WEAPON_LEVEL_UP§"
ITEMWAYS_COST_WEAPON_STAGE_UP• 
ITEMWAYS_COST_WEAPON_REFINE¶ 
ITEMWAYS_COST_CHIP_LEVEL_UPß
ITEMWAYS_COST_ITEM_COMPOSE®
ITEMWAYS_COST_ITEM_DELETE©
ITEMWAYS_COST_ITEM_USE™
ITEMWAYS_COST_MISSION´
ITEMWAYS_COST_COOK¨*
%ITEMWAYS_COST_CHARACTER_CONSTELLATION≠
ITEMWAYS_COST_GACHAÆ
ITEMWAYS_COST_RAIDØ.
)ITEMWAYS_COST_ACTIVE_POINT_DAILY_EXCHANGE∞.
)ITEMWAYS_COST_ACTIVE_POINT_EXTRA_EXCHANGE±+
&ITEMWAYS_COST_UNLOCK_CHARACTER_MISSION≤*
%ITEMWAYS_COST_WORLD_BOSS_TAKE_REWARDS≥)
$ITEMWAYS_COST_WORLD_TREASURE_REWARDS¥!
ITEMWAYS_COST_CHIP_DECOMPOSEµ"
ITEMWAYS_COST_POTION_LEVEL_UP∂
ITEMWAYS_COST_EQUIP_CREATE∑ 
ITEMWAYS_COST_EQUIP_ENHANCE∏"
ITEMWAYS_COST_EQUIP_DISMANTLEπ
ITEMWAYS_COST_GEM_FUSION∫&
!ITEMWAYS_COST_CONVERT_ELITE_POINTª
ITEMWAYS_COST_RAID_SWEEPº(
#ITEMWAYS_COST_GACHA_EXCHANGE_TICKETΩ+
&ITEMWAYS_COST_CHARACTER_ELITE_LEVEL_UPæ&
!ITEMWAYS_COST_DIVINE_PUPIL_SUBMITø!
ITEMWAYS_COST_CHARACTER_GIFT¿(
#ITEMWAYS_COST_BATTLE_PASS_BUY_LEVEL¡
ITEMWAYS_COST_ITEM_RECYCLE¬)
$ITEMWAYS_COST_WILD_BOSS_TAKE_REWARDS√.
)ITEMWAYS_COST_WILD_BOSS_BUY_REWARDS_COUNTƒ
ITEMSWAY_COST_ROGUE≈ 
ITEMWAYS_COST_ACTIVITY_KUJI∆ 
ITEMWAYS_COST_MIRROR_REPAIR«!
ITEMWAYS_COST_POWER_EXCHANGE»#
ITEMWAYS_COST_EXCHANGE_DIAMOND… 
ITEMWAYS_COST_MESSAGE_BOARD 
ITEMWAYS_OTHERèN*¡
UniversalItemType
UNIVERSAL_ITEM_NORMAL 
UNIVERSAL_ITEM_WEAPON
UNIVERSAL_ITEM_CHIP
UNIVERSAL_ITEM_EQUIP
UNIVERSAL_ITEM_GEM
UNIVERSAL_ITEM_CHARACTER
UNIVERSAL_ITEM_SKIN
UNIVERSAL_ITEM_EFFECT_DRESS
UNIVERSAL_ITEM_TITLE
UNIVERSAL_ITEM_AVATAR	
UNIVERSAL_ITEM_AVATARFRAME
*ª
UniversalItemTag
UNIVERSAL_ITEM_TAG_DEFAULT 
UNIVERSAL_ITEM_TAG_EXTRA!
UNIVERSAL_ITEM_TAG_TARGET_ONE!
UNIVERSAL_ITEM_TAG_TARGET_TWO#
UNIVERSAL_ITEM_TAG_TARGET_THREE*|
	EquipType
EQUIP_TYPE_NULL 
EQUIP_TYPE_FORCE
EQUIP_TYPE_DYNAMIC
EQUIP_TYPE_ENERGY
EQUIP_TYPE_ASSIST*c
SceneStatus
MAIN 
RAID	
ABYSS	
ROGUE
TRAININGGROUND

TEMPLE

LOUNGE*M
SceneWorldLayer
SCENE_WORLD_LAYER_SURFACE 
SCENE_WORLD_LAYER_INNER*A
CookWay
MENU 

CUSTOM
	SAVEDMENU
RECOMMENDMENU*/
MapTracePointEnum
MAP_TRACE_CUSTOM_POINT *|
MailLinkType
MAIL_LINK_TYPE_NONE 
MAIL_LINK_TYPE_INNER
MAIL_LINK_TYPE_OUTER
MAIL_LINK_TYPE_GAME_CONTENT*x
AbyssStageState
ABYSS_STAGE_ONGOING 
ABYSS_STAGE_TMP_LEAVE
ABYSS_STAGE_Complete
ABYSS_STAGE_FAILURE*^
TempleStageState
TEMPLE_STAGE_INIT 
TEMPLE_STAGE_COMPLETE
TEMPLE_STAGE_FAILURE*´
GachaPoolType
POOL_TYPE_NULL 
POOL_TYPE_RESIDENT 
POOL_TYPE_LIMITED_GUARANTEED
POOL_TYPE_LIMITED_UP
POOL_TYPE_TEST_ROUND_TWO
POOL_TYPE_NEWBIE*m
GachaPoolState
GACHA_POOL_STATE_EFFECTIVE 
GACHA_POOL_STATE_OFF_SHELF
GACHA_POOL_STATE_SHIELD*C
GuideStateEnum
GUIDE_STATE_ONGOING 
GUIDE_STATE_COMPLETE*K
ClientModuleEnum
CLIENT_MODULE_ENUM_UI 
CLIENT_MODULE_ENUM_INPUT*P
BloodstainState
BLOODSTAIN_STATE_INITIAL 
BLOODSTAIN_STATE_INTERACTED*õ
MissionStateEnum
MISSION_STATE_WAIT_ACCEPT 
MISSION_STATE_ONGOING
MISSION_STATE_FAILED
MISSION_STATE_SUCCESS
MISSION_STATE_GIVEUP*h
MissionFlowType
MISSION_FLOW_TYPE_NORMAL 
MISSION_FLOW_TYPE_FAIL
MISSION_FLOW_TYPE_EXTRA*T
	RaidState
RAID_STATE_INIT 
RAID_STATE_TOOK_REWARD
RAID_STATE_FAILURE*1
AchievementTag
AC_NOTAG 
AC_COLLECTION*ﬁ	
AchievementCountKey)
%ACHIEVEMENT_COUNT_MAXIMUM_WORLD_LEVEL 
ACHIEVEMENT_COUNT_LOGIN_DAY*
&ACHIEVEMENT_COUNT_MAXIMUM_ABYSS_STARTS#
ACHIEVEMENT_COUNT_PERFECT_DODGE"
ACHIEVEMENT_COUNT_TOTAL_DAMAGE$
 ACHIEVEMENT_COUNT_KILLED_MONSTER!
ACHIEVEMENT_COUNT_KILLED_BOSS"
ACHIEVEMENT_COUNT_MAIN_MISSION"
ACHIEVEMENT_COUNT_SIDE_MISSION#
ACHIEVEMENT_COUNT_DAILY_MISSION	!
ACHIEVEMENT_COUNT_ONLINE_TIME

ACHIEVEMENT_COUNT_GACHA"
ACHIEVEMENT_COUNT_EQUIP_CREATE'
#ACHIEVEMENT_COUNT_CONSECUTIVE_LOGIN$
 ACHIEVEMENT_COUNT_LEVEL_UP_EQUIP#
ACHIEVEMENT_COUNT_OPEN_TREASURE(
$ACHIEVEMENT_COUNT_COLLECT_GATHERABLE"
ACHIEVEMENT_COUNT_COMBINE_ITEM(
$ACHIEVEMENT_COUNT_SUPPORT_SKILL_CAST)
%ACHIEVEMENT_COUNT_ROGUELIKE_RAID_PASS)
%ACHIEVEMENT_COUNT_WILD_BOSS_CHALLENGE/
+ACHIEVEMENT_COUNT_BREAK_TOUGHNESS_BAR_COUNT1
-ACHIEVEMENT_COUNT_CHAR_TUTORIAL_TASK_COMPLETE)
%ACHIEVEMENT_COUNT_DEATH_BY_TRAP_COUNT,
(ACHIEVEMENT_COUNT_DESTROY_MAP_PROP_COUNT4
0ACHIEVEMENT_COUNT_REVIVE_CHARACTERS_WITH_BEACONS-
)ACHIEVEMENT_COUNT_SCENE_USE_GRIPPER_COUNT+
'ACHIEVEMENT_COUNT_BEACON_TELEPORT_COUNT0
,ACHIEVEMENT_COUNT_KILL_MONSTER_BY_TRAP_COUNT)
%ACHIEVEMENT_COUNT_UPDRAFT_MAXIMUM_SEC*O
RogueGameState
ROGUE_GAME_NULL 
ROGUE_GAME_HANG
ROGUE_GAME_PLAY*´
RogueRoomType
ROGUE_ROOM_TYPE_NULL 
ROGUE_ROOM_TYPE_ALLY
ROGUE_ROOM_TYPE_ITEM
ROGUE_ROOM_TYPE_CION
ROGUE_ROOM_TYPE_SHOP
ROGUE_ROOM_TYPE_BOSS*S
RogueRoomStatus 
ROGUE_ROOM_STATUS_UNFINISHED 
ROGUE_ROOM_STATUS_FINISHED*e
RogueFinishType
ROGUE_FINISH_TYPE_PASS 
ROGUE_FINISH_TYPE_DEAD
ROGUE_FINISH_TYPE_QUIT*z
ContactSessionState
CONTACT_SESSION_STATE_LOCK !
CONTACT_SESSION_STATE_ONGOING 
CONTACT_SESSION_STATE_FINISH*X
ActivitType
ACTICITY_BASE 
ACTICITY_LEVEL_REWARD
ACTICITY_DOUBLE_DUNGEON*_
ActivitEggType
EGG_NULL 

EGG_REWARD
EGG_BOSS
EGG_DUNGEON
EGG_TREASURE*±
LoungeInteractPointUseType#
LOUNGE_INTERACT_POINT_USE_EMPTY $
 LOUNGE_INTERACT_POINT_USE_INVITE$
 LOUNGE_INTERACT_POINT_USE_GLOBAL"
LOUNGE_INTERACT_POINT_USE_RAND*a
BattlePassPayLevel
BATTLE_PASS_PAY_NULL 
BATTLE_PASS_PAY_LOW
BATTLE_PASS_PAY_HIGHB™ACT.Game.Databproto3
™
abyss.protopbcommon.proto"o
AbyssChallengeStageReq
selectedStageIdx (
abyssId (
teams (2.pb.TeamUsage
byGM ("ç
AbyssChallengeStageAck
errMsg (	
transNo (	4
characterRepository (2.pb.CharacterRepository
	abyssData (2	.pb.Abyss"W
AbyssCompleteSubStageReq

useSeconds ('

settleInfo (2.pb.StageSettleInfo"ê
AbyssCompleteSubStageAck
errMsg (	
completedAll (*
completedStageInfo (2.pb.AbyssStage
unlockNewStage (
transNo (	
	abyssData (2	.pb.Abyss'
stageRewards (2.pb.UniversalItem,
quickStageRewards	 (2.pb.UniversalItemJ"]
AbyssTakeRewardReq

targetStar (
abyssId (
stageIdx (
claimAll ("T
AbyssTakeRewardAck 
items (2.pb.UniversalItem
	abyssData (2	.pb.Abyss"X
AbyssRechallengeReq
onlyCurrentLayer ('

settleInfo (2.pb.StageSettleInfo"z
AbyssRechallengeAck
transNo (	4
characterRepository (2.pb.CharacterRepository
	abyssData (2	.pb.Abyss"E
AbyssLeaveReq
tmp ('

settleInfo (2.pb.StageSettleInfo"-
AbyssLeaveAck
	abyssData (2	.pb.Abyss"
AbyssComebackReq"f
AbyssComebackAck
	abyssData (2	.pb.Abyss4
characterRepository (2.pb.CharacterRepository":
AbyssFailureReq'

settleInfo (2.pb.StageSettleInfo"/
AbyssFailureAck
	abyssData (2	.pb.Abyss"©
AbyssNtf
abyss (2	.pb.Abyss*
abysses (2.pb.AbyssNtf.AbyssesEntry
lastChallengeAbyssID (9
AbyssesEntry
key (
value (2	.pb.Abyss:8bproto3
˚
activity.protopbcommon.proto"
ActivityRefreshReq"
ActivityRefreshAck"T
ActivityLevelRewardNtf:
activitLevelRewardInfo (2.pb.ActivitLevelRewardInfo"a
ActivityGetLevelRewardReq

activityId (
activityGroup (
activityChallenge ("@
ActivityGetLevelRewardAck#
gotItems (2.pb.UniversalItem"Z
ActivityDoubleDungeonNtf>
activitDoubleDungeonInfo (2.pb.ActivitDoubleDungeonInfo"F
ActivityDoubleDungeonRewardReq

activityId (
rewardId (" 
ActivityDoubleDungeonRewardAck"E
ActivitySignInNtf0
activitSignInInfo (2.pb.ActivitSignInInfo"j
ActivitySignInChooseRewardReq

activityId (
groupId (
challengeId (
rewards ("
ActivitySignInChooseRewardAck"S
ActivitySignInRewardReq

activityId (
groupId (
challengeId ("W
ActivitySignInRewardAck
items (2.pb.Item#
gotItems (2.pb.UniversalItem"B
ActivityAbyssNtf.
activitAbyssInfo (2.pb.ActivitAbyssInfo"^
ActivityAbyssRewardReq

activityId (
activityGroup (
activityChallenge ("1
ActivityAbyssRewardAck
items (2.pb.Item"T
ActivityCombinationNtf:
activitCombinationInfo (2.pb.ActivitCombinationInfo"I
ActivityCombinationRewardReq

activityId (
activityGroup ("7
ActivityCombinationRewardAck
items (2.pb.Item"`
ActivityTempleChallengeNtfB
activitTempleChallengeInfo (2.pb.ActivitTempleChallengeInfo"N
ActivityRoleTrialNtf6
activitRoleTrialInfo (2.pb.ActivitRoleTrialInfo"b
ActivityRoleTrialRewardReq

activityId (
activityGroup (
activityChallenge (">
ActivityRoleTrialRewardAck 
items (2.pb.UniversalItem"N
ActivitySkinTrialNtf6
activitSkinTrialInfo (2.pb.ActivitSkinTrialInfo"b
ActivitySkinTrialRewardReq

activityId (
activityGroup (
activityChallenge (">
ActivitySkinTrialRewardAck 
items (2.pb.UniversalItem"Y
ActivityDailyLotteryNtf>
activityDailyLotteryInfo (2.pb.ActivityDailyLotteryInfo"]
ActivityDailyLotteryGachaReq

activityId (
lotteryPoolId (

gachaConut ("@
ActivityDailyLotteryGachaAck 
items (2.pb.UniversalItem"\
ActivityTotalRechargeNtf@
activityTotalRechargeInfo (2.pb.ActivityTotalRechargeInfo"f
ActivityTotalRechargeRewardReq

activityId (
activityGroup (
activityChallenge ("B
ActivityTotalRechargeRewardAck 
items (2.pb.UniversalItem"A
ActivityKujiNtf.
activityKujiInfo (2.pb.ActivityKujiInfo"B
ActivityKujiRewardReq

activityId (
activityGroup ("9
ActivityKujiRewardAck 
items (2.pb.UniversalItem")
ActivityKujiDrawReq

activityId ("7
ActivityKujiDrawAck 
items (2.pb.UniversalItem"P
ActivityMainStoryNtf8
activityMainStoryInfo (2.pb.ActivityMainStoryInfo"G
ActivityMainStoryRewardReq

activityId (
activityGroup (">
ActivityMainStoryRewardAck 
items (2.pb.UniversalItem"S
ActivityMapExploreNtf:
activityMapExploreInfo (2.pb.ActivityMapExploreInfo"H
ActivityMapExploreRewardReq

activityId (
activityGroup ("?
ActivityMapExploreRewardAck 
items (2.pb.UniversalItem"V
ActivityMultiDeviceNtf<
activityMultiDeviceInfo (2.pb.ActivityMultiDeviceInfo"d
ActivityMultiDeviceRewardReq

activityId (
activityGroup (
activityChallenge ("@
ActivityMultiDeviceRewardAck 
items (2.pb.UniversalItembproto3
â
archive.protopbcommon.proto"*

ArchiveNtf
archive (2.pb.Archive"0
ArchiveChangeNtf
archive (2.pb.Archive"*
ArchiveUpdateReq
unlockMonsters ("
ArchiveUpdateAck".
ArchiveReadReq
archive (2.pb.Archive"
ArchiveReadAckbproto3
Ñ
assist.protopbcommon.proto"(
	AssistNtf
changes (2
.pb.Assist"=
AssistSkinNtf
assist (
skin (2.pb.AssistSkin">
AssistDyeingReq
assist (
skin (
color (",
AssistDyeingAck
changes (2.pb.Item"=
AssistSetupReq
assist (
skin (
color ("
AssistSetupAck" 
AssistEquipReq
assist ("
AssistEquipAckbproto3
π
battlepass.protopbcommon.proto"v
BattlePassNtf-
battlePassInfo (2.pb.BattlePassDbModel
battlePassBeginTime (
battlePassEndTime (")
BattlePassBuyLevelReq
buyCount ("
BattlePassBuyLevelAck";
BattlePassClaimTaskReq
taskId (
	subTaskId ("
BattlePassClaimTaskAck":
BattlePassClaimRewardReq
level (
premium ("<
BattlePassClaimRewardAck 
items (2.pb.UniversalItembproto3
ß

bill.protopbcommon.proto"e
CreatOrderReq
goodsId (
currency (	
indexs (
itemId (
	subShopId ("a
CreatOrderAck
orderId (	
money (
callbackUrl (	
extra (	
sign (	"
PayActionProcessReq"
PayActionProcessAck"D
OrderShipNtf
orderId (	#
gotItems (2.pb.UniversalItem"(
OrderShipDisplayedReq
orderId (	"
OrderShipDisplayedAckbproto3
›
character.protopbcommon.proto"P
CharacterNtf
changes (2.pb.Character 
	changeWay (2.pb.ItemsWays"≤
CharacterChangeNtf
	sceneEnum (:

characters (2&.pb.CharacterChangeNtf.CharactersEntryD
extraCharacters (2+.pb.CharacterChangeNtf.ExtraCharactersEntry@
CharactersEntry
key (
value (2.pb.Character:8E
ExtraCharactersEntry
key (
value (2.pb.Character:8"æ
CharacterDependChangeNtf
	sceneEnum (<
characterDependSnapshot (2.pb.CharacterDependSnapshotA
extraCharacterDependSnapshot (2.pb.CharacterDependSnapshot
remove (";
CharacterLevelUpReq

id (
spends (2.pb.Item"0
CharacterLevelUpAck
changes (2.pb.Item"0
CharacterStageReq

id (
toStage (".
CharacterStageAck
changes (2.pb.Item"8
CharacterTakeStageRewardReq

id (
stage ("6
CharacterTakeStageRewardAck
items (2.pb.Item"£
CharacterStatusSyncReq.
cs (2".pb.CharacterStatusSyncReq.CsEntry
battleCharacterId (>
CsEntry
key ("
value (2.pb.CharacterStatus:8"
CharacterStatusSyncAck"J
CharacterUpgradeSkillGroupReq
characterId (
skillGroupId ("D
CharacterUpgradeSkillGroupAck#
gotItems (2.pb.UniversalItem"P
 CharacterUpgradeConstellationReq
characterId (
constellationId (""
 CharacterUpgradeConstellationAck"O
CharacterReturnConstellationReq
characterId (
constellationId ("!
CharacterReturnConstellationAck"P
CharacterUpdateConstellationReq
characterId (
constellationIds (";
CharacterUpdateConstellationAck
constellationNum ("Q
CharacterEliteLevelUpReq
characterId (
pointId (
toLevel ("
CharacterEliteLevelUpAck"Q
CharacterEliteResetReq
characterId (
pointId (
	pointNode ("
CharacterEliteResetAckbproto3


chip.protopbcommon.proto"Z
ChipNtf
changes (2.pb.Chip

removeUids ( 
	changeWay (2.pb.ItemsWays":
ChipWearPosition
uid (
slot (
idx ("G
ChipWearReq
characterId (#
chips (2.pb.ChipWearPosition"
ChipWearAck"5
ChipUnloadReq
characterId (
chipUid ("
ChipUnloadAck"(
ChipLockReq
uid (
lock ("
ChipLockAck"
ChipLevelUpReq
uid ("+
ChipLevelUpAck
changes (2.pb.Item" 
ChipDecomposeReq
uids ("+
ChipDecomposeAck
items (2.pb.Item"$
ChipCancelNewFlagReq
uids ("
ChipCancelNewFlagAckbproto3
À
contact.protopbcommon.proto"*

ContactNtf
contact (2.pb.Contact"é
ContactCharacterMessageNtf
	sessionId (
newMessages (
sessionFinish (
updateTimeStamp (
newMessagesInt64 ("n
ContactCharacterSessionNtf-
sessions (2.pb.ContactCharacterSession!
gmMode (2.pb.ContactGMMode">
ContactChooseOptionReq
	sessionId (
	chooseIdx ("
ContactChooseOptionAck"E
ContactChatWithPlayerReq)
message (2.pb.ContactPlayerMessage"(
ContactChatWithPlayerAck
code ("D
ContactPlayerMessageNtf)
message (2.pb.ContactPlayerMessage*b
ContactGMMode
CONTACT_GM_MODE_NONE 
CONTACT_GM_MODE_NORMAL
CONTACT_GM_MODE_OPEN_UIbproto3
ü
dropitem.protopbcommon.proto"$
DropItemPickPackageReq

id ("s
DropItemPickPackageAck%
dropRes (2.pb.DropItemPickInfo
wid (%

gotRewards (2.pb.UniversalItem"#
DropItemPickItemReq
uids ("9
DropItemPickInfo
uid (
err (2.pb.PickErr"I
DropItemPickItemAck%
dropRes (2.pb.DropItemPickInfo
wid ("d
DropItemAddNtf
wid (
dropSoureUid (
ditems (2.pb.DropItem
	packageId (*G
PickErr
PICK_NO_ERR 
PICK_UNKNOWN_ERR
PICK_BAG_FULL_ERRbproto3
ö
enter.protopbcommon.proto"À
EnterGameReq
openId (	
loginKey (	
	accountId (
isEditor (
sdkAid (

distinctID (	
clientVersion (	 
tdData (2.pb.TDClientData
	sessionID	 (	J
"ö
EnterGameAck

ts (
version (	
openTime ( 
info (2.pb.DetailUserInfo
databaseVersion (	
lastEnterTime (
	isNewUser (
code (
	banNotice	 (	&
maintainInfo
 (2.pb.MaintainInfo
	sessionID (	
lastSessionExpired ("1
CreateUserReq
gender (
nickName (	"F
CreateUserAck 
info (2.pb.DetailUserInfo
isValidName ("%
EnterGameLoadReq
	lastSeqID ("4
EnterGameLoadAck 
info (2.pb.DetailUserInfo"
RandomNameReq"
RandomNameAck
name (	bproto3
Ê
equip.protopbcommon.proto"`
EquipInfoNtf
changes (2	.pb.Equip

removeUids ( 
	changeWay (2.pb.ItemsWays"\

GemInfoNtf
changes (2.pb.Gem

removeUids ( 
	changeWay (2.pb.ItemsWays"
EquipCreateReq

id ("5
EquipCreateAck#
gotItems (2.pb.UniversalItem"-
EquipEnhanceReq
uid (
level ("
EquipEnhanceAck"!
EquipDismantleReq
uids (",
EquipDismantleAck
items (2.pb.Item"0
EquipWearReq
uid (
characterId ("
EquipWearAck"Z
EquipGemOperateReq
equipUid (
	gemSlotId (
operate (
gemUid (".
EquipGemOperateAck
equip (2	.pb.Equip"+
EquipLockReq
uid (
isLock ("
EquipLockAck"
GemFusionReq
uids ("3
GemFusionAck#
gotItems (2.pb.UniversalItem")

GemLockReq
uid (
isLock ("

GemLockAckbproto3
Ù

fish.protopbcommon.proto" 
FishSetupReq
fishBait ("
FishSetupAck"
FishStartReq"1
FishStartAck
startTs (
finishTs ("
FishReq

ts ("@
FishAck
fish (
size (
changes (2.pb.Itembproto3
‚
handbook.protopbcommon.proto"6
HandbookInfoNtf#
	handbooks (2.pb.HandbookInfo"-
HandbookNtf
handbook (2.pb.Handbook"[
HandbookUpdateReq
unlockMonsters (
killedMonsters (
unlockWildBoss ("ô
HandbookUpdateAckI
monsterKilledCount (2-.pb.HandbookUpdateAck.MonsterKilledCountEntry9
MonsterKilledCountEntry
key (
value (:8"3
"HandbookDailyMissionClaimRewardReq
rowId ("v
"HandbookDailyMissionClaimRewardAck 
items (2.pb.UniversalItem.
rewardStatus (2.pb.HandbookRewardStatus"9
#HandbookDailyActivePtClaimRewardReq

ptRewardId ("w
#HandbookDailyActivePtClaimRewardAck 
items (2.pb.UniversalItem.
rewardStatus (2.pb.HandbookRewardStatus"I
(HandbookGrowthGuideMissionClaimRewardReq

id (
	chapterID ("x
(HandbookGrowthGuideMissionClaimRewardAck 
items (2.pb.UniversalItem*
growthGuide (2.pb.PlayerGrowthGuide"6
(HandbookGrowthGuideChapterClaimRewardReq

id ("x
(HandbookGrowthGuideChapterClaimRewardAck 
items (2.pb.UniversalItem*
growthGuide (2.pb.PlayerGrowthGuidebproto3
µ
interactevent.protopbcommon.proto"§
TriggerInteractEventReq
wid (#
states (2.pb.StateChangeInfo
items (2.pb.Item
position (2.pb.PBVector3,
characterInfo (2.pb.CharacterSyncInfo*
mapViewLogInfo (2.pb.MapViewLogInfo2
mapViewRecordParam (2.pb.MapViewRecordParam
chunkID ("B
StateChangeInfo
uid (
stateId (
	eventName (	";
TriggerInteractEventAck 
items (2.pb.UniversalItem"I
ServiceSaveStateNtf
wid (%
changes (2.pb.ServiceSaveState"C
ServiceBehaveNtf
wid ("
changes (2.pb.ServiceBehave"H
SceneChallengeBossReq
difficultyLevel (
interactionUid ("
SceneChallengeBossAck"9
SceneTakeChallengeBossRewardReq
interactionUid ("<
SceneTakeChallengeBossRewardAck
rewards (2.pb.Item"
SceneResetChallengeBossReq"
SceneResetChallengeBossAck"
TriggerTeleportPointReq"
TriggerTeleportPointAckbproto3
í

item.protopbcommon.proto"F
ItemNtf
changes (2.pb.Item 
	changeWay (2.pb.ItemsWays"6
ItemAffectObject

objectType (
objIDs ("W
UseItemsReq
item (2.pb.OperationItem'
	affectObj (2.pb.ItemAffectObject"Ü
UseItemsAck

ok ('
	affectObj (2.pb.ItemAffectObject
obtainItems (2.pb.Item#
gotItems (2.pb.UniversalItem"A
DelItemsReq
itemType ( 
items (2.pb.OperationItem"
DelItemsAck

ok (".
ComposeItemReq

targetItem (2.pb.Item"
ComposeItemAck"6
LittleItemsNtf$
littleItems (2.pb.LittleItems"
UseLittleItemReq

id ("
UseLittleItemAck"
PotionUseReq"!
PotionUseAck
	usedCount ("/
PotionLevelUpReq

id (
toLevel ("
PotionLevelUpAck">
PotionUpdateAdditiveReq
potionId (
	additives ("
PotionUpdateAdditiveAck")
PotionRecoverUseCountReq
count ("-
PotionRecoverUseCountAck
	usedCount ("3
PotionInfoNtf"

potionInfo (2.pb.PotionInfo",
	PotionNtf
potions (2.pb.PotionItem"ß
PotionChangeNtf
	sceneEnum (1
potions (2 .pb.PotionChangeNtf.PotionsEntry
remove (>
PotionsEntry
key (
value (2.pb.PotionItem:8"?
SyncLittleItemsReq)
info (2.pb.LittleItemsShortcutInfo"
SyncLittleItemsAck"9
TreasureInfoNtf&
treasureInfo (2.pb.TreasureInfo"3
RecycleItemsReq 
items (2.pb.UniversalItem"3
RecycleItemsAck 
items (2.pb.UniversalItem"E
OpenBagChestReq
itemId (
count (
chooseIndex ("3
OpenBagChestAck 
items (2.pb.UniversalItem"J
BagChestRewardSelectCountNtf*
data (2.pb.BagChestRewardSelectDatabproto3
‘
login.protopbcommon.proto"Ÿ
LoginReq
loginTicket (	
openId (	

appVersion (	
	accountId (,
operationalInfo (2.pb.OperationalInfo

distinctID (	 
tdData (2.pb.TDClientData
isEditor (
env	 (	"Œ
LoginAck
openId (	
loginKey (	
	accountId (
gateAddr (	
code (
serverGroup (	
sdkAid (
aesKey (
isEncry	 (
fairTag
 (
gateAddrBackup (	bproto3
Ì
lounge.protopbcommon.proto"
LoungeEnterReq"0
LoungeEnterAck

loungeInfo (2
.pb.Lounge"
LoungeLeaveReq"
LoungeLeaveAck"B
GiftToCharacterReq
gifts (2.pb.Item
characterID ("Ω
GiftToCharacterAck
characterID (
gotLikeability (
curLikeabilityLv (
curLikeabilityExp (-
likeabilityRewards (2.pb.UniversalItem
todayGiftCount ("n
LoungeTriggerPointReq
pointID (/
triggerType (2.pb.LoungeTriggerPointType
characterID ("ƒ
LoungeTriggerPointAck

loungeInfo (2
.pb.Lounge
pointID (
gotLikeability (
curLikeabilityLv (
curLikeabilityExp (-
likeabilityRewards (2.pb.UniversalItem*ü
LoungeTriggerPointType.
*LOUNGE_TRIGGER_POINT_TYPE_INVITE_CHARACTER 0
,LOUNGE_TRIGGER_POINT_TYPE_INTERACT_CHARACTER#
LOUNGE_TRIGGER_POINT_TYPE_STORYbproto3
¸

mail.protopbcommon.proto":
MailChangeTagReq

id (
toTag (2.pb.MailTag"
MailChangeTagAck"A
MailChangeStateReq
ids (
toState (2.pb.MailState"F
MailChangeStateAck
ids (#
gotItems (2.pb.UniversalItem"
MailUnlockReq

id ("'
MailUnlockAck
mail (2.pb.Mail"
MailOpenBoxReq"v
MailOpenBoxAck,
mails (2.pb.MailOpenBoxAck.MailsEntry6

MailsEntry
key (
value (2.pb.Mail:8"}
MailNtf%
mails (2.pb.MailNtf.MailsEntry
lockTmplIds (6

MailsEntry
key (
value (2.pb.Mail:8"
MailHasNewNtf*E
	MailState

UNREAD 
READ

REWARD

DELETE

UNSEND*/
MailType
	ZERO_FILL 

NORMAL
RARE*!
MailTag	
NOTAG 
COLLECTbproto3
ì
	map.protopbcommon.proto"6
MapSetupCustomFlagReq
cf (2.pb.MapCustomFlag"6
MapSetupCustomFlagAck
cf (2.pb.MapCustomFlag"L
MapModifyCustomFlagTypeReq
areaID (
flagID (
newTyp ("I
MapModifyCustomFlagTypeAck+
latestCustomFlag (2.pb.MapCustomFlag"5
MapDelCustomFlagReq
areaID (
flagID ("
MapDelCustomFlagAck"+
MapFetchCustomFlagInfoReq
areaID ("B
MapFetchCustomFlagInfoAck%
	areaFlags (2.pb.MapCustomFlags"ê
MapCustomFlagNtf6
	areaFlags (2#.pb.MapCustomFlagNtf.AreaFlagsEntryD
AreaFlagsEntry
key (!
value (2.pb.MapCustomFlags:8"J
MapSetupTracePointReq!
point (2.pb.MapTrancePoint
cancel ("
MapSetupTracePointAck"6
MapTrancePointNtf!
point (2.pb.MapTrancePoint"ê
MapAreaDivinePupilsNtf6
pupils (2&.pb.MapAreaDivinePupilsNtf.PupilsEntry>
PupilsEntry
key (
value (2.pb.DivinePupil:8"8
MapSubmitDivinePupilReq
areaID (
count ("n
MapSubmitDivinePupilAck#
gotItems (2.pb.UniversalItem.
latestDivinePupilInfo (2.pb.DivinePupil".
MapClaimDivinePupilRewardReq
areaID ("s
MapClaimDivinePupilRewardAck#
gotItems (2.pb.UniversalItem.
latestDivinePupilInfo (2.pb.DivinePupil"ñ
MapAreaUnlockNtf:
areaExplore (2%.pb.MapAreaUnlockNtf.AreaExploreEntryF
AreaExploreEntry
key (!
value (2.pb.MapAreaExplore:8"
MapAreaExploreQueryReq"¢
MapAreaExploreQueryAck@
areaExplore (2+.pb.MapAreaExploreQueryAck.AreaExploreEntryF
AreaExploreEntry
key (!
value (2.pb.MapAreaExplore:8"<
MapExploreClaimRewardReq
areaType (
areaId ("h
MapExploreClaimRewardAck#
gotItems (2.pb.UniversalItem'
areaExplore (2.pb.MapAreaExplore"+
LightMapBlockReq
wid (

id ("
LightMapBlockAck"/
LightedMapBlocksNtf
wid (
ids ("B
MapViewLogReq
layer (	"
position (2.pb.PBVector2Int"
MapViewLogAck"I
MapViewCompleteLayerReq
layer (	
areaID (
chunkID ("
MapViewCompleteLayerAck"e

MapViewNtf
wid ( 
mapView (2.pb.MapViewInfo(
mapViewFull (2.pb.MapViewFullInfobproto3
‚
messageboard.protopbcommon.proto"A
MessageBoardNtf.
messageBoardInfo (2.pb.MessageBoardInfo"-
MessageBoardAddSyntaxNtf
	syntaxIds ("/
MessageBoardAddContentNtf

contentIds (">
SceneMessageNtf+
sceneMessages (2.pb.SceneMessageInfo"o
SceneMessageCreateReq
syntaxId (

contentIds (
styleId (
position (2.pb.PBVector3"A
SceneMessageCreateAck(

newMessage (2.pb.SceneMessageInfo"*
SceneMessageDeleteReq
	messageId ("
SceneMessageDeleteAck"9
SceneMessageLikeReq
	messageId (
emojiId ("
SceneMessageLikeAck"
MessageBoardRefreshReq"™
MessageBoardRefreshAckD
ownedMessages (2-.pb.MessageBoardRefreshAck.OwnedMessagesEntryJ
OwnedMessagesEntry
key (#
value (2.pb.SceneMessageInfo:8"'
SceneMessageSetReq
	isRefresh ("
SceneMessageSetAckbproto3
´
mission.protopbcommon.proto":
MissionUpdateStateReq!
mission (2.pb.MissionState"2
MissionUpdateStateAck
rewards (2.pb.Item"
AcceptMissionReq

id ("4
AcceptMissionAck

ok (
errorMessage (	"/

MissionNtf!
mission (2.pb.MissionState""
MissionMonsterDieReq

id ("
MissionMonsterDieAck">
MissionUpdateBluePrintReq!
mission (2.pb.MissionState"
MissionUpdateBluePrintAck">
MissionApplyItemReq
	missionId (
collectionId (".
MissionApplyItemAck
items (2.pb.Item"}
MissionRNtf/
missions (2.pb.MissionRNtf.MissionsEntry=
MissionsEntry
key (
value (2.pb.MissionR:8"É
NewMissionRNtf2
missions (2 .pb.NewMissionRNtf.MissionsEntry=
MissionsEntry
key (
value (2.pb.MissionR:8"s
MissionStateUpdateNtf
	missionID (#
state (2.pb.MissionStateEnum"
rewards (2.pb.UniversalItem"O
MissionStateUpdateReq
	missionID (#
state (2.pb.MissionStateEnum"
MissionStateUpdateAck"e
MissionConditionStateNtf
	missionID (
conditionID (
progress (
success ("p
%MissionConditionActionPairCompleteNtf
	missionID (
pairIdx (#
state (2.pb.MissionStateEnum"T
MissionConditionUpdateReq
	missionID (
conditionID (
success ("
MissionConditionUpdateAck"J
MissionFlowCompleteNtf
	missionID (
flow (2.pb.MissionFlow"H
MissionFlowUpdateNtf
	missionID (
flow (2.pb.MissionFlow"%
MissionAcceptReq
	missionID ("
MissionAcceptAck")
MissionExpireNtf
missionIDList ("-
ReplacMissionTrackingReq
	missionID ("
ReplacMissionTrackingAck"'
MissionTrackingNtf
	missionID ("&
MissionRAcceptReq
	missionID ("
MissionRAcceptAck"p
MissionRUpdateFlowReq
	missionID (
flow (2.pb.MissionFlow%
flowType (2.pb.MissionFlowType"6
MissionRUpdateFlowAck
flow (2.pb.MissionFlow"í
MissionRConditionUpdateReq
	missionID (
	flowIndex ('
	condition (2.pb.TriggerCondition%
flowType (2.pb.MissionFlowType"
MissionRConditionUpdateAck"ö
MissionRActionUpdateReq
	missionID (
	flowIndex (
pairIdx (!
action (2.pb.TriggerAction%
flowType (2.pb.MissionFlowType"
MissionRActionUpdateAck"P
MissionRUpdateStateReq
	missionID (#
state (2.pb.MissionStateEnum"<
MissionRUpdateStateAck"
rewards (2.pb.UniversalItembproto3
õP
player.protopbcommon.proto"&
ChangeWorldLevelReq
toLevel ("X
ChangeWorldLevelAck

ok (
changeTS (#
gotItems (2.pb.UniversalItem"4
ChangeSkinReq
characterId (
skinId ("4
ChangeSkinAck
characterId (
skinId (")

SkinAddNtf
skins (2.pb.SkinInfo"*
SkinSyncNtf
skins (2.pb.SkinInfo"P
ChangeEffectDressReq
characterId (
effectDressId (
wear ("B
ChangeEffectDressAck
characterId (
effectDressId ("?
EffectDressAddNtf*
effectDresses (2.pb.EffectDressInfo"@
EffectDressSyncNtf*
effectDresses (2.pb.EffectDressInfo"L
OperationTimeStampsNtf
changeWorldLevelTS (
changeGenderTS ("X
Progress
type (2.pb.ProgressType

id (
rawData (
newData ("/
ProgressNtf 

progresses (2.pb.Progress"I
GachaQueryHistoryReq#
poolType (2.pb.GachaPoolType
page ("`
GachaQueryHistoryAck
code ('
	pageItems (2.pb.GachaHistoryItem
	totalPage ("0
GachaCardDrawReq
pooId (
count ("≥
GachaCardDrawItem
poolItem (2.pb.Item
	extraItem (2.pb.Item!
characterMaxConstellation (
tiggeredFirstGuaranteed (!
triggeredTargetGuaranteed ("I
GachaCardDrawAck
code ('
gotItems (2.pb.GachaCardDrawItem"Ë
GachaPoolDataNtf-
poolShareData (2.pb.GachaPoolShareData@
poolUniqueData (2(.pb.GachaPoolDataNtf.PoolUniqueDataEntry
openPoolIds (N
PoolUniqueDataEntry
key (&
value (2.pb.GachaPoolUniqueData:8"E
GachaPoolEffectiveInfoNtf(
info (2.pb.GachaPoolEffectiveInfo"v
GachaPoolShareDataChangeNtf*

changeData (2.pb.GachaPoolShareData+

poolUnique (2.pb.GachaPoolUniqueData"B
GachaTargetSelectReq
gachaId (
targetGachaItemId ("C
GachaTargetSelectAck+

poolUnique (2.pb.GachaPoolUniqueData"'
GachaTargetCancelReq
gachaId ("C
GachaTargetCancelAck+

poolUnique (2.pb.GachaPoolUniqueData"F
GachaExchangeFinalGuaranteedReq
poolId (
gachaItemId ("<
GachaExchangeFinalGuaranteedAck
gotItem (2.pb.Item"5
"GachaExchangeAccumulativeRewardReq
bonusId ("=
"GachaExchangeAccumulativeRewardAck
items (2.pb.Item"1
GachaExchangeMilestoneRewardReq
poolId ("C
GachaExchangeMilestoneRewardAck 
items (2.pb.UniversalItem"5
GachaExchangeTicketReq
poolId (
num ("@
GachaExchangeTicketAck
code (
ticket (2.pb.Item",
DrawCardReq
poolId (
count ("ü
DrawCardAck
items (2.pb.Item.
gotItems (2.pb.DrawCardAck.DrawCardItemG
DrawCardItem
poolItem (2.pb.Item
	extraItem (2.pb.Item"7
DrawCardChooseItemReq
poolId (
itemId ("
DrawCardChooseItemAck"
PowerBuyReq" 
PowerBuyAck
	canBuyNum ("&
AchievementTakeRewardReq

id ("3
AchievementTakeRewardAck
items (2.pb.Item",
AchievementTakeGroupRewardReq
gid ("8
AchievementTakeGroupRewardAck
items (2.pb.Item"<
 AchievementRecordFightTypeCntReq
typ (
cnt (""
 AchievementRecordFightTypeCntAck"J
AchievementSyncInfoReq0
achievementInfo (2.pb.AchievementSyncInfo"
AchievementSyncInfoAck"$
AchievementCompleteReq

id (",
AchievementCompleteAck

completeTS ("F
AchievementChangeTagReq

id (
tag (2.pb.AchievementTag"
AchievementChangeTagAck"V
 AchievementRecordConversationReq
keys ($
op (2.pb.RecordConversationOP""
 AchievementRecordConversationAck"ô
&AchievementRecordConversationOptionReqB
data (24.pb.AchievementRecordConversationOptionReq.DataEntry+
	DataEntry
key (
value (:8"(
&AchievementRecordConversationOptionAck"8
AchievementNtf&
achievements (2.pb.Achievements"'
AchievementRewardReq
groupId ("8
AchievementRewardAck 
items (2.pb.UniversalItem",
AchievementGroupRewardReq
groupId ("=
AchievementGroupRewardAck 
items (2.pb.UniversalItem"J
AchievementInfoNtf4
achievementData (2.pb.AchievementProgressData"b
CookReq
	mainItems (2.pb.Item

minorItems (2.pb.Item
cookWay (2.pb.CookWay"P
CookAck
relatedMenu (
unlockedMenu (
buff (2.pb.FoodBuff"$
CookResetMinorBuffReq
idx ("3
CookResetMinorBuffAck
buff (2.pb.FoodBuff"R
CookSaveCustomMenuReq
menu (2.pb.CookMenu
idx (
fromBuff ("
CookSaveCustomMenuAck"8
CookModifyCustomMenuNameReq
name (	
idx ("
CookModifyCustomMenuNameAck"#
CookDelCustomMenuReq
idx ("
CookDelCustomMenuAck"!
CookNtf
info (2.pb.Cook"‡
SyncGameInfoReq
position (2.pb.PBVector3,
characterInfo (2.pb.CharacterSyncInfo
playingMusic (0
achievementInfo (2.pb.AchievementSyncInfo*
mapViewLogInfo (2.pb.MapViewLogInfo8
littleItemsShortcut (2.pb.LittleItemsShortcutInfo
chunkId (
wid (2
mapViewRecordParam	 (2.pb.MapViewRecordParam"
SyncGameInfoAck"(
SyncSettingOptionsReq
content (	"
SyncSettingOptionAck"-
RedPointSetReq
info (2.pb.RedPoints"
RedPointSetAck"*
RedPointNtf
info (2.pb.RedPoints"6
ItemGotLogsNtf$
itemGotLogs (2.pb.ItemGotLogs"0
GuideLogsNtf 
	guideLogs (2.pb.GuideLogs"Ç
GuideChangeNtf0
changed (2.pb.GuideChangeNtf.ChangedEntry>
ChangedEntry
key (
value (2.pb.GuideState:8"4
GuideLogsInterfaceReq
group (
step ("
GuideLogsInterfaceAck"
GuideTriggerReq

id ("
GuideTriggerAck"
GuideReadReq
ids (")
GuideReadAck
rewards (2.pb.Item"
GuideUnlockReq

id ("
GuideUnlockAck

id ("
GuideCompleteReq

id ("
GuideCompleteAck

id ("0
DailyDataNtf 
	dailyData (2.pb.DailyData"G
NotifyCollectionItemLimitNtf'
items (2.pb.NotifyCollectionItem"%
ChangeNickNameReq
nickName (	"1
ChangeNickNameAck

ok (
nickName (	" 
PublicChatReq
message (	"
PublicChatAck"b
PublicChatNtf

id (
nickname (	
level (
curAvatarId (
message (	"9
AnswerQuestionReq

questionId (
optionId ("?
AnswerQuestionAck
correct (
reward (2	.pb.Items"7
AnswerQuestionsNtf!
data (2.pb.AnswerQuestions"G
FriendOperateReq&
	operation (2.pb.FriendOperation
uid ("3
FriendOperateAck
info (2.pb.FriendProfile"
FriendSearchReq
uid ("2
FriendSearchAck
info (2.pb.FriendProfile"'

FriendsNtf
data (2.pb.Friends"

DestroyReq"

DestroyAck"[
SceneSwitchReq
wid (
position (2.pb.PBVector3
cid (
areaId ("
SceneSwitchAck"[
ChunkSwitchReq
cid (
position (2.pb.PBVector3
wid (
areaId ("
ChunkSwitchAck"C
SceneWorldLayerSwitchReq'

worldLayer (2.pb.SceneWorldLayer"C
SceneWorldLayerSwitchAck'

worldLayer (2.pb.SceneWorldLayer"Õ
QuestionnaireNtf-
questionnaires (2.pb.QuestionnaireInfo/
newQuestionnaire (2.pb.QuestionnaireInfo,
read (2.pb.QuestionnaireNtf.ReadEntry+
	ReadEntry
key (
value (:8"#
QuestionnaireReadReq
ids ("
QuestionnaireReadAck" 
RedeemCodeUseReq
code (	"
RedeemCodeUseAck"•
OperationalActivityNtf<
	activitys (2).pb.OperationalActivityNtf.ActivitysEntryM
ActivitysEntry
key (*
value (2.pb.OperationalActivityInfo:8"≠
OperationalActivityDataNtf@
	activitys (2-.pb.OperationalActivityDataNtf.ActivitysEntryM
ActivitysEntry
key (*
value (2.pb.OperationalActivityData:8".
TipNoticeNtf
notices (2.pb.TipNotice"
ClientUpdateNtf"<
NewNoticeNtf
type (

id (

displayPos ("4
AssistantNpcHelpReq
npc (2.pb.AssistantNpc"
AssistantNpcHelpAck"'
AssistantNpcFinishReq
npcIds ("
AssistantNpcFinishAck"1
AssistantNpcNtf
npcs (2.pb.AssistantNpc"M
LeaderboardQueryReq
typ (

id (
startPos (
num ("-
LeaderboardQueryAck
rank (2.pb.Rank"A
LeaderboardQueryMemberReq
typ (

id (
uid (";
LeaderboardQueryMemberAck
selfInfo (2.pb.RankInfo"
TaskNtf
changes (2.pb.Task)
targets (2.pb.TaskNtf.TargetsEntry.
TargetsEntry
key (
value (:8".
TaskGroupNtf
changes (2.pb.TaskGroup"j
TempArchiveUpdateReq+
	operation (2.pb.TempArchiveOperation%
syncData (2.pb.SyncGameInfoReq"
TempArchiveUpdateAck"≥
ClientModuleComponentStateNtfE

components (21.pb.ClientModuleComponentStateNtf.ComponentsEntryK
ComponentsEntry
key ('
value (2.pb.ClientComponentState:8"◊
/ClientModuleClientModuleComponentStateChangeNtfW

components (2C.pb.ClientModuleClientModuleComponentStateChangeNtf.ComponentsEntryK
ComponentsEntry
key ('
value (2.pb.ClientComponentState:8"'
GoodsNtf
goods (2.pb.PayGoods"*
AddGoodsNtf
goods (2.pb.PayGoods"
DelGoodsNtf
goodsIds ("D
TipsNtf
errCode (	(
overflowItems (2.pb.UniversalItem"
PowerInfoQueryReq":
PowerInfoQueryAck
power (
powerRecoverTs ("M
NotifyCollectionItem
itemId (
limit (
destoryedCount ("
ReviewPromptNtf"
ReviewPromptDisplayedReq"
ReviewPromptDisplayedAck"[
PlayerDeadReq
position (2.pb.PBVector3
chunkId (
createBloodstain (";
PlayerDeadAck*
bloodstainInfo (2.pb.BloodstainInfo"ë
BloodStainNotify
chunkId (#
bloodstains (2.pb.Bloodstain&
selfBloodstain (2.pb.Bloodstain
otherBloodstainDisabled ("(
SetBloodStainEnableReq
enable ("D
SetBloodStainEnableAck*
bloodstainInfo (2.pb.BloodstainInfo"-
BloodStainInteractReq
bloodstainId (	"g
BloodStainInteractAck"
rewards (2.pb.UniversalItem*
bloodstainInfo (2.pb.BloodstainInfo"4
PowerExchangeReq
powerNum (
itemId ("6
PowerExchangeAck"
rewards (2.pb.UniversalItem*
ProgressType
ITEM *N
RecordConversationOP
RecordConversationAdd 
RecordConversationReset*4
FriendOperation

ADD_FRIEND 
DELETE_FRIEND*a
TempArchiveOperation	
Start 

Update
DropCurrentStage
DropAllStage

Finishbproto3
’	
profile.protopbcommon.proto"3
RecordLastPosReq
position (2.pb.PBVector3"
RecordLastPosAck"5
RecordSpawnPosReq 
info (2.pb.SceneSpawnInfo"
RecordSpawnPosAck"@
RecordTmpArchivePosReq&
info (2.pb.SceneTempArchiveInfo"
RecordTmpArchivePosAck" 
RecordCheckPosReq
uid ("
RecordCheckPosAck"(
EscModifyNicknameReq
nickname (	"
EscModifyNicknameAck"*
EscModifySignatureReq
	signature (	"
EscModifySignatureAck"&
EscModifyAvatarReq
avatarId ("
EscModifyAvatarAck"$
EscAvatarNtf
getAvatarIds ("0
EscModifyAvatarFrameReq
avatarFrameId ("
EscModifyAvatarFrameAck".
EscAvatarFrameNtf
getAvatarFrameIds ("$
EscModifyTitleReq
titleId ("
EscModifyTitleAck""
EscTitleNtf
getTitleIds ("5
EscModifyShowCharacterReq
showCharacterIds ("
EscModifyShowCharacterAck"$
SavePlayingMusicReq
music ("
SavePlayingMusicAck"#
QueryUserProfileReq
uids (">
QueryUserProfileAck'
profiles (2.pb.NormalUserProfile"!
ChangeGenderReq
gender ("°
ChangeGenderAck
curAvatarId (5
	avatarIds (2".pb.ChangeGenderAck.AvatarIdsEntry
changeTS (0
AvatarIdsEntry
key (
value (:8bproto3
ñ	

raid.protopbcommon.proto"S
RaidEnterReq

id (
team (2.pb.TeamUsage
rate (
byGM ("q
RaidEnterAck
transNo (	4
characterRepository (2.pb.CharacterRepository
raidInfo (2.pb.Raid"=
RaidRechallengeReq'

settleInfo (2.pb.StageSettleInfo"w
RaidRechallengeAck
transNo (	4
characterRepository (2.pb.CharacterRepository
raidInfo (2.pb.Raid"
RaidPlayerDeadReq"/
RaidPlayerDeadAck
raidInfo (2.pb.Raid"Q
RaidTakeRewardsReq

rewardRate ('

settleInfo (2.pb.StageSettleInfo"n
RaidTakeRewardsAck
items (2.pb.Item#
gotItems (2.pb.UniversalItem
raidInfo (2.pb.Raid"'
RaidSweepReq

id (
num ("h
RaidSweepAck
items (2.pb.Item
raidInfo (2.pb.Raid#
gotItems (2.pb.UniversalItem"7
RaidLeaveReq'

settleInfo (2.pb.StageSettleInfo"*
RaidLeaveAck
raidInfo (2.pb.Raid"9
RaidFailureReq'

settleInfo (2.pb.StageSettleInfo",
RaidFailureAck
raidInfo (2.pb.Raid"É
RaidNtf%
raids (2.pb.RaidNtf.RaidsEntry
challengingRaidId (6

RaidsEntry
key (
value (2.pb.Raid:8bproto3
Ä
recipe.protopbcommon.proto"*
RecipeMakeReq

id (
count ("*
RecipeMakeAck
changes (2.pb.Itembproto3
ä
rogue.protopbcommon.proto"0
RogueInfoNtf 
	RogueInfo (2.pb.RogueInfo".
RogueUnlockTalentTreeCodeReq
coreId ("
RogueUnlockTalentTreeCodeAck".
RogueUpdateTalentTreeNodeReq
nodeId ("
RogueUpdateTalentTreeNodeAck"i
RogueChallengeReq
modeId (
coreId (&
battleCharacter (2.pb.TeamUsage
seed ("8
RogueChallengeAck#
gameInfo (2.pb.RogueGameInfo"¯
RogueEnterNextRoomReq#
roomType (2.pb.RogueRoomType1
item (2#.pb.RogueEnterNextRoomReq.ItemEntry7
leftUse (2&.pb.RogueEnterNextRoomReq.LeftUseEntry=

battleInfo (2).pb.RogueEnterNextRoomReq.BattleInfoEntry=

effectInfo (2).pb.RogueEnterNextRoomReq.EffectInfoEntry:
	ItemEntry
key (
value (2.pb.RogueItem:8.
LeftUseEntry
key (
value (:81
BattleInfoEntry
key (
value (:81
EffectInfoEntry
key (
value (:8"J
RogueEnterNextRoomAck
coin (#
roomInfo (2.pb.RogueRoomInfo"\
RogueBuyItemReq
isBuy (
itemId (
	isReplace (
replacePosition ("
RogueBuyItemAck"%
RogueRecycleItemReq
itemId ("
RogueRecycleItemAck"
RogueHangGameReq"
RogueHangGameAck"
RogueContinueGameReq"ﬂ
RogueContinueGameAck0
battleCharacter (2.pb.CharacterRepository
	rougeTeam (2.pb.Team8
bagItems (2&.pb.RogueContinueGameAck.BagItemsEntry>
BagItemsEntry
key (
value (2.pb.RogueItem:8"=
RogueFinishGameReq'

finishType (2.pb.RogueFinishType"s
RogueFinishGameAck
talentTreePoint (
items (2.pb.Item
clearedMode (
weeklyCoinGain ("
RogueCoinRewardReq"
RogueCoinRewardAck"@
RogueCoinNtf
coin (
gainCoin (
costCoin ("1
RogueTeamChangeReq
team (2.pb.TeamUsage"@
RogueTeamChangeAck*
	rogueTeam (2.pb.CharacterRepository"P
RoguePickUpItemReq
itemId (
	isReplace (
replacePosition ("
RoguePickUpItemAck"4
RogueModifyCoinReq
isAdd (
coinNum ("
RogueModifyCoinAck"
RogueSetRoomFinishedReq"
RogueSetRoomFinishedAck"=
RogueTalentTreeNtf'

talentTree (2.pb.RogueTalentTree"(
RogueEnterRoomReq
gameWorldId ("8
RogueEnterRoomAck#
gameInfo (2.pb.RogueGameInfo"9
RogueGmNextRoomReq#
roomType (2.pb.RogueRoomType"9
RogueGmNextRoomAck#
roomInfo (2.pb.RogueRoomInfo"#
RogueGmAddItemReq
itemId ("
RogueGmAddItemAckbproto3
Ë

shop.protopbcommon.proto"h
ShopNtf%
shops (2.pb.ShopNtf.ShopsEntry6

ShopsEntry
key (
value (2.pb.Shop:8"_
ShopBuyCommodityReq
shopId (

subShopIdx (
commodityIdx (
buyNum (":
ShopBuyCommodityAck#
gotItems (2.pb.UniversalItem"6
DiamondDataNtf$
diamondData (2.pb.DiamondData"3
BundleDataNtf"

bundleData (2.pb.BundleData"%
ExchangeFreeDiamondReq
num ("
ExchangeFreeDiamondAck"N
ExchangeCommodityReq
commodityId (
indexs (
	subShopId (";
ExchangeCommodityAck#
gotItems (2.pb.UniversalItembproto3
ı
system.protopbcommon.proto"
SystemOpenReq

id ("
SystemOpenAck

id ("9
SystemOpenNtf
openSystems (
readSystems ("
SystemReadDoneReq

id ("
SystemReadDoneAck

id ("6
SystemTakeLevelRewardReq
level (
all ("3
SystemTakeLevelRewardAck
items (2.pb.Item"4
SystemGuideTakeChapterRewardReq
	chapterId ("F
SystemGuideTakeChapterRewardAck#
gotItems (2.pb.UniversalItem"∑
SystemTakeLevelRewardNtf
levels (P
systemGuideChapter (24.pb.SystemTakeLevelRewardNtf.SystemGuideChapterEntry9
SystemGuideChapterEntry
key (
value (:8"4
SystemStatusNtf!
systems (2.pb.SystemStatus"9
SystemStatusChangeNtf 
system (2.pb.SystemStatusbproto3
∫

team.protopbcommon.proto"-
TeamInfoNtf
teamInfo (2.pb.TeamInfo"d
ReplacePresetTeamReq
idx (
team (2.pb.TeamUsage"

presetTeam (2.pb.PresetTeam"
ReplacePresetTeamAck"H
SavePresetTeamsReq
teams (2.pb.PresetTeam
mainTeamIdx ("
SavePresetTeamsAck"4
ModifyPresetTeamNameReq
idx (
name (	"
ModifyPresetTeamNameAck"
DelPresetTeamReq
idx ("
DelPresetTeamAck""
RecordBattleTeamReq
idx ("
RecordBattleTeamAck"H
UpdateUsageTeamReq
	sceneEnum (
newUsage (2.pb.TeamUsage"z
UpdateUsageTeamAck
	sceneEnum (
teams (2.pb.TeamList4
characterRepository (2.pb.CharacterRepositorybproto3
ì	
temple.protopbcommon.proto"#
TempleUnlockReq
templeId ("1
TempleUnlockAck

templeInfo (2
.pb.Temple"C
TempleChallengeReq
templeId (
team (2.pb.TeamUsage"{
TempleChallengeAck
transNo (	4
characterRepository (2.pb.CharacterRepository

templeInfo (2
.pb.Temple"?
TempleRechallengeReq'

settleInfo (2.pb.StageSettleInfo"}
TempleRechallengeAck
transNo (	4
characterRepository (2.pb.CharacterRepository

templeInfo (2
.pb.Temple"9
TempleLeaveReq'

settleInfo (2.pb.StageSettleInfo"
TempleLeaveAck"A
TempleCompleteStageReq'

settleInfo (2.pb.StageSettleInfo"w
TempleCompleteStageAck
rewards (2.pb.Item
newInfo (2
.pb.Temple%

gotRewards (2.pb.UniversalItem";
TempleFailureReq'

settleInfo (2.pb.StageSettleInfo"2
TempleFailureAck

templeInfo (2
.pb.Temple"5
TempleSelectBuffReq
roomId (
buffId ("
TempleSelectBuffAck":
TempleTakeStarRewardReq
areaId (
starNum ("\
TempleTakeStarRewardAck
rewards (2.pb.Item&
templeAreaInfo (2.pb.TempleArea"-
TempleInfoNtf
info (2.pb.TempleInfobproto3
ı
trainingground.protopbcommon.proto"?
TrainingGroundEnterReq%

sceneParam (2.pb.ScenePosParam"N
TrainingGroundEnterAck4
characterRepository (2.pb.CharacterRepository"
TrainingGroundLeaveReq"
TrainingGroundLeaveAckbproto3
á
vocabulary.protopbcommon.proto"Ó
VocabularyNtf5

GroupState (2!.pb.VocabularyNtf.GroupStateEntry9
ContentState (2#.pb.VocabularyNtf.ContentStateEntry7
ContentInfo (2".pb.VocabularyNtf.ContentInfoEntry1
GroupStateEntry
key (
value (:83
ContentStateEntry
key (
value (:8J
ContentInfoEntry
key (%
value (2.pb.TextLibraryContent:8",
VocabularyUnlockContentReq
idList ("¢
VocabularyUnlockContentAckB

GroupState (2..pb.VocabularyUnlockContentAck.GroupStateEntryF
ContentState (20.pb.VocabularyUnlockContentAck.ContentStateEntryD
ContentInfo (2/.pb.VocabularyUnlockContentAck.ContentInfoEntry1
GroupStateEntry
key (
value (:83
ContentStateEntry
key (
value (:8J
ContentInfoEntry
key (%
value (2.pb.TextLibraryContent:8"*
VocabularyReadContentReq
idList ("•
VocabularyReadContentAckD
ContentState (2..pb.VocabularyReadContentAck.ContentStateEntryB
ContentInfo (2-.pb.VocabularyReadContentAck.ContentInfoEntry3
ContentStateEntry
key (
value (:8J
ContentInfoEntry
key (%
value (2.pb.TextLibraryContent:8"ù
VocabularyRememberGroupStateReqG

GroupState (23.pb.VocabularyRememberGroupStateReq.GroupStateEntry1
GroupStateEntry
key (
value (:8"!
VocabularyRememberGroupStateAckbproto3
º
weapon.protopbcommon.proto"^
	WeaponNtf
changes (2
.pb.Weapon

removeUids ( 
	changeWay (2.pb.ItemsWays"1
WeaponWearReq
uid (
characterId ("
WeaponWearAck"*
WeaponLockReq
uid (
lock ("
WeaponLockAck"V
WeaponLevelUpReq
uid (
spendWeaponUids (

spendItems (2.pb.Item"-
WeaponLevelUpAck
changes (2.pb.Item"
WeaponStageReq
uid ("+
WeaponStageAck
changes (2.pb.Item"0
WeaponRefineReq
uid (
spendUid (",
WeaponRefineAck
changes (2.pb.Itembproto3
„
wildboss.protopbcommon.proto"2
WildBossTakeRewardReq
interactionObjUID (">
WildBossTakeRewardAck%

gotRewards (2.pb.UniversalItem"(
WildBossRewardBoughtReq
count ("
WildBossRewardBoughtAckbproto3
≤

dbuser.protopbcommon.proto"ı	
DBUser

id (
	accountId (
serverIndex (
openId (	
sdkAid (

createTime (
lastUpdateTime (
	enterTime (
offlineTime	 (
level
 (
exp (

worldLevel (
nickName (	
coin (
power (
freeDiamond (
costDiamond (
gender (.
tookLevelRewards (2.pb.TookLevelRewards(
openedSystems (2.pb.OpenedSystems
items (2	.pb.Items"

attributes (2.pb.Attributes"

characters (2.pb.Characters
weapons (2.pb.Weapons
chips (2	.pb.Chips
	handbooks (2.pb.Handbook
missions (2.pb.Missions
assists (2.pb.Assists
scenes (2
.pb.Scenes"
profile (2.pb.PlayerProfile
equips (2
.pb.Equips
gems  (2.pb.Gems*
composeData! (2.pb.PlayerComposeData
mapInfo" (2.pb.MapDbModel%

loungeInfo# (2.pb.LoungeDbModel)

battlePass$ (2.pb.BattlePassDbModel-
vocabularyInfo% (2.pb.VocabularyDbModel(
td_client_data& (2.pb.TDClientData*
timeLimitItems' (2.pb.TimeLimitItems
skins( (2.pb.SkinInfo$
diamondData) (2.pb.DiamondData"

bundleData* (2.pb.BundleData,
monthly_passes+ (2.pb.MonthlyPassEntry*
effectDresses, (2.pb.EffectDressInfoB™ACT.Game.Databproto3
˚

user.protopbcommon.protodbuser.proto"õ
DBBriefUser

id (
serverIndex (
openId (	

createTime (
nickName (	
level (
offlineTime (
	accountId ("%
UserList
users (2
.pb.DBUser"<
QueryUserByAccountIdReq
	accountId (
dbName (	"6
QueryUserByOpenIdReq
openId (	
dbName (	"6
QueryUserBySDKAidReq
sdkAid (
dbName (	"E
QueryUserRsp
error (2.pb.ErrorAck
user (2
.pb.DBUser"7
SaveUserReq
user (2
.pb.DBUser
dbName (	"@
SaveUserRsp
error (2.pb.ErrorAck
affectedRows (B™ACT.Game.Databproto3