/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */



import 'dart:core';

import '../../common/cls_conf/vega3000JsonFile.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/environment.dart';
import '../../drv/ffi/ubuntu/ffi_vega3000.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';
import '../cm_sys/cm_cksys.dart';

/*-----------------------------------------------------
	HeaderData	共通ヘッダ
-----------------------------------------------------*/
class HeaderData {
	List<String> businessCode = List.generate(4, (_) => ""); // 業務コード
	int businessSubCode = 0; // 業務サブコード
	List<String> processDate = List.generate(7, (_) => ""); // 処理日付
	List<String> processTime = List.generate(7, (_) => ""); // 処理時刻
	List<String> terminalID = List.generate(14, (_) => ""); // 端末識別番号
	List<String> slipNumber = List.generate(6, (_) => ""); // 端末処理通番
	int terminalType = 0; // 端末識別区分
	List<String> extraA0 = List.generate(9, (_) => ""); // 予備
	List<String> operatorCode = List.generate(6, (_) => ""); // 担当者コード
	List<String> memo1 = List.generate(11, (_) => ""); // メモ１
	List<String> memo2 = List.generate(11, (_) => ""); // メモ２
	int testModeFlag = 1; // TESTモードフラグ
	List<String> extraA1 = List.generate(11, (_) => ""); // 予備
	int processingResult = 0; // 処理結果
	List<String> errorCode = List.generate(4, (_) => ""); // エラーコード
	List<String> message1 = List.generate(24, (_) => ""); // メッセージ１
	List<String> message2 = List.generate(24, (_) => ""); // メッセージ２
	List<String> responseCode = List.generate(4, (_) => ""); // レスポンスコード
	int dllFlag = 0; // ＤＬＬフラグ
	List<String> extraA2 = List.generate(11, (_) => ""); // 予備
}

/*-----------------------------------------------------
	SettleData	決済要求
-----------------------------------------------------*/
class SettleData {
	int reversalType = 0; // 取消指令区分
	int processType = 0; // 処理区分
	int approvalType = 0; // 承認区分
	List<String> approvalNumber = List.generate(8, (_) => ""); // 承認番号
	int cardType = 0; // カード種類
	List<String> salesAmount = List.generate(9, (_) => ""); // 取扱金額
	List<String> taxPostage = List.generate(8, (_) => ""); // 税送料
	List<String> goodsCode = List.generate(8, (_) => ""); // 商品コード
	List<String> tradingDate = List.generate(7, (_) => ""); // 取引日
	List<String> businessDate = List.generate(7, (_) => ""); // 営業日
	List<String> pIN = List.generate(5, (_) => ""); // 暗証番号
	List<String> originalSlipNumber = List.generate(6, (_) => ""); // 元伝票番号
	List<String> originalTradingDate = List.generate(7, (_) => ""); // 元取引日
}

/*-----------------------------------------------------
	CardData	カードデータ
-----------------------------------------------------*/
class CardData {
	int type = 0; // カード利用区分
	List<String> cardData1 = List.generate(38, (_) => ""); // JIS1カード情報
	List<String> cardData2 = List.generate(70, (_) => ""); // JIS2カード情報
}

/*-----------------------------------------------------
	ICData	ICカード
-----------------------------------------------------*/
class ICData {
	List<String> aID = List.generate(33, (_) => ""); // AID(ApplicationID)
	int terminalForICFlag = 0; // IC対応端末フラグ
	int mSorICInformationType = 0; // MS/IC情報取得区分
	int pANInputMode = 0; // PAN入力モード
	int pINInputFunction = 0; // PIN入力機能
	List<String> pANSequenceNumber = List.generate(3, (_) => ""); // PANシーケンスナンバー
	int encodeType = 0; // エンコード種別
	int onOffType = 0; // オン/オフ区分
	int tipConditionCode = 0; // チップコンディションコード
	List<String> brandType = List.generate(3, (_) => ""); // ブランド種別
	List<String> storageData = List.generate(341, (_) => ""); // 格納データ
	List<String> storageDataLength = List.generate(5, (_) => ""); // 格納データ長
	List<String> terminalProcessingTime = List.generate(7, (_) => ""); // 端末処理時間
	List<String> terminalProcessingDate = List.generate(9, (_) => ""); // 端末処理日付
	int dealingResult = 0; // 取引結果
	int processingLevel = 0; // 処理レベル
	int forcedOnline = 0; // 強制オンライン
	int forcedApproval = 0; // 強制承認
}

