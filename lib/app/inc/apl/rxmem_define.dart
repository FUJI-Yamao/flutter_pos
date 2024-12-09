/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../clxos/calc_api_data.dart';
import '../../../postgres_library/src/basic_table_access.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../postgres_library/src/staff_table_access.dart';
import '../../common/cls_conf/counterJsonFile.dart';
import '../../common/cls_conf/mac_infoJsonFile.dart';
import '../../common/cls_conf/mbrrealJsonFile.dart';
import '../../common/cls_conf/soundJsonFile.dart';
import '../../common/cls_conf/sysJsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../lib/apllib/recog.dart';
import '../../lib/apllib/rx_prt_flag_set.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../regs/inc/rc_crdt.dart';
import '../../set/prg_preset.dart';
import '../db/c_ttllog.dart';
import '../lib/apllib.dart';
import '../lib/if_acx.dart';
import '../lib/if_fcl.dart';
import '../lib/if_pana.dart';
import '../lib/if_suica.dart';
import '../sys/tpr_ipc.dart';
import 'compflag.dart';
import 'fnc_code.dart';
import 'image.dart';
import 'rx_cnt_list.dart';
import 'rxmem.dart';
import 'rxmem_msg.dart';
import 'rxmem_tmp.dart';
import 'rxmemcustreal2.dart';
import 'rxmemnttdpreca.dart';
import 'rxmemqcConnect.dart';
import 'rxmemprn.dart';
import 'rxregmem_define.dart';
import 'rxtbl_buff.dart';
import 'rxtbl_buff_keyopt.dart';
import 'scpu.dart';
import 'sysparam.dart';
import 't_item_log.dart';
import 'trm_list.dart';

/// チェッカー／キャッシャー指示定義
///  関連tprxソース:\inc\apl\rxmem.h - RX_REGSINST
enum RxRegsinst {
  RX_REGSINST_START,
  /* 登録開始 */
  RX_REGSINST_STOP,
  /* 登録終了 */
  RX_STROPN_START,
  RX_STROPN_STOP,
  RX_STRCLS_START,
  RX_STRCLS_STOP,
  RX_MENU_START,
  RX_MENU_STOP,
  RX_ANOTHER1_START,
  RX_ANOTHER1_STOP,
  RX_ANOTHER2_START,
  RX_ANOTHER2_STOP,
  RX_ANOTHER21_STOP,
  RX_ANOTHER2_SPEC_SPECIAL,
  // #if SIMPLE_2STAFF /* 2004.01.13 */
  // RX_SIMPLE2STF_START,
  // RX_SIMPLE2STF_STOP,
  // #endif
  // #if CN_NSC
  // RX_BANK_START,
  // RX_BANK_STOP,
  // #endif
  // #if FB_FENCE_OVER
  // RX_FENCE_OVER_START,
  // RX_FENCE_OVER_STOP,
  // #endif
  RX_ASSIST_REQ,
  RX_EJCONF_START,
  RX_EJCONF_STOP,
  RX_CASH_RECYCLE_START,
  RX_CASH_RECYCLE_STOP,
  RX_AUTO_STRCLS_START,
  RX_DATA_SHIFT_STOP,
}

/// オペモードフラグのNo.リスト
///  関連tprxソース: \inc\apl\rxmem.h - OPE_MODE_FLAG_LIST
class OpeModeFlagList {
  static const OPE_MODE_REG	= 1000;		// 登録モード (旧: 1)
  static const OPE_MODE_REG_SP_TCKT	= 1100;		// お会計券 (登録モード) (旧: 41, item7)
  static const OPE_MODE_REG_QC_SPLIT = 1200;		// QCashierスプリット (登録モード) (旧: 51, item7)
  static const OPE_MODE_REG_DUMMY	= 1300;		//
  static const OPE_MODE_TRAINING = 2000;		// 訓練モード (旧: 2)
  static const OPE_MODE_TRAINING_SP_TCKT = 2100;	// お会計券 (訓練モード) (旧: 42, item7)
  static const OPE_MODE_TRAINING_QC_SPLIT = 2200;	// QCashierスプリット (登録モード) (旧: 52, item7)
  static const OPE_MODE_TRAINING_DUMMY = 2300;	//
  static const OPE_MODE_VOID = 3000;		// 訂正モード (旧: 3)
  static const OPE_MODE_VOID_SP_TCKT = 3100;		// お会計券 (訓練モード) (旧: 43, item7)
  static const OPE_MODE_VOID_QC_SPLIT = 3200;		// QCashierスプリット (登録モード) (旧: 53, item7)
  static const OPE_MODE_VOID_DUMMY = 3300;		//
  static const OPE_MODE_SCRAP = 4000;		// 廃棄モード (旧: 4)
  static const OPE_MODE_ORDER = 5000;		// 発注モード (旧: 17, item7)
  static const OPE_MODE_STOCKTAKING = 6000;		// 棚卸モード (旧: 18, item8)
  static const OPE_MODE_OFFICIAL_RCPT = 6100;	// 61.領収書 (登録モード)
  static const OPE_MODE_OFFICIAL_RCPT_TR = 6200;	// 62.領収書 (訓練モード)
  static const OPE_MODE_PRODUCTION = 7000;		// 生産モード (旧: 24, item9)
  static const OPE_MODE_STAFF_OPN = 11000;	// 従業員オープン (旧: 70)
  static const OPE_MODE_STAFF_CLS = 12000;	// 従業員クローズ (旧: 11)
  static const OPE_MODE_FLASH_REPT = 13000;	// 売上速報 (旧: 15)
  static const OPE_MODE_CHECK_REPT = 14000;	// 売上点検 (旧: 7)
  static const OPE_MODE_FINISH_REPT = 15000;	// 売上精算 (旧: 8)
  static const OPE_MODE_LOGIN = 16000;	// ログイン コメリ仕様 (旧: 30)
  static const OPE_MODE_SETUP = 17000;	// 設定 (旧: 9)
  static const OPE_MODE_PRC_CHANGE = 18000;	// 売価変更 (旧: 10)
  static const OPE_MODE_RESERV_REPT = 19000;	// 予約レポート
  static const OPE_MODE_USER_SETUP = 20000;	// ユーザーセットアップ (旧: 13)
  static const OPE_MODE_STORE_OPN = 21000;	// 開設 (旧: 12)
  static const OPE_MODE_STORE_CLS = 22000;	// 閉設 (旧: 12)
  static const OPE_MODE_CLOSE_LINE = 23000;	// 締め精算処理：区切り線として利用し、実績はなし
  static const OPE_MODE_CNCT_INFO = 40000;	// 接続情報
  static const OPE_MODE_RESERV_RG = 61000;	// 予約モード（登録）（旧：60)
  static const OPE_MODE_RESERV_TR = 62000;	// 予約モード（訓練）（旧：60)
  static const OPE_MODE_MBR_UNLOCK = 81000;	// 会員情報ロック解除実績
  static const OPE_MODE_MODE_END = 82000;	// モード終了 (旧: 85)
  static const OPE_MODE_MODE_START = 83000;	// モード開始 (旧: 86)
  static const OPE_MODE_MENTE = 99000;	// メンテナンス (旧: 5)
  static const OPE_MODE_SPEC_SETUP = 99100;	// スペックファイル設定
  static const OPE_MODE_INIT = 99200;	// ファイル初期設定 (旧: 16)
  static const OPE_MODE_STRCLS_INFO = 99300;	// 精算情報
}

///-----------------------------------------------------------------------------

/// 共有メモリ関数の戻り値
///  関連tprxソース: \inc\apl\rxmem.h
class RxMem {
  static const RXMEM_OK = 0; /* 正常終了 */
  static const RXMEM_NG = -1; /* 異常終了 */
  static const RXMEM_DATA_ON = RXMEM_OK; /* データあり */
  static const RXMEM_DATA_NG = 1; /* データなし */

  /**********************************************************************
      最大レコード数定義
   ***********************************************************************/
  static const DB_INSTRE_MAX = 99; // インストアマーキング
  static const DB_TAX_MAX = 10; // 税金
  static const DB_RECMSG_MAX = 31; /* レシートメッセージ */
  static const DB_FIPMSG_MAX = 10; /* FIPスクロールメッセージ */
  static const DB_COLORDSP_MAX = 10; /* カラー客表メッセージ */

  static const PRESET_LCD57_MAX = 8; /* =5.7インチLCD */
  static const PRESET_MKEY1_MAX = 56; /* 本体メカキー */
  static const PRESET_MKEY2_MAX = 30; /* タワーメカキー */
  static const PRESET_MKEY52_MAX = 52; /* 52Keyタワーメカキー */
  static const PRESET_MKEY35_MAX = 35; /* 35key本体メカキー */
  static const PRESET_MKEY28i_MAX = 68; /* Web2800i 本体メカキー */
  static const PRESET_MKEY28iM_MAX = 84; /* Web2800iM 本体メカキー */
//static const  PRESET_MKEY_MAX		PRESET_MKEY28i_MAX
  static const PRESET_MKEY_MAX = PRESET_MKEY28iM_MAX;
  static const FTP_MAX = 2;
  static const TPOINT_TBL = 50000;

  // システム定義
  static const CHARCODE_BYTE = 4;	// 現在の文字コードにおける, １文字を表現する最大のbyte数

  /// イメージデータ構造定義
  static const DB_IMG_DATASIZE = 300;
  static const OLD_DB_IMG_DATASIZE = 32;
}

/// 共有メモリインデックス
///  関連tprxソース: \inc\apl\rxmem.h - RXMEM_IDX
class RxMemIdx {
  static const RXMEM_COMMON = 0; /* 全タスク共通メモリ */
  static const RXMEM_STAT = 1; /* タスクステータス */
  static const RXMEM_CHK_INP = 2; /* チェッカー入力情報 */
  static const RXMEM_CASH_INP = 3; /* キャッシャー入力情報 */
  static const RXMEM_CHK_RCT = 4; /* チェッカーレシートバッファ */
  static const RXMEM_CASH_RCT = 5; /* キャッシャーレシートバッファ */
  static const RXMEM_UPD_RCT = 6; /* 実績加算レシートバッファ */
  static const RXMEM_PRN_RCT = 7; /* レシート印字レシートバッファ */
  static const RXMEM_PRN_STAT = 8; /* 印字ステータスバッファ */
  static const RXMEM_CHK_CASH = 9; /* 割込入力情報 */
  static const RXMEM_ACX_STAT = 10; /* ACXステータスバッファ */
  static const RXMEM_JPO_STAT = 11; /* JPOステータスバッファ */
  static const RXMEM_SOCKET = 12; /* SOCKET通信用共通メモリ */
  static const RXMEM_SCL_STAT = 13; /* SCLステータスバッファ */
  static const RXMEM_RWC_STAT = 14; /* RWCステータスバッファ */
  static const RXMEM_STROPNCLS = 15; /* 開閉設入力情報 */
  static const RXMEM_SGSCL1_STAT = 16; /* セルフゲートSCL1ステータスバッファ */
  static const RXMEM_SGSCL2_STAT = 17; /* セルフゲートSCL2ステータスバッファ */
  static const RXMEM_PROCINST = 18; /* PROCESS CONTROL 入力情報 */
  static const RXMEM_ANOTHER1 = 19; /* another1入力情報 */
  static const RXMEM_ANOTHER2 = 20; /* another2入力情報 */
  static const RXMEM_PMOD = 21; /* pmod情報 */
  static const RXMEM_SALE = 22; /* sale_com_mm情報 */
  static const RXMEM_REPT = 23; /* report情報 */
  static const RXMEM_STPR_RCT = 24; /* ステーションプリンタ印字レシートバッファ */
  static const RXMEM_STPR_STAT = 25; /* 印字ステータスバッファ */
  static const RXMEM_MNTCLT = 26; /* menteclient information */
  static const RXMEM_SOUND = 27; /* 音声情報(卓上部) */
  static const RXMEM_S2PR_RCT = 28; /* ステーションプリンタ印字レシートバッファ */
  static const RXMEM_S2PR_STAT = 29; /* 印字ステータスバッファ */
  static const RXMEM_BANK_STAT = 30; /* BANKステータスバッファ */
  static const RXMEM_NSC_RCT = 31; /* BANKレシートバッファ */
  //#if FB_FENCE_OVER
  static const RXMEM_FENCE_OVER = 32; /* FenceOver入力情報 */
  //#endif
  static const RXMEM_SOUND2 = 33; /* 音声情報(タワー部) */
  static const RXMEM_SUICA_STAT = 34; /* SUICAステータスバッファ */
  static const RXMEM_ACXREAL = 35; /* 釣銭釣札機リアル問い合わせ処理 */
  static const RXMEM_MP1_RCT = 36; /* MP1印字レシートバッファ */
  static const RXMEM_MULTI_STAT = 37; /* MULTIステータスバッファ */
  static const RXMEM_CUSTREAL_STAT = 38; /* 顧客リアルステータスバッファ */
  static const RXMEM_CUSTREAL_SOCKET = 39; /* 顧客リアルSOCKET通信用共通メモリ */
  static const RXMEM_QCCONNECT_STAT = 40; /* QcConnectステータスバッファ */
  static const RXMEM_CREDIT_SOCKET = 41; /* クレジットSOCKET通信用共通メモリ */
  static const RXMEM_CUSTREAL_NECSOCKET = 42; /* NEC SOCKET通信用共通メモリ */
  static const RXMEM_MASR_STAT = 43; /* 自走式磁気リーダ */
  static const RXMEM_CASH_RECYCLE = 44; /* キャッシュリサイクル */
  static const RXMEM_QCJC_C_PRN_RCT = 45; /* レシート印字レシートバッファ */
  static const RXMEM_QCJC_C_PRN_STAT = 46; /* 印字ステータスバッファ */
  static const RXMEM_SQRC = 47; /* SQRC Ticket */
  static const RXMEM_KITCHEN1_PRN_RCT = 48; /* レシート印字レシートバッファ(Kitchen1) */
  static const RXMEM_KITCHEN1_PRN_STAT = 49; /* 印字ステータスバッファ(Kitchen1) */
  static const RXMEM_KITCHEN2_PRN_RCT = 50; /* レシート印字レシートバッファ(Kitchen2) */
  static const RXMEM_KITCHEN2_PRN_STAT = 51; /* 印字ステータスバッファ(Kitchen2) */
  static const RXMEM_MAIL_SENDER = 52; /* 電子メール送信 */
  static const RXMEM_DUMMY_PRN_RCT = 53; /* レシート印字レシートバッファ(ダミー) */
  static const RXMEM_DUMMY_PRN_STAT = 54; /* 印字ステータスバッファ(ダミー) */
  static const RXMEM_TBLMAX = 55; /*  */
}


