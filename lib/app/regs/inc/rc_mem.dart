/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:core';
import 'dart:typed_data';

import '../../../postgres_library/src/customer_table_access.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../postgres_library/src/royalty_promotion_table_access.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_bdl.dart';
import '../../inc/apl/rx_cnt_list.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/t_item_log.dart';
import '../../inc/lib/if_acx.dart';
import '../../inc/lib/if_pana.dart';
import '../../inc/lib/jan_inf.dart';
import 'rc_crdt.dart';

///  関連tprxソース: dev_in.h
class DevIn{
/*----------------------------------------------------------------------*
 *  dev
 *----------------------------------------------------------------------*/
  static const int D_KEY   =  0x01;  /* device: mecanical key */
  static const int D_TCH   =  0x02;  /* device: 10.4inch touch key */
  static const int D_SML   =  0x03;  /* device: 5.7inch touch key */
  static const int D_OBR   =  0x04;  /* device: OBR */
  static const int D_LCDB  =  0x05;  /* device: LCD bright */
  static const int D_MCD1  =  0x06;  /* device: magnetic card JIS1 */
  static const int D_MCD2  =  0x07;  /* device: magnetic card JIS2 */
  static const int D_SUB   =  0x08;  /* device: SUB-CPU */
  static const int D_SWT   =  0x10;  /* device: Clerk Call Switch */
  static const int D_DCT   =  0x11;  /* device: Sencer */
  static const int D_ICCD1 =  0x12;  /* device: IC Card1 */
  static const int D_PSEN  =  0x13;  /* device: Proximity Sensor */
  static const int D_APBF  =  0x14;  /* device: Auto Prastic Bag Feader */
  static const int D_EXC   =  0x15;  /* device: Age Check */

/*----------------------------------------------------------------------*
 *  Ocode : Original code
 *----------------------------------------------------------------------*/
  /// comming data count in a time
  static const int O_CNT = 4;
  /// comming data count in a time
  static const int MCD_CNT = 72;
  /// comming data count in a time
  static const int GS1_CNT = 56;
  /// comming data count in a time
  static const int ICCD_CNT = 44;

/*----------------------------------------------------------------------*
 *  no : Key Map function
 *----------------------------------------------------------------------*/

  /// dev:D_KEY form key1
  static const int KEY1 = 0x01;
  /// dev:D_KEY form key2
  static const int KEY2 = 0x02;
  /// dev:D_KEY form key6
  static const int KEY6 = 0x06;

}

class RefData {
  CPluMst plu = CPluMst(); //  Plu File
  // CClsMst         lrg;            //  Large Class File
  // CClsMst         mdl;            //  Middle Class File
  // CClsMst         sml;            //  Small Class File
  // CClsMst         tny;            //  Tiny Class File
  // PPromschMst     lrgsch;            //  Large Class File
  // PPromschMst     mdlsch;            //  Middle Class File
  // PPromschMst     smlsch;            //  Small Class File
  // PPromschMst     tnysch;            //  Tiny Class File
  // PPromschMst     brgnsch;        //  Bargen Schedule File
  // PBrgnitemMst    brgnitm;        //  Bargen Item File (rxtblBuff.h)
  // PPromschMst     clssch;            //  Class Disc Schedule File
  // PPromschMst     mclssch;           //  Member Class Disc Schedule File
//  CBrgnschMst     brgnsch;        //  Bargen Schedule File
//  CBrgnitemMst    brgnitm;        //  Bargen Item File
//   #if 0
//   CBdlschMst      bdlsch;         //  Bundle Schedule File
//   CBdlitemMst     bdlitm;         //  Bundle Item File
//   CStmsch2Mst     stmsch;         //  Set Match Schedule File
//   CStmitem2Mst    stmitm;         //  Set Match Item File
//   #endif
//   PPromschMst     bdlsch;         //  Bundle Schedule File
//   PPromitemMst    bdlitm;         //  Bundle Item File
//   PPromschMst     stmsch[RCSCHSTMALLSCH+1]; //  Bundle Schedule File
//   PPromitemMst    stmitm[RCSCHSTMALLSCH+1];//  Bundle Item File
//   CCaseitemMst    caseitm;        //  Case Plu File
  CTaxMst tax = CTaxMst(); //  Tax File
//   CStaffMst       staff;          //  Staff File
//   CFspplanPluTbl fspPlu;        //  FSP PLU File
   CCrdtDemandTbl crdtTbl = CCrdtDemandTbl();     //  Credit Demand Table Fil
// //  CPluitemMst   pluitm;         //  Plu Point Item File
//   PPromschMst     plusch;         //  Plu Point Schedule File
//   SCHPLANCD         schplancd;      //
//   RXMEMCLSDSC  rcClsdsc;           //  Class Dsc
//   CProducerMst	prod;   // 　生産者
//   PPromschMst     mbrbdlsch;      //  Member Bundle Schedule File
//   PPromitemMst    mbrbdlitm;      //  Member Bundle Item File
//   PPromschMst     plumulsch;         //  商品倍率ポイントスケジュールデータ
//   cSub1ClsMst	sub1lrg;	//  サブ1分類 大分類
//   cSub1ClsMst	sub1mdl;	//  サブ1分類 中分類
//   cSub1ClsMst	sub1sml;	//  サブ1分類 小分類
//   cSub2ClsMst	sub2lrg;	//  サブ2分類 大分類
//   cSub2ClsMst	sub2mdl;	//  サブ2分類 中分類
//   cSub2ClsMst	sub2sml;	//  サブ2分類 小分類
// //	ALLSTMINF	allStmCd[RCSCHSTMALLSCH+1];   //  SetMatch Code
//   PPromschMst     dpntPlusch;     //  dポイント用商品ポイント加算スケジュール商品マスタ
//   SCHPLANCD         dpntSchplancd;  //  dポイント用商品ポイント加算スケジュールコード
//   CLiqritemMst	liqritem;	//  酒品目
//   CLiqrtaxMst		liqrtax;	//  酒税
}

enum PluReadType {
  pluReadNormal, // 通常
  pluReadNoChkDelete, // 取得時, status != 2 のいうSQL条件を含めない
}

/// 関連tprxソース: rc_mem.h - STAT
class Stat {
  int clkStatus = 0;                /* Clerk Status        */
  int scrMode = 0;                  /* LCD Screen Mode     */
  int opeMode = 0;                  /* Operation Mode      */
  int orgCode = 0;                  /* Input Original Code */
  int fncCode = 0;                  /* Input Function Code */
  int orgFncCode = 0;               /* Original Function Code */
  int wfIList = 0;                 /* Subtotal LCD Item List */
  /* 00000001:UpKey   Active */
  /* 00000010:DownKey Active */
  int acrMode = 0;                  /* 0x00: Normal Mode     */
  /* 0x01: Answer Get Mode */
  /* 0x10: Pop Window Mode */
  int subScrMode = 0;               /* 5.7LCD Screen Mode    */
  int eventMode = 0;                /* Event Mode            */
  int dspEventMode = 0;             /* Display Event Mode    */
  int fSpool = 0;                   /* flag for spooler ctrl */
  int prnStatus = 0;                /* Printer Status        */
  int rjpMode = 0;                 /* Pirnt Off-On Status   */
  int updDsp = 0;                  /* UpData Display Status */
  int tFlag = 0;                   /* Handling Timer Flag   */
  int disableFlag = 0;              /* Subttl/Suspend/Resume input Flag */
  int scrType = 0;                  /* 1:10.4LCD / 2:5.7LCD  */
  int bkScrMode = 0;                /* Orignal Screen Mode   */
  int bkSubScrMode = 0;             /* Orignal SubScreen Mode   */
  int dscStat = 0;                 /* 0:No Disc / 1:Disc    */
  int stprRjpMode = 0;			/* Station Pirnt Off-On Status   */
  int s2prRjpSts = 0;				/* 2 Station Pirnt Status   */
  int s2prDspSts = 0;				/* 2 Station Pirnt DSP Status   */
  int clsCnclMode = 0;            /* Class Discount Cancel Mode */
  int dualTSingle = 0;             /* Dual Tower Single Mode , 0:tower side 1:desktop side */
  int cashintFlag = 0;             /* Cashier Interrupt Flag */
  int dishMode = 0;                /* Dish calc/clr Mode */
  int opelvlFlg = 0;
  int tagrdwtMode = 0;              /* Tag read/write Mode */
  int disburseFlg = 0;              /* */
  int departFlg = 0;               /* 0x01:自社クレジット宣言中    */
  /* 0x02:種別1買物カード入力     */
  /* 0x04:種別2買物カード入力     */
  /* 0x08:OMC優待許可フラグ       */
  /* 0x10:売掛入金入力フラグ      */
  /* 0x20:請求テーブルノンファイル*/
  /* 0x40:種別3買物カード入力     */
  /* 0x80:種別4買物カード入力     */
  int acboffItminfFlg = 0;        /* */
  int spDepartFlg = 0;            /* 0x01:カード取引中            */
  /* 0x02:カード入金中            */
  /* 0x04:カード読込中            */
  /* 0x08:入金値引中              */
  /* 0x10:一括登録中              */
  /* 0x20:友の会利用中            */
  int changerFlg = 0;              /* 特定商品釣銭機無効フラグ 0:有効 1:無効(コープさっぽろ仕様) */
  int masrErrFlg = 0;		    /* 自走式磁気リーダエラー表示　0：未表示　１：表示済　*/
  int bkclsCnclMode = 0;          /* Class Discount Cancel Mode */
  int tCardType = 0;              /* Tpoint Card 0:16桁 1:9桁     */
  int msgDspStatus = 0;             /* 登録開始時１回メッセージを表示する */
  int pluFlrdFlg = 0;             /* 商品リアル 及び 売価未確定時の画面表示用 */
  int pluPrcexeFlg = 0;           /* 売価未確定時のPLUマスタ更新用 */
  int pluFlrdTyp = 0;             /* 商品リアル問合せの結果タイプ */
  int pluOfflineFlg = 0;          /* 商品リアル問合せ時、ZHQとオフライン状態 */
  int clsCnclModeSgl = 0;         /* 単品分類解除フラグ */
  late var clsCnclFlg = List.filled(3, 0);            /* 分類解除による分類解除中フラグ */
  late var clsCnclSglFlg = List.filled(3, 0);         /* 単品分類解除による分類解除中フラグ */
  int happySmileScrmode = 0;      /* 15インチ対面セルフでQCashierの画面を利用する場合の、QCashierスクリーンモード保存先 */
  int happySmileBackscr = 0;
  int selectdspCcinBackscr = 0;   /* QCの支払い選択画面で釣機入金動作する場合の、直前画面 */
  int stepWait = 0;  		    /* 自動開閉店次ステップ処理待ちフラグ */
  int tomoifLibCheck = 0;	    /* 友の会ライブラリチェック用(登録開始時、各取引開始時) */
  bool crdtDealFlg = false;	    /* クレジット処理中フラグ　１：処理中　*/	
}

/// 関連tprxソース: rc_mem.h - ENTRY
class Entry {
  int errStat = 0;                 /* Error Status     */
  int errNo = 0;                   /* Error No.        */
  int tencnt = 0;                 /* Entry Count      */
  Uint8List entry = Uint8List(10);  /* Entry Data (BCD) */
  int warnNo = 0;                  /* Warning No.(Manual) */
  int bzwarnNo = 0;                /* BzWarning No.    */
  String docMemStat = '';             /* Doc/Mem Check Status */
  int deccnt = 0;                   /* Decimal Count    */
  String crdtErrCd = '';           /* Credit Error Code */
  String crdtCompCd = '';          /* Credit Comp Code  */
  int stlFlg = 0;
  String addMsgBuf = '';            // エラーダイアログへの追加メッセージ保存バッファ (msg_bufへセットするもの)
}

/// 関連tprxソース: rc_mem.h - DATA_REG
class DataReg {
  int kPm1_0 = 0;                  /* Rate of %-                    */
  int kDsc0 = 0;                  /* Amount of Discount            */
  int kBra0 = 0;                  /* Amount of Bottle Return       */
  int kBra1 = 0;                  /* Count of Bottle Return        */
  String kBra2 = '';                  /* Count of Bottle Return Repeat */
  int kMul0 = 0;                  /* Number of Multiple            */
  int kMul1 = 0;                  /* Number of Multiple(ichiyama)  */
  int kMul0Bak = 0;              /* 乗算キーバックアップ：品券キーの乗算用（いちやま）*/
  int kPri0 = 0;                  /* Price of Entry                */
  String kSen0 = '';                  /* Count of "KY_SEN"             */
  String k5sen0 = '';                 /* Count of "KY_5SEN"            */
  int kMan0 = 0;                  /* Count of "KY_MAN"             */
  List<int> kEnt0 = List<int>.filled(10, 0);              /* Data of Entry "BCD"           */
  int kEnt1 = 0;                  /* Count of Digit in "Entry"     */
  int kWgh0 = 0;                  /* Barcode of Weight             */
  String telNo = '';                /* Member Telephone No "BCD"     */
  int kUprc0 = 0;                 /* KY_UPRC of Entry              */
  int kTare0 = 0;                 /* KY_WTTARE of Entry (TARE)     */
  int kWgh1 = 0;                  /* KY_WTTARE of Entry (WEIGHT)   */
  int kDec0 = 0;                  /* Decimal Point Data            */
  int kPlus0 = 0;                 /* Amount of Plus                */
  int kPlus1_0 = 0;                /* Rate of %+                    */
  int kProd0 = 0;                 /* Barcode of Producer           */
  String edyCd = '';               /* Edy code for Comp code        */
  String k5hyaku0 = '';               /* Count of "KY_5HYAKU"          */
  int gxWeight = 0;                /* GramX Weight                  */
  int gxFlg = 0;                   /* GramX Data Flag               */
  int pdscType = 0;                /* type of %-                    */
  int kSla_0 = 0;                  /* Amount of Slash data          */
  int kPm2_0 = 0;                  /* Rate of %-                    */
  int kDsc2_0 = 0;                 /* Amount of Discount            */
  String cpnBarCd = '';           /* Coupon barcode                */
  String tpointMbrInput = '';         /* 0:MCD 1:Entry Key             */
  int avprcAdptFlg = 0;           /* 平均単価使用                  */
  int avprcUtilFlg = 0;           /* 平均単価利用設定種別          */
}

