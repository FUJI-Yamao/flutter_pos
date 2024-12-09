/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/apl/rx_cnt_list.dart';

import 'rxmemreason.dart';

// TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
///関連tprxソース:rxmemprn.h - PRNTER_CONTROL_TYPE_IDX構造体
enum PrnterControlTypeIdx {
  TYPE_RCPT,          /* レシート       */
  TYPE_RPR,               /* 再発行         */
  TYPE_CNCL,              /* 取消           */
  TYPE_RFM1,              /* 領収書発行(金額入力)    */
  TYPE_RFM2,              /* 領収書発行(取引)        */
  TYPE_CIN,               /* 入金           */
  TYPE_OUT,               /* 出金           */
  TYPE_LOAN,              /* 釣準備         */
  TYPE_PICK,              /* 売上回収       */
  TYPE_DRW,               /* 両替           */
  TYPE_FEED,              /* フィード       */
  TYPE_COUT,              /* 釣銭支払       */
  TYPE_CCHG,              /* 釣銭両替       */
  TYPE_SUS,               /* 仮締合計       */
  TYPE_RES,               /* 前金合計       */
  TYPE_RFM10,             /* not use  */
  TYPE_RFM11,             /* not use  */
  TYPE_RFM12,             /* not use  */
  TYPE_RFM20,             /* not use  */
  TYPE_RFM21,             /* not use  */
  TYPE_RFM22,             /* not use  */
  TYPE_ADD,               /* 買上追加       */
  TYPE_EVOID,             /* 一括訂正       */
  TYPE_EREF,              /* 検索返品       */
  TYPE_ERPR,              /* 検索レシート   */
  TYPE_DELIV_RCT,         /* レシート控え   */
  TYPE_CLOSE,             /* クローズ       */
  TYPE_POSTTEND,
  TYPE_TCKTISSU,          /* チケット発行   */
  TYPE_OTHER,             /* 登録以外 */
  TYPE_WRTY,              /* 保証書  */
  TYPE_DETAIL,            /* 明細印字  */
  TYPE_MENTE,             /* メンテナンス関連  */
  TYPE_STPR_RPR,          /* 伝票発行 */
  TYPE_STPR_FEED,         /* 伝票フィード */
  TYPE_STPR_TEST,         /* 伝票テスト */
  TYPE_VMCERR,            /* ﾋﾞｽﾏｯｸｴﾗ- */
  TYPE_ESVOID,            /* 検索訂正 */
  TYPE_DRWCHK,            /* 差異チェック */
  TYPE_ACXUPLOG,          /*釣銭実績ｱｯﾌﾟﾃﾞｰﾄ */
  TYPE_CLSCNCL,           /* 分類解除 */
  TYPE_CALC,              /* 計算     */
  TYPE_ERCTFM,            /* 検索領収書 */
  TYPE_TWNOSET,           /* 統一發票設定 TWNO_S2PR */
  TYPE_TWNOSR,            /* 統一發票廃棄 TWNO_S2PR */
  TYPE_MCNEW,             /* カード更新 */
  TYPE_MCALC,             /* 割振計算 */
  TYPE_CASHINT,           /* 割込予約 */
  TYPE_SCNCHK,            /* 売価チェック */
  TYPE_MMINQ,             /* 顧客情報照会 */
  TYPE_CARDCHG,           /* カード切替 */
  TYPE_CRDTVOID,          /* クレジット訂正 */
  TYPE_PRECAVOID,         /* プリカ訂正 */
  TYPE_ESVOID2,           /* 検索訂正(訂正実績) */
  TYPE_POST,              /* ポストテンダリング */
  TYPE_PMEMO,		/* 連絡確認 */
  TYPE_CMEMO,		/* 釣銭要求 */
  TYPE_GODUTCH,		/* 割勘額表示 */
  TYPE_RPRSUS,            /* 仮締レシート再発行 */
  TYPE_EDY_ALARM,         /* Ｅｄｙアラーム発行 */
  TYPE_CCIN,              /* 釣機入金 */
  TYPE_MENU,              /* メニュー       */
  TYPE_ICNML,             /* Suica 処理未了取引印字     */
  TYPE_ICABNML,           /* Suica 障害取引印字 */
  TYPE_CHGPICK,           /* 釣機回収       */
  TYPE_SPCNCL,            /* スプリット取消 */
  TYPE_CHGREF,            /* 釣機参照 */
  TYPE_STRDRW,            /* 閉設：在高報告 */
  TYPE_RRATE,             /* レシート倍率 */
  TYPE_PMOV,              /* ポイント移行 */
  TYPE_PRCLBL,            /* 値付けラベル */
  TYPE_MP1_EJ,            /* 値付けプリンタ電子ジャーナル */
  TYPE_PRCLBL_NOITEM,     /* 値付け未登録商品 */
  TYPE_CARRY,             /* 積載指示書 */
  TYPE_WIZNONFILE,        /* ノンファイル */
  TYPE_SPVT_ALARM,        /* Smartplus/Visa Touch アラーム */
  TYPE_LOAN_CCIN,         /* 釣準備  釣機入金    */
  TYPE_LOAN_CSTOCK,        /* 釣準備  釣機在高    */
  TYPE_ICNML_SUICA,       /* Suica 処理未了不明取引印字     */
  TYPE_ICNML_WAON,        /* WAON 処理未了不明取引印字     */
  TYPE_WAON_HISTORY,      /* WAON履歴印字     */
  TYPE_SUICA_HISTORY,     /* Suica履歴印字    */
  TYPE_ID_HISTORY,        /* iD履歴印字       */
  TYPE_RESERV,            /* 予約印字         */
  TYPE_RESERVCNCL,        /* 予約取消印字     */
  TYPE_RPRRESERV,         /* 再予約印字       */
  TYPE_EDY_HISTORY,       /* Ｅｄｙ履歴印字   */
  TYPE_POINT_SHIFT,       /* ポイント移行     */
  TYPE_EJONLYRCPT,        /* 実績無しレシート */
  TYPE_REREGCNCL,         /* 再売り取消       */
  TYPE_NOTEJRCPT,         /* */
  TYPE_QC_TCKT,           /* お買い物券(ＱＲ) */
  TYPE_INOUT_EVOID,       /* 入出金違算       */
  TYPE_PBCHGSEQNO,        /* */
  TYPE_QC_DATA,           /* ＱＲデータ */
  TYPE_QC_TCKT_RPR,       /* 再発行お買い物券(ＱＲ) */
  TYPE_INTERRUPT,         /* 取引中断   */
  TYPE_QC_CHG,            /* お釣りレシート */
  TYPE_RPRRSVCIN,          /* 再内金入金印字 */
  TYPE_RPRRSVOUT,         /* 再内金支払印字 */
  TYPE_CHGDRW,		/* 棒金開 */
  TYPE_QC_VOID,		/* お釣りレシート訂正 */
  TYPE_QC_VOIDDATA,	/* お釣りレシート訂正データ */
  TYPE_OFF_MODE,		/* 休止 */
  TYPE_CSHR_OPEN,		/* キャッシャーオープン */
  TYPE_CHGTRAN,		/* 入出金確認       */
  TYPE_QC_CUSTOMER,	/* カスタマーカード時のお会計券       */
  TYPE_QC_CUSTINFO,	/* お会計券リード時の顧客情報       */
  TYPE_REQUEST_DRW,	/* 両替依頼書発行       */
  TYPE_CASHRECYCLE_OUT,   /* キャッシュリサイクル：出金->入金指示 */
  TYPE_CASHRECYCLE_IN,    /* キャッシュリサイクル：入金           */
  TYPE_ALL_REFUND,        /* 全返品 */
  TYPE_ALL_REFUND_RPR,    /* 全返品再発行 */
  TYPE_TRAN_REFUND,       /* 取引データあり返品 */
  TYPE_TRAN_REFUND_RPR,   /* 取引データあり返品再発行 */
  TYPE_MANUAL_REFUND,     /* 手動返品 */
  TYPE_MANUAL_REFUND_RPR, /* 手動返品再発行 */
  TYPE_CSHR_CLOSE,	/* キャッシャークローズ */
  TYPE_QC_COMERR,		/* お会計券リード時の通信エラーレシート */
  TYPE_SELECT_COUT,       /* 金種別の払出設定の釣機払出 */
  TYPE_MBRPRN,       /* 会員印字の項目変更 */
  TYPE_CHGPICK_RESERV,    /* 釣機回収（残置不足情報） */
  TYPE_CIN_NONADD,	/* 入金(実績＆在高非可算) */
  TYPE_OUT_NONADD,	/* 出金(実績＆在高非可算) */
  TYPE_CHGCHK_IN,		/* 釣機戻入（戻入結果） */
  TYPE_CHGCHK_PICK,	/* 釣機戻入（回収結果） */
  TYPE_CHGCHK_PICK_IN,	/* 釣機戻入（回収戻入結果） */
  TYPE_CHG_MENTEOUT,      /* 取引外払出 */
  TYPE_DRWCHK_CASH,       /* 手持現金入力 */
  TYPE_REPICA_MAINTE,	/* レピカ仕様 カード保守 */
  TYPE_REG_CHK,		/* レジ点検 */
  TYPE_KITCHEN,		/* キッチンプリンタ */
  TYPE_REG_CHK_NG,	/* レジ点検失敗 */
  TYPE_CHGREF_IN,		/* 釣機参照 */
  TYPE_AYAHA_IMMPROM,	/* アヤハディオ即時プロモーション発行 */
  TYPE_DELIVERY_SERVICE,	/* 宅配発行 */
  TYPE_ZHQ_COUPON,	/* 全日食クーポン */
  TYPE_PORTAL_CONF,	/* 認証キーによる発行 */
  TYPE_STRCLS_INFO,	/* 精算情報 */
  TYPE_CLOSE_PICK_ENDLOG,	/* 従業員精算処理終了 */
  TYPE_VESCA_RPR,		/* Verifone再印字 */
  TYPE_RCPT_VOID,		/* 通番訂正 */
  TYPE_RCPT_VOID_RPR,	/* 通番訂正再発行 */
  TYPE_RFM_RPR,           /* 領収書再発行 */
  TYPE_MBRSVCTK,		/* 割戻チケットのみ印字 */
  TYPE_PASSPORTINFO_RCT,	/* 免税記録票・誓約書 */
  TYPE_PRCCHK_CERT,	/* 証書印字（価格確認） */
  TYPE_DRWCHK_MENTECIN,	/* 釣機入金（差異チェック） */
  TYPE_MCARD_CHG,		/* 特定DS2仕様 カード切替 */
  TYPE_MCARD_CHG_RPR,	/* 特定DS2仕様 カード切替(再発行) */
  TYPE_RCPT_VOID_REF,	/* 通番訂正返金 */
  TYPE_MBR_UNLOCK,	/* 会員情報ロック解除 */
  TYPE_VESCA_EDY,		/* Verifone Edy印字（支払い毎） */
  TYPE_OVERFLOW_PICK,	/* オーバーフロー回収 */
  TYPE_OVERFLOW_MOVE,	/* ｵｰﾊﾞｰﾌﾛｰ庫移動 */
  TYPE_OVERFLOW_MENTE,	/* ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ */
  TYPE_EC_OMNI_RECV,	/* 店舗受取（ワールドスポーツ様） */
  TYPE_EC_OMNI_RECV_RPR,	/* 店舗受取（ワールドスポーツ様）（再発行） */
  TYPE_MBR_JOIN_RPR,	/* 会員統合（ワールドスポーツ様） */
  TYPE_WS_CPN_REISSUE,	/* クーポン再発行（ワールドスポーツ様） */
  TYPE_DPOINT_MODIFY,	/* dポイント修正 */
  TYPE_EC_OMNI_CANCEL,	/* EC注文キャンセル（ワールドスポーツ様） */
  TYPE_EC_OMNI_FREE_RECEIPT,	/* EC受領書（ワールドスポーツ様） */
  TYPE_BCDPAY_ERR_PRT,	/* バーコード決済 障害レシート印字 */
  TYPE_PRCERR_PRT,	/* プリカ 障害取引印字 */
  TYPE_REPICAPNT_MODIFY,	/* プリカポイント訂正 */
  TYPE_MODE_CHG,		/* モード切替実績 */
  TYPE_SAG_API_RESULT,	/* Shop&GoAPIの結果 */
  TYPE_TOMOINQ,		/* 友の会残高照会 */
  TYPE_CNCT_INFO,		/* 接続情報 */
  TYPE_HOW_TO_SERVE,	/* おいしい召し上がり方 */
  TYPE_TR_START,		/* 訓練モード開始 */
  TYPE_TR_END,		/* 訓練モード終了 */
  TYPE_ACXINFO,		/* フレスタ様　釣銭情報 */
  TYPE_OZEKI_CASHBACK,	/* オオゼキ_キャッシュバック */

/* ここに追加した場合は、05_POS_ログ.xlsx の 印字種類一覧シートに追記してください */
}

