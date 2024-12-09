/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';
//---------------
// Check Process for ATA Member Spec Card
// 関連tprxソース:  rxmbratachk.h
//---------------

/// 関連tprxソース: rxmbratachk.h -ACTIVATE_STATUS
enum ActivateStatus {
  ACTIVATE_NONE,
  ACTIVATE_SELECT,
  ACTIVATE_ACT,
  ACTIVATE_AUTHENT,
  ACTIVATE_CANCEL,
  ACTIVATE_NORMAL,
  ACTIVATE_SPECIAL,
  ACTIVATE_EMER,
  ACTIVATE_CONF,
}

/// 関連tprxソース: rxmbratachk.h - ACTIVATE_TYPE
enum ActivateType {
  TYPE_ORG,
  TYPE_PAGE,
  TYPE_RCV,
  TYPE_ACTI_CNCL,
}
/// 承認キー関連定義.
/// 関連tprxソース: rxmbratachk.h
class RecogKeyDefine{

  /// 承認キーの長さ.
  static const RECOG_ENTRY_LENGTH1 = 12;
  /// 承認機能の長さ.
  static const RECOG_ENTRY_LENGTH2 = 8;
}

/// 承認キーや設定ファイルの設定値定義.
enum RecogValue {
  RECOG_NO("no"),
  RECOG_YES("yes"),
  RECOG_EMER("yes"),
  RECOG_OK0893("ok0893", iniStr2: "OK0893"),
  RECOG_YES_EMER(""); /* 緊急用承認キー  */

  final String iniStr;
  final String iniStr2; //iniStrの別の書き方.
  const RecogValue(this.iniStr, {this.iniStr2 = ""});

  /// keyIdから対応するFuncKeyを取得する.
  static RecogValue getDefine(int index) {
    RecogValue? define =
    RecogValue.values.firstWhereOrNull((a) => a.index == index);
    define ??= RECOG_NO; // 定義されているものになければnoneを入れておく.
    return define;
  }

  /// [value]がキーの設定値と一致しているかどうか
  bool isSameValue(String value) {
    if (value == iniStr) {
      return true;
    }
    if (iniStr2.isNotEmpty && value == iniStr2) {
      return true;
    }
    return false;
  }

  bool isValid(){
    return this != RECOG_NO;
  }
}

/// RECOGの読み取り、書き込みの種類
/// 関連tprxソース: rxmbratachk.h - RECOG_TYPS
enum RecogTypes {
  RECOG_GETMEM(false, true), //  GET ini_sys
  RECOG_GETSYS(false, false), //  GET sys.ini
  RECOG_SETMEM(true, true), //  SET ini_sys
  RECOG_SETSYS(true, false), //  SET sys.ini

  RECOG_GETMEM_JC_J(false, true), //  GET ini_sys mask recog_qcjc_j
  RECOG_GETMEM_JC_C(false, true), //  GET ini_sys mask recog_qcjc_c
  RECOG_GETMEM_ALL(false, true), //  GET ini_sys no mask

  RECOG_GETSYS_JC_J(false, false), //  GET sys.ini mask recog_qcjc_j
  RECOG_GETSYS_JC_C(false, false), //  GET sys.ini mask recog_qcjc_c
  RECOG_GETSYS_ALL(false, false); //  GET sys.ini no mask

  final bool isSetting;
  final bool isMemory;
  const RecogTypes(this.isSetting, this.isMemory);
}

