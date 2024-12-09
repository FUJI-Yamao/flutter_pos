/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'package:collection/collection.dart';

import '../../inc/sys/tpr_ipc.dart';

/// 釣銭機からの受信データ
class ChangerDataReceiveResult {
    TprMsgDevNotify2_t msg = TprMsgDevNotify2_t();
    ChangerDataReceiveResult(this.msg);
}

/// 関連tprxソース: \inc\lib\if_acx.h - define
class IfAcxDef {
  static const MSG_ACROK = 0;   /* Normal End */
  static const MSG_INPUTERR = 1;  /* Inpur Error */
  static const MSG_ACRFLGERR = 2;   /* Flag Error */
  static const MSG_FILEUPDATEERR = 3;  /* File Update Error */
  static const MSG_ACRACT  = 4;  /* SUB (Busy) */
  static const MSG_SETTEINGERR = 5;   /* DC3 (Setting Error) */
  static const MSG_CHARGING = 6;  /* DC4 (in progress) */
  static const MSG_ACRLINEOFF = 7;  /* Lineoff (not connected) */
  static const MSG_ACRERROR = 8;  /* Illegal Response */
  static const MSG_ACRCAN = 9;   /* CAN (Abnornal End) */
  static const MSG_ACRNAK = 10;  /* NAK (Not Ack) */
  static const MSG_ACTTMOUT = 11;  /* TIME OUT */
  static const MSG_ACRDATAERR = 12;  /* Terminal Data Error */
  static const MSG_ACRSENDERR = -1;  /* Send Error */
  static const MSG_ACRCMDERR = -2;  /* Command Send Error */
  static const MSG_ACRNOTOPEN = -3;  /* Device not open */

/*--------------------------------------------------------------------------*/
/*    Command Definition                                                    */
/*--------------------------------------------------------------------------*/
  static const ACR_RESET             = '\x30';       //0x30
  static const ACR_COINOUT           = '\x31';       //0x31
  static const ACR_INSPECT           = '\x32';       //0x32
  static const ACR_CLEAR             = '\x33';       //0x33
  static const ACR_MEMREAD           = '\x34';       //0x34
  static const ACR_SPECOUT           = '\x35';       //0x35
  static const ACR_CONNECTMODE       = '\x36';       //0x36
  static const ACR_DATETIMESET       = '\x37';       //0x37
  static const ACR_PICKUP            = '\x38';       //0x38
  static const ACR_SSWSET            = '\x3A';       //0x3A
  static const ACR_STATEREAD         = '\x3B';       //0x3B
  static const ACR_SSWSET2           = '\x3F';       //0x3F
  static const ACR_CINREAD           = '\x41';       //0x41
  static const ACR_CINSTART          = '\x45';       //0x45
  static const ACR_CINEND            = '\x46';       //0x46
  static const ACR_CINSTOP           = '\x47';       //0x47
  static const ACR_CINRESTART        = '\x48';       //0x48
  static const ACR_CALCLATEMODE      = '\x49';       //0x49
  static const ACR_LOCALOPEBAN       = '\x4C';       //0x4C
  static const ACR_DRWOPEN           = '\x50';       //0x50
  static const ACR_CLOSE             = '\x52';       //0x52
  static const ACR_COININSERT        = '\x53';       //0x53
  static const ACR_MENTE_IN          = '\x54';       //0x54
  static const ACR_MENTE_OUT         = '\x55';       //0x55
  static const ACR_MENTE_SPECOUT     = '\x56';       //0x56
  static const ACR_OUTERR_IN         = '\x57';       //0x57
  static const ACR_CLOSE_DATAREAD    = '\x59';       //0x59
  static const ECS_CINSTART          = '\x46';       //0x46
  static const ECS_STATEREAD         = '\x48';       //0x48
  static const ECS_CALCLATEMODE      = '\x49';       //0x49
  static const ECS_DOWNLOAD          = '\x4D';       //0x4D
  static const ECS_PROGRAMLOAD       = '\x4E';       //0x4E
  static const ECS_ENDDOWNLOAD       = '\x4F';       //0x4F
  static const ECS_CINCONTINUE       = '\x50';       //0x50
  static const ECS_OPESET            = '\x51';       //0x51
  static const ECS_SETTINGREAD       = '\x57';       //0x57
  static const ECS_VERREAD           = '\x5A';       //0x5A
  static const ECS_DRWREAD           = '\x5B';       //0x5B
  static const ECS_DRWOPEN           = '\x5C';       //0x5C
  static const ECS_CINEND            = '\x5F';       //0x5F
  static const ECS_RECALC            = '\x66';       //0x66
  static const ECS_LOGREAD           = '\x6A';       //0x6A
  static const ECS_COINOUT6DIGIT     = '\x6D';       //0x6D
  static const ECS_CINREAD           = '\x6F';       //0x6F
  static const ECS_PICKUP            = '\x70';       //0x70
  static const ECS_DATETIMESET       = '\x72';       //0x72
  static const ECS_SPEEDCHG          = '\x7D';       //0x7D
  static const ECS_MODELREAD         = '\x3A';       //0x3A
  static const ECS_PAYOUTREAD        = '\x71';       //0x71
  static const SST1_STATEREAD        = '\x3B';       //0x3B
  static const SST1_CINCANCEL        = '\x4A';       //0x4A
  static const SST1_LOGREAD          = '\x4B';       //0x4B
  static const SST1_DATETIMESET      = '\x4C';       //0x4C
  static const SST1_COINCLEAR        = '\x4D';       //0x4D
  static const SST1_FLGCLEAR         = '\x4E';       //0x4E
  static const SST1_CONNECTON        = '\x99';       //0x99
  static const FAL2_CINSTART         = '\x45';       //0x45
  static const FAL2_CINEND           = '\x80';       //0x80
  static const FAL2_STATESENSE       = '\x83';       //0x83
  static const FAL2_RASDATAGET       = '\x84';       //0x84
  static const FAL2_HOLDERSETREAD    = '\x86';       //0x86
  static const FAL2_STATESETREAD     = '\x87';       //0x87
  static const FAL2_IDSETREAD        = '\x88';       //0x88
  static const FAL2_LIFEDATACLEAR    = '\x89';       //0x89
  static const FAL2_VERREAD          = '\x8A';       //0x8A
  static const FAL2_LOCALLOGREAD     = '\x8B';       //0x8B
  static const FAL2_MEMREAD          = '\x8E';       //0x8E
  static const FAL2_BILLMODEWRITE    = '\x8F';       //0x8F
  static const FAL2_SENSORDATAREAD   = '\x90';       //0x90
  static const FAL2_SENSORADJUST     = '\x91';       //0x91
  static const FAL2_STOCKREAD        = '\x92';       //0x92
  static const FAL2_COININSERT       = '\x93';       //0x93
  static const FAL2_AUTOINSPECT      = '\x94';       //0x94
  static const FAL2_SHUTTERCONTROL   = '\x95';       //0x95
  static const FAL2_BUZZERCONTROL    = '\x96';       //0x96
  static const FAL2_SCLEANDATAGET    = '\x97';       //0x97
  static const RT300_LOGREAD         = '\x3D';       //0x3D

