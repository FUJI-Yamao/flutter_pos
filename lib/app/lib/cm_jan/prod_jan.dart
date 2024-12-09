/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


/*
 * prod_jan.dart - Common Functions for Producer JAN Code
 */

/*----------------------------------------------------------------------*
 * Include files
 *----------------------------------------------------------------------*/
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../common/cmn_sysfunc.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../../app/inc/lib/jan_inf.dart';

/*----------------------------------------------------------------------*
 *	Clerk bar code mask data table
 *----------------------------------------------------------------------*/




class ProdJan {


  // /*
// 		Set clerk bar code information
// */
  ///  TODO:00007 梶原 中身の実装が必要
  ///関連tprxソース: prod_jan.c - cm_prod
  static void cmProd(JANInf Ji,int flag){

  }
//   void cm_prod(JAN_inf *Ji, char flag) {
//     cmSetProdFlag(Ji);
//     if(Ji->FlagDigit != flag) {
//     Ji->Type = JANtype;
//     Ji->Format = 0;
//     Ji->flagDigit=(char)0;
//     cm_clr(&Ji->flag[0], sizeof(Ji->flag));
//     }
//     cmSetProdType(Ji);
//     if((Ji->Type != JANtype_PRODUCER) &&
//     (Ji->Type != JANtype_PRODUCER_1) &&
//     (Ji->Type != JANtype_PRODUCER_2))
//     {
//     cm_clr(&Ji->flag[0], sizeof(Ji->flag));
//     }
//     else
//     cm_set_prod_price(Ji);
//   }
//

  /// Set clerk bar code information flag
  ///  引数：Ji
  ///  戻値：なし
  ///  関連tprxソース:prod_jan.c - cm_set_prod_flag()
  static void cmSetProdFlag (JANInf Ji) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pComBuf = xRet.object;

    Ji.format = 0;
    Ji.flagDigit = 0;

    for(int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if(pComBuf.dbInstre[i].format_typ == 18) { /* 1st */
      switch(pComBuf.dbInstre[i].format_no) {
        case 157:
        case 158:
        case 159:
        case 160:
        case 161:
        case 344:
        case 345:
        case 346:
        case 347:
          Ji.flagDigit = 2;
          Ji.flag = Ji.code.substring(0, Ji.flagDigit);
          if(!(Ji.flag == pComBuf.dbInstre[i].instre_flg)) {
            Ji.format = pComBuf.dbInstre[i].format_no;
          }
          break;
        case 198:
        case 199:
        case 200:
          Ji.flagDigit = 1;
          Ji.flag = Ji.code.substring(0, Ji.flagDigit);
          if(!(Ji.flag == pComBuf.dbInstre[i].instre_flg)) {
            Ji.format = pComBuf.dbInstre[i].format_no;
          }
          break;
        default:
          break;
        }
      } else if(pComBuf.dbInstre[i].format_typ == 94) {
        /* 生産者バーコード2段目 */
        switch(pComBuf.dbInstre[i].format_no) {
          case 349:
            Ji.flagDigit = 2;
            Ji.flag = Ji.code.substring(0, Ji.flagDigit);
            if(!(Ji.flag == pComBuf.dbInstre[i].instre_flg)) {
              Ji.format = pComBuf.dbInstre[i].format_no;
            }
            break;
          default:
            break;
        }
      }
      if(Ji.format != 0) {
        break;
      }
    }
  }

/*
		Set JAN-information type & format for clerk bar code
*/
  static Future<void> cmSetProdType (JANInf Ji) async {
    switch(Ji.format) {
      /* Discount Plu 13 format number is OK ? */
      case 157:
      case 158:
      case 159:
      case 160:
      case 161:
      case 198:
      case 199:
      case 200:
      case 345:
      case 346:
      case 347:
        Ji.type = JANInfConsts.JANtypeProducer;
        break;
      case 344:
        if (await CmCksys.cmSm55TakayanagiSystem() == 1) {
          Ji.type = JANInfConsts.JANtypeProducer1;
        } else {
          Ji.type = JANInfConsts.JANtypeProducer;
        }
        break;
      case 349:
        Ji.type = JANInfConsts.JANtypeProducer2;
        break;
      default:
        Ji.type = JANInfConsts.JANtype;
        Ji.format = 0;
        break;
    }
  }