///関連tprxソース:rxmemprn.h - WIZ_QRDATA構造体
class WizQrData {
  int tranStat = 0;            /* 取引状態         */
  int tranErr = 0;             /* エラー状態       */
  String errPluCd = "";       /* エラー商品コード */
  int errPluCnt = 0;          /* エラー商品数     */
  String wizNo = "";           /* Wiz端末番号      */
  String saleDatetime = "";    /* Wiz取引日時      */
  int wizTtlAmt = 0;          /* Wizお買上げ額    */
  int wizPayAmt = 0;          /* Wizお支払い額    */
  int wizChaPayAmt = 0;      /* Wizお支払い額    */
}

class RepicaPntErr {
  String cardType = ""; // カード種別
  int repicaErrFlg = 0; // ポイント加算1エラーフラグ
  int repicaErrFlg2 = 0; // ポイント減算エラーフラグ
  int repicaTargetPrice = 0; // ポイント対象額
  int pointSub = 0; // ポイント処理
  int repicaPntInquFlag = 0; // 通信済みフラグ
}
const int nameSize = 128+1;

///関連tprxソース:rxmemprn.h - REFLISTPRN
class RefListPrn {
  int	fncCd = 0;
  int refLstItmPrn = 0;
  int	refListSelNo = 0;		/* 返品理由選択番号 */
  int	receiptNo = 0;		/* レシート番号   */
  int	printNo = 0;		/* ジャーナル番号 */
  int macNo = 0;
  String nowSaleDatetime = '';	/* 日時           */
  int	chkrNo = 0;		/* チェッカーNO   */
  String chkrName = '';
  int	cshrNo = 0;                /* キャッシャーNO */
  String cshrName = '';
  int customerReciptSkip = 0;
  EsVoidItm esVoidItm = EsVoidItm();
  int	refListKind = 0;		/* 返品理由種別     */
}

///関連tprxソース:rxmemprn.h - ESVOIDITM
class EsVoidItm {
int flg = 0;
int qty = 0;
int prc = 0;
int lrgClsCd = 0;            /* large class code */
int mdlClsCd = 0;            /* middle class code */
int smlClsCd = 0;            /* small class code */
int tnyClsCd = 0;            /* tiny class code */
String posName = '';         /* pos name */
}

/// 関連tprxソース:rxmemprn.h - struct CASHRECYCLE
class CashRecycle {
  int chgout_amt = 0;		/* 両替出金金額 */
  int office_amt = 0;		/* 事務所指示金額 */
  List<int> in_diff = List<int>.filled(10, 0); 		/* 入金差異枚数 */
  String barcode = ""; // 再入金キャッシュリサイクルバーコード
}

/// 関連tprxソース:rxmemprn.h - struct PASSPORT_DATA
class PassportData {
  int	inpFlg = 0;	/* 0x01:記録票　0x02:誓約書 */
  List<String> typeJp = List.filled(nameSize, "");
  List<String> typeEx = List.filled(nameSize, "");
  List<String> number = List.filled(20+1, "");
  List<String> name =  List.filled(39+1, "");
  List<String> birthday = List.filled(8+1, "");
  List<String> country = List.filled(10+1, "");
  List<String> residenJp = List.filled(nameSize, "");
  List<String> residenEx = List.filled(nameSize, "");
  List<String> land = List.filled(8+1, "");
  List<String> purchaseDay = List.filled(8+1, "");
  List<String> addName = List.filled(5+1, "");
  List<String> sex = List.filled(1+1, "");
  List<String> purchaseTime = List.filled(30, "");
}

/// 関連tprxソース:rxmemprn.h - struct CRDTVOID_PRN
class CrdtVoidPrn {
  int macNo = 0;  /* 登録レジNo */
  int receiptNo = 0;  /* 登録レシートNo */
  int printNo = 0;  /* 登録ジャーナルNo */
  int voidMacNo = 0;  /* 訂正レジNo */
  int voidReceiptNo = 0;  /* 訂正レシートNo */
  int voidPrintNo = 0;  /* 訂正ジャーナルNo */
}

