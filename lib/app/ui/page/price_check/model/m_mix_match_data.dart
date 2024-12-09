/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// ミックスマッチデータ
class MixMatchData {
  static const mixMatchItemName = 'ミックスマッチ';

  /// 条件のリスト
  List<MixMatchItem> mixMatchItems = <MixMatchItem>[];
  /// 最大条件数
  static const int mixMatchMaxItemNumber = 5;
  /// 成立後一般平均単価
  int generalAverageUnitPrice;
  /// 成立後会員平均単価
  int memberAverageUnitPrice;

  /// 一般用データ有無
  bool isGeneralExist;
  /// 会員用データ有無
  bool isMemberExist = false;
  /// 有効条件数
  int validConditionNumber = 0;

  MixMatchData({
    required this.mixMatchItems,
    required this.isGeneralExist,
    required this.isMemberExist,
    this.generalAverageUnitPrice = 0,
    this.memberAverageUnitPrice = 0,
  }) {
    int diff = mixMatchMaxItemNumber - mixMatchItems.length;
    // 内容が空であれ、登録されたアイテム数分を有効とする
    validConditionNumber = mixMatchItems.length;
    // 登録アイテムが最大条件数に満たない場合は空の内容でリストを埋める
    for (int i = 0; i < diff; i++) {
      MixMatchItem mixMatchItem = MixMatchItem(conditionName: '', generalQty: 0, generalPrice: 0, memberQty: 0, memberPrice: 0);
      mixMatchItems.add(mixMatchItem);
    }
  }
}

/// ミックスマッチ条件
class MixMatchItem {
  /// 条件名
  String conditionName;

  /// 一般個数
  int generalQty;

  /// 一般値引き額
  int generalPrice;

  /// 会員個数
  int memberQty;

  /// 会員値引き額
  int memberPrice;

  MixMatchItem({
    required this.conditionName,
    required this.generalQty,
    required this.generalPrice,
    required this.memberQty,
    required this.memberPrice,
  });
}