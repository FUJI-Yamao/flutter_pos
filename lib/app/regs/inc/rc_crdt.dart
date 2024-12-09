/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';
import 'package:flutter_pos/app/regs/common/rx_log_calc.dart';
import 'package:flutter_pos/app/regs/inc/rc_mem.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxregmem_define.dart';


/************************************************************************/
/*                        Typedef Struct Datas                          */
/************************************************************************/
/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_RXHD
class NttAspRxhd {
  String aspCounter = '';
  String conComCd = '';
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_RXDT
class NttAspRxdt {
  String typeId = '';
  String manageCd = '';
  String payPri = '';
  String stoNo = '';
  String aspRdttm = '';
  String funcCd = '';
  String aspMdate = '';
  String aspRecno = '';
  String mbrNo = '';
  String goodThru = '';
  String kanaName = '';
  String dspMsg = '';
  String prnMsg = '';
  String confirmCode = '';
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_RXDATA
class NttAspRxData {
  NttAspRxhd? nwhd;
  NttAspRxdt? data;
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_INF
class NttAspInf {
  // バイナリファイルからパースできるよう、元の構造体の配列長を別途定義
  static const busiKindByteLength = 1;
  static const sendDateByteLength = 10;
  static const aspRdttmByteLength = 12;
  static const stoNoByteLength = 6;
  static const conComCdByteLength = 11;
  static const mbrNoByteLength = 19;
  static const goodThruByteLength = 4;
  static const aspRecNoByteLength = 6;
  static const aspCrdtNoByteLength = 5;
  static const orgCrdtNoByteLength = 5;
  static const itemCdByteLength = 4;
  static const payPriByteLength = 12;
  static const taxEtcByteLength = 7;
  static const payDivByteLength = 2;
  static const payWayByteLength = 81;
  static const useDateByteLength = 4;
  static const tranFlgByteLength = 1;
  static const judgmentByteLength = 1;
  static const nttAspInfBytelength = busiKindByteLength
      + sendDateByteLength
      + aspRdttmByteLength
      + stoNoByteLength
      + conComCdByteLength
      + mbrNoByteLength
      + goodThruByteLength
      + aspRecNoByteLength
      + aspCrdtNoByteLength
      + orgCrdtNoByteLength
      + itemCdByteLength
      + payPriByteLength
      + taxEtcByteLength
      + payDivByteLength
      + payWayByteLength
      + useDateByteLength
      + tranFlgByteLength
      + judgmentByteLength;

  /// 業務種別
  String busiKind = "";
  /// 端末送信日時
  String sendDate = "";
  /// センタ受付日時
  String aspRdttm = "";
  /// システムとレースナンバー
  String stoNo = "";
  /// 接続先会社コード
  String conComCd = "";
  /// 会員番号
  String mbrNo = "";
  /// 有効期限
  String goodThru = "";
  /// 承認番号
  String aspRecNo = "";
  /// 伝票番号
  String aspCrdtNo = "";
  /// 元伝票番号
  String orgCrdtNo = "";
  /// 商品コード
  String itemCd = "";
  /// 金額＜取引＞
  String payPri  = "";
  /// 税／その他
  String taxEtc = "";
  /// 支払区分
  String payDiv = "";
  /// 支払方法
  String payWay = "";
  /// 日付＜取得＞
  String useDate = "";
  /// 取引完了フラグ
  String tranFlg = "";
  /// カウンタ判定結果
  String judgment = "";

