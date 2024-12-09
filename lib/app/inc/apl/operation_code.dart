/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース:operation_code.h - OPERATION_LISTS
enum OperationLists {
  /// 販売注意商品の登録
  OPE_CAUTION_ITEM(1),
  /// 販売不可商品の登録
  OPE_NONSALE_ITEM(2),
  /// パスワード確認
  OPE_CHECK_PASSWORD(3),
  /// 酒税免税設定変更
  OPE_LIQRTAX_CHANGE(4);

  static int get MAX_OPERATION => OperationLists.values.last.id + 1;
  final int id;
  const OperationLists(this.id);
}