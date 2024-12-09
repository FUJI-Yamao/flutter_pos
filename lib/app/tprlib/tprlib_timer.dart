/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

///  関連tprxソース: TprLibTimer.c
class TprLibTimer {

  ///  関連tprxソース: TprLibTimer.c - TprLibUsleep()
  static void	TprLibUsleep(int usec) {
    Future(() async {
      sleep(Duration(microseconds: usec));
    });
    return;
  }

}