  /// バイナリ配列をパースしてクラスメンバ変数に格納
  /// 引数   bytes  : NttAspInf構造体を含むバイト配列
  ///        offset : パース開始位置
  /// 戻り値:成功フラグ
  bool parse(List<int> bytes, int offset) {
    // オフセット値がマイナス、もしくはbyte長が不足している場合は処理を終了する
    if (offset < 0 || (bytes.length - offset) < nttAspInfBytelength) {
      return false;
    }
    int seek = offset;
    busiKind = String.fromCharCodes(bytes.sublist(seek, seek+=busiKindByteLength));
    sendDate = String.fromCharCodes(bytes.sublist(seek, seek+=sendDateByteLength));
    aspRdttm = String.fromCharCodes(bytes.sublist(seek, seek+=aspRdttmByteLength));
    stoNo = String.fromCharCodes(bytes.sublist(seek, seek+=stoNoByteLength));
    conComCd = String.fromCharCodes(bytes.sublist(seek, seek+=conComCdByteLength));
    mbrNo = String.fromCharCodes(bytes.sublist(seek, seek+=mbrNoByteLength));
    goodThru = String.fromCharCodes(bytes.sublist(seek, seek+=goodThruByteLength));
    aspRecNo = String.fromCharCodes(bytes.sublist(seek, seek+=aspRecNoByteLength));
    aspCrdtNo = String.fromCharCodes(bytes.sublist(seek, seek+=aspCrdtNoByteLength));
    orgCrdtNo = String.fromCharCodes(bytes.sublist(seek, seek+=orgCrdtNoByteLength));
    itemCd = String.fromCharCodes(bytes.sublist(seek, seek+=itemCdByteLength));
    payPri = String.fromCharCodes(bytes.sublist(seek, seek+=payPriByteLength));
    taxEtc = String.fromCharCodes(bytes.sublist(seek, seek+=taxEtcByteLength));
    payDiv = String.fromCharCodes(bytes.sublist(seek, seek+=payDivByteLength));
    payWay = String.fromCharCodes(bytes.sublist(seek, seek+=payWayByteLength));
    useDate = String.fromCharCodes(bytes.sublist(seek, seek+=useDateByteLength));
    tranFlg = String.fromCharCodes(bytes.sublist(seek, seek+=tranFlgByteLength));
    judgment = String.fromCharCodes(bytes.sublist(seek, seek+=judgmentByteLength));
    return true;
  }
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_TIFILE
class NttAspTiFile {
  /// 取引データ件数
  int cnt = 0;
  /// 取引データ
  List<NttAspInf> inf = List.generate(Datas.TIFILE_MAX, (_) => NttAspInf());
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_NWHD
class NttAspNwhd {
  List<String> dataLen = List.filled(4, '');          /* データレングス            */
  List<String> srvCode = List.filled(3, '');         /* センターサービスコード    */
  List<String> reqCode = List.filled(4, '');         /* 要求コード                */
  List<String> comCode = List.filled(5, '');         /* 端末情報:企業コード       */
  List<String> strCode = List.filled(4, '');         /*         :店舗コード       */
  List<String> macNo = List.filled(4, '');           /*         :端末通番         */
  List<String> pidOld = List.filled(8, '');          /*         :PID-OLD          */
  List<String> pidNew = List.filled(8, '');          /*         :PID-NEW          */
  List<String> counter = List.filled(4, '');          /* カウンタ                  */
  List<String> reserv1 = List.filled(18, '');         /* リザーブ領域１            */
  List<String> sendDate = List.filled(10, '');       /* 端末送信日時              */
  List<String> conComCd = List.filled(11, '');      /* 接続先会社コード          */
  List<String> conComKid = List.filled(3, '');      /* 接続先会社KID             */
  String errorCd = '';         /* エラーコード              */
  List<String> reserv2 = List.filled(8, '');          /* リザーブ領域２            */
  String corrStat = '';                               /* 直前取引情報:取引完了ステータス   */
  List<String> corrDate = List.filled(10, '');       /*             :直前取引端末送信日時 */
  List<String> reserv3 = List.filled(5, '');          /* リザーブ領域３            */
  List<String> hardMaker = List.filled(2, '');       /* 管理データ:メーカーコード */
  List<String> hardModel = List.filled(2, '');       /*           :モデル         */
  List<String> aplKind = List.filled(2, '');         /*           :端末種別       */
  List<String> aplVersion = List.filled(3, '');      /*           :総合バージョン */
  List<String> reserv4 = List.filled(9, '');          /* リザーブ領域４            */
  List<String> conComName = List.filled(10, '');    /* 接続会社名                */
  List<String> cafisCrdtno = List.filled(6, '');     /* CAFIS処理通番             */
  List<String> cafisRdttm = List.filled(4, '');      /* CAFIS処理月日             */
  List<String> cafisRecognNo = List.filled(1, '');  /* CAFIS承認番号(上1桁)      */
  List<String> reserv5 = List.filled(19, '');         /* 予備                      */
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_DATA
class NttAspData {
  List<String> typeId = List.filled(4, '');
  List<String> bmap64 = List.filled(8, '');
  List<String>? info;
}

/// 関連tprxソース: regs\inc\rccrdt.h - NTTASP_RCVSOCT
class NttAspRcvSoct {
  NttAspNwhd nwhd = NttAspNwhd();
  NttAspData data = NttAspData();
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_REQCOM
class CardCrewReqCom {
  /// 電送区分
  String dataType = "";
  /// 電文長
  String dataLen = "";
  /// 業務コード
  String businessCode = "";
  /// 企業ID
  String compId = "";
  /// 通信ID
  String correspondId = "";
  /// リザーブ
  String reserve = "";
  /// リターンコード
  String returnCode = "";
  /// 続行フラグ
  String continueFlg = "";
  /// 端末ID
  String macId = "";
  /// 端末処理通番
  String regCreditNumber = "";
  /// 業務区分
  String businessKind = "";
  /// 取消指令区分
  String voidKind = "";
  /// 売上日付
  String saleDate = "";
  /// 売上金額
  String salePrice = "";
  /// 税送料
  String taxPrice = "";
  /// 元伝票番号
  String orgCreditNumber = "";
  /// 支払区分
  String payKind = "";
  /// 支払内容明細
  String payDetail = "";
  /// 商品コード
  String itemCode = "";
  /// 承認区分
  String admitKind = "";
  /// 事後承認番号
  String admitNumber = "";
  /// カード区分
  String cardKind = "";
  /// カード内容
  String cardDetail = "";
  /// 暗証番号
  String cardNumber = "";
  /// サイクル通番
  String cycleNumber = "";
  /// 担当者コード
  String staffNumber = "";
  /// 今回ポイント
  String justPoint = "";
  /// メモ１
  String memo1 = "";
  /// メモ２
  String memo2 = "";
  /// カウンタ売上件数
  String saleQtyCounter = "";
  /// カウンタ売上金額
  String salePrcCounter = "";
  /// カウンタ取消件数
  String voidQtyCounter = "";
  /// カウンタ取消金額
  String voidPrcCounter = "";
  /// KEY管理１
  String key1 = "";
  /// KEY管理２
  String key2 = "";
  /// チェック用電話番号
  String telNumber = "";
  /// クリアフラグ
  String clearFlg = "";
  /// 端末判定カード会社識別
  String cardcompJudge = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_RCVCOM
class CardCrewRcvCom {
  /// 電送区分
  String dataType = "";
  /// 電文長
  String dataLen = "";
  /// 業務コード
  String businessCode = "";
  /// 企業ID
  String compId = "";
  /// 通信ID
  String correspondId = "";
  /// リザーブ
  String reserve = "";
  /// リターンコード
  String returnCode = "";
  /// 続行フラグ
  String continueFlg = "";
  /// 端末ID
  String macId = "";
  /// 端末処理通番
  String regCreditNumber = "";
  /// 処理日付
  String tranDate = "";
  /// 処理時刻
  String tranTime = "";
  /// CAFIS処理通番
  String cafisCreditNumber = "";
  /// カード会社コード
  String cardcompCode = "";
  /// 会員番号
  String memberCode = "";
  /// 有効期限
  String validTerm = "";
  /// 業態コード
  String formCode = "";
  /// カード利用区分
  String useCardKind = "";
  /// IDマーク
  String idMark = "";
  /// カード会社名
  String cardcompName = "";
  /// 承認番号
  String admitNumber = "";
  /// POS用会社コード
  String regCompCode = "";
  /// カード会社TEL
  String cardcompTel = "";
  /// エラーコード
  String errCode = "";
  /// メッセージ１
  String message1 = "";
  /// メッセージ２
  String message2 = "";
  /// 提携区分
  String affiliateKind = "";
  /// クリアフラグ
  String clearFlg = "";
  /// カウンタ売上件数
  String saleQtyCounter = "";
  /// カウンタ売上金額
  String salePrcCounter = "";
  /// カウンタ取消件数
  String voidQtyCounter = "";
  /// カウンタ取消金額
  String voidPrcCounter = "";
  /// 顧客コード
  String customerCode = "";
  /// 通帳印字固定部
  String bankbookFixed = "";
  /// 通帳印字任意部
  String bankbookOption = "";
  /// 伝票印字銀行コード
  String printBankCode = "";
  /// 伝票印字支店コード
  String printBankOffice = "";
  /// 伝票印字口座番号
  String printBankNumber = "";
  /// 伝票印字発行銀行名
  String printBankName = "";
  /// クリアリング発行銀行
  String ringBankName = "";
  /// クリアリング加盟店コード
  String ringStoreCode = "";
  /// クリアリング加盟店サブ
  String ringStoreSub = "";
  /// 累計ポイント
  String totalPoint = "";
  /// サイクル通番
  String cycleNumber = "";
  /// センタ識別
  String centerCheck = "";
  /// CAFIS処理月日
  String cafisTrandate = "";
  /// KEY管理１
  String key1 = "";
  /// KEY管理２
  String key2 = "";
  /// CASSオンライン状態フラグ
  String cassState = "";
  /// 元取引仕向会社サブコード
  String subCode = "";
  /// 予備
  String spare = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_REQADD
class CardCrewReqAdd {
  String businessDate = '';  /* vega接続 営業日        */
  String orgcreditDatetime = '';  /* vega接続 元取引日      */
  String buseBcnt = '';  /* vega接続 ボーナス併用時ボーナス回数 */
  String crdtvoidFlg = '';  /* vega接続 訂正フラグ    */
  String voidDetail = ''; /* vega接続 訂正電文用支払内容明細           */
/* VEGA3000接続対応で電文送信時にセットする項目を追加するときは下に追加していく */
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_REQVEGA
class CardCrewReqVEGA{
  CardCrewReqCom	reqCom = CardCrewReqCom();
  CardCrewReqAdd	reqAdd = CardCrewReqAdd();
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_RCVADD
class CardCrewRcvAdd {
  /// vega接続 端末ID
  String terminalId = "";
  /// vega接続 サインレスフラグ
  String recSignless = "";
  /// vega接続 サインレスフラグ(IC)
  String icPrintSignless = "";
  /// vega接続 IC/MS識別子
  String icMsType = "";
  /// vega接続 暗証番号確認済み
  String comfirmedPin = "";
  /// vega接続 AID
  String aid = "";
  /// vega接続 アプリケーションラベル
  String brandName = "";
  /* VEGA3000接続対応で電文受信時にセットする項目を追加するときは下に追加していく */
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_RCVCOMVEGA
class CardCrewRcvComVega {
  CardCrewRcvCom rcvCom = CardCrewRcvCom();
  CardCrewRcvAdd rcvAdd = CardCrewRcvAdd();
}

/// 関連tprxソース: regs\inc\rccrdt.h - ENCRYPT_SEND
class EncryptSend {
  String tid = '';                  /* 端末機識別番号       */
  String firstKeyDecryptKey = ''; /* 第１鍵復号化鍵       */
  String noticeInfo = '';           /* 通知情報             */
  String nwMngData = '';          /* NWヘッダ:管理情報    */
  String nwTermSendData = '';    /* NWヘッダ:端末送信日時*/
  int track2DataFlg = 0;          /* トラック２データ有無 */
  String track2Data = '';      /* トラック２データ     */
  int addDataFlg = 0;             /* 追加データ有無       */
  String addData = '';         /* 追加データ           */
  int accountNoFlg = 0;           /* 第１次会計番号有無   */
  String accountNo = '';       /* 第１次会計番号       */
  String creditAmount = '';      /* 金額＜取引＞         */
  String varidDate = '';          /* 日付＜満了＞         */
  int certificateNoFlg = 0;       /* 暗証番号有無         */
  String certificateNo = '';        /* 暗証番号(PINデータ)  */
  String termAuditNo = '';         /* 端末処理通番         */
  String confirmCode = '';          /* メッセージ認証コード */
}

/// 関連tprxソース: regs\inc\rccrdt.h - ENCRYPT_RECV
class EncryptRecv {
  String tid = '';                  /* 端末機識別番号       */
  String firstKeyDecryptKey = ''; /* 第１鍵復号化鍵       */
  String noticeInfo = '';           /* 通知情報             */
  String nwMngData = '';          /* NWヘッダ:管理情報    */
  String nwTermSendData = '';    /* NWヘッダ:端末送信日時*/
  String creditAmount = '';      /* 金額＜取引＞         */
  String accountNo = '';       /* 第１次会計番号       */
  String dataLength = '';           /* データレングス       */
  String requestCode = '';          /* 要求コード           */
  String varidDate = '';          /* 日付＜満了＞         */
  String confirmCode = '';          /* メッセージ認証コード */
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_HEAD
class CapsHead {
  String cmd = "";
  String dataLen = "";
  String posName = "";
  String macNo = "";
  String procNo = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_S
class CapsS {
  CapsHead head = CapsHead();
  String bizCode = "";
  String posId = "";
  String commType = "";
  String lanAdd = "";
  String lanNode = "";
  String portNum = "";
  String retCode = "";
  String errCode = "";
  String posProcNo = "";
  String bizType = "";
  String cardType = "";
  String encData = "";
  String password = "";
  String itemCode = "";
  String saleAmt = "";
  String taxCarr = "";
  String sep = "";
  String detail = "";
  String cgAbnmCode = "";
  String cafisPosNo = "";
  String aprvType = "";
  String aprvNum = "";
  String posMkrCode = "";
  String ntSrvNo = "";
  String induceCode = "";
  String filler = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_E
class CapsE {
  CapsHead head = CapsHead();
  String bizCode = "";
  String posId = "";
  String commType = "";
  String lanAdd = "";
  String lanNode = "";
  String portNum = "";
  String retCode = "";
  String procCode = "";
  String cafisErrCode = "";
  String srvProcDate = "";
  String srvProcTime = "";
  String cafisProcNo = "";
  String cardType = "";
  String idMark = "";
  String bizCondCode = "";
  String dealCompCode = "";
  String dealCompName = "";
  String cardNo = "";
  String cardLimit = "";
  String aprvNum = "";
  String telNum = "";
  String agentType = "";
  String compCode = "";
  String posProcNo = "";
  String orgPosProcNo = "";
  String msg = "";
  String filler = "";
}

/// 共通 パケットデータ 制御コード部
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_CTRL
class CapsPqvicCtrl {
  String id = "";
  String flag = "";
  String filler = "";
}

/// オーソリ電文 伝送制御部
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_TRANS_CTRL_OUTHORI
class CapsPqvicTransCtrlOuthori {
  String len = "";
  String judgeCd = "";
  String tranDatetime = "";
  String errCd = "";
  String filller = "";
}

/// オーソリ電文 業務データ部 業務ヘッダ
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_DUTY_HEAD_OUTHORI
class CapsPqvicDutyHeadOuthori {
  /// 電文レングス
  String len = "";
  /// 電文種別
  String type = "";
  /// エラーコード
  String errCd = "";
  /// 予備
  String filller = "";
  /// 端末識別コード
  String macId = "";
  /// 取引日付
  String tranDatetime = "";
  /// 端末SEQNo
  String seqNo = "";
  /// 端末メーカーコード
  String makerCd = "";
  /// 店舗コード
  String streCd = "";
  /// 披仕向会社名称
  String cardCompName = "";
  /// 予備
  String filller2 = "";
}

/// オーソリ電文 業務データ部 データ
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_DUTY_DATA_OUTHORI
class CapsPqvicDutyDataOuthori {
  /// 端末機識別番号
  String macId = "";
  /// 取引日付
  String tranDatetime = "";
  /// 端末SEQNo
  String seqNo = "";
  /// スキーム区分
  String schemeType = "";
  /// 業務区分
  String businessType = "";
  /// 電文区分
  String dataType = "";
  /// 承認区分
  String consType = "";
  /// オンライン送信先センタ区分
  String centerType = "";
  /// 精査日~オーソリ判定センタID
  String adviceData = "";
  /// カード区分
  String cardType = "";
  /// エンコード内容
  String encode = "";
  /// 披仕向会社コード
  String compCd = "";
  /// 会員番号
  String memberCode = "";
  /// 有効期限
  String validTerm = "";
  /// 暗証番号
  String pin = "";
  /// 商品コード
  String itemCode = "";
  /// POSデータコード
  String posdataCode = "";
  /// メッセージ理由コード
  String messageCode = "";
  /// 加盟店会社コード
  String menberStrCorpCode = "";
  /// 加盟店業種コード
  String menberStrTypeCode = "";
  /// 金額
  String salePrice = "";
  /// 支払区分コード
  String paytypeCode = "";
  /// 支払方法明細
  String payway = "";
  /// 伝票番号
  String receiptNo = "";
  /// 取消元伝票番号
  String voidReceiptNumber = "";
  /// 取消返品区分
  String voidType = "";
  /// 取消元業務区分
  String voidBusinessType = "";
  /// 承認番号
  String admitNumber = "";
  /// センターエラーコード
  String centerErrCode = "";
  /// 加盟店番号
  String menberStrNumber = "";
  /// 端末出力データ
  String putputData = "";
  /// 加盟店名称
  String menberStrName = "";
  /// 所在都市名
  String city = "";
  /// セキュリティーコード使用フラグ
  String securityFlg1 = "";
  /// セキュリティーコード端末入力可否
  String securityFlg2 = "";
  /// セキュリティーコード店員入力有無
  String securityFlg3 = "";
  /// セキュリティーコード
  String securityCode = "";
  /// JIS2使用フラグ
  String jis2Flg = "";
  /// JIS2端末読取機能有無
  String jis2Func = "";
  /// JIS2面情報有無
  String jis2DataFlg = "";
  /// JIS2面
  String jis2Data = "";
  /// JIS2カード情報1
  String jis2Data1 = "";
  /// JIS2カード情報2
  String jis2Data2 = "";
  /// JIS2カード情報3
  String jis2Data3 = "";
  /// 端末付帯情報
  String filler = "";
}

/// オーソリ電文 全体 送信
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_OUTHORI_TX
class CapsPqvicOuthoriTx {
  CapsPqvicCtrl ctrl = CapsPqvicCtrl();
  String length1 = "";
  CapsPqvicTransCtrlOuthori ctrlCert = CapsPqvicTransCtrlOuthori();
  String length2 = "";
  CapsPqvicDutyHeadOuthori dutyHead = CapsPqvicDutyHeadOuthori();
  CapsPqvicDutyDataOuthori dutyDataOuthori = CapsPqvicDutyDataOuthori();
  String padd = "";
  String sha1 = "";
}

/// オーソリ電文 全体 受信
/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_PQVIC_OUTHORI_RX
class CapsPqvicOuthoriRx {
  CapsPqvicCtrl ctrl = CapsPqvicCtrl();
  String length1 = "";
  CapsPqvicTransCtrlOuthori ctrlCert = CapsPqvicTransCtrlOuthori();
  String length2 = "";
  CapsPqvicDutyHeadOuthori dutyHead = CapsPqvicDutyHeadOuthori();
  CapsPqvicDutyDataOuthori dutyDataOuthori = CapsPqvicDutyDataOuthori();
  String padd = "";
  String sha1 = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_CAFIS_HEAD
class CapsCafisHead {
  /// 業務コード
  String bizCode = "";
  /// システム領域1
  String system1 = "";
  /// 通信ID
  String commId = "";
  /// 処理区分
  String procDiv = "";
  /// システム領域2
  String system2 = "";
  /// リターンコード
  String retCode = "";
  /// エラーコード
  String errCode = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_CAFIS_S
class CapsCafisS {
  /// ヘッダー
  CapsCafisHead head = CapsCafisHead();
  /// 業務区分
  String bizType = "";
  /// 端末処理通番
  String posProcNo = "";
  /// カード区分
  String cardType = "";
  /// エンコード内容
  String encode = "";
  /// 暗証番号
  String password = "";
  /// 商品コード
  String itemCode = "";
  /// 金額
  String saleAmt = "";
  /// 税送料
  String taxCarr = "";
  /// セパレーター
  String sep = "";
  /// 明細情報
  String detail = "";
  /// CAFIS用端末通番
  String cafisPosNo = "";
  /// 承認区分
  String admitType = "";
  /// 承認番号
  String admitNumber = "";
  /// 端末メーカコード
  String posMkrCode = "";
  /// 端末処理日付
  String posDatetime = "";
  /// 予備エリア
  String filArea = "";
  /// 被仕向会社コード
  String induceCode = "";
  /// 予約エリア
  String reserve = "";
  /// 拡張データ部用エリア
  String data = "";
  /// 予備
  String filler = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_CAFIS_E
class CapsCafisE {
  /// ヘッダー
  CapsCafisHead head = CapsCafisHead();
  /// CAFISエラーコード
  String cafisErrCode = "";
  /// 処理日付
  String srvProcDate = "";
  /// 処理時刻
  String srvProcTime = "";
  /// CAFIA処理通番
  String cafisProcNo = "";
  /// カード区分
  String cardType = "";
  /// IDマーク
  String idMark = "";
  /// 業態コード
  String bizCondCode = "";
  /// 取引会社コード
  String dealCompCode = "";
  /// 取引会社名称
  String dealCompName = "";
  /// 会員番号
  String cardNo = "";
  /// 有効期間
  String cardLimit = "";
  /// 承認番号
  String admitNumber = "";
  /// 取引会社電話番号
  String telNum = "";
  /// 提携区分
  String agentType = "";
  /// 会社コード
  String compCode = "";
  /// 端末処理通番
  String posProcNo = "";
  /// 元端末処理通番
  String orgPosProcNo = "";
  /// メッセージ
  String msg = "";
  /// 被仕向会社コード
  String induceCode = "";
  /// 予約エリア
  String reserve = "";
  /// 仕向処理通番
  String induceNo = "";
  /// センタ識別番号
  String centerNo = "";
  /// CAFIS処理日付
  String cafisData = "";
  /// 拡張データ部用エリア
  String data = "";
  /// 予備
  String filler = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_CARDNET_HEAD
class CapsCardnetHead {
  /// 業務コード
  String bizCode = "";
  /// システム領域1
  String system1 = "";
  /// 通信ID
  String commId = "";
  /// 処理区分
  String procDiv = "";
  /// システム領域2
  String system2 = "";
  /// レスポンスコード
  String retCode = "";
  /// アクションコード
  String actionCode = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - CAPS_CARDNET_DATA
class CapsCardnetData {
  /// ヘッダー
  CapsCardnetHead head = CapsCardnetHead();
  /// 宛先センタID
  String centerId = "";
  /// 被仕向会社コード
  String induceCode = "";
  /// 仕向区分
  String induceType = "";
  /// 会員番号
  String cardNo = "";
  /// プロセシングコード
  String prossesCode = "";
  /// 取引金額
  String saleAmt = "";
  /// システムトレースオーディットナンバ
  String sto = "";
  /// 現地取引日付
  String dealDatetime = "";
  /// 有効期間
  String cardLimit = "";
  /// 収集日
  String gatherDate = "";
  /// 商品コード
  String itemCode = "";
  /// POSデータコード
  String posDataCode = "";
  /// ファンクションコード
  String functionCode = "";
  /// メッセージ理由コード
  String msg = "";
  /// 加盟店業種コード
  String mbrstoreTypCode = "";
  /// 精査日
  String adviceDate = "";
  /// オリジナル金額
  String orgAmt = "";
  /// 加盟店会社コード
  String mbrstoreCompCode = "";
  /// JIS1情報
  String jis1 = "";
  /// リトリーバルリファレンスナンバ
  String retrievalNo = "";
  /// 承認コード
  String admitNumber = "";
  /// アクションコード
  String actionCode = "";
  /// 加盟店端末番号
  String mbrstoreTrmCode = "";
  /// 加盟店番号
  String mbrstoreCode = "";
  /// 加盟店名／所在地
  String mbrstoreName = "";
  /// JIS2情報
  String jis2 = "";
  /// 国内レスポンスコード
  String domRetCode = "";
  /// 取引通貨コード
  String moneyCode = "";
  /// 入力暗証番号
  String certificateNo = "";
  /// ICカード関連データ長
  String icDataLen = "";
  /// ICカード関連データ
  String icData = "";
  /// オリジナルデータエレメント
  String orgDataElement = "";
  /// オーソリ判定センタID
  String outhoriCenterId = "";
  /// 端末出力データ
  String trmOutputData = "";
  /// 国内使用予約域
  String domUse = "";
  /// 個社使用予約域
  String compUse = "";
  /// カードネット拡張使用域
  String cardnetExData = "";
  /// 予備
  String filler = "";
}

/// 関連tprxソース: regs\inc\rccrdt.h - KY_CRDTIN_STEP
enum KyCrdtInStep{
  NONE(-1),
  INPUT_1ST(0),
  CARD_KIND(1),
  PLES_CARD(2),
  GOOD_THRU(3),
  RECEIT_NO(4),
  PAY_A_WAY(5),
  DIV_BEGIN(6),
  PAY_DIVID(7),
  BONUS_TWO(8),
  BNS_BEGIN(9),
  BONUSUSE1(10),
  BONUS_CNT(11),
  BONUSUSE2(12),
  PAY_KYCHA(13),
  OFF_KYCHA(14),
  RECOGN_NO(15),
  INPUT_END(16),
  NIMOCA_RD(17);

