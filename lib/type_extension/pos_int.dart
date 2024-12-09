/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
/// POS専用にintを拡張する.
extension PosInt on int {
  /// 全角文字列へ変換する.
  /// ﾏｲﾅｽ記号も全角になる.
  String toTwoByteString() {
    // まずは半角文字列に変換.
    String oneByteStr = toString();

    // 全角と半角のcharコードの差分を取得.
    int diff = '０'.codeUnitAt(0) - '0'.codeUnitAt(0);
    // 半角文字列のcharコードに差分を足し合わせる.
    String twoByteStr =
        oneByteStr.runes.map((v) => String.fromCharCode(v + diff)).join();

    return twoByteStr;
  }
}
