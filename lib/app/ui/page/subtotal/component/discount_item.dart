/// 割引／値引の変数用クラス
class DiscountItem  {
  final String title;
  final int dscValue;
  final StlDscType dscType;

  const DiscountItem({
    required this.title,
    required this.dscValue,
    required this.dscType,
  });
}
/// 小計値下のタイプ
enum StlDscType {
  // なし
  none,
  // 値引
  dsc,
  // 割引
  pdsc,
}
