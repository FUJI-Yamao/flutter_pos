/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// キーファンクション, 及び, キーオプション格納構造体
//  関連tprxソース: rxtbl_buff.h

import '../../lib/apllib/rm_db_read.dart';
import 'fnc_code.dart';
import 'rxmem_define.dart';

/// 小計キーオプション
///  関連tprxソース: rxtbl_buff.h - ky_stl_opt
class KyStlOpt {
  int ttlamtRead = 0; // 合計金額の読み上げ  0:する 1:しない
  int taxfreeTaxCd = 0; // 免税対象額税No.選択
  int taxfreeRcptQty = 0; // 免税レシート発行枚数
  int taxfreeAmt = 0; // 免税対象額
}

/// 現計キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_cha_opt
class KyCashOpt {
  int frcCustCallFlg = 0; // 会員呼出の強制  0:しない 1:する
  int stlMinusFlg = 0; // 小計額マイナス額の操作  0:しない 1:する
  int frcStlkyFlg = 0; // 小計キーの使用を強制  0:しない 1:する
  int stlOverFlg = 0; // 小計額を越える登録  0:禁止 1:有効 2:確認表示
  int splitEnbleFlg = 0; // 小計額未満の登録  0:禁止 1:有効
  int frcEntryFlg = 0; // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効 2:払出エラー時のみ
  int frcStlkyChkrFlg = 0; // チェッカーの小計キーを強制  0:しない 1:する
  int chgamtRecalcFlg = 0; // 釣銭再計算  0:する 1:しない
  int digit = 0; // 置数金額の桁制限
  int autoProcTime = 0; // 自動操作を開始するまでの経過時間
  int autoProcAmtOver = 0; // 入金額が合計額以上の場合, 自動動作  0:しない 1:する
  int endBtnFipDisp = 0; // おわりボタンの客側表示  0:する 1:しない
  int changeConfirm = 0; // おわりボタンの表示と音声を確認ボタンへ変更  0:する 1:しない
  int expSettleNo = 0; // 上位連携用  決済種番号
  int expChgamtSettleNo = 0; // 上位連携用  釣銭決済種番号
  int expSettleTyp = 0; // 上位連携用  決済種タイプ
  int expChgamtSettleTyp = 0; // 上位連携用  釣銭決済種タイプ
  int chargeBrndrefSelect = 0; // Verifoneチャージ時、ブランド指定　0:しない  1:する
  int chargeReceiptCtrl = 0; // Verifoneチャージ時、チャージレシートの即時印字　0:する  1:しない
  int mbrPrcKey = 0; //会員売価利用　0：しない　1：する (カネスエ様特注)
}

/// 会計キーオプション
/// 関連tprxソース: rxtbl_buff.h - campaign_lowlmt_amt
class KyChaOpt {
  int frcCustCallFlg = 0; // 会員呼出の強制  0:しない 1:する
  int stlMinusFlg = 0; // 小計額マイナス額の操作  0:しない 1:する
  int frcStlkyFlg = 0; // 小計キーの使用を強制  0:しない 1:する
  int stlOverFlg = 0; // 小計額を越える登録  0:禁止 1:有効 2:確認表示
  int splitEnbleFlg = 0; // 小計額未満の登録  0:禁止 1:有効
  int frcEntryFlg = 0; // 預り金額の置数強制  0:しない 1:する 2:確定処理 3:券面のみ
  int mulFlg = 0; // 乗算登録  0:禁止 1:有効
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効 2:払出エラー時のみ
  int tranUpdateFlg = 0; // 実績の在高加算方法  0:通常加算 1:現金加算
  int crdtEnbleFlg = 0; // 掛売登録  0:しない 1:する
  int crdtTyp = 0; // 掛売の種類
  int ticketCollectFlg = 0; // チケット回収  0:しない 1:する
  int digit = 0; // 置数金額の桁制限
  int nochgFlg = 0; // 釣り銭支払  0:あり 1:なし 2:確認表示 3:使用不可
  int restmpFlg = 0; // 収入印紙発行  0:する 1:しない
  int chkamtAddFlg = 0; // 券面のみ設定時, 枚数加算動作と枚数制限  0:しない 1:する
  int rcptkeyPrnFlg = 0; // 領収書キーによる領収書発行  0:する 1:しない
  int expSettleNo = 0; // 上位連携用  決済種番号
  int expChgamtSettleNo = 0; // 上位連携用  釣銭決済種番号
  int acntVoucharTyp = 0; // 売掛伝票の印字タイプ
  int exceptMsgTyp1 = 0; // キー使用時の除外メッセージタイプ1
  int exceptMsgTyp2 = 0; // キー使用時の除外メッセージタイプ2
  int expSettleTyp = 0; // 上位連携用  決済種タイプ
  int expChgamtSettleTyp = 0; // 上位連携用  釣銭決済種タイプ
  int chkAmt = 0; // 券面金額
  int cardTyp = 0; // 上位連携用  カードタイプ
  int toCashFlg = 0; // 検索訂正/通番訂正時、現金での返金  0:しない 1:する
  int verifoneChargeFlg = 0; // Verifone接続時、チャージを許可  0:しない 1:する（電子マネーのみ有効）
  int drwchkAutoSet = 0; // 差異チェック時、理論在高自動セット  0:しない 1:する
  int otherTyp = 0; // 会計の扱い  0:通常  1:ポイント値引  2:ｷｬｯｼｭﾚｽ
  int cashlessFlg = 0; // キャッシュレス対象  0:非対象  1:対象
  int cashlessTyp = 0; // キャッシュレス還元の扱い  0:しない  1:自動還元  2:返品還元
  int barcodepayScanTyp = 0; // バーコード決済タイプ  0:店舗スキャン  1:ユーザースキャン
  int mbrPrcKey = 0; //会員売価利用　0：しない　1：する (カネスエ様特注)
  int unreadCashTyp = 0; //未読現金  0：しない  1：する (多慶屋様特注)
  int campaignDscntOpe = 0; //割引操作  0：しない  1：する (多慶屋様特注 キャンペーン値引き)
  int campaignDscntRate = 0; //割引率 (多慶屋様特注 キャンペーン値引き)
  int campaignUprlmtAmt = 0; //上限金額 (多慶屋様特注 キャンペーン値引き)
  int campaignLowlmtAmt = 0; //操作下限額 (多慶屋様特注 キャンペーン値引き)
  int chaListDisp = 0; // 現外登録(会計一覧表示) 0：しない  1：する(フレスタ様特注)
}

