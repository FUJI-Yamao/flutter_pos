/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class CmCktWr {

  static int TPR_TYPE_DESK = 0;
  static int TPR_TYPE_TOWER = 1;
  static int TPR_TYPE_OTHER = 2;


  /// TPRタイプを返す
  /// 1:TOWER 0:DESK
  //  関連tprxソース:cm_cktwr.c - cm_chk_tower()
  static int cm_chk_tower() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return (TPR_TYPE_TOWER);
    }
    RxCommonBuf pCom = xRet.object;

    if (pCom.iniSys.type.tower != 'yes') {
      return TPR_TYPE_DESK;
    }
    return (TPR_TYPE_TOWER);
  }
}