/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ffi';
import 'package:flutter_pos/app/lib/if_vega3000/vega3000_com.dart';
import '../library.dart';

typedef NativeDummy = Bool Function();
// -----------------------------------------------------
// 	HeaderData	共通ヘッダ
// -----------------------------------------------------
final class HeaderDataStruct extends Struct {
  @Array( 4) external Array<Uint8> businessCode; // 業務コード
  @Uint8()   external int businessSubCode; // 業務サブコード
  @Array( 7) external Array<Uint8> processDate; // 処理日付
  @Array( 7) external Array<Uint8> processTime; // 処理時刻
  @Array(14) external Array<Uint8> terminalID; // 端末識別番号
  @Array( 6) external Array<Uint8> slipNumber; // 端末処理通番
  @Uint8()   external int terminalType; // 端末識別区分
  @Array( 9) external Array<Uint8> extraA0; // 予備
  @Array( 6) external Array<Uint8> operatorCode; // 担当者コード
  @Array(11) external Array<Uint8> memo1; // メモ１
  @Array(11) external Array<Uint8> memo2; // メモ２
  @Uint8()   external int testModeFlag; // TESTモードフラグ
  @Array(11) external Array<Uint8> extraA1; // 予備
  @Uint8()   external int processingResult; // 処理結果
  @Array( 4) external Array<Uint8> errorCode; // エラーコード
  @Array(24) external Array<Uint8> message1; // メッセージ１
  @Array(24) external Array<Uint8> message2; // メッセージ２
  @Array( 5) external Array<Uint8> responseCode; // レスポンスコード
  @Uint8()   external int dllFlag; // ＤＬＬフラグ
  @Array(11) external Array<Uint8> extraA2; // 予備
}

// -----------------------------------------------------
// 	SettleData	決済要求
// -----------------------------------------------------
final class SettleDataStruct extends Struct {
  @Uint8()   external int reversalType; // 取消指令区分
  @Uint8()   external int processType; // 処理区分
  @Uint8()   external int approvalType; // 承認区分
  @Array( 8) external Array<Uint8> approvalNumber; // 承認番号
  @Uint8()   external int cardType; // カード種類
  @Array( 9) external Array<Uint8> salesAmount; // 取扱金額
  @Array( 8) external Array<Uint8> taxPostage; // 税送料
  @Array( 8) external Array<Uint8> goodsCode; // 商品コード
  @Array( 7) external Array<Uint8> tradingDate; // 取引日
  @Array( 7) external Array<Uint8> businessDate; // 営業日
  @Array( 5) external Array<Uint8> pIN; // 暗証番号
  @Array( 6) external Array<Uint8> originalSlipNumber; // 元伝票番号
  @Array( 7) external Array<Uint8> originalTradingDate; // 元取引日
}

// -----------------------------------------------------
// 	CardData	カードデータ
// -----------------------------------------------------
final class CardDataStruct extends Struct {
  @Uint8()   external int type; // カード利用区分
  @Array(38) external Array<Uint8> cardData1; // JIS1カード情報
  @Array(70) external Array<Uint8> cardData2; // JIS2カード情報
}

// -----------------------------------------------------
// 	ICData	ICカード
// -----------------------------------------------------
final class ICDataStruct extends Struct {
  @Array( 33) external Array<Uint8> aID; // AID(ApplicationID)
  @Uint8()    external int terminalforICFlag; // IC対応端末フラグ
  @Uint8()    external int mSorICInformationType; // MS/IC情報取得区分
  @Uint8()    external int pANInputMode; // PAN入力モード
  @Uint8()    external int pINInputFunction; // PIN入力機能
  @Array(  3) external Array<Uint8> pANSequenceNumber; // PANシーケンスナンバー
  @Uint8()    external int encodeType; // エンコード種別
  @Uint8()    external int onOffType; // オン/オフ区分
  @Uint8()    external int tipConditionCode; // チップコンディションコード
  @Array(  3) external Array<Uint8> brandType; // ブランド種別
  @Array(341) external Array<Uint8> storageData; // 格納データ
  @Array(  5) external Array<Uint8> storageDataLength; // 格納データ長
  @Array(  7) external Array<Uint8> terminalProcessingTime; // 端末処理時間
  @Array(  9) external Array<Uint8> terminalProcessingDate; // 端末処理日付
  @Uint8()    external int dealingResult; // 取引結果
  @Uint8()    external int processingLevel; // 処理レベル
  @Uint8()    external int forcedOnline; // 強制オンライン
  @Uint8()    external int forcedApproval; // 強制承認
}

// -----------------------------------------------------
// 	PaymentData	支払方法
// -----------------------------------------------------
final class PaymentDataStruct extends Struct {
  @Array( 3) external Array<Uint8> paymentType; // 支払区分
  @Array( 3) external Array<Uint8> paymentStartMonth; // 支払開始月
  @Array( 9) external Array<Uint8> bonusAmount01; // 初回金額ﾎﾞｰﾅｽ金額(1)／分割金額(1)
  @Array( 9) external Array<Uint8> bonusAmount02; // ﾎﾞｰﾅｽ金額(2)／分割金額(2)
  @Array( 9) external Array<Uint8> bonusAmount03; // ﾎﾞｰﾅｽ金額(3)／分割金額(3)
  @Array( 9) external Array<Uint8> bonusAmount04; // ﾎﾞｰﾅｽ金額(4)／分割金額(4)
  @Array( 9) external Array<Uint8> bonusAmount05; // ﾎﾞｰﾅｽ金額(5)／分割金額(5)
  @Array( 9) external Array<Uint8> bonusAmount06; // ﾎﾞｰﾅｽ金額(6)／分割金額(6)
  @Array( 3) external Array<Uint8> installmentNumber; // 分割回数
  @Array( 3) external Array<Uint8> bonusNumber; // ボーナス回数
  @Array( 3) external Array<Uint8> bonusMonth01; // ボーナス月(1)
  @Array( 3) external Array<Uint8> bonusMonth02; // ボーナス月(2)
  @Array( 3) external Array<Uint8> bonusMonth03; // ボーナス月(3)
  @Array( 3) external Array<Uint8> bonusMonth04; // ボーナス月(4)
  @Array( 3) external Array<Uint8> bonusMonth05; // ボーナス月(5)
  @Array( 3) external Array<Uint8> bonusMonth06; // ボーナス月(6)
}

// -----------------------------------------------------
// 	SettleResponse	決済応答
// -----------------------------------------------------
final class SettleResponseStruct extends Struct {
  @Array( 8) external Array<Uint8> approvalNumber; // 承認番号
  @Array( 7) external Array<Uint8> approvalDate; // 承認取得日
  @Array( 7) external Array<Uint8> centerProcessNumber; // センター処理通番
  @Uint8()   external int centerDistinction; // センタ識別
  @Array(12) external Array<Uint8> acquirerCompanyCode; // 仕向会社コード
  @Array( 5) external Array<Uint8> expirationDate; // 有効期限
  @Array( 5) external Array<Uint8> swcProcessingDate; // ＳＷセンタ処理月日
  @Uint8()   external int onlineStateFlag; // オンライン状態フラグ
  @Array( 3) external Array<Uint8> icOnlineResponse; // ICｵﾝﾗｲﾝｵｰｿﾘ　ﾚｽﾎﾟﾝｽ
}

// -----------------------------------------------------
// 	CreditResponse	クレジット応答
// -----------------------------------------------------
final class CreditResponseStruct extends Struct {
  @Array(20) external Array<Uint8> pAN; // 会員番号
  @Array( 6) external Array<Uint8> cardCompanyCode; // カード会社コード
  @Array(11) external Array<Uint8> cardCompanyName; // カード会社名
  @Array(16) external Array<Uint8> cardCompanyTEL; // カード会社ＴＥＬ
  @Array( 3) external Array<Uint8> companyCodeforPOS; // POS用会社コード
  @Uint8()   external int businessConditionsCode; // 業態コード
  @Uint8()   external int tieupType; // 提携区分
  @Uint8()   external int signlessFlag; // サインレスフラグ
  @Array( 3) external Array<Uint8> negaErrorCode; // ネガ判定結果コード
  @Array(31) external Array<Uint8> inquiryInfo01; // 問い合せ情報１
  @Array(31) external Array<Uint8> inquiryInfo02; // 問い合せ情報２
}