enum RecogLists {
/* 1ページ 0~*/
  RECOG_MEMBERSYSTEM,
  RECOG_MEMBERPOINT,
  RECOG_MEMBERFSP,
  RECOG_CREDITSYSTEM,
  RECOG_SPECIAL_RECEIPT,
  RECOG_DISC_BARCODE,
  RECOG_IWAISYSTEM,
  RECOG_SELF_GATE,
  RECOG_SYS_24HOUR,
  RECOG_VISMACSYSTEM,
  RECOG_HQ_ASP,
  RECOG_JASAITAMA_SYS,
  RECOG_PROMSYSTEM,
  RECOG_EDYSYSTEM,
  RECOG_FRESH_BARCODE,
  RECOG_SUGI_SYS,
  RECOG_HESOKURISYSTEM,
  RECOG_GREENSTAMP_SYS,
  RECOG_COOPSYSTEM,
  RECOG_POINTCARDSYSTEM,
/* 2ページ:20~ */
  RECOG_MOBILESYSTEM,
  RECOG_HQ_OTHER,
  RECOG_REGCONNECTSYSTEM,
  RECOG_CLOTHES_BARCODE,
  RECOG_FJSS,
  RECOG_MCSYSTEM,
  RECOG_NETWORK_PRN,
  RECOG_POPPY_PRINT,
  RECOG_TAG_PRINT,
  RECOG_TAURUS,
  RECOG_NTT_ASP,
  RECOG_EAT_IN,
  RECOG_MOBILESYSTEM2,
  RECOG_MAGAZINE_BARCODE,
  RECOG_HQ_OTHER_REAL,
  RECOG_PW410SYSTEM,
  RECOG_NSC_CREDIT,
  RECOG_SKIP_2_18,
/* 3ページ:38~ */
  RECOG_HQ_PROD,
  RECOG_FELICASYSTEM,
  RECOG_PSP70SYSTEM,
  RECOG_NTT_BCOM,
  RECOG_CATALINASYSTEM,
  RECOG_PRCCHKR,
  RECOG_DISHCALCSYSTEM,
  RECOG_ITF_BARCODE,
  RECOG_CSS_ACT,
  RECOG_CUST_DETAIL,
  RECOG_CUSTREALSVR,
  RECOG_SUICA_CAT,
  RECOG_YOMOCASYSTEM,
  RECOG_SMARTPLUSSYSTEM,
  RECOG_DUTY,
  RECOG_ECOASYSTEM,
  RECOG_ICCARDSYSTEM,
  RECOG_SUB_TICKET,
/* 4ページ:56~ */
  RECOG_QUICPAYSYSTEM,
  RECOG_IDSYSTEM,
  RECOG_REVIVAL_RECEIPT,
  RECOG_QUICK_SELF,
  RECOG_QUICK_SELF_CHG,
  RECOG_ASSIST_MONITOR,
  RECOG_MP1_PRINT,
  RECOG_REALITMSEND,
  RECOG_RAINBOWCARD,
  RECOG_GRAMX,
  RECOG_MM_ABJ,
  RECOG_CAT_POINT,
  RECOG_TAGRDWT,
  RECOG_DEPARTMENT_STORE,
  RECOG_EDYNO_MBR,
  RECOG_FCF_CARD,
  RECOG_PANAMEMBERSYSTEM,
  RECOG_LANDISK,
/* 5ページ:74~ */
  RECOG_PITAPASYSTEM,
  RECOG_TUOCARDSYSTEM,
  RECOG_SALLMTBAR,
  RECOG_BUSINESS_MODE,
  RECOG_MCP200SYSTEM,
  RECOG_SPVTSYSTEM,
  RECOG_REMOTESYSTEM,
  RECOG_ORDER_MODE,
  RECOG_JREM_MULTISYSTEM,
  RECOG_MEDIA_INFO,
  RECOG_GS1_BARCODE,
  RECOG_ASSORTSYSTEM,
  RECOG_CENTER_SERVER,
  RECOG_RESERVSYSTEM,
  RECOG_DRUG_REV,
  RECOG_GINCARDSYSTEM,
  RECOG_FCLQPSYSTEM,
  RECOG_FCLEDYSYSTEM,
/* 6ページ:92~ */
  RECOG_CAPS_CAFIS,
  RECOG_FCLIDSYSTEM,
  RECOG_PTCKTISSUSYSTEM,
  RECOG_ABS_PREPAID,
  RECOG_PROD_ITEM_AUTOSET,
  RECOG_PROD_ITF14_BARCODE,
  RECOG_SPECIAL_COUPON,
  RECOG_BLUECHIP_SERVER,
  RECOG_HITACHI_BLUECHIP,
  RECOG_HQ_OTHER_CANTEVOLE,
  RECOG_QCASHIER_SYSTEM,
  RECOG_RECEIPT_QR_SYSTEM,
  RECOG_VISATOUCH_INFOX,
  RECOG_PBCHG_SYSTEM,
  RECOG_HC1_SYSTEM,
  RECOG_CAPS_HC1_CAFIS,
  RECOG_REMOTESERVER,
  RECOG_MRYCARDSYSTEM,
/* 7ページ:110~ */
  RECOG_SP_DEPARTMENT,
  RECOG_DECIMALITMSEND,
  RECOG_WIZ_CNCT,
  RECOG_ABSV31_RWT,
  RECOG_PLURALQR_SYSTEM,
  RECOG_NETDOARESERV,
  RECOG_SELPLUADJ,
  RECOG_CUSTREAL_WEBSER,
  RECOG_WIZ_ABJ,
  RECOG_CUSTREAL_UID,
  RECOG_BDLITMSEND,
  RECOG_CUSTREAL_NETDOA,
  RECOG_UT_CNCT,
  RECOG_CAPS_PQVIC,
  RECOG_YAMATO_SYSTEM,
  RECOG_CAPS_CAFIS_STANDARD,
  RECOG_NTTD_PRECA,
  RECOG_USBCAM_CNCT,
/* 8ページ:128~ */
  RECOG_DRUGSTORE,
  RECOG_CUSTREAL_NEC,
  RECOG_CUSTREAL_OP,
  RECOG_DUMMY_CRDT,
  RECOG_HC2_SYSTEM, // くろがねや特注仕様確認
  RECOG_PRICE_SOUND,
  RECOG_DUMMY_PRECA,
  RECOG_MONITORED_SYSTEM,
  RECOG_JMUPS_SYSTEM,
  RECOG_UT1QPSYSTEM,
  RECOG_UT1IDSYSTEM,
  RECOG_BRAIN_SYSTEM,
  RECOG_PFMPITAPASYSTEM,
  RECOG_PFMJRICSYSTEM,
  RECOG_CHARGESLIP_SYSTEM,
  RECOG_PFMJRICCHARGESYSTEM,
  RECOG_ITEMPRC_REDUCTION_COUPON,
  RECOG_CAT_JNUPS_SYSTEM,
/* 9ページ:146~ */
  RECOG_SQRC_TICKET_SYSTEM,
  RECOG_CCT_CONNECT_SYSTEM,
  RECOG_CCT_EMONEY_SYSTEM,
  RECOG_TEC_INFOX_JET_S_SYSTEM,
  RECOG_PROD_INSTORE_ZERO_FLG,
  RECOG_SKIP_9_06,
  RECOG_SKIP_9_07,
  RECOG_SKIP_9_08,
  RECOG_SKIP_9_09,
  RECOG_SKIP_9_10,
  RECOG_SKIP_9_11,
  RECOG_SKIP_9_12,
  RECOG_SKIP_9_13,
  RECOG_SKIP_9_14,
  RECOG_SKIP_9_15,
  RECOG_SKIP_9_16,
  RECOG_SKIP_9_17,
  RECOG_SKIP_9_18,
/* 10ページ:164~ */
  RECOG_FRONT_SELF_SYSTEM,
  RECOG_TRK_PRECA,
  RECOG_DESKTOP_CASHIER_SYSTEM,
  RECOG_SUICA_CHARGE_SYSTEM,
  RECOG_NIMOCA_POINT_SYSTEM,
  RECOG_CUSTREAL_POINTARTIST,
  RECOG_TB1_SYSTEM,
  RECOG_TAX_FREE_SYSTEM,
  RECOG_REPICA_SYSTEM,
  RECOG_CAPS_CARDNET_SYSTEM,
  RECOG_YUMECA_SYSTEM,
  RECOG_DUMMY_SUICA,
  RECOG_PAYMENT_MNG,
  RECOG_CUSTREAL_TPOINT,
  RECOG_MAMMY_SYSTEM,
  RECOG_ITEMTYP_SEND,
  /* 商品区分 */
  RECOG_YUMECA_POL_SYSTEM,
  RECOG_COGCA_SYSTEM,
/* 11ページ:182~ */
  RECOG_CUSTREAL_HPS,
  RECOG_MARUTO_SYSTEM,
  RECOG_HC3_SYSTEM,
  RECOG_SM3_MARUI_SYSTEM,
  RECOG_KITCHEN_PRINT,
  RECOG_BDL_MULTI_SELECT_SYSTEM,
  /* ﾐｯｸｽﾏｯﾁ複数選択仕様 */
  RECOG_SALL_LMTBAR26,
  RECOG_PURCHASE_TICKET_SYSTEM,
  /* 特定売上チケット発券仕様 */
  RECOG_CUSTREAL_UNI_SYSTEM,
  RECOG_EJ_ANIMATION_SYSTEM,
  /* EJ動画サーバ接続仕様 */
  RECOG_VALUECARD_SYSTEM,
  RECOG_SM4_COMODI_SYSTEM,
  RECOG_SM5_ITOKU_SYSTEM,
  /* 特定SM5仕様 */
  RECOG_CCT_POINTUSE_SYSTEM,
  RECOG_ZHQ_SYSTEM,
  RECOG_SKIP_11_16,
  RECOG_SKIP_11_17,
  RECOG_SKIP_11_18,
/* 12ページ:200~ */
  RECOG_SKIP_12_1,
  RECOG_SKIP_12_2,
  RECOG_SKIP_12_3,
  RECOG_SKIP_12_4,
  RECOG_SKIP_12_5,
  RECOG_SKIP_12_6,
  RECOG_RPOINT_SYSTEM,
  /* 楽天ポイント仕様 */
  RECOG_SKIP_12_8,
  RECOG_VESCA_SYSTEM,
  RECOG_SKIP_12_10,
  RECOG_CR_NSW_SYSTEM,
  RECOG_SKIP_12_12,
  RECOG_SKIP_12_13,
  RECOG_SKIP_12_14,
  RECOG_SKIP_12_15,
  RECOG_SKIP_12_16,
  RECOG_AJS_EMONEY_SYSTEM,
  /* 電子マネー[FIP]仕様 */
  RECOG_SKIP_12_18,
/* 13ページ:218~ */
  RECOG_SKIP_13_1,
  RECOG_SKIP_13_2,
  RECOG_SKIP_13_3,
  RECOG_SKIP_13_4,
  RECOG_SM16_TAIYO_TOYOCHO_SYSTEM,
  /* 特定SM16仕様[タイヨー(茨城)] */
  RECOG_SKIP_13_6,
  RECOG_SKIP_13_7,
  RECOG_SKIP_13_8,
  RECOG_SKIP_13_9,
  RECOG_CR_NSW_DATA_SYSTEM,
  /* 特定CR2接続仕様 */
  RECOG_INFOX_DETAIL_SEND_SYSTEM,
  /* 明細送信[INFOX]仕様 */
  RECOG_SKIP_13_12,
  RECOG_SKIP_13_13,
  RECOG_SKIP_13_14,
  RECOG_SKIP_13_15,
  RECOG_SELF_MEDICATION_SYSTEM,
  /* セルフメディケーション仕様 */
  RECOG_SKIP_13_17,
  RECOG_SM20_MAEDA_SYSTEM,
  /* 特定SM20仕様[マエダ] */
/* 14ページ:236~ */
  RECOG_SKIP_14_1,
  RECOG_SKIP_14_2,
  RECOG_SKIP_14_3,
  RECOG_SKIP_14_4,
  RECOG_SKIP_14_5,
  RECOG_SKIP_14_6,
  RECOG_SKIP_14_7,
  RECOG_SKIP_14_8,
  RECOG_SKIP_14_9,
  RECOG_SKIP_14_10,
  RECOG_SKIP_14_11,
  RECOG_SKIP_14_12,
  RECOG_SKIP_14_13,
  RECOG_PANAWAONSYSTEM,
  /* WAON仕様 [Panasonic] */
  RECOG_ONEPAYSYSTEM,
  /* Onepay仕様 */
  RECOG_HAPPYSELF_SYSTEM,
  /* HappySelf仕様 */
  RECOG_HAPPYSELF_SMILE_SYSTEM,
  /* HappySelf[対面セルフ用] */
  RECOG_SKIP_14_18,
/* 15ページ:254~ */
  RECOG_SKIP_15_1,
  RECOG_SKIP_15_2,
  RECOG_LINEPAY_SYSTEM,
  /* LINE Pay仕様 */
  RECOG_STAFF_RELEASE_SYSTEM,
  /* 従業員権限解除 */
  RECOG_SKIP_15_5,
  RECOG_SKIP_15_6,
  RECOG_REASON_SELECT_STD_SYSTEM,
  /* 理由選択仕様 */
  RECOG_SKIP_15_8,
  RECOG_WIZ_BASE_SYSTEM,
  /* WIZ-BASE仕様 */
  RECOG_PACK_ON_TIME_SYSTEM,
  /* Pack On Time 仕様 */
  RECOG_SKIP_15_11,
  RECOG_SKIP_15_12,
  RECOG_SKIP_15_13,
  RECOG_SKIP_15_14,
  RECOG_SKIP_15_15,
  RECOG_SKIP_15_16,
  RECOG_SKIP_15_17,
  RECOG_SKIP_15_18,
/* 16ページ:272~ */
  RECOG_SKIP_16_1,
  RECOG_SKIP_16_2,
  RECOG_SKIP_16_3,
  RECOG_SHOP_AND_GO_SYSTEM,
  /* Shop&Go仕様 */
  RECOG_SKIP_16_5,
  RECOG_SKIP_16_6,
  RECOG_SKIP_16_7,
  RECOG_SKIP_16_8,
  RECOG_STAFFID1_YMSS_SYSTEM,
  /* 特定社員証1仕様 */
  RECOG_SKIP_16_10,
  RECOG_SKIP_16_11,
  RECOG_SKIP_16_12,
  RECOG_TAXFREE_PASSPORTINFO_SYSTEM,
  /* 旅券読取内蔵免税仕様 */
  RECOG_SM33_NISHIZAWA_SYSTEM,
  /* 特定SM33仕様[ニシザワ] */
  RECOG_SKIP_16_15,
  RECOG_DS2_GODAI_SYSTEM,
  /* 特定DS2仕様[ゴダイ] */
  RECOG_SKIP_16_17,
  RECOG_SKIP_16_18,
/* 17ページ:290~ */
  RECOG_SKIP_17_1,
  RECOG_SM36_SANPRAZA_SYSTEM,
  /* 特定SM36仕様[サンプラザ] */
  RECOG_CR50_SYSTEM,
  /* CR5.0接続仕様 */
  RECOG_SKIP_17_4,
  RECOG_CASE_CLOTHES_BARCODE_SYSTEM,
  /* 特定クラス衣料バーコード仕様 */
  RECOG_DPOINT_SYSTEM,
  /* dポイント仕様 */
  RECOG_CUSTREAL_DUMMY_SYSTEM,
  /* 顧客リアル仕様[ダミーシステム] */
  RECOG_SKIP_17_8,
  RECOG_SKIP_17_9,
  RECOG_BARCODE_PAY1_SYSTEM,
  /* JPQR決済仕様 */
  RECOG_CUSTREAL_PTACTIX,
  /* 顧客リアル[PT]仕様 */
  RECOG_CR3_SHARP_SYSTEM,
  /* 特定CR3接続仕様 */
  RECOG_GAME_BARCODE_SYSTEM,
  /* 特定遊技機用印字仕様 */
  RECOG_CCT_CODEPAY_SYSTEM,
  /* CCTコード払い決済仕様 */
  RECOG_WS_SYSTEM,
  /* 特定WS仕様 */
  RECOG_CUSTREAL_POINTINFINITY,
  /* 顧客リアル[PI]仕様 */
  RECOG_TOY_SYSTEM,
  /* 特定TOY仕様 */
  RECOG_CANAL_PAYMENT_SERVICE_SYSTEM,
  /* ｺｰﾄﾞ決済[CANALPay]仕様 */
/* 18ページ:308~ */
  RECOG_SKIP_18_1,
  RECOG_SKIP_18_2,
  RECOG_SKIP_18_3,
  RECOG_MULTI_VEGA_SYSTEM,
  /* VEGA3000電子ﾏﾈｰ仕様 */
  RECOG_DISPENSING_PHARMACY_SYSTEM,
  /* 特定DP1仕様[アインHD] */
  RECOG_SM41_BELLEJOIS_SYSTEM,
  /* 特定SM41仕様[ベルジョイス] */
  RECOG_SM42_KANESUE_SYSTEM,
  /* 特定SM42仕様[カネスエ] */
  RECOG_SKIP_18_8,
  RECOG_PUBLIC_BARCODE_PAY_SYSTEM,
  /* 特定公共料金仕様 */
  RECOG_SKIP_18_10,
  RECOG_TS_INDIV_SETTING_SYSTEM,
  /* TS設定個別変更仕様 */
  RECOG_SM44_JA_TSURUOKA_SYSTEM,
  /* 特定SM44仕様[JA鶴岡] */
  RECOG_SKIP_18_13,
  RECOG_STERA_TERMINAL_SYSTEM,
  /* stera terminal仕様 */
  RECOG_SM45_OCEAN_SYSTEM,
  /* 特定SM45仕様[オーシャンシステム] */
  RECOG_REPICA_POINT_SYSTEM,
  /* レピカポイント仕様 */
  RECOG_SKIP_18_17,
  RECOG_FUJITSU_FIP_CODEPAY_SYSTEM,
  /* ｺｰﾄﾞ決済[FIP]仕様(Ver12以降) */
/* 19ページ:326~ */
  RECOG_SKIP_19_1,
  RECOG_SKIP_19_2,
  RECOG_SKIP_19_3,
  RECOG_TAXFREE_SERVER_SYSTEM,
  /*免税電子化仕様 */
  RECOG_SKIP_19_5,
  RECOG_SKIP_19_6,
  RECOG_EMPLOYEE_CARD_PAYMENT_SYSTEM,
  /* 社員証決済仕様[売店] */
  RECOG_NET_RECEIPT_SYSTEM,
  /* 電子レシート仕様 */
  RECOG_SKIP_19_9,
  RECOG_SM49_ITOCHAIN_SYSTEM,
  /* 特定SM49仕様[伊藤ﾁｪｰﾝ] */
  RECOG_SKIP_19_11,
  RECOG_SKIP_19_12,
  RECOG_SKIP_19_13,
  RECOG_SKIP_19_14,
  RECOG_PUBLIC_BARCODE_PAY2_SYSTEM,
  /* 特定公共料金2仕様 */
  RECOG_MULTI_ONEPAYSYSTEM,
  /* Onepay複数ブランド仕様 */
  RECOG_SM52_PALETTE_SYSTEM,
  /* 特定SM52仕様[パレッテ] */
  RECOG_PUBLIC_BARCODE_PAY3_SYSTEM,
  /* 特定公共料金3仕様 */
/* 20ページ:344~ */
  RECOG_SKIP_20_1,
  RECOG_SVSCLS2_STLPDSC_SYSTEM,
  /* ｻｰﾋﾞｽ分類別割引2仕様 */
  RECOG_SKIP_20_3,
  RECOG_SKIP_20_4,
  RECOG_SKIP_20_5,
  RECOG_SKIP_20_6,
  RECOG_SKIP_20_7,
  RECOG_SKIP_20_8,
  RECOG_SM55_TAKAYANAGI_SYSTEM,
  /*特定SM55仕様[タカヤナギ様] */
  RECOG_MAIL_SEND_SYSTEM,
  /* ﾚｼｰﾄﾒｰﾙ送信仕様 */
  RECOG_NETSTARS_CODEPAY_SYSTEM,
  /* ｺｰﾄﾞ決済[Netstars]仕様(Ver12以降) */
  RECOG_SM56_KOBEBUSSAN_SYSTEM,
  /* 特定SM56仕様[神戸物産] */
  RECOG_SKIP_20_13,
  RECOG_SKIP_20_14,
  RECOG_HYS1_SERIA_SYSTEM,
  /* 特定HYS1仕様[セリア] */
  RECOG_SKIP_20_16,
  RECOG_SKIP_20_17,
  RECOG_SKIP_20_18,
/* 21ページ:362~ */
  RECOG_SKIP_21_1,
  RECOG_SKIP_21_2,
  RECOG_LIQR_TAXFREE_SYSTEM,
  /*酒税免税仕様 */
  RECOG_CUSTREAL_GYOMUCA_SYSTEM,
  /* 顧客ﾘｱﾙ[SM56]仕様 */
  RECOG_SM59_TAKARAMC_SYSTEM,
  /* 特定SM59仕様[タカラ・エムシー] */
  RECOG_DETAIL_NOPRN_SYSTEM,
  /* 分類別明細非印字仕様[ファルマ様] */
  RECOG_SKIP_21_7,
  RECOG_SKIP_21_8,
  RECOG_SKIP_21_9,
  RECOG_SM61_FUJIFILM_SYSTEM,
  /* 特定SM61仕様[富士フィルムシステム(ゲオリテール)様] */
  RECOG_DEPARTMENT2_SYSTEM,
  /* 特定百貨店2仕様[さくら野百貨店様] */
  RECOG_SKIP_21_12,
  RECOG_CUSTREAL_CROSSPOINT,
  /* 顧客ﾘｱﾙ[CP]仕様(DB V14以降) */
  RECOG_HC12_JOYFUL_HONDA_SYSTEM,
  /* 特定HC12仕様[ジョイフル本田] */
  RECOG_SM62_MARUICHI_SYSTEM,
  /* 特定SM62仕様[マルイチ] */
  RECOG_SKIP_21_16,
  RECOG_SKIP_21_17,
  RECOG_SKIP_21_18,
/* 22ページ:380~ */
  RECOG_SM65_RYUBO_SYSTEM,
  /* 特定SM65仕様[リウボウ] */
  RECOG_SKIP_22_2,
  RECOG_SKIP_22_3,
  RECOG_TOMOIF_SYSTEM, // 友の会仕様,
  RECOG_SM66_FRESTA_SYSTEM,
  /* 特定SM66仕様[フレスタ] */
  RECOG_SKIP_22_6,
  RECOG_SKIP_22_7,
  RECOG_SKIP_22_8,
  RECOG_SKIP_22_9,
  RECOG_COSME1_ISTYLE_SYSTEM,
  RECOG_PUBLIC_BARCODE_PAY4_SYSTEM,
  /* 特定公共料金4仕様 */
  RECOG_SKIP_22_12,
  RECOG_SM71_SELECTION_SYSTEM,
  /* 特定SM71仕様[セレクション] */
  RECOG_KITCHEN_PRINT_RECIPT,
  /* ｷｯﾁﾝﾌﾟﾘﾝﾀﾚｼｰﾄ印字仕様[角田市役所様] */
  RECOG_MIYAZAKI_CITY_SYSTEM,
  RECOG_SP1_QR_READ_SYSTEM,
  /* 特定QR読込1仕様 */
  RECOG_RF1_HS_SYSTEM,
  RECOG_SKIP_22_18,
/* 23ページ:398~ */
  RECOG_SKIP_23_1,
  RECOG_CASHONLY_KEYOPT_SYSTEM,	/* 現金支払限定仕様 */
  RECOG_AIBOX_SYSTEM,		/* AIBOX連携仕様 */
  RECOG_SKIP_23_4,
  RECOG_SKIP_23_5,
  RECOG_SM74_OZEKI_SYSTEM,	/* 特定SM74仕様[オオゼキ] */
  RECOG_CARPARKING_QR_SYSTEM,	/* 駐車場QRコード印字仕様[Ｍｉｋ様] */
  RECOG_SKIP_23_8,
  RECOG_SKIP_23_9,
  RECOG_OLC_SYSTEM,
  RECOG_QUIZ_PAYMENT_SYSTEM,
  RECOG_SKIP_23_12,
  RECOG_JETS_LANE_SYSTEM,
  RECOG_SKIP_23_14,
  RECOG_SKIP_23_15,
  RECOG_SKIP_23_16,
  RECOG_SKIP_23_17,
  RECOG_SKIP_23_18,

/*
    追加する場合は、class RecogData にも対応するデータを追加する必要がある。
	  登録で利用する承認キーの場合は下記のファイルも修正してください(2014/06/17三宮さんのメール)
	  /pj/tprx/src/inc/apl/rxmem.h
	  /pj/tprx/src/regs/checker/rxregmem.c
	  ※登録専用のチェック関数が必要となります。
	*/
  RECOG_MAX;