/// 関連tprxソース: rc_mem.h - CRDT_REG
class CrdtReg {
  int stat = 0;         /* 0x0001:鍵配信要求            */
  /*        (NTT Encrypt Key)     */
  /* 0x0002:クレジット与信取消    */
  /*        (M&C VOID電文要求)    */
  /* 0x0004:NTTカウンタ判定不一致 */
  /* 0x0008:NTT復号化処理エラー   */
  /* 0x0010:承認番号入力指示      */
  /* 0x0020:手動時：同会計キー待ち*/
  /* 0x0040:M&C照会エラー表示中   */
  /* 0x0080:クレジット解約:本日分 */
  /* 0x0100:クレジット解約:承認後 */
  /* 0x0200:カード問い合わせエラー*/
  /* 0x0400:マニュアル入力        */
  /* 0x0800:                      */
  /* 0x1000:通信PCオフライン      */
  /* 0x2000:CAFISオフライン       */
  /* 0x4000:タイムアウトエラー    */
  /* 0x8000:M&Cクレジット照会エラー*/
  String kind = '';                     /* regs/inc/rcregs.h <enum>     */
  String cardDiv = '';      /* '1':国際JIS1                 */
  /* '2':国際JIS2(JIS1あり)       */
  /* '3':手入力                   */
  /* '4':国内JIS1                 */
  /* '5':JIS1優先(JIS2あり)       */
  int cardKind = 0;                /* Card Kind 5D                 */
  int companyCd = 0;               /* Company Code 5D              */
  String cdno = '';                 /* Card No. 16D ASCII           */
  String date = '';                  /* Ins Limit Date<MMYYorYYMM    */
  Uint8List rpno = Uint8List(10);    /* Receipt No. 5D               */
  Uint8List reno = Uint8List(3);     /* Recognition No. 6D           */
  CrdtMAanal? jis1; /* Magnetic JIS1 Data           */
  CrdtMAanal? jis2; /* Magnetic JIS2 Data           */
  int step = 0;                     /* Manual Disp Step             */
  int crdtKey = 0;                  /* Credit Final Function Key#   */
  RxSocket crdtReq = RxSocket();        /* Credit Request Socket Datas  */
  RxSocket crdtRcv = RxSocket();        /* Credit Receive Socket Datas  */
  NttAspRxData nttRcv = NttAspRxData();        /* NttAsp Credit Receive Datas  */
  CCrdtDemandTbl crdtTbl = CCrdtDemandTbl();        /* Credit Table File Input Data */
  String pay = '';                      /* Credit Pay                   */
  int diviCnt = 0;                 /* Pay Divide Count             */
  int diviPri = 0;                 /* Pay Divide Price             */
  int bonsPri = 0;                 /* Pay Bonus Price              */
  int bonsMth = 0;                 /* Pay Bonus Type               */
  int bonsMm1 = 0;                 /* Pay Bonus Month(1st)         */
  int bonsMm2 = 0;                 /* Pay Bonus Month(2nd)         */
  String payDtYY = '';              /* Pay Start Date YY/           */
  String payDate = '';              /* Pay Start Date    MM/DD      */
  String personNo = '';              /* Person No. 6D                */
  String reqCode = '';              /* NttAsp:要求コード            */
  String handleDiv = '';            /* NttAsp:取引区分              */
  String encryptK1di = '';          /* NttAsp:第1鍵(K1di)           */
  String encryptK2di = '';          /* NttAsp:第2鍵(K2di)           */
  String encryptIv = '';            /* NttAsp:イニシャルベクタ(Iv)  */
  EncryptSend encryptSend = EncryptSend();        /* NttAsp:暗号化への構造体      */
  EncryptRecv encryptRecv = EncryptRecv();        /* NttAsp:復号化への構造体      */
  String rstreJoinNo = '';        /* 他社応答：提携先コード       */
  int rcardCompCd = 0;            /* 他社応答：カード会社コード   */
  String rcompanyNm = '';        /* 他社応答：カード会社名       */
  String rerrCd = '';               /* 信用照会：SC+処理区分+エラーコード */
  String rerrMsg = '';           /* 他社応答：エラーメッセージ   */
  String rinqResCd = '';           /* 他社応答：照会結果コード     */
  String rblackCheck = '';             /* 他社応答：ブラック照会区分   */
  int rbackPosi = 0;               /* 他社応答：戻り先パターン     */
  int rrecieptNo = 0;              /* 他社応答：伝票番号           */
  int rcrdtNo = 0;                 /* 他社応答：処理通番           */
  int rtotal = 0;                   /* 自社応答：合計               */
  int rlevy = 0;                    /* 自社応答：手数料             */
  int rchgAmt = 0;                 /* 自社応答：改め額             */
  int rdeposit = 0;                 /* 自社応答：頭金               */
  int rdepoCin = 0;                /* 自社応答：頭金入金済額       */
  int rdiviCin = 0;                /* 自社応答：分割払入金済額     */
  int rdivTtl = 0;                 /* 自社応答：分割払金合計       */
  int rtranCd = 0;                 /* 自社応答：ファイル検索サイン */
  int rpayCnt1 = 0;                /* 自社応答：分割&ボーナス回数1 */
  int rpayAmt1 = 0;                /* 自社応答：分割&ボーナス金額1 */
  int rpayCnt2 = 0;                /* 自社応答：分割&ボーナス回数2 */
  int rpayAmt2 = 0;                /* 自社応答：分割&ボーナス金額2 */
  String rsaleDiv = '';                /* 自社応答：売上区分           */
  int payDiv = 0;                  /* CardCrew：支払区分           */
  int jis1flg = 0;                  /* CardCrew：JIS1 DATA SET     */
  int jis2flg = 0;                  /* CardCrew：JIS2 DATA SET     */
  int crdtdscFlg = 0;              /* クレジット小計割引案分フラグ */
  int kasumiInpflg = 0;            /* カスミ様手入力許可フラグ     */
  int kasumiOffcrdt = 0;           /* カスミ様オフクレフラグ       */
  int crdtdscCancel = 0;           /* クレジット小計割引取消フラグ */
  String multiFlg = '';                /* 0x01:サインレスフラグ        */
  /* 0x02:自社クレジット取引完了  */
  /* 0x04:スキップ払い利用        */
  /* 0x08:個別割賦払い利用        */
  /* 0x10:売掛入金取引            */
  /* 0x20:承認番号取得済み取引    */
  /* 0x40:中合クレ：オフ訂正      */
  /* 0x80:SPVT オーソリー要求     */
  int buseBcnt = 0;                /* ボーナス併用時ボーナス回数   */
  int cardReqCd = 0;              /* CardCrew：カード会社コード   */
  String cardcrewErr = '';          /* CardCrew：エラーコード       */
  int kasumiAeon = 0;              /* カスミAEONクレジットカード   */
  int b1Setflg = 0;                /* 中合クレ：第一ボーナスセット */
  int b2Setflg = 0;                /* 中合クレ：第二ボーナスセット */
  int bSeason = 0;                 /* 中合クレ：第一ボーナス支払期 */
  int icCardType = 0;             /* 非接触ICカードタイプ    */
  int spvtAuthori = 0;             /* VISATouchオーソリー要求 */
  String id = '';                       /* NttAsp:IDコード              */
  String business = '';                 /* NttAsp:業態コード            */
  int chkGoodThru = 0;            /* 有効期限チェックフラグ       */
  Uint8List voidDate = Uint8List(4);             /* VEGA接続 元取引日 8D */
}

class Working {
  DataReg dataReg = DataReg();               /* Registration Datas        */
  TItemLog pluReg = TItemLog();   /* PLU Datas                 */
  RefData refData = RefData();    /* Refer Item Informations   */
  CPluMst notfReg = CPluMst();            /* Urgent Setting Data       */
  JANInf janInf = JANInf();             /* JAN information table     */
  CrdtReg crdtReg = CrdtReg();            /* Credit Datas              */
  Code128Inf code128Inf = Code128Inf();         /* Code128 information table */
  int eqPluIRecNo = 0;         /* same plu item rec no      */
  int surtax = 0;              /* surtax amount */

  /// Set PLU_REG Data for TPR
  /// workingにデータをセットする.
  ///関連tprxソース: rcpluset.c rcSet_PLU_REG
  bool rcSetPluReg() {
    // MEMO:本来はカ一般売価をセットする.
    pluReg.t10003.uusePrc = refData.plu.pos_prc;

    //MEMO:ひとまずプロトタイプ向けで使用するものだけ取得.
    //rcSet_Name
    pluReg.t10000.posName = refData.plu.pos_name ?? "";
    //rcSet_item_qty
    pluReg.t10000.itemTtlQty = 1;
    //rcSet_tax_cd
    pluReg.t10000.taxCd = refData.tax.tax_cd ?? 0;
    // rcSet_tax_typ
    pluReg.t10000.taxTyp = refData.tax.tax_typ;
    // rcSet_tax_typ
    pluReg.t10000.taxPer = refData.tax.tax_per ?? 0;
    // rcSet_tax_odd_flg
    pluReg.t10000.oddFlg = refData.tax.odd_flg;
    // rcSet_ItemType.
    pluReg.t10003.itemTyp = refData.plu.item_typ;

    //rcSet_nomi_prc
    pluReg.calcData.nomiPrc = pluReg.t10003.uusePrc * pluReg.t10000.itemTtlQty;
    return true;
  }
}

/// 関連tprxソース: rc_mem.h - REPEAT
class Repeat {
  String  repStat = '';  /* Repeat Status  */
  int  repCnt = 0;  /* Count of Repeat  */
  int  smlclsCd = 0;  /* Used Small Class Code Data  */
  String  smlclsPset = '';  /* Small Class Preset In  */
  String  prcchgStat = '';  /* Price Change Status  */
  String  pluCd11 = '';  /* Used Barcode Data 1st.  */
  String  pluCd12 = '';  /* Used Barcode Data 1st.  */
  String  pluCd21 = '';  /* Used Barcode Data 2nd.  */
  int  mdlclsCd = 0;  /* Used Middle Class Code Data  */
  String  mdlclsPset = '';  /* Middle Class Preset In  */
  int  lrgclsCd = 0;  /* Used Large Class Code Data  */
  String  lrgclsPset = '';  /* Large Class Preset In  */
  int  repTtlprc = 0;  /* Repeat total price  */
  int  repTtldsc = 0;  /* Repeat total dsc  */
}

/// 関連tprxソース: rc_mem.h - SCAN_MM
class ScanMm {
  int   price1 = 0;                 /* Scan Check M/M Price1     */
  int  piece1 = 0;                 /* Scan Check M/M Piece1     */
  int   price2 = 0;                 /* Scan Check M/M Price2     */
  int  piece2 = 0;                 /* Scan Check M/M Piece2     */
  int   price3 = 0;                 /* Scan Check M/M Price3     */
  int  piece3 = 0;                 /* Scan Check M/M Piece3     */
  int   price4 = 0;                 /* Scan Check M/M Price4     */
  int  piece4 = 0;                 /* Scan Check M/M Piece4     */
  int   price5 = 0;                 /* Scan Check M/M Price5     */
  int  piece5 = 0;                 /* Scan Check M/M Piece5     */
  int   priceAv = 0;               /* Scan Check M/M 平均単価      */
  int   priceCustAv = 0;          /* Scan Check M/M 会員平均単価  */
  int   priceLowLimit = 0;        /* Scan Check M/M 成立下限額    */
  int   price6 = 0;                 /* Scan Check M/M Price6     */
  int   price7 = 0;                 /* Scan Check M/M Price7     */
  int   price8 = 0;                 /* Scan Check M/M Price8     */
  int   price9 = 0;                 /* Scan Check M/M Price9     */
  int   price10 = 0;                /* Scan Check M/M Price10    */
  int  bdlTyp = 0;                   /* Scan Check M/M Type       */
}

