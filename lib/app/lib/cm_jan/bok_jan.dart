/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class BokJan{
  //   /*
  //  *   Foramt : void cm_bok_jan26(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *            char flag    - 1(F) or 2(FF) or 3(FFF)
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: bok_jan.c - cm_bok_jan26
  static void cmBokJan26(JANInf Ji,int flag){

  }
  //   extern
  //   void cm_bok_jan26(JAN_inf *Ji, char flag)
  //   {
  // //   RX_COMMON_BUF *pComBuf;
  //
  //   cm_set_bok_flag(Ji);
  //   if(Ji->FlagDigit != flag) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit =(char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   return;
  //   }
  //   cm_set_bok_type(Ji);
  //   if((Ji->Type != JANtype_BOOK26_1) &&
  //   (Ji->Type != JANtype_BOOK26_2) )
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   else {
  //   cm_set_bok_price(Ji);
  //   }
  //
  //   cm_set_bok_specific(Ji);
  //
  //   return;
  //   }
}