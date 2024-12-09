/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */
/// 紙幣/硬貨の種別
enum BillCoinType {
  bill, // 紙幣
  coin, // 硬貨
}

/// 金額リスト
List<int> cashType = [
  10000,
  5000,
  2000,
  1000,
  500,
  100,
  50,
  10,
  5,
  1,
];

int cashCode = 14;

// 会計のコード表
List<int> accountingCode = [
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  384,
  385,
  386,
  387,
  388,
  389,
  390,
  391,
  392,
  393,
  394,
  395,
  396,
  397,
  398,
  399,
  400,
  401,
  402,
  403,
];

//品券のコード表
List<int> giftCertificateCode = [
  26,
  27,
  28,
  29,
  30,
];

/// 内訳表のヘッダ
List<String> breakDownHeader = [
  'つり準備',
  '入金',
  '支払い',
  '売上回収',
  'その他',
  '合計',
];

/// 各金種の在高情報
class ChangeData {
  /// 紙幣/硬貨の種別
  BillCoinType billCoinType;

  /// 金額
  int amount;

  /// 枚数
  int value;

  /// コンストラクタ
  ChangeData({
    required this.billCoinType,
    required this.amount,
    required this.value,
  });
}

/// 在高内訳情報
class BreakDownData {
  // 名称
  String header;

  /// 現金在高
  int cashStockData;

  /// 会計在高
  int accountStockData;

  /// 各金種の在高割合
  int giftCardStockData;

  ///合計
  int rowSum;

  /// コンストラクタ
  BreakDownData({
    required this.header,
    required this.cashStockData,
    required this.accountStockData,
    required this.giftCardStockData,
    required this.rowSum,
  });
}

/// 各金種の在高情報
class NonCashData {
  /// ラベルタイトル
  String title;

  ///　データ
  int value;

  /// コンストラクタ
  NonCashData({
    required this.title,
    required this.value,
  });
}