  /*--------------------------------------------------------------------------*/
/*	Auto Coin Changer Common Definition									                  	*/
/*--------------------------------------------------------------------------*/
  static const STX = 0x02;
  static const DC1 = 0x11;
  static const ETX = 0x03;
  static const ENQ = 0x05;
  static const DLE = 0x10;

  static const ACK = 0x06;
  static const NAK = 0x15;
  static const CAN = 0x18;		/* Abnormal End */
  static const ETB = 0x17;		/* Near End */
  static const DC3 = 0x13;
  static const SUB = 0x1A;		/* Active */
  static const BON = 0x1C;		/* Active */
  static const DC4 = 0x14;
  static const DC2 = 0x12;
  static const BEL = 0x07;

  /// 動作環境取得コマンド取得データ格納領域
  static const ECS_ENVSET_DATAGP_MAX = 32;
  static const ECS_ENVSET_DATA_MAX = 12;
}

/// 関連tprxソース: \inc\lib\if_acx.h - CBILLKIND
class CBillKind {
  int  bill10000 = 0;
  int  bill5000 = 0;
  int  bill2000 = 0;
  int  bill1000 = 0;
  int  coin500 = 0;
  int  coin100 = 0;
  int  coin50 = 0;
  int  coin10 = 0;
  int  coin5 = 0;
  int  coin1 = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - CBILLFULL
class CBillFull {
  int  rjctfull = 0;
  int  csetfull = 0;
  int  actFlg = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - STOCKSTATE
class StockState {
  int  billFlg = 0;  /* 紙幣収納庫 0:確定／1:不確定 */
  int  coinFlg = 0;  /* 硬貨収納庫 0:確定／1:不確定 */
  int  billOverflow = 0;  /* 紙幣回収庫 0:確定／1:不確定 */
}

/// 関連tprxソース: \inc\lib\if_acx.h - COINDATA
class CoinData {
  CBillKind  holder = CBillKind();
  int  billrjct = 0;  /* リジェクト合計 */
  int  billrjctIn = 0;  /* 入金リジェクト */
  int  billrjctOut = 0;  /* 出金リジェクト */
  int  billrjct2000 = 0;  /* 二千券リジェクト */
  int  coinrjct = 0;
  CBillKind  overflow = CBillKind();
  CBillFull  billfull = CBillFull();
  int  coinslot = 0;
  StockState stockState = StockState();
  CBillKind  drawData = CBillKind();
  int  drawStat = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - ENUMDATA
class EnumData {
  String flag = '';
  int enumamt = 0;
  String crj = '';
  String brj = '';
}

/// 関連tprxソース: \inc\lib\if_acx.h
class CoinChanger {
  /*----------------------------------------------------------------------*/
  /*	Coin/Bill Changer or Coin Changer discrimination Definition		    	*/
  /*----------------------------------------------------------------------*/
  static const int ACR_COINBILL = 0x01;
  static const int ACR_COINONLY = 0x02;

  static const int LINEBUFSIZ = 260;

  static const int ACB_10 = 1;
  static const int ACB_20 = 2;
  static const int ACB_50_ = 4;
  static const int ECS = 8;
  static const int SST1 = 16;
  static const int ACB_200 = 32;
  static const int FAL2 = 64;
  static const int RT_300 = 128;
  static const int ECS_777 = 256;

  static const int RT_300_X	= RT_300;
  static const int ACB_200_X	= (ACB_200 + RT_300_X);
  static const int ACB_50_X	= (ACB_50_ + ACB_200_X);
  static const int ACB_20_X	= (ACB_20 + ACB_50_X);

  static const int ECS_X = (ECS + ECS_777);

  static const String ACX_OVERFLOW_MOV_FILE = "acx_overflow_mov.txt";
  static const String ACX_OVERFLOW_MOV_PATH = "/pj/tprx/tmp/acx_overflow_mov.txt";
  static const String ACX_OVERFLOW_LINE_LABEL = "****************************************";
  static const String ACX_OVERFLOW_TIME_LABEL = "time=";
  static const String ACX_OVERFLOW_TYPE_LABEL = "type=";
  static const String ACX_OVERFLOW_CNT_LABEL = "count=";
  static const String ACX_OVERFLOW_PRC_LABEL = "price=";
}

/// 関連tprxソース: \inc\lib\if_acx.h - ACXSTATUS
enum AcxStatus {
  CinEnd(0),
  CinStart(1),
  CinAct(2),
  CinWait(3),
  CinStop(4),
  CinReset(5);