/// 関連tprxソース: rc_mem.h - DSP_DATAS
class DspDatas {
  List<int> entry =  List.generate(10, (_) => 0); /* Entry Data                */
  int   itemqty = 0;                   /* Item Qty. Data            */
  String   ecrno = '';                     /* Ecr No. Data              */
  String   nameLcd = '';              /* Name or Mg Name Data      */
  String   nameFip = '';              /* Name or Entry Data        */
  int   price = 0;                     /* Sale Price Data           */
  int   uprice = 0;                    /* Unit Price Data           */
  int   nomiPrc = 0;                  /* Sale Price Data           */
  int  repeatCnt = 0;                /* Repeat Counter Data       */
  String   msgLcd = '';               /* Message Name Data         */
  String   cinkey = '';                 /* In/Out Key Entry Data     */
  int   mulkey = 0;                    /* Mul Key Entry Data        */
  int   prikey = 0;                    /* Pri-Change Key Entry Data */
  int   dscAmt = 0;                   /* Discount Amount Data      */
  String   drwkey = '';                 /* Drower Key Entry Data     */
  int  pdsckey = 0;                   /* %Discount Key Entry Data  */
  int   minusData = 0;                /* Dsc & Bot.return Key Data */
  String   dtHh = '';                     /* Date of Hour              */
  String   dtMi = '';                     /* Date of Minute            */
  String   mbrcdfip = '';              /* Member Code Data          */
  String   fipL1 = '';       /* FIP First Line Display Area  */
  String   fipL2 = '';       /* FIP Second Line Display Area */
  String   fipL3 = '';       /* FIP Third Line Display Area  */
  String   subLcd = '';               /* 5.7LCD Display Area       */
  String   subibuf = '';               /* 5.7LCD Disp Area for Item */
  int   matchDsc = 0;                 /* Bundle/SetMatch Dsp Data  */
  String   dscDspFlg = '';               /* 5.7 Dsc/Mul Display Flag  */
  String   prcDspFlg = '';               /* 5.7 Price Display Flag    */
  int   uprckey = 0;                    /* Unit Price Change Key Entry Data */
  int  pluske = 0;                   /* %Plus Key Entry Data      */
  int    ScnPrcNowDisp = 0;           /* ScanPriceMode Now Display */
  String   msgFip = '';               /* Message Name Data for Fip */
  String   fipP1 = '';       /* FIP 1Line Display Push/Pop Area */
  String   fipP2 = '';       /* FIP 2Line Display Push/Pop Area */
  String   fipP3 = '';       /* FIP 3Line Display Push/Pop Area */
  int   surtax = 0;                    /* Scan Surtax Price  */
  int  surqty = 0;                    /* Scan Surtax Quity  */
  ScanMm?  mm;                       /* Scan Check M/M */
  ScanMm?  mbrmm;                    /* Scan Check member M/M */
  int  guidanceNo = 0;               /* ガイダンス表示への指定文言セット */
}

/// 関連tprxソース: rc_mem.h - POST_REG
class PostReg {
  int sub_ttl =0;                  /* Subtotal for post tendering  */
  int tend =0;                     /* Tend data for post tendering */
  int change =0;                   /* Change for post tendering    */
  int sum_ttl =0;                 /* Subtotal for Calculation     */
}

/// 関連tprxソース: rc_mem.h - CUSTDATA
class CustData {
  CCustMstColumns cust = CCustMstColumns();
  PPromschMstColumns svsCls = PPromschMstColumns();
  SCustTtlTblColumns? enq;
  SCustTtlTblColumns enqParent = SCustTtlTblColumns();
  String? dividFlg;
}

/// 関連tprxソース: rc_mem.h - ACB_DATA
class AcbData {                    /* ACB Decision Data */
  int       totalPrice = 0;
  int       ccinPrice = 0;
  int       splitPrice = 0;
  EnumData   enumdata = EnumData();
  int       acbFullPrice = 0;        /* FullStop Price Data             */
  String       acbFullStat = '';         /* FullStop Status -> COIN or BILL */
  int      acbFullNodisp = 0;       /* フル状態が解除されるまで、表示し続けないよう制御用(フルエラー発生させたくない場合にフラグON) */
  int       acbDeviceStat = 0;       /* ACB Device Status               */
  int       acbDrwFlg = 0;           /* ACB Drawer Open Flag            */
  String       keyChgcinFlg = '';        /* ChgCin Key Flag                 */
  int       inputPrice = 0;           /* input Price                     */
  int       ccinAddPrice = 0;        /* ccin add Price                  */
  int      acbErrorDisp = 0;        /* ACB Error Recover Disp          */
  int      chgStockStateErr = 0;   /* 在高不確定フラグ                */
}

/// 関連tprxソース: rc_mem.h - FRESH_BAR
class FreshBar {
  int freshFlg = 0;                 /* fresh item flg         */
  String   pluCd = '';                /* plu code               */
  String   packDatetime = '';         /* pack date YYYY-MM-DD HH:MM:SS */
  String   sellDatetime = '';         /* sell date YYYY-MM-DD HH:MM:SS */
  String   useDatetim = '';          /* use date  YYYY-MM-DD HH:MM:SS */
  int sellDatechk = 0;              /* check sell date        */
  int   wgtData = 0;                  /* weight data            */
  int wgtItem = 0;                  /* weight item            */
  int   freshAmt = 0;                 /* perishables amount     */
  int dscFlg = 0;                   /* disc flag              */
  int   dscVal = 0;                   /* disc value             */
  String   orgId = '';                /* original ID            */
  int couponFlg = 0;                /* coupon flag            */
  int   couponVal = 0;                /* coupon value           */
}

/// 関連tprxソース: rc_mem.h - DSC_BAR
class DscBar {
  String   dscBarCd1 = '';   /* Disc BarCode 1st     */
  String   dscBarCd2 = '';   /* Disc BarCode 2nd     */
  String   dscPluCd = '';    /* Plu Code             */
  String   dscBarType = '';              /* Dsc/%Dsc/Prc Type    */
  int   dscBarData = 0;              /* Dsc/%Dsc/Prc Data    */
  String   dscBarFlg = '';               /* Disc BarCode Flag    */
  String   dscBar1Flg = '';              /* Disc BarCode 1stFlag */
  String   dscBar2Flg = '';              /* Disc BarCode 2ndFlag */
  String   sallmtday = '';              /* Sale Limit Day       */
  String   specialDscBarCd = '';    /* Disc BarCode All     */
  int  itemReductCoupon = 0;
}

/// 関連tprxソース: rc_mem.h - RCPT_BAR
class RcptBar {
  String   saleDate = '';             /* YYYY-MM-DD              */
  int   macNo = 0;                    /* machine number          */
  int   receiptNo = 0;                /* receipt number          */
  int   printNo = 0;                  /* print number            */
  int   rcptBarFlg = 0;              /* Receipt BarCode Flag    */
  int   rcptBar1Flg = 0;             /* Receipt BarCode 1stFlag */
  int   rcptBar2Flg = 0;             /* Receipt BarCode 2ndFlag */
}

/// 関連tprxソース: rc_mem.h - BOOK_BAR
class BookBar {
  String   bookBarCd1 = '';   /* Book BarCode 1st             */
  String   bookBarCd2 = '';   /* Book BarCode 2nd             */
  String   bookBarCd2_2 = ''; /* Book BarCode 2nd after Mask  */
  String   bookBarFlg = '';               /* Book BarCode Flag            */
  int   bookBarPrc = 0;               /* Book BarCode Price           */
  String   bookBar1Flg = '';              /* Disc BarCode 1stFlag         */
  String   bookBar2Flg = '';              /* Disc BarCode 2ndFlag         */
  int	 bookClsCode = 0;		     /* 書籍部門登録コード*/
}

/// 関連tprxソース: rc_mem.h - CLOTHES_BAR
class ClothesBar {
  String   clothesBarCd1 = '';   /* Clothes BarCode 1st               */
  String   clothesBarCd2 = '';   /* Clothes BarCode 2nd               */
  String   clothesBarCd2_2 = ''; /* Clothes BarCode 2nd after Mask    */
  String   clothesBarFlg = '';               /* Clothes BarCode Flag              */
  int   clothesBarSml = 0;               /* Clothes BarCode Small Class Code  */
  int   clothesBarPrc = 0;               /* Clothes BarCode Price             */
  int  clothesBar1Fno = 0;              /* Clothes BarCode 1st Format No     */
  int  clothesBar2Fno = 0;              /* Clothes BarCode 2st Format No     */
  String   clothesBar1Flg = '';              /* Clothes BarCode 1stFlag           */
  String   clothesBar2Flg = '';              /* Clothes BarCode 2ndFlag           */
  int   clothesBarTnyclass = 0;          /* 特定クラス衣料バーコード用 */
}

/// 関連tprxソース: rc_mem.h - MAGAZINE_BAR
class MagazineBar {
  String   mgznBarCd1_1 = '';   /* Magazine BarCode 1st             */
  String   mgznBarCd1_2 = '';   /* Magazine BarCode 1st             */
  String   mgznBarCd2 = '';     /* Magazine BarCode 2nd             */
  String   mgznBarFlg = '';                 /* Magazine BarCode Flag            */
  int   mgznBarPrc = 0;                 /* Magazine BarCode Price           */
  String   mgznBar1Flg = '';                /* Magazine BarCode 1stFlag         */
  String   mgznBar2Flg = '';                /* Magazine BarCode 2ndFlag         */
  int	 mgznClsCode = 0;		       /* 雑誌部門登録コード*/
}

/// 関連tprxソース: rc_mem.h - ITF_BAR
class ItfBar {
  String   itfBarCd1_1 = '';   /* ITF BarCode 1st             */
  String   itfBarCd1_2 = '';   /* ITF BarCode 1st             */
  String   itfBarCd2 = '';     /* ITF BarCode 2nd             */
  String   itfBarFlg = '';                 /* ITF BarCode Flag            */
  int   itfBarPrc = 0;                 /* ITF BarCode Price           */
  int   itfBarAmt = 0;                 /* ITF BarCode Weight          */
}

/// 関連tprxソース: rc_mem.h - SEG1_DATA
class Seg1Data {
  String   segL = '';        /* Web-Jr Segment Line Display Area */
  String   segbackL = '';    /* Web-Jr Segment Line Display BackUp Area */
  String   commaData = '';                /* Web-Jr Comma Data         */
  String   triangleData = '';             /* Web-Jr Triangle Data      */
  int eTendType = 0;                 /* Web-Jr Triangle Check     */
}

/// 関連tprxソース: rc_mem.h - SEG2_DATA
class Seg2Data {
  String   segL = '';        /* Web-Jr Segment Line Display Area */
  String   segbackL = '';    /* Web-Jr Segment Line Display BackUp Area */
  String   commaData = '';                /* Web-Jr Comma Data         */
  String   triangleData = '';             /* Web-Jr Triangle Data      */
  int eTendType = 0;                 /* Web-Jr Triangle Check     */
}

/// 関連tprxソース: rc_mem.h - ASST_MNT
class AsstMnt {
  String   datetime = '';                /* Assist Monitor Date      */
  String   chkCncl = '';                    /* Assist Monitor Chk Cncl  */
  int   number = 0;                      /* Assist Monitor Number    */
  int   flag = 0;                        /* Assist Monitor Flag      */
  String   suspend = '';                     /* Assist Monitor Suspend   */
}

/// 関連tprxソース: rc_mem.h - PRESET_BAR
class PresetBar {
  String   presetBarCd = '';   /* Preset BarCode 1st             */
  String   presetBarFlg = '';              /* Preset BarCode Flag            */
  int   presetBarSml = 0;              /* Preset BarCode Small Class Code*/
  int   presetBarClass = 0;            /* Preset BarCode Class Code      */
  int   presetBarFd = 0;               /* Preset BarCode fd Code         */
}

/// 関連tprxソース: rc_mem.h - PRICETAG_BAR
class PricetagBar {
  String   prctagBarCd1 = '';   /* prctag BarCode 1st             */
  String   prctagBarCd2 = '';   /* prctag BarCode 1st            */
  String   prctagBarCd2_2 = ''; /* prctag BarCode 1st            */
  String   prctagBarFlg = '';               /* prctag BarCode Flag            */
  int   prctagBarPrc = 0;               /* prctag BarCode Price           */
  String   prctagBar1Flg = '';              /* prctag BarCode 1stFlag         */
  String   prctagBar2Flg = '';              /* prctag BarCode 2ndFlag         */
  int  prctagBar1Fno = 0;              /* prctag BarCode 1st Format No   */
  int  prctagBar2Fno = 0;              /* prctag BarCode 2st Format No   */
  int   prctagBarSml = 0;               /* prctag BarCode Small Class Code*/
  int   prctagBarClass = 0;             /* prctag BarCode Class Code      */
  int   prctagBarFd = 0;                /* prctag BarCode fd Code         */
}

/// 関連tprxソース: rc_mem.h - GIFT_BAR
class GiftBar {
  String   giftBarCd1 = '';     /* gift BarCode 1st               */
  String   giftBarCd2 = '';     /* gift BarCode 2nd               */
  String   giftBarCd2_2 = '';   /* gift BarCode 2nd after Mask    */
  String   giftBarFlg = '';                 /* gift BarCode Flag              */
  int   giftBarSml = 0;                 /* gift BarCode Small Class Code  */
  int   giftBarPrc = 0;                 /* gift BarCode Price             */
  int   giftBarClass = 0;               /* gift BarCode Class Code        */
  int   giftBarFd = 0;                  /* gift BarCode fd Code           */
  int   giftBarItmcd = 0;               /* gift BarCode item Code         */
  int  giftBar1Fno = 0;                /* gift BarCode 1st Format No     */
  int  giftBar2Fno = 0;                /* gift BarCode 2st Format No     */
  String   giftBar1Flg = '';                /* gift BarCode 1stFlag           */
  String   giftBar2Flg = '';                /* gift BarCode 2ndFlag           */
}