// -----------------------------------------------------
// 	InquiryResponse	問合せ応答
// -----------------------------------------------------
final class InquiryResponseStruct extends Struct {
  @Array( 6) external Array<Uint8> cardCompanyCode; // 発行カード会社コード
  @Array(11) external Array<Uint8> cardCompanyName; // 発行カード会社名
  @Uint8()   external int paymentCheck; // 支払方法チェック
  @Array(21) external Array<Uint8> paymentCode; // 支払方法コード
  @Uint8()   external int installmentCheckFlag; // 分割支払可能回数チェック
  @Array(41) external Array<Uint8> installmentNumber; // 分割支払可能回数
  @Array( 3) external Array<Uint8> installmentFrom; // 分割支払可能回数Ｆｒｏｍ
  @Array( 3) external Array<Uint8> installmentTo; // 分割支払可能回数Ｔｏ
  @Uint8()   external int bonusMonthCheckFlag; // ボーナス支払チェック
  @Array( 3) external Array<Uint8> bonusMonthSummer01; // 夏ボーナス支払月(1)
  @Array( 3) external Array<Uint8> bonusMonthSummer02; // 夏ボーナス支払月(2)
  @Array( 3) external Array<Uint8> bonusMonthWinter01; // 冬ボーナス支払月(1)
  @Array( 3) external Array<Uint8> bonusMonthWinter02; // 冬ボーナス支払月(2)
  @Uint8()   external int bonusPeriodCheckFlag; // ﾎﾞｰﾅｽ支払期間チェック
  @Array( 5) external Array<Uint8> bonusPeriodSummerFromDate; // 夏ボーナス利用開始月日
  @Array( 5) external Array<Uint8> bonusPeriodSummerToDate; // 夏ボーナス利用終了月日
  @Array( 5) external Array<Uint8> bonusPeriodWinterFromDate; // 冬ボーナス利用開始月日
  @Array( 5) external Array<Uint8> bonusPeriodWinterToDate; // 冬ボーナス利用終了月日
}

// -----------------------------------------------------
// 	ExtInquiryResponse	拡張問合せ応答
// -----------------------------------------------------
final class ExtInquiryResponseStruct extends Struct {
  @Array( 6) external Array<Uint8> creditCompanyPublicCode; // カード会社流開コード
  @Array(17) external Array<Uint8> creditCompanyName; // クレジット会社名
  @Array(11) external Array<Uint8> creditCompanyReserveCode; // クレジット会社・（予備）コード
  @Uint8()   external int creditCompanyType; // クレジット会社区分
  @Array(12) external Array<Uint8> issuerCodeForManualInput; // 被仕向会社コード
  @Array(16) external Array<Uint8> authorizationTEL; // オーソリ先TEL
  @Array( 4) external Array<Uint8> kID; // ＫＩＤ
  @Array( 3) external Array<Uint8> bonusMonthSummer03; // 夏ボーナス支払月(3)
  @Array( 3) external Array<Uint8> bonusMonthSummer04; // 夏ボーナス支払月(4)
  @Array( 3) external Array<Uint8> bonusMonthSummer05; // 夏ボーナス支払月(5)
  @Array( 3) external Array<Uint8> bonusMonthSummer06; // 夏ボーナス支払月(6)
  @Array( 3) external Array<Uint8> bonusMonthWinter03; // 冬ボーナス支払月(3)
  @Array( 3) external Array<Uint8> bonusMonthWinter04; // 冬ボーナス支払月(4)
  @Array( 3) external Array<Uint8> bonusMonthWinter05; // 冬ボーナス支払月(5)
  @Array( 3) external Array<Uint8> bonusMonthWinter06; // 冬ボーナス支払月(6)
  @Uint8()   external int paymentType25Repeat; // ボーナス金額の繰返し／「２５」
  @Uint8()   external int paymentType34Repeat; // ボーナス金額の繰返し／「３４」
  @Array( 9) external Array<Uint8> limitFirstTimeAmount; // 初回金額／下限値「６３」
  @Array( 3) external Array<Uint8> limitUpperNumber22; // ボーナス回数／上限値「２２」
  @Array( 3) external Array<Uint8> limitUpperNumber24; // ボーナス回数／上限値「２４」
  @Array( 3) external Array<Uint8> limitUpperNumber25; // ボーナス回数／上限値「２５」
  @Array( 3) external Array<Uint8> limitUpperNumber33; // ボーナス回数／上限値「３３」
  @Array( 3) external Array<Uint8> limitUpperNumber34; // ボーナス回数／上限値「３４」
  @Uint8()   external int paymentStartMonth31; // 支払開始月／「３１」
  @Uint8()   external int paymentStartMonth32; // 支払開始月／「３２」
  @Uint8()   external int paymentStartMonth33; // 支払開始月／「３３」
  @Uint8()   external int paymentStartMonth34; // 支払開始月／「３４」
  @Uint8()   external int paymentStartMonth61; // 支払開始月／「６１」
  @Uint8()   external int paymentStartMonth62; // 支払開始月／「６２」
  @Uint8()   external int paymentStartMonth63; // 支払開始月／「６３」
  @Array( 3) external Array<Uint8> limitCheckPaymentCode01; // 支払方法毎のﾘﾐｯﾄ／支払区分０１
  @Array( 9) external Array<Uint8> limitCheckUpperAmount01; // 支払方法毎のﾘﾐｯﾄ／上限金額０１
  @Array( 9) external Array<Uint8> limitCheckLowerAmount01; // 支払方法毎のﾘﾐｯﾄ／下限金額０１
  @Array( 3) external Array<Uint8> limitCheckPaymentCode02; // 支払方法毎のﾘﾐｯﾄ／支払区分０２
  @Array( 9) external Array<Uint8> limitCheckUpperAmount02; // 支払方法毎のﾘﾐｯﾄ／上限金額０２
  @Array( 9) external Array<Uint8> limitCheckLowerAmount02; // 支払方法毎のﾘﾐｯﾄ／下限金額０２
  @Array( 3) external Array<Uint8> limitCheckPaymentCode03; // 支払方法毎のﾘﾐｯﾄ／支払区分０３
  @Array( 9) external Array<Uint8> limitCheckUpperAmount03; // 支払方法毎のﾘﾐｯﾄ／上限金額０３
  @Array( 9) external Array<Uint8> limitCheckLowerAmount03; // 支払方法毎のﾘﾐｯﾄ／下限金額０３
  @Array( 3) external Array<Uint8> limitCheckPaymentCode04; // 支払方法毎のﾘﾐｯﾄ／支払区分０４
  @Array( 9) external Array<Uint8> limitCheckUpperAmount04; // 支払方法毎のﾘﾐｯﾄ／上限金額０４
  @Array( 9) external Array<Uint8> limitCheckLowerAmount04; // 支払方法毎のﾘﾐｯﾄ／下限金額０４
  @Array( 3) external Array<Uint8> limitCheckPaymentCode05; // 支払方法毎のﾘﾐｯﾄ／支払区分０５
  @Array( 9) external Array<Uint8> limitCheckUpperAmount05; // 支払方法毎のﾘﾐｯﾄ／上限金額０５
  @Array( 9) external Array<Uint8> limitCheckLowerAmount05; // 支払方法毎のﾘﾐｯﾄ／下限金額０５
  @Array( 3) external Array<Uint8> limitCheckPaymentCode06; // 支払方法毎のﾘﾐｯﾄ／支払区分０６
  @Array( 9) external Array<Uint8> limitCheckUpperAmount06; // 支払方法毎のﾘﾐｯﾄ／上限金額０６
  @Array( 9) external Array<Uint8> limitCheckLowerAmount06; // 支払方法毎のﾘﾐｯﾄ／下限金額０６
  @Array( 3) external Array<Uint8> limitCheckPaymentCode07; // 支払方法毎のﾘﾐｯﾄ／支払区分０７
  @Array( 9) external Array<Uint8> limitCheckUpperAmount07; // 支払方法毎のﾘﾐｯﾄ／上限金額０７
  @Array( 9) external Array<Uint8> limitCheckLowerAmount07; // 支払方法毎のﾘﾐｯﾄ／下限金額０７
  @Array( 3) external Array<Uint8> limitCheckPaymentCode08; // 支払方法毎のﾘﾐｯﾄ／支払区分０８
  @Array( 9) external Array<Uint8> limitCheckUpperAmount08; // 支払方法毎のﾘﾐｯﾄ／上限金額０８
  @Array( 9) external Array<Uint8> limitCheckLowerAmount08; // 支払方法毎のﾘﾐｯﾄ／下限金額０８
  @Array( 3) external Array<Uint8> limitCheckPaymentCode09; // 支払方法毎のﾘﾐｯﾄ／支払区分０９
  @Array( 9) external Array<Uint8> limitCheckUpperAmount09; // 支払方法毎のﾘﾐｯﾄ／上限金額０９
  @Array( 9) external Array<Uint8> limitCheckLowerAmount09; // 支払方法毎のﾘﾐｯﾄ／下限金額０９
  @Array( 3) external Array<Uint8> limitCheckPaymentCode10; // 支払方法毎のﾘﾐｯﾄ／支払区分１０
  @Array( 9) external Array<Uint8> limitCheckUpperAmount10; // 支払方法毎のﾘﾐｯﾄ／上限金額１０
  @Array( 9) external Array<Uint8> limitCheckLowerAmount10; // 支払方法毎のﾘﾐｯﾄ／下限金額１０
}

// -----------------------------------------------------
// 	CupData	銀聯カード
// -----------------------------------------------------
final class CupDataStruct extends Struct {
  @Array( 7) external Array<Uint8> cancelSystemNumber; // 取消／返品　銀聯番号
  @Array(13) external Array<Uint8> cancelProcessDate; // 取消／返品　取引日付
  @Array( 7) external Array<Uint8> cancelApprovalNumber; // 取消／返品　承認番号
}