  static KyCrdtInStep getDefine(int id){
    KyCrdtInStep? define =
    KyCrdtInStep.values.firstWhereOrNull((a) => a.cd == id);
    define ??= NONE; // 定義されているものになければnoneを入れておく.
    return define;
  }

  final int cd;
  const KyCrdtInStep(this.cd);
}

/// 関連tprxソース: regs\inc\rccrdt.h - CRDT_TRAN_TYPE
enum CrdtTranType{
  CRDT_TRAN_TYPE_ALIPAY(58),
  CRDT_TRAN_TYPE_LINEPAY(59),
  CRDT_TRAN_TYPE_WECHATPAY(60),
  CRDT_TRAN_TYPE_BARCODE_PAY1(61),
  CRDT_TRAN_TYPE_CANAL_PAY(62),
  CRDT_TRAN_TYPE_FIP_CODEPAY(63),
  CRDT_TRAN_TYPE_MULTIONEPAY(64),
  CRDT_TRAN_TYPE_NETSTARS(66),
  CRDT_TRAN_TYPE_QUIZ(67);

  final int cd;
  const CrdtTranType(this.cd);
}

/// 関連tprxソース: regs\inc\rccrdt.h
class Datas {
/************************************************************************/
/*                      #define Datas                                   */
/************************************************************************/
  static int NORMAL_CRDT = 0;
  static int KASUMI_CRDT = 1;
  static int KANSUP_CRDT = 2;
  static int NAKAGO_CRDT = 3;
  static int SAPDRA_CRDT = 4;
  static int TIFILE_MAX = 200;
  static int January = 0x01;
  static int December = 0x12;
}

/// 関連tprxソース: regs\inc\rccrdt.h
class RcCrdt {
  /************************************************************************/
  /*                      #define Datas                                   */
  /************************************************************************/
  static const			MANUAL_INPUT	=	0;
  static const			MCD_INPUT	=	0;
  static const			IC_INPUT	=	0;