/// 値引キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_dsc_opt
class KyDscOpt {
  int entryFlg = 0; // 置数値引  0:有効 1:禁止
  int itemDscpdscFlg = 0; // 単品に対する値引  0:有効 1:禁止
  int stldscpdscFlg = 0; // 小計に対する値引  0:有効 1:禁止
  int digit = 0; // 桁制限
  int trendsTyp = 0; // 企画フラグ  0:本部企画  1:店舗企画
  int dscAmt = 0; // 値引額
}

/// 割引キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_pdsc_opt
class KyPdscOpt {
  int entryFlg = 0; // 置数割引  0:有効 1:禁止
  int itemDscpdscFlg = 0; // 単品に対する割引  0:有効 1:禁止
  int stldscpdscFlg = 0; // 小計に対する割引  0:有効 1:禁止
  int pdscPer = 0; // 割引率
  int trendsTyp = 0; // 企画フラグ  0:本部企画  1:店舗企画
}

///秤/風袋キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_wttare_opt
class KyWttareOpt {
  int tareGram = 0; // 風袋値
  int digit = 0; // 桁制限
}

/// 返品キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_ref_opt
class KyRefOpt {
  int digit = 0; // 桁制限
  int mulRepeatFlg = 0; // 乗算. リピート登録  0:有効 1:禁止
}

/// 乗算キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_mul_opt
class KyMulOpt {
  int digit = 0; // 桁制限
}

/// 金額キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_prc_opt
class KyPrcOpt {
  int digit = 0; // 桁制限
  int entryAmtLimit = 0; // 金額制限
}

/// 取消キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_cncl_opt
class KyCnclOpt {
  int itemCnclFlg = 0; // 商品登録時の取消  0:有効 1:禁止
  int tendCnclFlg = 0; // 締め操作時の取消  0:有効 1:禁止
  int reasonSelectDisp = 0; // 理由選択画面の表示	0:しない　1:する
  int reasonPrint = 0; // 理由選択内容の印字	0:しない　1:する
}

/// 返瓶キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_brt_opt
class KyBrtOpt {
  int digit = 0; // 桁制限
  int mulRepeatFlg = 0; // 乗算. リピート登録  0:有効 1:禁止
  int calcPointFlg = 0; // 返ビン額をポイント対象額に加算  0:しない  1:する
  int calcStldscFlg = 0; // 返ビン額を小計値下対象額に加算  0:しない  1:する
  int chgCd = 0; // 返ビン税コード
  int btlRetAmt = 0; // 返ビン額
  int btlRetClsCd = 0; // 返ビン売上部門コード
  String btlRetPluCd = ""; // 返ビン売上PLUコード
  int btlPluListFlg = 0; // 返ビン商品をリスト表示  0:しない  1:する
}

/// 入金キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_cin_opt
class KyCinOpt {
  int frcSelectFlg = 0; // 金種別登録を強制  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int kyTyp = 0; // 一括入力時のファンクションキーコード
  int restmpFlg = 0; // 収入印紙発行  0:しない 1:する
  int divideFlg = 0; // 区分の入力  0:後入力 1:先入力
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
}

///  支払キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_out_opt
class KyOutOpt {
  int frcSelectFlg = 0; // 金種別登録を強制  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int kyTyp = 0; // 一括入力時のファンクションキーコード
  int divideFlg = 0; // 区分の入力  0:後入力 1:先入力
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
}

///  釣機入金キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chgcin_opt
class KyChgcinOpt {
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int restmpFlg = 0; // 収入印紙発行  0:しない 1:する
  int divideFlg = 0; // 区分の入力  0:後入力 1:先入力
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
}

///  釣機払出キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chgout_opt
class KyChgoutOpt {
  int frcSelectFlg = 0; // 金種別登録  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int divideFlg = 0; // 区分の入力  0:後入力 1:先入力
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
  int frcSelectOutFlg = 0; // 金種別出金  0:しない 1:硬貨のみ
}

///  釣準備キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_loan_opt
class KyLoanOpt {
  int frcSelectFlg = 0; // 金種別登録を強制  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int kyTyp = 0; // 一括入力時のファンクションキーコード
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
  int keepFlg = 0;
}

///  売上回収キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_pick_opt
class KyPickOpt {
  int frcSelectFlg = 0; // 金種別登録を強制  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int kyTyp = 0; // 一括入力時のファンクションキーコード
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
}