  /// indexからRecogListsの定義を取得する.
  static RecogLists getDefine(int index) {
    RecogLists? define =
    RecogLists.values.firstWhereOrNull((a) => a.index == index);
    define ??= RecogLists.RECOG_MAX; // 定義されているものになければmaxを入れておく.
    return define;
  }
}

/// 承認キーを参照する際の情報
///  関連tprxソース:rxmbratachk.h - RECOG_REF_INFO
class RecogRefInfo {
  int page = 0;
  int func = 0;
  String keyword = "";
  String data = ""; // 共有メモリ SYS構造体内のデータ先アドレス
  void init() {
    page = 0;
    func = 0;
    keyword = "";
    data = "";
  }
}

/// 承認キーのデータリスト
///  関連tprxソース:recog.c - Recog_Data_List
class RecogData {
  int page = 0;
  int func = 0;
  String keyword = "";
  RecogData(this.page, this.func, this.keyword);

  static List<RecogData> recogDataList = [
    RecogData(1, 1, "membersystem"),
    RecogData(1, 19, "memberpoint"),
    RecogData(1, 20, "memberfsp"),
    RecogData(1, 2, "creditsystem"),
    RecogData(1, 3, "special_receipt"),
    RecogData(1, 4, "disc_barcode"),
    RecogData(1, 5, "iwaisystem"),
    RecogData(1, 6, "self_gate"),
    RecogData(1, 7, "sys_24hour"),
    RecogData(1, 8, "vismacsystem"),
    RecogData(1, 9, "hq_asp"),
    RecogData(1, 10, "jasaitama_sys"),
    RecogData(1, 11, "promsystem"),
    RecogData(1, 12, "edysystem"),
    RecogData(1, 13, "fresh_barcode"),
    RecogData(1, 14, "sugi_sys"),
    RecogData(1, 15, "hesokurisystem"),
    RecogData(1, 16, "greenstamp_sys"),
    RecogData(1, 17, "coopsystem"),
    RecogData(1, 18, "pointcardsystem"),
    RecogData(2, 1, "mobilesystem"),
    RecogData(2, 2, "hq_other"),
    RecogData(2, 3, "regconnectsystem"),
    RecogData(2, 4, "clothes_barcode"),
    RecogData(2, 5, "fjss"),
    RecogData(2, 6, "mcsystem"),
    RecogData(2, 7, "network_prn"),
    RecogData(2, 8, "poppy_print"),
    RecogData(2, 9, "tag_print"),
    RecogData(2, 10, "taurus"),
    RecogData(2, 11, "ntt_asp"),
    RecogData(2, 12, "eat_in"),
    RecogData(2, 13, "mobilesystem2"),
    RecogData(2, 14, "magazine_barcode"),
    RecogData(2, 15, "hq_other_real"),
    RecogData(2, 16, "pw410system"),
    RecogData(2, 17, "nsc_credit"),
    RecogData(2, 18, "jabar_autoset"),
    RecogData(3, 1, "hq_prod"),
    RecogData(3, 2, "felicasystem"),
    RecogData(3, 3, "psp70system"),
    RecogData(3, 4, "ntt_bcom"),
    RecogData(3, 5, "catalinasystem"),
    RecogData(3, 6, "prcchkr"),
    RecogData(3, 7, "dishcalcsystem"),
    RecogData(3, 8, "itf_barcode"),
    RecogData(3, 9, "css_act"),
    RecogData(3, 10, "cust_detail"),
    RecogData(3, 11, "custrealsvr"),
    RecogData(3, 12, "suica_cat"),
    RecogData(3, 13, "yomocasystem"),
    RecogData(3, 14, "smartplussystem"),
    RecogData(3, 15, "duty"),
    RecogData(3, 16, "ecoasystem"),
    RecogData(3, 17, "iccardsystem"),
    RecogData(3, 18, "sub_ticket"),
    RecogData(4, 1, "quicpaysystem"),
    RecogData(4, 2, "idsystem"),
    RecogData(4, 3, "revival_receipt"),
    RecogData(4, 4, "quick_self"),
    RecogData(4, 5, "quick_self_chg"),
    RecogData(4, 6, "assist_monitor"),
    RecogData(4, 7, "mp1_print"),
    RecogData(4, 8, "realitmsend"),
    RecogData(4, 9, "rainbowcard"),
    RecogData(4, 10, "gramx"),
    RecogData(4, 11, "mm_abj"),
    RecogData(4, 12, "cat_point"),
    RecogData(4, 13, "tagrdwt"),
    RecogData(4, 14, "department_store"),
    RecogData(4, 15, "edyno_mbr"),
    RecogData(4, 16, "fcf_card"),
    RecogData(4, 17, "panamembersystem"),
    RecogData(4, 18, "landisk"),
    RecogData(5, 1, "pitapasystem"),
    RecogData(5, 2, "tuocardsystem"),
    RecogData(5, 3, "sallmtbar"),
    RecogData(5, 4, "business_mode"),
    RecogData(5, 5, "mcp200system"),
    RecogData(5, 6, "spvtsystem"),
    RecogData(5, 7, "remotesystem"),
    RecogData(5, 8, "order_mode"),
    RecogData(5, 9, "jrem_multisystem"),
    RecogData(5, 10, "media_info"),
    RecogData(5, 11, "gs1_barcode"),
    RecogData(5, 12, "assortsystem"),
    RecogData(5, 13, "center_server"),
    RecogData(5, 14, "reservsystem"),
    RecogData(5, 15, "drug_rev"),
    RecogData(5, 16, "gincardsystem"),
    RecogData(5, 17, "fclqpsystem"),
    RecogData(5, 18, "fcledysystem"),
    RecogData(6, 1, "caps_cafis"),
    RecogData(6, 2, "fclidsystem"),
    RecogData(6, 3, "ptcktissusystem"),
    RecogData(6, 4, "abs_prepaid"),
    RecogData(6, 5, "prod_item_autoset"),
    RecogData(6, 6, "prod_itf14_barcode"),
    RecogData(6, 7, "special_coupon"),
    RecogData(6, 8, "bluechip_server"),
    RecogData(6, 9, "hitachi_bluechip"),
    RecogData(6, 10, "hq_other_cantevole"),
    RecogData(6, 11, "qcashier_system"),
    RecogData(6, 12, "receipt_qr_system"),
    RecogData(6, 13, "visatouch_infox"),
    RecogData(6, 14, "pbchg_system"),
    RecogData(6, 15, "hc1_system"),
    RecogData(6, 16, "caps_hc1_cafis"),
    RecogData(6, 17, "remoteserver"),
    RecogData(6, 18, "mrycardsystem"),
    RecogData(7, 1, "sp_department"),
    RecogData(7, 2, "decimalitmsend"),
    RecogData(7, 3, "wiz_cnct"),
    RecogData(7, 4, "absv31_rwt"),
    RecogData(7, 5, "pluralqr_system"),
    RecogData(7, 6, "netdoareserv"),
    RecogData(7, 7, "selpluadj"),
    RecogData(7, 8, "custreal_webser"),
    RecogData(7, 9, "wiz_abj"),
    RecogData(7, 10, "custreal_uid"),
    RecogData(7, 11, "bdlitmsend"),
    RecogData(7, 12, "custreal_netdoa"),
    RecogData(7, 13, "ut_cnct"),
    RecogData(7, 14, "caps_pqvic"),
    RecogData(7, 15, "yamato_system"),
    RecogData(7, 16, "caps_cafis_standard"),
    RecogData(7, 17, "nttd_preca"),
    RecogData(7, 18, "usbcam_cnct"),
    RecogData(8, 1, "drugstore"),
    RecogData(8, 2, "custreal_nec"),
    RecogData(8, 3, "custreal_op"),
    RecogData(8, 4, "dummy_crdt"),
    RecogData(8, 5, "hc2_system"),
    RecogData(8, 6, "price_sound"),
    RecogData(8, 7, "dummy_preca"),
    RecogData(8, 8, "monitored_system"),
    RecogData(8, 9, "jmups_system"),
    RecogData(8, 10, "ut1qpsystem"),
    RecogData(8, 11, "ut1idsystem"),
    RecogData(8, 12, "brain_system"),
    RecogData(8, 13, "pfmpitapasystem"),
    RecogData(8, 14, "pfmjricsystem"),
    RecogData(8, 15, "chargeslip_system"),
    RecogData(8, 16, "pfmjricchargesystem"),
    RecogData(8, 17, "itemprc_reduction_coupon"),
    RecogData(8, 18, "cat_jmups_system"),
    RecogData(9, 1, "sqrc_ticket_system"),
    RecogData(9, 2, "cct_connect_system"),
    RecogData(9, 3, "cct_emoney_system"),
    RecogData(9, 4, "tec_infox_jet_s_system"),
    RecogData(9, 5, "prod_instore_zero_flg"),
    RecogData(9, 6, ""),
    RecogData(9, 7, ""),
    RecogData(9, 8, ""),
    RecogData(9, 9, ""),
    RecogData(9, 10, ""),
    RecogData(9, 11, ""),
    RecogData(9, 12, ""),
    RecogData(9, 13, ""),
    RecogData(9, 14, ""),
    RecogData(9, 15, ""),
    RecogData(9, 16, ""),
    RecogData(9, 17, ""),
    RecogData(9, 18, ""),
    RecogData(10, 1, "front_self_system"),
    RecogData(10, 2, "trk_preca"),
    RecogData(10, 3, "desktop_cashier_system"),
    RecogData(10, 4, "suica_charge_system"),
    RecogData(10, 5, "nimoca_point_system"),
    RecogData(10, 6, "custreal_pointartist"),
    RecogData(10, 7, "tb1_system"),
    RecogData(10, 8, "tax_free_system"),
    RecogData(10, 9, "repica_system"),
    RecogData(10, 10, "caps_cardnet_system"),
    RecogData(10, 11, "yumeca_system"),
    RecogData(10, 12, "dummy_suica"),
    RecogData(10, 13, "payment_mng"),
    RecogData(10, 14, "custreal_tpoint"),
    RecogData(10, 15, "mammy_system"),
    RecogData(10, 16, "itemtyp_send"),
    RecogData(10, 17, "yumeca_pol_system"),
    RecogData(10, 18, "cogca_system"),
    RecogData(11, 1, "custreal_hps"),
    RecogData(11, 2, "maruto_system"),
    RecogData(11, 3, "hc3_system"),
    RecogData(11, 4, "sm3_marui_system"),
    RecogData(11, 5, "kitchen_print"),
    RecogData(11, 6, "bdl_multi_select_system"),
    RecogData(11, 7, "sallmtbar26"),
    RecogData(11, 8, "purchase_ticket_system"),
    RecogData(11, 9, "custreal_uni_system"),
    RecogData(11, 10, "ej_animation_system"),
    RecogData(11, 11, "value_card_system"),
    RecogData(11, 12, "sm4_comodi_system"),
    RecogData(11, 13, "sm5_itoku_system"),
    RecogData(11, 14, "cct_pointuse_system"),
    RecogData(11, 15, "zhq_system"),
    RecogData(11, 16, "special_member_disc_system"),
    RecogData(11, 17, "sm6_kanehide_system"),
    RecogData(11, 18, "stlpdsc_ticket_system"),
    RecogData(12, 1, "sm7_hokushin_system"),
    RecogData(12, 2, "edy_bonuspoint_system"),
    RecogData(12, 3, "rf1_system"),
    RecogData(12, 4, "sm8_taiyo_system"),
    RecogData(12, 5, "sm9_unclefujiya_system"),
    RecogData(12, 6, "hc4_nanba_system"),
    RecogData(12, 7, "rpoint_system"),
    RecogData(12, 8, "themepark1_system"),
    RecogData(12, 9, "vesca_system"),
    RecogData(12, 10, "tmoney_system"),
    RecogData(12, 11, "cr_nsw_system"),
    RecogData(12, 12, "sm10_newsankyu_system"),
    RecogData(12, 13, "ja1_acoop_system"),
    RecogData(12, 14, "sm11_nara_coop_system"),
    RecogData(12, 15, "sm12_foods_land_system"),
    RecogData(12, 16, "ajs_point_system"),
    RecogData(12, 17, "ajs_emoney_system"),
    RecogData(12, 18, "sm13_chuoichiba_system"),
    RecogData(13, 1, "jbrain_system"),
    RecogData(13, 2, "sm14_shoptokai_system"),
    RecogData(13, 3, "hc5_sekichu_system"),
    RecogData(13, 4, "sm15_beniya_system"),
    RecogData(13, 5, "sm16_taiyo_toyocho_system"),
    RecogData(13, 6, "cogca_bonuspoint_system"),
    RecogData(13, 7, "sm17_shufu_nktgw_system"),
    RecogData(13, 8, "sm18_super_value_system"),
    RecogData(13, 9, "custreal_fa_system"),
    RecogData(13, 10, "cr2_nsw_system"),
    RecogData(13, 11, "infox_detail_send_system"),
    RecogData(13, 12, "absv31_rwt_standard"),
    RecogData(13, 13, "custreal_ponta"),
    RecogData(13, 14, "nec_emoney_system"),
    RecogData(13, 15, "sm19_nishimuta_system"),
    RecogData(13, 16, "self_medication_system"),
    RecogData(13, 17, "rececom_qrlink_system"),
    RecogData(13, 18, "sm20_maeda_system"),
    RecogData(14, 1, "sm21_hashidrug_system"),
    RecogData(14, 2, "vismac_qcconnect_system"),
    RecogData(14, 3, "sm22_ichigoukan_system"),
    RecogData(14, 4, "taxfree_by_kind_system"),
    RecogData(14, 5, "sm23_liondor_system"),
    RecogData(14, 6, "set_setmach_system"),
    RecogData(14, 7, "manual_weight_system"),
    RecogData(14, 8, "tec_infox_connect_system"),
    RecogData(14, 9, "special_poical_system"),
    RecogData(14, 10, "sm24_7star_system"),
    RecogData(14, 11, "kitchen_print_num_system"),
    RecogData(14, 12, "hc6_juntendo_system"),
    RecogData(14, 13, "change_fsprbtper_system"),
    RecogData(14, 14, "pana_waon_system"),
    RecogData(14, 15, "onepay_system"),
    RecogData(14, 16, "happyself_system"),
    RecogData(14, 17, "happyself_smile_system"),
    RecogData(14, 18, "sm25_taxfree_system"),
    RecogData(15, 1, "pana_rececon_system"),
    RecogData(15, 2, "ds1_sakaiya_system"),
    RecogData(15, 3, "linepay_system"),
    RecogData(15, 4, "staff_release_system"),
    RecogData(15, 5, "sm26_hokuren_system"),
    RecogData(15, 6, "chgslctitems_keyopt_system"),
    RecogData(15, 7, "reason_select_std_system"),
    RecogData(15, 8, "makersupport_prom_system"),
    RecogData(15, 9, "wiz_base_system"),
    RecogData(15, 10, "pack_on_time_system"),
    RecogData(15, 11, "auto_rbt_cha_system"),
    RecogData(15, 12, "cvs1_sej_system"),
    RecogData(15, 13, "sm27_olympic_system"),
    RecogData(15, 14, "hc7_simachu_system"),
    RecogData(15, 15, "print_addpoint_system"),
    RecogData(15, 16, "sm28_sunshine_system"),
    RecogData(15, 17, "bdl_clsselect_system"),
    RecogData(15, 18, "svscls_stlpdsc_system"),
    RecogData(16, 1, "browser_system"),
    RecogData(16, 2, "pack_on_time_tgate_system"),
    RecogData(16, 3, "sm29_nagaya_system"),
    RecogData(16, 4, "shop_and_go_system"),
    RecogData(16, 5, "sm30_sendo_system"),
    RecogData(16, 6, "movieticket_system"),
    RecogData(16, 7, "std_rececon_system"),
    RecogData(16, 8, "sm31_maruhachi_system"),
    RecogData(16, 9, "staffid1_ymss_system"),
    RecogData(16, 10, "sm32_maruai_system"),
    RecogData(16, 11, "hc8_juntendo_system"),
    RecogData(16, 12, "boarding_pass_read_system"),
    RecogData(16, 13, "taxfree_passportinfo_system"),
    RecogData(16, 14, "sm33_nishizawa_system"),
    RecogData(16, 15, "sm34_toubi_system"),
    RecogData(16, 16, "ds2_godai_system"),
    RecogData(16, 17, "age_verification_system"),
    RecogData(16, 18, "sm35_cupid_system"),
    RecogData(17, 1, "bluechip_ic_system"),
    RecogData(17, 2, "sm36_sanpraza_system"),
    RecogData(17, 3, "cr50_system"),
    RecogData(17, 4, "sm37_yaohan_system"),
    RecogData(17, 5, "case_clothes_barcode_system"),
    RecogData(17, 6, "dpoint_system"),
    RecogData(17, 7, "custreal_dummy_system"),
    RecogData(17, 8, "greenstamp_gmt1000_system"),
    RecogData(17, 9, "sm38_nihonadoshisu_system"),
    RecogData(17, 10, "barcode_pay1_system"),
    RecogData(17, 11, "custreal_ptactix"),
    RecogData(17, 12, "cr3_sharp_system"),
    RecogData(17, 13, "game_barcode_system"),
    RecogData(17, 14, "cct_codepay_system"),
    RecogData(17, 15, "ws_system"),
    RecogData(17, 16, "custreal_pointinfinity"),
    RecogData(17, 17, "toy_system"),
    RecogData(17, 18, "canal_payment_service_system"),
    RecogData(18, 1, "sm39_kasumi_system"),
    RecogData(18, 2, "sm40_yoneya_system"),
    RecogData(18, 3, "open_coupon_system"),
    RecogData(18, 4, "multi_vega_system"),
    RecogData(18, 5, "dispensing_pharmacy_system"),
    RecogData(18, 6, ""),
    RecogData(18, 7, ""),
    RecogData(18, 8, ""),
    RecogData(18, 9, "public_barcode_pay_system"),
    RecogData(18, 10, ""),
    RecogData(18, 11, "ts_indiv_setting_system"),
    RecogData(18, 12, "sm44_ja_tsuruoka_system"),
    RecogData(18, 13, ""),
    RecogData(18, 14, "stera_terminal_system"),
    RecogData(18, 15, "sm45_ocean_system"),
    RecogData(18, 16, "repica_point_system"),
    RecogData(18, 17, ""),
    RecogData(18, 18, "fujitsu_fip_codepay_system"),
    RecogData(19, 1, ""),
    RecogData(19, 2, ""),
    RecogData(19, 3, ""),
    RecogData(19, 4, "taxfree_server_system"),
    RecogData(19, 5, ""),
    RecogData(19, 6, ""),
    RecogData(19, 7, "employee_card_payment_system"),
    RecogData(19, 8, "net_receipt_system"),
    RecogData(19, 9, ""),
    RecogData(19, 10, "sm49_itochain_system"),
    RecogData(19, 11, ""),
    RecogData(19, 12, ""),
    RecogData(19, 13, ""),
    RecogData(19, 14, ""),
    RecogData(19, 15, "public_barcode_pay2_system"),
    RecogData(19, 16, "multi_onepay_system"),
    RecogData(19, 17, "sm52_palette_system"),
    RecogData(19, 18, "public_barcode_pay3_system"),
    RecogData(20, 1, ""),
    RecogData(20, 2, "svscls2_stlpdsc_system"),
    RecogData(20, 3, ""),
    RecogData(20, 4, ""),
    RecogData(20, 5, ""),
    RecogData(20, 6, ""),
    RecogData(20, 7, ""),
    RecogData(20, 8, ""),
    RecogData(20, 9, "sm55_takayanagi_system"),
    RecogData(20, 10, "mail_send_system"),
    RecogData(20, 11, "netstars_codepay_system"),
    RecogData(20, 12, "sm56_kobebussan_system"),
    RecogData(20, 13, ""),
    RecogData(20, 14, ""),
    RecogData(20, 15, "hys1_seria_system"),
    RecogData(20, 16, ""),
    RecogData(20, 17, ""),
    RecogData(20, 18, ""),
    RecogData(21, 1, ""),
    RecogData(21, 2, ""),
    RecogData(21, 3, "liqr_taxfree_system"),
    RecogData(21, 4, "custreal_gyomuca_system"),
    RecogData(21, 5, "sm59_takaramc_system"),
    RecogData(21, 6, "detail_noprn_system"),
    RecogData(21, 7, ""),
    RecogData(21, 8, ""),
    RecogData(21, 9, ""),
    RecogData(21, 10, "sm61_fujifilm_system"),
    RecogData(21, 11, "department2_system"),
    RecogData(21, 12, ""),
    RecogData(21, 13, "custreal_crosspoint"),
    RecogData(21, 14, "hc12_joyful_honda_system"),
    RecogData(21, 15, "sm62_maruichi_system"),
    RecogData(21, 16, ""),
    RecogData(21, 17, ""),
    RecogData(21, 18, ""),
    RecogData(22, 1, "sm65_ryubo_system"),
    RecogData(22, 2, ""),
    RecogData(22, 3, ""),
    RecogData(22, 4, "tomoIF_system"),
    RecogData(22, 5, "sm66_fresta_system"),
    RecogData(22, 6, ""),
    RecogData(22, 7, ""),
    RecogData(22, 8, ""),
    RecogData(22, 9, ""),
    RecogData(22, 10, "cosme1_istyle_system"),
    RecogData(22, 11, "public_barcode_pay4_system"),
    RecogData(22, 12, ""),
    RecogData(22, 13, "sm71_selection_system"),
    RecogData(22, 14, "kitchen_print_recipt"),
    RecogData(22, 15, "miyazaki_city_system"),
    RecogData(22, 16, "sp1_qr_read_system"),
    RecogData(22, 17, "rf1_hs_system"),
    RecogData(22, 18, ""),
    RecogData(23, 1, ""),
    RecogData(23, 2, "cashonly_keyopt_system"),
    RecogData(23, 3, "aibox_system"),
    RecogData(23, 4, ""),
    RecogData(23, 5, ""),
    RecogData(23, 6, "sm74_ozeki_system"),
    RecogData(23, 7, "carparking_qr_system"),
    RecogData(23, 8, ""),
    RecogData(23, 9, ""),
    RecogData(23, 10, "olc_system"),
    RecogData(23, 11, "quiz_payment_system"),
    RecogData(23, 12, "jets_lane_system"),
    RecogData(23, 13, ""),
    RecogData(23, 14, ""),
    RecogData(23, 15, ""),
    RecogData(23, 16, ""),
    RecogData(23, 17, ""),
    RecogData(23, 18, ""),
    RecogData(0, 0, "")
  ];
}
///  関連tprxソース: rxmbratachk.h - RECOGKEY_SQL_RECOGINFO_SET;
class RxMbrAtaChk{
  static const  RECOGKEY_SQL_RECOGINFO_SET =
      "update c_recoginfo_mst "
      "set password = @password, fcode = @fcode, upd_datetime = 'now' , status = '0', send_flg = '0', upd_user = @upd_user, upd_system = '0' "
      "where comp_cd = @comp and stre_cd = @stre and mac_no = @mac and page = @page";