  static const			CARDCREW_ON	=	0;
  static const			CARDCREW_OFF	=	1;

  static const			CARD_KIND_DGT	=	5;
  static const			MEMBER_NO_DGT	=	16;
  static const			GOOD_THRU_DGT	=	4;
  static const			RECEIT_NO_DGT	=	5;
  static const			PQVIC_RECEIT_NO_DGT	=	4;
  static const			PERSON_NO_DGT	=	6;
  static const			YYYYMM	=	0;
  static const			January	=	0;
  static const			December	=	0;
  static const			MILLION	=	0;
  static const			JIS1_ABA	=	0;
  static const			TIFILE_MAX	=	0;

  static const			ORDER_ERRRT	=	-2;
  static const			ORDER_ERROR	=	-1;
  static const			ORDER_RESET	=	0;
  static const			ORDER_REQUEST	=	1;
  static const			ORDER_LOG	=	0;
  static const			ORDER_CHA	=	0;
  static const			ORDER_RECEIVE	=	4;
  static const			ORDER_REQRES	=	5;
  static const			ORDER_SEND	=	0;
  static const			ORDER_REQSCH	=	7;
  static const			ORDER_REQWORK	=	8;
  static const			ORDER_RECWORK	=	9;
  static const			ORDER_SENDWORK	=	10;
  static const			ORDER_REQSUB	=	11;
  static const			ORDER_LOGSEND	=	12;
  static const			ORDER_MULTIPANA_START = 13;
  static const			ORDER_MULTIPANA_END	= 14;

  static const			CARD_REQ	=	0;
  static const			CRDT_REQ	=	0;
  static const			CRDT_CNCL	=	0;
  static const			CRDT_EMV_OFF	=	3;
  static const			CRDT_FALLBACK	=	4;

  static const			NORMAL_CRDT	=	0;
  static const			KASUMI_CRDT	=	1;
  static const			KANSUP_CRDT	=	2;
  static const			NAKAGO_CRDT	=	3;
  static const			SAPDRA_CRDT	=	4;

  static const			KASUMI_AEON	=	1;
  static const			AEON	=	2;

  static const      RECOGN_NO_DGT = 6;
  static const      PQVIC_RECOGN_NO_DGT = 7;
  static const      KEY_INPUT1   = 0x0604;
  static const      KEY_BREAK1   = 0x0608;
  static const      KEY_PAYPREV  =	0x0609;		// 支払方法へ戻るボタン
  static const      LUMP         = 0x0301;
  static const      TWICE        = 0x0302;
  static const      DIVIDE       = 0x0303;
  static const      B_LUMP       = 0x0304;
  static const      B_TWICE      = 0x0305;
  static const      B_USE        = 0x0306;
  static const      RIBO         = 0x0307;
  static const   DIVIDE1     = 0x0401;
  static const   DIVIDE2     = 0x0402;
  static const   DIVIDE3     = 0x0403;
  static const   DIVIDE5     = 0x0404;
  static const   DIVIDE6     = 0x0405;
  static const   DIVIDE10    = 0x0406;
  static const   DIVIDE12    = 0x0407;
  static const   DIVIDE15    = 0x0502;
  static const   DIVIDE18    = 0x0503;
  static const   DIVIDE20    = 0x0504;
  static const   DIVIDE24    = 0x0505;
  static const   DIVIDE30    = 0x0506;
  static const   DIVIDE36    = 0x0507;

  static const   W_B1_PAY1   = 0x0405;
  static const   W_B1_PAY2   = 0x0406;
  static const   W_B1_PAY3   = 0x0407;
  static const   W_B2_PAY1   = 0x0505;
  static const   W_B2_PAY2   = 0x0506;
  static const   W_B2_PAY3   = 0x0507;
  static const   S_B1_PAY1   = 0x0402;
  static const   S_B1_PAY2   = 0x0403;
  static const   S_B1_PAY3   = 0x0404;
  static const   S_B2_PAY1   = 0x0502;
  static const   S_B2_PAY2   = 0x0503;
  static const   S_B2_PAY3   = 0x0504;

  static const   B_USE3      = 0x0403;
  static const   B_USE5      = 0x0404;
  static const   B_USE6      = 0x0405;
  static const   B_USE10     = 0x0406;
  static const   B_USE12     = 0x0407;
  static const   B_USE15     = 0x0502;
  static const   B_USE18     = 0x0503;
  static const   B_USE20     = 0x0504;
  static const   B_USE24     = 0x0505;
  static const   B_USE30     = 0x0506;
  static const   B_USE36     = 0x0507;