///  関連tprxソース: \inc\apl\rxmem.h  STAFF_INFO_IDX
enum StaffInfoIndex {
  STAFF_INFO_CASHIER,
  STAFF_INFO_CHECKER,
  STAFF_INFO_LOGIN,
  STAFF_INFO_MAX
}
///  関連tprxソース: \inc\apl\rxmem.h  STAFF_INFO_IDX
class StrclsInfo{
  T110000? strclsTtl;
  /// 精算時釣機回収残置金額
  int strclsCnt = 0;
  /// 精算時釣機回収残置金額
  int cpickAmt = 0;
  /// 精算時釣機回収残置金額
  int cpickResAmt = 0;
  /// 精算時回収枚数（売上回収＋釣機回収）
  List<int> pickSht = List.generate(10, (_) => 0);

}

/// 共有メモリのキータイプ定義
///  関連tprxソース: \inc\apl\rxmem.h
class RxMemKey {
  static const KEYTYPE_84 = 1;
  static const KEYTYPE_68 = 2;
  static const KEYTYPE_56 = 3;
  static const KEYTYPE_30 = 4;
  static const KEYTYPE_52 = 5;
  static const KEYTYPE_35 = 6;
  static const KEYTYPE_56_23 = 13;
  static const KEYTYPE_30_23 = 14;

  /// 本体メカキープリセットマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey1Read()
  static int getPresetCdFromKeyD(int key) {
    switch (key) {
      case RxMemKey.KEYTYPE_84:
        return PrgPresetDef.REG2800IMKEYD;
      case RxMemKey.KEYTYPE_68:
        return PrgPresetDef.REG2800IKEYD;
      case RxMemKey.KEYTYPE_56:
        return PrgPresetDef.REGMAINKEYD;
      case RxMemKey.KEYTYPE_30:
        return PrgPresetDef.REGJRKEYD;
      case RxMemKey.KEYTYPE_56_23:
        return PrgPresetDef.REGMAINKEYD;
      case RxMemKey.KEYTYPE_30_23:
        return PrgPresetDef.REGJRKEYD;
      case RxMemKey.KEYTYPE_52:
        return PrgPresetDef.REG52KEYD;
      case RxMemKey.KEYTYPE_35:
        return PrgPresetDef.REG35KEYD;
      default:
        return PrgPresetDef.REG2800IMKEYD;
    }
  }

  /// 本体メカキープリセットマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey2Read()
  static int getPresetCdFromKeyT(int key) {
    switch (key) {
      case RxMemKey.KEYTYPE_84:
        return PrgPresetDef.REG2800IMKEYD;
      case RxMemKey.KEYTYPE_68:
        return PrgPresetDef.REG2800TOWERKEYD;
      case RxMemKey.KEYTYPE_56:
        return PrgPresetDef.REGMAINKEYD;
      case RxMemKey.KEYTYPE_30:
        return PrgPresetDef.REGTOWERKEYD;
      case RxMemKey.KEYTYPE_56_23:
        return PrgPresetDef.REGMAINKEYD;
      case RxMemKey.KEYTYPE_30_23:
        return PrgPresetDef.REGTOWERKEYD;
      case RxMemKey.KEYTYPE_52:
        if (CmCksys.cmQCashierJCSystem() != 0) {
          return PrgPresetDef.REG52KEYD;
        }
        return PrgPresetDef.REG52TOWERKEYD;
      default:
        return PrgPresetDef.REG2800TOWERKEYD;
    }
  }

  /// 本体メカキープリセットマスタ読み込み
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey1Read() / rmDbPresetMkey2Read()
  static int getMkeyMaxFromKey(int key, {bool isTower = false}) {
    switch (key) {
      case RxMemKey.KEYTYPE_84:
        return RxMem.PRESET_MKEY28iM_MAX;
      case RxMemKey.KEYTYPE_68:
        return RxMem.PRESET_MKEY28i_MAX;
      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
        return RxMem.PRESET_MKEY1_MAX;
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return RxMem.PRESET_MKEY2_MAX;
      case RxMemKey.KEYTYPE_52:
        return RxMem.PRESET_MKEY52_MAX;
      case RxMemKey.KEYTYPE_35:
        if (isTower) {
          return RxMem.PRESET_MKEY28i_MAX;
        }
        return RxMem.PRESET_MKEY35_MAX;
      default:
        if (isTower) {
          return RxMem.PRESET_MKEY28i_MAX;
        }
        return RxMem.PRESET_MKEY28iM_MAX;
    }
  }

  /// 本体メカキープリセットマスター　データ数チェック（row）
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey1Read()
  static int getRowFromKey(int key) {
    switch (key) {
      case RxMemKey.KEYTYPE_84:
        return 7;
      case RxMemKey.KEYTYPE_68:
        return 4;
      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
        return 0;
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return 0;
      case RxMemKey.KEYTYPE_52:
        return 13;
      case RxMemKey.KEYTYPE_35:
        return 7;
      default:
        return 7;
    }
  }

  /// 本体メカキープリセットマスター　データ数チェック（line）
  /// 関連tprxソース: rmdbread.c - rmDbPresetMkey1Read()
  static int getLineFromKey(int key) {
    switch (key) {
      case 12:
        return 7;
      case 17:
        return 4;
      case RxMemKey.KEYTYPE_56:
      case RxMemKey.KEYTYPE_56_23:
        return 0;
      case RxMemKey.KEYTYPE_30:
      case RxMemKey.KEYTYPE_30_23:
        return 0;
      case RxMemKey.KEYTYPE_52:
        return 4;
      case RxMemKey.KEYTYPE_35:
        return 5;
      default:
        return 12;
    }
  }
}

///  関連tprxソース: rxmemctr.h - FB_MKEY
class FbMkey {
  int presetColor = 0;
  String kyName = "";
}

///  関連tprxソース: rxmemctr.h - MKEY_INFO
class MkeyInfo {
  late List<FbMkey> preMkInfo =
      List.generate(RxMem.PRESET_MKEY_MAX, (_) => FbMkey());
  int keyMax = 0; // キー数.
  int row = 0; // 行.
  int line = 0; // 列.
  List<int> softKeyNo = List.generate(8, (_) => 0);
}

///-----------------------------------------------------------------------------

//---------------------------------

// 共有メモリ更新インデックス
enum RxMemIndex {
  ///
  RXMEM_NON(0),
  /// 全タスク共通メモリ　Class：RxCommonBuf
  RXMEM_COMMON(1),
  /// タスクステータス　Class：RxTaskStatBuf
  RXMEM_STAT(2),
  /// チェッカー入力情報　Class：RxInputBuf
  RXMEM_CHK_INP(3),
  /// キャッシャー入力情報　Class：RxInputBuf
  RXMEM_CASH_INP(4),
  /// チェッカーレシートバッファ　Class：RegsMem
  RXMEM_CHK_RCT(5),
  /// キャッシャーレシートバッファ　Class：RegsMem
  RXMEM_CASH_RCT(6),
  /// 実績加算レシートバッファ　Class：RegsMem
  RXMEM_UPD_RCT(7),
  /// レシート印字レシートバッファ　Class：RegsMem
  RXMEM_PRN_RCT(8),
  /// 印字ステータスバッファ　Class：RxPrnStat
  RXMEM_PRN_STAT(9),
  /// 割込入力情報　Class：RxInputBuf
  RXMEM_CHK_CASH(10),
  /// ACXステータスバッファ　Class：RxInputBuf
  RXMEM_ACX_STAT(11),
  /// JPOステータスバッファ　Class：RxInputBuf
  RXMEM_JPO_STAT(12),
  /// SOCKET通信用共通メモリ　Class：RxSocket
  RXMEM_SOCKET(13),
  /// SCLステータスバッファ　Class：RxInputBuf
  RXMEM_SCL_STAT(14),
  /// RWCステータスバッファ　Class：RxInputBuf
  RXMEM_RWC_STAT(15),
  /// 開閉設入力情報　Class：RxInputBuf
  RXMEM_STROPNCLS(16),
  /// セルフゲートSCL1ステータスバッファ　Class：RxInputBuf
  RXMEM_SGSCL1_STAT(17),
  /// セルフゲートSCL2ステータスバッファ　Class：RxInputBuf
  RXMEM_SGSCL2_STAT(18),
  /// PROCESSCONTROL入力情報　Class：RxInputBuf
  RXMEM_PROCINST(19),
  /// another1入力情報　Class：RxInputBuf
  RXMEM_ANOTHER1(20),
  /// another2入力情報　Class：RxInputBuf
  RXMEM_ANOTHER2(21),
  /// pmod情報　Class：RxInputBuf
  RXMEM_PMOD(22),
  /// sale_com_mm情報　Class：RxInputBuf
  RXMEM_SALE(23),
  /// report情報　Class：RxInputBuf
  RXMEM_REPT(24),
  /// ステーションプリンタ印字レシートバッファ　Class：RegsMem
  RXMEM_STPR_RCT(25),
  /// 印字ステータスバッファ　Class：RxPrnStat
  RXMEM_STPR_STAT(26),
  /// menteclientinformation　Class：RxMntclt
  RXMEM_MNTCLT(27),
  /// 音声情報(卓上部)　Class：RxSoundStat
  RXMEM_SOUND(28),
  /// ステーションプリンタ印字レシートバッファ　Class：RegsMem
  RXMEM_S2PR_RCT(29),
  /// 印字ステータスバッファ　Class：RxPrnStat
  RXMEM_S2PR_STAT(30),
  /// BANKステータスバッファ　Class：RxInputBuf
  RXMEM_BANK_STAT(31),
  /// BANKレシートバッファ　Class：RegsMem
  RXMEM_NSC_RCT(32),
  /// FenceOver入力情報　Class：RxInputBuf
  RXMEM_FENCE_OVER(33),
  /// 音声情報(タワー部)　Class：RxSoundStat
  RXMEM_SOUND2(34),
  /// SUICAステータスバッファ　Class：RxInputBuf
  RXMEM_SUICA_STAT(35),
  /// 釣銭釣札機リアル問い合わせ処理　Class：RxInputBuf
  RXMEM_ACXREAL(36),
  /// MP1印字レシートバッファ　Class：RegsMem
  RXMEM_MP1_RCT(37),
  /// MULTIステータスバッファ　Class：RxInputBuf
  RXMEM_MULTI_STAT(38),
  /// 顧客リアルステータスバッファ　Class：RxInputBuf
  RXMEM_CUSTREAL_STAT(39),
  /// 顧客リアルSOCKET通信用共通メモリ　Class：RxSocket
  RXMEM_CUSTREAL_SOCKET(40),
  /// QcConnectステータスバッファ　Class：RxQcConnect
  RXMEM_QCCONNECT_STAT(41),
  /// クレジットSOCKET通信用共通メモリ　Class：RxSocket
  RXMEM_CREDIT_SOCKET(42),
  /// NECSOCKET通信用共通メモリ　Class：RxSocket
  RXMEM_CUSTREAL_NECSOCKET(43),
  /// 自走式磁気リーダ　Class：RxInputBuf
  RXMEM_MASR_STAT(44),
  /// キャッシュリサイクル　Class：RxInputBuf
  RXMEM_CASH_RECYCLE(45),
  /// レシート印字レシートバッファ　Class：RegsMem
  RXMEM_QCJC_C_PRN_RCT(46),
  /// 印字ステータスバッファ　Class：RxPrnStat
  RXMEM_QCJC_C_PRN_STAT(47),
  /// SQRCTicket　Class：RxInputBuf
  RXMEM_SQRC(48),
  /// レシート印字レシートバッファ(Kitchen1)　Class：RegsMem
  RXMEM_KITCHEN1_PRN_RCT(49),
  /// 印字ステータスバッファ(Kitchen1)　Class：RxPrnStat
  RXMEM_KITCHEN1_PRN_STAT(50),
  /// レシート印字レシートバッファ(Kitchen2)　Class：RegsMem
  RXMEM_KITCHEN2_PRN_RCT(51),
  /// 印字ステータスバッファ(Kitchen2)　Class：RxPrnStat
  RXMEM_KITCHEN2_PRN_STAT(52),
  /// 電子メール送信　Class：RxMailSender
  RXMEM_MAIL_SENDER(53),
  /// レシート印字レシートバッファ(ダミー)　Class：RegsMem
  RXMEM_DUMMY_PRN_RCT(54),
  /// 印字ステータスバッファ(ダミー)　Class：RxPrnStat
  RXMEM_DUMMY_PRN_STAT(55),
  /// 電子レシート処理　Class：RxNetReceipt
  RXMEM_NET_RECEIPT(56),
  /// ハイタッチ受信　Class：RxInputBuf
  RXMEM_HI_TOUCH(57),
  /// FenceOver入力情報フェンスオーバー化対応　Class：RxInputBuf
  RXMEM_FENCE_OVER_2(58),
  ;
//*********************
  final int id;
  const RxMemIndex(this.id);
  static get RXMEM_INDEX_MAX => RxMemIndex.values.last.id + 1;
}

/// 共有メモリ共通ヘッダ
///  関連tprxソース: rxmemctr.h - RX_CTRL
class RxCtrl {
  bool ctrl = false; // 制御フラグ(0:データなし/1:あり)
  String filter = ""; //予備
}

///  関連tprxソース: \inc\apl\rxmem.h - RX_SOCKET
class RxSocket {
  RxCtrl ctrl = RxCtrl();		  /* ヘッダ情報           */
  int order = 0;		  /* 1:クレジット要求電文 */
  /* 2:クレジット請求電文 */
  /* 3:会計実績電文       */
  /* 4:クレジット応答電文（受信終了） */
  int errNo = 0;		  /* エラー情報           */
  String data = ""; /* 電文データ（送受信） */
  String corrCd = "";	  /* クレジット訂正用カード番号 */

  int emvOffMode = 0;     /* 0:ONLINE 1:OFFLINE */
}

/// チェッカータスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_CHK
class RxTaskstatChk {
  int SpoolStat = 0;
  int	cash_pid = 0;
  int stat = 0;
  int intkey_flag = 0;         /* intkey flag */
  int intBook_flag = 0;
  int errstat_flag = 0;
  int reg_flg = 0;            /* Regs Check Flg for Dual */
  int err_stat = 0;           /* Error Check Flg for Dual */
  int stat_dual = 0;
  int selfmove_flg = 0;
  int selfctrl_flg = 0;
  String SelfGifPath = "";  // [128];
  int	qc_movie_x_offset = 0;	/* movie x offset */
  int	qc_movie_y_offset = 0;	/* movie y offset */
  int qc_movie_w_size = 0;	/* movie width */
  int qc_movie_h_size = 0;	/* movie height */
  int dlg_msg_chg = 0;
  String dlg_chg_msg = "";  // [128+10];
  int ELdual = 0;
  int sg_rfm_flg = 0;
  int fip_stop_flg = 0;
  int fnc_code = 0;       /* ファンクションコード */
  int movie_stat = 0;	/* movie playing stat */
  int sclstop_flg = 0;
  int sclstop_1time_flg = 0;
  String color_fip_movie_path = ""; // [128];
  int color_fip_movie_x = 0;
  int color_fip_movie_y = 0;
  int color_fip_movie_w = 0;
  int color_fip_movie_h = 0;
  int color_fip_movie_stat = 0;
  int autodscstl_par = 0;
  int	autodscstl_conf = 0;
  int qcjc_frcclk_flg = 0;
  int tab_active = 0;
  int notice_chk = 0;
  int chk_registration = 0;
  int stlkey_retn_function = 0;
  int colorfip_ctrl_flg = 0;
  int cin_total_price = 0;
  int kycash_redy_flg = 0;
  int ky_qcselect_flg = 0;
  int regs_start_flg = 0;
  int memo_set_flg = 0;
  int next_regs_start_chk = 0;
  int fip_notuse = 0;
  int staff_pw = 0;	//簡易従業員入力画面表示 0x01:表示中 0x02:処理中
}

/// キャッシャータスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_CASH
class RxTaskStatCash {
  int stat = 0;
  int err_stat = 0;
  int inout_flg = 0;
  int int_stat = 0;
  int chk_pid = 0;
  int menukey_flg = 0;
  int cmodkey_flg = 0;
  int fnc_code = 0;
  int int_ban_flg = 0;
  int qcjc_j_stat = 0;
  int autodscstl_conf = 0;
  int tab_active = 0;
  int notice_flg = 0;
  int redisp_flg = 0;
  int autostlky_flg = 0;
  int content_movie_stop_flg = 0;
  int regsret_stop_flg = 0;
  int cinreturn_flg = 0;
  int kycash_start_flg = 0;
  int regstart_chkflg = 0;
  int rwcrky_flg = 0;
  int ky_cash_cha_flg = 0;
  int self_mnt_ctrl_flg = 0;
  int vesca_charge_settle = 0;
  int staff_pw = 0;
  int notice_msg_cd = 0;
}

/// スプール管理タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_SPL
class RxTaskStatSpl {
  int spoolCnt = 0;
  int	spoolCntOld = 0;
}

/// ドロアタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_DRW
class RxTaskStatDrw {
  int result = 0; // ドライバ実行結果
  int prnStatus = 0; //long
  int drwStat = 0; //uchar
  int drwStat2 = 0; //uchar
}

/// プリンタタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_PRN
class RxTaskStatPrn {
  int stepCnt = 0;
  int errCode = 0;
  int rpKind = 0; // 切断なし印字制御
                  // 0:ヘッダ付き印字
                  // 1:ヘッダなし印字
                  // 2:切断のみ
/*
  RX_SCNCHK ScnChk;
  RX_ADDPNT AddPnt; // アヤハディオ様 ポイント加算対応
*/
  int syncGetNum = 0; // Printer Get Sync Number
  int init = 0;
  int prnrBufType = 0;
}

/// JPOタスクステータス
/// 関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_JPO
class RxTaskStatJpo{
  int price = 0;
  int ctr = 0;
// int order;
// //short     stat;
// int stat;
// int err_stat;
// tprmsgdevack2_t devack;
// short           s_cancel;
// char            req_data[1024];
// char            socket_flg;
// short           pay_condition;
// long		cct_suica_use_prc;
// short		cct_suica_any_flg;
// long		jmups_rcpt_no;
// long		jmups_seq_no;
// long		trm_slipno;
// char		err_no[8];
  int jmupsAcFlg = 0;
// short		currentservice;
// char            comp_cd[16];
// short		vesca_cvm;
// char		vesca_errcd[16];	/* 表示用エラーコード */
// char		vesca_errcd_detail[16];	/* エラーコード詳細 */
// short		vesca_edy_nearfull;	/* Edyニアフル制御用フラグ */
// short		vesca_end_act_chk;
// long		cafis_arch_seqno;
// char            accountnumber[16+1];    // 会員番号
// long            cancel_slip_no;         // 取消・返品用の元伝票番号
// char            t_card_number[16+1];    // Tカード会員番号(9桁または16桁)
// char            selected_media[20];     // 選択されたメディア(FeliCa/JIS2Mag)
// char            data_type[20];          // データタイプ
// char            idm_no[20];             // IDm情報
// long            felica_table_no;        // FeliCa使用の場合にアクセスしたテーブルのレコード番号
// char            block1_value[32+1];     // FeliCa使用の場合に読み込んだブロック１のデータ
// char            block2_value[32+1];     // FeliCa使用の場合に読み込んだブロック２のデータ
// char            block3_value[32+1];     // FeliCa使用の場合に読み込んだブロック３のデータ
// char            block4_value[32+1];     // FeliCa使用の場合に読み込んだブロック４のデータ
// char            block5_value[32+1];     // FeliCa使用の場合に読み込んだブロック５のデータ
// char            block6_value[32+1];     // FeliCa使用の場合に読み込んだブロック６のデータ
// char            block7_value[32+1];     // FeliCa使用の場合に読み込んだブロック７のデータ
// char            block8_value[32+1];     // FeliCa使用の場合に読み込んだブロック８のデータ
// char            jis2_data[69+1];        // JIS2磁気データ
// short           custom_code;            // カスタムコード
// char		cafis_arch_service[8];	// CAFIS Arch業務区分
// short		kid_emoney_kind;
// long		settledamount;		// 決済額
// long		beforebalance;		// 決済前残高
// short		jetbcrdt_corp_cd;		// KID
// short		jetbcrdt_payment_div;		// 支払区分
// short		jetbcrdt_bonus_cnt;		// ボーナス回数
// char		jetbcrdt_bouns_month[20];	// ボーナス月
// long		jetbcrdt_bouns_amt; 		// ボーナス金額
// short		jetbcrdt_start_month;		// 支払開始月
// short		jetbcrdt_division_cnt;		// 分割回数
// long		jetbcrdt_first_amt;		// 初回金額
// char		creditCompanyCode[7+1];			// カード会社コード
// char		creditCompanyName[64+2];		// カード会社名
// char		creditCompanyNameJp[64+2];		// カード会社名（全角）
// char		cardNetwork[32+2];			// カードネットワーク名
// char		lumpSumType[2+1];			// 支払い区分コード：一括
// char		bonusType[2+1];				// 支払い区分コード：ボーナス
// char		bonusComboType[2+1];			// 支払い区分コード：ボ併
// char		installmentType[2+1];			// 支払い区分コード：分割
// char		revolvingType[2+1];			// 支払い区分コード：リボ
// char		minAmountInstalment[8+1];		// 分割払い最低金額
// char		instalmentPlan[64+1];			// 分割回数パターン
// char		minAmountBonus[8+1];			// ボーナス払い最低金額
// char		bonusAvailableMonth[32+1];		// ボーナス払い可能月
// char		creditCompanyTel[15+1];			// 電話番号
// short		wait_next_timeout;			// カードを支払い方法の電文を受信するまでのタイムアウト（秒）
// char		vesca_accountnumber2[20];		// 会員番号
// short		paymentcondition;			// 支払区分
// short		firstmonth;				// 支払開始月
// short		numinstalment;				// 分割回数
// long		firstamount;				// 初回金額
// short		numbonus;				// ボーナス回数
// short		bonusmonth1;				// ボーナス月1
// short		bonusmonth2;				// ボーナス月2
// short		bonusmonth3;				// ボーナス月3
// short		bonusmonth4;				// ボーナス月4
// short		bonusmonth5;				// ボーナス月5
// short		bonusmonth6;				// ボーナス月6
// long		bonusamount1;				// ボーナス金額1
// long		bonusamount2;				// ボーナス金額2
// long		bonusamount3;				// ボーナス金額3
// long		bonusamount4;				// ボーナス金額4
// long		bonusamount5;				// ボーナス金額5
// long		bonusamount6;				// ボーナス金額6
// char		datetime[20+1];				// 取引日時 YY/MM/DD HH:MM:SS
// short		ispaymentdetails;			// 支払情報
// short		param;					// 電文区分（0:通常、1:拡張1、2:拡張2）
// short		felica_id_mark1;			// IDマーク1
// short		felica_id_mark2;			// IDマーク2
// short		felica_id_mark3;			// IDマーク3
// short		felica_id_mark4;			// IDマーク4
// short		felica_id_mark5;			// IDマーク5
// short		felica_id_mark6;			// IDマーク6
// short		felica_id_mark7;			// IDマーク7
// short		felica_id_mark8;			// IDマーク8
// short		vesca_lang;				// Verifone表示言語指定用
// long		balance;				// 残高
  int vesca_currentservice = 0;			// 電子マネーブランド判定用
// char		vesca_errdetail[16];			// 電子マネーエラーコード詳細判定用
// short		vesca_error_order;			// 電子マネーエラー判定用
// char		vesca_status_cd[4+1];			// Verifone状態通知コード
// short		gmo_timeout;				// VEGA端末 通信強制終了フラグ
// char		cancel_auth_no[20];			// 元取引承認番号
// char		statement_id[20];			// 1件明細ID
// long		subamount_month;			// 当月利用金額合計
// long		subamount_day;				// 本日利用金額合計
// char		qr_brand[2+1];				// QRコード決済ブランド
// short           vesca_waon_retch;                       // WAON再タッチフラグ
// short           vesca_balance_inq;                       // 残高照会時フラグ
// RX_LANE_INFO	lane_info;
}

/// 共有メモリインデックス
///  関連tprxソース: \inc\apl\rxmem.h - RXMEM_IDX
enum RXMEM_IDX {
  RXMEM_COMMON,
  /* 全タスク共通メモリ */
  RXMEM_STAT,
  /* タスクステータス */
  RXMEM_CHK_INP,
  /* チェッカー入力情報 */
  RXMEM_CASH_INP,
  /* キャッシャー入力情報 */
  RXMEM_CHK_RCT,
  /* チェッカーレシートバッファ */
  RXMEM_CASH_RCT,
  /* キャッシャーレシートバッファ */
  RXMEM_UPD_RCT,
  /* 実績加算レシートバッファ */
  RXMEM_PRN_RCT,
  /* レシート印字レシートバッファ */
  RXMEM_PRN_STAT,
  /* 印字ステータスバッファ */
  RXMEM_CHK_CASH,
  /* 割込入力情報 */
  RXMEM_ACX_STAT,
  /* ACXステータスバッファ */
  RXMEM_JPO_STAT,
  /* JPOステータスバッファ */
  RXMEM_SOCKET,
  /* SOCKET通信用共通メモリ */
  RXMEM_SCL_STAT,
  /* SCLステータスバッファ */
  RXMEM_RWC_STAT,
  /* RWCステータスバッファ */
  RXMEM_STROPNCLS,
  /* 開閉設入力情報 */
  RXMEM_SGSCL1_STAT,
  /* セルフゲートSCL1ステータスバッファ */
  RXMEM_SGSCL2_STAT,
  /* セルフゲートSCL2ステータスバッファ */
  RXMEM_PROCINST,
  /* PROCESS CONTROL 入力情報 */
  RXMEM_ANOTHER1,
  /* another1入力情報 */
  RXMEM_ANOTHER2,
  /* another2入力情報 */
  RXMEM_PMOD,
  /* pmod情報 */
  RXMEM_SALE,
  /* sale_com_mm情報 */
  RXMEM_REPT,
  /* report情報 */
  RXMEM_STPR_RCT,
  /* ステーションプリンタ印字レシートバッファ */
  RXMEM_STPR_STAT,
  /* 印字ステータスバッファ */
  RXMEM_MNTCLT,
  /* menteclient information */
  RXMEM_SOUND,
  /* 音声情報(卓上部) */
  RXMEM_S2PR_RCT,
  /* ステーションプリンタ印字レシートバッファ */
  RXMEM_S2PR_STAT,
  /* 印字ステータスバッファ */
  RXMEM_BANK_STAT,
  /* BANKステータスバッファ */
  RXMEM_NSC_RCT,
  /* BANKレシートバッファ */
  // TODO:10010 コンパイルスイッチ(FB_FENCE_OVER) 有効だと下記enumが有効だが、無効だとenumの定義が飛ばされる
  //            飛ばさずに定義したままで良いならそちらの方が実装が楽だが、indexを利用しているものがあるとずれてしまうので要確認.
  RXMEM_FENCE_OVER,
  /* FenceOver入力情報 */
  RXMEM_SOUND2,
  /* 音声情報(タワー部) */
  RXMEM_SUICA_STAT,
  /* SUICAステータスバッファ */
  RXMEM_ACXREAL,
  /* 釣銭釣札機リアル問い合わせ処理 */
  RXMEM_MP1_RCT,
  /* MP1印字レシートバッファ */
  RXMEM_MULTI_STAT,
  /* MULTIステータスバッファ */
  RXMEM_CUSTREAL_STAT,
  /* 顧客リアルステータスバッファ */
  RXMEM_CUSTREAL_SOCKET,
  /* 顧客リアルSOCKET通信用共通メモリ */
  RXMEM_QCCONNECT_STAT,
  /* QcConnectステータスバッファ */
  RXMEM_CREDIT_SOCKET,
  /* クレジットSOCKET通信用共通メモリ */
  RXMEM_CUSTREAL_NECSOCKET,
  /* NEC SOCKET通信用共通メモリ */
  RXMEM_MASR_STAT,
  /* 自走式磁気リーダ */
  RXMEM_CASH_RECYCLE,
  /* キャッシュリサイクル */
  RXMEM_QCJC_C_PRN_RCT,
  /* レシート印字レシートバッファ */
  RXMEM_QCJC_C_PRN_STAT,
  /* 印字ステータスバッファ */
  RXMEM_SQRC,
  /* SQRC Ticket */
  RXMEM_KITCHEN1_PRN_RCT,
  /* レシート印字レシートバッファ(Kitchen1) */
  RXMEM_KITCHEN1_PRN_STAT,
  /* 印字ステータスバッファ(Kitchen1) */
  RXMEM_KITCHEN2_PRN_RCT,
  /* レシート印字レシートバッファ(Kitchen2) */
  RXMEM_KITCHEN2_PRN_STAT,
  /* 印字ステータスバッファ(Kitchen2) */
  RXMEM_MAIL_SENDER,
  /* 電子メール送信 */
  RXMEM_DUMMY_PRN_RCT,
  /* レシート印字レシートバッファ(ダミー) */
  RXMEM_DUMMY_PRN_STAT,
  /* 印字ステータスバッファ(ダミー) */
  RXMEM_NET_RECEIPT,
  /* 電子レシート処理 */
  RXMEM_HI_TOUCH,
  /* ハイタッチ受信 */