  /* recog.hから移動 */
  static const RECOG_PAGE_MAX = 64;	/* 最大頁数 */
  static const RECOG_FUNC_MAX = 18;	/* １頁あたりのファンクション数 */

  static const String DEV_ATA = "/dev/hdb1"; /* 標準デバイス名 */
  static const String DIR_ATA = "/customer"; /* 標準指定ディレクトリ */
  static const String DIR_ORG = "/pj/tprx/conf";

  static const String SECT_TYPE = "type";

  static const String MBR_SYSTEM = "membersystem";
  static const String MBR_POINT = "memberpoint";
  static const String MBR_FSP = "memberfsp";

  static const int TOKEN_SZ = 256; /* トークンサイズ */

  static const String DIR_LOOP_CNCT = "/tmp/loop_cnct_save/"; // 日中送信ファイルディレクトリ

  static const String PREFIX_PACK_ON_TIME = "PackOnTime"; // PackOnTime仕様での日中送信参照ファイル接頭辞
  static const String PREFIX_SEND_PACK_ON_TIME = "POT_"; // PackOnTime仕様での日中送信ファイル接頭辞
  static const String PREFIX_PACK_ON_TIME_TGATE = "TGATE_PackOnTime"; // PackOnTime仕様での日中送信参照ファイル接頭辞
  static const String PREFIX_SEND_PACK_ON_TIME_TGATE = "RESZD"; // PackOnTime仕様での日中送信ファイル接頭辞