  final int id;
  const AcxStatus(this.id);
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINDATA
class CinData {
  int bill10000 = 0;
  int bill5000 = 0;
  int bill2000 = 0;
  int bill1000 = 0;
  int coin500 = 0;
  int coin100 = 0;
  int coin50 = 0;
  int coin10 = 0;
  int coin5 = 0;
  int coin1 = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINFLG
class CinFlg {
	int cininfo = 0;
	int cinstopcom = 0;
	int device_state = 0;
	int billinfo = 0;
	int billdetail = 0;
	int coininfo = 0;
	int coindetail = 0;
	int opeflg = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - CININFO
class CinInfo {
    CinData cindata = CinData();
    CinFlg  cinflg = CinFlg();
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINSTART_ECS
class CinStartEcs {
	int total_sht = 1;          /* トータル枚数 0:クリアしない／1:クリアする */
	int auto_continue = 1;      /*自動継続 0:あり／1:なし */
	int suspention = 1;         /* 一時保留 0:しない／1:する */
	CinData reject = CinData();             /* 金種別リジェクト 0:しない／1:する */
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINREAD_ECS
class CinReadEcs {
	CinData cindata = CinData();		/* 入金枚数 */
	int reject_coin = 1;	/* 硬貨リジェクト 0:無し／1:有り */
	int reject_bill = 1;	/* 紙幣リジェクト 0:無し／1:有り */
}

/// 関連tprxソース: \inc\lib\if_acx.h - HOLDER_FLAG_LIST
// 釣機内の保留枚数の状態
enum HolderFlagList {
  HOLDER_NORMAL, // 問題なし
  HOLDER_EMPTY, // エンプティ
  HOLDER_NEAR_END, // ニアエンド
  HOLDER_NEAR_FULL, // ニアフル
  HOLDER_NEAR_FULL_BFR_ALERT, // ニアフル前警告（サインポール表示等）
  HOLDER_FULL, // フル
  HOLDER_NON, // エンプティ(ニアエンド設定0のため、不足していても問題ない扱い)
}

/// 関連tprxソース: \inc\lib\if_acx.h - COINBILL_KIND_LIST
// 各金種を表す
enum CoinBillKindList {
  CB_KIND_0(-1),
  CB_KIND_10000(0),
  CB_KIND_05000(1),
  CB_KIND_02000(2),
  CB_KIND_01000(3),
  CB_KIND_00500(4),
  CB_KIND_00100(5),
  CB_KIND_00050(6),
  CB_KIND_00010(7),
  CB_KIND_00005(8),
  CB_KIND_00001(9),
  CB_KIND_MAX(10);

  final int id;
  const CoinBillKindList(this.id);

