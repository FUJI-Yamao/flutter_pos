/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class CustomerCardJan{
/*----------------------------------------------------------------------*
 * FUNCTION KEY BAR CODE
 *----------------------------------------------------------------------*/
  ///関連tprxソース: customercard_jan.c - cm_CustomerCard_jan
  static void cmCustomerCardJan(JANInf Ji,int flag){
    cmSetCustomercardFlag(Ji);
    if(Ji.flagDigit != flag){
      Ji.type = JANInfConsts.JANtype;
      Ji.format = 0;
      Ji.flagDigit = 0;
      Ji.flag = '0';     // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
    }

    cmSetCustomercardType(Ji);
    if(Ji.type != JANInfConsts.JANtypeCustomercard){
      Ji.flag = '0';     // cm_clr(&Ji->Flag[0], sizeof(Ji->Flag));
    }
    Ji.price = 0;
  }

  ///関連tprxソース: customercard_jan.c - cm_set_customercard_flag
  static void cmSetCustomercardFlag(JANInf Ji){
    Ji.flagDigit = 2;
    Ji.flag = Ji.code.substring(0,Ji.flagDigit);    // cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  }

  ///関連tprxソース: customercard_jan.c - cm_set_customercard_type
  static void cmSetCustomercardType(JANInf Ji){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pComBuf = xRet.object;

    Ji.type = JANInfConsts.JANtype;
    Ji.format = 0;

    if(Ji.flagDigit != 2){
      return;
    }
    for(int i = 0; i< RxMem.DB_INSTRE_MAX;i++){
      if((pComBuf.dbInstre[0]).format_typ == 59){
        if(Ji.flag != ((pComBuf.dbInstre[i]).instre_flg).substring(0,Ji.flagDigit)){
          if((pComBuf.dbInstre[i]).format_no == 251){
            Ji.type = JANInfConsts.JANtypeCustomercard;
            Ji.format = (pComBuf.dbInstre[i]).format_no;
            break;
          }
        }
      }
    }
  }
}