///  釣機回収キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chgpick_opt
class KyChgpickOpt {
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
  int frcSelectOutFlg = 0; // 金種別出金  0:しない 1:硬貨のみ
  int outBarcodeFlg = 0; // 出金情報バーコード印字  0:しない 1:する
}

/// 旧cKoptinoutMst踏襲
/// 入金、支払、釣機入金、釣機払出、回収、釣り準備の合算構造体。各キーオプション追加時はこの構造体にも追加必要
/// 関連tprxソース: rxtbl_buff.h - koptinout_buff
class KoptinoutBuff {
  int frcSelectFlg = 0; // 金種別登録を強制  0:しない 1:する
  int acbDrwFlg = 0; // 釣銭機使用時のドロア  0:禁止 1:有効
  int digit = 0; // 桁制限
  int kyTyp = 0; // 一括入力時のファンクションキーコード
  int restmpFlg = 0; // 収入印紙発行  0:しない 1:する
  int divideFlg = 0; // 区分の入力  0:後入力 1:先入力
  int tranCreateFlg = 0; // 実績作成  0:する 1:しない
  int frcSelectOutFlg = 0; // 金種別出金  0:しない 1:硬貨のみ
  int keepFlg = 0;
  int outBarcodeFlg = 0; // 出金情報バーコード印字  0:しない 1:する
}

///  スタンプキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_stamp_opt
class KyStampOpt {
  int entryFlg = 0; // 置数入力  0:有効 1:無効
  int limitCnt = 0; // 1客に許される回数
  int addPnt = 0; // 1回のポイント点数
  int digit = 0; // 桁制限
  int acctCd = 0; // アカウントコード
  String promoPluCd = ""; // 上位システム識別PLUコード
  String promoExtId = ""; // 上位システム識別企画番号
}

///  会員呼出キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_mbr_opt
class KyMbrOpt {
  int entryTelNo = 0; // 電話番号呼出  0:する 1:しない
  int telNoList = 0; // 電話番号一覧表示項目  0:生年月日 1:会員番号
  int maskDigit = 0; // 会員番号マスク桁数
}

/// 電話番号
/// 関連tprxソース: rxtbl_buff.h - ky_tel_opt
class KyTelOpt {
  int telNoList = 0; // 電話番号一覧表示項目  0:生年月日 1:会員番号
}

///  割増キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_plus_opt
class KyPlusOpt {
  int entryFlg = 0; // 置数割増  0:有効 1:無効
  int pplusPer = 0; // 割増率
}

///  手動ミックスマッチキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_manualmm_opt
class KyManualmmOpt {
  int entryFlg = 0; // 置数入力  0:有効 1:無効
  int schCd = 0; // スケジュール番号
}

///  多段割戻キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_mulrbt_opt
class KyMulrbtOpt {
  int entryFlg = 0; // 置数入力  0:有効 1:無効
  int digit = 0; // 桁制限
  int multrbtAmt = 0; // 発行金額
  int lowLimitPnt = 0; // 下限ポイント
}

///  領収書宣言キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_pre_rctfm_opt
class KyPreRctfmOpt {
  int restmpUpTran = 0; // 宣言取引の収入印紙実績  0:領収書実績に加算 1:レシート実績に加算
}

///  クレジット宣言キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_crdtin_opt
class KyCrdtinOpt {
  int manuInputFlg = 0; // カード番号の手入力を禁止
}

///  領収書キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_rctfm_opt
class KyRctfmOpt {
  int smileselfBtnDisp = 0; // 対面セルフの領収書ボタン表示  0:しない 1:する
  int restmpLimitFlg = 0; // 印紙申告課税限度額判断  0:税抜き 1:額面
  int sparePrn = 0; // 領収書控え印字  0:しない 1:する
  int payinfoPrn = 0; // 領収書タイプが明細付きの場合、支払詳細を記載 0:する 1:しない
}

///  プリカキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_preca_in_opt
class KyPrecaInOpt {
  int manuInputPasswd = 0; // カード番号の手入力固定パスワード変更
  int maskDigit = 0; // カード番号マスク桁数
  int manuInputFlg = 0; // カード番号の手入力  0:しない 1:する 2:パスワード
  int maskPosiFlg = 0; // カード番号のマスク  0:前マスク 1:後マスク 2:しない
  int chargeSmlclsCd = 0; // チャージ用部門外実績小分類番号
  int cardReadKind = 0; // カード番号読込  0:磁気カード 1:バーコード
  int selfChargeBtnFlg = 0; // スピードセルフ残高不足時のチャージボタン表示
  int repicaMultiUseFlg = 0; // レピカ複数枚カード利用  0:しない 1:する
  int memberCompanyCd = 0; // 加盟社コード
  int custNumReadOffset = 0; // 顧客番号読取り開始位置
  int custRereadConfirmFlg = 0; // 顧客一度読み 会員呼出済時の再読取りの確認表示
  int balPrintNoPrecaPayment = 0; // プリカ会計キー未使用時の残高情報印字  0:しない 1:する
}

///  直前訂正キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_corr_opt
class KyCorrOpt {
  int corrItemdspFlg = 0; // 直前訂正での商品名称表示  0:しない 1:する
}

///  両替キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_drw_opt
class KyDrwOpt {
  int frcStaffInputFlg = 0; // 従業員No.強制入力  0:しない 1:する
  int reasonSelectDisp = 0; // 理由選択画面の表示	0:しない　1:する
}