  /// dlgIdから対応するFuncKeyを取得する.
  static CoinBillKindList getDefine(int id) {
    CoinBillKindList? define =
    CoinBillKindList.values.firstWhereOrNull((a) => a.id == id);
    define ??= CoinBillKindList.CB_KIND_0; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: \inc\lib\if_acx.h - HOLDER_DATA_FLG
// 各金種の保留枚数の状態を格納
class HolderDataFlg {
  int nearFullDiff = 0; // ニアフルチェック用枚数
  int qcNearFullDiff = 0; // ニアフルチェック用枚数(Qcashier)
  int qcSignpFullChk = 0; // ニアフルサインポールチェック用枚数(Qcashier)
  HolderFlagList simpleFlg = HolderFlagList.HOLDER_NORMAL; // 全体の保留枚数状態の簡易チェック用
  List<HolderFlagList> kindFlg = List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => HolderFlagList.HOLDER_NORMAL); // 各金種の保留枚数状態
  List<int> percentage = List.generate(CoinBillKindList.CB_KIND_MAX.id, (_) => 0); // 各金種の在高割合((収納枚数 * 100) / 最大保留枚数)
}

/// 富士電機用回収指示データ
/// 関連tprxソース: if_acx.h - PICK_ECS
class PickEcs {
  CBillKind cBillKind = CBillKind();	/* 金種別回収枚数
                                          0～999:枚数指定
                                          10000:回収残設定超枚数
                                          10001:全回収 */
  int coin = 1;			/* 硬貨 0:混合回収／1:金種別回収 */
  int bill = 1;			/* 紙幣 0:混合回収／1:金種別回収 */
  int leave = 1;		/* 金額残置回収 0:しない／1:する */
  int caset = 1;		/* 回収庫回収 0:しない／1:する */
}

/// 共通回収指示データ
/// 関連tprxソース: if_acx.h - PICK_DATA
class PickData {
  CBillKind cBillKind = CBillKind();  /* 金種別回収枚数	*/
  int coinMode = 0;  /* 硬貨回収方法 */
  int billMode = 0;  /* 紙幣回収方法 */
  int coin = 0;  /* 硬貨 0:混合回収／1:金種別回収 */
  int bill = 0;  /* 紙幣 0:混合回収／1:金種別回収 */
  int leave = 1;  /* 金額残置回収 0:しない／1:する */
}

/// 出金、回収データ
/// 関連tprxソース: if_acx.h - CHGOUT_DATA
class ChgOutData {
  int type = 0;		/* 0:出金 1:回収 */
  int price = 0;
  PickData data = PickData();		/* 回収の指示データ or 出金枚数データ */
}

/// 払出枚数リードコマンド
/// 関連tprxソース: if_acx.h - ECS_PAYOUT
class EcsPayout {
  int payoutBill10000 = 0;
  int payoutBill5000 = 0;
  int payoutBill2000 = 0;
  int payoutBill1000 = 0;
  int payoutCoin500 = 0;
  int payoutCoin100 = 0;
  int payoutCoin50 = 0;
  int payoutCoin10 = 0;
  int payoutCoin5 = 0;
  int payoutCoin1 = 0;
}

/// if_acb_StataeSet
/// 関連tprxソース: if_acx.h - NEAREND
class NearEnd {
  int	dummy = 0;
  int	bill5000 = 0;
  int	bill2000 = 0;
  int	bill1000 = 0;
  int	coin500 = 0;
  int	coin100 = 0;
  int	coin50 = 0;
  int	coin10 = 0;
  int	coin5 = 0;
  int	coin1 = 0;
}

/// 関連tprxソース: if_acx.h - ST1
class St1 {
  int busy = 0;
  int ctmErrStat = 0;
  int cssErrStat = 0;
  int rcvPaidType = 0;
  int pickupMode = 0;
  int coinChgMode = 0;
  int fix1 = 0;
  int dummy = 0;
}

/// 関連tprxソース: if_acx.h - ST2
class St2 {
  int cssClean_h = 0;
  int cssClean_s = 0;
  int fix0 = 0;
  int cssPaidOut = 0;
  int cssRcvOut = 0;
  int cssRjtStat = 0;
  int fix1 = 0;
  int dummy = 0;
}

/// 関連tprxソース: if_acx.h - ST3
class St3 {
  int ctmClean = 0;
  int ctmPaidOut = 0;
  int ctmRcvOut = 0;
  int ctmBunit = 0;
  int ctmConnect = 0;
  int ctmRjtStat = 0;
  int fix1 = 0;
  int dummy = 0;
}

/// 関連tprxソース: if_acx.h - ST4
class St4 {
  int fix0 = 0;
  int fix1 = 0;
  int fix2 = 0;
  int fix3 = 0;
  int ctmPosition = 0;
  int ctmKind = 0;
  int fix4 = 0;
  int dummy = 0;
}

/// 関連tprxソース: if_acx.h - STATEDATA
class StateData {
  St1 st1 = St1();
  St2 st2 = St2();
  St3 st3 = St3();
  St4 st4 = St4();
  List<int> hopperStat = List.generate(10, (_) => 0);
  List<int> errCode = List.generate(3, (_) => 0);
}

/// 関連tprxソース: if_acx.h - STATE_ACB_BILL
class StateAcbBill {
  List<int> errCode = List.generate(4, (_) => 0);/* エラーコード */
  int restoreFlg = 0;       /* 解除手順 */
  int sensorInfo = 0;       /* 搬送路センサー情報 */
  int	stockErrBill10000 = 0;/* 在高不確定解除方法 */
  int	stockErrBill5000 = 0;	/* 在高不確定解除方法 */
  int	stockErrBill2000 = 0;	/* 在高不確定解除方法 */
  int	stockErrBill1000 = 0;	/* 在高不確定解除方法 */
  int	stockErrCaset = 0;		/* 在高不確定解除方法 */
}

/// 関連tprxソース: if_acx.h - STATE_ACB_COIN
class StateAcbCoin {
  List<int> errCode = List.generate(4, (_) => 0);/* エラーコード */
  int restoreFlg = 0;       /* 解除手順 */
  int sensorInfo = 0;       /* 搬送路センサー情報 */
  int unitInfo = 0;         /* 硬貨メカセット */
  int	drawStat = 0;
  int	stockErrCoin500 = 0;	/* 在高不確定解除方法 */
  int	stockErrCoin100 = 0;	/* 在高不確定解除方法 */
  int	stockErrCoin50 = 0;	  /* 在高不確定解除方法 */
  int	stockErrCoin10 = 0;	  /* 在高不確定解除方法 */
  int	stockErrCoin5 = 0;		/* 在高不確定解除方法 */
  int	stockErrCoin1 = 0;		/* 在高不確定解除方法 */
}

/// 関連tprxソース: if_acx.h - STATE_ACB
class StateAcb {
  StateAcbBill bill = StateAcbBill();
  StateAcbCoin coin = StateAcbCoin();
}

/// 関連tprxソース: if_acx.h - LAST_DATA
/// 前回データ
class LastData {
  CBillKind iN = CBillKind(); //計数枚数データ
  CBillKind out = CBillKind(); //放出枚数データ
}

/// 関連tprxソース: if_acx.h - STATE_ACXDRW
/// 棒金ドロアデータ
class StateAcxDrw {
  CBillKind	stock = CBillKind();		/* 収納枚数 */
  int		deviceState = 0;	/* 動作情報 */
  CBillKind	cBillState = CBillKind();	/* 状態フラグ */
  int		reserv1Stock = 0;	/* 予備金種1収納枚数 */
  int		reserv2Stock = 0; /* 予備金種2収納枚数 */
  int		reserv1State = 0; /* 予備金種1状態フラグ */
  int		reserv2State = 0; /* 予備金種2状態フラグ */
}

/// ログデータ
/// 関連tprxソース: if_acx.h - ACXPROCNO
class LogDataEcs {
  List<String> logData = List.generate(254, (_) => "");
}

/// 関連tprxソース: if_acx.h - RECALCDATA
class ReCalcData {
  int		ejectCoin = 0;		/* 排出硬貨有無  0:無し 0:有り */
  int		ejectBill = 0;		/* 排出紙幣有無  0:無し 0:有り */
  int		reserveBill = 0;	/* 保留紙幣有無  0:無し 0:有り */
  int		stop = 0;			/* 途中停止有無  0:無し 0:有り */
  int		bill = 0;			/* 紙幣 */
  int		coin = 0;			/* 硬貨 */
}

/// 関連tprxソース: if_acx.h - STATE_SST1
class StateSst1 {
  String detailErrCode;	/* 詳細エラーコード */
  int rejectCoin;	      	/* 硬貨リジェクト */
  int	rejectBill;         /* 紙幣リジェクト */

  StateSst1(
    {
      this.detailErrCode = "",
      this.rejectCoin = 0,
      this.rejectBill = 0
    }
  );

