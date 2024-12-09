/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import '../../inc/lib/apl_cnv.dart';
import '../../lib/apllib/apllib_staffpw.dart';

///  関連tprxソース: rc_elog.h
class RcElog{
  static const EJCONF_LCDDISP = 1;
  static const EJCONF_SUBDISP = 2;
  static const EVOID_LCDDISP = 3;
  static const EVOID_SUBDISP = 4;
  static const EREF_LCDDISP = 3;
  static const EREF_SUBDISP = 4;
  static const ESVOID_LCDDISP = 3;
  static const ESVOID_SUBDISP = 4;
  static const ERCTFM_LCDDISP = 3;
  static const ERCTFM_SUBDISP = 4;
  static const CRDTVOID_LCDDISP = 3;
  static const CRDTVOID_SUBDISP = 4;
  static const PRECAVOID_LCDDISP = 3;
  static const PRECAVOID_SUBDISP = 4;
  static const DELIVSVC_LCDDISP = 3;
  static const EJCONF_FINDDISP = 5;
  static const STAFF_SUBDISP = 6;

  // #if CN || TW
// static const EJDISPLINEMAX = 23;
  // #else
  static const EJDISPLINEMAX = 29;
  //#endif
  static const EJPRNRETRYCNT = 100;

/* EJLOG_SEARCH */
  static const EJCONF_TEXT_SEARCH_BUF_LEN = 50;
// static const EJCONF_TEXT_SEARCH_FIL = 10;
  static const EJCONF_TEXT_SEARCH_FIL = 101;
  static const EJCONF_TEXT_SEARCH_SHOW_MAX = 16;
/* EJLOG_SEARCH */

//  #if RALSE_CREDIT
  static const SCNCARDDSP      = 0x10;
  static const SCNCASHCARDDSP  = 0x20;
  static const SCNCASHCARDCALL = 0x40;
//  #endif

  static const EJSELPRNMAX = 4;

  static const CRDTVOID_SPVT = 1;

  static const SALE_DATE_LEN = 19;
  static const EJCONF_MODE_FIND_MAX = 42; /* OPE_MODE_SP_TCKT_TR */

  static const ESV_OLD = 0;
  static const ESV_NEW = 1;
}

/*---------------------------------------------------------------------------*
 *  Display & Print EjConf Datas
 *---------------------------------------------------------------------------*/
///  関連tprxソース: rc_elog.h  SoftKeyList
enum SoftKeyList {
  sKey1(0),
  sKey2(1),
  sKey3(2),
  sKey4(3),
  sKey5(4),
  sKey6(5),
  sKey7(6),
  sKey8(7),
  sKey9(8),
  sKey0(9),
  sKeyClr(10),
  sKeyMax(11);
  final int value;
  const SoftKeyList(this.value);
}

///  関連tprxソース: rc_elog.h struct SKey_t
class SoftKeyT {
// GtkWidget	*btn;
  List<String> name = List.generate(128, (_) => "");
  int key = 0;
}

///  関連tprxソース: rc_elog.h struct EJCONF_SEL_PRN
class EjConfSelPrn {
  List<String> nowSaleDatetime = List.generate(31, (_) => ""); // now sales datetime
  int receiptNo = 0; // receipt no
  int printNo = 0; // journal no
}