///  重さ単価キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_uprc_opt
class KyUprcOpt {
  int digit = 0; // 桁制限
}

///  BC券キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_bc_opt
class KyBcOpt {
  int bcPrc = 0; // BC売価
}

///  決済選択キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_payment_opt
class KyPaymentOpt {
  int kyCd1 = 0; // 会計キーキーコード1 (上段左)
  int kyCd2 = 0; // 会計キーキーコード2 (上段中央)
  int kyCd3 = 0; // 会計キーキーコード3 (上段右)
  int kyCd4 = 0; // 会計キーキーコード4 (中段左)
  int kyCd5 = 0; // 会計キーキーコード5 (中段中央)
  int kyCd6 = 0; // 会計キーキーコード6 (中段右)
  int kyCd7 = 0; // 会計キーキーコード7 (下段左)
  int kyCd8 = 0; // 会計キーキーコード8 (下段中央)
  int kyCd9 = 0; // 会計キーキーコード9 (下段右)
}

///  買上追加キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_add_pnt_opt
class KyAddPntOpt {
  int addTyp = 0; // ポイント加算入力タイプ  0:対象額  1:ポイント
  int amtSetFlg = 0; // ポイント加算時, 対象額の加算  0:する  1:しない
  int custSearchDisp = 0; // 会員検索条件の画面表示  0:全入力条件  1:会員番号のみ
  int custNameDisp = 0; // 顧客名称の表示  0:する  1:しない
  int taxinAmtDispFlg = 0; // 税込買上金額の入力画面表示  0:する  1:しない
  int taxoutAmtDispFlg = 0; // 税抜買上金額の入力画面表示  0:する  1:しない
  int addAmtLimit = 0; // 対象額の入力値上限
  int addPntLimit = 0; // ポイントの入力値上限
}

///  返品モードキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_refopr_opt
class KyRefoprOpt {
  int tranCustNum = 0; // 客数の加算  0:しない  1:する
  int reasonSelectDisp = 0; // 理由選択画面の表示	0:しない　1:する
  int reasonPrint = 0; // 理由選択内容の印字	0:しない　1:する
}

///  入金確定キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chg_deccin_opt
class KyChgDeccinOpt {
  int frcStlkyFlg = 0; // 小計キーの使用を強制  0:しない 1:する
}

///  税変換1-5オプション
/// 関連tprxソース: rxtbl_buff.h - ky_chg_tax
class KyChgTax {
  int chgCd = 0; // 税変換の税コード
  int assortChgCd = 0; // 一体資産(詰合せ固定)の標準税率税コード
  int opeTyp = 0; // 税変換方法
  int amtChgTyp = 0; // 税変換の金額計算
  int otherUse = 0; // 登録以外
}

///  ブランド残高照会キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_brndref_opt
class KyBrndrefOpt {
  int brndrefSelect = 0; // 残高照会時、ブランド指定　0:しない  1:する
}

///  検索訂正キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_esvoid_opt
class KyEsvoidOpt {
  int addPlu = 0; // 商品追加　0:しない 1:する
  int taxFree = 0; // 免税対応 0:しない 1:する
}

///  言語切替キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_langchg_opt
class KyLangchgOpt {
  int langchgNoYes = 0; // 言語切替  0:しない  1:する(直接切替)  2:する(選択切替)
  int switchableLang1 = 0; // 切替可能言語１  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang2 = 0; // 切替可能言語２  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang3 = 0; // 切替可能言語３  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang4 = 0; // 切替可能言語４  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang5 = 0; // 切替可能言語５  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang6 = 0; // 切替可能言語６  0:未使用  1:英語  2:中国語  3:韓国語
  int switchableLang7 = 0; // 切替可能言語７  0:未使用  1:英語  2:中国語  3:韓国語
}

///  指定訂正キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chg_select_items_opt
class KyChgSelectItemsOpt {
  int initDisplay = 0; // キー押下時の初期画面		0:単品  1:全体
  int pmInitSet = 0; // 割引処理初期値		0:割引1  1:割引2  2:割引3  3:割引4  4:割引5
  int dscInitSet = 0; // 値引処理初期値		0:値引1  1:値引2  2:値引3  3:値引4  4:値引5
  int chgqtyDisp = 0; // キー押下時、点数変更表示	0:する  1:しない
  int pchgDisp = 0; // キー押下時、売価変更表示	0:する  1:しない
  int pmDisp = 0; // キー押下時、割引表示		0:する  1:しない
  int dscDisp = 0; // キー押下時、値引表示		0:する  1:しない
  int mrateDisp = 0; // キー押下時、倍率変更表示	0:する  1:しない
  int allChgqtyEnable = 0; // 全体表示時、点数変更		0:する  1:しない
  int allPchgEnable = 0; // 全体表示時、売価変更		0:する  1:しない
  int allPmEnable = 0; // 全体表示時、割引処理		0:する  1:しない
  int allDscEnable = 0; // 全体表示時、値引処理		0:する  1:しない
  int allMrateEnable = 0; // 全体表示時、倍率変更処理	0:する  1:しない
  int mrateDecimalInput = 0; // 倍率変更処理時、小数点入力	0:する  1:しない
  int dscbarOpeAuth = 0; // 値下バーコード商品に対して売価変更、割引、値引を利用		0:しない  1:する
  int reasonDisp = 0; // 対象外商品の表示		0:する  1:しない
  int freeproductEnable = 0; // 無償商品		0:しない  1:する
}