/*-----------------------------------------------------
	PaymentData	支払方法
-----------------------------------------------------*/
class PaymentData {
	List<String> paymentType = List.generate(3, (_) => ""); // 支払区分
	List<String> paymentStartMonth = List.generate(3, (_) => ""); // 支払開始月
	List<String> bonusAmount01 = List.generate(9, (_) => ""); // 初回金額ﾎﾞｰﾅｽ金額(1)／分割金額(1)
	List<String> bonusAmount02 = List.generate(9, (_) => ""); // ﾎﾞｰﾅｽ金額(2)／分割金額(2)
	List<String> bonusAmount03 = List.generate(9, (_) => ""); // ﾎﾞｰﾅｽ金額(3)／分割金額(3)
	List<String> bonusAmount04 = List.generate(9, (_) => ""); // ﾎﾞｰﾅｽ金額(4)／分割金額(4)
	List<String> bonusAmount05 = List.generate(9, (_) => ""); // ﾎﾞｰﾅｽ金額(5)／分割金額(5)
	List<String> bonusAmount06 = List.generate(9, (_) => ""); // ﾎﾞｰﾅｽ金額(6)／分割金額(6)
	List<String> installmentNumber = List.generate(3, (_) => ""); // 分割回数
	List<String> bonusNumber = List.generate(3, (_) => ""); // ボーナス回数
	List<String> bonusMonth01 = List.generate(3, (_) => ""); // ボーナス月(1)
	List<String> bonusMonth02 = List.generate(3, (_) => ""); // ボーナス月(2)
	List<String> bonusMonth03 = List.generate(3, (_) => ""); // ボーナス月(3)
	List<String> bonusMonth04 = List.generate(3, (_) => ""); // ボーナス月(4)
	List<String> bonusMonth05 = List.generate(3, (_) => ""); // ボーナス月(5)
	List<String> bonusMonth06 = List.generate(3, (_) => ""); // ボーナス月(6)
}

/*-----------------------------------------------------
	SettleResponse	決済応答
-----------------------------------------------------*/
class SettleResponse {
	List<String> approvalNumber = List.generate(8, (_) => ""); // 承認番号
	List<String> approvalDate = List.generate(7, (_) => ""); // 承認取得日
	List<String> centerProcessNumber = List.generate(7, (_) => ""); // センター処理通番
	int centerDistinction = 0; // センタ識別
	List<String> acquirerCompanyCode = List.generate(12, (_) => ""); // 仕向会社コード
	List<String> expirationDate = List.generate(5, (_) => ""); // 有効期限
	List<String> swcProcessingDate = List.generate(5, (_) => ""); // ＳＷセンタ処理月日
	int onlineStateFlag = 0; // オンライン状態フラグ
	List<String> icOnlineResponse = List.generate(3, (_) => ""); // ICｵﾝﾗｲﾝｵｰｿﾘ　ﾚｽﾎﾟﾝｽ
}

/*-----------------------------------------------------
	CreditResponse	クレジット応答
-----------------------------------------------------*/
class CreditResponse {
	List<String> pAN = List.generate(20, (_) => ""); // 会員番号
	List<String> cardCompanyCode = List.generate(6, (_) => ""); // カード会社コード
	List<String> cardCompanyName = List.generate(11, (_) => ""); // カード会社名
	List<String> cardCompanyTEL = List.generate(16, (_) => ""); // カード会社ＴＥＬ
	List<String> companyCodeForPOS = List.generate(3, (_) => ""); // POS用会社コード
	int businessConditionsCode = 0; // 業態コード
	int tieUpType = 0; // 提携区分
	int signLessFlag = 0; // サインレスフラグ
	List<String> negaErrorCode = List.generate(3, (_) => ""); // ネガ判定結果コード
	List<String> inquiryInfo01 = List.generate(31, (_) => ""); // 問い合せ情報１
	List<String> inquiryInfo02 = List.generate(31, (_) => ""); // 問い合せ情報２
}