///  関連tprxソース: rc_elog.h struct EJCONF
class EjConf {
  int dialog = 0;
  List<String> put = List.generate(10, (_) => "");
  int topReceiptNo = 0;
  int topPrintNo = 0;
  int topSeqNo = 0;
  List<String> topNowSaleDatetime = List.generate(28, (_) => "");
  int topLine = 0;
  int btmReceiptNo = 0;
  int btmPrintNo = 0;
  int btmSeqNo = 0;
  List<String> btmNowSaleDatetime = List.generate(28, (_) => "");
  int btmLine = 0;
  int dispLine = 0;
  int dispEnd = 0;
  int fEnter = 0;
  int fCondition = 0;
  int fSelect = 0;
  int fEnterPosition = 0;
  int fDefEntry = 0;
  int fDisplay = 0;
  int nowDisplay = 0;
  List<String> chDate = List.generate(10, (_) => "");
  List<String> chDate2 = List.generate(10, (_) => "");
  int chReceipt1 = 0;
  int chReceipt2 = 0;
  int chMacNo = 0;
  List<String> chTime1 = List.generate(10, (_) => "");
  List<String> chTime2 = List.generate(10, (_) => "");
  List<String> textSearchBuf = List.generate((RcElog.EJCONF_TEXT_SEARCH_BUF_LEN + RcElog.EJCONF_TEXT_SEARCH_FIL), (_) => "");
  int printGo = 0;
  int printConf = 0;
  int printError = 0;
  int printErrorMsg = 0;
  int printErrorCount = 0;
  int printLine = 0;
  int printReadLine = 0;
  int savePrintLine = 0;
  int dialogConf = 0;
  int dialogMSGNO = 0;
  List<String> printData = List.generate(12001, (_) => "");
  int printReceiptNo = 0;
  int printPrintNo = 0;
  int printSeqNo = 0;
  int printEjLine = 0;
  int makeTempTbl = 0;      // make temp 0:no 1:yes
  List<String> findMode = List.generate(RcElog.EJCONF_MODE_FIND_MAX, (_) => "");       // mode 0:no 1:yes
                                                                                        //   [0]:RG
                                                                                        //   [1]:TR
                                                                                        //   [2]:VD
                                                                                        //   [3]:SR
                                                                                        //   [4]:mente
                                                                                        //   [5]:file confirm
                                                                                        //   [6]:sales check
                                                                                        //   [7]:sales account
                                                                                        //   [8]:set
                                                                                        //   [9]:change price
                                                                                        //  [10]:close
                                                                                        //  [11]:store open and close
                                                                                        //  [12]:
                                                                                        //  [13]:
                                                                                        //  [14]:sales flash
                                                                                        //  [15]:
                                                                                        //  [16]:OD
                                                                                        //  [17]:IV
                                                                                        //  [18]:
                                                                                        //  [19]:
                                                                                        //  [20]:
                                                                                        //  [21]:
                                                                                        //  [22]:
                                                                                        //  [23]:PD
                                                                                        //  [24]:
                                                                                        //  [25]:
                                                                                        //  [26]:
                                                                                        //  [27]:
                                                                                        //  [28]:
                                                                                        //  [29]:
                                                                                        //  [30]:
                                                                                        //  [31]:
                                                                                        //  [32]:
                                                                                        //  [33]:
                                                                                        //  [34]:
                                                                                        //  [35]:
                                                                                        //  [36]:
                                                                                        //  [37]:
                                                                                        //  [38]:
                                                                                        //  [39]:
                                                                                        //  [40]:QCTCKT_RG
                                                                                        //  [41]:QCTCKT_TR
  int findItem = 0; // item 0:no 1:yes
  int findFnc1 = 0; // function 0:none !0:function
  int findFncCondi1 = 0; // condition 0:OR 1:AND
  int findFnc2 = 0; // function 0:none !0:function
  int findFncCondi2 = 0; // condition 0:OR 1:AND
  int findFnc3 = 0; // function 0:none !0:function
  int findFncCondi3 = 0; // condition 0:OR 1:AND
  int findDecFlg = 0; // decision 0:no 1:yes
  int findDelFlg = 0; // delete mode 0:no 1:yes
  int findDecPush = 0; // decision 0:no 1:yes
  List<String> textSearchBuf2 = List.generate((RcElog.EJCONF_TEXT_SEARCH_BUF_LEN + RcElog.EJCONF_TEXT_SEARCH_FIL), (_) => "");
  int findReturn = 0; // 0:Display 1:Printer
  List<String> eFindMode = List.generate(RcElog.EJCONF_MODE_FIND_MAX, (_) => "");         // mode 0:no 1:yes
                                                                                            //  [0]:RG
                                                                                            //  [1]:TR
                                                                                            //  [2]:VD
                                                                                            //  [3]:SR
                                                                                            //  [4]:mente
                                                                                            //  [5]:file confirm
                                                                                            //  [6]:sales check
                                                                                            //  [7]:sales account
                                                                                            //  [8]:set
                                                                                            //  [9]:change price
                                                                                            // [10]:close
                                                                                            // [11]:store open and close
                                                                                            // [12]:
                                                                                            // [13]:
                                                                                            // [14]:sales flash
                                                                                            // [15]:
                                                                                            // [16]:OD
                                                                                            // [17]:IV
                                                                                            // [18]:
                                                                                            // [19]:
                                                                                            // [20]:
                                                                                            // [21]:
                                                                                            // [22]:
                                                                                            // [23]:PD
                                                                                            // [24]:
                                                                                            // [25]:
                                                                                            // [26]:
                                                                                            // [27]:
                                                                                            // [28]:
                                                                                            // [29]:
                                                                                            // [30]:
                                                                                            // [31]:
                                                                                            // [32]:
                                                                                            // [33]:
                                                                                            // [34]:
                                                                                            // [35]:
                                                                                            // [36]:
                                                                                            // [37]:
                                                                                            // [38]:
                                                                                            // [39]:
                                                                                            // [40]:QCTCKT_RG
                                                                                            // [41]:QCTCKT_TR
  int eFindItem = 0; // item 0:no 1:yes
  int eFindFnc1 = 0; // function 0:none !0:function
  int eFindFncCondi1 = 0; // condition 0:OR 1:AND
  int eFindFnc2 = 0; // function 0:none !0:function
  int eFindFncCondi2 = 0; // condition 0:OR 1:AND
  int eFindFnc3 = 0; // function 0:none !0:function
  int eFindFncCondi3 = 0; // condition 0:OR 1:AND
  List<String> eTextSearchBuf2 = List.generate((RcElog.EJCONF_TEXT_SEARCH_BUF_LEN + RcElog.EJCONF_TEXT_SEARCH_FIL), (_) => "");
  StaffData staffData = StaffData(); // 従業員パスワード画面引数
// #if MM_DD_YY || DD_MM_YY
//   char      date_buf[10];
//   char      date2_buf[10];
// #endif
  int procFlg = 0;
  int endDateDspFlg = 0; // end date
  int endDateFlg = 0; // end date
  int dbReadFlg = 0;  // EJ-LOG READ
                        // 0:DB
                        // 1:HDD
                        // 2:CD-R
  int selPrn = 0;
  List<EjConfSelPrn> selPrnDat =
      List.generate(RcElog.EJSELPRNMAX, (_) => EjConfSelPrn());
  int searchFlg = 0;
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *text;
  // GtkWidget *condition;
  // GtkWidget *date;
  // GtkWidget *date_fix;
  // GtkWidget *date_label;
  // GtkWidget *date_entry;
  // /* 2005/08/29 >>> */
  // GtkWidget *date2;
  // GtkWidget *date2_fix;
  // GtkWidget *date2_label;
  // GtkWidget *date2_entry;
  // /* <<< 2005/08/29 */
  // GtkWidget *receipt;
  // GtkWidget *receipt_label;
  // GtkWidget *receipt_fix;
  // GtkWidget *receipt_tolabel;
  // GtkWidget *receipt_entry1;
  // GtkWidget *receipt_entry2;
  // GtkWidget *macno;
  // GtkWidget *macno_label;
  // GtkWidget *macno_fix;
  // GtkWidget *macno_entry;
  // GtkWidget *time;
  // GtkWidget *time_label;
  // GtkWidget *time_fix;
  // GtkWidget *time_tolabel;
  // GtkWidget *time_entry1;
  // GtkWidget *time_entry2;
  // /* EJLOG_SEARCH */
  // GtkWidget *search_char_title;
  // GtkWidget *search_char_label1;
  // GtkWidget *search_char_label_condi1;
  // GtkWidget *search_char_label2;
  // GtkWidget *search_char_label_condi2;
  // GtkWidget *search_char_label3;
  // /* EJLOG_SEARCH */
  // GtkWidget *evoid;
  // GtkWidget *esvoid;
  // GtkWidget *eref;
  // GtkWidget *enter;
  // GtkWidget *select;
  // GtkWidget *top;
  // GtkWidget *bottom;
  // GtkWidget *bfre_receipt;
  // GtkWidget *next_receipt;
  // GtkWidget *bfre_page;
  // GtkWidget *next_page;
  // GtkWidget *text_search;
  // GtkWidget *down;
  // GtkWidget *up;
  // GtkWidget *print;
  // GtkWidget *disp;
  // GtkWidget *end;
  // GtkWidget *erctfm;
  // GtkWidget *find;
  // GtkWidget *find_window;
  // GtkWidget *find_fixed;
  // GtkWidget *find_title;
  // GtkWidget *find_mode_btn[EJCONF_MODE_FIND_MAX];
  // GtkWidget *find_item_btn;
  // GtkWidget *find_fnc1_btn;
  // GtkWidget *find_fnc_btn_condi1;
  // GtkWidget *find_fnc2_btn;
  // GtkWidget *find_fnc_btn_condi2;
  // GtkWidget *find_fnc3_btn;
  // GtkWidget *find_fnc_btn_condi3;
  // GtkWidget *find_char_btn;
  // GtkWidget *find_char_lbl;
  // GtkWidget *find_dec_btn;
  // GtkWidget *find_del_btn;
  // GtkWidget *find_end_btn;
  // GtkWidget *crdtvoid;
  // GtkWidget *precavoid;
  //
  // GtkWidget *rj_prn_btn[EJSELPRNMAX];
  // GtkWidget *cashvoid;
  // GtkWidget *camera_btn;
}