///  購買履歴キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_buy_hist_opt
class KyBuyHistOpt {
  int buyHistContCust = 0; // 登録途中以外での購買履歴操作時、終了後に会員呼出状態を継続　0:する 1:しない 2:確認表示
  int buyHistTabInit = 0; // 切替タブの初期値　0:役立品 1:支援品 2:特選品 3:化粧品 4:全(ﾌｰｽﾞ除)
}

///  差異チェックキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_drwchk_opt
class KyDrwchkOpt {
  int pickBtnDisp = 0; // 売上回収ボタン表示　0:する 1:しない
  int menteCinBtnDisp = 0; // 釣機入金ボタン表示　0:する 1:しない
  int closepickBtnDisp = 0; // 従業員精算ボタン表示　0:する 1:しない
  int drwchkSpDrawAmt = 0; // 差異チェック時に、登録機の小計額未満を理論在高に含める　0:しない 1:する
}

///  チケット発行キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_tckt_issu
class KyTcktIssu {
  int tcktissuPoint = 0; // 登録途中以外での購買履歴操作時、終了後に会員呼出状態を継続　0:する 1:しない 2:確認表示
}

///  見積宣言キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_quotation_opt
class KyQuotationOpt {
  int frcMarkdownToPluprc = 0; // 見積宣言時はマークダウン商品も定番売価にする
}

/// 通番訂正キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_rcpt_void_opt
class KyRcptVoidOpt {
  int rcptVoidCashpayBalance = 0; // 現金返金　0:全額 1:差額
  int reasonSelectDisp = 0; // 理由選択画面の表示	0:しない　1:する
  int reasonPrint = 0; // 理由選択内容の印字	0:しない　1:する
  int rbtpntRtn = 0; // 訂正時に割戻ポイント分を戻す	0:する　1:しない
}

///  ﾒｲﾝﾒﾆｭｰキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_menu_opt
class KyMenuOpt {
  int wizadjForced = 0; // Wiz精算実績の取り込みを強制　0:しない  1:する
}

///  売価変更キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_pchg_opt
class KyPchgOpt {
  int reasonSelectDisp = 0; // 理由選択画面の表示	0:しない　1:する
}

///  従業員権限解除キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_stfrelease_opt
class KyStfreleaseOpt {
  int oneTouchOff = 0; // 再度キータッチで元に戻す	0:しない　1:する
}

///  レシート倍率キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_rrate_opt
class KyRrateOpt {
  int pointPerLimit = 0; // 倍率の上限値
}

///  ｵｰﾊﾞｰﾌﾛｰ庫ﾒﾝﾃﾅﾝｽキーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_acx_overflow_mente_opt
class KyAcxOverflowMenteOpt {
  int pickTranStock = 0; // 回収実績に使用する在高	0:実在高（精査枚数）	1:理論在高（移動履歴）
  int overRecalcJudge = 0; // 釣銭機空き不足による精査動作	0:精査する	1:精査しない
}

///  金額読込キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_read_money_opt
class KyReadMoneyOpt {
  int bar1User = 0; // 自由使用欄からの商品コード抽出方法（公共料金）	0:ユーザー1 1:ユーザー2
  int bar1SubidPos = 0; // 科目ID取得開始位置（公共料金）【ユーザー1のみ有効】	0～44 (0の場合は公共料金商品コードを使用)
  int bar1SubidLen = 0; // 科目ID取得桁数（公共料金）【ユーザー1のみ有効】0～6 (0の場合は公共料金商品コードを使用)
  int bar1PluCd = 0; // 公共料金商品コード（公共料金）0～999999 (0の場合は999999コード)
  int bar1ExpdateChk = 0; // 有効期限の判定（公共料金）0:しない 1:する
  int bar1ExpdateDisp = 0; // 有効期限の表示（公共料金）0:しない 1:する
}

///  棒金開キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_chgdrw_opt
class KyChgdrwOpt {
  int chgdrwStaffInput = 0; // 棒金開使用時、従業員入力 0:しない 1:する
}

///  端末カード読込キーオプション
/// 関連tprxソース: rxtbl_buff.h - ky_cat_cardread_opt
class KyCatCardreadOpt {
  int manualInput = 0; // カード番号の手入力（特定ユーザーのみ有効）	0:しない 1:する
  int useCard = 0; // 利用するカード（特定ユーザーのみ有効）	0:磁気カード 1:磁気カード＋FeliCaカード
}

