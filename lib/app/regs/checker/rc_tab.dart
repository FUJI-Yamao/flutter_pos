/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース: rc_tab.h - #define
class TabDef {
  static const DATA_DSP = 0;
  static const DATA_CLR = 1;
}

// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
///関連tprxソース: rc_tab.h - TAB_INFO
class TabInfo {
  int dspTab = 0;
  int nextDspTab = 0;
  int tabCounter = 0;
  int tabDataDsp = 0;
  int saveDspTab = 0;		// save tab number (use of [tab display <-> no tab display] )
  int tabStep = 0;		// tab step 0: Suspend -> 1: Resume
  int dspPixNum = 0;
  String skinName = '';		// tab skin image name
  String iconName = '';		// tab icon image name
}

///関連tprxソース: rc_tab.h - TAB_SAVE_DATA
class TabSaveData {
  int pixNum = 0;
  int counter = 0;
  int ttlAmt = 0;
  int ttlQty = 0;
  String  fileName = "";
  String mbrCd = "";
  String mbrName = "";
  int dspMode = 0;
  int chkrNo = 0;
  int cshrNo = 0;
  String preRcpfmFlg = "";		// 領収書宣言保持フラグ
  int cinAmt = 0;
}

///関連tprxソース: rc_tab.h - FIP_INFO
class FipInfo {
  int fipCounter = 0;
  int fipDspCnt = 0;
  late List<FipNum> fipNum = List.generate(TabNum.MaxTab.num, (_) => FipNum());
  int selectFip = 0;
  late List<FipTData> fipTData = List.generate(TabNum.MaxTab.num, (_) => FipTData());
  int lastDspFipNo = 0;		// last disp fip number
}

///関連tprxソース: rc_tab.h - FIP_NUM
class FipNum {
  int tabNum = 0;
  String fipBackName = '';
  String fipIconName = '';
}

///関連tprxソース: rc_tab.h - FIP_TDATA
class FipTData {
  int fipNo = 0;
}

///関連tprxソース: rc_tab.h - TAB_NUM
enum TabNum {
  firstTab(1),
  SecondTab(2),
  ThirdTab(3),
  MaxTab(4);

  final int num;
  const TabNum(this.num);
}

///関連tprxソース: rc_tab.h - TAB_STEP
enum TabStep {
  TabStepS(1),	//Suspend
  TabStepR(2),	//Resume
  TabStepE(3);	//End

  final int num;
  const TabStep(this.num);
}