///  関連tprxソース: rc_elog.h struct EREF
class ERef{
  int     dialog = 0;
  int     errNo = 0;
  int     fEnter = 0;
  int     fEnterPosition = 0;
  int     fSign = 0;
  int     nowDisplay = 0;
  /// char      put[32];
  String      put = '';
  int    printNo = 0;
  int       opeModeFlg = 0;
  /// char      date[10];
  String      date = '';
  int      macno = 0;
  int      recno = 0;
  int      amt = 0;
  int      refAmt = 0;
  int      refQty = 0;
  /// char      dflt_date[10];
  String      dfltDate = '';
  int      dfltMacno = 0;
  int      dfltRecno = 0;
  int      dfltAmt = 0;
  int    rPosition = 0;
  // #if MM_DD_YY || DD_MM_YY
  // char      date_buf[10];
  // #endif
  int     mbrstlpdscflg = 0;
  // GtkWidget *winref;
  // GtkWidget *winref_fix;
  // GtkWidget *ref_amt_btn;
  // GtkWidget *ref_amt_ent;
  // GtkWidget *ref_qty_btn;
  // GtkWidget *ref_qty_ent;
  // GtkWidget *ttl_label;
  // GtkWidget *entref_btn;
  // GtkWidget *execref_btn;
  // GtkWidget *endref_btn;
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *date_btn;
  // GtkWidget *date_ent;
  // GtkWidget *macno_btn;
  // GtkWidget *macno_ent;
  // GtkWidget *recno_btn;
  // GtkWidget *recno_ent;
  // GtkWidget *amt_btn;
  // GtkWidget *amt_ent;
  // GtkWidget *sign_btn;
  // GtkWidget *ent_btn;
  // GtkWidget *exec_btn;
  // GtkWidget *end_btn;
  /// char serial_no[sizeof(((c_header_log *)NULL)->serial_no)];
  String serialNo = '';
  TLogParam tlogParam = TLogParam();
  int server = 0;
}

