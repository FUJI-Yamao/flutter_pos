/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_log.dart';

class DblJan{
   //  /*
   // *   Foramt : void cm_dbl_jan26(JAN_inf *Ji, char flag);
   // *   Input  : JAN_inf *Ji - Address of JAN Information
   // *            char flag    - 1(F) or 2(FF) or 3(FFF)
   // *   Output : void
   // */
  ///関連tprxソース: dbl_jan.c - cm_dbl_jan26
  static void cmDblJan26(JANInf ji,int flag1,int flag2){
    cmSetDblFlag(ji);
    if ((ji.flagDigit != flag1) &&
        (ji.flagDigit != flag2)) {
      ji.type = JANInfConsts.JANtype;
      ji.format = 0;
      ji.flagDigit = 0;
      ji.flag = "";
      return;
    }
    cmSetDblType(ji);
    if ((ji.type != JANInfConsts.JANtypeJan261) &&
        (ji.type != JANInfConsts.JANtypeJan262)) {
      ji.flag = "";
    } else {
      // TODO:10167 値段はクラウドPOS側での設定のため実装保留
//      cm_set_dbl_price(ji);
    }
    return;
  }

  // /*
  //  *   Foramt : void cm_set_dscplu_flag(JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///関連tprxソース: dbl_jan.c - cm_set_dbl_flag
  static void cmSetDblFlag(JANInf ji){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(0, LogLevelDefine.error,
          "cmSetDblFlag() rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ji.format = 0;
    ji.flagDigit =0;
    ji.flag = "";
    for (int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if (pCom.dbInstre[i].format_typ == 17) {		/* 2nd */
        switch (pCom.dbInstre[i].format_no) {
          case 152:
          case 153:
          case 154:
          case 155:
          case 156:
//          case JANInfConsts.JANtypeCaseClothes2:
          case 343:
            if (pCom.dbInstre[i].format_no == 156) {
              ji.flagDigit = 4;
              ji.flag = ji.code.substring(0, 3);
              if (ji.flag == pCom.dbInstre[i].instre_flg) {
                ji.format = pCom.dbInstre[i].format_no;
              }
            } else {
              ji.flagDigit = 2;
              ji.flag = "";
              ji.flag = ji.code.substring(0, ji.flagDigit);
              if (ji.flag == pCom.dbInstre[i].instre_flg) {
                ji.format = pCom.dbInstre[i].format_no;
              }
            }
            break;
          default:
            break;
        }
      } else if(pCom.dbInstre[i].format_typ == 16) {	/* 1st */
        switch (pCom.dbInstre[i].format_no) {
          case 146:
          case 147:
          case 148:
          case 149:
          case 150:
          case 151:
          case 145:
//          case JANInfConsts.JANtypeCaseClothes1:
          case 342:
            ji.flagDigit = 2;
            ji.flag = ji.code.substring(0, ji.flagDigit);
            if (ji.flag == pCom.dbInstre[i].instre_flg) {
              ji.format = pCom.dbInstre[i].format_no;
            }
            break;
          default:
            break;
        }
      }
      if(ji.format != 0) {
        break;
      }
    }
  }

  // /*
  //  *   Foramt : void cm_set_dscplu_type (JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  ///関連tprxソース: dbl_jan.c - cm_set_dbl_type
  static void cmSetDblType(JANInf ji){
    switch (ji.format) { /* Discount Plu 13 format number is OK ? */
      case 152:
      case 153:
      case 154:
      case 155:
      case 156:
//          case JANInfConsts.JANtypeCaseClothes2:
      case 343:
        ji.type = JANInfConsts.JANtypeJan262;
        break;
      case 146:
      case 147:
      case 148:
      case 149:
      case 150:
      case 151:
      case 145:
//          case JANInfConsts.JANtypeCaseClothes1:
      case 342:
        ji.type = JANInfConsts.JANtypeJan261;
        break;
      default:
        ji.type = JANInfConsts.JANtype;
        ji.format = 0;
        break;
    }
  }

  // /*
  //  *   Foramt : void cm_set_dbl_price (JAN_inf *Ji);
  //  *   Input  : JAN_inf *Ji - Address of JAN Information
  //  *   Output : void
  //  */
  static void cmSetDblPrice(JANInf Ji){

  }
  //   static void cm_set_dbl_price(JAN_inf *Ji)
  //   {
  //   char price[ASC_EAN_13];
  //   int len;
  //
  //   if (Ji->Type == JANtype_JAN26_2)
  //   {
  //   len = 0;
  //   Ji->Price = 0;
  //   switch(Ji->Format) { /* Discount Plu 13 format number is OK ? */
  //   case 152:
  //   len = 4; break;
  //   case 153:
  //   len = 5; break;
  //   case 154:
  //   len = 6; break;
  //   case 155:
  //   len = 7; break;
  //   case 156:
  //   len = 6; break;
  //   case JANtype_CASE_CLOTHES2:
  //   cm_mov( &Ji->Code[5], "00000000", 8 );
  //   cm_mk_cdigit(&Ji->Code);
  //   len = 6; break;
  //   default:
  //   return;
  //   }
  //
  //   memset( price, 0, sizeof(price) );
  //   memcpy( price, &Ji->Code[12-len], len );
  //   Ji->Price = atol( price);		/* price */
  //
  //   if(!(Ji->Format == JANtype_CASE_CLOTHES2)) /* チェックデジット計算した為 */
  //   {
  //   memset( &Ji->Code[12-len], '0', len+1 );
  //   }
  //   }
  //   else
  //   {
  //   Ji->Price = 0;
  //   len = 0;
  //   switch(Ji->Format) { /* Discount Plu 13 format number is OK ? */
  //   case 146:
  //   break;
  //   case 147:
  //   len = 2; break;
  //   case 148:
  //   len = 3; break;
  //   case 149:
  //   len = 4; break;
  //   case 150:
  //   len = 5; break;
  //   case 151:
  //   len = 6; break;
  //   case 145:
  //   // アイテム番号以降をマスクし、C/Dを付加
  //   cm_mov( &Ji->Code[5], "00000000", 8 );
  //   cm_chk_mk_cdigit_variable( Ji->Code , 1, 13 );
  //   break;
  //   case JANtype_CASE_CLOTHES1:
  //   len = 4;
  //   default:
  //   break;
  //   }
  //   if (len)
  //   {
  //   memset( price, 0, sizeof(price) );
  //   memcpy( price, &Ji->Code[2], len );
  //   Ji->Price = atol( price);		/* price */
  //   }
  //   }
  //   }
}