  RXMEM_TBLMAX, /*  */
}

/// 従業員情報
///  関連tprxソース: \inc\apl\rxmem.h - STAFF_INFO
class StaffInfo {
  int staffCd = 0;
  String name = "";
  int authLvl = 0;
}

/// 音声タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_SOUND
class RxTaskStatSound {
  int errCode = 0;
  int stop = 0;
}

/// スキャナタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_SCAN
class RxTaskStatScan {
  double stime = 0;
  int		status = 0;
  int		scan_flg = 0;
}

/// Repicaタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_REPICA
class RxTaskStatRepica {
  int	order = 0;
  int sub = 0;
  int stat = 0;
  int	scan_flg = 0;	/* レピカ(アララ)標準用 CODE128のバーコードが可変桁のため"devNotifyScannerMain()"で読取モード時に処理するためのフラグ */
  //RXMEM_REPICA_TX		tx_data;
  //RXMEM_REPICA_RX		rx_data;
}

/// バーコード決済タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_BCDPAY
class  RxTaskStatBcdpay {
  int	type = 0;	/* 決済タイプ */
  int	order = 0;
  int	cancel_flg = 0;
  int	scan_flg = 0;			/* CODE128のバーコードが可変桁のため"devNotifyScannerMain()"で読取モード時に処理するためのフラグ */
  int	scan_qcjc_qc_flg = 0;	/* 上記をqcjc時にqc側へ処理するためのフラグ */
  int	stat = 0;
  // RXMEM_BCDPAY_TX		tx_data;
  // RXMEM_BCDPAY_RX		rx_data;
}

/// EE社 AIBOX通信タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_AIBOX
class RxTaskStatAibox {
  int     code = 0;		// ステータスコード(101～112)
  int     totalQuantiity = 0;	// 合計点数(コード107用)
  int     timestamp = 0;	// UNIX TIME
  String  msg = "";		// ステータスに準じたメッセージ
  int     state = 0;		// AIBOX通信タスクの状態を他タスクに通知する(0:nouse, 1:use, -1:err)
// ステータス使用タスク → スキャンドライバ, 登録タスク
}

///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_BASKET_SERVER
class RxTaskStatBasketServer {
  // int			order;				/* オーダー */
  // char			url[256];			/* URL */
  // SND_API_4_2		snd_api_4_2;
  // RCV_API_4_2		rcv_api_4_2;
  // SND_API_4_7		snd_api_4_7;
  // RCV_API_4_7		rcv_api_4_7;
  // SND_API_4_9		snd_api_4_9;
  // RCV_API_4_9		rcv_api_4_9;
  // SND_API_6_1		snd_api_6_1;
  // RCV_API_6_1		rcv_api_6_1;
  // SND_API_7_1		snd_api_7_1;
  // RCV_API_7_1		rcv_api_7_1;
  // SND_API_8_1		snd_api_8_1;
  // RCV_API_8_1		rcv_api_8_1;
  // SND_API_9_1		snd_api_9_1;
  // RCV_API_9_1		rcv_api_9_1;
  // SND_API_10_1		snd_api_10_1;
  // RCV_API_10_1		rcv_api_10_1;
  // SND_API_FIXED_SALES	snd_api_fixed_sales;
  RcvApiFixedSales	rcv_api_fixed_sales = RcvApiFixedSales();
  // MAKE_API		make_api_4_9;
  // RCV_API_4_9		make_rcv_api_4_9;
  // MAKE_API		make_api_fixed_sales;
  // RCV_API_FIXED_SALES	make_rcv_api_fixed_sales;
  // int             	test_srv_flg;			/* テストサーバー接続 しない/する */
  // char			api_key[44+1];			/* レジ固有番号 */
  // char			stre_token[44+1];		/* 通信キー */
  // char			reg_ver[15+1];			/* レジバージョン */
  // char			submst_ver[15+1];		/* サブマスタ */
  // long			companyCode;			/* 企業コード */
  // long			storeCode;			/* 店舗コード */
  // CURLcode		res;				/* データレスポンス */
  // long			res_code;			/* レスポンスコード */
  // short			server_timeout;			/* レスポンスコード */
  // short			thread_timeout;			/* 実績送信スレッド接続タイムアウト */
  // char			proxy[46];			/* Shop&Go Proxyサーバー ホスト名 */
  // long			proxy_port;			/* Shop&Go Proxyサーバー ポート番号 */
}

/// NTT DATA Precaタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_NTTDPRECA
class RxTaskStatNttPreca {
  int order = 0;
  int sub = 0;
  int stat = 0;
  RxMemNttdPrecaTx txData = RxMemNttdPrecaTx();
  RxMemNttdPrecaRx rxData = RxMemNttdPrecaRx();
}

/// 音声情報
///  関連tprxソース: soundini.h - RX_SOUNDINI
class RxSoundIni {
  int wav_use = 0;
  /* ガイダンス音声 */
  int left_volume = 0; /* 右スピーカーの音量 		*/
  int right_volume = 0; /* 左スピーカーの音量 		*/
  /*----------------------------------------------------------------------*/
  /* 音声合成装置'HD AIVoice'の設定					*/
  /* (sound.iniのｾｸｼｮﾝ[hdaivoice]の設定)					*/
  /*----------------------------------------------------------------------*/
  int voice_volume = 0; /* 音声の音量(0～100)		*/
  int voice_speed = 0; /* 話速変換倍率(70～130)	*/
  int effect_volume0 = 0; /* 効果音０の音量(0～100)	*/
  int effect_volume1 = 0; /* 効果音１の音量(0～100)	*/
  int effect_volume2 = 0; /* 効果音２の音量(0～100)	*/
  int effect_volume3 = 0; /* 効果音３の音量(0～100)	*/
  int effect_volume4 = 0; /* 効果音４の音量(0～100)	*/
  int effect_volume5 = 0; /* 効果音５の音量(0～100)	*/
  int effect_volume6 = 0; /* 効果音６の音量(0～100)	*/
  int effect_volume7 = 0; /* 効果音７の音量(0～100)	*/
  int effect_volume8 = 0; /* 効果音８の音量(0～100)	*/
  int effect_volume9 = 0; /* 効果音９の音量(0～100)	*/
  /*----------------------------------------------------------------------*/
  /* 音声合成装置'AR-STTS-01'の設定					*/
  /* (sound.iniのｾｸｼｮﾝ[arsttsvoice]の設定)				*/
  /*----------------------------------------------------------------------*/
  int arstts_voice_volume = 0; /* 音量(0～255)			*/
  int arstts_voice_loudness = 0; /* 音程(0～2)			*/
  int arstts_voice_speed = 0; /* 話速(0～2)			*/
  int arstts_voice_leave = 0; /* 読み上げ開始までの間隔(ﾐﾘ秒)	*/
  /* volume ( Web2300, WebPrimePlus ) */
  int G1R = 0; /* 元SUBCPU sound 		*/
  int G1L = 0; /* 元SUBCPU sound 		*/
  int G2 = 0; /* Self sound			*/
  int VIA_DXS1 = 0; /* VIA_DXS1 			*/
  int VIA_DXS2 = 0; /* VIA_DXS2 			*/
  int VIA_DXS3 = 0; /* VIA_DXS3 			*/
  int VIA_DXS4 = 0; /* VIA_DXS4 			*/
  int ERR_R = 0; /* エラー音量(本体)		*/
  int ERR_L = 0; /* エラー音量(タワー)		*/
  int WARN_R = 0; /* 警告音量(本体)		*/
  int WARN_L = 0; /* 警告音量(タワー)		*/
  int FNFL_R = 0; /* ファンファーレ音量(本体)	*/
  int FNFL_L = 0; /* ファンファーレ音量(タワー)	*/
  int POPUP_R = 0; /* ポップアップ音量(本体)	*/
  int POPUP_L = 0; /* ポップアップ音量(タワー)	*/
  int VERIFONE_R = 0; /* Verifone音量(本体)	*/
  int VERIFONE_L = 0; /* Verifone音量(タワー)	*/
  /* designated */
  int D_Left = 0; /* 左 指定音量 0 - 10		*/
  int D_Right = 0; /* 右 指定音量 0 - 10		*/
  /* pitch ( Web2300, WebPrimePlus ) */
  int CLICK_NUM_R = 0; /* キー入力音、選択番号（卓上） 	*/
  int CLICK_NUM_L = 0; /* キー入力音、選択番号（タワー） 	*/
  int CLICK_R = 0; /* キー入力音、音程（卓上） 		*/
  int CLICK_L = 0; /* キー入力音、音程（タワー） 		*/
  int ERR_NUM_R = 0; /* エラー音、選択番号（卓上） 		*/
  int ERR_NUM_L = 0; /* エラー音、選択番号（タワー） 	*/
  int FANFARE1_NUM_R = 0; /* ファンファーレ１、選択番号（卓上） 	*/
  int FANFARE1_NUM_L = 0; /* ファンファーレ１、選択番号（タワー）	*/
  int FANFARE2_NUM_R = 0; /* ファンファーレ２、選択番号（卓上） 	*/
  int FANFARE2_NUM_L = 0; /* ファンファーレ２、選択番号（タワー）	*/
  int FANFARE3_NUM_R = 0; /* ファンファーレ３、選択番号（卓上） 	*/
  int FANFARE3_NUM_L = 0; /* ファンファーレ３、選択番号（タワー） */
  int BIRTH_NUM_R = 0; /* 記念日、選択番号（卓上） 		*/
  int BIRTH_NUM_L = 0; /* 記念日、選択番号（タワー） 		*/
  int POPUP_NUM_R = 0; /* ポップアップ、選択番号（卓上） 		*/
  int POPUP_NUM_L = 0; /* ポップアップ、選択番号（タワー） 		*/
  int VERIFONE_NUM_R = 0; /* Verifone処理未了、選択番号（卓上）	*/
  int VERIFONE_NUM_L = 0; /* Verifone処理未了、選択番号（タワー）*/
  /* staffid: 特定社員証1仕様 */
  int staffid_left_volume = 0; /* (特定社員証1仕様)左スピーカーの音量 		*/
  int staffid_right_volume = 0; /* (特定社員証1仕様)右スピーカーの音量 		*/
}

/// デバイス情報
///  関連tprxソース: \inc\apl\rxmem.h - RX_DEV_INF
class RxDevInf {
  int devId = 0;
  int stat = 0;
  String data = ""; // data[sizeof(tprmsgdevreq2_t)];	/* データ */
  String filler = ""; //char	filler[1];
  String adonCd = ""; //char	adon_cd[5]; adon code
  String itfAmt = ""; //char	itf_amt[9]; ITF Barcode
  String salelmt = "";   /* Sale Limit Disc Barcode */
  int barCdLen = 0; // Scannr Input Code Length
  String barData = ""; // Special Disc Barcode(18degit)
  int bcdSeqNo = 0; // バーコード段数
}

/// default mechakey data
///  関連tprxソース: rxmem.h - MKEYNUMTBL
class MkeyNumTbl {
  int hiKcd = 0;
  int loKcd = 0;
  String num = "";

  ///  関連tprxソース: rxmem.h - MKEYNUM_MAX
  static const MKEYNUM_MAX = 35;
}

/// 入力情報
///  関連tprxソース: \inc\apl\rxmem.h - RX_INPUT_BUF
class RxInputBuf {
  RxCtrl ctrl = RxCtrl();
  RxDevInf devInf = RxDevInf();
  int hardKey = 0;
  String mecData = "";
  int funcCode = 0;
  int smlclsCd = 0; // 小分類コード.
  int appGrpCd = 0; // アプリケーショングループコード.
  RxMemIndex rxMemIndex = RxMemIndex.RXMEM_NON;
  RxRegsinst? inst;
}


///-----------------------------------------------------------------------------

/*----- SUICAタスクステータス -----*/
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_SUICA
class RxTaskstatSuica {
// TODO:00011 周 rc_key_cash.dart実装中、構造体の中身を全部コピペしてきたが
// TODO:00011 周 （上の行と続く）必要な部分だけ先行実装、ほかの部分は一旦コメントアウト
// long            price;        /* 引去金額   */
// unsigned long   before_price; /* 引去金額   */
// long            after_price;  /* 取引後残額 */
// unsigned long   rest;         /* カード残額 */
// unsigned long   cncl_amt;     /* 取消金額   */
// unsigned long   price2;
// unsigned short  detcnt;       /* 残り一件明細件数 */
// unsigned short  rct_id;       /* 一件明細ID */
// unsigned short  seq_ic;       /* IC取扱通番 */
// unsigned short  sf_log;       /* SFログID */
// unsigned short  act_cd;       /* 活性化事業者コード */
// unsigned char   rct_date[7];  /* 一件明細作成時間 */
// unsigned char   cmd_cd;       /* コマンドコード */
// unsigned char   sub_cd;       /* サブコード */
// short           ctr;
  int order = 0;
// short           stat;
// char            mode;
// uchar           end_cd;
// short           err_stat;
  int transFlg = 0;
  int timeFlg = 0;
// char            idi[17];        /* カードIDi */
// char            ng_res[49];
// char            buf[256];
// short           Time_Set;
// MULTI_BUF       multi_buf;    /* 取引/障害ログバッファ */
// short           Alarm_flg;
// short           sub_order;
// char            card_type;
// short           step;
// unsigned long   charge_amt;
// unsigned short  charge_cnt;
  NimocaData nimocaData = NimocaData();   /* nimoca用バッファ */
// tprmsgdevack2_t devack;
}