///  関連tprxソース: rc_elog.h struct ESVOID
class EsVoid{
  int     dialog = 0;
  int     errNo = 0;
  int     fEnter = 0;
  int     fEnterPosition = 0;
  int     fSign = 0;
  int     nowDisplay = 0;
  /// char      put[32];
  String      put = '';
  int      printNo = 0;
  int       opeModeFlg = 0;
  /// char      date[10];
  String      date = '';
  int      macno = 0;
  int      recno = 0;
  int      amt = 0;
  int     rPosition = 0;
  /// char      cnclflg[ITEM_MAX];
  String      cnclflg = '';
  int     maxpage = 0;
  int     pageno = 0;
  int       dsptype = 0;
  int     cflg = 0;
  int      sprc = 0;
  int      qtyflg = 0;
  int      qty = 0;
  int     dscno = 0;
  /// long      dsc[6];
  List<int>      dsc = List<int>.filled(6, 0);
  int     pdscno = 0;
  int     pdsc = 0;
  int      pdscamt = 0;
  int     sdpdscno = 0;
  int     sdpdsc = 0;
  int      sdpdscamt = 0;
  int     stampno = 0;
  int      stamp = 0;
  /// short     stmpcnt[6];
  List<int>     stmpcnt = List<int>.filled(6, 0);
  int      rbtdsc = 0;
  /// short     plus[6];
  List<int?>     plus = List<int?>.empty();
  int      othdscamt = 0;
  int      ttlamt = 0;
  /// long      cash[2][ESV_CASHMAX];
  List<List<int?>>     cash = List<List<int?>>.empty();
  int      chgamt = 0;
  int      chg = 0;
  int      ttl = 0;
  /// char      cflg_name[66];
  String      cflgName = '';
  /// char      prc_name[66];
  String      prcName = '';
  /// char      qty_name[3][66];
  List<String> qtyName = List<String>.empty();
  /// char      othdsc_name[66];
  String      othdscName = '';
  /// char      spcflg_name[66];
  String      spcflgName = '';
  /// char      rbt_name[66];
  String      rbtName = '';
  /// char      allcncl_name[66];
  String      allcnclName = '';
  /// char      stamp_name[6][66];
  List<String?> stampName = List<String?>.empty();
  /// char      dsc_name[6][66];
  List<String?> dscName = List<String?>.empty();
  /// char      pdsc_name[6][66];
  List<String?> pdscName = List<String?>.empty();
  /// char      plus_name[6][66];
  List<String?> plusName = List<String?>.empty();
  /// char      cash_name[ESV_CASHMAX][66];
  List<String?> cashName = List<String?>.empty();
  int     ItemCurr = 0;
  int     StlDscRecCnt = 0;
  int     StlPlusRecCnt = 0;
  int      rtnChg = 0;
  bool?      allcnclflg;
  /// short     sht[ESV_CASHMAX];
  List<int?>     sht = List<int?>.empty();
  /* 08/02/14 */
  int     dscamtFlg = 0;
//#if RALSE_CREDIT
  int     scndspFlg = 0;
  int     syoriFlg = 0;
  int      gcatAmt = 0;
//#endif
//   #if MM_DD_YY || DD_MM_YY
//   char      date_buf[10];
//   #endif
  int     shtInFl = 0;
  // GtkWidget *swin;
  // GtkWidget *swin_fix;
  // GtkWidget *sttl_label;
  // GtkWidget *sothdsc_label;
  // GtkWidget *sbtn[7];
  // GtkWidget *sent[7];
  // GtkWidget *sht_ent[7];
  // GtkWidget *sht_amt_ent[7];
  // GtkWidget *sent_btn;
  // GtkWidget *snext_btn;
  // GtkWidget *sbefor_btn;
  // GtkWidget *sexec_btn;
  // GtkWidget *send_btn;
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *date_btn;
  // GtkWidget *date_ent;
  // GtkWidget *macno_btn;
  // GtkWidget *macno_ent;
  // GtkWidget *recno_btn;
  // GtkWidget *recno_ent;
  // GtkWidget *amt_btn;
  // GtkWidget *amt_ent;
  // GtkWidget *sign_btn;
  // GtkWidget *ent_btn;
  // GtkWidget *exec_btn;
  // GtkWidget *end_btn;
  // GtkWidget *stldsclbl[10];
  // GtkWidget *stldscfixed;
  // GtkWidget *bc_btn;
  bool?	     regsprnflg;
  bool?      dataserchFlg;
  bool?      esvoidendFlg;
  /// short     man_cnt[ESV_CASHMAX];
  List<int?>     manCnt = List<int?>.empty();
  int     voidUpdateFlg = 0;
  int      itemMacno = 0;
  int      itemRecno = 0;
  int     speezadbOpnFlg = 0;
  int     cashvoidDspTyp = 0;
  int      orgMacNo = 0;
  int      payCondition = 0;
  // GtkWidget *message_ent;
  /// char      cpn_bar_cd[ESV_CASHMAX][14];
  List<String?> cpnBarCd = List<String?>.empty();
  Icpntvoid nimoca = Icpntvoid();
  /// char serial_no[sizeof(((c_header_log *)NULL)->serial_no)];
  String serialNo = '';
  TLogParam tlogParam = TLogParam();
  int server = 0;
  int carddspFlg = 0;
}