/// 関連tprxソース:rxmemprn.h - struct CPNCONTENT
class CpnContent {
  String name = "";    /* 商品名 */
  String limit = "";    /* 個数 */
  String amt = "";    /* ポイント・値段 */
  String jan = "";    /* JAN */
}

/// 関連tprxソース:rxmemprn.h - struct CPNCONTENT_STD
class CpnContentStd {
  String titleBuf = "";
  String effPeriod = "";
  String itemInfo = "";
  String promName = "";
  String msgData1 = "";
  String msgData2 = "";
  String msgData3 = "";
  String msgData4 = "";
  String barcode = "";
  int bmpWkFlg = 0;
  int ttlSizeFlg = 0;
  int msgSizeFlg = 0;
  int rctLogoFlg = 0;
  int mbrNoFlg = 0;
  int mbrNameFlg = 0;
  int bcdFlg = 0;
  int beniyaFlg = 0;
  int kirinyaFlg = 0;
}

/// クーポン情報
/// 関連tprxソース:rxmemprn.h - struct RXMEMCPNPRN
class RxMemCpnPrn {
  String custNo = "";  /* 会員番号 */
  String cpnId = "";  /* クーポンＩＤ */
  List<String> cpnData = List.filled(30, "");  /* 商品データ */
  String prnStreName = "";    /* 印字店舗名称 */
  String prnTime = "";    /* 印字期間 */
  String templateId = "";    /* テンプレートＩＤ */
  String pictPath = "";    /* 画像パス */
  String notes = "";    /* 注釈など */
  List<CpnContent> cpnContent = List.filled(30, CpnContent());		/* 印字内容 */
  int cpnContentCnt = 0;    /* 印字内容数 */
  String instreFlg = "";    /* インストアマーキング */
  CpnContentStd cpnContenStd = CpnContentStd();    // 標準クーポン印字内容
}

/// ワールドスポーツ様 クーポンバーコード利用情報詳細
/// 関連tprxソース:rxmemprn.h - struct RXMEMPRNWSCPNUSEINFO
class RxMemPrnWsCpnUseInfo {
  int cpnbarTyp = 0;		// 企画種別
  int cpnbarMny = 0;		// 券面金額
  int cpnbarCd = 0;		// 企画コード
  int cpnbarNum = 0;		// まとめ枚数
  int cpnItmcnt = 0;		// 特別価格クーポン使用時、直前のアイテムログカウント数を保持する関数
  int fEnable = 0;		// 有効フラグ（TRUE:有効、FALSE：無効）
}

/// ワールドスポーツ様：クーポン利用情報
/// 関連tprxソース:rxmemprn.h - struct RXMEMPRNWSCPNUSE
class RxMemPrnWsCpnUse {
  int count = 0; // 登録件数
  int cpnDscPrc = 0; // 値引クーポン複数利用時に直前の値引額を保持する
  int cpnPntAdd = 0; // ポイント付与クーポン使用時、ポイントを加算する関数
  int cpnPntMag = 0; // 倍率ポイントクーポン使用時、ポイントを加算する関数
  int cpnPmPer = 0; // 割引クーポン複数利用時に高い割引率を保持する
  List<RxMemPrnWsCpnUseInfo> cpnInfo = List.filled(
      RxMemPrn.WSCPNUSE_MAX, RxMemPrnWsCpnUseInfo()); // クーポン単位の情報
}

/// 関連tprxソース:rxmemprn.h - struct MARUSYO_MBRCALLSVCTK
class MarusyoMbrCallSvctk {
  int mbrcallSvctkFlg = 0;  // 会員呼出時に割戻ポイントを保持したかどうかの判定フラグ
  int dtipTtlsrv = 0;    // 会員呼出時のチケット発行ポイント
}

const vescaDataMax = 100;
const vescaLenMax = 90;
/// ベスカ決済の処理結果を抽出
/// 関連tprxソース:rxmemprn.h - struct VESCA_DTL
class VescaDtl {
  List<String> label = List.generate(vescaLenMax + 1, (_) => "");
  List<String> value = List.generate(vescaLenMax + 1, (_) => "");
}

class RxMemPrn {
  static const WSCPNUSE_MAX = 99;

