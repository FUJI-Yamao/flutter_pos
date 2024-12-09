/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/*
 * dsc_plu.dart - Common Functions for JAN Code
 * 関連tprxソース:dsc_plu.c
 */


/*----------------------------------------------------------------------*
 * Include files
 *----------------------------------------------------------------------*/
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import '../../inc/lib/jan_inf.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../sys/regs/rmmain.dart';
import '../apllib/recog.dart';

// #include "tpraid.h"
// #include "rxmem.h"
// #include "cm_ary.h"
// #include "cm_chg.h"
// #include "cm_jan.h"
// #include "cm_sys.h"

/*----------------------------------------------------------------------*
 * DSC-PLU data table
 *----------------------------------------------------------------------*/
/*
 * DSC-PLU 13 Digits Format
 *
 * F   : Flag
 * I   : Item code
 * P   : Price / Weight
 * 0   : Always zero
 * N   : discount flag
 * C   : Check Digit
 *
 *   Format No139:  FF IIIIIIIIII C
 *   Format No140:  FF III0N PPPPP C
 */

/*----------------------------------------------------------------------*
 * Basic function
 *----------------------------------------------------------------------*/

const int NG = 1;
const int OK = 0;

class DscPluRet{
  int result = NG;
  Code128_inf C128 = Code128_inf();
}

class DscPlu {

// /*----------------------------------------------------------------------*
//  * DSC-PLU
//  *----------------------------------------------------------------------*/

  /// 関連tprxソース: ean.h   cm_dsc_plu_1();
  static int cmDscPlu1(Code128_inf C128i) {
    int ret = NG;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ret;
    }
    RxCommonBuf pComBuf = xRet.object;

    for (int i = 0; i < pComBuf.dbInstre.length; i++) {
      if (pComBuf.dbInstre[i].format_typ == 9) {
        switch (pComBuf.dbInstre[i].format_no) {
          case 139:
            C128i.Code1 = pComBuf.dbInstre[i].instre_flg.toString().substring(0, 2);
            ret = OK;
            break;
        }
      }
    }
    return (ret);
  }

  static int cmDscPlu2(Code128_inf C128i) {
    int ret = NG;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return ret;
    }
    RxCommonBuf pComBuf = xRet.object;

    for (int i = 0; i < pComBuf.dbInstre.length; i++) {
      if (pComBuf.dbInstre[i].format_typ == 10) {
        switch (pComBuf.dbInstre[i].format_no) {
          case 140:
            C128i.Code2 = pComBuf.dbInstre[i].instre_flg.toString().substring(0, 2);
            ret = OK;
            break;
        }
      }
    }
    return (ret);
  }

  /// 処理概要：void cmDscPlu(JANInf ji, int flag)
  /// パラメータ：JANInf ji - Address of JAN Information
  ///          int flag    - 1(F) or 2(FF) or 3(FFF)
  /// 戻り値：なし
  /// 関連tprxソース: dsc_plu.c   cm_dsc_plu();
  static Future<void> cmDscPlu(JANInf ji, int flag) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    cmSetDscPluFlag(ji);
    if (ji.flagDigit != flag) {
      ji.type = JANInfConsts.JANtype ;
      ji.format = 0;
      ji.flagDigit = 0;
      ji.flag = "";
      return;
    }
    cmSetDscPluType(ji);
    if ((ji.type != JANInfConsts.JANtypeDscPlu1) &&
        (ji.type != JANInfConsts.JANtypeDscPlu2)) {
      ji.flag = "";
    } else {
      if (xRet.result != RxMem.RXMEM_OK) {
        ji.type = JANInfConsts.JANtype;
        ji.format = 0;
        ji.flagDigit = 0;
        ji.flag = "";
        return;
      }
      RecogRetData recogRetData1 = await Recog().recogGet(
          Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_DISC_BARCODE,
          RecogTypes.RECOG_GETMEM);
      RecogRetData recogRetData2 = await Recog().recogGet(
          Tpraid.TPRAID_SYSTEM,
          RecogLists.RECOG_PROMSYSTEM,
          RecogTypes.RECOG_GETMEM);
      if ((recogRetData1.result == RecogValue.RECOG_NO) &&
          (recogRetData2.result == RecogValue.RECOG_NO)) {
        ji.type = JANInfConsts.JANtypeIllSys;
        ji.format = 0;
        ji.flagDigit = 0;
        ji.flag = "";
      }
    }
    return;
  }

  /// 処理概要：void cmSetDscPluFlag(JANInf ji)
  /// パラメータ：JANInf ji - Address of JAN Information
  /// 戻り値：なし
  /// 関連tprxソース: dsc_plu.c   cm_set_dscplu_flag();
  static void cmSetDscPluFlag(JANInf ji) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ji.format = 0;
    ji.flagDigit = 0;
    ji.flag = "";
    for (int i = 0; i < RxMem.DB_INSTRE_MAX; i++) {
      if (pCom.dbInstre[i].format_typ == 9) {
        switch (pCom.dbInstre[i].format_no) {
          case 139:
            ji.flagDigit = 2;
            ji.flag = ji.code.substring(0, ji.flagDigit);
            if (ji.flag == pCom.dbInstre[i].instre_flg) {
              ji.format = pCom.dbInstre[i].format_no;
            }
            break;
          default:
            break;
        }
      } else if (pCom.dbInstre[i].format_typ == 10) {
        switch(pCom.dbInstre[i].format_no) {
          case 140:
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
      if (ji.format != 0) {
        break;
      }
    }
  }

  /// 処理概要：void cmSetDscPluType(JANInf ji)
  /// パラメータ：JANInf ji - Address of JAN Information
  /// 戻り値：なし
  /// 関連tprxソース: dsc_plu.c   cm_set_dscplu_type();
  static void cmSetDscPluType(JANInf ji) {
    switch (ji.format) {
    /* Discount Plu 13 format number is OK ? */
      case 139:
        ji.type = JANInfConsts.JANtypeDscPlu1;
        break;
      case 140:
        ji.type = JANInfConsts.JANtypeDscPlu2;
        break;
      default:
        ji.type = JANInfConsts.JANtype;
        ji.format = 0;
        break;
    }
  }

}