  StateSst1.copy(StateSst1 stateSst1)
    : detailErrCode = stateSst1.detailErrCode,
      rejectCoin = stateSst1.rejectCoin,
      rejectBill = stateSst1.rejectBill;
}

/// 富士電機製釣銭釣札機 詳細状態リードデータ格納領域
/// 関連tprxソース: if_acx.h - STATE_ERR
class StateErr {
  int unit = 0; // ユニットコード
  int procCode = 0; // 処理コード
  List<String> contentCode = List.generate(2, (_) => ""); // 内容コード
}

/// 関連tprxソース: if_acx.h - STATE_SENSOR
class StateSensor {
  int	billIn = 0;			// 紙幣投入口
  int	billOut = 0;		// 紙幣出金口
  int	coinIn = 0;			// 硬貨投入口
  int	coinReturn = 0;	// 硬貨返却口
  int	coinOut = 0;		// 硬貨出金口
}

/// 関連tprxソース: if_acx.h - STATE_HOLDER
class StateHolder {
  int	full = 0;				// フル
  int	nearFull = 0;		// ニアフル
  int	nearEmpty = 0;	// ニアエンプティ
  int	empty = 0;			// エンプティ
}

/// 関連tprxソース: if_acx.h - STATE_CASHBOX
class StateCashBox {
  int	lid = 0;				// 紙幣回収庫ふた開検知
  int	set = 0;				// 紙幣回収庫セット検知
  int	bill = 0;				// 紙幣回収庫紙幣検知
  int	full = 0;				// 紙幣回収庫フル
}

/// 関連tprxソース: if_acx.h - STATE_KEY
class StateKey {
  int	billSet = 0;			// 紙幣部セット検知
  int	billKey = 0;			// 紙幣部鍵位置
  int	coinSet = 0;			// 硬貨部セット検知
  int	coinKey = 0;			// 硬貨部鍵位置
}

/// 関連tprxソース: if_acx.h - STATE_TEMP
class StateTemp {
  int	billFull = 0;			// 紙幣一時保留部のフル検知
  int	coinFull = 0;			// 硬貨一時保留部のフル検知
  int	billStatus = 0;		// 紙幣一時保留部の紙幣有無
  int	coinStatus = 0;		// 硬貨一時保留部の硬貨有無
}

/// 関連tprxソース: if_acx.h - STATE_DETAIL
class StateDetail {
  String bill = ""; // 紙幣部詳細動作モード
  String coin = ""; // 硬貨部詳細動作モード
}

/// 関連tprxソース: if_acx.h - STATE_ECS
class StateEcs {
  int unit = 0; // ユニット情報
  int actMode = 0; // 動作モード
  int cinMode = 0; // 入金モード
  StateErr err = StateErr(); // エラーコード
  StateSensor sensor = StateSensor(); // センサ情報
  CBillKind full = CBillKind(); // フル
  CBillKind nearFull = CBillKind(); // ニアフル
  CBillKind nearEmpty = CBillKind(); // ニアエンプティ
  CBillKind empty = CBillKind(); // エンプティ
  StateHolder holder = StateHolder(); // 紙幣混合収納庫情報
  List<String> actState = List.generate(21, (_) => ""); // 動作情報
  StateCashBox cashBox = StateCashBox(); // 金庫等の情報
  StateKey key = StateKey(); // 鍵情報等
  StateTemp temp = StateTemp(); // 一時保留庫
  StateDetail detail = StateDetail(); // 詳細動作モード
}

/// 紙幣在高異常データ
/// 関連tprxソース: if_acx.h - BILL_STOCK_ERR
class BillStockErr {
  int holderOpen = 0; // 収納庫開
  int caset = 0;
  int bill10000 = 0;
  int bill5000 = 0;
  int bill2000 = 0;
  int bill1000 = 0;
}

/// 硬貨在高異常データ
/// 関連tprxソース: if_acx.h - COIN_STOCK_ERR
class CoinStockErr {
  int holderOpen = 0; // 収納庫開
  int coin500 = 0;
  int coin100 = 0;
  int coin50 = 0;
  int coin10 = 0;
  int coin5 = 0;
  int coin1 = 0;
}

/// 紙幣区間ステータス
/// 関連tprxソース: if_acx.h - BILL_SEGMENT_STATUS
class BillSegmentStatus {
  int holderErr = 0;
  int stockErr = 0;
  int rjNowErr = 0;
  int rjBfrErr = 0;
}

/// 硬貨区間ステータス
/// 関連tprxソース: if_acx.h - COIN_SEGMENT_STATUS
class CoinSegmentStatus {
  int holderErr = 0;
  int stockErr = 0;
  int drawerErr = 0;
}

/// 交代データ
/// 関連tprxソース: if_acx.h - CLOSE_DATA
class CloseData {
  int			            index = 0;
  String			        startDate = "";	// MMDDHHMM
  String			        nowDate = "";	// MMDDHHMM
  List<int>			      startPrice = List.generate(10, (_) => 0);	// 開始時在高金額(※電文データ長は10桁だが釣銭機に億単位が収納されている可能性はないものとしてlong型とした)
  List<int>			      inPrice = List.generate(10, (_) => 0);	// 累積入金系金額
  List<int>			      outPrice = List.generate(10, (_) => 0);	// 累積出金系金額
  List<int>			      nowPrice = List.generate(10, (_) => 0);	// 現在在高金額
  List<int>			      diffPrice = List.generate(10, (_) => 0);	// 在高差分金額
  BillStockErr		    billStock = BillStockErr();
  CoinStockErr		    coinStock = CoinStockErr();
  BillSegmentStatus	  billSegSt = BillSegmentStatus();
  CoinSegmentStatus	  coinSegSt = CoinSegmentStatus();
  int			            closeId = 0;
}

/// 関連tprxソース: if_acx.h - COIN_STOCK
class CoinStock {
  CBillKind? holder;
  int billRjct = 0; // リジェクト合計
  int billRjctIn = 0; // 入金リジェクト
  int billRjctOut = 0; // 出金リジェクト
  int billRjct2000 = 0; // 二千券リジェクト
  int coinRjct = 0;
  CBillKind? overflow;
  CBillKind? drawData;
  String dateTime = ""; // 在高取得日時 YYYY-MM-DD HH:MM:SS
}

// NEC製釣銭釣札機(FAL2)
//--------- 状態センスコマンド取得データ格納領域 ---------
/// 常時通知データ
/// 関連tprxソース: if_acx.h - FAL2_ALWAYS_RESP
class Fal2AlwaysResp {
  List<String> actStatus = List.generate(2, (_) => ""); // 動作ステータス
  List<String> actResultCcode = List.generate(2, (_) => ""); // 動作結果コード
  int unitOffInfo = 0; // 外れ情報
  int typeCode = 0; // 代表コード
  List<String> detailCode = List.generate(2, (_) => ""); // 詳細コード
}

/// 変化データ有無情報
/// 関連tprxソース: if_acx.h - FAL2_CHGINFO
class Fal2ChgInfo {
  int statMediaExist = 0; // 媒体有無情報
  int statSecurityInfo = 0; // セキュリティー情報
  int statBatteryAlarm = 0; // バッテリーアラーム
  int statHolderA = 0; // 収納庫A状態
  int statHolderB = 0; // 収納庫B状態
  int statHolderC = 0; // 収納庫C状態
  int statCashBox = 0; // 紙幣回収庫状態
  int statRejectBox = 0; // 紙幣リジェクト庫状態
  int statCoin500Box = 0; // 500円庫状態
  int statCoin100Box = 0; // 100円庫状態
  int statCoin50Box = 0; // 50円庫状態
  int statCoin10Box = 0; // 10円庫状態
  int statCoin5Box = 0; // 5円庫状態
  int statCoin1Box = 0; // 1円庫状態
  int statCoinReject = 0; // 硬貨リジェクト枚数
  int statCinMode = 0; // 入金モード
  int statSensorInfo = 0; // センサ情報
  int statHolderAmt = 0; // 収納庫在高状態
  int statLocalMode = 0; // ローカルモード
  int statCountUp = 0; // 計数内容
  int statAlwaysCin = 0; // 常時入金計数内容
}

/// 媒体有無情報 0:媒体なし 1:媒体あり
/// 関連tprxソース: if_acx.h - FAL2_MEDIA_EXIST
class Fal2MediaExist {
  int billInOut = 0; // 紙幣入出金口
  int billRoute = 0; // 紙幣搬送路
  int coinIn = 0; // 硬貨投入口
  int coinOut = 0; // 硬貨出金口
  int coinInRoute = 0; // 硬貨入金搬送路
}

/// セキュリティー情報 0:電源OFF中の外れなし 1:電源OFF中の外れあり
/// 関連tprxソース: if_acx.h - FAL2_SECULITY
class Fal2Security {
  int coinBox = 0; // 硬貨金庫
  int billBox = 0; // 紙幣金庫
  int rejectBoxDoor = 0; // リジェクト庫扉
  int collectBox = 0; // 回収庫
  int unit = 0; // ユニット
}

/// 収納庫/回収庫/紙幣リジェクト庫/硬貨リジェクト口の状態
// 0:エンド 1:ニアエンド 2:ニアフル 3:フル 4:媒体あり
/// 関連tprxソース: if_acx.h - FAL2_UNIT_STATUS
class Fal2UnitStatus {
  int holderA = 0; // 収納庫A状態
  int holderB = 0; // 収納庫B状態
  int holderC = 0; // 収納庫C状態
  int cashBox = 0; // 紙幣回収庫状態
  int rejectBox = 0; // 紙幣リジェクト庫状態
  int coin500Box = 0; // 500円庫状態
  int coin100Box = 0; // 100円庫状態
  int coin50Box = 0; // 50円庫状態
  int coin10Box = 0; // 10円庫状態
  int coin5Box = 0; // 5円庫状態
  int coin1Box = 0; // 1円庫状態
  int coinReject = 0; // 硬貨リジェクト口状態
}

/// センサ情報 0:該当センサはOFF 1:該当センサはON
/// 関連tprxソース: if_acx.h - FAL2_SENSOR
class Fal2Sensor {
  int sc22 = 0;
  int sc21 = 0;
  int sc19 = 0;
  int sc02 = 0;
  int reserve = 0;
  int sc04 = 0;
  int sc03 = 0;
  int sc01_1 = 0;

