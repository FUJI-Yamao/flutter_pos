/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class Gs1{
  //   /*----------------------------------------------------------------------*
  //  * DSC-PLU
  //  *----------------------------------------------------------------------*/
  // /*
  //  *   Foramt : void cm_gs1(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///関連tprxソース: gs1.c - cm_gs1
  static void cmGs1(JANInf Ji){
    cmSetGs1Type(Ji);///  TODO:00007 梶原 中身の実装が必要
    return ;
  }

  // /*
  //  *   Foramt : void cm_set_dscplu_type (JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: gs1.c - cm_set_gs1_type
  static int cmSetGs1Type(JANInf Ji){
    return 0;
  }
  //   static short cm_set_gs1_type(JAN_inf *Ji)
  //   {
  //
  //   short cd_st = 0;
  //
  //   if( Ji->Code[0] == 'R' ) {
  //   if( (Ji->Code[1] == 'X') ||
  //   (Ji->Code[1] == '4')   )
  //   cd_st = 2;
  //   else
  //   cd_st = 1;
  //   if( strncmp( &Ji->Code[cd_st], "01", 2 ) == 0 )
  //   Ji->Type = JANtype_GS1;
  //   else if( strncmp( &Ji->Code[cd_st+1], "01", 2 ) == 0 ) {
  //   Ji->Type = JANtype_GS1;
  //   cd_st++;
  //   }
  //   }
  //   if( Ji->Type != JANtype_GS1 ) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   }
  //   else {
  //   cd_st = cd_st + 3;
  //   }
  //
  //   return(cd_st);
  //
  //   }
}