/// 関連tprxソース: rc_mem.h - DEPTFRESH_BAR
class DeptfreshBar {
  String   deptfreshBarCd = '';   /* DeptFresh BarCode                 */
  String   deptfreshtBarFlg = '';             /* DeptFresh BarCode Flag            */
  int   deptfreshBarSml = 0;              /* DeptFresh BarCode Small Class Code*/
  int   deptfreshBarPrc = 0;              /* DeptFresh BarCode Price           */
  int   deptfreshBarFd = 0;               /* DeptFresh BarCode fd Code         */
}

/// 関連tprxソース: rc_mem.h - SALLMT_BAR
class SallmtBar {
  String   sallmtBarCd1 = '';   /* Sale Limit BarCode 1st     */
  String   sallmtBarCd2 = '';   /* Sale Limit BarCode 2nd     */
  String   sallmtPluCd = '';    /* Plu Code             */
  String   sallmtBarFlg = '';               /* Sale Limit BarCode Flag    */
  String   sallmtBar1Flg = '';              /* Sale Limit BarCode 1stFlag */
  String   sallmtBar2Flg = '';              /* Sale Limit BarCode 2ndFlag */
  String   sallmtday = '';                 /* Sale Limit Day       */
  int   sallmtBarPrc = 0;               /* Sale Limit Barcode Price   */
  String   sallmtBar26Flg = '';              /* Sale Limit BarCode 26 Digit Flag */
  String expiryDay = '';               /* expiry date           */
  String sallmtBarOlcFlg = '';         /* Sale Limit BarCode olc Flag */
}

/// 関連tprxソース: rc_mem.h - FUNCTION_BAR
class FunctionBar {
  String   funcBarCd = '';   /* Function BarCode             */
  String   funcBarFlg = '';              /* Function BarCode Flag        */
  int   funcBarKycd = 0;             /* Function BarCode Key Code    */
  int   funcBarFree = 0;             /* Function BarCode free Code   */
}

/// 関連tprxソース: rc_mem.h - POINTTCKT_BAR
class PointtcktBar {
  String   ticketBarCd = '';   /* Function BarCode             */
  String   ticketBarBack1 = ''; /* Function BarCode Backup     */
  String   ticketBarBack2 = ''; /* Function BarCode Backup     */
  String   ticketBarBack3 = ''; /* Function BarCode Backup     */
  String   ticketBarBack4 = ''; /* Function BarCode Backup     */
  String   ticketBarBack5 = ''; /* Function BarCode Backup     */
  String   ticketBarBack6 = ''; /* Function BarCode Backup     */
  String   ticketBarBack7 = ''; /* Function BarCode Backup     */
  String   ticketBarBack8 = ''; /* Function BarCode Backup     */
  String   ticketBarBack9 = ''; /* Function BarCode Backup     */
  int ticketBarFlg = 0;              /* PointTicket BarCode Flag        */
  int ticketBarStore = 0;            /* PointTicket BarCode Key Code    */
  int ticketBarMacno = 0;            /* PointTicket BarCode Key Code    */
  int ticketBarNum = 0;              /* PointTicket BarCode free Code   */
  String ticketBarPrc = '';              /* PointTicket BarCode Price       */
  int ticketBarCnt = 0;              /* PointTicket BarCode Count       */
}

/// 関連tprxソース: rc_mem.h - GS1_BAR
class Gs1Bar {
  String   barCd = '';               /* Gs1 BarCode Jan Code */
  String   sallmt = '';                /* Gs1 BarCode Sale Limit */
  String   expdate = '';
  String   orgId = '';
  String   dsc = '';
  String   sallmttm = '';
  String   expdatetm = '';
  String   weight = '';
  String   pluCd = '';       /* BarCode Plu Code  */
  String   barFlg = '';                  /* BarCode Dsc Flag  */
  int   barPrc = 0;                  /* Barcode Sdc Price */
  int   netWgt = 0;                  /* Barcode Net Weight */
  int  gs1barFlg = 0;
}

/// 関連tprxソース: rc_mem.h - ASSORT
class Assort {
  int  typ = 0;     /* 1:qty ZERO 2: amt ZERO  3: mbr amt (bit)*/
  int   cd = 0;
  int   amt = 0;
  int   mamt = 0;
  int  qty = 0;
  int  mark = 0;
  int  flg = 0;
  int  drwCd = 0;
  String   name = '';
  int  repetFlg = 0;
  int	taxDiff = 0;	/* セット商品の印字やEJフラグ  0:RCPT/EJ 詰合名称のみ  1:RCPT/EJ 構成商品  */
}

/// 関連tprxソース: rc_mem.h - RESERV_BAR
class ReservBar {
  int   shopNo = 0;                   /* shop number             */
  int   macNo = 0;                    /* machine number          */
  int   receiptNo = 0;                /* receipt number          */
  int   printNo = 0;                  /* print number            */
  String   saleDate = '';             /* YYMMDD                  */
  String   barFlg = '';                   /* BarCode Flag            */
  String   janCd = '';                /* jan code                */
}

/// 関連tprxソース: rc_mem.h - BENEFIT_BAR
class BenefitBar {
  String   couponBarCd = ''; /* Benefit BarCode              */
  String   couponBarFlg = '';            /* Benefit BarCode Flag         */
  int   couponBarCompcd = 0;         /* Benefit BarCode Comp Code    */
  int   couponBarBenefitcd = 0;      /* Benefit BarCode benefit Code */
  int   couponBarPlancd = 0;         /* Benefit BarCode Plan Code    */
  int   couponBarValue = 0;          /* Benefit BarCode Value Code   */
}

/// 関連tprxソース: rc_mem.h - CARDFORGET_BAR
class CardforgetBar {
  String   forgetBarCd1 = '';/* Card Forget BarCode 1st      */
  String   forgetBarCd2 = '';/* Card Forget BarCode 2nd      */
  String   forgetBarFlg = '';            /* Card Forget BarCode Flag     */
  String   forgetBar1Flg = '';           /* Card Forget BarCode 1stFlag  */
  String   forgetBar2Flg = '';           /* Card Forget BarCode 2ndFlag  */
  int   forgetBarCompcd = 0;         /* Card Forget BarCode Comp Code*/
  int   forgetBarPoint = 0;          /* Card Forget BarCode Point    */
  String   forgetDay = '';             /* Card Forget Day              */
  int   forgetMacNo = 0;             /* Card Forget Reg Number       */
  int   forgetReceiptNo = 0;         /* Card Forget Receipt Number   */
}

/// 関連tprxソース: rc_mem.h - RPTAG_BAR
class RptagBar {
  String   rptagBarCd1 = '';   /* Red/Price Tag BarCode 1st             */
  String   rptagBarCd2 = '';   /* Red/Price Tag BarCode 2nd             */
  String   rptagBarCd2_2 = ''; /* Red/Price Tag BarCode 2nd             */
  String   rptagBarFlg = '';               /* Red/Price Tag BarCode Flag            */
  int   rptagBarPrc = 0;               /* Red/Price Tag BarCode Price           */
  String   rptagBar1Flg = '';              /* Red/Price Tag BarCode 1stFlag         */
  String   rptagBar2Flg = '';              /* Red/Price Tag BarCode 2ndFlag         */
  int  rptagBar1Fno = 0;              /* Red/Price Tag BarCode 1st Format No   */
  int  rptagBar2Fno = 0;              /* Red/Price Tag BarCode 2nd Format No   */
  int   rptagBarSml = 0;               /* Red/Price Tag BarCode Small Class Code*/
  int   rptagBarClass = 0;             /* Red/Price Tag BarCode Class Code      */
  int   rptagBarDiv = 0;               /* Red/Price Tag BarCode div Code        */
}

/// 関連tprxソース: rc_mem.h - GOODSNUM_BAR
class GoodsnumBar {
  String   goodsnumBarCd = ''; /* Goods Number BarCode                  */
  String   goodsnumBarFlg = '';            /* Goods Number BarCode Flag             */
  int   goodsnumBarSml = 0;            /* Goods Number BarCode Small Class Code */
  int   goodsnumBarClass = 0;          /* Goods Number BarCode Class Code       */
}

/// 関連tprxソース: rc_mem.h - AUTOSTRCLS_STAFF
class AutostrclsStaff {
  String 	entFlg = '';	/* 入力済フラグ
				   0x00:未入力　
				   0x01:差異チェック入力済　
				   0x02:売上回収
				　 0x04:釣機回収 */
}

/// 関連tprxソース: rc_mem.h - AYAHA_GIFT_POINT_BAR
class AyahaGiftPointBar {
  String	giftPointBarCd = '';
  String	giftPointBarFlg = '';
  int	giftPointBarSumcd = 0; // 集計コード
  int	giftPointBarPoint = 0; // 付与ポイント
}

/// 関連tprxソース: rc_mem.h - TPOINT_DATA
class TPointData {
  int	couponCount = 0;		// クーポン数
  int	couponno = 0;		// クーポン番号
  String	ankenno = '';	// プロモーション番号
  String	jancd = '';		// JANコード
  String	kanrino = '';	// 管理番号
  int	keihyou = 0;		// 景表法金額
  String	note1 = '';		// 会員番号印字フラグ
  String	note2 = '';		// 発券店舗名印字フラグ
}

/// 関連tprxソース: rc_mem.h - WSUSEDINFO
/// ワールドスポーツ様 中古品情報
class WsUsedInfo {
  int	fStatus = 0;		// ステータス情報
  String	jancdInput = '';	// JANｺｰﾄﾞ(入力)
  String	jancdAnswer = '';	// JANｺｰﾄﾞ(回答)
  String	hinak = '';		// 品名(ｶﾅ)
  String	kikak = '';		// 規格(ｶﾅ)
  String	hinkj = '';		// 品名(漢字)
  String	kikkj = '';		// 規格(漢字)
  int	bmncd = 0;			// 部門ｺｰﾄﾞ
  int	daicd = 0;			// 大分類ｺｰﾄﾞ
  int	chucd = 0;			// 中分類ｺｰﾄﾞ
  int	shocd = 0;			// 小分類ｺｰﾄﾞ
  String	bkazei = '';			// 売価課税区分
  String	zerit = '';			// 消費税率
  int	baika = 0;			// 売単価
}

/// 関連tprxソース: rc_mem.h - WSCPNUSE
/// ワールドスポーツ様 クーポンバーコード利用
class WsCpnUse {
  int cpnbarFlg1 = 0;		// 1段目バーコードスキャン済みフラグ(先頭7)
  int cpnbarFlg2 = 0;		// 2段目バーコードスキャン済みフラグ(先頭8)
  int cpnbarTyp = 0;		// 企画種別
  int cpnbarMny = 0;		// 券面金額
  int cpnbarCd = 0;		// 企画コード
  int cpnbarNum = 0;		// まとめ枚数
  int cpnbarTicket = 0;		// 券種別（1:クーポン、2:抽選券、3:デジタルクーポン）
}

/// 関連tprxソース: rc_mem.h - ATTEND_TIME_DATA
class AttendTimeData {
  String	startTime = '';	// アテンド時間計測開始時刻
  int time = 0;		// アテンド時間
}

/// 関連tprxソース: rc_mem.h - DEPOINPLU_BAR
class DepoinpluBar {
  String   depoinBarCd = '';  /* 貸瓶付き商品バーコード            */
  String   pluCd = '';                /* 貸瓶付き商品バーコードのPLUコード */
  String   depopluCd = '';            /* 貸瓶商品コード                    */
  String   depoinpluBarFlg = '';                   /* 貸瓶付き商品バーコード読込みFlag  */
}

/// 関連tprxソース: rc_mem.h - PRODUCER_BAR
class ProducerBar {
  String	prodBarCd1 = '';	/* 生産者バーコード1段目 */
  String	prodBarCd2 = '';	/* 生産者バーコード2段目 */
  String	prodBarFlg = '';			/* 読み込みフラグ　      */
  int	prodBarPrc = 0;			/* 金額  */
  String	prodBar1Flg = '';			/* 1段目読込状態*/
  String	prodBar2Flg = '';			/* 1段目読込状態*/
  int	prodCode = 0;			/* 生産者品目コード  */
  String	pluCd = '';			/* 商品PLUコード */
  String	prodName = '';			/* 生産者品目名称 */
}

/// 関連tprxソース: rc_mem.h - DIVDATA
class DivData {
  int	divCd = 0;			/* 区分コード */
  int	taxCd = 0;			/* 税コード */
  String divName = '';		/* 区分名称 */
}

