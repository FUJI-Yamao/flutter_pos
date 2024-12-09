/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'rc_elog.dart';

///  関連tprxソース: rckyprecavoid.c
class RcKyPrecaVoid {
  static PrecaVoid precaVoid = PrecaVoid();

  ///  関連tprxソース: rckyprecavoid.c -PrecaVoid_PopUp
  // TODO:00004　小出　定義のみ追加する。
  static void precaVoidPopUp(int err_no) {
    //rcPrecaVoid_DialogErr(err_no, 1, NULL);
  }


}