/*-----------------------------------------------------
	InquiryResponse	問合せ応答
-----------------------------------------------------*/
class InquiryResponse {
	List<String> cardCompanyCode = List.generate(6, (_) => ""); // 発行カード会社コード
	List<String> cardCompanyName = List.generate(11, (_) => ""); // 発行カード会社名
	int paymentCheck = 0; // 支払方法チェック
	List<String> paymentCode = List.generate(21, (_) => ""); // 支払方法コード
	int installmentCheckFlag = 0; // 分割支払可能回数チェック
	List<String> installmentNumber = List.generate(41, (_) => ""); // 分割支払可能回数
	List<String> installmentFrom = List.generate(3, (_) => ""); // 分割支払可能回数Ｆｒｏｍ
	List<String> installmentTo = List.generate(3, (_) => ""); // 分割支払可能回数Ｔｏ
	int bonusMonthCheckFlag = 0; // ボーナス支払チェック
	List<String> bonusMonthSummer01 = List.generate(3, (_) => ""); // 夏ボーナス支払月(1)
	List<String> bonusMonthSummer02 = List.generate(3, (_) => ""); // 夏ボーナス支払月(2)
	List<String> bonusMonthWinter01 = List.generate(3, (_) => ""); // 冬ボーナス支払月(1)
	List<String> bonusMonthWinter02 = List.generate(3, (_) => ""); // 冬ボーナス支払月(2)
	int bonusPeriodCheckFlag = 0; // ﾎﾞｰﾅｽ支払期間チェック
	List<String> bonusPeriodSummerFromDate = List.generate(5, (_) => ""); // 夏ボーナス利用開始月日
	List<String> bonusPeriodSummerToDate = List.generate(5, (_) => ""); // 夏ボーナス利用終了月日
	List<String> bonusPeriodWinterFromDate = List.generate(5, (_) => ""); // 冬ボーナス利用開始月日
	List<String> bonusPeriodWinterToDate = List.generate(5, (_) => ""); // 冬ボーナス利用終了月日
}
/*-----------------------------------------------------
	ExtInquiryResponse	拡張問合せ応答
-----------------------------------------------------*/
class ExtInquiryResponse {
	List<String> creditCompanyPublicCode = List.generate(6, (_) => ""); // カード会社流開コード
	List<String> creditCompanyName = List.generate(17, (_) => ""); // クレジット会社名
	List<String> creditCompanyReserveCode = List.generate(11, (_) => ""); // クレジット会社・（予備）コード
	int creditCompanyType = 0; // クレジット会社区分
	List<String> issuerCodeForManualInput = List.generate(12, (_) => ""); // 被仕向会社コード
	List<String> authorizationTEL = List.generate(16, (_) => ""); // オーソリ先TEL
	List<String> kID = List.generate(4, (_) => ""); // ＫＩＤ
	List<String> bonusMonthSummer03 = List.generate(3, (_) => ""); // 夏ボーナス支払月(3)
	List<String> bonusMonthSummer04 = List.generate(3, (_) => ""); // 夏ボーナス支払月(4)
	List<String> bonusMonthSummer05 = List.generate(3, (_) => ""); // 夏ボーナス支払月(5)
	List<String> bonusMonthSummer06 = List.generate(3, (_) => ""); // 夏ボーナス支払月(6)
	List<String> bonusMonthWinter03 = List.generate(3, (_) => ""); // 冬ボーナス支払月(3)
	List<String> bonusMonthWinter04 = List.generate(3, (_) => ""); // 冬ボーナス支払月(4)
	List<String> bonusMonthWinter05 = List.generate(3, (_) => ""); // 冬ボーナス支払月(5)
	List<String> bonusMonthWinter06 = List.generate(3, (_) => ""); // 冬ボーナス支払月(6)
	int paymentType25Repeat = 0; // ボーナス金額の繰返し／「２５」
	int paymentType34Repeat = 0; // ボーナス金額の繰返し／「３４」
	List<String> limitFirstTimeAmount = List.generate(9, (_) => ""); // 初回金額／下限値「６３」
	List<String> limitUpperNumber22 = List.generate(3, (_) => ""); // ボーナス回数／上限値「２２」
	List<String> limitUpperNumber24 = List.generate(3, (_) => ""); // ボーナス回数／上限値「２４」
	List<String> limitUpperNumber25 = List.generate(3, (_) => ""); // ボーナス回数／上限値「２５」
	List<String> limitUpperNumber33 = List.generate(3, (_) => ""); // ボーナス回数／上限値「３３」
	List<String> limitUpperNumber34 = List.generate(3, (_) => ""); // ボーナス回数／上限値「３４」
	int paymentStartMonth31 = 0; // 支払開始月／「３１」
	int paymentStartMonth32 = 0; // 支払開始月／「３２」
	int paymentStartMonth33 = 0; // 支払開始月／「３３」
	int paymentStartMonth34 = 0; // 支払開始月／「３４」
	int paymentStartMonth61 = 0; // 支払開始月／「６１」
	int paymentStartMonth62 = 0; // 支払開始月／「６２」
	int paymentStartMonth63 = 0; // 支払開始月／「６３」
	List<String> limitCheckPaymentCode01 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０１
	List<String> limitCheckUpperAmount01 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０１
	List<String> limitCheckLowerAmount01 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０１
	List<String> limitCheckPaymentCode02 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０２
	List<String> limitCheckUpperAmount02 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０２
	List<String> limitCheckLowerAmount02 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０２
	List<String> limitCheckPaymentCode03 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０３
	List<String> limitCheckUpperAmount03 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０３
	List<String> limitCheckLowerAmount03 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０３
	List<String> limitCheckPaymentCode04 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０４
	List<String> limitCheckUpperAmount04 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０４
	List<String> limitCheckLowerAmount04 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０４
	List<String> limitCheckPaymentCode05 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０５
	List<String> limitCheckUpperAmount05 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０５
	List<String> limitCheckLowerAmount05 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０５
	List<String> limitCheckPaymentCode06 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０６
	List<String> limitCheckUpperAmount06 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０６
	List<String> limitCheckLowerAmount06 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０６
	List<String> limitCheckPaymentCode07 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０７
	List<String> limitCheckUpperAmount07 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０７
	List<String> limitCheckLowerAmount07 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０７
	List<String> limitCheckPaymentCode08 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０８
	List<String> limitCheckUpperAmount08 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０８
	List<String> limitCheckLowerAmount08 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０８
	List<String> limitCheckPaymentCode09 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分０９
	List<String> limitCheckUpperAmount09 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額０９
	List<String> limitCheckLowerAmount09 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額０９
	List<String> limitCheckPaymentCode10 = List.generate(3, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／支払区分１０
	List<String> limitCheckUpperAmount10 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／上限金額１０
	List<String> limitCheckLowerAmount10 = List.generate(9, (_) => ""); // 支払方法毎のﾘﾐｯﾄ／下限金額１０
}

/*-----------------------------------------------------
	CupData	銀聯カード
-----------------------------------------------------*/
class CupData {
	List<String> cancelSystemNumber = List.generate(7, (_) => ""); // 取消／返品　銀聯番号
	List<String> cancelProcessDate = List.generate(13, (_) => ""); // 取消／返品　取引日付
	List<String> cancelApprovalNumber = List.generate(7, (_) => ""); // 取消／返品　承認番号
}

/*-----------------------------------------------------
	ICPrintInfo	IC印字情報 [POS連動用]
-----------------------------------------------------*/
class ICPrintInfo {
	List<String> aID = List.generate(14, (_) => ""); // AID(ApplicationID)
	List<String> aplLabel = List.generate(33, (_) => ""); // アプリケーションラベル
	List<String> aTC = List.generate(6, (_) => ""); // ATC
	List<String> cardSequenceNumber = List.generate(3, (_) => ""); // カードシーケンス番号
	int icMsType = 0; // IC/MS識別子
	int confirmedPIN = 0; // 暗証番号確認済み
	int signlessFlag = 0; // サイン省略
	List<String> extra1 = List.generate(25, (_) => ""); // 予備１
	List<String> extra2 = List.generate(25, (_) => ""); // 予備２
	List<String> extra3 = List.generate(25, (_) => ""); // 予備３
}

/*-----------------------------------------------------
	Config	接続先設定
-----------------------------------------------------*/
class Config {
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
}

/*-----------------------------------------------------
	★CreditParam	クレジット[磁気 マニュアル 端末判定 ICカード]
-----------------------------------------------------*/
class CreditParam {
	HeaderData header = HeaderData();
	SettleData settle = SettleData();
	PaymentData payment = PaymentData();
	SettleResponse rSettle = SettleResponse();
	CreditResponse rCredit = CreditResponse();
	ICPrintInfo iCPrint = ICPrintInfo();
}

/*-----------------------------------------------------
	★InquiryParam	問合せ
-----------------------------------------------------*/
class InquiryParam {
	HeaderData header = HeaderData();
	SettleData settle = SettleData();
	CreditResponse rCredit = CreditResponse();
	InquiryResponse rInquiry = InquiryResponse();
	ExtInquiryResponse rExtInquiry = ExtInquiryResponse();
}

/*-----------------------------------------------------
	★CupParam	銀聯
-----------------------------------------------------*/
class CupParam {
	HeaderData header = HeaderData();
	SettleData settle = SettleData();
	CupData cup = CupData();
	SettleResponse rSettle = SettleResponse();
	CreditResponse rCredit = CreditResponse();
}

/*-----------------------------------------------------
	★MscParam	MSカード
-----------------------------------------------------*/
class PosMsParam {
	HeaderData header = HeaderData();
	CardData card = CardData();
}

/*-----------------------------------------------------
	★CgcParam	CoGCa
-----------------------------------------------------*/
class PosCoGCaParam {
	HeaderData header = HeaderData();
	CardData card = CardData();
}

class IfVega3000Com {
	// TODO:コンパイルSW
// #if CENTOS
	static const	sYSIni	= "/conf/sys.ini";
	static const	vEGAIni	= "/conf/vega3000.ini";
	static const	tTYS	= "/dev/ttyS";
	static const	cOM	= "com";
	static const	lOGDir	= "log";
	static TprLog myLog = TprLog();
	static var ffiVega =  FFIVega3000();

/* Initialize */
	/// 関数：ifVega3000ConfigInitExec()
	/// 機能：VEGA3000端末 Config構造体初期化実行
	/// 引数：なし
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_Init_Exec
	Future<void> ifVega3000ConfigInitExec() async {
		RxCommonBuf pCom = RxCommonBuf();
		Config tempConf = Config();

		RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
		if (xRet.isInvalid()) {
			myLog.logAdd(0, LogLevelDefine.error,
					"ifVega3000ConfigInitExec rxMemPtr error");
			return;
		}
		pCom = xRet.object;

		ifVega3000MakePlusPos(tempConf); /* 端末初期化 */
		ifVega3000ConfigInitSave(pCom.vega3000Conf, tempConf); /* Config初期値保持 */
		await ifVega3000ConfigMemSet(pCom.vega3000Conf); /* Config設定値入力 */

		return;
	}