// /*
//  *   Foramt : void cm_set_bok_price (JAN_inf *Ji);
//  *   Input  : JAN_inf *Ji - Address of JAN Information
//  *   Output : void
//  */
//   static void cm_set_prod_price (JAN_inf *Ji) {
//     char price[ASC_EAN_13];
//     int len;
//     int siz;
//
//     if( (Ji->Type == JANtype_PRODUCER) ||
//     (Ji->Type == JANtype_PRODUCER_1) )
//     {
//     switch(Ji->Format) { /* Discount Plu 13 format number is OK ? */
//     case 157:
//     len = 7;
//     siz = 1;
//     break;
//     case 158:
//     len = 6;
//     siz = 2;
//     break;
//     case 159:
//     len = 5;
//     siz = 3;
//     break;
//     case 160:
//     len = 4;
//     siz = 4;
//     break;
//     case 161:
//     len = 3;
//     siz = 5;
//     break;
//     case 198:
//     len = 5;
//     siz = 3;
//     break;
//     case 199:
//     len = 4;
//     siz = 4;
//     break;
//     case 200:
//     len = 4;
//     siz = 3;
//     break;
//     case 344:
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[8], 4);
//     Ji->Code2 = atol(price);
//     Ji->Price = 0;
//     if(Ji->Type == JANtype_PRODUCER_1)
//     {
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[2], 6);
//     Ji->Cls_code = atol(price);
//     }
//
//     if (!cm_Prod_Item_Auto_system())
//     {
//     memset(&Ji->Code[8], '0', 5);
//     }
//     return;
//     break;
//     case 345:
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[7], 5);
//     Ji->Code2 = atol(price);
//     Ji->Price = 0;
//     if (!cm_Prod_Item_Auto_system())
//     {
//     memset(&Ji->Code[7], '0', 6);
//     }
//     return;
//     break;
//     case 346:
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[6], 6);
//     Ji->Code2 = atol(price);
//     Ji->Price = 0;
//
//     if (!cm_Prod_Item_Auto_system())
//     {
//     memset(&Ji->Code[6], '0', 7);
//     }
//     return;
//     break;
//     case 347:
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[2], 3);
//     Ji->Code2 = atol(price);
//
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[8], 4);
//     Ji->Price = atol(price);
//
//     memset(&Ji->Code[8], '0', 5);
//     if (!cm_Prod_Item_Auto_system())
//     {
//     memset(&Ji->Code[2], '0', 3);
//     }
//     return;
//     break;
//     default:
//     Ji->Price = 0;
//     Ji->Code2 = 0;
//     return;
//     }
//
//     memset( price, 0, sizeof(price) );
//     memcpy( price, &Ji->Code[len], siz );
//     Ji->Code2 = atol( price); /* cat code */
//
//     memset( price, 0, sizeof(price) );
//     memcpy( price, &Ji->Code[len+siz], 13-(len+siz+1) );
//     Ji->Price = atol( price); /* price */
//
//     if(cm_Prod_Item_Auto_system())
//     memset( &Ji->Code[len+siz], '0', 13-(len+siz) ); /* PPPP(P) + C/D */
//     else
//     memset( &Ji->Code[len], '0', 13-len ); /* C(siz) + PPPP(P) + C/D */
//     }
//     else if (Ji->Type == JANtype_PRODUCER_2)
//     {
//     switch(Ji->Format)
//     {
//     case 349:
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[2], 2);
//     Ji->Cls_code = atol(price);
//
//     memset(price, 0, sizeof(price));
//     memcpy(price, &Ji->Code[6], 6);
//     Ji->Price = atol(price);
//     return;
//
//     default:
//     Ji->Price = 0;
//     Ji->Code2 = 0;
//     return;
//     }
//     }
//     else
//     {
//     Ji->Price = 0;
//     Ji->Code2 = 0;
//     }
//   }


  /// Set clerk bar code information flag
  ///  引数：Ji
  ///  戻値：なし
  ///  関連tprxソース:prod_jan.c - cm_set_prod_flag()

  ///  * 関数名	: cmChkProdbarLen20
  ///  * 機能概要	: 20桁生産者バーコードであるか確認する
  ///  * 呼出方法	: #include "cm_jan.h"
  ///  *		: cmChkProdbarLen20(code);
  ///  * パラメータ	: バーコードストリング
  ///  * 戻り値	: 結果
  ///  関連tprxソース:prod_jan.c - cm_chk_prodbar_len20()
  static int cmChkProdbarLen20 (String code) {
    int ret = 0;
    JANInf ji_buf = JANInf();

    ji_buf.code = code;

    cmSetProdFlag(ji_buf);

    switch (ji_buf.format) {
      case 344:
        if(CmCksys.cmSm55TakayanagiSystem() == 1) {
          return (ret);
        }
        break;
      case 345:
      case 346:
        ret = 1;
        if ((code.substring(13, 14) == '7') && (code.length == 20)) {
          ret = 2;
        }
        break;
      default:
        break;
    }
    return(ret);
  }
}