///  関連tprxソース: rc_elog.h struct ERCTFM
class Erctfm {
  int dialog = 0;
  int errNo = 0;
  int fEnter = 0;
  int fEnterPosition = 0;
  int fSign = 0;
  int nowDisplay = 0;
  int nowSelectDisplay = 0;
  String put = "";
  int printNo = 0;
  String date = "";
  String nowSaleDate = "";
  String nowSaleTime = "";
  int macNo = 0;
  int recNo = 0;
  int amt = 0;
// #if MM_DD_YY || DD_MM_YY
  String dateBuf = ""; /* sale_date */
  String dateBuf2 = "";  /* now_sale_date */
// #endif
// GtkWidget *window;
// GtkWidget *win_fix;
// GtkWidget *title;
// GtkWidget *date_btn;
// GtkWidget *date_ent;
// GtkWidget *now_saledate_btn;
// GtkWidget *now_saledate_ent;
// GtkWidget *now_saletime_btn;
// GtkWidget *now_saletime_ent;
// GtkWidget *macno_btn;
// GtkWidget *macno_ent;
// GtkWidget *amt_btn;
// GtkWidget *amt_ent;
// GtkWidget *sign_btn;
// GtkWidget *ent_btn;
// GtkWidget *exec_btn;
// GtkWidget *end_btn;
// GtkWidget *find_window;
// GtkWidget *find_win_fix;
// GtkWidget *find_title;
// GtkWidget *find_inf_ent;
// GtkWidget *find_sel_ent[3];
// GtkWidget *find_sel_btn[3];
// GtkWidget *find_bf_btn;
// GtkWidget *find_af_btn;
// GtkWidget *find_end_btn;
  String serialNo = "";
  TLogParam tLogParam = TLogParam();
  int server = 0;
  List<SoftKeyT> sKey = List<SoftKeyT>.generate(SoftKeyList.sKeyMax.value, (_) => SoftKeyT());
  int opeModeFlg = 0;
//   GtkWidget *TenKeyWindow;   // RM-3800でソフトテンキーの為追加
}

