/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class PbchgJan{
  //   /*----------------------------------------------------------------------*
  //  * DSC-PLU
  //  *----------------------------------------------------------------------*/
  // /*
  //  *   Foramt : void cm_reserv(JAN_inf *Ji, char flag);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///関連tprxソース: pbchg_jan.c - cm_pbchg
  static void cmPbchg(JANInf Ji){
    cmSetPbchgType(Ji);
    return;
  }

  // /*
  //  *   Foramt : void cm_set_dscplu_type (JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: pbchg_jan.c - cm_set_pbchg_type
  static int cmSetPbchgType(JANInf Ji){
    return 0;
  }
  //   static short cm_set_pbchg_type(JAN_inf *Ji)
  //   {
  //
  //   short cd_st = 0;
  //   short jan_len;
  //
  //   jan_len = strlen(Ji->Code);
  //   if( (Ji->Code[0] == 'K') && (jan_len == (PBCHG_JAN_LEN + 1)) ) {
  //   Ji->Type = JANtype_PBCHG;
  //   if(!cm_chk_mk_cdigit_variable(&Ji->Code[1],1, PBCHG_JAN_LEN)) {
  //   /* automaticaly make check-digit error ? */
  //   Ji->Type = JANtype_ILL_CD;  /* check-digit error */
  //   }
  //   }
  //   if( Ji->Type != JANtype_PBCHG ) {
  //   Ji->Type = JANtype;
  //   Ji->Format = 0;
  //   }
  //
  //   return(cd_st);
  //
  //   }
}