  // TODO:00011 周 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  ///関連tprxソース:rxmemtmp.h - RXMEMPRN構造体
  String flightName = ""; //[300+1];
//EDY_ALM			edy_alm;
  int totalDrawchk = 0;
  int acrDrawchk = 0;
  int amtDrawchk = 0;
  int diffDrawchk = 0;
  int otherStoreMbr = 0;
  int calcTtlamt = 0;
  int calcAmt = 0;
  int calcChgamt = 0;
  int erctfmMacNo = 0;      /* reference machine no */
  int erctfmReceiptNo = 0;  /* reference receipt no */
  int erctfmPrintNo = 0;    /* reference journal no */
  int iTmpDscDiffAmt = 0;
  String cashintflg = "";
  int spdClearTpnt = 0;
  int spdWriteStat = 0;
  int spdLastStreNo = 0;
  String spdLastIssueDate  = ""; // [6];
  String spd_refixDate  = ""; // [6];
  String chequeNo  = ""; // [8];
  int chequeSptendCnt = 0;
  int godutchTtlamt = 0;
  int godutchPeople = 0;
  int godutchInamt = 0;
  String multisusflname  = ""; // [128];
  int susttlamt = 0;
  int oldFspLvl = 0;
  String suicaId = "";
  String suicaRwId = "";
  int suicaNgPrn = 0;
  String mybagPointFlg  = "";
  int remainderAmt = 0;
  int miketuFlg = 0;
  String updFname  = ""; // [128];
  int deliv_rctNo = 0;
  int homeDelivNo = 0;
  int nextFspLvl = 0;
  int card1timeAmt = 0;
  int chgInoutAmt = 0;
//MP1_PRN mp1Prn;
  int rprFlg = 0;
  SpvtAlm spvtAlm = SpvtAlm();
  String mediaLimit_yy  = ""; // [2+1];
  String mediaLimitMm  = ""; // [2+1];
//EDYHIST edy_hist[6];
  String felicaOtherCustNo  = ""; // [8];
  int felicaOtherAnyprcTermMny = 0;
  int oldAdvanceMoney = 0;
  int qctcktQty = 0;		/* 復活させた */
  int qctcktTtlamt = 0;		/* 復活させた */
  String hcrdtName  = ""; // [36];
  List<int> useLmtAmt = List<int>.generate(10, (index) => 0); // [10];
  String dpsLmtDate  = ""; // [8];
  int qc_rfm_rcptFlg = 0;	/* 領収書発行済みレシート */
  int reservCustnonPrn = 0;
  int outadvanceMoney = 0;
  late WizQrData wizQrData = WizQrData();
  int mlyPrice = 0;
  String now_rankName  = ""; // [40+1];
  double stopStart = 0;		/* 休止時間 */
  int interruptPrice = 0;
  int	specType = 0;
  int qcSelectMsg = 0;
  int	cardStopKind = 0;
  String chkrOffmodeStart  = ""; // [20];
  String chkrOffmode_end  = ""; // [20];
  String cshrOffmodeStart  = ""; // [20];
  String cshrOffmode_end  = ""; // [20];
  String cctSuicaFlg = "";
  String slip_reasonName  = ""; // [REASON_NAME_LEN];
  int rcpCnt = 0;
  int rcpAmt = 0;
  int rprServFlg = 0;
  int syncSetNum = 0;
  RefListPrn refList = RefListPrn();
  int qcReciptPrn = 0;
  int opeStaffCd = 0;
  String opeStaffName = "";
  int divadjCrdtAmt1 = 0;
  int divadjCrdtAmt2 = 0;
  int divadjCrdtAmt3 = 0;
  int divadjCrdtAmt4 = 0;
  int divadjCrdtAmt5 = 0;
  String firstQc_readTime  = ""; // [8+1];
  String secondQc_readTime  = ""; // [8+1];
  int chargeSlipFlg = 0;	/* 売掛会員フラグ 0:売掛会員ではない 1:売掛会員である */
  String mltsuicaNumber = "";
  String mltsuicaSeqNo = "";
  CashRecycle crinfo = CashRecycle();
  int suicaNgAmt = 0;
  int officeDrwchg = 0;
//SUICA_ALM suicaAlm;
  List<int> taxfreePrnSelect = List.generate(6, (index) => 0); // [6];
//SPZ_READ_TYPE spz_readType;
  int tmpDpntTtlsrv = 0;
  int tmpDcauMspur = 0;
  List<String> marutoCdmsg = List.generate(4, (index) => ""); // [4][64+1];	/* マルト様レシートメッセージスケジュールマスタのメッセージコードのメッセージ */
//AYAHA_PROM		ayahaProm[8];
//TPOINT_PRN		tpointPrn;
//CHARGE_SLIP_PRNDATA	charge_slipPrndata;		/* 売掛伝票印字　しない・するの印字データフラグ */
  int trm_slipno = 0;		/* Y端末 端末伝票番号 */
  int speezaQrPrintFlg = 0;	/* QR印字フラグ 0:1次元 1:2次元(QR) */
  List<RxMemCpnPrn> cpnPrnBuf = List.filled(RxCntList.OTH_PROM_MAX, RxMemCpnPrn());
  int cpnCnt = 0;		/* 印字内容数 */
  int ttlTax = 0;		/*領収書税額*/
  int inTax = 0;			/*領収書内税額*/
//msg_mstData		msgPortalConf[3];	/* 認証キー印字 */
//RestPromParam		restPromParam[REST_PROM_MAX];	/* 残権利情報 */
  int orgPrnTyp = 0;            /* 元レシート印字種類 */
  int vescaReceiptCnt = 0;
  List<VescaDtl> vescaDtl = List.filled(vescaDataMax, VescaDtl());
//   StlDscTmpParam		tmp_bnsdsc;	// ボーナス値引一時情報
//   StlDscTmpParam		tmp_rbtdsc;	// ポイント還元一時情報
  int	qcRprItemPrn = 0;		// QC指定の場合の再発行にて登録商品の印字 0:しない　1:する
  String custNo  = ""; // [21];
  int vescaDtlRowId = 0;
  int vescaDtl1RowId = 0;
  int vescaDtl2RowId = 0;
  int vescaDtl3RowId = 0;
  int vescaDtl4RowId = 0;
  int vescaDtl5RowId = 0;
  int checkVescaReceiptEnd = 0;
  int vescaQcSign = 0;
  int refPrintNo = 0;  /* 検索返品ジャーナル番号 */
// //	NSW_FMT			nswFmt;		/* NSWデータ連携レシートフォーマット */
  int rfmPrintNo = 0;         /* 領収書ジャーナル番号 */
//   #if SS_CR2
//   String cr40FilePath = ""; //[TPRMAXPATHLEN];	/* CR4.0のリードファイル名  */
//   String qcReadTimeCR40 = ""; // [12+1];            /* お買い物券 発行時刻   */
//   int cr2ReadMacNo = 0;		/* 特定CR2接続仕様 登録機レジ番号 */
//   int cr2ReadKubun = 0;			/* 特定CR2接続仕様 登録機区分 */
//   int cr2BarType = 0;			/* 特定CR2接続仕様 バーコード印字タイプ */
//   NSW_FMT nswFmt = NSW_FMT();			/* NSWデータ連携レシートフォーマット */
//   #endif
  MarusyoMbrCallSvctk	mbrCallSvctk = MarusyoMbrCallSvctk();		/* 会員呼出～締め処理までに、ポイント変動が行われたかの判定 */
  int tran_mode = 0;			// 取引中のモード
  late PassportData passportData = PassportData();
  RxMemStfRelease stfRelease = RxMemStfRelease();	// 従業員権限解除
//   GODAI_CUST_CARDCHG	custCardChg;
  int clinicReceiptFlg = 0;		/* HappySelfクリニックモードレシート印字設定 */
  int vescaCashFlg = 0;			//Verifone連動予約取消現金返却フラグ
  int vesca_edyFlg = 0;			//Verifone edy支払い毎印字フラグ
  int vesca_edyCnt = 0;			//Verifone edy支払い毎印字枚数
  int	orgType_vesca = 0;			// 元、印字の種類<Verifone用>
  RxMemReason reason = RxMemReason();			// 理由選択
//   RXMEMPRNWS		wscpnbuf;	// ワールドスポーツ様対応用
  int overflowMenteType = 0;		// ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ処理種類
  int overflow_recalcOver = 0;		// ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ精査収納オーバーフラグ
//   RXMEMPRNCUSTPIINFO	custPointInfinity;	// 顧客リアルPI情報
  String dPointCardNo = "";
  String barcodepay_err  = ""; // [51];	// barcodepay err message
  String barcodepayName  = ""; // [51];	// barcodepay issua name
//   UNKNOWN_PRN		unknownPrn;
  RxMemPrnWsCpnUse wsCpnUse = RxMemPrnWsCpnUse();	// クーポン利用情報
  AjsEmoneyPrn ajsEmoneyPrn = AjsEmoneyPrn();		/* AJSマネー 印字データ */
  int dpntTtlsrv_buf = 0;		// 本日ポイントバッファ
  List<String> msgData = List.generate(CntList.itemMax, (index) => ""); // 商品メッセージ印字用バッファ((32*3+1)*10(10行目は改行はない))  [ITEM_MAX][970];
//   REPICA_PNT	repicaPnt;		// レピカポイント情報印字
  late RepicaPntErr repicaPntErr = RepicaPntErr(); // レピカポイントエラー
  int sagAplDlQrPrnFlg = 0;
  int precaCardnumMaskFlg = 0;		/* プリペイド番号のマスクフラグ */
  int precaCardnumMaskDigit = 0;	/* プリペイド番号のマスク桁数 */
  String mltsuicaDatetime = ""; // 交通系IC取引日時
  int mltsuicaIcNo = 0; // 交通系IC取引通番
  String nimocaDatetime  = ""; // [20];            /* NIMOCA 一件明細作成日時 */
  String nimoca_rwId  = ""; // [13+1];             /* NIMOCA 物販端末RWコード */
  int nimocaIcNo = 0;                   /* NIMOCA IC取引通番 */
  int preca_balPrintFlg = 0;		// プリカ会計キー未使用時の残高情報印字フラグ
  int coupon_rprFlg = 0;			// クーポン再発行フラグ
//RXMEMPRNTOMO		tomoPrn;	// 友の会様対応用
  int vesca_rprFlg = 0;			// Verifone再印字キー押下実行フラグ
  int fg_sptckt_errFlg = 0;		// FG券利用通信時エラーフラグ
  List<MulprePrn> mulPreCard = List.generate(10, (index) => MulprePrn());// プリペイド複数枚利用情報 len[10];
//   STAMPCARD_PRNDATA	stpcd_buf[OTH_PROM_MAX];	// スタンプカード印字データ
  int banCashless = 0;			// ｷｬｯｼｭﾚｽ決済禁止キー 0：通常 1：現金決済のみ
  String centerOrderId  = ""; // [64+1];		// コード決済[QUIZ]仕様 決済事業者が発番する取引ID
  String gatewayOrderId  = ""; // [64+1];		// コード決済[QUIZ]仕様 決済サーバーが発番する取引ID
  String gateway_refundId  = ""; // [64+1];	// コード決済[QUIZ]仕様 決済サーバーが発番する返金ID
  int crdtvoidUpderrFlg = 0;  // クレ訂での実績ライトエラーフラグ
  CrdtVoidPrn crdtVoid = CrdtVoidPrn();  //クレ訂用 レシート印字
  int type = 0;  /* 印字の種類     */
  int receiptNo = 0;  /* 領収書連番     */
  int rpointVoidCnclFlg = 0;  /* Rポイント仕様　訂正時の顧客実績連動制御フラグ */
}