  int sc08 = 0;
  int sc07 = 0;
  int sc12 = 0;
  int sc11 = 0;
  int sc16 = 0;
  int sc15 = 0;

  int sc10 = 0;
  int sc09 = 0;
  int sc14 = 0;
  int sc13 = 0;
  int sc18 = 0;
  int sc17 = 0;

  int sc53 = 0;
  int sc52 = 0;
  int sc45 = 0;
  int sc33 = 0;
  int sc35 = 0;
  int sc34 = 0;
  int sc32 = 0;
  int sc31 = 0;

  int sc38 = 0;
  int sc37 = 0;
  int sc44 = 0;
  int sc43 = 0;
  int sc42 = 0;
  int sc41 = 0;
  int sc40 = 0;
  int sc39 = 0;

  int sc54 = 0;
  int sc51 = 0;
  int sc50 = 0;
  int sc49 = 0;
  int sc48 = 0;
  int sc47 = 0;
  int sc46 = 0;

  int sc60 = 0;
  int sc59 = 0;
  int sc58 = 0;
  int sc57 = 0;
  int sc56 = 0;
  int sc55 = 0;
}

/// 計数内容
/// 関連tprxソース: if_acx.h - FAL2_COUNT
class Fal2Count {
  int amount = 0; // 計数金額
  int bill10000 = 0; // 万券枚数
  int bill5000 = 0; // 五千券枚数
  int bill2000 = 0; // 二千券枚数
  int bill1000 = 0; // 千券枚数
  int coin500 = 0; // 500円枚数
  int coin100 = 0; // 100円枚数
  int coin50 = 0; // 50円枚数
  int coin10 = 0; // 10円枚数
  int coin5 = 0; // 5円枚数
  int coin1 = 0; // 1円枚数
  int billReject = 0; // 紙幣リジェクト枚数
  int coinReject = 0; // 硬貨リジェクト枚数
  int out1000Reject = 0; // 千券の出金
  int out5000Reject = 0; // 五千券の出金
  int out10000Reject = 0; // 万券の出金
}

/// 常時入金計数内容
/// 関連tprxソース: if_acx.h - FAL2_ALWAYSCIN
class Fal2AlwaysCin {
  int amount = 0; // 計数金額
  int bill10000 = 0; // 万券枚数
  int bill5000 = 0; // 五千券枚数
  int bill2000 = 0; // 二千券枚数
  int bill1000 = 0; // 千券枚数
  int coin500 = 0; // 500円枚数
  int coin100 = 0; // 100円枚数
  int coin50 = 0; // 50円枚数
  int coin10 = 0; // 10円枚数
  int coin5 = 0; // 5円枚数
  int coin1 = 0; // 1円枚数
  int billReject = 0; // 紙幣リジェクト枚数
  int coinReject = 0; // 硬貨リジェクト枚数
}

/// 状態センスコマンド取得データ
/// 関連tprxソース: if_acx.h - STATE_FAL2
class StateFal2 {
  Fal2AlwaysResp alwaysResp = Fal2AlwaysResp(); // 常時通知データ
  Fal2MediaExist mediaExist = Fal2MediaExist(); // 媒体有無情報
  Fal2Security security = Fal2Security(); // セキュリティー情報
  int batteryAlarm = 0; // バッテリーアラーム   0:正常 1:バッテリーアラーム
  Fal2UnitStatus unitStatus = Fal2UnitStatus(); // 収納庫/回収庫/紙幣リジェクト庫/硬貨リジェクト口の状態
  int standbyMode = 0; // 釣銭機待機モード     0:常時入金モード 1:指定入金モード
  Fal2Sensor sensor = Fal2Sensor(); // センサ情報
  int holderAmt = 0; // 収納庫在高状態       0:紙幣、硬貨共に確定 1:紙幣不確定 2:硬貨不確定 3:紙幣、硬貨共に不確定
  int localMode = 0; // ローカルモード       0:運用モード 1:運用モードの補充or両替中 2:ローカルモード 3:保守モード
  Fal2Count count = Fal2Count(); // 計数内容
  Fal2AlwaysCin alwaysCin = Fal2AlwaysCin(); // 常時入金計数内容
}

/// Definition Order
/// 関連tprxソース: if_acx.h - ACXPROCNO
enum AcxProcNo {
  ACX_NOT_ORDER(0),
  ACX_STATE_READ(1),
  ACX_STATE_GET(2),
  ACX_STATE_SET(3),
  ACX_DATETIMESET(4),
  ACX_STOCK_READ(5),
  ACX_STOCK_GET(6),
  ACX_CHANGE_OUT(7),
  ACX_SPECIFY_OUT(8),
  ACX_ANS_READ(9),
  ACX_RESET(10),
  ACX_RESULT_GET(11),
  ACX_ENUM_READ(12),
  ACX_ENUM_GET(13),
  ACX_SSW_SET(14),
  ACX_CIN_READ(15),
  ACX_CIN_GET(16),
  ACX_CIN_READ_RES(17),
  ECS_CIN_READ(18),
  ECS_CIN_READ_RES(19),
  ECS_CIN_STATE_READ(20),
  ECS_CIN_STATE_RES(21),
  SST_CIN_READ(22),
  SST_CIN_READ_RES(23),
  SST_CIN_STATE01(24),
  SST_CIN_STATE01_RES(25),
  SST_CIN_STATE80(26),
  SST_CIN_STATE80_RES(27),
  ACB_STATE80(28),
  ACB_STATE80_RES(29),
  ACB_STATE80_GET(30),
  ECS_STATE_READ(31),
  ECS_STATE_RES(32),
  ECS_STATE_GET(33),
  SST_STATE01(34),
  SST_STATE01_RES(35),
  SST_STATE01_GET(36),
  SST_STATE80(37),
  SST_STATE80_RES(38),
  SST_STATE80_GET(39),
  ACX_START(40),
  ACX_START_GET(41),
  ACX_STOP(42),
  ACX_END(43),
  ACX_CANCEL(44),
  ACX_PICKUP(45),
  ECS_OPE_SET(46),
  ACX_DRW_OPEN(47),
  ECS_DRW_READ(48),
  ECS_DRW_GET(49),
  ACX_CHANGE_OUT_GET(50),
  ACX_PICKUP_GET(51),
  FAL2_CIN_READ(52),
  FAL2_CIN_READ_RES(53),
  ACB_STATE_LASTDATA(54),
  ACB_STATE_LASTDATA_RES(55),
  ACB_STATE_LASTDATA2(56),
  ACB_STATE_LASTDATA2_RES(57),
  ACB_STATE_LASTDATA_GET(58),
  ACX_CALCMODE_SET(59),
  ACX_CALCMODE_CHK(60),
  ACX_CALCMODE_GET(61),
  ECS_RAS_SETTING_READ(62),
  ECS_RAS_SETTING_SET(63),
  ECS_RAS_SETTING_GET(64),
  ECS_PAYOUT_READ(65),
  ECS_PAYOUT_GET(66),
  ACX_OVERFLOW_MOVE_AUTO_START(67),
  ACX_OVERFLOW_MOVE_AUTO_01_CMD(68),
  ACX_OVERFLOW_MOVE_AUTO_01_RES(69),
  ACX_OVERFLOW_MOVE_AUTO_02_CMD(70),
  ACX_OVERFLOW_MOVE_AUTO_02_RES(71),
  ACX_OVERFLOW_MOVE_AUTO_03_CMD(72),
  ACX_OVERFLOW_MOVE_AUTO_03_RES(73),
  ACX_OVERFLOW_MOVE_AUTO_04_CMD(74),
  ACX_OVERFLOW_MOVE_AUTO_04_RES(75),
  ACX_OVERFLOW_MOVE_AUTO_05_CMD(76),
  ACX_OVERFLOW_MOVE_AUTO_05_RES(77),
  ACX_OVERFLOW_MOVE_AUTO_06_CMD(78),
  ACX_OVERFLOW_MOVE_AUTO_06_RES(79),
  ACX_OVERFLOW_MOVE_AUTO_07_CMD(80),
  ACX_OVERFLOW_MOVE_AUTO_07_RES(81),
  ACX_OVERFLOW_MOVE_AUTO_08_CMD(82),
  ACX_OVERFLOW_MOVE_AUTO_08_RES(83),
  ACX_OVERFLOW_MOVE_AUTO_09_CMD(84),
  ACX_OVERFLOW_MOVE_AUTO_09_RES(85),
  ACX_OVERFLOW_MOVE_AUTO_FINISH(86),
  ACX_CIN_END(87),
  ACX_CIN_END_RES(88),
  ACX_CIN_END_STATE_READ(89),
  ACX_CIN_END_STATE_RES(90),
  ECS_CIN_END(91),
  ECS_CIN_END_RES(92),
  ECS_CIN_END_STATE_READ(93),
  ECS_CIN_END_STATE_RES(94),
  ECS_CIN_END_MOTION2(95),
  ECS_CIN_END_MOTION2_RES(96),
  ECS_CIN_END_MOTION2_STATE_READ(97),
  ECS_CIN_END_MOTION2_STATE_RES(98),
  ACX_CIN_END_GET(99),
  ACX_ORDER_RESET(9999);
  final int no;
  const AcxProcNo(this.no);
  