/// 関連tprxソース: rc_mem.h - ACMEM
class AcMem {                     /* Common Memory of Registration Mode */
  Stat stat = Stat();                  /* Clerk Status                 */
  Entry ent = Entry();                   /* Entry Buffer                 */
  Working working = Working();               /* Registration Working Buffer  */
  Repeat repeat = Repeat();                /* Repeat Datas Working Buffer  */
  var keyChkb = List.filled(FuncKey.keyMax+1, 0);  /* Local Key Flag Buffer        */
  var keyStat = List.filled(FuncKey.keyMax+1, 0);  /* All Func. Key Status         */
  DspDatas scrData = DspDatas();               /* Write Screen Buffer FIP      */
  DateTime? date;                  /* Read System Date Buffer      */
  PostReg postReg = PostReg();              /* Post Tendering               */
  CoinData coinData = CoinData();              /* ACR/ACB Stock data           */
  CustData custData = CustData();              /* Customer Data                */
  AcbData acbData = AcbData();               /* ACB Decision Data            */
  DscBar? dscBar;               /* Disc BarCode Data            */
  RcptBar rcptBar = RcptBar();              /* Receipt BarCode Data         */
  PostReg? postRegsv;            /* Post Tendering Save          */
  FreshBar? freshBar;             /* Fresh BarCode Data            */
  BookBar? bookBar;              /* Book BarCode Data            */
  ClothesBar? clothesBar;        /* Clothes BarCode Data         */
  MagazineBar? magazineBar;		/* Magazine BarCode Data		*/
  ItfBar? itfBar;                 /* ITF Barcode Data             */
  Seg1Data seg1Data = Seg1Data();             /* Web-Jr Seg1 Data             */
  Seg2Data seg2Data = Seg2Data();             /* Web-Jr Seg2 Data             */
  String fbDualdskStopFlg = '';	/* FB Dual Desktop Type Device Stop Flag */
  String fbDualScnchkFlg = '';     /* FB Dual Single Mode ScnChk Pop Flag   */
  int fenceOverFlg = 0;
  AsstMnt? asstMnt;                /* Assist Monitor Data */
  PresetBar? presetBar;           /* Preset Barcode Data   */
  PricetagBar? pricetagBar;         /* PriceTag Barcode Data */
  GiftBar? giftBar;             /* Preset Barcode Data   */
  DeptfreshBar? deptfreshBar;       /* DeptFresh Barcode Data*/
  SallmtBar? sallmtBar;       /* Sale Limit Barcode Data */
  FunctionBar? funcBar;         /* Function Barcode Data   */
  int apldlgPtn = 0;       /* Dialog Pattern Mode     */
  PointtcktBar ticketBar = PointtcktBar();      /* PointTicket Barcode Data */
  Gs1Bar? gs1Bar;             /* GS1 Barcode Data */
  Assort assort = Assort();         /* assorted set match */
  String? bkupNowSaleDatetime; /* now sales datetime */
  String? bkupSaleDate;        /* sale date */
  ReservBar? reservBar;	 /* Reserv Barcode Data */
  int regsItemlogCnt = 0;  /* Registration itemlogCnt  Fip表示切替にて使用 */
  int prodbarNotfpluFlg = 0;       /* ProducerBarCode NotFindPLU flag */
  BenefitBar? benefitBar;        /* Benefit Coupon Barcode Data     */
  CardforgetBar? cardforgetBar;     /* Card Forget Barcode Data        */
  RptagBar? rptagBar;     /* Red/Price Tag Barcode Data        */
  GoodsnumBar? gnBar;     /* Goods Number Barcode Data        */
  int alertFlg = 0;
  int prcChgUpFlg = 0;	     /* Price Change Up flag */
  int qcSeltFlg = 0;            /* QC指定 */
  AutostrclsStaff? staffInfo;
  int acracbFirstAnswer = 0;
  int useCount = 0;	     /* Server uses when PQS(CO5) */
  int ticketFlg = 0;          /* Ticket has been given this mouth, when PQS(CO5) */
  String jis1TmpBuf = '';
  String jis2TmpBuf = '';
  int ticketCount = 0;
  int couponCount = 0;
  int ticketPoint = 0;
  int qrChgFlg = 0;
  int qrChgKoptFlg = 0;
  AyahaGiftPointBar? ayahaBar;
  int devStlFlg = 0;
  TPointData? tPointData;		     /* Tポイント会員データ */
  int kfncCdCnt = 0;
  int ItemMax = 0;		// 登録段数の最大値
  int chkHappySmileStart = 0;
  int opeCdCnt = 0;
  WsUsedInfo? wsUsedInfo;	// 中古品情報
  WsCpnUse? wsCpnUse;	// クーポンバーコード
  AttendTimeData attendTimeData = AttendTimeData();	// アテンド時間計測用
  DepoinpluBar? depoinplu;	// 貸瓶付き商品バーコード情報
  ProducerBar? prodBar;	// 生産者バーコード
  int fselfMbrscanFlg = 0;				/* G3対面 客側会員読取状態 0：操作待ち、1：持っていない、2：読込済 */
  int fselfMbrscanInquiry = 0;			/* G3対面 客側会員問合せ待ちフラグ 0：問合せ待ちでない、1：問合せ待ち */
  String fselfMbrscanMemberCd = '';	/* G3対面 客側会員読取 バーコード情報 */
  int fselfMbrscanPopupFlg = 0;		/* G3対面 客側会員読取 カード未入力ポップアップ 0：表示しない、1：表示した */
  DivData? divData;
}

/// 関連tprxソース: rc_mem.h - IFWAIT_SAVE
class IfWaitSave {
  int count = 0;
  var buf = List.generate(20, (index) => RxInputBuf());  // 固定長さ「20」を変更するならintFlagの長さと一緒に同じ値に変更すること
  var intFlag = List.filled(20, 0);  // 固定長さ「20」を変更するならbufの長さと一緒に同じ値に変更すること
}

/// 関連tprxソース: rc_mem.h - RCPT_CASH
/// 通番訂正 返金用メモリ
class RcptCash {
  int pay = 0;		/* 通番訂正返金額 */
  int status = 0;		/* 返金ボタン表示 */
  int actChk = 0;	/* 合計金額0円チェック */
}

/// 関連tprxソース: rc_mem.h - WEBREAL_TBL
class WebrealTbl {
  int step = 0;                     /* Command Step                 */
  int opemode = 0;                  /* Ope Mode                     */
  int amt = 0;
  int webrealsrvKangen = 0;
  int webrealsrvFuyo = 0;
  int key = 0;
  int stat = 0;
  int addStat = 0;		 /* 締め処理時のポイント更新処理　0:しない　1：する */
  int addErr = 0;
  Function? func = null;
}

/// 関連tprxソース: rc_mem.h - SPVT_DATA
class SpvtData {
  int  fncCode = 0;       /* Func Code    */
  int  oldStep = 0;       /* Step Backup  */
  int  checkSt = 0;       /* Status Check */
  int  tranEnd = 0;       /* Tran End Flg */
  late var kid1 = List.filled(4, 0);       /* KID1         */
  late var kid2 = List.filled(4, 0);       /* KID2         */
  late var kid3 = List.filled(4, 0);       /* KID3         */
  late var slipNo = '0';     /* Slip No      */
  late var icNo = '0';      /* IC No        */
  late var anyCd = List.filled(10, 0);     /* Res Err Code */
  int  happySmileDspCtrl = 0;
}

/// LCD Subtotal Screen Item List
/// 関連tprxソース: rc_mem.h - STLLCD_ITEM
class StlLcdItem {
  int pageCurr = 0;                 /* current Page Number for item list */
  int pageMax = 0;                  /* maximum Page Number for item list */
  int itemCurr = 0;                 /* index of aiI[] for current item list */
  int itemMax = 0;                  /* index of aiI[] for bottom item list */
  List<int> aiI = List.filled(CntList.itemMax, 0);            /* index of ITEMRBUF */
  int scrVoid = 0;                  /* The Number for item list on a screen */
  int iI = 0;                       /* index of ITEMRBUF for SCREEN VOID*/
  int currNum = 0;                  /* index of aiI[] for current item list for Web2800 */
  int currMax = 0;                  /* index of aiI[] for bottom item list for Web2800 */
  int stlItemCurr = 0;              /* index of aiI[] for stl current item list for Web2800 in Dual */
  int stlCurrNum = 0;               /* index of aiI[] for stl current item list for Web2800 in Dual */
  int stlCurrMax = 0;               /* index of aiI[] for stl bottom item list for Web2800 in Dual */
  int itemLastFlg = 0;              /* item list last line for Web2800 */
  int stlLastFlg = 0;               /* slt list last line for Web2800 */
  List<List<int>> itemSlctFlg = List.filled(ChangeKind.CHG_KIND_MAX.index, List.filled(CntList.itemMax * 2, 0));  /* 選択モード中の選択アイテム     */
  int slctCurrKind = 0;		/* 明細変更種別*/
}

