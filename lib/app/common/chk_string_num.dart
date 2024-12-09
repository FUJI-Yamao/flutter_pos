/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
class ChkStringNum {
  /// 文字列の内容が「0」かどうか
  static bool checkZero(String dst) {
    var list = dst.split(''); // 文字ごとに区切ってリストへ変換.
    for (var str in list) {
      int? num = int.tryParse(str);
      if (num == null || num != 0) {
        return false;
      }
    }
    return true;
  }
}
