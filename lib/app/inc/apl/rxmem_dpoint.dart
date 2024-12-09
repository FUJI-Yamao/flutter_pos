/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// dポイントデータ_前取引情報
/// 関連tprxソース:rxmem_dpoint.h - struct RXMEM_DPOINT_ORGTRAN
class RxMemDPointOrgTran {
  /// 前取引先営業日
  String saleDate = "";
  /// 前取引先発生年月日
  String procDate = "";
  /// 前取引先発生時刻
  String procTime = "";
  /// 前端末識別番号
  int terminalId = 0;
  /// 前取引番号
  int	slipNo = 0;
  /// 前レシート番号
  int receiptNo = 0;
}

/// dポイントデータ
/// 関連tprxソース:rxmem_dpoint.h - struct RXMEM_DPOINT_DATA
class RxMemDPointData {
  /// dポイントカード番号
  String cardNo = "";
  /// 照会処理で取得したdポイントセンタ処理時間
  String inqDate = "";
  /// 利用可能ポイント
  int usablePoints = 0;
  /// 前取引情報（0:進呈情報, 1:利用情報）
  List<RxMemDPointOrgTran> orgTran = List.generate(2, (_) => RxMemDPointOrgTran());
}