// -----------------------------------------------------
// 	ICPrintInfo	IC印字情報 [POS連動用]
// -----------------------------------------------------
final class ICPrintInfoStruct extends Struct {
  @Array(14) external Array<Uint8> aID; // AID(ApplicationID)
  @Array(33) external Array<Uint8> aplLabel; // アプリケーションラベル
  @Array( 6) external Array<Uint8> aTC; // ATC
  @Array( 3) external Array<Uint8> cardSequenceNumber; // カードシーケンス番号
  @Uint8()   external int icMsType; // IC/MS識別子
  @Uint8()   external int confirmedPIN; // 暗証番号確認済み
  @Uint8()   external int signlessFlag; // サイン省略
  @Array(25) external Array<Uint8> extra1; // 予備１
  @Array(25) external Array<Uint8> extra2; // 予備２
  @Array(25) external Array<Uint8> extra3; // 予備３
}

// -----------------------------------------------------
// 	Config	接続先設定
// -----------------------------------------------------
final class ConfigStruct extends Struct {
  @Int32() 		external int svFlag; // 内部処理用フラグ：サブサーバの有無フラグ
  @Int32()		external int swFlag; // 内部処理用フラグ：サブサーバへ切り替え中フラグ
  @Array( 16)	external Array<Uint8> address;  // 接続先サーバIP
  @Array( 16)	external Array<Uint8> addressSub; // 接続先サブサーバIP
  @Int32() 		external int port; // 接続先サーバPort
  @Int32() 		external int portSub; // 接続先サブサーバPort
  @Int32() 		external int recvTimeOut; // 電文受信待ち時間(sec)
  @Int32() 		external int connTimeOut; // コネクション取得待ち時間(sec)
  @Int32() 		external int retryCount; // コネクションリトライ回数[*********未使用***************]
  @Int32()		external int logFlag; // ログ出力判定フラグ
  @Array(128)	external Array<Uint8> logFilePath; // ログ出力先フォルダ：指定無の場合カレントフォルダに出力
  @Int32() 		external int logSaveDate; // ログ保存日数：0指定の場合無制限
  @Int32() 		external int devFlag; // 開発用 DLL内部折返しフラグ
  @Int32()		external int trainingModeFlag; // トレーニングモードフラグ[POS連動用]
  @Array( 24)	external Array<Uint8> comNo; // シリアルポート名：Windowsの場合"COM1"等、Linuxの場合"/dev/ttyS1"等[POS連動用]
}

// -----------------------------------------------------
// 	★CreditParam	クレジット[磁気 マニュアル 端末判定 ICカード]
// -----------------------------------------------------
final class CreditParamStruct extends Struct {
  external HeaderDataStruct header;
  external SettleDataStruct settle;
  external PaymentDataStruct payment;
  external SettleResponseStruct rSettle;
  external CreditResponseStruct rCredit;
  external ICPrintInfoStruct iCPrint; // POS連動用追加フィールド
}
// -----------------------------------------------------
// 	★InquiryParam	問合せ
// -----------------------------------------------------
final class InquiryParamStruct extends Struct {
  external HeaderDataStruct header;
  external SettleDataStruct settle;
  external CreditResponseStruct rCredit;
  external InquiryResponseStruct rInquiry;
  external ExtInquiryResponseStruct rExtInquiry;
}

// -----------------------------------------------------
// 	★CupParam	銀聯
// -----------------------------------------------------
final class CupParamStruct extends Struct {
  external HeaderDataStruct header;
  external SettleDataStruct settle;
  external CupDataStruct cup;
  external SettleResponseStruct rSettle;
  external CreditResponseStruct rCredit;
}

// -----------------------------------------------------
// 	★MscParam	MSカード
// -----------------------------------------------------
final class PosMsParamStruct extends Struct {
  external HeaderDataStruct header;
  external CardDataStruct card;
}

// -----------------------------------------------------
// 	★CgcParam	CoGCa
// -----------------------------------------------------
final class PosCoGCaParamStruct extends Struct {
  external HeaderDataStruct header;
  external CardDataStruct card;
}

class FFIVega3000 {
  // PlusPosConnector.hに定義してある構造体サイズ
  static const configSize = 228;
  static const creditParamSize = 619;
  static const inquiryParamSize = 807;
  static const cupParamSize = 428;
  static const posMsParamSize = 268;
  static const posCoGCaParamSize = 268;

  static Function? callBackFunc;

  // Initialize
  /// 関数：makePlusPos()
  /// 機能：VEGA3000 Config構造体初期化
  /// 引数：Config vegaConf
  /// 戻値：なし
  void makePlusPos(Config vegaConf) {
    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      // 構造体へ詰めなおす
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      try {
        final int Function(Pointer<ConfigStruct> vegaConf) interface =
            vega3000Dylib
                .lookup<NativeFunction<Int16 Function(Pointer<ConfigStruct>)>>(
                    "makePlusPos")
                .asFunction();
        //APIコール
        interface(vegaConfStruct);
      } catch (e) {
        //
      } finally {
        // クラス変数へ詰めなおす
        cnvConfigOutPut(vegaConfStruct.ref, vegaConf);
        calloc.free(vegaConfStruct);
      }
    } else {
      debugPrint("FFIVega3000.makePlusPos() -- interface() WITHOUT_DEVICE実行");
    }
    return;
  }

