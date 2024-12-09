/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class RckySpbarcodeRead{
  // TODO:10121 QUICPay、iD 202404実装対象外
  /// フレスタ様クーポンポイント実績クリア
  /// 関連tprxソース: rcky_spbarcode_read.c - rc_SpBarCode_FspPnt_Clr
  /// 引数：なし
  /// 戻値：なし
  static void rcSpBarCodeFspPntClr(){
    return;
  }

  // TODO:00014 日向 rc_key_cash.dart実装中、必要なため定義だけ先行で追加
  /// 関連tprxソース: rcky_spbarcode_read.c - rc_SpBarCode_SvrErrDlg()
  static void rcSpBarCodeSvrErrDlg(int fncCd, int errNo) {
    return;
  }

  //実装は必要だがARKS対応では除外
  /// 関連tprxソース: rcky_spbarcode_read.c - rc_FrestaSpBarcode_Draw
  static void rcFrestaSpBarcodeDraw() {}
  
}