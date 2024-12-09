/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class ItfJan{
  // /*
  //  *  Set Catalina bar code information for JAN-information
  // */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: itf_jan.c - cm_itf
  static void cmItf(JANInf Ji,int flag){

  }
  //   extern
  //   void cm_itf (JAN_inf *Ji, char flag)
  //   {
  //   cm_set_itf_flag(Ji);
  //
  //   if(Ji->FlagDigit != flag)
  //   {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit=(char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   cm_set_itf_type(Ji);
  //   if(Ji->Type == JANtype_ITF14)
  //   {
  //   cm_set_itf14_Code(Ji);
  //   }
  //   else if(Ji->Type == JANtype_ITF16)
  //   {
  //   cm_set_itf16_Code(Ji);
  //   }
  //   else
  //   {
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   }

  // /*
  //  *  Set flag for JAN-information
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: itf_jan.c - cm_set_itf_flag
  static void cmSetItfFlag(JANInf Ji){

  }
  //   static
  //   void cm_set_itf_flag (JAN_inf *Ji)
  //   {
  //   RX_COMMON_BUF *pComBuf;
  //   int i;
  //
  //   if(rxMemPtr(RXMEM_COMMON,  (void **) &pComBuf) != RXMEM_OK)
  //   {
  //   return;
  //   }
  //
  //   Ji->Format = 0;
  //   Ji->FlagDigit =(char)0;
  //   memset(&Ji->Flag[0], 0x0, sizeof(Ji->Flag));
  //   for(i = 0; i < DB_INSTRE_MAX; i++)
  //   {
  //   if(pComBuf->db_instre[i].format_typ == 23)
  //   {
  //   switch(pComBuf->db_instre[i].format_no)
  //   {
  //   case 222:
  //   Ji->FlagDigit = (char)1;
  //   break;
  //   case 223:
  //   Ji->FlagDigit = (char)3;
  //   break;
  //   default:
  //   break;
  //   }
  //   }
  //   if(Ji->FlagDigit != 0)
  //   {
  //   cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  //   if(! strncmp(&Ji->Flag[0], &pComBuf->db_instre[i].instre_flg[0], Ji->FlagDigit))
  //   {
  //   if(pComBuf->db_instre[i].format_no == 223)  /* ITF16 */
  //   {
  //   if(strlen(Ji->Itf_Code) == 3)
  //   {
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   break;
  //   }
  //   }
  //   else if(pComBuf->db_instre[i].format_no == 222)  /* ITF14 */
  //   {
  //   if(strlen(Ji->Itf_Code) == 1)
  //   {
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   break;
  //   }
  //   }
  //   Ji->FlagDigit = 0;
  //   }
  //   }
  //   }
  //   }
}