// クレジット
  /// 関数：startPlusPosCredit()
  /// 機能：クレジットカード読取 構造体初期化
  /// 引数：CreditParam crdtParam
  ///     ：InquiryParam inqParam
  ///     ：Config vegaConf
  /// 戻値：false:初期化、端末との通信が正常終了しなかった true:初期化、端末との通信が正常終了
  bool startPlusPosCredit(
      CreditParam crdtParam, InquiryParam inqParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CreditParamStruct> crdtParamStruct = calloc.allocate(creditParamSize);
      Pointer<InquiryParamStruct> inqParamStruct = calloc.allocate(inquiryParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCreditParamToStruct(crdtParam, crdtParamStruct);
      cnvInquiryParamToStruct(inqParam, inqParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<CreditParamStruct> crdtParam,
              Pointer<InquiryParamStruct> inqParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(
                          Pointer<CreditParamStruct>,
                          Pointer<InquiryParamStruct>,
                          Pointer<ConfigStruct>)>>("startPlusPosCredit")
              .asFunction();
      //APIコール
      result = interface(crdtParamStruct, inqParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(crdtParamStruct.ref.header, crdtParam.header);
      cnvSettleResponseOutPut(crdtParamStruct.ref.rSettle, crdtParam.rSettle);
      cnvCreditResponseOutPut(crdtParamStruct.ref.rCredit, crdtParam.rCredit);
      cnvICPrintInfoOutPut(crdtParamStruct.ref.iCPrint, crdtParam.iCPrint);
      cnvHeaderDataOutPut(inqParamStruct.ref.header, inqParam.header);
      cnvCreditResponseOutPut(inqParamStruct.ref.rCredit, inqParam.rCredit);
      cnvInquiryResponseOutPut(inqParamStruct.ref.rInquiry, inqParam.rInquiry);
      cnvExtInquiryResponseOutPut(inqParamStruct.ref.rExtInquiry, inqParam.rExtInquiry);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(crdtParamStruct);
      calloc.free(inqParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.startPlusPosCredit() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：plusPosCredit()
  /// 機能：クレジットカード読取 処理実行
  /// 引数：CreditParam crdtParam
  ///     ：Config vegaConf
  /// 戻値：false:サーバとの通信が正常終了しなかった true:サーバとの通信が正常終了
  bool plusPosCredit(CreditParam crdtParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CreditParamStruct> crdtParamStruct = calloc.allocate(creditParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCreditParamToStruct(crdtParam, crdtParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(Pointer<CreditParamStruct> crdtParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<CreditParamStruct>,
                          Pointer<ConfigStruct>)>>("PlusPosCredit")
              .asFunction();
      //APIコール
      result = interface(crdtParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(crdtParamStruct.ref.header, crdtParam.header);
      cnvSettleResponseOutPut(crdtParamStruct.ref.rSettle, crdtParam.rSettle);
      cnvCreditResponseOutPut(crdtParamStruct.ref.rCredit, crdtParam.rCredit);
      cnvICPrintInfoOutPut(crdtParamStruct.ref.iCPrint, crdtParam.iCPrint);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(crdtParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint("FFIVega3000.plusPosCredit() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：plusPosInquiry()
  /// 機能：クレジットカード問い合わせ 処理実行
  /// 引数：InquiryParam inqParam
  ///     ：Config vegaConf
  /// 戻値：false:サーバとの通信が正常終了しなかった true:サーバとの通信が正常終了
  bool plusPosInquiry(InquiryParam inqParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<InquiryParamStruct> inqParamStruct = calloc.allocate(inquiryParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvInquiryParamToStruct(inqParam, inqParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(Pointer<InquiryParamStruct> inqParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<InquiryParamStruct>,
                          Pointer<ConfigStruct>)>>("PlusPosInquiry")
              .asFunction();
      //APIコール
      result = interface(inqParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(inqParamStruct.ref.header, inqParam.header);
      cnvCreditResponseOutPut(inqParamStruct.ref.rCredit, inqParam.rCredit);
      cnvInquiryResponseOutPut(inqParamStruct.ref.rInquiry, inqParam.rInquiry);
      cnvExtInquiryResponseOutPut(inqParamStruct.ref.rExtInquiry, inqParam.rExtInquiry);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(inqParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.plusPosInquiry() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：endPlusPosCredit()
  /// 機能：クレジットカード読取 処理終了
  /// 引数：CreditParam crdtParam
  ///     ：InquiryParam inqParam
  ///     ：Config vegaConf
  /// 戻値：false:端末との通信が正常終了しなかった true:端末との通信が正常終了
  bool endPlusPosCredit(
      CreditParam crdtParam, InquiryParam inqParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CreditParamStruct> crdtParamStruct = calloc.allocate(creditParamSize);
      Pointer<InquiryParamStruct> inqParamStruct = calloc.allocate(inquiryParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCreditParamToStruct(crdtParam, crdtParamStruct);
      cnvInquiryParamToStruct(inqParam, inqParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<CreditParamStruct> crdtParam,
              Pointer<InquiryParamStruct> inqParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(
                          Pointer<CreditParamStruct>,
                          Pointer<InquiryParamStruct>,
                          Pointer<ConfigStruct>)>>("endPlusPosCredit")
              .asFunction();
      //APIコール
      result = interface(crdtParamStruct, inqParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(crdtParamStruct.ref.header, crdtParam.header);
      cnvSettleResponseOutPut(crdtParamStruct.ref.rSettle, crdtParam.rSettle);
      cnvCreditResponseOutPut(crdtParamStruct.ref.rCredit, crdtParam.rCredit);
      cnvICPrintInfoOutPut(crdtParamStruct.ref.iCPrint, crdtParam.iCPrint);
      cnvHeaderDataOutPut(inqParamStruct.ref.header, inqParam.header);
      cnvCreditResponseOutPut(inqParamStruct.ref.rCredit, inqParam.rCredit);
      cnvInquiryResponseOutPut(inqParamStruct.ref.rInquiry, inqParam.rInquiry);
      cnvExtInquiryResponseOutPut(inqParamStruct.ref.rExtInquiry, inqParam.rExtInquiry);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(crdtParamStruct);
      calloc.free(inqParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.endPlusPosCredit() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

 // 銀聯
  /// 関数：startPlusPosCup()
  /// 機能：銀聯カード読取 構造体初期化
  /// 引数：CupParam cupParam
  ///     ：Config vegaConf
  /// 戻値：false:初期化、通信が正常終了しなかった true:初期化、通信が正常終了
  bool startPlusPosCup(CupParam cupParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CupParamStruct> cupParamStruct = calloc.allocate(cupParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCupParamToStruct(cupParam, cupParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<CupParamStruct> cupParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<CupParamStruct>,
                          Pointer<ConfigStruct>)>>("startPlusPosCup")
              .asFunction();
      //APIコール
      result = interface(cupParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cupParamStruct.ref.header, cupParam.header);
      cnvSettleResponseOutPut(cupParamStruct.ref.rSettle, cupParam.rSettle);
      cnvCreditResponseOutPut(cupParamStruct.ref.rCredit, cupParam.rCredit);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cupParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.startPlusPosCup() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：plusPosCup()
  /// 機能：銀聯カード読取 処理実行
  /// 引数：CupParam cupParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool plusPosCup(CupParam cupParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CupParamStruct> cupParamStruct = calloc.allocate(cupParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCupParamToStruct(cupParam, cupParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<CupParamStruct> cupParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<CupParamStruct>,
                          Pointer<ConfigStruct>)>>("PlusPosCup")
              .asFunction();
      //APIコール
      result = interface(cupParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cupParamStruct.ref.header, cupParam.header);
      cnvSettleResponseOutPut(cupParamStruct.ref.rSettle, cupParam.rSettle);
      cnvCreditResponseOutPut(cupParamStruct.ref.rCredit, cupParam.rCredit);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cupParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint("FFIVega3000.plusPosCup() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：endPlusPosCup()
  /// 機能：銀聯カード読取 処理終了
  /// 引数：CupParam cupParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool endPlusPosCup(CupParam cupParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<CupParamStruct> cupParamStruct = calloc.allocate(cupParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvCupParamToStruct(cupParam, cupParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<CupParamStruct> cupParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<CupParamStruct>,
                          Pointer<ConfigStruct>)>>("endPlusPosCup")
              .asFunction();
      //APIコール
      result = interface(cupParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cupParamStruct.ref.header, cupParam.header);
      cnvSettleResponseOutPut(cupParamStruct.ref.rSettle, cupParam.rSettle);
      cnvCreditResponseOutPut(cupParamStruct.ref.rCredit, cupParam.rCredit);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cupParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint("FFIVega3000.endPlusPosCup() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

// MSカード
  /// 関数：startPlusPosMsRead()
  /// 機能：MSカード読取 構造体初期化
  /// 引数：PosMsParam msParam
  ///     ：Config vegaConf
  /// 戻値：false:初期化、通信が正常終了しなかった true:初期化、通信が正常終了
  bool startPlusPosMsRead(PosMsParam msParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosMsParamStruct> msParamStruct = calloc.allocate(posMsParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvPosMsParamToStruct(msParam, msParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<PosMsParamStruct> msParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosMsParamStruct>,
                          Pointer<ConfigStruct>)>>("startPlusPosMsRead")
              .asFunction();
      //APIコール
      result = interface(msParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(msParamStruct.ref.header, msParam.header);
      cnvCardDataOutPut(msParamStruct.ref.card, msParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(msParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.startPlusPosMsRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：plusPosMsRead()
  /// 機能：MSカード読取 処理実行
  /// 引数：PosMsParam msParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool plusPosMsRead(PosMsParam msParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosMsParamStruct> msParamStruct = calloc.allocate(posMsParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvPosMsParamToStruct(msParam, msParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<PosMsParamStruct> msParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosMsParamStruct>,
                          Pointer<ConfigStruct>)>>("PlusPosMsRead")
              .asFunction();
      //APIコール
      result = interface(msParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(msParamStruct.ref.header, msParam.header);
      cnvCardDataOutPut(msParamStruct.ref.card, msParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(msParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint("FFIVega3000.plusPosMsRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：endPlusPosMsRead()
  /// 機能：MSカード読取 処理終了
  /// 引数：PosMsParam msParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool endPlusPosMsRead(PosMsParam msParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosMsParamStruct> msParamStruct = calloc.allocate(posMsParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvPosMsParamToStruct(msParam, msParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(
              Pointer<PosMsParamStruct> msParam, Pointer<ConfigStruct> vegaConf)
          interface = vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosMsParamStruct>,
                          Pointer<ConfigStruct>)>>("endPlusPosMsRead")
              .asFunction();

      //APIコール
      result = interface(msParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(msParamStruct.ref.header, msParam.header);
      cnvCardDataOutPut(msParamStruct.ref.card, msParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(msParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.endPlusPosMsRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

// CoGCa
  /// 関数：startPlusPosCoGCaRead()
  /// 機能：CoGCaカード読取 構造体初期化
  /// 引数：PosCoGCaParam cogcaParam
  ///     ：Config vegaConf
  /// 戻値：false:初期化、通信が正常終了しなかった true:初期化、通信が正常終了
  bool startPlusPosCoGCaRead(PosCoGCaParam cogcaParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosCoGCaParamStruct> cogcaParamStruct = calloc.allocate(posCoGCaParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      // 構造体へ変換
      cnvPosCoGCaParamToStruct(cogcaParam, cogcaParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(Pointer<PosCoGCaParamStruct> cogcaParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosCoGCaParamStruct>,
                          Pointer<ConfigStruct>)>>("startPlusPosCoGCaRead")
              .asFunction();
      //APIコール
      result = interface(cogcaParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cogcaParamStruct.ref.header, cogcaParam.header);
      cnvCardDataOutPut(cogcaParamStruct.ref.card, cogcaParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cogcaParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.startPlusPosCoGCaRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：plusPosCoGCaRead()
  /// 機能：CoGCaカード読取 処理実行
  /// 引数：PosCoGCaParam cogcaParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool plusPosCoGCaRead(PosCoGCaParam cogcaParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosCoGCaParamStruct> cogcaParamStruct = calloc.allocate(posCoGCaParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      // 構造体へ変換
      cnvPosCoGCaParamToStruct(cogcaParam, cogcaParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);

      final bool Function(Pointer<PosCoGCaParamStruct> cogcaParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosCoGCaParamStruct>,
                          Pointer<ConfigStruct>)>>("PlusPosCoGCaRead")
              .asFunction();
      //APIコール
      result = interface(cogcaParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cogcaParamStruct.ref.header, cogcaParam.header);
      cnvCardDataOutPut(cogcaParamStruct.ref.card, cogcaParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cogcaParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.plusPosCoGCaRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

  /// 関数：endPlusPosCoGCaRead()
  /// 機能：CoGCaカード読取 処理終了
  /// 引数：PosCoGCaParam cogcaParam
  ///     ：Config vegaConf
  /// 戻値：false:通信が正常終了しなかった true:通信が正常終了
  bool endPlusPosCoGCaRead(PosCoGCaParam cogcaParam, Config vegaConf) {
    bool result;

    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<PosCoGCaParamStruct> cogcaParamStruct = calloc.allocate(posCoGCaParamSize);
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);
      cnvPosCoGCaParamToStruct(cogcaParam, cogcaParamStruct);
      cnvConfigToStruct(vegaConf, vegaConfStruct);
      final bool Function(Pointer<PosCoGCaParamStruct> cogcaParam,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                  NativeFunction<
                      Bool Function(Pointer<PosCoGCaParamStruct>,
                          Pointer<ConfigStruct>)>>("endPlusPosCoGCaRead")
              .asFunction();
      //APIコール
      result = interface(cogcaParamStruct, vegaConfStruct);
      cnvHeaderDataOutPut(cogcaParamStruct.ref.header, cogcaParam.header);
      cnvCardDataOutPut(cogcaParamStruct.ref.card, cogcaParam.card);
      cnvConfigOutPut(vegaConfStruct.ref, vegaConf);

      calloc.free(cogcaParamStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.endPlusPosCoGCaRead() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

// Cancel
  /// 関数：registeredCallbackFunction()
  /// 機能：コールバック関数を登録する
  /// 引数：なし
  /// 戻値：false:関数登録が正常終了しなかった true:関数登録が正常終了
  /// 備考：ネイティブ層にコールバック関数を登録してもdart側の呼び出しができなかったため、
  /// 　　　dart側に関数を登録する。
  ///　　　　実際のコールバック関数の呼び出しは
  ///　　　　executeRegisteredCallbackFunctionで実行する
  bool registeredCallbackFunction(Function func) {
    callBackFunc = func;
    return true;
  }

  /// 関数：executeRegisteredCallbackFunction()
  /// 機能：コールバック関数を実行する
  /// 引数：なし
  /// 戻値：false:関数登録が正常終了しなかった true:関数登録が正常終了
  static bool executeRegisteredCallbackFunction() {
    return callBackFunc?.call();
  }

  /// 関数：plusPosRegisterCancelCallback()
  /// 機能：キャンセル用コールバック関数登録
  /// 引数：Function func
  ///     ：Config vegaConf
  /// 戻値：false:関数登録が正常終了しなかった true:関数登録が正常終了
  bool plusPosRegisterCancelCallback(Function func, Config vegaConf) {
    bool result;
    //外部関数（インターフェース）
    if (!isWithoutDevice()) {
      // Dartの関数comparからC言語の関数ポインタに変換
      Pointer<NativeFunction<NativeDummy>> funcPointer =
          Pointer.fromFunction(executeRegisteredCallbackFunction, false);

      // PlusPosConnector.hに定義してある構造体のサイズ分領域確保
      Pointer<ConfigStruct> vegaConfStruct = calloc.allocate(configSize);

      cnvConfigToStruct(vegaConf, vegaConfStruct);
      final bool Function(Pointer<NativeFunction<NativeDummy>> func,
              Pointer<ConfigStruct> vegaConf) interface =
          vega3000Dylib
              .lookup<
                      NativeFunction<
                          Bool Function(Pointer<NativeFunction<NativeDummy>>,
                              Pointer<ConfigStruct>)>>(
                  "PlusPosRegisterCancelCallback")
              .asFunction();
      //APIコール
      result = interface(funcPointer, vegaConfStruct);
      calloc.free(vegaConfStruct);
    } else {
      debugPrint(
          "FFIVega3000.plusPosRegisterCancelCallback() -- interface() WITHOUT_DEVICE実行");
      result = true;
    }
    return (result);
  }

// 内部関数
  /// 関数：cnvConfigToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：Config src
  ///     ：Pointer<ConfigStruct> dest
  /// 戻値：なし
  static void cnvConfigToStruct(Config src, Pointer<ConfigStruct> dest) {
    int i;

    dest.ref.svFlag = src.svFlag;
    dest.ref.swFlag = src.swFlag;
    for (i = 0; i < src.address.length; i++) {
      if (src.address[i].isEmpty) {
        break;
      }
      dest.ref.address[i] = src.address[i].codeUnitAt(0);
    }
    for (i = 0; i < src.addressSub.length; i++) {
      if (src.addressSub[i].isEmpty) {
        break;
      }
      dest.ref.addressSub[i] = src.addressSub[i].codeUnitAt(0);
    }
    dest.ref.port = src.port;
    dest.ref.portSub = src.portSub;
    dest.ref.recvTimeOut = src.recvTimeOut;
    dest.ref.connTimeOut = src.connTimeOut;
    dest.ref.retryCount = src.retryCount;
    dest.ref.logFlag = src.logFlag;
    for (i = 0; i < src.logFilePath.length; i++) {
      if (src.logFilePath[i].isEmpty) {
        break;
      }
      dest.ref.logFilePath[i] = src.logFilePath[i].codeUnitAt(0);
    }
    dest.ref.logSaveDate = src.logSaveDate;
    dest.ref.devFlag = src.devFlag;
    dest.ref.trainingModeFlag = src.trainingModeFlag;
    for (i = 0; i < src.comNo.length; i++) {
      if (src.comNo[i].isEmpty) {
        break;
      }
      dest.ref.comNo[i] = src.comNo[i].codeUnitAt(0);
    }
  }

  /// 関数：cnvCreditParamToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：CreditParam src
  ///     ：Pointer<CreditParamStruct> dest
  /// 戻値：なし
  static void cnvCreditParamToStruct(
      CreditParam src, Pointer<CreditParamStruct> dest) {
    cnvHeaderDataToStruct(src.header, dest.ref.header);
    cnvSettleDataToStruct(src.settle, dest.ref.settle);
    cnvPaymentDataToStruct(src.payment, dest.ref.payment);
  }

  /// 関数：cnvInquiryParamToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：InquiryParam src
  ///     ：Pointer<InquiryParamStruct> dest
  /// 戻値：なし
  static void cnvInquiryParamToStruct(
      InquiryParam src, Pointer<InquiryParamStruct> dest) {
    cnvHeaderDataToStruct(src.header, dest.ref.header);
    cnvSettleDataToStruct(src.settle, dest.ref.settle);
  }

  /// 関数：cnvCupParamToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：CupParam src
  ///     ：Pointer<CupParamStruct> dest
  /// 戻値：なし
  static void cnvCupParamToStruct(CupParam src, Pointer<CupParamStruct> dest) {
    cnvHeaderDataToStruct(src.header, dest.ref.header);
    cnvSettleDataToStruct(src.settle, dest.ref.settle);
    cnvCupDataToStruct(src.cup, dest.ref.cup);
  }

  /// 関数：cnvPosMsParamToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：PosMsParam src
  ///     ：Pointer<PosMsParamStruct> dest
  /// 戻値：なし
  static void cnvPosMsParamToStruct(
      PosMsParam src, Pointer<PosMsParamStruct> dest) {
    cnvHeaderDataToStruct(src.header, dest.ref.header);
  }

  /// 関数：cnvPosCoGCaParamToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：PosCoGCaParam src
  ///     ：Pointer<PosCoGCaParamStruct> dest
  /// 戻値：なし
  static void cnvPosCoGCaParamToStruct(
      PosCoGCaParam src, Pointer<PosCoGCaParamStruct> dest) {
    cnvHeaderDataToStruct(src.header, dest.ref.header);
  }

  /// 関数：cnvHeaderDataToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：HeaderData src
  ///     ：HeaderDataStruct dest
  /// 戻値：なし
  static void cnvHeaderDataToStruct(HeaderData src, HeaderDataStruct dest) {
    int i;

    for (i = 0; i < src.businessCode.length; i++) {
      if (src.businessCode[i].isEmpty) {
        break;
      }
      dest.businessCode[i] = src.businessCode[i].codeUnitAt(0);
    }
    dest.businessSubCode = src.businessSubCode;
    for (i = 0; i < src.processDate.length; i++) {
      if (src.processDate[i].isEmpty) {
        break;
      }
      dest.processDate[i] = src.processDate[i].codeUnitAt(0);
    }
    for (i = 0; i < src.processTime.length; i++) {
      if (src.processTime[i].isEmpty) {
        break;
      }
      dest.processTime[i] = src.processTime[i].codeUnitAt(0);
    }
    for (i = 0; i < src.terminalID.length; i++) {
      if (src.terminalID[i].isEmpty) {
        break;
      }
      dest.terminalID[i] = src.terminalID[i].codeUnitAt(0);
    }
    for (i = 0; i < src.slipNumber.length; i++) {
      if (src.slipNumber[i].isEmpty) {
        break;
      }
      dest.slipNumber[i] = src.slipNumber[i].codeUnitAt(0);
    }
    dest.terminalType = src.terminalType;
    for (i = 0; i < src.extraA0.length; i++) {
      if (src.extraA0[i].isEmpty) {
        break;
      }
      dest.extraA0[i] = src.extraA0[i].codeUnitAt(0);
    }
    for (i = 0; i < src.operatorCode.length; i++) {
      if (src.operatorCode[i].isEmpty) {
        break;
      }
      dest.operatorCode[i] = src.operatorCode[i].codeUnitAt(0);
    }
    for (i = 0; i < src.memo1.length; i++) {
      if (src.memo1[i].isEmpty) {
        break;
      }
      dest.memo1[i] = src.memo1[i].codeUnitAt(0);
    }
    for (i = 0; i < src.memo2.length; i++) {
      if (src.memo2[i].isEmpty) {
        break;
      }
      dest.memo2[i] = src.memo2[i].codeUnitAt(0);
    }
    dest.testModeFlag = src.testModeFlag;
    for (i = 0; i < src.extraA1.length; i++) {
      if (src.extraA1[i].isEmpty) {
        break;
      }
      dest.extraA1[i] = src.extraA1[i].codeUnitAt(0);
    }
    dest.processingResult = src.processingResult;
    for (i = 0; i < src.errorCode.length; i++) {
      if (src.errorCode[i].isEmpty) {
        break;
      }
      dest.errorCode[i] = src.errorCode[i].codeUnitAt(0);
    }
    for (i = 0; i < src.message1.length; i++) {
      if (src.message1[i].isEmpty) {
        break;
      }
      dest.message1[i] = src.message1[i].codeUnitAt(0);
    }
    for (i = 0; i < src.message2.length; i++) {
      if (src.message2[i].isEmpty) {
        break;
      }
      dest.message2[i] = src.message2[i].codeUnitAt(0);
    }
    for (i = 0; i < src.responseCode.length; i++) {
      if (src.responseCode[i].isEmpty) {
        break;
      }
      dest.responseCode[i] = src.responseCode[i].codeUnitAt(0);
    }
    dest.dllFlag = src.dllFlag;
    for (i = 0; i < src.extraA2.length; i++) {
      if (src.extraA2[i].isEmpty) {
        break;
      }
      dest.extraA2[i] = src.extraA2[i].codeUnitAt(0);
    }

  }

  /// 関数：cnvSettleDataToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：SettleData src
  ///     ：SettleDataStruct dest
  /// 戻値：なし
  static void cnvSettleDataToStruct(SettleData src, SettleDataStruct dest) {
    int i;

    dest.reversalType = src.reversalType;
    dest.processType = src.processType;
    dest.approvalType = src.approvalType;
    for (i = 0; i < src.approvalNumber.length; i++) {
      if (src.approvalNumber[i].isEmpty) {
        break;
      }
      dest.approvalNumber[i] = src.approvalNumber[i].codeUnitAt(0);
    }
    dest.cardType = src.cardType;
    for (i = 0; i < src.salesAmount.length; i++) {
      if (src.salesAmount[i].isEmpty) {
        break;
      }
      dest.salesAmount[i] = src.salesAmount[i].codeUnitAt(0);
    }
    for (i = 0; i < src.taxPostage.length; i++) {
      if (src.taxPostage[i].isEmpty) {
        break;
      }
      dest.taxPostage[i] = src.taxPostage[i].codeUnitAt(0);
    }
    for (i = 0; i < src.goodsCode.length; i++) {
      if (src.goodsCode[i].isEmpty) {
        break;
      }
      dest.goodsCode[i] = src.goodsCode[i].codeUnitAt(0);
    }
    for (i = 0; i < src.tradingDate.length; i++) {
      if (src.tradingDate[i].isEmpty) {
        break;
      }
      dest.tradingDate[i] = src.tradingDate[i].codeUnitAt(0);
    }
    for (i = 0; i < src.businessDate.length; i++) {
      if (src.businessDate[i].isEmpty) {
        break;
      }
      dest.businessDate[i] = src.businessDate[i].codeUnitAt(0);
    }
    for (i = 0; i < src.pIN.length; i++) {
      if (src.pIN[i].isEmpty) {
        break;
      }
      dest.pIN[i] = src.pIN[i].codeUnitAt(0);
    }
    for (i = 0; i < src.originalSlipNumber.length; i++) {
      if (src.originalSlipNumber[i].isEmpty) {
        break;
      }
      dest.originalSlipNumber[i] = src.originalSlipNumber[i].codeUnitAt(0);
    }
    for (i = 0; i < src.originalTradingDate.length; i++) {
      if (src.originalTradingDate[i].isEmpty) {
        break;
      }
      dest.originalTradingDate[i] = src.originalTradingDate[i].codeUnitAt(0);
    }
  }

  /// 関数：cnvPaymentDataToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：PaymentData src
  ///     ：PaymentDataStruct dest
  /// 戻値：なし
  static void cnvPaymentDataToStruct(PaymentData src, PaymentDataStruct dest) {
    int i;

    for (i = 0; i < src.paymentType.length; i++) {
      if (src.paymentType[i].isEmpty) {
        break;
      }
      dest.paymentType[i] = src.paymentType[i].codeUnitAt(0);
    }
    for (i = 0; i < src.paymentStartMonth.length; i++) {
      if (src.paymentStartMonth[i].isEmpty) {
        break;
      }
      dest.paymentStartMonth[i] = src.paymentStartMonth[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount01.length; i++) {
      if (src.bonusAmount01[i].isEmpty) {
        break;
      }
      dest.bonusAmount01[i] = src.bonusAmount01[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount02.length; i++) {
      if (src.bonusAmount02[i].isEmpty) {
        break;
      }
      dest.bonusAmount02[i] = src.bonusAmount02[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount03.length; i++) {
      if (src.bonusAmount03[i].isEmpty) {
        break;
      }
      dest.bonusAmount03[i] = src.bonusAmount03[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount04.length; i++) {
      if (src.bonusAmount04[i].isEmpty) {
        break;
      }
      dest.bonusAmount04[i] = src.bonusAmount04[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount05.length; i++) {
      if (src.bonusAmount05[i].isEmpty) {
        break;
      }
      dest.bonusAmount05[i] = src.bonusAmount05[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusAmount06.length; i++) {
      if (src.bonusAmount06[i].isEmpty) {
        break;
      }
      dest.bonusAmount06[i] = src.bonusAmount06[i].codeUnitAt(0);
    }
    for (i = 0; i < src.installmentNumber.length; i++) {
      if (src.installmentNumber[i].isEmpty) {
        break;
      }
      dest.installmentNumber[i] = src.installmentNumber[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusNumber.length; i++) {
      if (src.bonusNumber[i].isEmpty) {
        break;
      }
      dest.bonusNumber[i] = src.bonusNumber[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth01.length; i++) {
      if (src.bonusMonth01[i].isEmpty) {
        break;
      }
      dest.bonusMonth01[i] = src.bonusMonth01[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth02.length; i++) {
      if (src.bonusMonth02[i].isEmpty) {
        break;
      }
      dest.bonusMonth02[i] = src.bonusMonth02[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth03.length; i++) {
      if (src.bonusMonth03[i].isEmpty) {
        break;
      }
      dest.bonusMonth03[i] = src.bonusMonth03[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth04.length; i++) {
      if (src.bonusMonth04[i].isEmpty) {
        break;
      }
      dest.bonusMonth04[i] = src.bonusMonth04[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth05.length; i++) {
      if (src.bonusMonth05[i].isEmpty) {
        break;
      }
      dest.bonusMonth05[i] = src.bonusMonth05[i].codeUnitAt(0);
    }
    for (i = 0; i < src.bonusMonth06.length; i++) {
      if (src.bonusMonth06[i].isEmpty) {
        break;
      }
      dest.bonusMonth06[i] = src.bonusMonth06[i].codeUnitAt(0);
    }
  }

  /// 関数：cnvCupDataToStruct()
  /// 機能：クラス変数から構造体に変換
  /// 引数：CupData src
  ///     ：CupDataStruct dest
  /// 戻値：なし
  static void cnvCupDataToStruct(CupData src, CupDataStruct dest) {
    int i;

    for (i = 0; i < src.cancelSystemNumber.length; i++) {
      if (src.cancelSystemNumber[i].isEmpty) {
        break;
      }
      dest.cancelSystemNumber[i] = src.cancelSystemNumber[i].codeUnitAt(0);
    }
    for (i = 0; i < src.cancelProcessDate.length; i++) {
      if (src.cancelProcessDate[i].isEmpty) {
        break;
      }
      dest.cancelProcessDate[i] = src.cancelProcessDate[i].codeUnitAt(0);
    }
    for (i = 0; i < src.cancelApprovalNumber.length; i++) {
      if (src.cancelApprovalNumber[i].isEmpty) {
        break;
      }
      dest.cancelApprovalNumber[i] = src.cancelApprovalNumber[i].codeUnitAt(0);
    }
  }

  /// 関数：cnvConfigOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：ConfigStruct src
  ///     ：Config dest
  /// 戻値：なし
  static void cnvConfigOutPut(ConfigStruct src, Config dest) {
    int i;

    dest.svFlag = src.svFlag;
    dest.swFlag = src.swFlag;
    for (i = 0; i < 16; i++) {
      if (src.address[i].toRadixString(16) == "0") {
        break;
      }
      dest.address[i] = src.address[i].toRadixString(16);
    }
    for (i = 0; i < 16; i++) {
      if (src.addressSub[i].toRadixString(16) == "0") {
        break;
      }
      dest.addressSub[i] = src.addressSub[i].toRadixString(16);
    }
    dest.port = src.port;
    dest.portSub = src.portSub;
    dest.recvTimeOut = src.recvTimeOut;
    dest.connTimeOut = src.connTimeOut;
    dest.retryCount = src.retryCount;
    dest.logFlag = src.logFlag;
    for (i = 0; i < 128; i++) {
      if (src.logFilePath[i].toRadixString(16) == "0") {
        break;
      }
      dest.logFilePath[i] = src.logFilePath[i].toRadixString(16);
    }
    dest.logSaveDate = src.logSaveDate;
    dest.devFlag = src.devFlag;
    dest.trainingModeFlag = src.trainingModeFlag;
    for (i = 0; i < 24; i++) {
      if (src.comNo[i].toRadixString(16) == "0") {
        break;
      }
      dest.comNo[i] = src.comNo[i].toRadixString(16);
    }
  }

  /// 関数：cnvHeaderDataOutPut()
  /// 機能：クラス変数から構造体に変換
  /// 引数：HeaderDataStruct src
  ///     ：HeaderData dest
  /// 戻値：なし
  static void cnvHeaderDataOutPut(HeaderDataStruct src, HeaderData dest) {
    int i;

    for (i = 0; i < 7; i++) {
      if (src.processDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.processDate[i] = src.processDate[i].toRadixString(16);
    }
    for (i = 0; i < 7; i++) {
      if (src.processTime[i].toRadixString(16) == "0") {
        break;
      }
      dest.processTime[i] = src.processTime[i].toRadixString(16);
    }
    for (i = 0; i < 14; i++) {
      if (src.terminalID[i].toRadixString(16) == "0") {
        break;
      }
      dest.terminalID[i] = src.terminalID[i].toRadixString(16);
    }
    for (i = 0; i < 6; i++) {
      if (src.slipNumber[i].toRadixString(16) == "0") {
        break;
      }
      dest.slipNumber[i] = src.slipNumber[i].toRadixString(16);
    }
    dest.terminalType = src.terminalType;
    for (i = 0; i < 9; i++) {
      if (src.extraA0[i].toRadixString(16) == "0") {
        break;
      }
      dest.extraA0[i] = src.extraA0[i].toRadixString(16);
    }
    for (i = 0; i < 6; i++) {
      if (src.operatorCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.operatorCode[i] = src.operatorCode[i].toRadixString(16);
    }
    for (i = 0; i < 11; i++) {
      if (src.memo1[i].toRadixString(16) == "0") {
        break;
      }
      dest.memo1[i] = src.memo1[i].toRadixString(16);
    }
    for (i = 0; i < 11; i++) {
      if (src.memo2[i].toRadixString(16) == "0") {
        break;
      }
      dest.memo2[i] = src.memo2[i].toRadixString(16);
    }
    dest.testModeFlag = src.testModeFlag;
    for (i = 0; i < 11; i++) {
      if (src.extraA1[i].toRadixString(16) == "0") {
        break;
      }
      dest.extraA1[i] = src.extraA1[i].toRadixString(16);
    }
    dest.processingResult = src.processingResult;
    for (i = 0; i < 4; i++) {
      if (src.errorCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.errorCode[i] = src.errorCode[i].toRadixString(16);
    }
    for (i = 0; i < 24; i++) {
      if (src.message1[i].toRadixString(16) == "0") {
        break;
      }
      dest.message1[i] = src.message1[i].toRadixString(16);
    }
    for (i = 0; i < 24; i++) {
      if (src.message2[i].toRadixString(16) == "0") {
        break;
      }
      dest.message2[i] = src.message2[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.responseCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.responseCode[i] = src.responseCode[i].toRadixString(16);
    }
    dest.dllFlag = src.dllFlag;
    for (i = 0; i < 11; i++) {
      if (src.extraA2[i].toRadixString(16) == "0") {
        break;
      }
      dest.extraA2[i] = src.extraA2[i].toRadixString(16);
    }
  }

  /// 関数：cnvCardDataOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：CardDataStruct src
  ///     ：CardData dest
  /// 戻値：なし
  static void cnvCardDataOutPut(CardDataStruct src, CardData dest) {
    int i;

    dest.type = src.type;
    for (i = 0; i < 38; i++) {
      if (src.cardData1[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardData1[i] = src.cardData1[i].toRadixString(16);
    }
    for (i = 0; i < 70; i++) {
      if (src.cardData2[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardData2[i] = src.cardData2[i].toRadixString(16);
    }
  }

  /// 関数：cnvSettleResponseOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：SettleResponseStruct src
  ///     ：SettleResponse dest
  /// 戻値：なし
  static void cnvSettleResponseOutPut(
      SettleResponseStruct src, SettleResponse dest) {
    int i;

    for (i = 0; i < 8; i++) {
      if (src.approvalNumber[i].toRadixString(16) == "0") {
        break;
      }
      dest.approvalNumber[i] = src.approvalNumber[i].toRadixString(16);
    }
    for (i = 0; i < 7; i++) {
      if (src.approvalDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.approvalDate[i] = src.approvalDate[i].toRadixString(16);
    }
    for (i = 0; i < 7; i++) {
      if (src.centerProcessNumber[i].toRadixString(16) == "0") {
        break;
      }
      dest.centerProcessNumber[i] =
          src.centerProcessNumber[i].toRadixString(16);
    }
    dest.centerDistinction = src.centerDistinction;
    for (i = 0; i < 12; i++) {
      if (src.acquirerCompanyCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.acquirerCompanyCode[i] =
          src.acquirerCompanyCode[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.expirationDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.expirationDate[i] = src.expirationDate[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.swcProcessingDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.swcProcessingDate[i] = src.swcProcessingDate[i].toRadixString(16);
    }
    dest.onlineStateFlag = src.onlineStateFlag;
    for (i = 0; i < 3; i++) {
      if (src.icOnlineResponse[i].toRadixString(16) == "0") {
        break;
      }
      dest.icOnlineResponse[i] = src.icOnlineResponse[i].toRadixString(16);
    }
  }

  /// 関数：cnvCreditResponseOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：CreditResponseStruct src
  ///     ：CreditResponse dest
  /// 戻値：なし
  static void cnvCreditResponseOutPut(
      CreditResponseStruct src, CreditResponse dest) {
    int i;

    for (i = 0; i < 20; i++) {
      if (src.pAN[i].toRadixString(16) == "0") {
        break;
      }
      dest.pAN[i] = src.pAN[i].toRadixString(16);
    }
    for (i = 0; i < 6; i++) {
      if (src.cardCompanyCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardCompanyCode[i] = src.cardCompanyCode[i].toRadixString(16);
    }
    for (i = 0; i < 11; i++) {
      if (src.cardCompanyName[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardCompanyName[i] = src.cardCompanyName[i].toRadixString(16);
    }
    for (i = 0; i < 16; i++) {
      if (src.cardCompanyTEL[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardCompanyTEL[i] = src.cardCompanyTEL[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.companyCodeforPOS[i].toRadixString(16) == "0") {
        break;
      }
      dest.companyCodeForPOS[i] = src.companyCodeforPOS[i].toRadixString(16);
    }
    dest.businessConditionsCode = src.businessConditionsCode;
    dest.tieUpType = src.tieupType;
    dest.signLessFlag = src.signlessFlag;
    for (i = 0; i < 3; i++) {
      if (src.negaErrorCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.negaErrorCode[i] = src.negaErrorCode[i].toRadixString(16);
    }
    for (i = 0; i < 31; i++) {
      if (src.inquiryInfo01[i].toRadixString(16) == "0") {
        break;
      }
      dest.inquiryInfo01[i] = src.inquiryInfo01[i].toRadixString(16);
    }
    for (i = 0; i < 31; i++) {
      if (src.inquiryInfo02[i].toRadixString(16) == "0") {
        break;
      }
      dest.inquiryInfo02[i] = src.inquiryInfo02[i].toRadixString(16);
    }
  }

  /// 関数：cnvInquiryResponseOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：InquiryResponseStruct src
  ///     ：InquiryResponse dest
  /// 戻値：なし
  static void cnvInquiryResponseOutPut(
      InquiryResponseStruct src, InquiryResponse dest) {
    int i;

    for (i = 0; i < 6; i++) {
      if (src.cardCompanyCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardCompanyCode[i] = src.cardCompanyCode[i].toRadixString(16);
    }
    for (i = 0; i < 11; i++) {
      if (src.cardCompanyName[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardCompanyName[i] = src.cardCompanyName[i].toRadixString(16);
    }
    dest.paymentCheck = src.paymentCheck;
    for (i = 0; i < 21; i++) {
      if (src.paymentCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.paymentCode[i] = src.paymentCode[i].toRadixString(16);
    }
    dest.installmentCheckFlag = src.installmentCheckFlag;
    for (i = 0; i < 41; i++) {
      if (src.installmentNumber[i].toRadixString(16) == "0") {
        break;
      }
      dest.installmentNumber[i] = src.installmentNumber[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.installmentFrom[i].toRadixString(16) == "0") {
        break;
      }
      dest.installmentFrom[i] = src.installmentFrom[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.installmentTo[i].toRadixString(16) == "0") {
        break;
      }
      dest.installmentTo[i] = src.installmentTo[i].toRadixString(16);
    }
    dest.bonusMonthCheckFlag = src.bonusMonthCheckFlag;
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer01[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer01[i] = src.bonusMonthSummer01[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer02[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer02[i] = src.bonusMonthSummer02[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter01[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter01[i] = src.bonusMonthWinter01[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter02[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter02[i] = src.bonusMonthWinter02[i].toRadixString(16);
    }
    dest.bonusPeriodCheckFlag = src.bonusPeriodCheckFlag;
    for (i = 0; i < 5; i++) {
      if (src.bonusPeriodSummerFromDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusPeriodSummerFromDate[i] =
          src.bonusPeriodSummerFromDate[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.bonusPeriodSummerToDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusPeriodSummerToDate[i] =
          src.bonusPeriodSummerToDate[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.bonusPeriodWinterFromDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusPeriodWinterFromDate[i] =
          src.bonusPeriodWinterFromDate[i].toRadixString(16);
    }
    for (i = 0; i < 5; i++) {
      if (src.bonusPeriodWinterToDate[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusPeriodWinterToDate[i] =
          src.bonusPeriodWinterToDate[i].toRadixString(16);
    }
  }

  /// 関数：cnvExtInquiryResponseOutPut()
  /// 機能：クラス変数から構造体に変換
  /// 引数：ExtInquiryResponseStruct src
  ///     ：ExtInquiryResponse dest
  /// 戻値：なし
  static void cnvExtInquiryResponseOutPut(
      ExtInquiryResponseStruct src, ExtInquiryResponse dest) {
    int i;

    for (i = 0; i < 6; i++) {
      if (src.creditCompanyPublicCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.creditCompanyPublicCode[i] =
          src.creditCompanyPublicCode[i].toRadixString(16);
    }
    for (i = 0; i < 17; i++) {
      if (src.creditCompanyName[i].toRadixString(16) == "0") {
        break;
      }
      dest.creditCompanyName[i] = src.creditCompanyName[i].toRadixString(16);
    }
    for (i = 0; i < 11; i++) {
      if (src.creditCompanyReserveCode[i].toRadixString(16) == "0") {
        break;
      }
      dest.creditCompanyReserveCode[i] =
          src.creditCompanyReserveCode[i].toRadixString(16);
    }
    dest.creditCompanyType = src.creditCompanyType;
    for (i = 0; i < 12; i++) {
      if (src.issuerCodeForManualInput[i].toRadixString(16) == "0") {
        break;
      }
      dest.issuerCodeForManualInput[i] =
          src.issuerCodeForManualInput[i].toRadixString(16);
    }
    for (i = 0; i < 16; i++) {
      if (src.authorizationTEL[i].toRadixString(16) == "0") {
        break;
      }
      dest.authorizationTEL[i] = src.authorizationTEL[i].toRadixString(16);
    }
    for (i = 0; i < 4; i++) {
      if (src.kID[i].toRadixString(16) == "0") {
        break;
      }
      dest.kID[i] = src.kID[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer03[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer03[i] = src.bonusMonthSummer03[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer04[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer04[i] = src.bonusMonthSummer04[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer05[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer05[i] = src.bonusMonthSummer05[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthSummer06[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthSummer06[i] = src.bonusMonthSummer06[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter03[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter03[i] = src.bonusMonthWinter03[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter04[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter04[i] = src.bonusMonthWinter04[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter05[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter05[i] = src.bonusMonthWinter05[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.bonusMonthWinter06[i].toRadixString(16) == "0") {
        break;
      }
      dest.bonusMonthWinter06[i] = src.bonusMonthWinter06[i].toRadixString(16);
    }
    dest.paymentType25Repeat = src.paymentType25Repeat;
    dest.paymentType34Repeat = src.paymentType34Repeat;
    for (i = 0; i < 9; i++) {
      if (src.limitFirstTimeAmount[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitFirstTimeAmount[i] =
          src.limitFirstTimeAmount[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitUpperNumber22[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitUpperNumber22[i] = src.limitUpperNumber22[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitUpperNumber24[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitUpperNumber24[i] = src.limitUpperNumber24[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitUpperNumber25[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitUpperNumber25[i] = src.limitUpperNumber25[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitUpperNumber33[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitUpperNumber33[i] = src.limitUpperNumber33[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitUpperNumber34[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitUpperNumber34[i] = src.limitUpperNumber34[i].toRadixString(16);
    }
    dest.paymentStartMonth31 = src.paymentStartMonth31;
    dest.paymentStartMonth32 = src.paymentStartMonth32;
    dest.paymentStartMonth33 = src.paymentStartMonth33;
    dest.paymentStartMonth34 = src.paymentStartMonth34;
    dest.paymentStartMonth61 = src.paymentStartMonth61;
    dest.paymentStartMonth62 = src.paymentStartMonth62;
    dest.paymentStartMonth63 = src.paymentStartMonth63;
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode01[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode01[i] =
          src.limitCheckPaymentCode01[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount01[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount01[i] =
          src.limitCheckUpperAmount01[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount01[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount01[i] =
          src.limitCheckLowerAmount01[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode02[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode02[i] =
          src.limitCheckPaymentCode02[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount02[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount02[i] =
          src.limitCheckUpperAmount02[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount02[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount02[i] =
          src.limitCheckLowerAmount02[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode03[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode03[i] =
          src.limitCheckPaymentCode03[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount03[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount03[i] =
          src.limitCheckUpperAmount03[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount03[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount03[i] =
          src.limitCheckLowerAmount03[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode04[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode04[i] =
          src.limitCheckPaymentCode04[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount04[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount04[i] =
          src.limitCheckUpperAmount04[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount04[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount04[i] =
          src.limitCheckLowerAmount04[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode05[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode05[i] =
          src.limitCheckPaymentCode05[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount05[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount05[i] =
          src.limitCheckUpperAmount05[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount05[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount05[i] =
          src.limitCheckLowerAmount05[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode06[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode06[i] =
          src.limitCheckPaymentCode06[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount06[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount06[i] =
          src.limitCheckUpperAmount06[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount06[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount06[i] =
          src.limitCheckLowerAmount06[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode07[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode07[i] =
          src.limitCheckPaymentCode07[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount07[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount07[i] =
          src.limitCheckUpperAmount07[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount07[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount07[i] =
          src.limitCheckLowerAmount07[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode08[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode08[i] =
          src.limitCheckPaymentCode08[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount08[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount08[i] =
          src.limitCheckUpperAmount08[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount08[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount08[i] =
          src.limitCheckLowerAmount08[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode09[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode09[i] =
          src.limitCheckPaymentCode09[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount09[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount09[i] =
          src.limitCheckUpperAmount09[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount09[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount09[i] =
          src.limitCheckLowerAmount09[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.limitCheckPaymentCode10[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckPaymentCode10[i] =
          src.limitCheckPaymentCode10[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckUpperAmount10[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckUpperAmount10[i] =
          src.limitCheckUpperAmount10[i].toRadixString(16);
    }
    for (i = 0; i < 9; i++) {
      if (src.limitCheckLowerAmount10[i].toRadixString(16) == "0") {
        break;
      }
      dest.limitCheckLowerAmount10[i] =
          src.limitCheckLowerAmount10[i].toRadixString(16);
    }
  }

  /// 関数：cnvICPrintInfoOutPut()
  /// 機能：構造体からクラス変数に変換
  /// 引数：ICPrintInfoStruct src
  ///     ：ICPrintInfo dest
  /// 戻値：なし
  static void cnvICPrintInfoOutPut(ICPrintInfoStruct src, ICPrintInfo dest) {
    int i;

    for (i = 0; i < 14; i++) {
      if (src.aID[i].toRadixString(16) == "0") {
        break;
      }
      dest.aID[i] = src.aID[i].toRadixString(16);
    }
    for (i = 0; i < 33; i++) {
      if (src.aplLabel[i].toRadixString(16) == "0") {
        break;
      }
      dest.aplLabel[i] = src.aplLabel[i].toRadixString(16);
    }
    for (i = 0; i < 6; i++) {
      if (src.aTC[i].toRadixString(16) == "0") {
        break;
      }
      dest.aTC[i] = src.aTC[i].toRadixString(16);
    }
    for (i = 0; i < 3; i++) {
      if (src.cardSequenceNumber[i].toRadixString(16) == "0") {
        break;
      }
      dest.cardSequenceNumber[i] = src.cardSequenceNumber[i].toRadixString(16);
    }
    dest.icMsType = src.icMsType;
    dest.confirmedPIN = src.confirmedPIN;
    dest.signlessFlag = src.signlessFlag;
    for (i = 0; i < 25; i++) {
      if (src.extra1[i].toRadixString(16) == "0") {
        break;
      }
      dest.extra1[i] = src.extra1[i].toRadixString(16);
    }
    for (i = 0; i < 25; i++) {
      if (src.extra2[i].toRadixString(16) == "0") {
        break;
      }
      dest.extra2[i] = src.extra2[i].toRadixString(16);
    }
    for (i = 0; i < 25; i++) {
      if (src.extra3[i].toRadixString(16) == "0") {
        break;
      }
      dest.extra3[i] = src.extra3[i].toRadixString(16);
    }
  }
}