	/// 関数：ifVega3000ConfigInitSave()
	/// 機能：VEGA3000 Config構造体初期値保持(端末初期化処理後に実行)
	/// 引数：RxVega3000Conf memConf
	///       Config vegaConf
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_Init_Save
	void ifVega3000ConfigInitSave(RxVega3000Conf memConf, Config vegaConf) {
		memConf.svFlag = vegaConf.svFlag;
		memConf.swFlag = vegaConf.swFlag;
		memConf.address = vegaConf.address;
		memConf.addressSub = vegaConf.addressSub;
		memConf.port = vegaConf.port;
		memConf.portSub = vegaConf.portSub;
		memConf.recvTimeOut = vegaConf.recvTimeOut;
		memConf.connTimeOut = vegaConf.connTimeOut;
		memConf.retryCount = vegaConf.retryCount;
		memConf.logFlag = vegaConf.logFlag;
		memConf.logFilePath = vegaConf.logFilePath;
		memConf.logSaveDate = vegaConf.logSaveDate;
		memConf.devFlag = vegaConf.devFlag;
		memConf.trainingModeFlag = vegaConf.trainingModeFlag;
		memConf.comNo = vegaConf.comNo;

		return;
	}

	/// 関数：ifVega3000ConfigInitSet()
	/// 機能：VEGA3000 Config構造体初期値入力(各端末処理開始前に実行)
	/// 引数：RxVega3000Conf memConf
	///       Config vegaConf
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_Init_Set
	void ifVega3000ConfigInitSet(RxVega3000Conf memConf, Config vegaConf) {
		vegaConf.svFlag = memConf.svFlag;
		vegaConf.swFlag = memConf.swFlag;
		vegaConf.address = memConf.address;
		vegaConf.addressSub = memConf.addressSub;
		vegaConf.port = memConf.port;
		vegaConf.portSub = memConf.portSub;
		vegaConf.recvTimeOut = memConf.recvTimeOut;
		vegaConf.connTimeOut = memConf.connTimeOut;
		vegaConf.retryCount = memConf.retryCount;
		vegaConf.logFlag = memConf.logFlag;
		vegaConf.logFilePath = memConf.logFilePath;
		vegaConf.logSaveDate = memConf.logSaveDate;
		vegaConf.devFlag = memConf.devFlag;
		vegaConf.trainingModeFlag = memConf.trainingModeFlag;
		vegaConf.comNo = memConf.comNo;

		return;
	}