// TODO:00012 平野 checker関数実装のため、定義のみ追加
///関連tprxソース:rxmemprn.h - RXMEMPRN構造体
class RxMemPrn_2 {
//     int     type;           /* 印字の種類     */
//     short   receipt_no;     /* 領収書連番     */
//     int     amount;         /* 領収書金額     */
//     int     ttl_tax;        /* 税金合計       */
//     int     in_tax;         /* 内税金額       */
//     char    elog_date[31];  /* 電子ログ過去日付 */
//     long    card_kind;      /* クレジット種別＃ */
//     long    comp_code;      /* クレジット企業＃ */
//     char    card_name[21];  /* クレジット会社名 */
//     char    telno1[25];
//     short   sprit_cnt;
//     short   guarantee_no;     /* 保証書連番     */
//     char    flight_name[17];  /* フライト名 */
//     char    vmc_wterr;        /* ビスマック書き込みエラー */
//     char    anvkind_name1[ANVKIND_NAME]; /*記念日1名称/Anniversary 1 name*/
//     char    anvkind_name2[ANVKIND_NAME]; /*記念日2名称/Anniversary 2 name*/
//     char    anvkind_name3[ANVKIND_NAME]; /*記念日3名称/Anniversary 3 name*/
//     char    anvkind_name4[ANVKIND_NAME]; /*記念日4名称/Anniversary 4 name*/
//     char    anvkind_name5[ANVKIND_NAME]; /*記念日5名称/Anniversary 5 name*/
//     EDY_PRN edy_prn[10];                 /*10:SPTEND_BUFCNT   */
//     EDY_ALM edy_alm;                     /*Ｅｄｙアラーム発行 */
//     int     receipt_gp1_amt;             /*領収書発行金額 1   */
//     int     receipt_gp2_amt;             /*領収書発行金額 2   */
//     int     receipt_gp3_amt;             /*領収書発行金額 3   */
//     int     receipt_gp4_amt;             /*領収書発行金額 4   */
//     int     receipt_gp5_amt;             /*領収書発行金額 5   */
//     int     receipt_gp6_amt;             /*領収書発行金額 6   */
//     long    last_chg;                    /*検索訂正：前回釣額 */
//     long    rtn_chg;                     /*検索訂正：返金額   */
//     short   mny_10000_sht;               /*MoneyKind:10000Count   */
//     short   mny_5000_sht;                /*MoneyKind:5000Count    */
//     short   mny_2000_sht;                /*MoneyKind:2000Count    */
//     short   mny_1000_sht;                /*MoneyKind:1000Count    */
//     short   mny_500_sht;                 /*MoneyKind:500Count     */
//     short   mny_100_sht;                 /*MoneyKind:100Count     */
//     short   mny_50_sht;                  /*MoneyKind:50Count      */
//     short   mny_10_sht;                  /*MoneyKind:10Count      */
//     short   mny_5_sht;                   /*MoneyKind:5Count       */
//     short   mny_1_sht;                   /*MoneyKind:1Count       */
//     int     cha_drawchk_amt1;            /*DrawChk:CHA1_Amt       */
//     int     cha_drawchk_amt2;            /*DrawChk:CHA2_Amt       */
//     int     cha_drawchk_amt3;            /*DrawChk:CHA3_Amt       */
//     int     cha_drawchk_amt4;            /*DrawChk:CHA4_Amt       */
//     int     cha_drawchk_amt5;            /*DrawChk:CHA5_Amt       */
//     int     cha_drawchk_amt6;            /*DrawChk:CHA6_Amt       */
//     int     cha_drawchk_amt7;            /*DrawChk:CHA7_Amt       */
//     int     cha_drawchk_amt8;            /*DrawChk:CHA8_Amt       */
//     int     cha_drawchk_amt9;            /*DrawChk:CHA9_Amt       */
//     int     cha_drawchk_amt10;           /*DrawChk:CHA10_Amt      */
//     int     chk_drawchk_amt1;            /*DrawChk:CHK1_Amt       */
//     int     chk_drawchk_amt2;            /*DrawChk:CHK2_Amt       */
//     int     chk_drawchk_amt3;            /*DrawChk:CHK3_Amt       */
//     int     chk_drawchk_amt4;            /*DrawChk:CHK4_Amt       */
//     int     chk_drawchk_amt5;            /*DrawChk:CHK5_Amt       */
//     long    total_drawchk;               /*DrawChk:Draw_Amt       */
//     long    acr_drawchk;                 /*DrawChk:Acr_Amt        */
//     long    amt_drawchk;                 /*DrawChk:CashChaChk_Amt */
//     long    diff_drawchk;                /*DrawChk:DiffPrc_Amt    */
//     short   other_store_mbr;             /*他店会員   */
//long	bonuspoint;                  /* Bonus Point */
//     char    acr_coin_slot;               /* ACR 投入口硬貨チェック */
//     long    calc_ttlamt;                 /* calc 合計             */
//     long    calc_amt;                    /* calc お預り           */
//     long    calc_chgamt;                 /* calc お釣り           */
//     long    erctfm_mac_no;               /* reference machine no */
//     long    erctfm_receipt_no;           /* reference receipt no */
//     long    erctfm_print_no;             /* reference journal no */
//     char    erctfm_sale_datetime[31];    /* reference sales datetime */
//     short   erctfm_mbr_input;            /* member device input  */
//     char    erctfm_other_store_mbr;      /* other　store　member */
//     char    erctfm_mbr_name_kanji[50];   /* member　name　kanji　25　char */
//     long    itmpdsc_diffamt;          /* item percent discount differ amt */
//     char    cashintflg;                  /* 割込予約Flg */
//long 	spd_clear_tpnt;              /* Sapporo Drug Total Poin Clear */
//short	spd_write_stat;		     /* Sapporo Drug Card Write Error */
//ushort	spd_last_stre_no;	     /* Sapporo Drug Card Last Store No */
//char 	spd_last_issue_date[6];	     /* Sapporo Drug Card Last Issue Date */
//char 	spd_refix_date[6];	     /* Sapporo Drug Card Last Visit Date */
//     char    erctfm_now_sale_datetime[31];   /* reference now sales datetime */
//     char    cheque_no[8];                /* Cheque No Input */
//     char    cheque_sptend_cnt;           /* Cheque sptend_cnt */
//     long    esvoid_mac_no;               /* search void machine no */
//     long    esvoid_receipt_no;           /* search void receipt no */
//     long    esvoid_print_no;             /* search void journal no */
//char    last_visit_date[8];	     /* Last Visit Date */
//     char    revenue_exclusionflg;        /* 印紙除外キー使用フラグ   */
//     char    revenue_exclusionflg2;       /* 印紙除外キー使用フラグ2  */
//     char    outside_rbtprnflg;           /* 割戻対象外キー使用フラグ */
//long    godutch_ttlamt;              /* 割勘額表示合計金額 */
//long    godutch_people;              /* 割勘額表示人数     */
//long    godutch_inamt;               /* 割勘額表示先入金額 */
//char    multisusflname[128];         /* multi suspend/resume file name */
//long	susttlamt;                   /* suspend total amt */
//long    hycard_ttlamt;               /* H-Y Card合計金額   */
//short   old_fsp_lvl;                 /* 旧FSPレベル           */
//char    rwc_write_flg;               /* rwc書込み結果フラグ   */
//     int     sptend_cd1;                  /* カスミ */
//     int     sptend_cd2;                  /* カスミ */
//     int     sptend_cd3;                  /* カスミ */
//     int     sptend_cd4;                  /* カスミ */
//     int     sptend_cd5;                  /* カスミ */
//     int     sptend_cd6;                  /* カスミ */
//     int     sptend_cd7;                  /* カスミ */
//     int     sptend_cd8;                  /* カスミ */
//     int     sptend_cd9;                  /* カスミ */
//     int     sptend_cd10;                 /* カスミ */
//     int     sptend_data1;                /* カスミ */
//     int     sptend_data2;                /* カスミ */
//     int     sptend_data3;                /* カスミ */
//     int     sptend_data4;                /* カスミ */
//     int     sptend_data5;                /* カスミ */
//     int     sptend_data6;                /* カスミ */
//     int     sptend_data7;                /* カスミ */
//     int     sptend_data8;                /* カスミ */
//     int     sptend_data9;                /* カスミ */
//     int     sptend_data10;               /* カスミ */
//     int     sptend_chg_amt1;             /* カスミ */
//     int     sptend_chg_amt2;             /* カスミ */
//     int     sptend_chg_amt3;             /* カスミ */
//     int     sptend_chg_amt4;             /* カスミ */
//     int     sptend_chg_amt5;             /* カスミ */
//     int     sptend_chg_amt6;             /* カスミ */
//     int     sptend_chg_amt7;             /* カスミ */
//     int     sptend_chg_amt8;             /* カスミ */
//     int     sptend_chg_amt9;             /* カスミ */
//     int     sptend_chg_amt10;            /* カスミ */
//     int     crdt_amt1;                   /* カスミ */
//long	chgptn_price;	             /* 釣機両替金額 */
//long	chgptn_out_price;	     /* 釣機両替出金額 */
//char    exclusion_prn;               /* 検索領収書用印紙除外キー使用フラグ */
//char	pop_msg[50];			/* pop up message data */
//char    suica_number[17];            /* Suica Card No */
  int    suica_amt = 0;                   /*取引金額       */
//long    before_amt;                  /*取引前残高     */
//long    after_amt;                   /*取引後残高     */
//     long    cpick_amt;                   /* CPick Price Data */
//     long    cpick_cassette;              /* CPick Cassette Price Data */
//char    suica_id[13];                /* Suica  ID  No */
//char    suica_rwid[13];              /* Suica  R/WID No */
//char    suica_ng_prn;                /* Suica NG Print */
//     short   cpick_errno;                 /* CPick Result Error No. */
//     COINDATA coindata;                   /* 釣銭釣札機精査情報 */
//char	srch_telno[21];		    /* a telephone number for the search */
//char    mybag_point_flg;                /* MyBag Point Add Flg */
//long    remainder_amt;               /* 百貨店 */
//     short   miketu_flg;                  /* 未決フラグ(中合) */
//char	upd_fname[128];			/* for Update file name */
//     long    sptend_input_data1;          /* 手入力金額 */
//     long    sptend_input_data2;          /* 手入力金額 */
//     long    sptend_input_data3;          /* 手入力金額 */
//     long    sptend_input_data4;          /* 手入力金額 */
//     long    sptend_input_data5;          /* 手入力金額 */
//     long    sptend_input_data6;          /* 手入力金額 */
//     long    sptend_input_data7;          /* 手入力金額 */
//     long    sptend_input_data8;          /* 手入力金額 */
//     long    sptend_input_data9;          /* 手入力金額 */
//     long    sptend_input_data10;         /* 手入力金額 */
//long	deliv_rct_no;                /* 配達用番号 */
//short	home_deliv_no;               /* 配達便番号 */
//     long    next_fsp_lvl;                /* 修飾(中合) */
//     long    card_1time_amt;              /* 取引区分(中合) */
//long 	chg_inout_amt;               /* 釣機入出金合計 */
//long	tuo_img_no   ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no1  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no2  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no3  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no4  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no5  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no6  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no7  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no8  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no9  ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_img_no10 ;                /* tuo仕様ｲﾒｰｼﾞｺｰﾄﾞ */
//long	tuo_sign_flg ;                /* tuo仕様サイン欄  */
//MP1_PRN	mp1_prn;                      /* 値付けラベル データ */
//char	rpr_flg;                      /* 再発行フラグ(中合) */
//char	order_send_result;            /* 発注送信処理結果(業務モード仕様) */
//     char    carry_on;                    /* 積載指示フラグ */
//short	qs_ej_prn_flg;                /* 印字情報ＥＪ印字フラグ */
//char	cust_offline_flg;             /* 顧客リアルサーバオフラインフラグ */
SpvtAlm? spvtAlm;                    /* Smartplus/Visa Touch アラーム情報 */
//short   fsp_lvl_ticket;               /* ＦＳＰチケット発行金額 */
//long	wres_today_point;             /* グリーンスタンプ ライトレスポンス印字 */
//long	wres_total_point;             /* グリーンスタンプ ライトレスポンス印字 */
//long	wres_rbt_point;               /* グリーンスタンプ ライトレスポンス印字 */
//char	media_limit_yy[2+1];
//char	media_limit_mm[2+1];
//     EDYHIST edy_hist[6];                  /* Ｅｄｙ履歴印字 */
//     char    drwchk_pick_flg;
//     long    invalid_point;                /* 本年切れポイント */
//     long    other_point;                  /* 他社ポイント     */
//     long	issue_tckt_no;                /* 発券チケットNo.     */
//     short   nombrmsg_no;                    /* */
//short   mulrbt_prn_amt;               /* 多段チケット印字金額 */
//short   mulrbt_pnt;                   /* 多段チケット使用ポイント */
//char	felica_other_cust_no[8];      /* 別カード顧客コード */
//long	felica_other_anyprc_term_mny; /* 別カード複数売価期間対象額 */
//long	oldadvance_money;             /* 前回前払金額     */
//char	card_forgot_flg;              /* カード忘れフラグ */
//long	ht2980_today_point;           /* ht2980 ライトレスポンス印字 */
//long	ht2980_total_point;           /* ht2980 ライトレスポンス印字 */
//short   ht2980_msg_cnt;               /* ht2980 message print count */
//char	ht2980_msg1[50];              /* ht2980 message data */
//char	ht2980_msg2[50];              /* ht2980 message data */
//char	ht2980_msg3[50];              /* ht2980 message data */
//char	ht2980_msg4[50];              /* ht2980 message data */
//char	ht2980_msg5[50];              /* ht2980 message data */
//char	ht2980_msg6[50];              /* ht2980 message data */
//char	ht2980_msg7[50];              /* ht2980 message data */
//long	qctckt_qty;                   /* お買い物券 点数      */
//long	qctckt_ttlamt;                /* お買い物券 合計金額  */
//short	crdt_non_prn;                 /* クレジット控え印字なし */
//char	hcrdt_name[36];               /* 自クレ顧客名(矢尾) */
//long	use_lmt_amt[10];              /* 友の会残額(矢尾) */
//char	dps_lmt_date[8];              /* 友の会入金期限(矢尾) */
//short	qc_rfm_rcpt_flg;              /* 領収書発行済みレシート */
//long	qc_read_qr_mac_no;            /* お会計券発行レジ番号　　 */
//long	qc_read_qr_rept_no;           /* お会計券発行レシート番号 */
//long	qc_read_qr_print_no;          /* お会計券発行ジャーナル番号 */
//     long    evoid_mac_no;                 /* search void machine no */
//     long    evoid_receipt_no;             /* search void receipt no */
//     long    evoid_print_no;               /* search void journal no */
//short   reserv_custnon_prn;           /* 予約お客様控え印字なし*/
//     char    qc_read_time[5+1];            /* お買い物券 発行時刻   */
//char    webrealsrv_kangen[10+1];      /* JA埼玉 還元履歴番号 */
//char    webrealsrv_fuyo[10+1];        /* JA埼玉 付与履歴番号 */
//     long	clrttlpnt;                    /* クリアポイント        */
//long	mbr_status;                   /* 会員状態              */
//long	qc_read_qr_cshr_no;           /* お会計券発行キャッシャー番号　　 */
//char	qc_read_qr_cshr_name[20];     /* お会計券発行キャッシャー名称　　 */
//long	outadvance_money;             /* 内金支払額 */
  late WizQrData wizQrData = WizQrData();                /* Wiz精算情報 */
//long	mly_price;                    /* 月間購入金額 */
//char	now_rank_name[40+1];          /* 当月コアカスタマーランク名称 */
//char	chkr_start[20];               /* Checker Start Time */
//char	chkr_end[20];                 /* Checker End Time */
//int	chkr_stop_time;               /* Checker Stop Time (second) */
//char	cshr_start[20];               /* Cashier Start Time */
//char	cshr_end[20];                 /* Cashier End Time */
//int	cshr_stop_time;               /* Cashier Stop Time (second) */
//time_t	stop_start;                   /* Checker Stop Start Time */
//long	interrupt_price;              /* 中断時の釣銭機への投入金額 */
//int	spec_type;                    /* RPNTER_SPEC_TYPE_IDXの値をセット */
//short   esvoid_cashvoid_mode;         /* 検索訂正金種訂正モード */
//char	qcselect_msg[32];             /* QC指定キーで印字する時のレジ名称 */
//short   card_stop_kind;               /* コープさっぽろ ｶｰﾄﾞ停止区分 */
//char	chkr_offmode_start[20];       /* Checker OffMode Start Time */
//char	chkr_offmode_end[20];         /* Checker OffMode End Time */
//char	cshr_offmode_start[20];       /* Cashier OffMode Start Time */
//char	cshr_offmode_end[20];         /* Cashier OffMode End Time */
//long	restmp_amt;                   /* 印紙対象外金額 */
//char	cct_suica_flg;                /* CCT決済端末接続のSuica 各種フラグ */
//char	slip_reason_name[REASON_NAME_LEN]; /* 業務モード  理由区分名称 */
//     long    rcp_cnt;         	      /* 領収書回数     */
//     long    rcp_amt;         	      /* 領収書金額     */
//int	rpr_serv_flg;                 /* 再発行予約フラグ */
//short	chg_stock_state_err;          /* 釣機在高不確定 */
//long	qc_read_dcau_mspur;           /* お会計券リード時本日対象額 */
//short	qc_read_qr_recipt_flg;        /* ＱＲレシートリード情報	*/
//char	offline_flg;                  /* レシート発行時のオフラインフラグ */
//char	bs_offline_flg;               /* レシート発行時のオフラインフラグ */
//char	add_limit_date[6+1];          /* 北欧トーキョー ポイント積立期限 */
//char	use_limit_date[6+1];          /* 北欧トーキョー 有効期限 */
//long	before_year_point;            /* 北欧トーキョー 前年ポイント数 */
//char	culay_recmsg_data[RECMSG_MAX_NUM][RECMSG_NAME_LEN];	/* 客層キー使用時の印字データ 客層キー[1-10]使用で, recmsg_cd[51-60]使用 */
//long	qc_read_dpnt_ttlsrv;           /* お会計券リード時 本日ポイント */
//long	qc_read_dcau_fsppur;           /* お会計券リード時 本日複数売価対象額 */
//CBILLKIND	drwchg_before;         /* 釣機両替両替前枚数 */
//CBILLKIND	drwchg_after;          /* 釣機両替両替後枚数 */
//int	sync_set_num;			/* Printer Set Sync Number */
//REFLISTPRN	reflist;               /* 返品理由印字 */
//     long    cash_recycle_mac_no1;          /* cash recycle machine no */
//     long    cash_recycle_mac_no2;          /* cash recycle machine no */
//     long    cash_recycle_mac_no3;          /* cash recycle machine no */
//     short   cash_recycle_diff;             /* cash recycle inout differnet */
  int	qcReciptPrn = 0;                 /* お会計券発行情報（再発行用）	*/
//long	autostrcls_staff_cd;		/* キャッシュマネジメント自動精算操作者No.*/
//char	autostrcls_staff_name[51];	/*キャッシュマネジメント自動精算操作者名*/
//long	divadjCrdtAmt1;               /* 分割精算クレジット支払額１ */
//long	divadjCrdtAmt2;               /* 分割精算クレジット支払額２ */
//long	divadjCrdtAmt3;               /* 分割精算クレジット支払額３ */
//long	divadjCrdtAmt4;               /* 分割精算クレジット支払額４ */
//long	divadjCrdtAmt5;               /* 分割精算クレジット支払額５ */
//     char    first_qc_read_time[8+1];        /* お買い物券 発行時刻   */
//     char    second_qc_read_time[8+1];       /* お買い物券 発行時刻   */
//char	pre_rctfm_flg;			/* 領収書宣言での発行フラグ  0:しない  1:する */
//char	mbr_prn_flg;			/* 会員印字の変更  0:しない  1:する */
//char	mbr_prn_name;			/* 会員名の印字  0:しない  1:する 2:チケット */
//char	mbr_prn_addr;			/* 会員住所の印字  0:しない  1:する */
//char	mbr_prn_tel;			/* 会員電話番号の印字  0:しない  1:する */
//short	qc_read_bluechip_flg;	        /* ブルーチップ検索登録情報	*/
//char	charge_slip_flg;			/* 売掛会員フラグ 0:売掛会員ではない 1:売掛会員である */
//short   drawchk_declare_flg;		/* 差異チェック時、在高申告実績作成 0:しない 1:する */
//     short   prize_won_flg;                  /* 当選チケット発行 */
//char    mltsuica_number[17+1];           /* Suica Card No */
//char    mltsuica_seqno[8+1];             /* Suica Seq No */
//long    suica_ng_amt;                    /* 取引金額      */
//long	webrealsrv_exp_point_prn;	/* JA埼玉 失効ポイント印字　0：しない　1：する*/
//long	webrealsrv_exp_point;		/* JA埼玉 失効ポイント*/
//char	webrealsrv_exp_date[10];	/* JA埼玉 失効予定日 */
//char	webrealsrv_offline_custno[20];	/* JA埼玉 オフライン顧客No. */
//CASHRECYCLE	crinfo;			/* キャッシュリサイクル情報 */
//short	sg_rfm_rcpt_flg;                /* 領収書発行済みレシート */
//short	office_drwchg;			/* 事務所両替 */
//     short   cpick_type;			/* 回収方法ボタン選択情報 */
//     short	revocation_flg;                 /* 失効ポイント印字フラグ */
//     long	revocation_day;                 /* 失効ポイント月         */
//     long	revocation_point;               /* 失効ポイント           */
//     short	achieved_flg;                   /* 達成印字フラグ         */
//     long	achieved_amt;                   /* 達成までの金額         */
//     CINDATA cindata;                        /* 釣銭釣札機入金枚数     */
//KIND_OUT kindout_prn;
//SUICA_ALM suica_alm;			/* 交通系IC処理未了関連 */
//char    nimoca_number[17+1];	/* NIMOCA Card No */
//char	nimoca_card_type;		/* NIMOCA Card Type */
//ushort	nimoca_rct_id;			/* NIMOCA Rct Id */
//ushort	nimoca_act_cd;			/* NIMOCA Act Cd */
//short   nimoca_flg;				/* NIMOCAﾎﾟｲﾝﾄ作成失敗ﾌﾗｸﾞ */
//short	taxfree_prn_select[6];		/* 免税レシート再発行時の各レシート印字選択フラグ 0：印字しない 1：印字する */
//SPZ_READ_TYPE	spz_read_type;		/* Speeza実績の訂正データ用 */
//short	custreal_fsp_first_rd;		/* ランク決定後、最初の読み込みか */
//REPICA_TC	repica_tc;		/* レピカ仕様 カード付替 */
//long	spz_rwc_write_pnt;		/* スピードセルフ用書込済ポイント */
//long	lottery_assist_amt;		/* 抽選補助点金額	*/
//int	lottery_assist_cnt;		/* 補助回数		*/
//long	tmp_dpnt_ttlsrv;		/* 本日ポイント */
//long	tmp_dcau_mspur;			/* 本日対象額 */
//char	maruto_outsmlcls_slipcd[6+1];		/* マルト様部門外伝票番号 */
//short	partist_Birth_flg;		/* 誕生日有効フラグ　０：付与　１：付与不可     */
//short	partist_realsvr_sts;            /* 61:他レジ使用中フラグ                        */
//long    partist_other_point;            /* 本部付与ポイント                             */
//long	partist_exp_point_prn;          /* 失効ポイント印字フラグ　０：しない　１：する */
//long	partist_exp_point;              /* 失効予定ポイント                             */
//char	partist_exp_date[11];           /* 失効予定日                                   */
//COGCA_PRN	cogca_prn;		/* CoGCa仕様 レシート印字 */
//long	d1_dcau_mspur;                  /* 割増前本日対象額 */
//AYAHA_PROM ayaha_prom[8];
//TPOINT_PRN	tpoint_prn;		/* Tポイント仕様　印字データ */
//long	qc_mente_staff_cd;		/* メンテナンススタッフ番号                     */
//char	qc_mente_staff_name[50];	/* メンテナンススタッフ名前                     */
//short	void_iccncl_msg_flg;		/* ニモカポイント付与レシート訂正時のポイント訂正メッセージ印字 0:しない 1:する */
//CHARGE_SLIP_PRNDATA	charge_slip_prndata;		/* 売掛伝票印字　しない・するの印字データフラグ */
//long	trm_slipno;			/* Y端末 端末伝票番号 */
//     YUMECAPOL_RX yumecapol_rx;              /* ゆめｶｰﾄﾞﾚｼﾞ直仕様 レシート印字 */
//     long	achieved_point;                 /* 達成までの金額         */
//short	taxfree_flg;			/* 免税宣言フラグ 0:非免税 1:免税 */
//int	ExtGuaranteeVol;		/* 延長保証対象登録数 */
//EXT_GUARANTEE_PRN extGuarantee_prn[10];	/* 延長保証対象商品名称	*/
//long	extGuarantee_price[200];	/* 延長保証対象商品の金額 */
//char	cr40_file_path[TPRMAXPATHLEN];	/* CR4.0のリードファイル名  */
//      char    qc_read_time_CR40[12+1];            /* お買い物券 発行時刻   */
//int	prize_transaction_count;        /* お買物券管理取引通版 */
//short	cct_givepnt_flg;		/* CCTポイント決済仕様：ポイント付与フラグ */
//short	cct_usepnt_flg;			/* CCTポイント決済仕様：ポイント利用フラグ */
//short	preca_cardnum_mask_flg;		/* プリペイド番号のマスクフラグ */
//short	preca_cardnum_mask_digit;	/* プリペイド番号のマスク桁数 */
//     long	qc_read_sptend_cnt;		/* お会計券内のスプリット回数 */
//     long	ssvoid_info_prn;		/* ＳＳ訂正情報印字           */
//RXMEMREASON reason;
//RXMEMSTFRELEASE stfrelease;
//short	crdtvoid_upderr_flg;		/* クレ訂での実績ライトエラーフラグ */
//CRDTVOID_PRN	crdtvoid;		/* クレ訂用 レシート印字 */
//char	acoop_recmsg_data[RECMSG_MAX_NUM][RECMSG_NAME_LEN];	//ADD 2016.05.17 Fujimura
//short	vesca_receipt_cnt;
//VESCA_DTL vesca_dtl[VESCA_DATA_MAX];
//RPOINT_PRN	rpoint_prn;		/* Rポイント仕様　印字データ */
//short	kasumi_receipt_flg;		/* カスミ領収証フラグ */
//short	rpoint_void_cncl_flg;		/* Rポイント仕様　訂正時の顧客実績連動制御フラグ */
//short	vesca_dtl_rowid;
//short	vesca_dtl1_rowid;
//short	vesca_dtl2_rowid;
//short	vesca_dtl3_rowid;
//short	vesca_dtl4_rowid;
//short	vesca_dtl5_rowid;
//MTGPANA_ENQ	mtgpana_enq;
//CASH_RECYCLE_INFO	cash_recycle;		/* キャッシュリサイクル情報 */
  AjsEmoneyPrn ajsEmoneyPrn = AjsEmoneyPrn();		/* AJSマネー 印字データ */
//UNKNOWN_PRN	unknown_prn;
//AJS_PRN	ajs_prn;			/* 顧客リアル[AJS]仕様 印字データ */
//NSW_FMT	nsw_fmt;			/* NSWデータ連携レシートフォーマット */
//NUTRIINFO_PRN	nutriinfo_prn;		/* 栄養成分印字データ */
//int	cr2_read_mac_no;		/* 特定CR2接続仕様 登録機レジ番号 */
//int	cr2_read_kubun;			/* 特定CR2接続仕様 登録機区分 */
//int	cr2_bar_type;			/* 特定CR2接続仕様 バーコード印字タイプ */
//short	custreal_exp_point_flg;		/* 顧客リアル仕様 失効予定ポイント印字フラグ */
//long	custreal_exp_point;		/* 顧客リアル仕様 失効予定ポイント */
//short	check_vesca_receipt_end;
//short	Sptend_input_flg[10];	/* 手入力マーク付与候補フラグ 0:手入力マーク付与しない 1:手入力マーク付与の候補である */
//PONTA_PRN	ponta_prn;		/* Ponta仕様 印字データ */
//NEC_EMONEY_PRN nec_emoney_prn;	/* NEC電子マネー仕様 印字データ */
//short	vesca_qc_sign;
//long	ref_print_no;			/* 検索返品ジャーナル番号 */
//long	rfm_print_no;			/* 領収書ジャーナル番号 */
//long	temp_callNumber;		/* 呼出番号（キッチンプリンタ仕様）*/
//long	first_tdy_amt;			/* グリーンスタンプ 初回の本日対象額 */
//WAON_PRN  waon_prn[1];			/* WAON支払情報<スプリット1段分>  */
//WAON_ALM  waon_alm;			/* WAONアラーム情報 */
//WAON_HIST waon_hist[3];			/* WAON履歴情報<明細最大3件> */
//WAON_POINT waon_point;			/* WAONポイント計算 */
//char      pana_waon_recmsg_data[RECMSG_MAX_NUM][RECMSG_NAME_LEN];	/* 各種WAONレシートのメッセージデータ<recmsg_cd[70,71,72]で使用> */
//char      pana_waon_recmsg_alm1[RECMSG_MAX_NUM][RECMSG_NAME_LEN];	/* 各種WAONレシートのアラームメッセージ<recmsg_cd[73-82]で使用> */
//char      pana_waon_recmsg_alm2[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm3[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm4[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm5[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm6[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm7[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm8[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm9[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//char      pana_waon_recmsg_alm10[RECMSG_MAX_NUM][RECMSG_NAME_LEN];
//long      qr_read_dcau_mspur;
//long      qr_read_dcau_fsppur;
//int       qr_read_mbr_input;
//char      qr_read_mbr_cd[20];
//char      vesca_service[16];		// VESCAの使用ブランド名称を格納
//short     tran_mode;			// 取引中のモード
//int	waon_type_rpr;			/* 再発行からのWAONオートチャージレシート印字の判断フラグ */
//char      country_name[72];
//char      country_english_name[18];
//TRNSFER_CST_PRN	trnsfer_cst_prn;	/* 店内クッキング仕様 理由選択区分 */
//short	vesca_cash_flg;			//Verifone連動予約取消現金返却フラグ
//PASSPORT_DATA	passport_data;
//short	clinic_receipt_flg;		/* HappySelfクリニックモードレシート印字設定 */
//short	vesca_speezac_flg;		// Verifoneお会計券印字スキップフラグ
//SPTEND_PRN_DATA	sp_prn_data[10];	// スプリット情報
//short	vesca_edy_flg;			// Verifone edy支払い毎印字フラグ
//short	vesca_edy_cnt;			// Verifone edy支払い毎印字枚数
//int	org_type_vesca;			// 元、印字の種類<Verifone用>
//char	dpoint_card_no[20];
//char	barcodepay_err[51];		// codepay err message
//char	barcodepay_name[51];		// codepay name
//short	overflow_mente_type;		// ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ処理種類
//short	overflow_recalc_over;		// ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽ精査収納オーバーフラグ
//char	mltsuica_datetime[20];		// 交通系IC取引日時
//JTR_PRN		jtr_prn;		/* カスミ様 JT-R端末情報印字 */
//ECOA_PRN	ecoa_recmsg;		/* ECOA QR発券仕様 レシートメッセージ */
//ECOA_TICKET	ecoa_ticket;		/* ECOA QR発券仕様 給水通番及び給水枚数 */
}