/// 各キーオプション共用体
/// C言語で共用体として定義されていた物.
/// Dartではlateで遅延初期化することで、使わないプロパティのメモリは確保しないようにする.
/// 関連tprxソース: rxtbl_buff.h - KeyOptUnion
class KeyOptUnion {
  late KyStlOpt stl = KyStlOpt();
  late KyCashOpt cash = KyCashOpt();
  late KyChaOpt cha = KyChaOpt();
  late KyDscOpt dsc = KyDscOpt();
  late KyPdscOpt pdsc = KyPdscOpt();
  late KyWttareOpt wttare = KyWttareOpt();
  late KyRefOpt ref = KyRefOpt();
  late KyMulOpt mul = KyMulOpt();
  late KyPrcOpt prc = KyPrcOpt();
  late KyCnclOpt cncl = KyCnclOpt();
  late KyPickOpt pick = KyPickOpt();
  late KyLoanOpt loan = KyLoanOpt();
  late KyBrtOpt brt = KyBrtOpt();
  late KyCinOpt cin = KyCinOpt();
  late KyOutOpt out = KyOutOpt();
  late KyStampOpt stamp = KyStampOpt();
  late KyMbrOpt mbr = KyMbrOpt();
  late KyTelOpt tel = KyTelOpt();
  late KyPlusOpt plus = KyPlusOpt();
  late KyManualmmOpt manualmm = KyManualmmOpt();
  late KyMulrbtOpt mulrbt = KyMulrbtOpt();
  late KyChgoutOpt chgout = KyChgoutOpt();
  late KyChgcinOpt chgcin = KyChgcinOpt();
  late KyPreRctfmOpt preRctfm = KyPreRctfmOpt();
  late KyChgpickOpt chgpick = KyChgpickOpt();
  late KyCrdtinOpt crdtin = KyCrdtinOpt();
  late KyRctfmOpt rctfm = KyRctfmOpt();
  late KyPrecaInOpt precaIn = KyPrecaInOpt();
  late KyCorrOpt corr = KyCorrOpt();
  late KyDrwOpt drw = KyDrwOpt();
  late KyUprcOpt uprc = KyUprcOpt();
  late KyBcOpt bc = KyBcOpt();
  late KyPaymentOpt payment = KyPaymentOpt();
  late KyAddPntOpt addPnt = KyAddPntOpt();
  late KyRefoprOpt refOpr = KyRefoprOpt();
  late KyChgDeccinOpt chgdeccin = KyChgDeccinOpt();
  late KyChgTax chgTax = KyChgTax();
  late KyBrndrefOpt brndRef = KyBrndrefOpt();
  late KyLangchgOpt langChg = KyLangchgOpt();
  late KyEsvoidOpt esvoid = KyEsvoidOpt();
  late KyChgSelectItemsOpt chgSelectItems = KyChgSelectItemsOpt(); // 指定訂正キー
  late KyBuyHistOpt buyHist = KyBuyHistOpt();
  late KyDrwchkOpt drwChk = KyDrwchkOpt();
  late KyTcktIssu tcktIssu = KyTcktIssu();
  late KyQuotationOpt quotation = KyQuotationOpt();
  late KyRcptVoidOpt rcptvoid = KyRcptVoidOpt(); // 通番訂正
  late KyMenuOpt menu = KyMenuOpt();
  late KyPchgOpt pchg = KyPchgOpt(); // 売価変更
  late KyStfreleaseOpt stfRelease = KyStfreleaseOpt(); // 従業員権限解除
  late KyRrateOpt rRate = KyRrateOpt();
  late KyAcxOverflowMenteOpt acxOverFlowMente = KyAcxOverflowMenteOpt();
  late KyReadMoneyOpt readMoney = KyReadMoneyOpt(); // 金額読込
  late KyChgdrwOpt chgDrw = KyChgdrwOpt(); //棒金開
  late KyCatCardreadOpt catCardRead = KyCatCardreadOpt(); // 端末カード読込