/// 関連tprxソース: rc_mem.h - AT_SINGL
class AtSingl {
  int autolevel = 0;                   /* Auto Checker Level           */
  int autonumber = 0;                  /* Auto Checker                 */
  int autoCall = 0;                   /* Auto Checker Auto Call       */
  String autoFlg = '';                 /* Auto Checker Flag            */
  String autoCd = '';                  /* Auto Checker code            */
  String autoMbrCd = '';              /* Auto Member code             */
  int autotimer1 = 0;                  /* Auto Checker Timer1          */
  int autotimer2 = 0;                  /* Auto Checker Timer2          */
  int autotimer3 = 0;                  /* Auto Checker Timer3          */
  int autotimerCnt = 0;               /* Auto Checker Timer Count     */
  int rctChkCnt = 0;                 /* Receipt empty check counter  */
  int btlSaleAmt = 0;                /* bottle/out of mdlcls sale amount temporary */
  int startDspFlg = 0;               /* Startup Display Flag         */
  int autoMbrFlg = 0;                /* Member Flag                  */
  int acbNotdecFlg = 0;              /* ACB Decision Type        */
  int useRwcRw = 0;                  /* Use rewrite card R/W         */
  int kyRwcrd = 0;                    /* Use rewrite card reading key */
  int kAmount = 0;                    /* Amount key                   */
  int lpntSurplus = 0;                /* Last point surplus           */
  int rwcErrNo = 0;                  /* Error no.                    */
  int kyVmcrd = 0;                    /* Use vismac card reading key  */
  int cardStoreCd = 0;               /* card store code              */
  int scnchkSelflg = 0;               /* Scan Check Select Item Flag */
  int scnchkPrintendbtnflg = 0;       /* Scan Check PrintEnd Button Flag */
  int mbrTyp = 0;                     /* member type */
  int beamReleaseFlg = 0;            /* beam Release Flag            */
  int chaReturnFlg = 0;              /* cha or chk return Flag       */
  int acbActFinalFlg = 0;            /* AcbAct Final Key Flag      */
  int limitFlg = 0;                   /* Amount of Limit Flag         */
  int tuoFlg = 0;                     /* tuo  Flag                   */
  int tuoMcdFlg = 0;                 /* tuo card Flag               */
  String tuoErr = '';
  int fscaAutoFlg = 0;               /* fsca auto point flag        */
  int fscaCrdtStat = 0;              /* fsca credit receive status  */
  int mediaMcdFlg = 0;               /* media card Flag               */
  int deptNorepeatFlg = 0;           /* department notrepeat flag   */
  int mbrinfoZoomFlg = 0;            /* member info zoom Flag       */
  int mbrinfoLine = 0;                /* member info line            */
  String rainbowName = '';          /* Rainbow Name for Disp       */
  String rainbowRank = '';           /* Rainbow Rank for Disp       */
  double buyPointAddMagn = 0.0;          /* Buy Point Add Magn Data     */
  int proditfErrFlg = 0;      /* ProdItf NonCategory ErrFlag */
  String addErrorCd = '';           /* add error code to error Dlg */
  int yaoDetailFlg = 0;              /* Yao Detail Flg for Pop Msg  */
  int lastUpdErrChk = 0;            /* Last Update Error Check Flg */
  int uidErrStat = 0;                /* uid error status            */
  int customercardFlg = 0;            /* Customer Card Data Make Flg */
  int lastVoidItmcnt = 0;            /* Last void item Flg          */
  int customercardFtpResult = 0;     /* Customer Card Data Ftp Result */
  int crdtMismsgCnt = 0;      /* ｶｽﾐ様他ｸﾚ読み取り不良MSG表示回数*/
  int btlAmtTotal = 0;               /* 返瓶金額合計（クレジット割引用） */
  int yamatoSettleTyp = 0;           /* ヤマト電子マネー端末の決済種別 */
  int beforeStlAmt = 0;              /* コープさっぽろ 表示前小計金額  */
  int entryCrdtInquFlag = 0;           /* 値数＋クレジット時の問合せフラグ  0:まだ  1:行った */
  int entryCrdtAmt = 0;                /* 値数＋クレジットの入力データ */
  int entryPrecaInquFlag = 0;           /* 置数＋プリペイド時の問合せフラグ  0:まだ  1:行った */
  int entryPrecaAmt = 0;                /* 置数＋プリペイドの入力データ */
  int utAlermFlg = 0;
  int notePluKind = 0;               /* noteplu func_cd */
  int othcntEjecterrChk = 0;
  int halfWinFlg = 0;                /* gratis half window exist */
  String multiPfmOcxErrmsg = '';    /* All OCX Result Code */
  int bkupAutoDeccin = 0;            /* (mac_info.json)bkup_auto_deccin  */
  int bkupAcbDeccin = 0;             /* (mac_info.json)bkup_acb_deccin   */
  int bkupAcrOnoff = 0;              /* (mac_info.json)bkup_acr_onoff    */
  int bkupAcbOnoff = 0;              /* (mac_info.json)bkup_acb_onoff    */
  int acxNearfullDiff = 0;           /* (mac_info.json)acx_nearfull_diff ニアフル差分枚数 */
  int itemdetailFlg = 0;              /* ItemDetail Flg for sp_department */
  int preRctfmFlg = 0;               /* 領収書宣言状態フラグ 0:しない 1:する  (prnrbufのみでは不可. MEM保存が仕様上障害になる) */
  int chargeSlipFlg = 0; /* 売掛会員フラグ 0:売掛会員ではない 1:売掛会員である */
  int qcSelectWinFlg = 0;           /* プリカおつりチャージ画面表示 */
  String mbrCdBkup = '';             /* Back up of mbr_cd               */
  int limitAmount = 0;                /* Limit amount                    */
  int reductCouponItmcnt = 0;        /* 単品値下げクーポン券の対象商品登録段数 */
  int reductVoidCouponFlg = 0;      /* 単品値下げクーポン券の指定訂正許可フラグ */
  DateTime? lastEventTime;             /* 最終操作時間 */
  int cctSettleTyp = 0;              /* CCT端末の決済種別 */
  int acracbRegstrStep = 0;          /* AcrAcb Command Step             */
  int printSkipFlg = 0;              /* レシート印字をさせたくないフラグ */
  int soundStopNonFlg = 0;          /* 音声を停止させたくないフラグ */
  int fselfThankyouFlg = 0;          /* ありがとうございました画面を追加表示したいフラグ */
  int ledCtrlFlg = 0;                /* LED表示の制御フラグ */
  int acracbStartFlg = 0;            /* 入金確定　開始フラグ */
  int acxUpdCtrl = 0;                /* 釣銭実績上げ制御（卓上レジ専用マルチ登録仕様） */
  int chgstatusErr = 0;               /* 釣機状態キーの状態表示用保持データ */
  String fselfSoundNo = '';         /* 繰り返し流す音声の、音声ファイル */
  int chgstopCtrlFlg = 0;            /* 入金状態を停止する場合の状態制御フラグ */
  int autoCinstopFlg = 0;            /* 入金状態を自動で停止するフラグ */
  int marutoAlertflg = 0;      /* 販売許可キーの押下判断フラグ（マルト様特注） */
  int nowDrawCinprc = 0;             /* 現在表示中の入金額 */
  int ayahaImmpromFlg = 0;           /* 即時プロモーション発行チェックフラグ【アヤハディオ】 */
  int fselfOnetimeCouponMode = 0;   /* 対面セルフ用クーポンモード判定フラグ */
  int fselfInoutChk = 0;             /* 登録画面の常時入金開始を制御する */
  int bdlDspFlg = 0;             /* 小計キー押下時エラーによるミックスマッチ選択画面の表示制御フラグ 0:表示しない 1:エラー解除後表示する */
  int redcolorLedSkip = 0;           /* 赤色LEDの表示をさせない為の制御フラグ */
  int zhqCpnErrFlg = 0; /* お得機のエラーフラグ */
  int mbrdscRateCtrl = 0;            /* 会員割引率の制御フラグ */
  int noPrintFlg = 0;      /*印字しないプラグ*/
  int rckySelfMnt = 0;               /* 15インチ対面セルフの客側表示へ店員側表示と同じ画面を表示させる制御 */
  int backupFncCd = 0;               /* 決済端末利用時のファンクションキーコードバックアップ */
  int mulErrFlg = 0;      /* 特定乗算対応時のエラーフラグ */
  int edyNearfullFlg = 0;            /* Edyニアフル表示フラグ */
  int ledAlloffSkip = 0;             /* LEDの全消灯をさせない為の制御フラグ */
  int happySmileCashSelect = 0;     /* HappySelf<対面>で現金支払いを選択した場合にセット */
  String vescaEwCode = '';      /* vesca 画面表示用エラーコード */
  int colorfipitemsCtrl = 0;          /* カラー客表の商品情報表示の制御フラグ<HappySelfのスマイルセルフモードで使用> */
  int selectChargeCardSound = 0;    /* チャージするカードを選択してください♪音声を制御する */
  int verifoneChargeHappySelf = 0;  /* HappySelf<フル>の場合のVerifone単独チャージ制御フラグ */
  int verifoneChargeAlarmBal = 0;   /* QCashier、HappySelf<フル>の処理未了現金チャージ後の残高照会の制御 */
  int verifoneResumeAct = 0;         /* QCashier、HappySelf<フル>の前取引呼出し制御 */
  int verifoneCargeCnclAct = 0;     /* QCashier、HappySelf<フル>の現金チャージキャンセルボタン制御 */
  int chargeRceiptCtrl = 0;          /* チャージレシートの印字制御フラグ（後から、取引レシートをまとめて印字する場合） */
  int alertScreenmode = 0;      /* 警告表示タッチパネル対応制御フラグ */
  int verifoneSelftopCharge = 0;     /* Verifone単独チャージ開始フラグ */
  int qcSelectDspCcinFlg = 0;      /* QCashierの支払い選択画面で入金があった場合にセット*/
  int happySmileStlwaitFlg = 0;     /* HappySelf<対面>で小計押下後に客側表示更新と音声の制御フラグ */
  int happySmileStlwaitSet = 0;     /* HappySelf<対面>で小計押下後に客側表示更新と音声の制御フラグの変更許可フラグ 0:禁止 1:許可 */
  int happySmileBackSelect = 0;     /* HappySelf<対面>で支払方法選択画面に戻る場合にセット */
  int backupVescaPrintErr = 0;      /* Verifoneの特殊印字時の印字エラーコード保存メモリ */
  int staffCloseAfterUpdateTran = 0;   /* 実績上げ後従業員クローズ */
  int happyDisplayCalcPostGuidance = 0;/* HappySelf<対面>　(再)計算時、客表画面に「店員操作中… 」ガイダンス表示 */
  int vescaEdyMaxErr = 0;      /* Verifone edyの複数支払最大回数超過時のエラーフラグ */
  int vescaEdySeqNo = 0;      /* Verifone edyの複数支払テキストseq_no保持用フィールド */
  int backupQcSelectFlg = 0;        /* CMEMのqc_selt_flgを退避する為 */
  int saveAcbTotalPrice = 0;          /* 値数クレジット、置数プリペイド時の入金額退避データ */
  int repicaInFlg = 0;               /* レピカ読込フラグ */
  int repicaVescaFlg = 0;            /* verifone端末命令送信フラグ */
  int happySmileCashCncl = 0; /* HappySelf<対面>で「入金取消」ボタン押下後にセット */
  int dpntPlupointrdFlg = 0; /* dポイント用商品ポイント加算スケジュール読み取りフラグ */
  String dpointEwCode = ''; /* dポイントのエラーコード */
  int dpointEwKind = 0; /* dポイント 通信エラー発生時の通信種類 */
  int dpointRecrsplitFlg = 0; /* dポイント用スプリット情報再作成フラグ */
  int bcdSeqNo = 0; /* ２段バーコード読込フラグ */
  int wsCouponOff = 0; /* クーポンOFFフラグ */
  int entryRepicaPnt = 0; /* レピカポイント */
  int entryRepicaPntInquFlag = 0; /* レピカポイント通信成功フラグ 0：通信していない 1：ポイント減算通信済み 2：ポイント加算通信済み */
  int publicReadMny = 0; /* パソナ様 バーコードから読込んだ金額を格納するメモリ */
  int depoBrtInFlg = 0;                   /* 瓶返却フラグ */
  int selfmntManual = 0;
  int multiVegaWaitFlg = 0;            /* VEGA端末処理中フラグ 1:要表示 2:表示中 */
  int vegaSettleTyp = 0;                /* VEGA端末の決済種別 */
  int paySelectBtnCtrlFlg = 0;        /* 支払い選択ボタンの排他制御 */
  int psenErrFlg = 0; /* 近接センサエラーの表示フラグ */
  String rpointEwCode = ''; /* 楽天ポイント通信時の結果コード */
  int rpointRecrsplitFlg = 0; /* 楽天ポイント仕様 スプリット再現制御フラグ */
  int rpointUpdPayKind = 0; /* 楽天ポイント仕様 ポイント登録呼出元決済種別 */
  int rpointUpderrProc = 0; /* 楽天ポイント仕様 ポイント登録通信エラー処理フラグ */
  int rpointUpderrProcErrno = 0; /* 楽天ポイント仕様 ポイント登録通信エラー処理中に発生したエラーメッセージ */
  int combiChgAmt = 0; /* 釣銭額一時保存メモリ */
  int payconfdialogChkFlg = 0; /* 支払確認ダイアログ表示フラグ */
  int splitRecrsplitFlg = 0;        /* スプリット再現制御フラグ */
  int pctCrdtTyp = 0; /* PCT接続時、返品取消の会計種類 */
  int pctDscMny = 0; /* PCT接続時、返品取消のイオクレ・デジタルお買物券利用額 */
  int tpointRecrsplitFlg = 0; /* Tポイント仕様 スプリット再現制御フラグ */
  int tomonokaiReadingflg = 0;           /* 友の会カード読込中フラグ */
  int tomonokaiFlg = 0;             /* 友の会フラグ  0:未使用 1:照会済み 2:利用済 */
  int tomonokaiUseamt = 0;             /* 友の会利用額 */
  int tomonokaiSagDispSts = 0; /* 友の会 Shop&Go 画面遷移用ステータス */
  String tomonokaiErrDefail = ''; /* 友の会 エラー内容詳細 */
  int loanChkCnt = 0; /* 自動開閉店釣準備画面で操作時間をカウントする */
  int mulPrecaSendStatus = 0; /* プリペイド複数枚利用　引き去り通信結果 */
  int paygrpTwice = 0; /* 会計グループのドリルダウン */
  String publicBarcodeExpdateName = ''; /* 公共料金有効期限名称 */
  String publicBarcodeExpdateDate = ''; /* 公共料金有効期限日付 */
  String sp1QRAcode = ''; /* 他社QRコード */
  int autoRmodExecFlg = 0; /* Happy対面 呼び戻し／検索登録後の登録画面遷移フラグ 0:登録画面に遷移しない 1:登録画面に遷移する */
  Uint8List lastCommSaveOtherEntry = Uint8List(10); /* 後通信処理 最後の支払が後通信決済ではなかった場合の入力値を保存 */
  int frestaDataSetFlg = 0; /* フレスタ 固定会員番号のデータ適用フラグ 0:適用させない 1:適用させる */
  int paymentGroupStartDisp = 0; /* スタート画面で選択した会計グループコード */
  int paymentStartDisp = 0; /* スタート画面で選択した会計コード */
  int startBagDispFlag = 0;    /* スタート画面でレジ袋選択画面フラグ*/
  String ozekiPluSetDate = ''; /* オオゼキ様、商品登録開始時間 */
  DateTime? ozekiScanStartTime;             /* オオゼキ様、商品登録開始時間 */
  int ozekiScanStartTimeSus = 0;         /* オオゼキ様、仮締めやタブーに移動するフラグ */
  // TODO:00011 周 下記C言語の構造体、必要になる時Dart側に都度追加実装する予定。最初は全部コメントアウト
  MCD inputbuf = MCD();  /* Input Buffer                 */
  StlLcdItem tStlLcdItem = StlLcdItem();  /* LCD Subtotal Screen Item List*/
//  STLSLCD_ITEM  tStlsubLcdItem;              /* Sub LCD Subtotal Screen Item List */
//  GtkWidget     *pStlItemBtn;                /* LCD Subtotal Item Button Press Key Address */
//  GtkWidget     *pStlItemBtnLst;             /* LCD Subtotal Item Button Last Press Key Address */
//  CLSCAT_FLG    clscat_flg;                  /* Class/Category AllDisc Flag  */
//  TRC_TR        trctrack;                    /* Track data(track1-track3)    */
//  TRC_DATA      trcdata;                     /* Track data(magn/prn data)    */
//  FSP_TR        fsptrack;                    /* Track data(track1-track3)    */
//  FSP_DATA      fspdata;                     /* Track data(magn/prn data)    */
//  ORC_WR_IWAI   orcdata;                     /* Oki Data                     */
//  T_VMC_MGNT_P  vmcpdata;                    /* vismac apl data              */
//  T_VMC_MGNT_T  vmctdata;                    /* vismac magnetic data         */
//  T_VMC_VSAL_P  vmcvdata;                    /* vismac visual data           */
  EDYSIP60     edysip60 = EDYSIP60();                    /* Edy Data                     */
//  MC_TBL        mc_tbl;                      /* Mc Table                     */
  FelicaTbl   felica_tbl = FelicaTbl();                  /* FeliCa Table                 */
  NttAspTiFile tranInfFile = NttAspTiFile();  /* Ntt Credit <Tran. Inf. File> */
//  PSP70_CARDDATA psp70_carddata;
//  PSP70_APLSTAT  psp70_apldata;
//  PANA_SPD_DATA sapporo_panadata;            /* Sapporo Pana Data            */
//  PANA_JKL_DATA jkl_panadata;                /* Jakkulu Pana Data            */
  PanaRainbowData rainbowPanadata = PanaRainbowData();        /* Rainbow Card Data */
  PanaMatsugenData mgnPanadata = PanaMatsugenData();           /* Matsugen Pana Data           */
//  MCP_DATA      mcp_data;                    /* Mcp200 Data */
  SuicaTbl suicaData = SuicaTbl();
  ScnChkMbr scanchkMbr = ScnChkMbr();
//  PANA_DATA panadata;                        /* Common Pana Data            */
  SpvtData spvtData = SpvtData();
//  MSR_DATA      msr_data;                    /* Back up for Magnetic Card Data */
//  HT2980_CARDINFO   ht_cardinfo;             /* HT2980 CardInfo             */
//  HT2980_WRITE      ht_write;                /* HT2980 Write                */
//  HT2980_WRITE_R    ht_write_data;           /* HT2980 WriteResult          */
  WebrealTbl webrealData = WebrealTbl();
//  YAO_MBR_DATA  yao_mbr_data;                /* Yao Member Data             */
  ChgOutData chgOutData = ChgOutData();  /* 再出金のためのデータ保存 */
  RcptCash rcptCash = RcptCash();           /* 通番訂正 返金額メモリ */
//  INI_ECS_SPEC ini_ecs_spec;                /* ECS RAS設定保存データ */
//  TPOINT_LOG tpoint_log; /* Tポイントデータ */
//  PROM_DATA prom_data; /* プロモーションデータ */
}

