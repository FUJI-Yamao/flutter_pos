/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class NonPlu{
  //   /*----------------------------------------------------------------------*
  //  * NON-PLU
  //  *----------------------------------------------------------------------*/
  // /*
  //  *   Foramt : void cm_non_plu8(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *            char flag    - 1(F) or 2(FF) or 3(FF)
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: non_plu.c - cm_non_plu8
  static void cmNonPlu8(JANInf Ji,int flag){

  }
  //   extern
  //   void cm_non_plu8 (JAN_inf *Ji, char flag)
  //   {
  //   char Code[5];
  //
  //   cm_set_np8_flag(Ji);
  //   if(Ji->FlagDigit != flag) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit =(char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   cm_set_np8_type(Ji);
  //   if(Ji->Type == JANtype_NON_PLU8) {
  //   cm_clr(Code, sizeof(Code));
  //   cm_mov(Code,&Ji->Code[8],sizeof(Code) - 1);
  //   cm_mov(&Ji->Code[8],"00000",5);
  //   Ji->Price = atol(Code);
  //   }
  //   else
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
}