///  RCRWタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_RWC
class RxTaskstatRwc {
  ///TODO:00014 日向 現計対応のため定義のみ先行実装
  int order = 0;
  // short		stat;
  // short           ejct;
  // TRC_TR          trctrack;  /* Track data(track1-track3) */
  // TRC_DATA        trcdata;   /* Track data(magn/prn data) */
  // ORC_WR_IWAI     orcdata;   /* Oki Data                  */
  // FSP_TR          fsptrack;  /* Track data(track1-track3) */
  // FSP_DATA        fspdata;   /* Track data(magn/prn data) */
  // T_VMC_MGNT_P    vmcpdata;  /* vismac apl data           */
  // T_VMC_MGNT_T    vmctdata;  /* vismac magnetic data      */
  // T_VMC_VSAL_P    vmcvdata;  /* vismac visual data        */
  // PSP_RSTAT       crwpstat;  /* Glory Status              */
  // CRWP_RWD_DATA   crwpdata;  /* Glory Data                */
  // long            crwpprep;  /* Glory non print point     */
  // short           cnt;       /* Glory retry count         */
  // PANA_DATA       panadata;  /* Pana Data                 */
  // #if PSP_70
  // PSP70_CARDDATA    psp70_carddata;
  // PSP70_APLSTAT     psp70_apldata;
  // #endif
  // #if SAPPORO
  // PANA_SPD_DATA   sapporo_panadata;  /* Sapporo Drug Pana Data */
  // PANA_JKL_DATA   jkl_panadata;  /* Jakkulu Drug Pana Data */
  // PANA_RAINBOW_DATA rainbow_panadata; /* Rainbow Card Data */
  // PANA_MATSUGEN_DATA mgn_panadata;    /* Matstugen Pana Data */
  // PANA_MRY_DATA   mry_panadata;      /* Moriya Pana Data */
  // #endif
  // MCP_DATA        mcp_data;  /* Mcp200 Data */
  // MCP_STAT        mcp_stat;  /* Mcp200 Status */
  // long            today_point;  /* Card Today Point Data */
  // short           use_prepaid;  /* ABS-S31K Use Prepaid */
  // HT2980_CARDINFO   ht_cardinfo;   /* HT2980 CardInfo    */
  // HT2980_WRITE      ht_write;      /* HT2980 Write       */
  // HT2980_WRITE_R    ht_write_data; /* HT2980 WriteResult */
  // ABSV31_DATA	absv31_data;	/* ABS_V31 data */
  // short		absv31_flg;	/* ABS_V31 flg */
  // tprmsgdevack2_t devack;
}

///  管理ＰＣ送信用タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_MANAGEPC
class RxTaskStatManagePc {
  String msgLogBuf = "";
}

///  MULTIタスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_MULTI
class RxTaskstatMulti {
  // TODO:00011 周 rc_key_cash.dart実装中、構造体の中身を全部コピペしてきたが
  // TODO:00011 周 （上の行と続く）必要な部分だけ先行実装、ほかの部分は一旦コメントアウト
  int	autoFlg = 0;
  // short		off_flg;
  int order = 0;
  int flg = 0;
  int errCd = 0;
  int step = 0;
  int step2 = 0;
  FclData fclData = FclData();
  // NIMOCA_DATA     nimoca_data;   /* nimoca用バッファ */
  // tprmsgdevack2_t	devack;
}

/// Cust Real2タスクステータス
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_CUSTREAL2
class RxTaskstatCustreal2 {
  int order = 0;
  int sub = 0;
  int stat = 0;
  RxMemCustReal2Data data = RxMemCustReal2Data();
}

enum RxMemAttn {
  NON(0),
  MAIN_TASK(1),
  MASTER(2),
  SLAVE(3);
  //*********************
  final int value;
  const RxMemAttn(this.value);
}

/// 免税電子化タスクステータス
/// 関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_TAXFREE
class RxTaskStatTaxfree {
  int	stat = 0;
  int	order = 0;
  int	errCd = 0;
  String errMsg = '';
  int result = 0;
  int	timeOut = 0;		//通信timeout
  String posCode = '';		//端末番号
  int corpCode = 0;		//企業コード
  int shopCode = 0;		//店舗コード
  String termCode = '';	//端末識別子
  String tranInfo = '';		//登録ファイル情報
  String voucherNum = '';		//伝票番号
  String cnclVoucherNum = '';	//取消伝票番号
  // TODO:00011 周 必要な部分だけ先行実装、ほかの部分は一旦コメントアウト、必要になる時改めて実装する予定
  // TAXFREE_REF_DATA	refData;	//サーバーデータ参照した取引情報
  int	serverTyp = 0;		//接続先 0:商用　1：デモ
  int	regsTranMode = 0;		//登録モード　0：通常　1：訓練
  int	tranErr = 0;		//登録実績チェック　0：正常　1：異常（同じ免税伝票番号の実績が存在）
}

/// ACRタスクステータス
/// 関連tprxソース: rxmem.h - RX_TASKSTAT_ACX
class RxTaskStatAcx {
  int order = 0;
  int seqNo = 0;
  int stat = 0;
  String jsonFileName = '';    // 釣銭機JSONファイル名
  CoinStock coinStock = CoinStock();
  CinInfo cinInfo = CinInfo();
  CinReadEcs cinInfoEcs = CinReadEcs();
  StateSst1 stateSst1 = StateSst1();
  StateEcs stateEcs = StateEcs();
  StateAcb stateAcb = StateAcb();
  StateFal2 stateFal2 = StateFal2();
  LastData lastData = LastData();
  int acxRealFlg = 0;  //acxreal 釣銭機への問合せ  0:続行 1:停止
  int acxRealStep = 0;  //acxreal 処理ステップ（衝突回避のための情報）
  TprMsgDevAck2_t devAck = TprMsgDevAck2_t();
  int acxResWrite = 0;
  int retryCnt = 0;
  int stockReady = 0;
  int pData = 0;  //コマンドのパラメーター指定
  CBillKind cBillKind = CBillKind();  //コマンドのパラメーター(金種データ)
  int initFlg = 0;  //釣銭機初期化処理フラグ 0:なし 1:初期化実行予約 2:初期化実行中 3:初期化アクション終了（釣機側処理中）
  StockState stockState = StockState();
  List<String> pickStatus = List.generate(2, (_) => ''); //ドライバ内回収レスポンス監視状況
  int errMsg = 0; // エラーダイアログ番号を格納 (登録画面での接続チェック時に一部セットし、それ以外は正常 0とする. )
  HolderDataFlg holderStatus = HolderDataFlg(); // 釣銭機内枚数の状態 (保留枚数取得時にセット)
}

/// MASRタスクステータス
/// 関連tprxソース: rxmem.h - RX_TASKSTAT_MASR
class RxTaskStatMasr {
  int order = 0;  /* ORDER_READ_START=リード開始　 ORDER_CNCL_START=リード終了 */
  int cardStat = 0;  /* MASR_RES_CARD_NONE=カードなし  MASR_RES_CARD_GATE=ゲートイン  MASR_RES_CARD_IN=カードイン */
  int errCd = 0;			/*  エラーコード */
  int ejectFlg = 0;		/*  リード後にリジェクトしない */
}

/// RCRWタスクステータス
/// 関連tprxソース: rxmem.h - RX_TASKSTAT_RWC
/*-----  -----*/
class RxTaskStatRwc {
  int order = 0;
  int stat = 0;
  int ejct = 0;
  /*
  TRC_TR          trctrack;  /* Track data(track1-track3) */
  TRC_DATA        trcdata;   /* Track data(magn/prn data) */
  ORC_WR_IWAI     orcdata;   /* Oki Data                  */
  FSP_TR          fsptrack;  /* Track data(track1-track3) */
  FSP_DATA        fspdata;   /* Track data(magn/prn data) */
  T_VMC_MGNT_P    vmcpdata;  /* vismac apl data           */
  T_VMC_MGNT_T    vmctdata;  /* vismac magnetic data      */
  T_VMC_VSAL_P    vmcvdata;  /* vismac visual data        */
  PSP_RSTAT       crwpstat;  /* Glory Status              */
  CRWP_RWD_DATA   crwpdata;  /* Glory Data                */
  long            crwpprep;  /* Glory non print point     */
  short           cnt;       /* Glory retry count         */
  PANA_DATA       panadata;  /* Pana Data                 */
  PSP70_CARDDATA    psp70_carddata;
  PSP70_APLSTAT     psp70_apldata;
  PANA_SPD_DATA   sapporo_panadata;  /* Sapporo Drug Pana Data */
  PANA_JKL_DATA   jkl_panadata;  /* Jakkulu Drug Pana Data */
   */
  PanaRainbowData rainbowPanaData = PanaRainbowData(); /* Rainbow Card Data */
  /*
  PANA_MATSUGEN_DATA mgn_panadata;    /* Matstugen Pana Data */
  PANA_MRY_DATA   mry_panadata;      /* Moriya Pana Data */
  MCP_DATA        mcp_data;  /* Mcp200 Data */
  MCP_STAT        mcp_stat;  /* Mcp200 Status */
  long            today_point;  /* Card Today Point Data */
  short           use_prepaid;  /* ABS-S31K Use Prepaid */
  HT2980_CARDINFO   ht_cardinfo;   /* HT2980 CardInfo    */
  HT2980_WRITE      ht_write;      /* HT2980 Write       */
  HT2980_WRITE_R    ht_write_data; /* HT2980 WriteResult */
  ABSV31_DATA	absv31_data;	/* ABS_V31 data */
  short		absv31_flg;	/* ABS_V31 flg */
  tprmsgdevack2_t devack;
   */
}

/// VEGA3000タスクステータス
/// 関連tprxソース: rxmem.h - RXMEM_VEGA_CARD
/* VEGA3000端末カード情報取得用 */
class RxMemVegaCard {
  late int cardType; // カードタイプ(D_ICCD1 / D_MCD2)
  late int type; // カード利用区分
  List<String> cardData1 = List.generate(38 + 1, (_) => ""); // カード情報１
  List<String> cardData2 = List.generate(70 + 1, (_) => ""); // カード情報２
  List<String> errCode = List.generate(4 + 1, (_) => ""); // エラーコード
  List<String> msg1 = List.generate(24 + 1, (_) => ""); // メッセージ１
  List<String> msg2 = List.generate(24 + 1, (_) => ""); // メッセージ２
}

/// 関連tprxソース: rxmem.h - RX_TASKSTAT_VEGA
class RxTaskStatVEGA {
  int vegaOrder = VegaOrder.VEGA_NOT_ORDER.cd;
  RxMemVegaCard vegaData = RxMemVegaCard(); // VEGA3000使用 data buffer
}

/// タスクステータス定義
///  関連tprxソース: \inc\apl\rxmem.h - RX_TASKSTAT_BUF
class RxTaskStatBuf {
  RxCtrl ctrl = RxCtrl();
  int syst = 0;
  RxTaskstatChk chk = RxTaskstatChk();
  RxTaskStatCash cash = RxTaskStatCash();
  RxTaskStatSpl spl = RxTaskStatSpl();
  RxTaskStatDrw drw = RxTaskStatDrw();
  RxTaskStatDrw qcjccDrw = RxTaskStatDrw();
  RxTaskStatJpo jpo = RxTaskStatJpo();
  RxTaskStatSound sound = RxTaskStatSound();
  RxTaskStatScan scan = RxTaskStatScan();
  RxTaskStatRepica repica = RxTaskStatRepica();
  RxTaskStatBcdpay bcdpay = RxTaskStatBcdpay();
  RxTaskStatAibox aibox = RxTaskStatAibox();
  RxTaskstatSuica suica = RxTaskstatSuica();
  RxTaskStatManagePc managePc = RxTaskStatManagePc();
  RxTaskstatHqhist hqhist = RxTaskstatHqhist();
  RxTaskstatMulti multi = RxTaskstatMulti();
  RxTaskstatCustreal2	custreal2 = RxTaskstatCustreal2();
  RxTaskStatDrw kitchen1Drw = RxTaskStatDrw();
  RxTaskStatPrn print = RxTaskStatPrn();
  RxTaskStatPrn qcjccPrint = RxTaskStatPrn();
  RxTaskStatPrn kitchen1Print = RxTaskStatPrn();
  RxTaskStatDrw kitchen2Drw = RxTaskStatDrw();
  RxTaskStatDrw dummyDrw = RxTaskStatDrw();
  RxTaskStatBasketServer basketServer = RxTaskStatBasketServer();
  RxTaskStatMovieSend movSend = RxTaskStatMovieSend();
  RxTaskStatHqftp	hqftp = RxTaskStatHqftp();

  RxTaskStatNttPreca nttdPreca = RxTaskStatNttPreca();
  RxTaskStatTaxfree	taxfree = RxTaskStatTaxfree();
  RxTaskStatAcx acx = RxTaskStatAcx();
  RxTaskStatMasr masr = RxTaskStatMasr();
  RxMntclt mente = RxMntclt();
  RxQcConnect qcConnect = RxQcConnect();
  RxTaskStatRwc rwc = RxTaskStatRwc();
  RxTaskStatMcftp mcftp = RxTaskStatMcftp();
  RxTaskStatVEGA	vega = RxTaskStatVEGA();
  late DateTime catchDateTime1 = DateTime.parse('2000-01-01 00:00:00');
  late DateTime catchDateTime2 = DateTime.parse('2000-01-02 00:00:00');
  RxTaskStatNeccuatreal custrealNec = RxTaskStatNeccuatreal();
  RxTaskStatMsr msr = RxTaskStatMsr();

  static RxTaskStatBuf _instance = RxTaskStatBuf._internal();
  factory RxTaskStatBuf() {
    return _instance;
  }
  RxTaskStatBuf._internal();
}