  static AcxProcNo getDefine(int index) {
    AcxProcNo typ = AcxProcNo.values.firstWhere((element) {
      return element.no == index;
    }, orElse: () => AcxProcNo.ACX_NOT_ORDER);
    return typ;
  }
}

/// 関連tprxソース: \inc\lib\if_acx.h - ACX_DATA_TYPE
enum AcxDataType {
  ACX_DATA_NON(0),
  ACX_DATA_COIN(1),
  ACX_DATA_BILL(2),
  ACX_DATA_COINBILL(3);

  final int id;
  const AcxDataType(this.id);
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINREAD_ECS
class CinreadEcs {
  CinData cindata = CinData();		/* 入金枚数 */
  int rejectCoin = 1;	/* 硬貨リジェクト 0:無し／1:有り */
  int rejectBill = 1;	/* 紙幣リジェクト 0:無し／1:有り */
}

/// 関連tprxソース: \inc\lib\if_acx.h - CININFO
class Cininfo {
  CinData cindata = CinData();
  Cinflg cinflg = Cinflg();
}

/// 関連tprxソース: \inc\lib\if_acx.h - CINFLG
class Cinflg {
  int cininfo = 0;
  int cinstopcom = 0;
  int device_state = 0;
  int billinfo = 0;
  int billdetail = 0;
  int coininfo = 0;
  int coindetail = 0;
  int opeflg = 0;
}

/// 関連tprxソース: \inc\lib\if_acx.h - STATE_CASHBOX
class StateCashbox {
  int	lid = 0;				/* 紙幣回収庫ふた開検知 */
  int	set = 0;				/* 紙幣回収庫セット検知 */
  int	bill = 0;				/* 紙幣回収庫紙幣検知 */
  int	full = 0;				/* 紙幣回収庫フル */
}

/// 関連tprxソース: \inc\lib\if_acx.h - FAL2_SECULITY
/* セキュリティー情報 0:電源OFF中の外れなし 1:電源OFF中の外れあり */
class Fal2Seculity {
  int	coin_box = 0;		     /* 硬貨金庫 */
  int	bill_box = 0;		     /* 紙幣金庫 */
  int	reject_boxdoor = 0;  /* リジェクト庫扉 */
  int	collect_box = 0;     /* 回収庫 */
  int	unit = 0;            /* ユニット */
}

/// 関連tprxソース: \inc\lib\if_acx.h - ACR_UNIT_CMD
enum AcrUnitCmd {
  COIN_CMD(0),
  BILL_CMD(1);

