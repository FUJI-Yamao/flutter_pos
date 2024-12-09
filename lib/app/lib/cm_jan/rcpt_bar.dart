/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class RcptBar{
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: rcpt_bar.c - cm_rcpt_bar
  static void cmRcptBar(JANInf Ji,int flag){
    cmSetRcptBar(Ji);///  TODO:00007 梶原 中身の実装が必要
  }
  // extern
  // void cm_rcpt_bar(JAN_inf *Ji, char flag)
  // {
  // cm_set_rcpt_bar(Ji);
  // if((Ji->FlagDigit != flag)
  // || (Ji->Type != JANtype_RCPT_BAR_26))
  // {
  // Ji->Type = JANtype;
  // Ji->Format = 0;
  // Ji->FlagDigit = (char)0;
  // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  // }
  // }

  // /*----------------------------------------------------------------------*
  //  * RECEIPT BARCODE
  //  *----------------------------------------------------------------------*/
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: rcpt_bar.c - cm_set_rcpt_bar
  static void cmSetRcptBar(JANInf Ji){

  }
  //   static void cm_set_rcpt_bar(JAN_inf *Ji)
  //   {
  //   RX_COMMON_BUF	*pComBuf;
  //   int		i;
  //
  //   if(rxMemPtr(RXMEM_COMMON, (void **)&pComBuf) != RXMEM_OK)
  //   return;
  //
  //   Ji->Format = 0;
  //   Ji->FlagDigit = (char)0;
  //   memset(&Ji->Flag[0], 0x0, sizeof(Ji->Flag));
  //
  //   for(i = 0; i < DB_INSTRE_MAX; i++) {
  //   if((pComBuf->db_instre[i].format_typ == 87) && (pComBuf->db_instre[i].format_no == 259)) {
  //   Ji->FlagDigit = (char)2;
  //   cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  //   if(! strncmp(&Ji->Flag[0], &pComBuf->db_instre[i].instre_flg[0], Ji->FlagDigit)) {
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   Ji->Type   = JANtype_RCPT_BAR_26;
  //   }
  //   else {
  //   Ji->FlagDigit = (char)0;
  //   memset(&Ji->Flag[0], 0x0, sizeof(Ji->Flag));
  //   }
  //   }
  //   if(Ji->Format != 0)
  //   break;
  //   }
  //   }
}