///関連tprxソース:rxmemprn.h - SPVT_ALM
class SpvtAlm {
  int almType = 0;          /* アラームの種類 */
  int tranAmt = 0;          /* 取引金額       */
  String cdNo = '';         /* カードNo       */
  String rcptNo1 = '';      /* 伝票番号       */
  String rcptNo2 = '';      /* ＩＣ通番       */
  int resultCode = 0;       /* 結果コード１[UT] */
  int rExtended = 0;        /* 結果コード２[UT] */
  String centerCode = '';   /* 結果コード３[UT] */
  String centerCodePfm = '';/* 結果コード４[PFM] */
  int pfmOpeMode = 0;       /* オペモード[PFM] */
}

///関連tprxソース:rxmemprn.h - RPNTER_SPEC_TYPE_IDX
enum RpnterSpecTypeIdx {
  PRN_SPEC_TYPE_NORMAL(0),	// 通常印字
  PRN_SPEC_TYPE_QC_CNCL(1),		// お会計券二度読み時の取消印字
  PRN_SPEC_TYPE_QC_INTERRUPT(2),	// お会計券中断時の中断レシート印字
  PRN_SPEC_TYPE_QC_SELECT(3);	// QC指定でのお会計券発行時の印字

  final int id;
  const RpnterSpecTypeIdx(this.id);
}

