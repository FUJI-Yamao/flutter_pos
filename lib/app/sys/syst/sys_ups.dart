/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// UPSデバイス
//  関連tprxソース: sysups
// TODO:10080 デバドラ_UPS

import '../../inc/sys/tpr_lib.dart';

/// 関連tprxソース:sysups.c
class SysUps {
  static TprTct sysUpsDrvTib = TprTct(); /* UPS driver task table */

  static int sysUpsInit(String path) {
    // TODO:10080 デバドラ_UPS
    return 0;
  }
}
