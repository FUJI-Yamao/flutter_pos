/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// ログレベル
///  関連tprxソース:tprlog.h Log Numbers
class LogLevelDefine {
  static const error = -1;
  static const warning = 0;
  static const normal = 1;
  static const other1 = 2;
  static const other2 = 3;
  static const other3 = 4;
  static const other4 = 5;
  static const fCall = other1;
  static const sql = other2;
  static const jpnDisp = 6; //日本語ログ.
  static const hqFtp = 9;
}