///  関連tprxソース: rc_elog.h struct ICPNTVOID
class Icpntvoid{
  /// char    number[17+1];	/* Card No */
  String    number = '';
  /// char	card_type;	/* Card Type */
  String	cardType = '';
  /// ushort	rct_id;		/* Rct Id */
  String	rctId = '';		/* Rct Id */
  /// ushort	act_cd;		/* Act Cd */
  String	actCd = '';		/* Act Cd */
  int	price = 0;          /* Price */
  int	point = 0;          /* Point */
  int   cnclFlg = 0;
  int   errNo = 0;		/* Error flg */
  int   actflg = 0;         /* Action flg */
  /// char    datetime[14+1];
  String    datetime = '';
  /// char    card_kind[2+1];
  String    cardKind = '';
  /// char    busi_cd[2+1];
  String    busiCd = '';
}

///  関連tprxソース: rc_elog.h struct EVOID
class EVoid{
  int     Dialog = 0;
  int     fEnter = 0;
  int     fEnterPosition = 0;
  int     fSign = 0;
  int     fExec = 0;
  int     nowDisplay = 0;
  //char      put[32];
  int      printNo = 0;
  int       opeModeFlg = 0;
  //char      date[10];
  int      macno = 0;
  int      recno = 0;
  int      amt = 0;
  int      dfltMacno = 0;
  int      dfltRecno = 0;
  int      dfltAmt = 0;
//  #if RALSE_CREDIT || SMARTPLUS
  int     scndspFlg = 0;
  int      gcatAmt = 0;
  String      smtplusMedia = '';
//  #endif
//  #if MM_DD_YY || DD_MM_YY
//   char      date_buf[10];
//   #endif
  String      gcatBusiKnd = '';
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *date_btn;
  // GtkWidget *date_ent;
  // GtkWidget *macno_btn;
  // GtkWidget *macno_ent;
  // GtkWidget *recno_btn;
  // GtkWidget *recno_ent;
  // GtkWidget *amt_btn;
  // GtkWidget *amt_ent;
  // GtkWidget *sign_btn;
  // GtkWidget *ent_btn;
  // GtkWidget *exec_btn;
  // GtkWidget *end_btn;
  int      itemMacno = 0;
  int      itemRecno = 0;
  int     speezadbOpnFlg = 0;
  int      payCondition = 0;
  int      slipno = 0;
  int      kidEmoneyKind = 0;
  // GtkWidget *message_ent;
  Icpntvoid nimoca = Icpntvoid();
  // char serial_no[sizeof(((c_header_log *)NULL)->serial_no)];
  TLogParam tlogParam = TLogParam();
  int server = 0;
  int     fncCd = 0;
}