  bool setDataFromDBMap(RxCommonBuf pCom, Map<String, dynamic> data) {
    bool isSuccessKyOpt = true;
    DBMapChangeRet<int> fncCdRet =
        RmDBRead.getIntValueFromDbMapRet(data["fnc_cd"]);
    isSuccessKyOpt &= fncCdRet.isSuccess;

    DBMapChangeRet<int> koptCdRet =
        RmDBRead.getIntValueFromDbMapRet(data["kopt_cd"]);
    isSuccessKyOpt &= koptCdRet.isSuccess;

    if (!isSuccessKyOpt) {
      return false;
    }
    DBMapChangeRet<int> koptDataRet =
        RmDBRead.getIntValueFromDbMapRet(data["kopt_data"]);
    isSuccessKyOpt &= koptDataRet.isSuccess;
    int fncCdId = fncCdRet.value;
    int koptCd = koptCdRet.value;
    int koptData = koptDataRet.value;

    FuncKey fncCd = FuncKey.getKeyDefine(fncCdId);
    if (fncCd == FuncKey.KY_STL) // 小計
    {
      if (koptCd == 1) {
        stl.taxfreeAmt = koptData;
      } else if (koptCd == 2) {
        stl.ttlamtRead = koptData;
      } else if (koptCd == 3) {
        stl.taxfreeTaxCd = koptData;
      } else if (koptCd == 4) {
        stl.taxfreeRcptQty = koptData;
      }
    } else if (fncCd == FuncKey.KY_CASH) // 現計
    {
      if (koptCd == 1) {
        cash.frcCustCallFlg = koptData;
      } else if (koptCd == 2) {
        cash.stlMinusFlg = koptData;
      } else if (koptCd == 3) {
        cash.frcStlkyFlg = koptData;
      } else if (koptCd == 4) {
        cash.stlOverFlg = koptData;
      } else if (koptCd == 5) {
        cash.splitEnbleFlg = koptData;
      } else if (koptCd == 6) {
        cash.frcEntryFlg = koptData;
      } else if (koptCd == 7) {
        cash.acbDrwFlg = koptData;
      } else if (koptCd == 8) {
        cash.frcStlkyChkrFlg = koptData;
      } else if (koptCd == 9) {
        cash.chgamtRecalcFlg = koptData;
      } else if (koptCd == 10) {
        cash.digit = koptData;
      } else if (koptCd == 11) {
        cash.autoProcTime = koptData;
      } else if (koptCd == 12) {
        cash.autoProcAmtOver = koptData;
      } else if (koptCd == 13) {
        cash.endBtnFipDisp = koptData;
      } else if (koptCd == 14) {
        cash.changeConfirm = koptData;
      } else if (koptCd == 15) {
        cash.expSettleNo = koptData;
      } else if (koptCd == 16) {
        cash.expChgamtSettleNo = koptData;
      } else if (koptCd == 17) {
        cash.expSettleTyp = koptData;
      } else if (koptCd == 18) {
        cash.expChgamtSettleTyp = koptData;
      } else if (koptCd == 19) {
        cash.chargeBrndrefSelect = koptData;
      } else if (koptCd == 20) {
        cash.chargeReceiptCtrl = koptData;
      } else if (koptCd == 21) {
        cash.mbrPrcKey = koptData;
      }
      pCom.dbKfnc[fncCdId].fncKind = KeyKindList.KEY_KIND_CASH;
    } else if ((fncCd == FuncKey.KY_CHA1) // 会計
        ||
        (fncCd == FuncKey.KY_CHA2) ||
        (fncCd == FuncKey.KY_CHA3) ||
        (fncCd == FuncKey.KY_CHA4) ||
        (fncCd == FuncKey.KY_CHA5) ||
        (fncCd == FuncKey.KY_CHA6) ||
        (fncCd == FuncKey.KY_CHA7) ||
        (fncCd == FuncKey.KY_CHA8) ||
        (fncCd == FuncKey.KY_CHA9) ||
        (fncCd == FuncKey.KY_CHA10) ||
        (fncCd == FuncKey.KY_CHA11) ||
        (fncCd == FuncKey.KY_CHA12) ||
        (fncCd == FuncKey.KY_CHA13) ||
        (fncCd == FuncKey.KY_CHA14) ||
        (fncCd == FuncKey.KY_CHA15) ||
        (fncCd == FuncKey.KY_CHA16) ||
        (fncCd == FuncKey.KY_CHA17) ||
        (fncCd == FuncKey.KY_CHA18) ||
        (fncCd == FuncKey.KY_CHA19) ||
        (fncCd == FuncKey.KY_CHA20) ||
        (fncCd == FuncKey.KY_CHA21) ||
        (fncCd == FuncKey.KY_CHA22) ||
        (fncCd == FuncKey.KY_CHA23) ||
        (fncCd == FuncKey.KY_CHA24) ||
        (fncCd == FuncKey.KY_CHA25) ||
        (fncCd == FuncKey.KY_CHA26) ||
        (fncCd == FuncKey.KY_CHA27) ||
        (fncCd == FuncKey.KY_CHA28) ||
        (fncCd == FuncKey.KY_CHA29) ||
        (fncCd == FuncKey.KY_CHA30) ||
        (fncCd == FuncKey.KY_CHK1) // 品券
        ||
        (fncCd == FuncKey.KY_CHK2) ||
        (fncCd == FuncKey.KY_CHK3) ||
        (fncCd == FuncKey.KY_CHK4) ||
        (fncCd == FuncKey.KY_CHK5)) {
      if (koptCd == 1) {
        cha.frcCustCallFlg = koptData;
      } else if (koptCd == 2) {
        cha.stlMinusFlg = koptData;
      } else if (koptCd == 3) {
        cha.frcStlkyFlg = koptData;
      } else if (koptCd == 4) {
        cha.stlOverFlg = koptData;
      } else if (koptCd == 5) {
        cha.splitEnbleFlg = koptData;
      } else if (koptCd == 6) {
        cha.frcEntryFlg = koptData;
      } else if (koptCd == 7) {
        cha.mulFlg = koptData;
      } else if (koptCd == 8) {
        cha.acbDrwFlg = koptData;
      } else if (koptCd == 9) {
        cha.tranUpdateFlg = koptData;
      } else if (koptCd == 10) {
        cha.crdtEnbleFlg = koptData;
      } else if (koptCd == 11) {
        cha.crdtTyp = koptData;
      } else if (koptCd == 12) {
        cha.ticketCollectFlg = koptData;
      } else if (koptCd == 13) {
        cha.digit = koptData;
      } else if (koptCd == 14) {
        cha.chkAmt = koptData;
      } else if (koptCd == 15) {
        cha.nochgFlg = koptData;
      } else if (koptCd == 16) {
        cha.restmpFlg = koptData;
      } else if (koptCd == 17) {
        cha.chkamtAddFlg = koptData;
      } else if (koptCd == 18) {
        cha.rcptkeyPrnFlg = koptData;
      } else if (koptCd == 19) {
        cha.expSettleNo = koptData;
      } else if (koptCd == 20) {
        cha.expChgamtSettleNo = koptData;
      } else if (koptCd == 21) {
        cha.expSettleTyp = koptData;
      } else if (koptCd == 22) {
        cha.acntVoucharTyp = koptData;
      } else if (koptCd == 23) {
        cha.exceptMsgTyp1 = koptData;
      } else if (koptCd == 24) {
        cha.exceptMsgTyp2 = koptData;
      } else if (koptCd == 25) {
        cha.expChgamtSettleTyp = koptData;
      } else if (koptCd == 26) {
        cha.cardTyp = koptData;
      } else if (koptCd == 27) {
        cha.toCashFlg = koptData;
      } else if (koptCd == 28) {
        cha.verifoneChargeFlg = koptData;
      } else if (koptCd == 29) {
        cha.drwchkAutoSet = koptData;
      } else if (koptCd == 30) {
        cha.otherTyp = koptData;
      } else if (koptCd == 31) {
        cha.cashlessFlg = koptData;
      } else if (koptCd == 32) {
        cha.cashlessTyp = koptData;
      } else if (koptCd == 33) {
        cha.barcodepayScanTyp = koptData;
      } else if (koptCd == 34) {
        cha.mbrPrcKey = koptData;
      } else if (koptCd == 35) {
        cha.unreadCashTyp = koptData;
      } else if (koptCd == 36) {
        cha.campaignDscntOpe = koptData;
      } else if (koptCd == 37) {
        cha.campaignDscntRate = koptData;
      } else if (koptCd == 38) {
        cha.campaignUprlmtAmt = koptData;
      } else if (koptCd == 39) {
        cha.campaignLowlmtAmt = koptData;
      } else if (koptCd == 40) {
        cha.chaListDisp = koptData;
      }
      pCom.dbKfnc[fncCdId].fncKind = KeyKindList.KEY_KIND_CHA;
    } else if ((fncCd == FuncKey.KY_DSC1) // 値引
        ||
        (fncCd == FuncKey.KY_DSC2) ||
        (fncCd == FuncKey.KY_DSC3) ||
        (fncCd == FuncKey.KY_DSC4) ||
        (fncCd == FuncKey.KY_DSC5)) {
      if (koptCd == 1) {
        dsc.entryFlg = koptData;
      } else if (koptCd == 2) {
        dsc.itemDscpdscFlg = koptData;
      } else if (koptCd == 3) {
        dsc.stldscpdscFlg = koptData;
      } else if (koptCd == 4) {
        dsc.dscAmt = koptData;
      } else if (koptCd == 5) {
        dsc.digit = koptData;
      } else if (koptCd == 6) {
        dsc.trendsTyp = koptData;
      }
      pCom.dbKfnc[fncCdId].fncKind = KeyKindList.KEY_KIND_DSC;
    } else if ((fncCd == FuncKey.KY_PM1) // 割引
        ||
        (fncCd == FuncKey.KY_PM2) ||
        (fncCd == FuncKey.KY_PM3) ||
        (fncCd == FuncKey.KY_PM4) ||
        (fncCd == FuncKey.KY_PM5)) {
      if (koptCd == 1) {
        pdsc.entryFlg = koptData;
      } else if (koptCd == 2) {
        pdsc.itemDscpdscFlg = koptData;
      } else if (koptCd == 3) {
        pdsc.stldscpdscFlg = koptData;
      } else if (koptCd == 4) {
        pdsc.pdscPer = koptData;
      } else if (koptCd == 5) {
        pdsc.trendsTyp = koptData;
      }
      pCom.dbKfnc[fncCdId].fncKind = KeyKindList.KEY_KIND_PDSC;
    } else if ((fncCd == FuncKey.KY_WTTARE1) // 風袋
        ||
        (fncCd == FuncKey.KY_WTTARE2) ||
        (fncCd == FuncKey.KY_WTTARE3) ||
        (fncCd == FuncKey.KY_WTTARE4) ||
        (fncCd == FuncKey.KY_WTTARE5) ||
        (fncCd == FuncKey.KY_WTTARE6) ||
        (fncCd == FuncKey.KY_WTTARE7) ||
        (fncCd == FuncKey.KY_WTTARE8) ||
        (fncCd == FuncKey.KY_WTTARE9) ||
        (fncCd == FuncKey.KY_WTTARE10)) {
      if (koptCd == 1) {
        wttare.tareGram = koptData;
      } else if (koptCd == 2) {
        wttare.digit = koptData;
      }
    } else if (fncCd == FuncKey.KY_REF) // 返品
    {
      if (koptCd == 1) {
        ref.digit = koptData;
      } else if (koptCd == 2) {
        ref.mulRepeatFlg = koptData;
      }
    } else if (fncCd == FuncKey.KY_MUL) // 乗算
    {
      if (koptCd == 1) {
        mul.digit = koptData;
      }
    }

    if (!isSuccessKyOpt) {
      return false;
    }
    return true;
  }
}

// ファンクションの種別
// 共有メモリへの反映時に同時セット
enum KeyKindList {
  KEY_KIND_NONE(0), // その他
  KEY_KIND_CASH(1), // 現計
  KEY_KIND_CHA(2), // 会計
//	KEY_KIND_CHK (3),	// 品券
  KEY_KIND_CIN(4), // 入金
  KEY_KIND_OUT(5), // 出金
  KEY_KIND_DSC(6), // 値引
  KEY_KIND_PDSC(7), // 割引
  KEY_KIND_PLUS(8); // 割増

  final int id;
  const KeyKindList(this.id);
}

// キーデータ
// cKeyfncMst, cKeyoptMstの情報を持つ
class KeyfncBuff {
  int fncCd = 0; // ファンクションキーコード
  bool fncDispFlg = false; // ファンクション表示フラグ  0:表示  1:非表示
  KeyKindList fncKind = KeyKindList.KEY_KIND_NONE; // ファンクションの種別
  late KeyOptUnion opt = KeyOptUnion(); // キーオプションの共用体
  String fncName = ""; // キー名称
}