/// 共有メモリ定義
///  関連tprxソース: \inc\apl\rxmem.h - RX_COMMON_BUF
class RxCommonBuf {
  int dual = 0;
  int scrmsgFlg = 0;
  int movieFlg = 0;		/* 0:none 1:order */
  int movieKind = 0;		/* 0:none 1:execution 2:pause 3:size change 4:stop */
  int movieOrder = 0;	/* movie file No. not 0:select  9999:select all  */
  int movieXOffset = 0;	/* movie x offset */
  int movieYOffset = 0;	/* movie y offset */
  int movieWSize = 0;	/* movie width */
  int movieHSize = 0;	/* movie height */
  int movieExec = 0;		/* infomation mplayer 0:stop 1:execution */
  int movieFrameFlg = 0;/* display of frame 0:no 1:yes */
  int devId = 0;
  bool batchRptFlag = false;
  int saveStaffCd = 0;
  int edySeterrFlg = 0;
  int kymenuUpFlg = 0;
  int csvServerFlg = 0;
  /// 単体キャッシュマネジメント自動精算送信*
  int manulStrcls = 0;
  
  // #if SIMPLE_2STAFF  /* 2004.01.13 */
  RxSimple2Stf stf2 = RxSimple2Stf();
  // #endif

  // --- クイックセットアップ系
  /// quick setup 0:no running 1:running
  QuickSetupTypeNo quickFlg = QuickSetupTypeNo.QUICK_SETUP_TYPE_NONE;
  /// process 0:no running 1:running
  bool quickProc = false;
  /// quick setup 0:returnbtn 1:nextbtn
  bool quickBtn = false;
  // --- qcjc系 ※2023年12月向け対象外.
  ///  QCashierJC動作 0:動作なし 1:動作中
  bool qcjcStat = false;
  int qcjc_c = 0;
  int qcjc_c_print = 0;
  int qcjc_voidmode_flg = 0;
  int qcjc_c_mntprn = 0;
  int qcjc_c_except = 0;
  int qcjc_frcclk_flg = 0;
  int auto_errstat = 0;	/* キャッシュマネジメント自動精算送信エラーMsg送信*/
  int sims_mente_copy = 0;	// マルチセグメント仕様でのコピー対応のため  0:動作なし  1:動作中

  /// QCJC 承認キー選択
  late List<List<int>> recog_qcjc = List.generate(
      RxMbrAtaChk.RECOG_PAGE_MAX,
      (_) => List.generate(
          RxMbrAtaChk.RECOG_FUNC_MAX, (_) => 0)); //rxprtflagset.c で値が設定される

  // --- タッチパネル
  int addTpanelConnect = 0; /* additional touch panel connected */

  // --- スキャナ
  int addScanFlg = 0; /* 3rdスキャナ制御フラグ 0:卓上側として処理 or 1:タワー側として処理 */
  RxVega3000Conf vega3000Conf = RxVega3000Conf();	/* VEGA3000関連設定値 */

  // --- プリンター
  int side_flag = 0;
  int auto_stropncls_run = 0;
  int kitchen_prn1_run = 0;
  int kitchen_prn1 = 0;
  int kitchen_prn2_run = 0;
  int kitchen_prn2 = 0;
  int printer_near_end = 0;
  int printer_near_end_JC_C = 0;
  int auto_strcls_errend = 0;	/* 自動閉設のエラー中断フラグ */

  // --- マシンの画面の型フラグ.
  bool vtclFhdFlg = false; //  縦型21.5インチ 判別フラグ  false:OFF true:ON
  bool vtclFhdFselfFlg = false; //  縦型15.6インチ対面 判別フラグ  false:OFF true:ON

  bool vtclRm5900Flg = false;
  bool vtclRm5900RegsOnFlg = false;
  int vtclRm5900RegsStlAcxFlg = 0;
  int vtclRm5900BarcodeFeedFlg = 0;
  /// RF1_SYSTEMが有効 RM-3800 1:在高入力時
  int vtclRm5900AmountOnHandFlg = 0;
  // --- psensor系.
  int psensorNoticeFlg = 0;
  int psensorSwingNoticeFlg = 0;
  int psensorSlowNoticeFlg = 0;
  int psensorAwayNoticeFlg = 0;
  int psensorDisptime = 0;
  int psensorSwingCntNow = 0; //  近接センサ空振り回数(現在)
  int psensorSwingCnt = 0; //  近接センサ空振り回数(設定)
  int psensorScanSlowSound = 0;
  int psensorAwaySound = 0;
  // --- recog
  bool recogKeyReadFlg = false;

  /// 承認キークリアキーのステータス
  ActivateStatus recogClrStatus = ActivateStatus.ACTIVATE_NONE;

  int revenueExclusion = 0;

  // --- メカキー関連.
  int mkeyD = 0;
  int mkeyT = 0;
  late MkeyInfo preMk = MkeyInfo();
  List<MkeyNumTbl> mkeyNumTbl =
      List.generate(MkeyNumTbl.MKEYNUM_MAX, (_) => MkeyNumTbl());

  // --- キャッシュレス還元系
  int clRestFlg = 0;

  /// HappySelf】簡易従業員設定値保存用
  int frcClkFlgCpt = 0;
  int mbrcdLength = 0; // member code length
  int magcdLength = 0;
  int wizSelfChg = 0;

  // --- usbcam
  int	usbcamStat = 0;	/* usbcam recording stat */
  int	usbcamDevStat = 0;	/* usbcam device stat */

  // -- その他
  int soundType = 0;
  int newhappyFlg = 0;
  int reverseFlg = 0;
  int dummy_prn = 0;

  // --- 設定ファイル/マスタ系------------------

  late CounterJsonFile iniCounter;
  late Mac_infoJsonFile iniMacInfo;
  late RxSysParam iniSysParam = RxSysParam();
  late SysJsonFile iniSys = SysJsonFile(); // sys.jsonで読みこんだ内容を全て保存しているのでini_scpuも含まれる
  bool iniSys_tower = false; // pCom->ini_sys.tower
  bool iniSys_msKind = true; // pCom->ini_sys.mskind
  late Scpu iniScpu = Scpu();
  late MbrrealJsonFile iniMbrreal;
  late RegInfoBuff dbRegCtrl = RegInfoBuff();
  late CStreMstColumns dbStr = CStreMstColumns();
  late CCompMstColumns dbComp = CCompMstColumns();
  late CtrlBuff dbCtrl = CtrlBuff();
  late TrmList dbTrm = TrmList();
  late CReportCntColumns dbReportCnt = CReportCntColumns();
  late COpencloseMstColumns dbOpenClose = COpencloseMstColumns();
  late List<TrmPlanBuff> dbTrmPlan =
      List.generate(CntList.trmplanMax, (_) => TrmPlanBuff());
  late CStaffopenMstColumns dbStaffopen = CStaffopenMstColumns();
  late List<CInstreMstColumns> dbInstre =
      List.generate(RxMem.DB_INSTRE_MAX, (_) => CInstreMstColumns());
  late List<CTaxMstColumns> dbTax =
      List.generate(RxMem.DB_TAX_MAX, (_) => CTaxMstColumns());
  late StrOpnClsBuf dbStrOpnCls = StrOpnClsBuf();

  // レシート印字用
  late List<MsgMstData> dbRecMsg =
      List.generate(DbMsgMstId.DB_MSGMST_MAX, (_) => MsgMstData());

  // TODO:10138 再発行、領収書対応 バックアップ
  // 再発行、領収書印字用バックアップ
  TTtlLog bkTtlLog = TTtlLog();
  CHeaderLog bkTHeader = CHeaderLog();
  CalcRequestParaItem? bkLastRequestData;
  late List<TItemLog> bkTItemLog = List.generate(CntList.itemMax, (_) => TItemLog());
  late List<TCrdtLog> bkTCrdtLog = List.generate(CntList.sptendMax, (_) => TCrdtLog());
  RxMemPrn bkPrnrBuf = RxMemPrn();
  RxMemTmp bkTmpBuf = RxMemTmp();

  // FIP用
  late List<MsgMstData> dbFipMsg =
      List.generate(DbMsgMstFipId.DB_MSGMST_FIP_MAX, (_) => MsgMstData());
  // カラー客表用
  late List<MsgMstData> dbColorDspMsg = List.generate(
      DbMsgMstColorDspId.DB_MSGMST_COLORDSP_MAX, (_) => MsgMstData());
  // キーデータ
  late List<KeyfncBuff> dbKfnc =
      List.generate(FuncKey.keyMax, (_) => KeyfncBuff());
  late RxImg img = RxImg();
  int imgMax = 0;

  late CashrycycleBuff dbCashrecycle = CashrycycleBuff();

  List<StaffInfo> staffInfoList =
      List.generate(StaffInfoIndex.STAFF_INFO_MAX.index, (_) => StaffInfo());

  late StrclsInfo	strclsInfo = StrclsInfo();

  /// mac_infoのマシン番号.
  int get iniMacInfoMacNo => iniMacInfo.system.macno;

  /// mac_infoの店番号.
  int get iniMacInfoShopNo => iniMacInfo.system.shpno;

  ///  mac_infoの企業番号
  int get iniMacInfoCrpNoNo => iniMacInfo.system.crpno;


  Future<SysJsonFile> getSysIni() async {
    if (iniSys.info.version.isEmpty) {
      await iniSys.load();
    }
    return iniSys;
  }

  int nowMentMode = 0;
  int nowFtpUse = 0;
  int iccardDevStat = 0;
  int custOffline = 0;

  RxTccutsIni ini_multi = RxTccutsIni();	//　マルチ端末用

  int shopAndGoAplDlQrPrintNormal = 0;
  int shopAndGoQrPrintChkItmCntFs = 0;
  int shopAndGoQrPrintChkItmCntSs = 0;

  int forceStreClsFlg = 0;	/* 自動強制閉設フラグ	0x01:強制閉設実行中
                                                0x02:
                                                0x04:Checkerメッセージ表示
                                                0x08:Cashierメッセージ表示
                                                0x10:登録メッセージ削除
                            */
  int custTelPrn = 0;		/* 会員の電話番号印字  0:しない 1:する */
  int offline = 0;

  int hsFsQcMenteMode = 0;	/* HappySelfフルセルフのQCメンテナンス画面かどうか 0:QCメンテ画面でない 1:QCメンテ画面である */

  int vmcChgReq = 0;    /* Change Display Flag          */
  int vmcHesoReq = 0;    /* Hesokuri Display Flag        */
  int apbfActFlg = 0;

  late FreqInfo rmstInfo = FreqInfo();

  int specChgCrtSts = 0;		/* スペックチェンジファイル作成状態（0 : 作成終了(未作成) 1 : 作成中） */

  int regReduFspCd = 0;  /* Service Fsp Code */
  int intFlag = 0;  // char int_flag;
  int qsAtFlg = 0;
  int regAddFspCd = 0;

  int overflowStat1 = 0;
  int overflowStat2 = 0;

  /// 再発行、領収書バックアップ用
  int bkGetSubTtlTaxInAmt() {
    return bkTtlLog.t100001.stlTaxInAmt;
  }

  /// 再発行、領収書印字用データバックアップ
  static Future<void> backUpRprRfmData() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    for(int sptendIndex = 0; sptendIndex < CntList.sptendMax; sptendIndex++){
      pCom.bkTtlLog.t100100[sptendIndex] = RegsMem().tTtllog.t100100[sptendIndex].copyWith();
    }

    for(int amtIndex = 0; amtIndex < AmtKind.amtMax.index; amtIndex++){
      pCom.bkTtlLog.t100200[amtIndex] = RegsMem().tTtllog.t100200[amtIndex].copyWith();
    }

    pCom.bkTtlLog.t600000 = RegsMem().tTtllog.t600000.copyWith();
    pCom.bkTtlLog.t100001 = RegsMem().tTtllog.t100001.copyWith();
    pCom.bkTtlLog.t100001Sts = RegsMem().tTtllog.t100001Sts.copyWith();
    pCom.bkTtlLog.t100002Sts = RegsMem().tTtllog.t100002Sts.copyWith();
    pCom.bkTtlLog.t100702 = RegsMem().tTtllog.t100702.copyWith();
    pCom.bkTtlLog.t105200 = RegsMem().tTtllog.t105200.copyWith();
    pCom.bkTtlLog.t105300 = RegsMem().tTtllog.t105300.copyWith();
    pCom.bkTtlLog.calcData = RegsMem().tTtllog.calcData.copyWith();
    pCom.bkTtlLog.t100003 = RegsMem().tTtllog.t100003.copyWith();
    pCom.bkTtlLog.t121000 = RegsMem().tTtllog.t121000.copyWith();
    pCom.bkTHeader = RegsMem().tHeader;
    pCom.bkLastRequestData = RegsMem().lastRequestData;
    pCom.bkTItemLog = RegsMem().tItemLog;
    pCom.bkTCrdtLog = RegsMem().tCrdtLog;
    pCom.bkPrnrBuf = RegsMem().prnrBuf;
    pCom.bkTmpBuf = RegsMem().tmpbuf;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK, "");
  }
}

/// 音声タスク通信用共通メモリ
///  関連tprxソース: \inc\apl\rxmem.h - RX_SOUND_STAT
class RxSoundStat {
  RxCtrl ctrl = RxCtrl();
  int where = 0;
  int mode = 0;
  String soundFilePath = "";

  static final RxSoundStat _instance = RxSoundStat._internal();
  factory RxSoundStat() {
    return _instance;
  }
  RxSoundStat._internal();
}

/// イメージデータ構造定義
///  関連tprxソース: \inc\apl\rxmem.h - RX_IMG
class RxImg {
  List<int> imgCd = List.filled(getDBImgMax(), 0);
  List<String> imgData = List.filled(getDBImgMax(), "");

  /// 関連tprxソース: rmdbread.c - DB_IMG_MAX
  static int getDBImgMax() {
    int max = FuncKey.keyMax + ImageDefinitions.IMG_MAX;
    if (CompileFlag.FIP_DISP_EX) {
      return max * 2;
    }
    return max;
  }
}
///  関連tprxソース: \inc\apl\rxmem.h - RCV_API_FIXED_SALES
class RcvApiFixedSales {
  int result = 0;				/* リザルトステータス */
  // char			message[256+1];			/* メッセージ */
  // RCV_BASKET_API_ERR_LIST	error_list[API_LIST_MAX];			/* エラーリスト */
}

///  関連tprxソース: rxmem.h - RC_INFO_MEM_LISTS
class RcInfoMemLists{
  RcCnctLists rcCnct = RcCnctLists();
  RcRecogLists rcRecog = RcRecogLists();
}

