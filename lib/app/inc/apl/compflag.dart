/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// C言語でコンパイルフラグとして設定されていた物.
///  関連tprxソース:compflag.h
class CompileFlag {
  //-------------------------
  // #define country select data
  // ------------------------
  ///China Be careful of [SEGMENT]
  static const CN = false;

  ///Taiwan
  static const TW = false;

  ///English
  static const EX = false;

  /// Japanese
  static const JPN = (true & !CN && !TW && !EX);

  //-------------------------
  // #define File data
  // ------------------------
  static const AUTO_COIN = (true && !CN && !TW && !EX);

  ///cm_rdsysdata(TERMINAL);
  static const TERMINAL = false;

  ///
  static const MBR_SPEC = false;
  static const MIX_MATCH = true;
  static const SET_MATCH = true;
  static const BOTTLE_RETURN = true;
  static const MANUAL_STAMP = true;
  static const ELECTRIC_LOG = true;
  static const USE_PERSONKEY = true;
  static const USE_CUSTLAYER = true;

  ///@@@
  static const FSP_POINTPER = false;

  ///@@@
  static const FSP_CLSMULTI = false;

  ///@@@
  static const FSP_PRIMULTI = false;
  static const DEBIT_CREDIT = (true && !CN && !TW && !EX);
  static const SIMPLE_STAFF = true;
  static const SIMPLE_2STAFF = (true && SIMPLE_STAFF && !TW);
  static const SCALE_SYSTEM = true;
  static const REWRITE_CARD = (true && !CN && !TW);
  static const DISC_BARCODE = true;
  static const IWAI = (true && !CN && !TW && !EX);
  static const SELF_GATE = (true && !CN && !TW && !EX);
  static const RCPT_BARCODE = true;
  static const FSP_REWRITE = (true && REWRITE_CARD);
  static const EJLOG_SEARCH = (true && ELECTRIC_LOG && !TW);
  static const VISMAC = (true && REWRITE_CARD);
  static const HQ_ASP = true;
  static const COIN_CLS_INPUT = (true && !CN && !TW && !EX);
  static const IIS21 = (true && !CN && !TW && !EX);
  static const MOBILE_POS = (true && !CN);

  ///@@@
  static const PROM = (false && !CN);
  static const DECIMAL_POINT = (CN || EX);
  static const FRESH_BARCODE = (true && DISC_BARCODE);
  static const MBR_ITEMDSC = (true && !CN);
  static const BOOK_BARCODE = (true && !CN);
  static const POINT_CARD = (true && !CN && !TW && !EX);
  static const PLU_ADD_POINT = (true && !CN);
  static const BIRTHDAY_POINT = (true && !CN);
  static const STATION_PRINTER = CN;
  static const NOMBR_POINT_PRN = (true && !CN);
  static const OFF_MODE = true;
  static const CLOTHES_BARCODE = (true && !CN);
  static const FJSS = (true && !CN && !TW);
  // TODO:10032 コンパイルスイッチ(MC_SYSTEM)
  static const MC_SYSTEM = (false && !CN && !TW && !EX);
  static const SEARCH_VOID = (true && ELECTRIC_LOG);
  static const POPPY_PRINT = (true && !CN);
  static const TAG_PRINT = (true && !CN);

