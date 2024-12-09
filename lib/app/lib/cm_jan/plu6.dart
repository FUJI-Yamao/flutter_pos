/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
//import '../../common/cmn_sysfunc.dart';
//import '../../inc/apl/rxmem_define.dart';

class Plu6{
  //   /*
  //    Foramt : void cm_plu6(JAN_inf *Ji);
  //    Input  : JAN_inf *Ji - Address of JAN Information
  //    Output : void
  // */
  ///関連tprxソース: plu6.c - cm_plu6
  static void cmPlu6(JANInf Ji){
    Ji.flag = '0';
    Ji.flagDigit = 0;
    Ji.type = JANInfConsts.JANtypePlu6;
    Ji.format = 0;
    Ji.price = 0;
  }
}