///  関連tprxソース: rxmem.h - RC_CNCT_LISTS
class RcCnctLists {
  int cnctRctOnoff = 0;
  int cnctAcrOnoff = 0;
  int cnctAcrCnct = 0;
  int cnctCardCnct = 0;
  int cnctAcbDeccin = 0;
  int cnctRwtCnct = 0;
  int cnctScaleCnct = 0;
  int cnctAcbSelect = 0;
  int cnctIis21Cnct = 0;
  int cnctMobileCnct = 0;
  int cnctStprCnct = 0;
  int cnctNetwlprCnct = 0;
  int cnctPoppyCnct = 0;
  int cnctTagCnct = 0;
  int cnctAutoDeccin = 0;
  int cnctS2PrCnct = 0;
  int cnctPwrctrlCnct = 0;
  int cnctCatalinaprCnct = 0;
  int cnctDishCnct = 0;
  int cnctCustrealsvrCnct = 0;
  int cnctAivoiceCnct = 0;
  int cnctGcatCnct = 0;
  int cnctSuicaCnct = 0;
  int cnctMp1Cnct = 0;
  int cnctRealitmsendCnct = 0;
  int cnctGramxCnct = 0;
  int cnctRfidCnct = 0;
  int cnctMsgFlg = 0;
  int cnctMultiCnct = 0;
  int cnctJremCnct = 0;
  int cnctColordspCnct = 0;
  int cnctUsbcamCnct = 0;
  int cnctMasrCnct = 0;
  int cnctBrainflCnct = 0;
  int cnctCatJmupsTwinCnct = 0;
  int cnctSqrcCnct = 0;
  int cnctCustrealPqsNewSend = 0;
  int cnctEffect = 0;
  int cnctIccardCnct = 0;		/* 2015/02/02 */
  int cnctColordspSize = 0;
  int cnctRcptCnct = 0;
  int cnctApbfCnct = 0;
  int cnctHitouchCnct = 0;
  int cnctAmiCnct = 0;
}


///  関連tprxソース: 関連tprxソース: rxmem.h - RC_RECOG_LISTS
class RcRecogLists{
  int recogMembersystem = 0;
  int recogMemberpoint = 0;
  int recogMemberfsp = 0;
  int recogCreditsystem = 0;
  int recogSpecialReceipt = 0;
  int recogDiscBarcode = 0;
  int recogIwaisystem = 0;
  int recogSelfGate = 0;
  int recogSys24Hour = 0;
  int recogVismacsystem = 0;
  int recogHqAsp = 0;
  int recogJasaitamaSys = 0;
  int recogPromsystem = 0;
  int recogEdysystem = 0;
  int recogFreshBarcode = 0;
  int recogSugiSys = 0;
  int recogHesokurisystem = 0;
  int recogGreenstampSys = 0;
  int recogCoopsystem = 0;
  int recogPointcardsystem = 0;
  int recogMobilesystem = 0;
  int recogHqOther = 0;
  int recogRegconnectsystem = 0;
  int recogClothesBarcode = 0;
  int recogFjss = 0;
  int recogMcsystem = 0;
  int recogNetworkPrn = 0;
  int recogPoppyPrint = 0;
  int recogTagPrint = 0;
  int recogTaurus = 0;
  int recogNttAsp = 0;
  int recogEatIn = 0;
  int recogMobilesystem2 = 0;
  int recogMagazineBarcode = 0;
  int recogHqOtherReal = 0;
  int recogPw410System = 0;
  int recogNscCredit = 0;
  int recogSkip218 = 0;
  int recogHqProd = 0;
  int recogFelicasystem = 0;
  int recogPsp70System = 0;
  int recogNttBcom = 0;
  int recogCatalinasystem = 0;
  int recogPrcchkr = 0;
  int recogDishcalcsystem = 0;
  int recogItfBarcode = 0;
  int recogCssAct = 0;
  int recogCustDetail = 0;
  int recogCustrealsvr = 0;
  int recogSuicaCat = 0;
  int recogYomocasystem = 0;
  int recogSmartplussystem = 0;
  int recogDuty = 0;
  int recogEcoasystem = 0;
  int recogIccardsystem = 0;
  int recogSubTicket = 0;
  int recogQuicpaysystem = 0;
  int recogIdsystem = 0;
  int recogRevivalReceipt = 0;
  int recogQuickSelf = 0;
  int recogQuickSelfChg = 0;
  int recogAssistMonitor = 0;
  int recogMp1Print = 0;
  int recogRealitmsend = 0;
  int recogRainbowcard = 0;
  int recogGramx = 0;
  int recogMmAbj = 0;
  int recogCatPoint = 0;
  int recogTagrdwt = 0;
  int recogDepartmentStore = 0;
  int recogEdynoMbr = 0;
  int recogFcfCard = 0;
  int recogPanamembersystem = 0;
  int recogLandisk = 0;
  int recogPitapasystem = 0;
  int recogTuocardsystem = 0;
  int recogSallmtbar = 0;
  int recogBusinessMode = 0;
  int recogMcp200System = 0;
  int recogSpvtsystem = 0;
  int recogRemotesystem = 0;
  int recogOrderMode = 0;
  int recogJremMultisystem = 0;
  int recogMediaInfo = 0;
  int recogGs1Barcode = 0;
  int recogAssortsystem = 0;
  int recogCenterServer = 0;
  int recogReservsystem = 0;
  int recogDrugRev = 0;
  int recogGincardsystem = 0;
  int recogFclqpsystem = 0;
  int recogFcledysystem = 0;
  int recogCapsCafis = 0;
  int recogFclidsystem = 0;
  int recogPtcktissusystem = 0;
  int recogAbsPrepaid = 0;
  int recogProdItemAutoset = 0;
  int recogProdItf14Barcode = 0;
  int recogSpecialCoupon = 0;
  int recogBluechipServer = 0;
  int recogHitachiBluechip = 0;
  int recogHqOtherCantevole = 0;
  int recogQcashierSystem = 0;
  int recogReceiptQrSystem = 0;
  int recogVisatouchInfox = 0;
  int recogPbchgSystem = 0;
  int recogHc1System = 0;
  int recogCapsHc1Cafis = 0;
  int recogRemoteserver = 0;
  int recogMrycardsystem = 0;
  int recogSpDepartment = 0;
  int recogDecimalitmsend = 0;
  int recogWizCnct = 0;
  int recogAbsv31Rwt = 0;
  int recogPluralqrSystem = 0;
  int recogNetdoareserv = 0;
  int recogSelpluadj = 0;
  int recogCustrealWebser = 0;
  int recogWizAbj = 0;
  int recogCustrealUid = 0;
  int recogBdlitmsend = 0;
  int recogCustrealNetdoa = 0;
  int recogUtCnct = 0;
  int recogCapsPqvic = 0;
  int recogYamatoSystem = 0;
  int recogCapsCafisStandard = 0;
  int recogNttdPreca = 0;
  int recogUsbcamCnct = 0;
  int recogDrugstore = 0;
  int recogCustrealNec = 0;
  int recogCustrealOp = 0;
  int recogDummyCrdt = 0;
  int recogHc2System = 0;		// くろがねや特注仕様確認
  int recogPriceSound = 0;
  int recogDummyPreca = 0;
  int recogMonitoredSystem = 0;
  int recogJmupsSystem = 0;
  int recogUt1Qpsystem = 0;
  int recogUt1Idsystem = 0;
  int recogBrainSystem = 0;
  int recogPfmpitapasystem = 0;
  int recogPfmjricsystem = 0;
  int recogChargeslipSystem = 0;
  int recogPfmjricchargesystem = 0;
  int recogItemprcReductionCoupon = 0;
  int recogCatJnupsSystem = 0;
  int recogSqrcTicketSystem = 0;
  int recogICCardSystem = 0;
  int recogCctConnectSystem = 0;
  int recogCctEmoneySystem = 0;
  int recogTecInfoxJetSSystem = 0;
  int recogProdInstoreZeroFlg = 0;
  int recogSkip906 = 0;
  int recogSkip907 = 0;
  int recogSkip908 = 0;
  int recogSkip909 = 0;
  int recogSkip910 = 0;
  int recogSkip911 = 0;
  int recogSkip912 = 0;
  int recogSkip913 = 0;
  int recogSkip914 = 0;
  int recogSkip915 = 0;
  int recogSkip916 = 0;
  int recogSkip917 = 0;
  int recogSkip918 = 0;
  int recogFrontSelfSystem = 0;
  int recogTrkPreca = 0;
  int recogDesktopCashierSystem = 0;
  int recogNimocaPointSystem = 0;
  int recogTb1System = 0;
  int recogRepicaSystem = 0;
  int recogCustrealPointartist = 0;
  int recogYumecaSystem = 0;
  int recogCustrealTpoint = 0;
  int recogMammySystem = 0;
  int recogKitchenPrint = 0;
  int recogEffect = 0;
  int recogAyahaSystem = 0;
  int recogCogcaSystem = 0;
  int recogBdlMultiSelectSystem = 0;      /* ﾐｯｸｽﾏｯﾁ複数選択仕様 */
  int recogSallLmtbar26 = 0;
  int recogPurchaseTicketSystem = 0;	/* 特定売上チケット発券仕様 */
  int recogCustrealUniSystem = 0;
  int recogEjAnimationSystem = 0;		/* EJ動画サーバ接続仕様 */
  int recogTaxFreeSystem = 0;		/* 免税仕様 */
  int recogValuecardSystem = 0;
  int recogSm4ComodiSystem = 0;
  int recogSm5ItokuSystem = 0;		/* 特定SM5仕様 */
  int recogCctPointuseSystem = 0;
  int recogZhqSystem = 0;
  int recogRpointSystem = 0;		/* 楽天ポイント仕様 */
  int recogVescaSystem = 0;
  int recogAjsEmoneySystem = 0;			/* 電子マネー[AJS]仕様*/
  int recogSm16TaiyoToyochoSystem = 0;	/* 特定SM16仕様[タイヨー(茨城)] */
  int recogInfoxDetailSendSystem = 0;	/* 明細送信[INFOX]仕様 */
  int recogSelfMedicationSystem = 0;	/* セルフメディケーション仕様 */
  int recogKitchenPrintNumSystem = 0;
  int recogPanawaonsystem = 0;		/* WAON仕様 [Panasonic] */
  int recogOnepaysystem = 0;			/* Onepay仕様 */
  int recogHappyselfSystem = 0;		/* HappySelf仕様 */
  int recogHappyselfSmileSystem = 0;	/* HappySelf仕様[対面セルフ用] */
  int recogLinepaySystem = 0;			/* LINE Pay仕様 */
  int recogStaffReleaseSystem = 0;		/* 従業員権限解除 */
  int recogWizBaseSystem = 0;		/* WIZ-BASE仕様 */
  int recogShopAndGoSystem = 0;		/* Shop&Go仕様 */
  int recogDs2GodaiSystem = 0;		/* 特定DS2仕様[ゴダイ] */
  int recogTaxfreePassportinfoSystem = 0;	/* 旅券読取内蔵免税仕様 */
  int recogSm20MaedaSystem = 0;		/* 特定SM20仕様[マエダ] */
  int recogSm36SanprazaSystem = 0;		/* 特定SM36仕様[サンプラザ] */
  int recogSm33NishizawaSystem = 0;	/* 特定SM33仕様[ニシザワ] */
  int recogCr50System = 0;			/* CR5.0接続仕様 */
  int recogCaseClothesBarcodeSystem = 0;	/* 特定クラス衣料バーコード仕様 */
  int recogCustrealDummySystem = 0;	/* 顧客リアル仕様[ダミーシステム] */
  int recogReasonSelectStdSystem = 0;	/* 理由選択仕様 */
  int recogBarcodePay1System = 0;		/* JPQR決済仕様 */
  int recogCustrealPtactix = 0;		/* 顧客リアル[PT]仕様 */
  int recogCr3SharpSystem = 0;		/* 特定CR3接続仕様 */
  int recogCctCodepaySystem = 0;		/* CCTコード払い決済仕様 */
  int recogWsSystem = 0;			/* 特定WS仕様 */
  int recogCustrealPointinfinity = 0;	/* 顧客リアル[PI]仕様 */
  int recogToySystem = 0;			/* 特定TOY仕様 */
  int recogCanalPaymentServiceSystem = 0;	/* ｺｰﾄﾞ決済[CANALPay]仕様 */
  int recogDispensingPharmacySystem = 0;	/* 特定DP1仕様[アインHD] */
  int recogSm41BellejoisSystem = 0;	/* 特定SM41仕様[ベルジョイス] */
  int recogSm42KanesueSystem = 0;  	/* 特定SM42仕様[カネスエ] */
  int recogDpointSystem = 0;		/* dポイント仕様 */
  int recogPublicBarcodePaySystem = 0;	/* 特定公共料金仕様[パソナ] */
  int recogTsIndivSettingSystem = 0;	/* TS設定個別変更仕様 */
  int recogSm44JaTsuruokaSystem = 0;  	/* 特定SM44仕様[JA鶴岡] */
  int recogSteraTerminalSystem = 0;  	/* stera terminal仕様 */
  int recogRepicaPointSystem = 0;		/* レピカポイント仕様 */
  int recogSm45OceanSystem = 0;		/* 特定SM45仕様[オーシャンシステム] */
  int recogFujitsuFipCodepaySystem = 0;	// ｺｰﾄﾞ決済[FIP]仕様(Ver12以降)
  int recogTaxfreeServerSystem = 0;	/*免税電子化仕様 */
  int recogEmployeeCardPaymentSystem = 0;	/* 社員証決済仕様[売店] */
  int recogNetReceiptSystem = 0;		/* 電子レシート仕様 */
  int recogSm49ItochainSystem = 0;		/* 特定SM49仕様[伊藤ﾁｪｰﾝ] */
  int recogPublicBarcodePay2System = 0;	/* 特定公共料金2仕様[平泉町役場] */
  int recogMultiOnepaysystem = 0;		/* Onepay複数ブランド仕様 */
  int recogSm52PaletteSystem = 0;		/* 特定SM52仕様[パレッテ] */
  int recogPublicBarcodePay3System = 0;	/* 特定公共料金3仕様[石川町役場] */
  int recogSvsclsStlpdscSystem = 0;	/* ｻｰﾋﾞｽ分類別割引仕様 */
  int recogSvscls2StlpdscSystem = 0;	/* ｻｰﾋﾞｽ分類別割引2仕様 */
  int recogStaffid1YmssSystem = 0;		/* 特定社員証1仕様 */
  int recogSm55TakayanagiSystem  = 0;	/*特定SM56仕様[タカヤナギ様] */
  int recogMailSendSystem = 0;		/* 電子メール送信仕様 */
  int recogNetstarsCodepaySystem = 0;	// ｺｰﾄﾞ決済[NETSTARS]仕様(Ver12以降)
  int recogSm56KobebussanSystem = 0;  	/* 特定SM56仕様[神戸物産] */
  int recogMultiVegaSystem = 0;            /* Vega3000電子ﾏﾈｰ仕様 */
  int recogHys1SeriaSystem = 0;		/* 特定HYS1仕様[セリア] */
  int recogLiqrTaxfreeSystem = 0;		/*酒税免税仕様 */
  int recogCustrealGyomucaSystem = 0;	/* 顧客ﾘｱﾙ[SM56]仕様 */
  int recogSm59TakaramcSystem = 0;		/* 特定SM59仕様[タカラ・エムシー] */
  int recogDetailNoprnSystem = 0;		/* 分類別明細非印字仕様[ファルマ様] */
  int recogSm61FujifilmSystem = 0;		/* 特定SM61仕様[富士フィルムシステム(ゲオリテール)様] */
  int recogDepartment2System = 0;		/* 特定百貨店2仕様[さくら野百貨店様] */
  int recogCustrealCrosspoint = 0;		/* 顧客ﾘｱﾙ[CP]仕様(DB V14以降) */
  int recogHc12JoyfulHondaSystem = 0;		/* 特定HC12仕様[ジョイフル本田] */
  int recogSm62MaruichiSystem = 0;		/* 特定SM62仕様[マルイチ] */
  int recogSm65RyuboSystem = 0;		/* 特定SM65仕様[リウボウ] */
  int recogTomoifSystem = 0;		/* 友の会仕様 */
  int recogSm66FrestaSystem = 0;		/* 特定SM66仕様[フレスタ] */
  int recogCosme1IstyleSystem = 0;		/* 特定コスメ1仕様[アイスタイルリテイル様] */
  int recogSm71SelectionSystem = 0;		/* 特定SM71仕様[セレクション] */
  int recogKitchenPrintRecipt = 0;		/* ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様[角田市役所様] */
  int recogMiyazakiCitySystem = 0;		/* 宮崎市役所 市民課様 */
  int recogPublicBarcodePay4System = 0;	/* 特定公共料金4仕様[角田市役所様] */
  int recogSp1QrReadSystem = 0;		/* 特定QR読込1仕様 */
  int recogAiboxSystem = 0;			/* AIBOX連携仕様 */
  int recogCashonlyKeyoptSystem = 0;		/* 現金支払限定仕様 */
  int recogSm74OzekiSystem = 0;		/* 特定SM74仕様[オオゼキ] */
  int recogCarparkingQrSystem = 0;		/* 駐車場QRコード印字仕様[Ｍｉｋ様] */
  int recogOlcSystem = 0;				/* 特定OLC仕様[オリエンタルランド様] */
  int recogQuizPaymentSystem = 0;		/* ｺｰﾄﾞ決済[QUIZ]仕様 */
  int recogJetsLaneSystem = 0;		/* Lane[JET-S]接続仕様 */

