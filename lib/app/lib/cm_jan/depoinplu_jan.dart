/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/lib/jan_inf.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';

class DepoinpluJan{
   // /*----------------------------------------------------------------------*
   // * FUNCTION KEY BAR CODE
   // *----------------------------------------------------------------------*/
  ///関連tprxソース: depoinplu_jan.c - cm_DepoInPlu_jan
  static void cmDepoInPluJan(JANInf Ji,int flag){
    cmSetDepoinpluFlag(Ji);
    if(Ji.flagDigit != flag){
      Ji.type = JANInfConsts.JANtype;
      Ji.format = 0;
      Ji.flagDigit = 0;
      Ji.flag = '0';
    }

    cmSetDepoinpluType(Ji);
    if(Ji.type != JANInfConsts.JANtypeDepoinplu){
      Ji.flag = '0';
    }
    Ji.price = 0;
  }

  ///関連tprxソース: depoinplu_jan.c - cm_set_depoinplu_flag
  static void cmSetDepoinpluFlag(JANInf Ji){
    Ji.flagDigit = 2;
    Ji.flag = Ji.code.substring(0,Ji.flagDigit);  // cm_mov(&Ji->Flag[0], &Ji->Code[0], Ji->FlagDigit);
  }

  ///関連tprxソース: depoinplu_jan.c - cm_set_depoinplu_type
  static void cmSetDepoinpluType(JANInf Ji){
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pComBuf = xRet.object;

    Ji.type = JANInfConsts.JANtype;
    Ji.format = 0;
    // if(rxMemPtr(RXMEM_COMMON,  (void **) &pComBuf) != RXMEM_OK) return;【dart置き換え時コメント】共有メモリのポインタセットの為、何もしない

    if(Ji.flagDigit != 2){
      return;
    }

    for(int i = 0; i < RxMem.DB_INSTRE_MAX; i++){
      if(pComBuf.dbInstre[i].format_typ == JANInfConsts.JANtypeDepoinplu){
        if(Ji.flag != ((pComBuf.dbInstre[i]).instre_flg).substring(0,Ji.flagDigit)){
          if(pComBuf.dbInstre[i].format_no == JANInfConsts.JANtypeDepoinplu){
            Ji.type = JANInfConsts.JANtypeDepoinplu;
            Ji.format = pComBuf.dbInstre[i].format_no;
            break;
          }
        }
      }
    }
  }
}