  static const int RECOG_EMER_LIMIT_DATE = 10; /* 緊急承認キーのリミット日数 */

  static const String DPOINT_DELFILE_NAME = "Tank007*";
  static const String DPOINT_DEL_BATCH_EXTENTION = ".dat";
  static const String DPOINT_DEL_ERR_EXTENTION = ".err";
  static const String DPOINT_DEL_CHK_EXTENTION = ".chk";
  static const String DPOINT_DEL_END_EXTENTION = ".end";
  static const String DPOINT_DEL_OK_EXTENTION = ".OK";
  static const String DPOINT_DEL_NG_EXTENTION = ".NG";

  static const String PASTCOMP_FILE_HEAD = "c_header_log_%s_%06ld.past"; // ヘッダーログの過去実績出力ファイル
  static const String PASTCOMP_FILE_STATUS = "c_status_log_%s_%06ld.past"; // ステータスログの過去実績出力ファイル
  static const String PASTCOMP_FILE_DATA = "c_data_log_%s_%06ld.past"; // データログの過去実績出力ファイル
  static const String PASTCOMP_FILE_EJ = "c_ej_log_%s_%06ld.past"; // ジャーナルログの過去実績出力ファイル
  static const String PASTCOMP_FILE_LINKAGE = "c_linkage_log_%s_%06ld.past"; // リンケージログの過去実績出力ファイル
  static const String PASTCOMP_FILE_BKDIR = "%s/tran_backup/bkcomp_file/"; // 圧縮ファイルの保存先ディレクトリ
  static const String PASTCOMP_FILE_NAME = "PAST_%s_%06ld.tar.gz"; // 取引検索と圧縮ファイル作成時の圧縮ファイル名
  static const String PASTCOMP_FILE_ALL = "PAST_*.tar.gz"; // ファイル初期化時の圧縮ファイル名
  static const String PASTCOMP_TARGET_FILE = "*_%06ld.past"; // 圧縮前の対象ファイル}
}