///  関連tprxソース: rc_elog.h struct PRECAVOID
class PrecaVoid{
  int     Dialog = 0;
  int     err_No = 0;
  int     fEnter = 0;
  int     fEnterPosition = 0;
  int     fSign = 0;
  int     nowDisplay = 0;
  // char      put[32];
  int      printNo = 0;
  int       opeModeFlg = 0;
  // char      date[10];
  int      macno = 0;
  int      recno = 0;
  int      amt = 0;
  int      slipno = 0;
  //char      precano[16];
  bool?      regsprnflg;
  int       digit = 0;
  int     subdispPage = 0;
  int     approveFlg = 0;
  //char      chk_date[10];
  int     tranType = 0;
  int       cdDigit = 0;
  bool?      mcdFlg;
  int     scndspFlg = 0;
  int     carddspFlg = 0;
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *date_btn;
  // GtkWidget *date_ent;
  // GtkWidget *macno_btn;
  // GtkWidget *macno_ent;
  // GtkWidget *recno_btn;
  // GtkWidget *recno_ent;
  // GtkWidget *amt_btn;
  // GtkWidget *amt_ent;
  // GtkWidget *sign_btn;
  // GtkWidget *slipno_btn;
  // GtkWidget *slipno_ent;
  // GtkWidget *precano_btn;
  // GtkWidget *precano_ent;
  // GtkWidget *ent_btn;
  // GtkWidget *exec_btn;
  // GtkWidget *end_btn;
  // GtkWidget *awin;
  // GtkWidget *awin_fix;
  // GtkWidget *app_entry;
  // GtkWidget *comment;
  // GtkWidget *comfixed;
  // GtkWidget *aent_btn;
  // GtkWidget *aend_btn;
  // GtkWidget *message_ent;
  // char serial_no[sizeof(((c_header_log *)NULL)->serial_no)];
  TLogParam tlogParam = TLogParam();
  int server = 0;
  Icpntvoid nimoca = Icpntvoid();
}