/// 関連tprxソース: rc_mem.h - MBR_CALFLAGS
class MbrCalFlags{
  int?  stlpdscLimitchkFlg;       /* Member stlpdsc Limit Check Flag */
  int?  stlpdscRatezeroFlg;         /* Member stlpdsc Rate ZERO Flag */
}

/// 関連tprxソース: rc_mem.h - MIXM_TBL
class MixMTbl {
  List<String> ProgCd = List.filled(5, '');         /* M/Mコード */
  String ProgLim = '';           /* 成立制限回数 */
  String ProgFlg = '';           /* M/Mフラグ */
  int MmCnt = 0;             /* 合計成立回数 */
  int MmQty = 0;             /* 合計成立売数 */
  double MmAmt = 0.0;             /* 合計成立金額 */
  double MmPri = 0.0;             /* 合計成立商品値引前金額 */
  double MmDsc = 0.0;             /* M/M値引額 */
  double MmRem = 0.0;             /* M/M値引残額 = M/M値引額 - 案分済金額 */
  double MmTax = 0.0;             /* M/M税値引額 */
  double MmTaxRem = 0.0;          /* M/M税値引残額 */
  int RemQty = 0;            /* 未案分売数 */
  int iItmRBufHighPri = 0;   /* 最高単価の単品レシートバッファインデックス */
  int iIMixmTblLow = 0;      /* M/Mソートテーブル最低インデックス */
  int iIMixmTblHigh = 0;     /* M/Mソートテーブル最高インデックス */
  int iIMixmTblEnd = 0;      /* M/Mソートテーブル成立最終インデックス */
  int iTmp = 0;              /* 成立多段階データインデックス */
  List<MixMTmp> Tmp = List.generate(6, (_) => MixMTmp());    /* M/M多段階データ */
  List<String> Name = List.filled(201, '');         /* M/M NAME */
  bool AvCalcFlg = false;         /* M/M成立後平均単価計算フラグ */
  double ProgPrcLim = 0.0;        /* 値引下限額   */
  int ProgTyp = 0;           /* ミックスマッチタイプ */
  int refund_flg = 0;        /* 返品フラグ */
  PPromschMst bdlschprg = PPromschMst();         /* ミックスマッチ設定情報 */
  int ProgAvAdptFlg = 0;     /* 平均単価使用設定値 */
  int ProgAvUtilFlg = 0;     /* 平均単価利用種別設定値 */
  double ProgAvPrc = 0.0;         /* 平均単価設定値 */
  //#if BDL_PER
  double MmPerDsc = 0.0;          /* 割引ミックスマッチ用割引額 */
  //#endif
  RxMemBdlTaxFreeOrg org_bdl_prc = RxMemBdlTaxFreeOrg();
}
class MixMTmp {
  int ProgQty = 0;            /* 個数 */
  double ProgPri = 0.0;           /* 金額 */
  double ProgAv = 0.0;             /* 平均単価 */
  int TmpQty = 0;            /* 合計売数 */
  int MmCnt = 0;             /* 合計成立回数 */
  double MmDsc = 0.0;             /* 合計値引金額 */
}

/// 関連tprxソース: rc_mem.h - FELICA_TBL
class FelicaTbl {
  // short           stat;                     /* Status                       */
  // char            step;                     /* Step                         */
  // char            sip60res[256];            /* Sip Data                     */
  int use_sip = 0;                  /* Use Sip                      */
  int write_flg = 0;                /* Write flag                   */
  String buyadd_flg = "";               /* Buy Add flag                 */
  // FELICA_CUST     cust_data;                /* Cust Data                    */
  // FCF_CUST        fcf_cust_data;            /* FCF Cust Data                */
  // char            use_rw;                   /* Use R/W                      */
  // char            other_card_flg;           /* Other Card flag              */
}

/// 関連tprxソース: rc_mem.h - SUICA_TBL
class SuicaTbl {
  // char            step;                     /* Command Step                 */
   int            page = 0;                     /* Display Page                 */
  // char            opemode;                  /* Ope Mode                     */
  // long            amt;
  // long            price;
  // long            lack_amt;
  // char            lack_flg;
  // char            Relack_flg;
  int endCd = 0;
  // long            before_amt;
  // long            after_amt;
  // long            rest;
  // long            cncl_amt;
  // short           detcnt;
  // short           suicakey;                 /* Suica Final Function Key#      */
  // int             suicadev;                 /* Suica Final Device#            */
  // char            idi[17];
  // char            suicares[256];            /* Suica Card Data                */
  // long            charge_amt;
  // short           charge_cnt;
  // char            card_no[21];
  // short           lack_status_happy_s;
}

/// 関連tprxソース: rc_mem.h - SCNCHK_MBR
class ScnChkMbr {
  String custNo = "";  /* customer No. */
  String name = "";  /* name (25 characters (12-character input limitation)) */
  int totalPoint = 0;  /* total point */
  int totalBuyRslt = 0;  /* total buying actual results (it is used at the time of the credit sale) */
  int anyprcTermMny = 0;  /* the amount of multiple price term object */
  int fspLvl = 0;  /* FSP level */
}

// 小計値下案分用構造体
/// 関連tprxソース: rc_mem.h - SORT_STLDSC
class SortStlDsc {
  int remainder = 0;	// あまり   (対象額 * 小計値下額) % 小計額
  int actPrice = 0;	// 対象額
  int seqNo = 0;		// アイテムレコード番号
}

/// 関連tprxソース: rc_mem.h - enum STLDSC_PROC_TYP
enum StlDscProcTyp {
  NORMAL,
  WS_BEFORE,	// WS用 割引のみ行う
  WS_AFTER,	// WS用 値引のみ行う
}

/// 関連tprxソース: rc_mem.h - STLDSC_TBL
class StlDscTbl {
  int pdDscFlg = 0;  // 0:何もしない  PD_DSC_TYPE(rxlogcalc.h)の値をセット
  int pdTrendsTyp = 0;  // システムフラグ  0:本部設定 1:店舗設定
  int pdKeyCd = 0;  // fnc_cdをセット(手動値下用)
  List<String> promPlanCd = List.filled(
      CntList.promStldscMax, "");  // plan_cdをセット(プロモーション値下用)
  List<int> promDscAmt = List.filled(
      CntList.promStldscMax, 0);  // 値下額をセット(プロモーション値下用)
  int promIdx = 0;  // プロモーション小計値下インデックス(プロモーション値下用)
  List<int> promRemAmt = List.filled(
      CntList.promStldscMax, 0);  // プロモーション小計値下対象額
  int obj = 0;  /* 小計値下対象額 */
  int pmAmt = 0;  /* 小計割引額 */
  int amt = 0;  /* 小計値下額 = 小計割引額 + 小計値引額 */
  int rem = 0;  /* 小計値下残額 = 小計値下額 - 案分済金額 */
  int iItmRBuf = 0;  /* 小計値下可能最終レコードインデックス */
  int upri = 0;  /* 最高単価 */
  int iItmRBufHighPri = 0;  /* 最高単価の単品レシートバッファインデックス */
  int dscAmtTtl = 0;  /* 額割引対象商品案分金額合計 */
  int rem2 = 0;  /* 小計値下残額 = 小計値下額 - 案分済金額 */
  List<SortStlDsc> sortStlDsc = List.generate(
      CntList.itemMax, (_) => SortStlDsc());  // 小計値下案分用の一時バッファ
  int sortCnt = 0;  // 小計値下対象アイテムの数
  StlDscProcTyp pdDscProcTyp = StlDscProcTyp.NORMAL;  // 小計値下の特定処理用
  int iPDscItmRBuf = 0;  /* 小計割引可能最終レコードインデックス */
}

/// 関連tprxソース: rc_mem.h - NON_FL_DATA
class NonFlData {
  int flag = 0; // 0:リアルなし 1:リアルあり
  int price = 0; // POS売価
  int lrgCd = 0; // 大分類コード
  int mdlCd = 0; // 中分類コード
  int smlCd = 0; // 小分類コード
  int tnyCd = 0; // クラスコード
  int mgNonFlg = 0; // 部門バーコード読込み
}

/// 関連tprxソース: rc_mem.h - ONETIME
class Onetime{
  List<MixMTbl> atMixmTbl = List.generate(CntList.itemMax, (_) => MixMTbl());
  Flags flags = Flags();                     /* Extern Flag's        */
  MbrCalFlags mbrcalflags = MbrCalFlags();   /* Member Calc Flag's   */
  int logSkip = 0;                           /* 特定のログ出力制御用 */
  int ttlsptendAmt = 0;  /* Sprit Tend Amt Total */
  StlDscTbl tStlDscTbl = StlDscTbl();        /* StlDsc/%- table      */
  NonFlData nonPFLData = NonFlData();        /* RealPLU Data(ZHQ)    */
}

/// 関連tprxソース: rc_mem.h - FLAGS
class Flags{
  int         wrt_flag = 0;                   /* Save File Flag           */
  int         int_flag = 0;                   /* KY_INT "int_flag"        */
  int         clk_mode = 0;                   /* Now Working Clerk Mode   */
  int         clk_dev = 0;                    /* Now Working Clerk Device */
  int         mbr_flag = 0;                   /* Member System Flag       */
  int         collect_scrv = 0;               /* 指定変更（商品明細プリセットイベント） */
  // #ifdef FB2GTK
  // short        autochkr_out;               /* Autochkr Out Chk Flag    */
  // #endif
  int        fself_aft_start_timer = 0;      /* 対面セルフ入金開始タイマー機動 */
}

/// 関連tprxソース: rc_mem.h
class RcMem{
  static const IFWAIT_MAX = 20;
}

/// 関連tprxソース: rc_mem.h - EDY_SIP60
class EDYSIP60{
  String       step = '';                     /* Command Step                 */
  int       page = 0;                     /* Display Page                 */
  int          edykey = 0;                   /* Edy Final Function Key#      */
  int          edydev = 0;                   /* Edy Final Device#            */
  String       more_cancel_flag = '';         /* [BREAK] Key Active flag      */
  String       sip60res = '';                 /* Edy Card Data                */
}

/// 関連tprxソース: rc_mem.h - DLG_PARAM
class DlgParamMem {
  int erCode = 0;    /* not use */
  int dialogPtn = 0;    /* dialog pattern     */
                        /*  0:non             */
                        /*  1:normal          */
                        /*  2:entry           */
                        /*  3:entry password  */
  TitlInfo titlInfo = TitlInfo();
  List<BotnInfo> botnInfo = List.generate(6, (_) => BotnInfo());
  List<ConfInfo> confInfo = List.generate(6, (_) => ConfInfo());
  List<MesgInfo> mesgInfo = List.generate(6, (_) => MesgInfo());
  int opsFlg = 0;    /* Opposite side msg flg */
                     /*  0:"只今処理中…"        */
                     /*  1:変更しない           */
  int userCode1 = 0;    /* not use */
  int userCode2 = 0;    /* not use */
  int userCode3 = 0;    /* not use */
  int inputMax = 0;    /* input max when dialog_ptn = 2 */
}

// 分類マスタのタイプ
/// 関連tprxソース: rc_mem.h - CLS_TYPE
enum ClsType{
  CLS_NORM(0),	// 分類マスタ
  CLS_SUB1(1),	// サブ1分類マスタ
  CLS_SUB2(2),	// サブ2分類マスタ
  CLS_MAX(3);

  final int id;
  const ClsType(this.id);
}

