/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../tprlib/tprlib_timer.dart';

///  関連tprxソース: tprmacro.h
class TprMacro {

  ///  関連tprxソース: tprmacro.h - #define	usleep(a)		TprLibUsleep(a)
  static void usleep(int a) {
    TprLibTimer.TprLibUsleep(a);
  }

}