  ///@@@
  static const FSP_ITEMDSC =
  (false && !CN && FSP_CLSMULTI && FSP_PRIMULTI && MBR_ITEMDSC);
  static const NETWORK_PRN = (true && !CN && !TW);
  static const BONUS_POINT = (true && !CN);
  static const TAX_CALC = (true && !CN && !EX);
  static const SET_SIMS = TW;
  static const OPNCLS_PASSWORD = (CN || TW);
  static const FIP_DISP_EX = TW;
  static const TW_2S_PRINTER = TW;
  static const ACB_50 = (true && AUTO_COIN);
  static const PRIME_FIP = EX;
  static const TW_OPNCLS_STAFF = TW;
  static const INTAX_SHARE = (true && !CN && !TW && !EX);
  static const SEGMENT = (true && !MC_SYSTEM);
  static const PW410_SYSTEM = (true && !CN && !TW && !EX);
  static const RALSE_MBRSYSTEM = (true && !CN && !TW && !EX);
  static const CN_NSC = (false && CN);
  static const SAPPORO = (true && POINT_CARD && !MC_SYSTEM);
  static const RALSE_CREDIT = (true && RALSE_MBRSYSTEM && !CN && !TW && !EX);
  static const OPELVL_CNCL = (CN || EX);
  static const PSP_70 = (false && !CN && !TW && !EX);
  static const FELICA_SMT = (false && !CN && !TW && !EX);
  static const MXSM_COUNTUP = true;
  static const RLS_MULFIP = true;
  static const RLS_REPEAT = true;
  static const PRESET_ITEM = true;
  static const PROTECT_INF = (true && !CN && !TW && !EX);
  static const SELF_S_STAFF = (true && SELF_GATE && SIMPLE_2STAFF);
  //　CATALINA_SYSTEM　trueで固定のため、if文で実装しなくてもよい
  static const CATALINA_SYSTEM = (true && !CN && !TW && !EX);
  static const EXTRA = true;
  static const NEW_TRANS = true;
  static const ITF18_BARCODE = (CN || TW);
  static const SSPS_ONLY = (true && SELF_GATE);
  static const SSPS_SOUND = (true && SELF_GATE);
  static const FB_FENCE_OVER = (true && FB2GTK);
  static const FB_CUST_DETAIL = (true && FB_FENCE_OVER && FB2GTK);
  static const NEW_OPNCLS = true;
  static const CUSTREALSVR = (true && !DEPARTMENT_STORE);
  static const SMARTPLUS = (true && !CN && !TW && !EX);
  static const SUICA_ENC = true;
  static const MP1_PRINT = (true && !CN && !TW && !EX);
  static const GRAMX = (false && !CN && !TW && !EX);
  static const SIMS_CUST = (true && !CN);
  static const DEPARTMENT_STORE = (false && FB2GTK && !CN && !TW && !EX);
  static const CUSTBIRTHSERCH = (false && CUSTREALSVR);
  static const SALELMT_BAR = true;
  static const BUSINESS_MODE = (true && FB2GTK && !CN && !TW && !EX);
  static const HQ_ASP_NEW = true;
  static const ARCS_MBR = (true && RALSE_CREDIT);
  static const CENTOS = true;
  static const IC_CONNECT = (false && FB2GTK && !CN && !TW && !EX);
  static const RESERV_SYSTEM = true;
  static const DRUG_REVISION = (false && FB2GTK && !CN && !TW && !EX);
  static const PASMO = (false && !CN && !TW && !EX);
  static const KITACA = (false && !CN && !TW && !EX);
  static const ACX_CHGTRAN = (true && !CN && !TW && !EX);
  static const RESERV_ACX = (true && RESERV_SYSTEM && !CN && !TW && !EX);
  static const COLORFIP = (true && !CN && !TW && !EX);
  static const SP_RECOG = true;
  static const RCTLOGO_STPRN = true;
  static const LOG_THREAD = true;
  static const CASH_RECYCLE = (true && !CN && !TW && !EX);
  static const UPD_TEST = false;
  static const DATA_SHIFT = true;
  static const FTP_CHANGE = true;
  static const BDL_PER = true;
  static const ARCS_VEGA = (true && ARCS_MBR);
  ///for 2400disp
  static const COMMON_DISP = true;
  static const NEW_VERUP = true;
  static const ACX_LOG_SPEEDUP = true;

  ///有効化する際には、qcashier.ini のコメントを外してください
  static const SS_CR2 = false;
  static const DB_SUB_GROUP = true;
  static const SMART_SELF = true;
  static const SMART_SELF_SPEEDUP = (true && SMART_SELF);
  static const FCON_MULTI_DSP = true;
  static const FCON_RANGE_MODE = (true && FCON_MULTI_DSP);
  /////Web2800でWeb3800用動作を確認するため 一時的なもので最終的には削除します
  static const WEB3800_TEST = false;
  static const RCPTVOID_PROM = false;
  static const GODAI_SVSTBL = true;
  static const EXPAND_MSGMST = true;
  static const QUICK_0_AND_4_MERGE = true;
  static const ZHQ_TS_COOPERATE = true;
  static const VUP_FREQ = false;
  static const CENTOS_G3 = false;

  ///https://onl.bz/E8PU2BJ	. Teams -> POSチーム(非公開) -> 099_DEBUG_MODE
  static const DEBUG_MODE = false;

  ///インボイス対応
  static const TAX_2019 = true;  // 軽減税率対応. 後で削除する
  static const INVOICE_SYSTEM = false;

  // TODO:10011 コンパイルスイッチ(元ソースに定義なし) ifdefが残っているもの.削除して良いかあとで確認する.
  static const FB2GTK = false;

  // デバッグ時
  static const DEBUG_TEST = true;

  // RM系 ロック・フィールド仕様
  static const RF1_SYSTEM = false;

  static const PPSDVS = true;
}