  final int id;
  const AcrUnitCmd(this.id);
}

/// 関連tprxソース: if_acx.h - ACR_CALC_MODE
enum AcrCalcMode {
  ACR_CALC_MANUAL(0),
  ACR_CALC_AUTO(1),
  ACR_CALC_CTRL(2);
  final int no;
  const AcrCalcMode(this.no);
}

/// 関連tprxソース: if_acx.h - ACRACX_CALC_TYPE
enum AcxCalcType {
  ACX_CALC_ALL,
  ACX_CALC_COIN,
  ACX_CALC_BILL,
}

/// 関連tprxソース: if_acx.h - ACR_DRAWER_LOCK_FLG
enum AcrDrawerLockFlg {
  ACR_DRW_NON,
  ACR_DRW_UNLOCK,
  ACR_DRW_LOCK,
}

/// 関連tprxソース: if_acx.h - ACR_LOCALOPEBAN_FLG
enum AcrLocalOpeBanFlg {
  ACR_LOCALOPEBAN_YES,
  ACR_LOCALOPEBAN_NO,
}

/// 関連tprxソース: if_acx.h - ACR_PICK
enum AcrPick {
  ACR_PICK_NON,
  ACR_PICK_10000,
  ACR_PICK_5000,
  ACR_PICK_2000,
  ACR_PICK_1000,
  ACR_PICK_500,
  ACR_PICK_100,
  ACR_PICK_50,
  ACR_PICK_10,
  ACR_PICK_5,
  ACR_PICK_1,
  ACR_PICK_ALL,
  ACR_PICK_LEAVE,
  ACR_PICK_DATA,
  ACR_PICK_CASET,
}

/// 関連tprxソース: if_acx.h - ACR_CALC_FLAG
enum AcrCalcFlag {
  ACR_CALC_ENQ,
  ACR_CALC_SET,
}

/// 関連tprxソース: if_acx.h - ACR_CLOSE_TYP
enum AcrCloseTyp {
  ACR_CLOSE_TYP_CHG,
  ACR_CLOSE_TYP_CLS,
}

/// 関連tprxソース: if_acx.h - ACR_CONNECT_RAD
enum AcrConnectRad {
  ACR_RAD_CONNECT,
  ACR_RAD_CUT,
}

/// 関連tprxソース: if_acx.h - ACR_CONNECT_AC
enum AcrConnectAcr {
  ACR_ACR_CONNECT,
  ACR_ACR_CUT,
}

/// 関連tprxソース: if_acx.h - CHGPICK_BTN
enum ChgPickBtn {
  BTN_OFF(0),
  ALLBTN_ON(1),
  RESERVEBTN_ON(2),
  MANBTN_ON(3),
  BILLBTN_ON(4),
  COINBTN_ON(5),
  USERDATABTN_ON(6),
  FULLBTN_ON(7),
  CASETBTN_ON(8);

  final int btnType;

  const ChgPickBtn(this.btnType);

  /// dlgIdから対応するFuncKeyを取得する.
  static ChgPickBtn getDefine(int btnType) {
    ChgPickBtn? define =
    ChgPickBtn.values.firstWhereOrNull((a) => a.btnType == btnType);
    define ??= ChgPickBtn.BTN_OFF; // 定義されているものになければnoneを入れておく.
    return define;
  }
}

/// 関連tprxソース: if_acx.h - SST1_FLGCLR
enum Sst1FlgClr {
  SST1_FCLR_BILL(0),
  SST1_FCLR_COIN(1);

  final int flg;

  const Sst1FlgClr(this.flg);

  /// dlgIdから対応するFuncKeyを取得する.
  static Sst1FlgClr getDefine(int flg) {
    Sst1FlgClr? define =
    Sst1FlgClr.values.firstWhereOrNull((a) => a.flg == flg);
    define ??= Sst1FlgClr.SST1_FCLR_BILL; // 定義されているものになければnoneを入れておく.
    return define;
  }
}