  static const   BONUSCNT1   = 0x0401;
  static const   BONUSCNT2   = 0x0402;
  static const   BONUSCNT3   = 0x0403;
  static const   BONUSCNT4   = 0x0404;
  static const   BONUSCNT5   = 0x0405;
  static const   BONUSCNT6   = 0x0406;

  static const   NOMONTH    = 0x0401;
  static const   MONTH1     = 0x0403;
  static const   MONTH2     = 0x0404;
  static const   MONTH3     = 0x0405;
  static const   MONTH4     = 0x0406;
  static const   MONTH5     = 0x0407;
  static const   MONTH6     = 0x0408;
  static const   MONTH7     = 0x0502;
  static const   MONTH8     = 0x0503;
  static const   MONTH9     = 0x0504;
  static const   MONTH10    = 0x0505;
  static const   MONTH11    = 0x0506;
  static const   MONTH12    = 0x0507;

/************************************************************************/
/*                        Static Const                                  */
/************************************************************************/
  static const INTERNAL_JIS1 = "9392";

  static int getPayPrice() {
    return RxLogCalc.rxCalcStlTaxAmt(RegsMem());
  }
  static NttAspTiFile nttf = SystemFunc.readAtSingl().tranInfFile;
  static CardCrewReqCom cReq = CardCrewReqCom();
  static CardCrewRcvCom cRcv = CardCrewRcvCom();
  static CapsS capsReq = CapsS();
  static CapsE capsRcv = CapsE();
  static CapsPqvicOuthoriTx	pqvicReq = CapsPqvicOuthoriTx();
  static CapsPqvicOuthoriRx pqvicRcv = CapsPqvicOuthoriRx();
  static CapsCafisS capsCafisReq = CapsCafisS();
  static CapsCafisE capsCafisRcv = CapsCafisE();
  static CapsCardnetData capsCardnetRcv = CapsCardnetData();
  static CardCrewRcvComVega cRcvVega = CardCrewRcvComVega();
  static NttAspRxData nSet = NttAspRxData();
  static CardCrewRcvCard CRCV = CardCrewRcvCard();
  static CardCrewReqVEGA cReqVEGA = CardCrewReqVEGA();

