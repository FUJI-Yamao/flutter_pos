/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class Mbr{
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: mbr.c - cm_dcm_mbr
  static void cmDcmMbr(JANInf Ji,int size){

  }
  // extern
  // void cm_dcm_mbr(JAN_inf *Ji, short size)
  // {
  //
  // int mcd_typ;
  //
  // if( size == cm_mbrcd_len() ) {
  // mcd_typ = cm_mcd_Check_TS3(&Ji->Code[0]);
  // if( (mcd_typ == TS3_DAIKI_MBR_CRDT) ) {
  // Ji->Type = JANtype_MBR13;
  // Ji->Format = 0;
  // Ji->FlagDigit = (char)0;
  // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  // Ji->Type = JANtype_MBR13;
  // }
  // }
  //
  // if( Ji->Type != JANtype_MBR13 ) {
  // Ji->Type = JANtype;
  // Ji->Format = 0;
  // Ji->FlagDigit = (char)0;
  // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  // }
  // }

  // /*----------------------------------------------------------------------*
  //  * MEMBER
  //  *----------------------------------------------------------------------*/
  // /*
  //  *   Foramt : void cm_non_plu8(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *          : char flag   - flag 1(F) or 2(FF) or 3(FF)
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: mbr.c - cm_mbr8
  static void cmMbr8(JANInf Ji,int flag){

  }
  //   extern
  //   void cm_mbr8 (JAN_inf *Ji, char flag)
  //   {
  //   #if 0 /* 2007/02/08 */
  //   cm_set_mbr8_flag(Ji);
  //   if(Ji->FlagDigit != flag) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit = (char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   cm_set_mbr8_type(Ji);
  //   if(Ji->Type != JANtype_MBR8)
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   #endif
  //   cm_set_mbr8_jan(Ji);
  //   if(Ji->FlagDigit != flag) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit = (char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   if((Ji->Type != JANtype_MBR8)&&(Ji->Type != JANtype_MBR8_2)) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit = (char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   Ji->Price = 0L;
  //   }

  // /*
  //  *   Foramt : void cm_non_plu13(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *          : char flag   - flag 1(F) or 2(FF) or 3(FF)
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: mbr.c - cm_mbr13
  static void cmMbr13(JANInf Ji,int flag){

  }
  //   extern
  //   void cm_mbr13(JAN_inf *Ji, char flag)
  //   {
  //   cm_set_mbr13_flag(Ji);
  //   if(Ji->FlagDigit != flag) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   Ji->FlagDigit = (char)0;
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   }
  //   cm_set_mbr13_type(Ji);
  //   if(Ji->Type != JANtype_MBR13)
  //   cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
  //   Ji->Price = 0L;
  //   }

  // /*
  //  *   Foramt : void cm_set_mbr13_flag(JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: mbr.c - cm_set_mbr13_flag
  static void cmSetMbr13Flag(JANInf Ji){

  }
  //   static void cm_set_mbr13_flag(JAN_inf *Ji)
  //   {
  //   Ji->FlagDigit = (char)2;
  //   cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  //   }

  // /*
  //  *   Foramt : void cm_set_mbr13_type (JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: mbr.c - cm_set_mbr13_type
  static void cmSetMbr13Type(JANInf Ji){

  }
  //   static
  //   void cm_set_mbr13_type (JAN_inf *Ji)
  //   {
  //   RX_COMMON_BUF *pComBuf;
  //   int i;
  //   char buf[cm_mbrcd_len()];
  //
  //   if(rxMemPtr(RXMEM_COMMON,  (void **) &pComBuf) != RXMEM_OK) {
  //   return;
  //   }
  //
  //   if(! cm_mbr_system(pComBuf))
  //   return;
  //
  //   if(Ji->FlagDigit != (char)2)
  //   return;
  //
  //   for(i = 0; i < DB_INSTRE_MAX; i++) {
  //   if(pComBuf->db_instre[i].format_typ == 3) {
  //   if(! strncmp(&Ji->Flag[0], &pComBuf->db_instre[i].instre_flg[0], Ji->FlagDigit)) {
  //   if(pComBuf->db_instre[i].format_no == 135) {
  //   Ji->Type = JANtype_MBR13;
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   if(pComBuf->db_trm.coop_yamaguchi_green_stamp) {
  //   cm_mov(buf,Ji->Code,cm_mbrcd_len());
  //   cm_mov(&buf[2],"0",1);
  //   cm_mov(&buf[12],"0",1);
  //   cm_mk_cdigit_variable(buf,cm_mbrcd_len());
  //   cm_mov(Ji->Code,buf,cm_mbrcd_len());
  //   }
  //   break;
  //   }
  //   }
  //   }
  //   }
  //   if(((char)Ji->Code[0] == 'N') && (pComBuf->db_trm.nw7mbr_barcode_1) && (pComBuf->db_trm.mem_use_typ == 1)){
  //   Ji->Type = JANtype_MBR13;
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   }
  //   else if(((char)Ji->Code[1] == 'N') && (pComBuf->db_trm.nw7mbr_barcode_2)){
  //   Ji->Type = JANtype_MBR13;
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   }
  //   if(cm_chk_ws_mbr(&Ji->Flag[0])) {
  //   Ji->Type = JANtype_MBR13;
  //   Ji->Format = pComBuf->db_instre[i].format_no;
  //   }
  //   if((pComBuf->db_trm.mem_bcd_typ == 1) && (Ji->Type == JANtype_MBR13)) {
  //   Ji->FlagDigit = (char)0;
  //   Ji->Format = 0;
  //   Ji->Type = JANtype_ILLEGAL;
  //   }
  //   }
}