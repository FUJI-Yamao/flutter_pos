/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class Pcd{
  // /*----------------------------------------------------------------------*
  //  * Caluclation price / weight check digit
  //  *----------------------------------------------------------------------*/
  // /*
  //  *   Foramt : bool cm_chk_pcd(JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - address of JAN information
  //  *   Output : bool result - result of checking price-C/D is OK
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: pcd.c - cm_chk_pcd
  static bool cmChkPcd(JANInf Ji){
    return true;
  }
  //   extern
  //   bool cm_chk_pcd (JAN_inf *Ji)
  //   {
  //   char pd;     /* price check digit */
  //   bool result; /* result */
  //
  //   switch (Ji->Type) {
  //   case JANtype_NON_PLU13:
  //   case JANtype_WEIGHT_PLU13:
  //   break;
  //   default:
  //   return(TRUE);
  //   }
  //
  //   switch (Ji->Format) {
  //   case 1:
  //   case 2:
  //   case 15:
  //   case 21:
  //   case 133:
  //   pd = (Ji->Code[7] - 0x30);
  //   result = (pd == cm_pcd4_asc(Ji->Code));
  //   break;
  //   case 3:
  //   case 23:
  //   pd = (Ji->Code[7] - 0x30);
  //   result = (pd == (char)0);
  //   break;
  //   case 13:
  //   case 16:
  //   case 33:
  //   pd = (Ji->Code[6] - 0x30);
  //   result = (pd == cm_pcd5_asc(Ji->Code));
  //   break;
  //   case 4:
  //   case 5:
  //   case 6:
  //   case 7:
  //   case 9:
  //   case 14:
  //   case 24:
  //   case 25:
  //   case 134:
  //   default:
  //   result = TRUE;
  //   break;
  //   }
  //   return(result);
  //   }
}