///  関連tprxソース: rc_elog.h struct CRDTVOID
class CrdtVoid{
  int dialog = 0;
  int errNo = 0;
  int fEnter = 0;
  int fEnterPosition = 0;
  int fSign = 0;
  int nowDisplay = 0;
  // char      put[32];
  String put = '';
  int printNo = 0;
  int opeModeFlg = 0;
  // char      date[10];
  String date = '';
  int macNo = 0;
  int recNo = 0;
  int amt = 0;
  int slipNo = 0;
  int cardNo = 0;
  // char      crdtno[16];
  String crdtNo = '';
  bool regsprnFlg = false;
  int digit = 0;
  int subdispPage = 0;
  int approveFlg = 0;
  // char      chk_date[10];
  String chkDate = '';
  int tranType = 0;
  // GtkWidget *window;
  // GtkWidget *win_fix;
  // GtkWidget *title;
  // GtkWidget *date_btn;
  // GtkWidget *date_ent;
  // GtkWidget *macno_btn;
  // GtkWidget *macno_ent;
  // GtkWidget *recno_btn;
  // GtkWidget *recno_ent;
  // GtkWidget *amt_btn;
  // GtkWidget *amt_ent;
  // GtkWidget *sign_btn;
  // GtkWidget *slipno_btn;
  // GtkWidget *slipno_ent;
  // GtkWidget *crdtno_btn;
  // GtkWidget *crdtno_ent;
  // GtkWidget *ent_btn;
  // GtkWidget *exec_btn;
  // GtkWidget *end_btn;
  // GtkWidget *awin;
  // GtkWidget *awin_fix;
  // GtkWidget *app_entry;
  // GtkWidget *comment;
  // GtkWidget *comfixed;
  // GtkWidget *aent_btn;
  // GtkWidget *aend_btn;
  // GtkWidget *message_ent;
  // #if ARCS_MBR
  int scndspFlg = 0;
  // #endif
  Icpntvoid nimoca = Icpntvoid();
  // char serial_no[sizeof(((c_header_log *)NULL)->serial_no)];
  String serialNo = '';
  TLogParam tlogParam = TLogParam();
  int server = 0;
}

///  関連tprxソース: rc_elog.h - cashvoid_dsp
enum CashvoidDsp{
  CASHVOID_NON_DSP(0),
  CASHVOID_RECSERCH_DSP(1),
  CASHVOID_CASH_DSP(2),
  CASHVOID_CASHSEL_DSP(3),
  CASHVOID_CASHIN_DSP(4),
  CASHVOID_MAX_DSP(5);

  final int cd;
  const CashvoidDsp(this.cd);
}
///  関連tprxソース: rc_elog.h - CASHKIND
enum CashKind {
  ESV_CASH(0),
  ESV_CHK1(1),
  ESV_CHK2(2),
  ESV_CHK3(3),
  ESV_CHK4(4),
  ESV_CHK5(5),
  ESV_CHA1(6),
  ESV_CHA2(7),
  ESV_CHA3(8),
  ESV_CHA4(9),
  ESV_CHA5(10),
  ESV_CHA6(11),
  ESV_CHA7(12),
  ESV_CHA8(13),
  ESV_CHA9(14),
  ESV_CHA10(15),
  ESV_CHA11(16),
  ESV_CHA12(17),
  ESV_CHA13(18),
  ESV_CHA14(19),
  ESV_CHA15(20),
  ESV_CHA16(21),
  ESV_CHA17(22),
  ESV_CHA18(23),
  ESV_CHA19(24),
  ESV_CHA20(25),
  ESV_CHA21(26),
  ESV_CHA22(27),
  ESV_CHA23(28),
  ESV_CHA24(29),
  ESV_CHA25(30),
  ESV_CHA26(31),
  ESV_CHA27(32),
  ESV_CHA28(33),
  ESV_CHA29(34),
  ESV_CHA30(35),
  ESV_CASHMAX(36);

  final int cd;
  const CashKind(this.cd);
}