  /// 送受信する電文データからクラスデータに変換する（CardCrewReqCom）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CardCrewReqCom）
  static CardCrewReqCom getCardCrewReqCom(String str) {
    CardCrewReqCom ret = CardCrewReqCom();
    ret.dataType = str.substring(0, 2);
    ret.dataLen = str.substring(2, 4);
    ret.businessCode = str.substring(4, 11);
    ret.compId = str.substring(11, 18);
    ret.correspondId = str.substring(18, 19);
    ret.reserve = str.substring(19, 25);
    ret.returnCode = str.substring(25, 27);
    ret.continueFlg = str.substring(27, 29);
    ret.macId = str.substring(29, 37);
    ret.regCreditNumber = str.substring(37, 42);
    ret.businessKind = str.substring(42, 43);
    ret.voidKind = str.substring(43, 44);
    ret.saleDate = str.substring(44, 50);
    ret.salePrice = str.substring(50, 58);
    ret.taxPrice = str.substring(58, 65);
    ret.orgCreditNumber = str.substring(65, 70);
    ret.payKind = str.substring(70, 72);
    ret.payDetail = str.substring(72, 156);
    ret.itemCode = str.substring(156, 163);
    ret.admitKind = str.substring(163, 164);
    ret.admitNumber = str.substring(164, 172);
    ret.cardKind = str.substring(172, 173);
    ret.cardDetail = str.substring(173, 272);
    ret.cardNumber = str.substring(272, 276);
    ret.cycleNumber = str.substring(276, 279);
    ret.staffNumber = str.substring(279, 284);
    ret.justPoint = str.substring(284, 292);
    ret.memo1 = str.substring(292, 302);
    ret.memo2 = str.substring(302, 312);
    ret.saleQtyCounter = str.substring(312, 315);
    ret.salePrcCounter = str.substring(315, 323);
    ret.voidQtyCounter = str.substring(323, 326);
    ret.voidPrcCounter = str.substring(326, 334);
    ret.key1 = str.substring(334, 342);
    ret.key2 = str.substring(342, 350);
    ret.telNumber = str.substring(350, 365);
    ret.clearFlg = str.substring(365, 366);
    ret.cardcompJudge = str.substring(366, 381);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CardCrewReqAdd）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CardCrewReqAdd）
  static CardCrewReqAdd getCardCrewReqAdd(String str) {
    CardCrewReqAdd ret = CardCrewReqAdd();
    ret.businessDate = str.substring(0, 6);
    ret.orgcreditDatetime = str.substring(6, 12);
    ret.buseBcnt = str.substring(12, 13);
    ret.crdtvoidFlg = str.substring(13, 14);
    ret.voidDetail = str.substring(14, 98);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CardCrewRcvCom）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CardCrewRcvCom）
  static CardCrewRcvCom getCardCrewRcvCom(String str) {
    CardCrewRcvCom ret = CardCrewRcvCom();
    ret.dataType = str.substring(0, 2);
    ret.dataLen = str.substring(2, 4);
    ret.businessCode = str.substring(4, 11);
    ret.compId = str.substring(11, 18);
    ret.correspondId = str.substring(18, 19);
    ret.reserve = str.substring(19, 25);
    ret.returnCode = str.substring(25, 27);
    ret.continueFlg = str.substring(27, 29);
    ret.macId = str.substring(29, 37);
    ret.regCreditNumber = str.substring(37, 42);
    ret.tranDate = str.substring(42, 48);
    ret.tranTime = str.substring(48, 54);
    ret.cafisCreditNumber = str.substring(54, 60);
    ret.cardcompCode = str.substring(60, 64);
    ret.memberCode = str.substring(64, 80);
    ret.validTerm = str.substring(80, 84);
    ret.formCode = str.substring(84, 85);
    ret.useCardKind = str.substring(85, 86);
    ret.idMark = str.substring(86, 87);
    ret.cardcompName = str.substring(87, 97);
    ret.admitNumber = str.substring(97, 104);
    ret.regCompCode = str.substring(104, 106);
    ret.cardcompTel = str.substring(106, 121);
    ret.errCode = str.substring(121, 124);
    ret.message1 = str.substring(124, 147);
    ret.message2 = str.substring(147, 170);
    ret.affiliateKind = str.substring(170, 171);
    ret.clearFlg = str.substring(171, 172);
    ret.saleQtyCounter = str.substring(172, 175);
    ret.salePrcCounter = str.substring(175, 183);
    ret.voidQtyCounter = str.substring(183, 186);
    ret.voidPrcCounter = str.substring(186, 194);
    ret.customerCode = str.substring(194, 210);
    ret.bankbookFixed = str.substring(210, 220);
    ret.bankbookOption = str.substring(220, 230);
    ret.printBankCode = str.substring(230, 234);
    ret.printBankOffice = str.substring(234, 238);
    ret.printBankNumber = str.substring(238, 252);
    ret.printBankName = str.substring(252, 262);
    ret.ringBankName = str.substring(262, 266);
    ret.ringStoreCode = str.substring(266, 273);
    ret.ringStoreSub = str.substring(273, 277);
    ret.totalPoint = str.substring(277, 285);
    ret.cycleNumber = str.substring(285, 288);
    ret.centerCheck = str.substring(288, 289);
    ret.cafisTrandate = str.substring(289, 293);
    ret.key1 = str.substring(293, 301);
    ret.key2 = str.substring(301, 309);
    ret.cassState = str.substring(309, 310);
    ret.subCode = str.substring(310, 314);
    ret.spare = str.substring(314, 350);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsS）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsS）
  static CapsS getCapsS(String str) {
    CapsS ret = CapsS();
    ret.head.cmd = str.substring(0, 3);
    ret.head.dataLen = str.substring(3, 7);
    ret.head.posName = str.substring(7, 15);
    ret.head.macNo = str.substring(15, 19);
    ret.head.procNo = str.substring(19, 25);
    ret.bizCode = str.substring(25, 32);
    ret.posId = str.substring(32, 39);
    ret.commType = str.substring(39, 40);
    ret.lanAdd = str.substring(40, 42);
    ret.lanNode = str.substring(42, 44);
    ret.portNum = str.substring(44, 46);
    ret.retCode = str.substring(46, 48);
    ret.errCode = str.substring(48, 50);
    ret.posProcNo = str.substring(50, 55);
    ret.bizType = str.substring(55, 56);
    ret.cardType = str.substring(56, 57);
    ret.encData = str.substring(57, 126);
    ret.password = str.substring(126, 130);
    ret.itemCode = str.substring(130, 137);
    ret.saleAmt = str.substring(137, 145);
    ret.taxCarr = str.substring(145, 152);
    ret.sep = str.substring(152, 153);
    ret.detail = str.substring(153, 235);
    ret.cgAbnmCode = str.substring(235, 237);
    ret.cafisPosNo = str.substring(237, 242);
    ret.aprvType = str.substring(242, 243);
    ret.aprvNum = str.substring(243, 250);
    ret.posMkrCode = str.substring(250, 253);
    ret.ntSrvNo = str.substring(253, 261);
    ret.induceCode = str.substring(261, 272);
    ret.filler = str.substring(272, 512);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsE）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsE）
  static CapsE getCapsE(String str) {
    CapsE ret = CapsE();
    ret.head.cmd = str.substring(0, 3);
    ret.head.dataLen = str.substring(3, 7);
    ret.head.posName = str.substring(7, 15);
    ret.head.macNo = str.substring(15, 19);
    ret.head.procNo = str.substring(19, 25);
    ret.bizCode = str.substring(25, 32);
    ret.posId = str.substring(32, 39);
    ret.commType = str.substring(39, 40);
    ret.lanAdd = str.substring(40, 42);
    ret.lanNode = str.substring(42, 44);
    ret.portNum = str.substring(44, 46);
    ret.retCode = str.substring(46, 48);
    ret.procCode = str.substring(48, 50);
    ret.cafisErrCode = str.substring(50, 53);
    ret.srvProcDate = str.substring(53, 59);
    ret.srvProcTime = str.substring(59, 65);
    ret.cafisProcNo = str.substring(65, 71);
    ret.cardType = str.substring(71, 72);
    ret.idMark = str.substring(72, 73);
    ret.bizCondCode = str.substring(73, 74);
    ret.dealCompCode = str.substring(74, 78);
    ret.dealCompName = str.substring(78, 88);
    ret.cardNo = str.substring(88, 104);
    ret.cardLimit = str.substring(104, 108);
    ret.aprvNum = str.substring(108, 115);
    ret.telNum = str.substring(115, 127);
    ret.agentType = str.substring(127, 128);
    ret.compCode = str.substring(128, 130);
    ret.posProcNo = str.substring(130, 135);
    ret.orgPosProcNo = str.substring(135, 140);
    ret.msg = str.substring(140, 163);
    ret.filler = str.substring(163, 512);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsPqvicOuthoriTx）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsPqvicOuthoriTx）
  static CapsPqvicOuthoriTx getCapsPqvicOuthoriTx(String str) {
    CapsPqvicOuthoriTx ret = CapsPqvicOuthoriTx();
    ret.ctrl.id = str.substring(0, 4);
    ret.ctrl.flag = str.substring(4, 5);
    ret.ctrl.filler = str.substring(5, 16);
    ret.length1 = str.substring(16, 20);
    ret.ctrlCert.len = str.substring(20, 24);
    ret.ctrlCert.judgeCd = str.substring(24, 28);
    ret.ctrlCert.tranDatetime = str.substring(28, 43);
    ret.ctrlCert.errCd = str.substring(45, 48);
    ret.ctrlCert.filller = str.substring(48, 150);
    ret.length2 = str.substring(150, 154);
    ret.dutyHead.len = str.substring(154, 158);
    ret.dutyHead.type = str.substring(158, 161);
    ret.dutyHead.errCd = str.substring(161, 164);
    ret.dutyHead.filller = str.substring(164, 202);
    ret.dutyHead.macId = str.substring(202, 215);
    ret.dutyHead.tranDatetime = str.substring(215, 227);
    ret.dutyHead.seqNo = str.substring(227, 232);
    ret.dutyHead.makerCd = str.substring(232, 235);
    ret.dutyHead.streCd = str.substring(235, 245);
    ret.dutyHead.cardCompName = str.substring(245, 277);
    ret.dutyHead.filller2 = str.substring(277, 282);
    ret.dutyDataOuthori.macId = str.substring(282, 295);
    ret.dutyDataOuthori.tranDatetime = str.substring(295, 307);
    ret.dutyDataOuthori.seqNo = str.substring(307, 312);
    ret.dutyDataOuthori.schemeType = str.substring(312, 314);
    ret.dutyDataOuthori.businessType = str.substring(314, 315);
    ret.dutyDataOuthori.dataType = str.substring(315, 316);
    ret.dutyDataOuthori.consType = str.substring(316, 317);
    ret.dutyDataOuthori.centerType = str.substring(317, 318);
    ret.dutyDataOuthori.adviceData = str.substring(318, 355);
    ret.dutyDataOuthori.cardType = str.substring(355, 356);
    ret.dutyDataOuthori.encode = str.substring(356, 425);
    ret.dutyDataOuthori.compCd = str.substring(425, 436);
    ret.dutyDataOuthori.memberCode = str.substring(436, 452);
    ret.dutyDataOuthori.validTerm = str.substring(452, 456);
    ret.dutyDataOuthori.pin = str.substring(456, 460);
    ret.dutyDataOuthori.itemCode = str.substring(460, 467);
    ret.dutyDataOuthori.posdataCode = str.substring(467, 479);
    ret.dutyDataOuthori.messageCode = str.substring(479, 483);
    ret.dutyDataOuthori.menberStrCorpCode = str.substring(483, 494);
    ret.dutyDataOuthori.menberStrTypeCode = str.substring(494, 498);
    ret.dutyDataOuthori.salePrice = str.substring(498, 506);
    ret.dutyDataOuthori.paytypeCode = str.substring(506, 508);
    ret.dutyDataOuthori.payway = str.substring(508, 590);
    ret.dutyDataOuthori.receiptNo = str.substring(590, 595);
    ret.dutyDataOuthori.voidReceiptNumber = str.substring(595, 600);
    ret.dutyDataOuthori.voidType = str.substring(600, 601);
    ret.dutyDataOuthori.voidBusinessType = str.substring(601, 602);
    ret.dutyDataOuthori.admitNumber = str.substring(602, 609);
    ret.dutyDataOuthori.centerErrCode = str.substring(609, 612);
    ret.dutyDataOuthori.menberStrNumber = str.substring(612, 627);
    ret.dutyDataOuthori.putputData = str.substring(627, 774);
    ret.dutyDataOuthori.menberStrName = str.substring(774, 797);
    ret.dutyDataOuthori.city = str.substring(797, 811);
    ret.dutyDataOuthori.securityFlg1 = str.substring(811, 812);
    ret.dutyDataOuthori.securityFlg2 = str.substring(812, 813);
    ret.dutyDataOuthori.securityFlg3 = str.substring(813, 814);
    ret.dutyDataOuthori.securityCode = str.substring(814, 818);
    ret.dutyDataOuthori.jis2Flg = str.substring(818, 819);
    ret.dutyDataOuthori.jis2Func = str.substring(819, 820);
    ret.dutyDataOuthori.jis2DataFlg = str.substring(820, 821);
    ret.dutyDataOuthori.jis2Data = str.substring(821, 890);
    ret.dutyDataOuthori.jis2Data1 = str.substring(890, 891);
    ret.dutyDataOuthori.jis2Data2 = str.substring(891, 892);
    ret.dutyDataOuthori.jis2Data3 = str.substring(892, 896);
    ret.dutyDataOuthori.filler = str.substring(896, 982);
    ret.padd = str.substring(982, 986);
    ret.sha1 = str.substring(986, 1006);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsPqvicOuthoriRx）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsPqvicOuthoriRx）
  static CapsPqvicOuthoriRx getCapsPqvicOuthoriRx(String str) {
    CapsPqvicOuthoriRx ret = CapsPqvicOuthoriRx();
    ret.ctrl.id = str.substring(0, 4);
    ret.ctrl.flag = str.substring(4, 5);
    ret.ctrl.filler = str.substring(5, 16);
    ret.length1 = str.substring(16, 20);
    ret.ctrlCert.len = str.substring(20, 24);
    ret.ctrlCert.judgeCd = str.substring(24, 28);
    ret.ctrlCert.tranDatetime = str.substring(28, 43);
    ret.ctrlCert.errCd = str.substring(45, 48);
    ret.ctrlCert.filller = str.substring(48, 150);
    ret.length2 = str.substring(150, 154);
    ret.dutyHead.len = str.substring(154, 158);
    ret.dutyHead.type = str.substring(158, 161);
    ret.dutyHead.errCd = str.substring(161, 164);
    ret.dutyHead.filller = str.substring(164, 202);
    ret.dutyHead.macId = str.substring(202, 215);
    ret.dutyHead.tranDatetime = str.substring(215, 227);
    ret.dutyHead.seqNo = str.substring(227, 232);
    ret.dutyHead.makerCd = str.substring(232, 235);
    ret.dutyHead.streCd = str.substring(235, 245);
    ret.dutyHead.cardCompName = str.substring(245, 277);
    ret.dutyHead.filller2 = str.substring(277, 282);
    ret.dutyDataOuthori.macId = str.substring(282, 295);
    ret.dutyDataOuthori.tranDatetime = str.substring(295, 307);
    ret.dutyDataOuthori.seqNo = str.substring(307, 312);
    ret.dutyDataOuthori.schemeType = str.substring(312, 314);
    ret.dutyDataOuthori.businessType = str.substring(314, 315);
    ret.dutyDataOuthori.dataType = str.substring(315, 316);
    ret.dutyDataOuthori.consType = str.substring(316, 317);
    ret.dutyDataOuthori.centerType = str.substring(317, 318);
    ret.dutyDataOuthori.adviceData = str.substring(318, 355);
    ret.dutyDataOuthori.cardType = str.substring(355, 356);
    ret.dutyDataOuthori.encode = str.substring(356, 425);
    ret.dutyDataOuthori.compCd = str.substring(425, 436);
    ret.dutyDataOuthori.memberCode = str.substring(436, 452);
    ret.dutyDataOuthori.validTerm = str.substring(452, 456);
    ret.dutyDataOuthori.pin = str.substring(456, 460);
    ret.dutyDataOuthori.itemCode = str.substring(460, 467);
    ret.dutyDataOuthori.posdataCode = str.substring(467, 479);
    ret.dutyDataOuthori.messageCode = str.substring(479, 483);
    ret.dutyDataOuthori.menberStrCorpCode = str.substring(483, 494);
    ret.dutyDataOuthori.menberStrTypeCode = str.substring(494, 498);
    ret.dutyDataOuthori.salePrice = str.substring(498, 506);
    ret.dutyDataOuthori.paytypeCode = str.substring(506, 508);
    ret.dutyDataOuthori.payway = str.substring(508, 590);
    ret.dutyDataOuthori.receiptNo = str.substring(590, 595);
    ret.dutyDataOuthori.voidReceiptNumber = str.substring(595, 600);
    ret.dutyDataOuthori.voidType = str.substring(600, 601);
    ret.dutyDataOuthori.voidBusinessType = str.substring(601, 602);
    ret.dutyDataOuthori.admitNumber = str.substring(602, 609);
    ret.dutyDataOuthori.centerErrCode = str.substring(609, 612);
    ret.dutyDataOuthori.menberStrNumber = str.substring(612, 627);
    ret.dutyDataOuthori.putputData = str.substring(627, 774);
    ret.dutyDataOuthori.menberStrName = str.substring(774, 797);
    ret.dutyDataOuthori.city = str.substring(797, 811);
    ret.dutyDataOuthori.securityFlg1 = str.substring(811, 812);
    ret.dutyDataOuthori.securityFlg2 = str.substring(812, 813);
    ret.dutyDataOuthori.securityFlg3 = str.substring(813, 814);
    ret.dutyDataOuthori.securityCode = str.substring(814, 818);
    ret.dutyDataOuthori.jis2Flg = str.substring(818, 819);
    ret.dutyDataOuthori.jis2Func = str.substring(819, 820);
    ret.dutyDataOuthori.jis2DataFlg = str.substring(820, 821);
    ret.dutyDataOuthori.jis2Data = str.substring(821, 890);
    ret.dutyDataOuthori.jis2Data1 = str.substring(890, 891);
    ret.dutyDataOuthori.jis2Data2 = str.substring(891, 892);
    ret.dutyDataOuthori.jis2Data3 = str.substring(892, 896);
    ret.dutyDataOuthori.filler = str.substring(896, 982);
    ret.padd = str.substring(982, 986);
    ret.sha1 = str.substring(986, 1006);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsCafisS）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsCafisS）
  static CapsCafisS getCapsCafisS(String str) {
    CapsCafisS ret = CapsCafisS();
    ret.head.bizCode = str.substring(0, 7);
    ret.head.system1 = str.substring(7, 14);
    ret.head.commId = str.substring(14, 15);
    ret.head.procDiv = str.substring(15, 16);
    ret.head.system2 = str.substring(16, 21);
    ret.head.retCode = str.substring(21, 23);
    ret.head.errCode = str.substring(23, 25);
    ret.bizType = str.substring(25, 26);
    ret.posProcNo = str.substring(26, 31);
    ret.cardType = str.substring(31, 32);
    ret.encode = str.substring(32, 101);
    ret.password = str.substring(101, 105);
    ret.itemCode = str.substring(105, 112);
    ret.saleAmt = str.substring(112, 120);
    ret.taxCarr = str.substring(120, 127);
    ret.sep = str.substring(127, 128);
    ret.detail = str.substring(128, 212);
    ret.cafisPosNo = str.substring(212, 217);
    ret.admitType = str.substring(217, 218);
    ret.admitNumber = str.substring(218, 225);
    ret.posMkrCode = str.substring(225, 228);
    ret.posDatetime = str.substring(228, 234);
    ret.filArea = str.substring(234, 236);
    ret.induceCode = str.substring(236, 247);
    ret.reserve = str.substring(247, 258);
    ret.data = str.substring(258, 1008);
    ret.filler = str.substring(1008, 1024);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsCafisE）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsCafisE）
  static CapsCafisE getCapsCafisE(String str) {
    CapsCafisE ret = CapsCafisE();
    ret.head.bizCode = str.substring(0, 7);
    ret.head.system1 = str.substring(7, 14);
    ret.head.commId = str.substring(14, 15);
    ret.head.procDiv = str.substring(15, 16);
    ret.head.system2 = str.substring(16, 21);
    ret.head.retCode = str.substring(21, 23);
    ret.head.errCode = str.substring(23, 25);
    ret.cafisErrCode = str.substring(25, 28);
    ret.srvProcDate = str.substring(28, 34);
    ret.srvProcTime = str.substring(34, 40);
    ret.cafisProcNo = str.substring(40, 44);
    ret.cardType = str.substring(44, 45);
    ret.idMark = str.substring(45, 46);
    ret.bizCondCode = str.substring(46, 47);
    ret.dealCompCode = str.substring(47, 51);
    ret.dealCompName = str.substring(51, 61);
    ret.cardNo = str.substring(61, 77);
    ret.cardLimit = str.substring(77, 81);
    ret.admitNumber = str.substring(81, 88);
    ret.telNum = str.substring(88, 103);
    ret.agentType = str.substring(103, 104);
    ret.compCode = str.substring(104, 106);
    ret.posProcNo = str.substring(106, 111);
    ret.orgPosProcNo = str.substring(111, 116);
    ret.msg = str.substring(116, 139);
    ret.induceCode = str.substring(139, 150);
    ret.reserve = str.substring(150, 161);
    ret.induceNo = str.substring(161, 163);
    ret.centerNo = str.substring(163, 165);
    ret.cafisData = str.substring(165, 169);
    ret.data = str.substring(169, 919);
    ret.filler = str.substring(919, 1018);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CapsCardnetData）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CapsCardnetData）
  static CapsCardnetData getCapsCardnetData(String str) {
    CapsCardnetData ret = CapsCardnetData();
    ret.head.bizCode = str.substring(0, 7);
    ret.head.system1 = str.substring(7, 14);
    ret.head.commId = str.substring(14, 15);
    ret.head.procDiv = str.substring(15, 16);
    ret.head.system2 = str.substring(16, 21);
    ret.head.retCode = str.substring(21, 24);
    ret.head.actionCode = str.substring(24, 27);
    ret.centerId = str.substring(27, 38);
    ret.induceCode = str.substring(38, 49);
    ret.induceType = str.substring(49, 51);
    ret.cardNo = str.substring(51, 70);
    ret.prossesCode = str.substring(70, 76);
    ret.saleAmt = str.substring(76, 88);
    ret.sto = str.substring(88, 94);
    ret.dealDatetime = str.substring(94, 106);
    ret.cardLimit = str.substring(106, 110);
    ret.gatherDate = str.substring(110, 114);
    ret.itemCode = str.substring(114, 118);
    ret.posDataCode = str.substring(118, 130);
    ret.functionCode = str.substring(130, 133);
    ret.msg = str.substring(133, 137);
    ret.mbrstoreTypCode = str.substring(137, 141);
    ret.adviceDate = str.substring(141, 147);
    ret.orgAmt = str.substring(147, 171);
    ret.mbrstoreCompCode = str.substring(171, 182);
    ret.jis1 = str.substring(182, 219);
    ret.retrievalNo = str.substring(219, 231);
    ret.admitNumber = str.substring(231, 237);
    ret.actionCode = str.substring(237, 240);
    ret.mbrstoreTrmCode = str.substring(240, 248);
    ret.mbrstoreCode = str.substring(248, 263);
    ret.mbrstoreName = str.substring(263, 303);
    ret.jis2 = str.substring(303, 372);
    ret.domRetCode = str.substring(372, 377);
    ret.moneyCode = str.substring(377, 380);
    ret.certificateNo = str.substring(380, 388);
    ret.icDataLen = str.substring(388, 391);
    ret.icData = str.substring(391, 646);
    ret.orgDataElement = str.substring(646, 681);
    ret.outhoriCenterId = str.substring(681, 692);
    ret.trmOutputData = str.substring(692, 839);
    ret.domUse = str.substring(839, 960);
    ret.compUse = str.substring(960, 1081);
    ret.cardnetExData = str.substring(1081, 1205);
    ret.filler = str.substring(1205, 1265);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CardCrewRcvComVega）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CardCrewRcvComVega）
  static CardCrewRcvComVega getCardCrewRcvComVega(String str) {
    CardCrewRcvComVega ret = CardCrewRcvComVega();
    ret.rcvCom.dataType = str.substring(0, 2);
    ret.rcvCom.dataLen = str.substring(2, 4);
    ret.rcvCom.businessCode = str.substring(4, 11);
    ret.rcvCom.compId = str.substring(11, 18);
    ret.rcvCom.correspondId = str.substring(18, 19);
    ret.rcvCom.reserve = str.substring(19, 25);
    ret.rcvCom.returnCode = str.substring(25, 27);
    ret.rcvCom.continueFlg = str.substring(27, 29);
    ret.rcvCom.macId = str.substring(29, 37);
    ret.rcvCom.regCreditNumber = str.substring(37, 42);
    ret.rcvCom.tranDate = str.substring(42, 48);
    ret.rcvCom.tranTime = str.substring(48, 54);
    ret.rcvCom.cafisCreditNumber = str.substring(54, 60);
    ret.rcvCom.cardcompCode = str.substring(60, 64);
    ret.rcvCom.memberCode = str.substring(64, 80);
    ret.rcvCom.validTerm = str.substring(80, 84);
    ret.rcvCom.formCode = str.substring(84, 85);
    ret.rcvCom.useCardKind = str.substring(85, 86);
    ret.rcvCom.idMark = str.substring(86, 87);
    ret.rcvCom.cardcompName = str.substring(87, 97);
    ret.rcvCom.admitNumber = str.substring(97, 104);
    ret.rcvCom.regCompCode = str.substring(104, 106);
    ret.rcvCom.cardcompTel = str.substring(106, 121);
    ret.rcvCom.errCode = str.substring(121, 124);
    ret.rcvCom.message1 = str.substring(124, 147);
    ret.rcvCom.message2 = str.substring(147, 170);
    ret.rcvCom.affiliateKind = str.substring(170, 171);
    ret.rcvCom.clearFlg = str.substring(171, 172);
    ret.rcvCom.saleQtyCounter = str.substring(172, 175);
    ret.rcvCom.salePrcCounter = str.substring(175, 183);
    ret.rcvCom.voidQtyCounter = str.substring(183, 186);
    ret.rcvCom.voidPrcCounter = str.substring(186, 194);
    ret.rcvCom.customerCode = str.substring(194, 210);
    ret.rcvCom.bankbookFixed = str.substring(210, 220);
    ret.rcvCom.bankbookOption = str.substring(220, 230);
    ret.rcvCom.printBankCode = str.substring(230, 234);
    ret.rcvCom.printBankOffice = str.substring(234, 238);
    ret.rcvCom.printBankNumber = str.substring(238, 252);
    ret.rcvCom.printBankName = str.substring(252, 262);
    ret.rcvCom.ringBankName = str.substring(262, 266);
    ret.rcvCom.ringStoreCode = str.substring(266, 273);
    ret.rcvCom.ringStoreSub = str.substring(273, 277);
    ret.rcvCom.totalPoint = str.substring(277, 285);
    ret.rcvCom.cycleNumber = str.substring(285, 288);
    ret.rcvCom.centerCheck = str.substring(288, 289);
    ret.rcvCom.cafisTrandate = str.substring(289, 293);
    ret.rcvCom.key1 = str.substring(293, 301);
    ret.rcvCom.key2 = str.substring(301, 309);
    ret.rcvCom.cassState = str.substring(309, 310);
    ret.rcvCom.subCode = str.substring(310, 314);
    ret.rcvCom.spare = str.substring(314, 350);
    ret.rcvAdd.terminalId = str.substring(350, 363);
    ret.rcvAdd.recSignless = str.substring(363, 364);
    ret.rcvAdd.icPrintSignless = str.substring(364, 365);
    ret.rcvAdd.icMsType = str.substring(365, 366);
    ret.rcvAdd.comfirmedPin = str.substring(366, 367);
    ret.rcvAdd.aid = str.substring(367, 380);
    ret.rcvAdd.brandName = str.substring(380, 412);
    return ret;
  }

  /// 送受信する電文データからクラスデータに変換する（CardCrewRcvCard）
  /// 引数:変換前となる文字列（RxSocket.data）
  /// 戻値:変換後のクラスデータ（CardCrewRcvCard）
  static CardCrewRcvCard getCardCrewRcvCard(String str) {
    CardCrewRcvCard ret = CardCrewRcvCard();
    ret.data_type = str.substring(0, 2);
    ret.data_len = str.substring(2, 4);
    ret.business_code = str.substring(4, 11);
    ret.comp_id = str.substring(11, 18);
    ret.correspond_id = str.substring(18, 19);
    ret.reserve = str.substring(19, 25);
    ret.return_code = str.substring(25, 27);
    ret.continue_flg = str.substring(27, 29);
    ret.mac_id = str.substring(29, 37);
    ret.regcredit_number = str.substring(37, 42);
    ret.cardcomp_code = str.substring(42, 46);
    ret.cardcomp_name = str.substring(46, 56);
    ret.member_code = str.substring(56, 72);
    ret.valid_term = str.substring(72, 76);
    ret.pay_way = str.substring(76, 96);
    ret.pay_time = str.substring(96, 136);
    ret.bonus_month = str.substring(136, 166);
    ret.bonus_term = str.substring(166, 196);
    ret.infomation1 = str.substring(196, 226);
    ret.infomation2 = str.substring(226, 256);
    ret.err_code = str.substring(256, 259);
    ret.message1 = str.substring(259, 282);
    ret.message2 = str.substring(282, 305);
    ret.saleqty_counter = str.substring(305, 308);
    ret.saleprc_counter = str.substring(308, 316);
    ret.voidqty_counter = str.substring(316, 319);
    ret.voidprc_counter = str.substring(319, 327);
    ret.cycle_number = str.substring(327, 330);
    ret.spare = str.substring(330, 350);
    return ret;
  }

  /// 関連tprxソース: regs\inc\rccrdt.h - CHK_DEVICE_MCD
  static bool CHK_DEVICE_MCD() {
    AtSingl atSing = SystemFunc.readAtSingl();
    return ((atSing.inputbuf.dev == DevIn.D_MCD1) || (atSing.inputbuf.dev == DevIn.D_MCD2));
  }
}


/// VEGA3000 タイプ別
/// 関連tprxソース: regs\inc\rccrdt.h - VEGA_ORDER
enum VegaOrder {
  VEGA_NOT_ORDER(0), /* 未通信 */
  VEGA_COGCA_TX(1), /* CoGCa送信 */
  VEGA_COGCA_RX(2), /* CoGCa受信 */
  VEGA_MS_TX(3), /* MS送信 */
  VEGA_MS_RX(4), /* MS受信 */
  VEGA_CANCEL(5), /* キャンセル */
  VEGA_ERR_END(6); /* エラー */

  final int cd;
  const VegaOrder(this.cd);
}

/// 関連tprxソース: regs\inc\rccrdt.h - CRDT_MANUAL
class CrdtMAanal {
    String    mbrNo  = "".padRight(16, ' ');    //[16]
    String    cdKind = "".padRight( 5, ' ');    //[ 5];
    String    insLim = "".padRight( 4 ,' ');    //[ 4];
    String    filler = "".padRight(44, ' ');    //[44];
}

/// 関連tprxソース: regs\inc\rccrdt.h - CARDCREW_RCVCARD
class CardCrewRcvCard {
  String data_type = "";          /* 電送区分               */
  String data_len = "";           /* 電文長                */
  String business_code = "";      /* 業務コード             */
  String comp_id = "";            /* 企業ID                */
  String correspond_id = "";      /* 通信ID                */
  String reserve = "";            /* リザーブ               */
  String return_code = "";        /* リターンコード          */
  String continue_flg = "";       /* 続行フラグ             */
  String mac_id = "";             /* 端末ID                */
  String regcredit_number = "";   /* 端末処理通番            */
  String cardcomp_code = "";      /* カード会社コード         */
  String cardcomp_name = "";      /* カード会社名称          */
  String member_code = "";        /* 会員番号               */
  String valid_term = "";         /* 有効期限               */
  String pay_way = "";            /* 利用可能支払方法         */
  String pay_time = "";           /* 利用可能分割回数         */
  String bonus_month = "";        /* 利用可能ボーナス支払月    */
  String bonus_term = "";         /* 利用可能ボーナス支払期間   */
  String infomation1 = "";        /* 問い合せ情報１           */
  String infomation2 = "";        /* 問い合せ情報２           */
  String err_code = "";           /* エラーコード            */
  String message1 = "";           /* メッセージ１            */
  String message2 = "";           /* メッセージ２            */
  String saleqty_counter = "";    /* カウンタ売上件数         */
  String saleprc_counter = "";    /* カウンタ売上金額         */
  String voidqty_counter = "";    /* カウンタ取消件数         */
  String voidprc_counter = "";    /* カウンタ取消金額         */
  String cycle_number = "";       /* サイクル通番            */
  String spare = "";              /* 予備                  */
}