  // RECOG_SM19_NISHIMUTA_SYSTEM
  int recogSm19NishimutaSystem = 0;	/* 特定SM19仕様 */

// TODO:10107 コンパイルスイッチ(RF1_SYSTEM)
// RF1_SYSTEMが0で定義されていたので、この部分はコメントアウトしておく。
// #if RF1_SYSTEM
// int RECOG_RF1_HS_SYSTEM  = 0;		// 特定総菜仕様(DB V1以降)[ＲＦ仕様]
// #endif	/* #if RF1_SYSTEM */
/***************************************************************************************************************/
/* 先にNotesのWeb2100DBの承認キーDBに添付されているエクセルファイルを変更し、承認キーの位置を確保してください。 */
/***************************************************************************************************************/
}

///  関連tprxソース: 関連tprxソース: rxmem.h - RX_SIMPLE2STF
class RxSimple2Stf{
  /// /* 1:one person / 2:two person */
  int	personFlag = 0;
  /// /* 0:normal / 1:cashier stop */
  int	cashierEnd = 0;
  int	twopersonKeyFlag = 0;
  int	fncCode = 0;
  int	updateExec = 0;
}

/// 印字ステータス
/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_PRN_STAT
class RxPrnStat {
  RxCtrl   Ctrl   = RxCtrl();		  /* ヘッダ情報 */
  RxDevInf DevInf = RxDevInf();		/* デバイス情報 */
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_MNTCLT
class ConstMntclt {
  static const SVRMAX = 2;	// Master and Sub
}
/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_MNTCLT
class RxMntclt {
  RxCtrl Ctrl = RxCtrl();		/* ヘッダ情報 */
  int		err_no = 0;
  String  ipadr = "";
  String  tbl_name = "";
  String  sql = "";
  List<int>		 spqc_offline = List.filled(ConstMntclt.SVRMAX, 0);	// 0: ONLINE 1: OFFLINE
  int		spqc_reg = 0;
  int		spqc_tr_reg = 0;
  int		spqc_all = 0;
  int		spqc_tr_all = 0;
  int		spqc_twocnct_chk = 0;	// ２台連結２人制のチェッカー表示更新用
  int		spqc_twocnct_reg = 0;	// ２台連結２人制の呼出されていない登録数
  int		spqc_twocnct_tr_reg = 0;	// ２台連結２人制の呼出されていない登録数 (訓練)
  int		spqc_use_svr = 0;		// 0: Master 1: Sub  件数確認や問い合わせ先などで優先されるサーバー
}

/// Qc Connectタスクステータス
/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_QCCONNECT
class RxQcConnect {
  int  ConMax = 0;				// 接続数
  RxMemQcConnectData	MyStatus = RxMemQcConnectData();			// 自レジ情報格納
  List<RxMemQcConnectData> ConStatus =
      List.generate(ConstQxConnect.QCCONNECT_MAX, (_) => RxMemQcConnectData());	// 接続レジ情報格納
}

/**********************************************************************
    電子メール送信処理用共有メモリ
 ***********************************************************************/
/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_MAIL_SENDER
class RxMailSender {
  RxCtrl  Ctrl = RxCtrl();  /* ヘッダ情報           */
  int     order = 0;        /* 要求内容             */
  int     err_no = 0;       /* エラー情報           */
  String  data = "";        /* 付加情報(len:512)    */

}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_MAIL_SENDER_EVENT_ORDER
enum RxMailSenderEventOrder {
  EMAILSEND_ORDER_IDLE(0),         // アイドル（内部イベント）
  EMAILSEND_ORDER_EDIT(1),         // 編集（実績発生）
  EMAILSEND_ORDER_CLOSE_SEND(2),   // 閉設時の未送データ送信
  EMAILSEND_ORDER_USETUP_SEND(3),  // ユーザーセットアップからの未送データ送信
  EMAILSEND_ORDER_APSEND(4);       // リクエスト実行（内部イベント）

  final int keyId;
  const RxMailSenderEventOrder(this.keyId);
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_MAIL_SENDER_UNSENT_RESULT
enum RxMailSenderUnsentResult {
  MAIL_UNSNTRES_IDLE(0),             // アイドル（内部イベント）
  MAIL_UNSNTRES_REQUEST(1),          // 要求中
  MAIL_UNSNTRES_EXEC(2),             // 実行中
  MAIL_UNSNTRES_RESULT_NORMAL(3),    // 処理結果正常（未送なし）
  MAIL_UNSNTRES_RESULT_OFFLINE(4),   // 処理結果異常（送信失敗）
  MAIL_UNSNTRES_RESULT_ERROR(5);     // 処理結果異常（送信異常）

  final int keyId;
  const RxMailSenderUnsentResult(this.keyId);
}

/**********************************************************************
    電子レシート処理用共有メモリ
 ***********************************************************************/
/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_NET_RECEIPT
class RxNetReceipt {
  RxCtrl  Ctrl  = RxCtrl();  /* ヘッダ情報           */
  int     order = 0;			   /* 要求内容             */
  int     err_no = 0;			   /* エラー情報           */
  String  data = "";         /* 付加情報 (len:512)            */
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_NET_RECEIPT_EVENT_ORDER
enum RxNetReceiptEventOrder {
  ENRCPT_ORDER_IDLE(0),			    // アイドル（内部イベント）
  ENRCPT_ORDER_EDIT(1),			    // 編集（実績発生）
  ENRCPT_ORDER_CLOSE_SEND(2),		// 閉設時の未送データ送信
  ENRCPT_ORDER_USETUP_SEND(3),	// ユーザーセットアップからの未送データ送信
  ENRCPT_ORDER_APSEND(4);			  // リクエスト実行（内部イベント）

  final int keyId;
  const RxNetReceiptEventOrder(this.keyId);
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_NET_RECEIPT_UNSENT_RESULT
enum RxNetReceiptUnsentResult {
  UNSNTRES_IDLE(0),             // アイドル（内部イベント）
  UNSNTRES_REQUEST(1),          // 要求中
  UNSNTRES_EXEC(2),             // 実行中
  UNSNTRES_RESULT_NORMAL(3),    // 処理結果正常（未送なし）
  UNSNTRES_RESULT_OFFLINE(4),   // 処理結果異常（送信失敗）
  UNSNTRES_RESULT_ERROR(5);     // 処理結果異常（送信異常）

  final int keyId;
  const RxNetReceiptUnsentResult(this.keyId);
}

/**********************************************************************
    マルチ端末（アークス様）
 ***********************************************************************/


/// 関連tprxソース: rxmem.h - RX_TCCUTS_INI
class RxTccutsIni {
  static const   TCCUTS_TID_LEN = 13;
  String QP_tid = "";
  String iD_tid = "";
  String Suica_tid = "";
  String Edy_tid = "";
}

/// VEGA3000 端末
/// 関連tprxソース: rxmem.h - RX_VEGA3000_CONF
class RxVega3000Conf {
  /* VEGA3000 接続先設定 */
  int svFlag = 0; // 内部処理用フラグ：サブサーバの有無フラグ
  int swFlag = 0; // 内部処理用フラグ：サブサーバへ切り替え中フラグ
  List<String> address = List.generate(16, (_) => ""); // 接続先サーバIP
  List<String> addressSub = List.generate(16, (_) => ""); // 接続先サブサーバIP
  int port = 0; // 接続先サーバPort
  int portSub = 0; // 接続先サブサーバPort
  int recvTimeOut = 0; // 電文受信待ち時間(sec)
  int connTimeOut = 0; // コネクション取得待ち時間(sec)
  int retryCount = 0; // コネクションリトライ回数[*********未使用***************]
  int logFlag = 0; // ログ出力判定フラグ
  List<String> logFilePath = List.generate(128, (_) => ""); // ログ出力先フォルダ：指定無の場合カレントフォルダに出力
  int logSaveDate = 0; // ログ保存日数：0指定の場合無制限
  int devFlag = 0; // 開発用 DLL内部折返しフラグ
  int trainingModeFlag = 0; // トレーニングモードフラグ[POS連動用]
  List<String> comNo = List.generate(24, (_) => ""); // シリアルポート名：Windowsの場合"COM1"等、Linuxの場合"/dev/ttyS1"等[POS連動用]
  /* VEGA3000 接続先設定ここまで */
  int vega3000CancelFlg = 0; // VEGA3000 キャンセル通知フラグ
}

/// 関連tprxソース: rxmem.h - RX_TASKSTAT_MCFTP
class RxTaskStatMcftp {
  int order = 0;
  int mseg_order = 0;
  int customercard_order = 0;
  int customercard_check = 0;
  int customercard_no = 0;
  int content_play_flg = 0;
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - FREQ_INFO
class FreqInfo{
  int	rmstFreq = 0;		//開設自動リクエストフラグ
  int	freqRes = 0;		//　
  int	rmstFreqRetry = 0;	//リクエスト再実行フラグ　
}

/// 関連tprxソース: 関連tprxソース: rxmem.h - RX_TASKSTAT_HQHIST
/*----- HQHISTタスクステータス -----*/
class RxTaskstatHqhist{
  int mode = 0;		// 動作状態  0:正常  1:強制ストップ
  int running = 0;
  int requestStart = 0;	// HQHIST_REQUEST_TYPの状態
  int requestResult = 0;	// 要求受信結果  0:正常  それ以外:異常
  int requestCount = 0;	// 要求受信件数
  int hqHistEnd = 0;
  int invalid = 0;	// 一括ダウンロードで使用
  int countOK = 0;		// SGYOUMU 正常レコード件数
  int countNG = 0;		// SGYOUMU 異常レコード件数
  int countC1 = 0;		// SGYOUMU 指示件数
}

/// 関連tprxソース: rxmem.h - RX_TASKSTAT_MOVIESEND
/// Movie Send タスクステータス
class RxTaskStatMovieSend {
  int order = 0;
  int delFlg = 0;
}

/// 関連tprxソース:rxmem.h - RX_TASKSTAT_HQFTP
class RxTaskStatHqftp {
  int mode = 0; // 0: 動作可能状態  1: 不可
  int running = 0; // hqftpタスクが実行中だった場合 1
  int hqftpEnd = 0; // hqftpタスクが終了したら 1
  int requestStart = 0; // hqftpタスクへ送信要求するためのメモリ
  int requestResult = 0; // 送信要求後の実行結果を格納
  String requestBuf = ''; // 再作成のYYYYMMDD or 再送信ファイル名
}

/// 関連tprxソース:rxmem.h - HQHIST_REQUEST_TYP
enum HqHistRequestTyp {
  HQHIST_REQ_NOT(0), // 定時での受信動作
  HQHIST_REQ_RECV(1), // 他タスクからの受信要求動作
  HQHIST_REQ_CLS(2), // 閉設
  HQHIST_REQ_OPN(3), // 開設
  HQHIST_REQ_DWN_S(4), // 一括ダウンロード(SGYOUMU)
  HQHIST_REQ_DWN_A(5); // 一括ダウンロード(AGYOUMU)

  final int type;

  const HqHistRequestTyp(this.type);
}