	/// 関数：ifVega3000ConfigSet()
	/// 機能：VEGA3000 Config構造体設定値入力
	/// 引数：Config vegaConf
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_Set
	Future<void> ifVega3000ConfigSet(Config vegaConf) async {
		vegaConf.logFlag = 1;
		vegaConf.logFilePath = [];
		vegaConf.logFilePath = "${EnvironmentData.TPRX_HOME}$lOGDir".split(""); // /pj/tprx/log
		vegaConf.comNo = await ifVega3000ConfigComNoSet();

		return;
	}

	/// 関数：ifVega3000ConfigMemSet()
	/// 機能：VEGA3000 Config構造体設定値入力（共有メモリ）
	/// 引数：RxVega3000Conf memConf
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_mem_Set
	Future<void> ifVega3000ConfigMemSet(RxVega3000Conf memConf) async {
		memConf.logFlag = 1;
		memConf.logFilePath = [];
		memConf.logFilePath = "${EnvironmentData.TPRX_HOME}$lOGDir".split(""); // /pj/tprx/log
		memConf.comNo = await ifVega3000ConfigComNoSet();

		return;
	}

	/// 関数：ifVega3000MakePlusPos()
	/// 機能：VEGA3000 Config構造体初期化
	/// 引数：Config vegaConf
	/// 戻値：なし
	/// 関連tprxソース: vega3000_com.c - if_vega3000_makePlusPos
	void ifVega3000MakePlusPos(Config vegaConf) {
		ffiVega.makePlusPos(vegaConf);

		return;
	}

/* クレジット */
	/// 関数：ifVega3000StartPlusPosCredit()
	/// 機能：クレジットカード読取 構造体初期化
	/// 引数：CreditParam crdtParam
	///     ：InquiryParam inqParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:初期化、端末との通信が正常終了しなかった 1:初期化、端末との通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_startPlusPosCredit
	int ifVega3000StartPlusPosCredit(CreditParam crdtParam,
			InquiryParam inqParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

    ret = 0;
		result = ffiVega.startPlusPosCredit(crdtParam, inqParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000PlusPosCredit()
	/// 機能：クレジットカード読取 処理実行
	/// 引数：CreditParam crdtParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:サーバとの通信が正常終了しなかった 1:サーバとの通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosCredit
	int ifVega3000PlusPosCredit(CreditParam crdtParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.plusPosCredit(crdtParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000PlusPosInquiry()
	/// 機能：クレジットカード問い合わせ 処理実行
	/// 引数：InquiryParam inqParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:サーバとの通信が正常終了しなかった 1:サーバとの通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosInquiry
	int ifVega3000PlusPosInquiry(InquiryParam inqParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.plusPosInquiry(inqParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000EndPlusPosCredit()
	/// 機能：クレジットカード読取 処理終了
	/// 引数：CreditParam crdtParam
	///     ：InquiryParam inqParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:端末との通信が正常終了しなかった 1:端末との通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_endPlusPosCredit
	int ifVega3000EndPlusPosCredit(CreditParam crdtParam, InquiryParam inqParam,
			RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.endPlusPosCredit(crdtParam, inqParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

/* 銀聯 */
	/// 関数：ifVega3000StartPlusPosCup()
	/// 機能：銀聯カード読取 構造体初期化
	/// 引数：CupParam cupParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:初期化、通信が正常終了しなかった 1:初期化、通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_startPlusPosCup
	int ifVega3000StartPlusPosCup(CupParam cupParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.startPlusPosCup(cupParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000PlusPosCup()
	/// 機能：銀聯カード読取 処理実行
	/// 引数：CupParam cupParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosCup
	int ifVega3000PlusPosCup(CupParam cupParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.plusPosCup(cupParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000EndPlusPosCup()
	/// 機能：銀聯カード読取 処理終了
	/// 引数：CupParam cupParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_endPlusPosCup
	int ifVega3000EndPlusPosCup(CupParam cupParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.endPlusPosCup(cupParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

/* MSカード */
	/// 関数：ifVega3000StartPlusPosMsRead()
	/// 機能：MSカード読取 構造体初期化
	/// 引数：PosMsParam msParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:初期化、通信が正常終了しなかった 1:初期化、通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_startPlusPosMsRead
	int ifVega3000StartPlusPosMsRead(PosMsParam msParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.startPlusPosMsRead(msParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000PlusPosMsRead()
	/// 機能：MSカード読取 処理実行
	/// 引数：PosMsParam msParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosMsRead
	int ifVega3000PlusPosMsRead(PosMsParam msParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.plusPosMsRead(msParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000EndPlusPosMsRead()
	/// 機能：MSカード読取 処理終了
	/// 引数：PosMsParam msParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_endPlusPosMsRead
	int ifVega3000EndPlusPosMsRead(PosMsParam msParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.endPlusPosMsRead(msParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

/* CoGCa */
	/// 関数：ifVega3000StartPlusPosCoGCaRead()
	/// 機能：CoGCaカード読取 構造体初期化
	/// 引数：PosCoGCaParam cogcaParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:初期化、通信が正常終了しなかった 1:初期化、通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_startPlusPosCoGCaRead
	int ifVega3000StartPlusPosCoGCaRead(PosCoGCaParam cogcaParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.startPlusPosCoGCaRead(cogcaParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000PlusPosCoGCaRead()
	/// 機能：CoGCaカード読取 処理実行
	/// 引数：PosCoGCaParam cogcaParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosCoGCaRead
	int ifVega3000PlusPosCoGCaRead(PosCoGCaParam cogcaParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.plusPosCoGCaRead(cogcaParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

	/// 関数：ifVega3000EndPlusPosCoGCaRead()
	/// 機能：CoGCaカード読取 処理終了
	/// 引数：PosCoGCaParam cogcaParam
	///     ：RxVega3000Conf rxVegaConf
	/// 戻値：0:通信が正常終了しなかった 1:通信が正常終了
	/// 関連tprxソース: vega3000_com.c - if_vega3000_endPlusPosCoGCaRead
	int ifVega3000EndPlusPosCoGCaRead(PosCoGCaParam cogcaParam, RxVega3000Conf rxVegaConf) {
		bool result;
		int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

		ret = 0;
		result = ffiVega.endPlusPosCoGCaRead(cogcaParam, vegaConf);

		if (result == true) {
			ret = 1;
		}

		return (ret);
	}

/* Cancel */
	/// 関数：ifVega3000PlusPosRegisterCancelCallback()
  /// 機能：キャンセル用コールバック関数登録
  /// 引数：Function func  コールバック関数
  ///     ：RxVega3000Conf rxVegaConf
  /// 戻値：0:関数登録が正常終了しなかった 1:関数登録が正常終了
	/// 備考：登録されたコールバック関数を一定間隔でコールする
  /// 関連tprxソース: vega3000_com.c - if_vega3000_PlusPosRegisterCancelCallback
  int ifVega3000PlusPosRegisterCancelCallback(Function func, RxVega3000Conf rxVegaConf) {
    bool result;
    int ret;

		Config vegaConf = Config();
		ifVega3000ConfigConvert(rxVegaConf, vegaConf);

    ret = 0;
    result = ffiVega.plusPosRegisterCancelCallback(func, vegaConf);

    if (result == true) {
			ffiVega.registeredCallbackFunction(func);
      ret = 1;
    }

    return (ret);
  }

/* 内部関数 */
	/// 関数：ifVega3000ConfigComNoSet()
	/// 機能：Config構造体 シリアルポート名セット
	/// 引数：なし
	/// 戻値：シリアルポート名（/dev/ttySn）
	/// 関連tprxソース: vega3000_com.c - if_vega3000_Config_ComNo_Set
	Future<List<String>> ifVega3000ConfigComNoSet() async {
		String tempBuf = ""; /* 一時バッファ */
		int port = -1; /* ポート番号 */

		/* iniファイルからポート情報取得 */
		Vega3000JsonFile vega3000Json = Vega3000JsonFile();
		await vega3000Json.load();
		tempBuf = vega3000Json.settings.port;

		/* ポート確認 */
		if (!tempBuf.contains(cOM)) {
			return ([""]);
		}

		/* シリアルポート名セット */
		port = int.parse(tempBuf.substring(cOM.length));
		if (CmCksys.cmG3System() == 1) {
			tempBuf = tTYS + (port + 3).toString();
		} else {
			tempBuf = tTYS + (port - 1).toString();
		}

		return tempBuf.split("");
	}
//#endif

	/// 関数：ifVega3000ConfigConvert()
	/// 機能：VEGA3000 Config構造体初期値入力(メモリからクラス変数に変換)
	/// 引数：RxVega3000Conf src
	///       Config dest
	/// 戻値：なし
	/// 関連tprxソース: なし（新規作成）
	void ifVega3000ConfigConvert(RxVega3000Conf src, Config dest) {
		dest.svFlag = src.svFlag;
		dest.swFlag = src.swFlag;
		dest.address = src.address;
		dest.addressSub = src.addressSub;
		dest.port = src.port;
		dest.portSub = src.portSub;
		dest.recvTimeOut = src.recvTimeOut;
		dest.connTimeOut = src.connTimeOut;
		dest.retryCount = src.retryCount;
		dest.logFlag = src.logFlag;
		dest.logFilePath = src.logFilePath;
		dest.logSaveDate = src.logSaveDate;
		dest.devFlag = src.devFlag;
		dest.trainingModeFlag = src.trainingModeFlag;
		dest.comNo = src.comNo;
	}
}