/// 関連tprxソース: rc_mem.h - LRGCLSCUST
class LrgClsCust{
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - MDLCLSCUST
class MdlClsCust{
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - SMLCLSCUST
class SmlClsCust {
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - TNYCLSCUST
class TnyClsCust {
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - PLUCUST
class PluCust {
  /// char       key_chkb[1+MAX_FKEY];
  /// var keyChkb = List.filled(FuncKey.keyMax+1, 0);
  // int size = RegsMem().tItemLog[0]?.t10000.pluCd1_2 as int;
  // var          code[sizeof(((t_itemlog *)NULL)->t10000.plu_cd1_2)];
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - STAMPCUST
class StampCust {
  int         code = 0;
  int         item_qty = 0;
}

/// 関連tprxソース: rc_mem.h - LGPCLSCUST
class LgpClsCust {
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - GRPCLSCUST
class GrpClsCust {
  int         code = 0;
  int         item_qty = 0;
  String      refund_flg = '';
  String      btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - DISCCUST
class DiscCust {
  int       	code = 0;
  int       	item_qty = 0;
  String    	refund_flg = '';
  String    	btlret_flg = '';       /* Bottle Return */
}

/// 関連tprxソース: rc_mem.h - CUST_TBL
class CustTbl{
  LrgClsCust lrgcls = List.filled(ClsType.CLS_MAX.id, 0) as LrgClsCust;
  MdlClsCust mdlcls = List.filled(ClsType.CLS_MAX.id, 0) as MdlClsCust;
  SmlClsCust smlcls = List.filled(ClsType.CLS_MAX.id, 0) as SmlClsCust;
  TnyClsCust? tnycls;
  PluCust?      plu;
  StampCust?    stamp;
  LgpClsCust?   lgpcls;
  GrpClsCust?   grpcls;
  DiscCust?	disc;
}

/// 関連tprxソース: dev_in.h - MCD
class MCD{             /* Magnetic Card Reader */
  /*----------------------------------------------------------------------*
 *  dev
 *----------------------------------------------------------------------*/
  static const int D_KEY   =  0x01;  /* device: mecanical key */
  static const int D_TCH   =  0x02;  /* device: 10.4inch touch key */
  static const int D_SML   =  0x03;  /* device: 5.7inch touch key */
  static const int D_OBR   =  0x04;  /* device: OBR */
  static const int D_LCDB  =  0x05;  /* device: LCD bright */
  static const int D_MCD1  =  0x06;  /* device: magnetic card JIS1 */
  static const int D_MCD2  =  0x07;  /* device: magnetic card JIS2 */
  static const int D_SUB   =  0x08;  /* device: SUB-CPU */
  static const int D_SWT   =  0x10;  /* device: Clerk Call Switch */
  static const int D_DCT   =  0x11;  /* device: Sencer */
  static const int D_ICCD1 =  0x12;  /* device: IC Card1 */
  static const int D_PSEN  =  0x13;  /* device: Proximity Sensor */
  static const int D_APBF  =  0x14;  /* device: Auto Prastic Bag Feader */
  static const int D_EXC   =  0x15;  /* device: Age Check */
 /*----------------------------------------------------------------------*
 *  Structure of input device data
 *----------------------------------------------------------------------*/
  int    dev = 0;                /* device (D_MCD1/D_MCD2) */
  int   no = 0;                 /* SUB-CPU number */
  String   cmd = '';                /* command */
  String   prepare = '';            /* */
  int      Ocnt = 0;               /* input count */
  List<int>      Ocode = List.filled(DevIn.O_CNT, 0);     /* Magnetic card */
  int      Fcode = 0;              /* function code */
  String   Acode = '';     /* attend code */
  String   ADcode = '';          /* adon code */
  int      Smlcode = 0;            /* small class code */
  String   ITF_amt = '';         /* ITF Amount */
//#if    SALELMT_BAR
  String   salelmt = '';         /* sale limit */
//#endif
  String   Bar_data = '';       /* special dick barcode */
  int      barcd_len = 0;          /* input barcode length */
}

/// 登録画面でのタイマー管理番号リスト
/// 関連tprxソース: rc_mem.h - RC_TIMER_LISTS
enum RC_TIMER_LISTS{
  RC_EVENT_LOOP_TIMER(0),// イベント取得用　(スキャンやキー入力などをループして取得しているタイマー)
  RC_TIME_DISPLAY_TIMER(1),	// 時刻表示用
  RC_START_TMP_TIMER(2),	// 登録画面の起動: 初期表示用
  RC_START_ERR_TIMER(3),	// 登録画面の起動: エラーチェック用
  RC_TRAN_FUNC_TIMER(4),	// 登録画面: 締め操作や印字用

  RC_VOID_PROC_TIMER(5),	// 訂正画面用

  RC_GTK_ACB_STOPDSP_TIMER(6),	// 釣機使用停止用
  RC_GTK_ACB_TIMER(7),	// 釣機機処理用
  RC_GTK_ACB_CCIN_TIMER(8),	// 釣銭機入金取消処理用

  RC_ERR_DISP_TIMER(9),	// エラーダイアログ表示用
  RC_QC_ERR_DISP_TIMER(10),	// QCashierエラーダイアログ表示用
  RC_GTK_SPOOLI_TIMER(11),	// スプール用
  RC_GTK_REGSRET_TIMER(12),	// 登録画面の自動戻り用

  RC_GTK_SPVT_TIMER(13),	// SPVT用
  RC_GTK_ICC_TIMER(14),
  RC_GTK_VMC_TIMER(15),
  RC_GTK_SUICA_TIMER(16),	// 交通系電子マネー用
  RC_GTK_EDY_TIMER(17),	// Edy用
  RC_GTK_ID_TIMER(18),	// ID用
  RC_GTK_PITA_TIMER(19),	// Pitapa用
  RC_GTK_MST_TIMER(20),	// MST用
  RC_GTK_TRC_TIMER(21),
  RC_GTK_PSP_TIMER(22),
  RC_GTK_NIMOCA_TIMER(23),
  RC_GTK_COGCA_TIMER(24),

  RC_GTK_FSELF_TIMER(25),		// スマイルセルフ用
  RC_GTK_SPRC_TIMER(26),
  RC_GTK_CONTENT_TIMER(27),		// スマイルセルフ背面の広告部分用
  RC_GTK_ACB_CINSTOP_TIMER(28),	// スマイルセルフ常時入金仕様用
  RC_GTK_LED_AFTER_TIMER(29),		// スマイルセルフLED用


  RC_SG_SCAN_ENABLE_TIMER(30),	// セルフ: スキャンEnable Disenble切替用
  RC_SG_POP_DOWN_TIMER(31),		// セルフ: お金をお取りくださいダイアログ用

  //	RC_SG_DCT_TIMER(),
  //	RC_SG_BZ_TIMER(),
  //	RC_SG_SND_TIMER(),
  RC_SG_STAFF_CALL_TIMER(32),	// セルフ : 店員呼出用

  RC_AUTO_TRAN_TIMER(33),	// 自動精算用
  RC_CASH_RECYCLE_TIMER(34),	// キャッシュリサイクル用
  RC_USBCAM_TIMER(35),	// USBカメラ仕様用
  RC_GTK_WIZ_TIMER(36),	// Wiz用
  RC_GTK_CUSTOMER_TIMER(37),	// カスタマーカード用

  RC_GTK_STAFF_PRC_TIMER(38),		// 社員売価キー用
  RC_DISH_SYSTEM_TIMER(39),		// 皿勘定キー用
  RC_INOUT_AUTO_EXE_TIMER(40),	// 入出金画面用
  RC_INOUT_COUT_TIMER(41),		// 入出金画面 : 払出用
  RC_2PERSON_TIMER(42),		// ２人制キー用
  RC_2PERSON_MSG_TIMER(43),		// ２人制キーダイアログ用
  RC_DELIVERY_SERVICE_TIMER(44),	// 宅配発行キー用
  RC_CHG_TRAN_TIMER(45),		// 入出金確認キー用
  RC_MBR_PRC_TIMER(46),		// 会員売価キー用
  RC_MANUAL_DLG_TIMER(47),		// 手動ミックスマッチキー用
  RC_CHG_POWER_TIMER(48),		// 釣機ON/OFFキー用
  RC_MBR_PLU_DLG_TIMER(49),		// 割戻ポップアップ用 : 商品登録時に表示する
  RC_MBR_TEL_WAIT_TIMER(50),		// 電話番号ダイアログ用
  RC_MBR_TICKET_TIMER(51),		// チケット発行キー用
  RC_MBR_CUSTREALSVR_TIMER(52),	// リアル顧客問い合わせ用
  RC_MBR_CUSTREALSVR_2_TIMER(53),	// リアル顧客2問い合わせ用
  RC_NEC_CUSTREALSVR_TIMER(54),	// NECリアル顧客問い合わせ用
  RC_CPN_PRINT_TIMER(55),		// お得機印字用
  RC_VESCA_TIMER(56),			// 端末接続時

  RC_MEDIA_CHK_TIMER(57),		// メディア情報用
  RC_ORDER_MODE_TIMER(58),		// 発注モード用
  RC_SLIP_MODE_TIMER(59),		// 業務モード用

  RC_FONT_CHG_TIMER(60),	// 2800での文字サイズ変換用
  RC_FORCE_STR_CLS_TIMER(61),		// 自動強制閉設監視用
  RC_DISP_KEYACT_TIMER(62),		// 画面描画後、キー処理する（キーステータス等、本来メインへ戻る時に行っている処理を通すためのタイマー）
  RC_CPN_PRN_DLG_TIMER(63),		// お得機印字中ダイアログ用
  RC_MBR_TELLST_TIMER(64),		// 電話番号検索時用

  RC_TIMER_MAX(65);		// タイマー管理番号の最大

  final int id;
  const RC_TIMER_LISTS(this.id);
}

/// 明細変更種類
/// 関連tprxソース: rc_mem.h - CHANGE_KIND
enum ChangeKind {
  CHG_KIND_NORMAL,	//税変換　免税区分変更
  CHG_KIND_TAXITM,	//課税対象
  CHG_KIND_MAX,
}

// PLU登録後のポップアップメッセージの順番
/// 関連tprxソース: rc_mem.h - PLUDLG_CHK_STEP
enum PluDlgChkStep {
  PLUDLG_STEP_START,		// ポップアップ表示の開始
  PLUDLG_STEP_TGTMSG_END,		// ターゲットメッセージ終了状態
  PLUDLG_STEP_POPMSG_END,		// 商品マスタのポップアップメッセージ終了状態
  PLUDLG_STEP_ALERT_END,		// 商品マスタの警告フラグメッセージ終了状態
  PLUDLG_STEP_DRUGMSG_END,	// 第1類メッセージ終了状態
  PLUDLG_STEP_LOYLIMITOVER_END,	// ロイヤリティ制限個数超過登録メッセージ終了状態
  PLUDLG_STEP_LOYREGOVER_END,	// ロイヤリティオーバーエラーメッセージ終了状態
  PLUDLG_STEP_ORDER_ITEM_END,	// 発注モードポップアップ終了状態
  PLUDLG_STEP_RBTMSG_END,		// 割戻メッセージ表示終了状態
  PLUDLG_STEP_ONELIMIT_MIX_END,	// 一個限り確認メッセージ終了状態
  PLUDLG_STEP_FSELF_MBRREAD_END,	// 対面セルフ会員読込終了状態
}

// PLU登録タイプ
/// 関連tprxソース: rc_mem.h - PLUDLG_ITEM_TYPE
enum PluDlgItemType {
  PLUDLG_ITEM_NONE,	// 無し(引き継ぎ)
  PLUDLG_ITEM_PLU,	// PLU登録
  PLUDLG_ITEM_CLS,	// 分類登録
}

/// 顧客用メッセージの順番
/// 関連tprxソース: rc_mem.h - enum MBRDLG_CHK_ORDER
enum MbrDlgChkOrder {
  MBRDLG_ORDER_BEFORE_WAIT,	// 1番初めの状態  会員と同時処理しなければいけない別タスク（プリカ等）の処理を待ちます
  MBRDLG_ORDER_CPNMSG,		// クーポンメッセージ表示
  MBRDLG_ORDER_CUST_BMP,		// 声かけ画面表示
  MBRDLG_ORDER_CMPLNTMSG,		// クレーム／注意メッセージ表示
  MBRDLG_ORDER_BUYHIST, 		// 購買履歴画面
  MBRDLG_ORDER_TGTMSG,		// ターゲットメッセージ表示
  MBRDLG_ORDER_LOYLIMITOVER,	// ロイヤリティ制限個数超過登録メッセージ表示
  MBRDLG_ORDER_LOYREGOVER,	// ロイヤリティオーバーエラーメッセージ表示
  MBRDLG_ORDER_FANFARE,		// ファンファーレ表示
}

/// 関連tprxソース: rc_mem.h - DLG_PARAM
class RcMemDlgParam {
  int erCode = 0;
  /* not use                     */
  int dialogPtn = 0;
  /* dialog pattern              */
  /*  0:non                      */
  /*  1:normal                   */
  /*  2:entry                    */
  /*  3:entry password           */
  TitlInfo titlInfo = TitlInfo();
  BotnInfo botnInfo = BotnInfo();
  ConfInfo confInfo = ConfInfo();
  MesgInfo mesgInfo = MesgInfo();
  int opsFlg = 0;
  /* Opposite side msg flg       */
  /*  0:"只今処理中…"           */
  /*  1:変更しない               */
  int userCode1 = 0;
  /* not use                     */
  int userCode2 = 0;
  /* not use                     */
  int userCode3 = 0;
  /* not use                     */
  int inputMax = 0;
  /* input max when dialog_ptn = 2 */
}

/// Common Popup Window Datas for FB2GTK
/// 関連tprxソース: rc_mem.h - TITL_INFO
class TitlInfo {
  String title = '';
  /* title message               */
  String titleColor = '';
  String charColor = '';
}

/// 関連tprxソース: rc_mem.h - BOTN_INFO
class BotnInfo {
  Function? func;
  /* button callback             */
  String msg = '';
  /* button image                */
  String btnColor = '';
  String charColor = '';
  String gifFile = '';
  /* gif file name               */
  int showHideCtrl = 0;
}

/// 関連tprxソース: rc_mem.h - CONF_INFO
class ConfInfo {
  Function? func;
  /* button callback             */
  String msg = '';
  /* button image                */
  String btnColor = '';
  String charColor = '';
  int btnSiz = 0;
  /* BigBtn表示(conf_info[0]～[2]まで有効。表示エリアの問題で BigBtnにすることで上下２段のボタン表示ができなくなるため。)
                                                ボタンを４個以上作成する条件では重なる可能性があるためBig指定でも標準サイズでの表示となります。 */
}

/// 関連tprxソース: rc_mem.h - MESG_INFO
class MesgInfo {
  String msg = '';
  /* message                     */
  String charColor = '';
}