// プリペイドカード複数枚利用 ()
///関連tprxソース:rxmemprn.h - MULPRE_PRN
class MulprePrn {
  String jis1 = ""; //[40];		// JIS1カード情報
}


///関連tprxソース:rxmemprn.h - AJS_EMONEY_PRN
class AjsEmoneyPrn {
  // char	cardNumMaskFg;		/* カード番号マスクフラグ */
  // long	cardNumMaskDigit;	/* カード番号マスク桁数 */
  // char	bfrTotalBalance[9+1];	/* Value利用前残高合計値 */
  // char	useTotalValue[9+1];	/* 今回Value利用合計値 */
  String aftTotalBalance = '';	/* Value利用後残高合計値 */
// char	grantValue[9+1];	/* キャンペーン付与額 */
// char	expire_ymd[8+1];	/* 有効期限 */
//
// char	bfrTicketBalance[9+1];	/* 紅屋特注 ポイント交換分利用前残高 */
// char	useTicketValue[9+1];	/* 紅屋特注 今回ポイント交換分利用合計値 */
// char	aftTicketBalance[9+1];	/* 紅屋特注 ポイント交換分利用後残高 */
//
// char	bfrSumBalance[9+1];	/* 紅屋特注 ポイント交換分+マネー残高 前 */
// char	useSumValue[9+1];	/* 紅屋特注 ポイント交換分+マネー利用合計 */
// char	aftSumBalance[9+1];	/* 紅屋特注 ポイント交換分+マネー残高 後 */
//
// char	seq_pos_no[30+1];	/* 紅屋特注 ポイント交換分 有効期限 */
// char	prn_req_code[4+1];	/* 紅屋特注 ポイント交換分 登録モード */
}
