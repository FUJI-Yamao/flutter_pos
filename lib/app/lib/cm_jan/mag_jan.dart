/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/ean.dart';
import '../../inc/lib/jan_inf.dart';
import '../cm_sys/cm_cksys.dart';

///関連tprxソース: mag_jan.c
class MagJan{
  /// 処理概要：Set magazine JAN 18 information
  /// パラメータ：JANInf ji - Address of JAN Information
  ///           int flag  - flag 1(F) or 2(FF) or 3(FFF)
  /// 関連tprxソース: mag_jan.c - cm_mag_jan18
  static Future<void> cmMagJan18(JANInf ji, int flag) async {
    cmSetJan18Flag(ji);
    if (ji.flagDigit != flag) {
      ji.type = JANInfConsts.JANtype;
      ji.format = 0;
      ji.flagDigit = 0;
    }
    cmSetMag18Type(ji);
    if (ji.type == JANInfConsts.JANtypeMagazine18) {
      // TODO:10167 値段はクラウドPOS側での設定のため実装保留
//      cm_set_mag18_price(Ji);
      await cmSetMagSpecific(ji);
    } else {
      ji.flag = "0";
    }
  }

  /// 処理概要：cm_set_dscplu_flag
  /// パラメータ：JANInf ji - Address of JAN Information
  /// 戻り値：なし
  /// 関連tprxソース: mag_jan.c - cm_set_jan18_flag
  static void cmSetJan18Flag(JANInf ji) {
    ji.flagDigit = 3;
    ji.flag = ji.code.substring(0, ji.flagDigit);
  }

  /// 処理概要：cm_set_mag18_type
  /// パラメータ：JANInf ji - Address of JAN Information
  /// 戻り値：なし
  /// 関連tprxソース: mag_jan.c - cm_set_mag18_type
  static void cmSetMag18Type(JANInf ji) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ji.type = JANInfConsts.JANtype;
    ji.format = 0;
    if (ji.flagDigit != 3) {
      return;
    }
    String kind = ji.code[4];

    for (int i = 0; i < RxMem.DB_INSTRE_MAX ; i++) {
      if (pCom.dbInstre[i].format_typ == 20) {
        String flag = ji.flag.substring(0, ji.flagDigit);
        String instreFlg = pCom.dbInstre[i].instre_flg.substring(0, ji.flagDigit);
        if (flag == instreFlg) {
          ji.clsCode = pCom.dbInstre[i].cls_code;
          if ((pCom.dbTrm.bookSumPluTyp == 1) ||
              (pCom.dbTrm.spcialItemCombine != 0)) {
            ji.format = 163;
            ji.type = JANInfConsts.JANtypeMagazine18;
            return;
          }
          switch (pCom.dbInstre[i].format_no) {
            case 163:
            case 164:
              if (kind == "0") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
              }
              break;
            case 165:
            case 166:
              if (kind == "1") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
              }
              break;
            case 167:
            case 168:
              if (kind == "2") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
                if (pCom.dbTrm.specialconvWeekbook != 0) {
                  if ((ji.code[8] == "1") || (ji.code[8] == "2") || (ji.code[8] == "3") ||
                      (ji.code[8] == "4") || (ji.code[8] == "5") || (ji.code[8] == "9")) {
                    String bef = ji.code.substring(0, 8);
                    String aft = ji.code.substring(9);
                    ji.code = "${bef}0$aft";
                  }
                }
              }
              break;
            case 169:
            case 170:
              if (kind == "3") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
                if (pCom.dbTrm.specialconvWeekbook != 0) {
                  if ((ji.code[8] == "1") || (ji.code[8] == "2") || (ji.code[8] == "3") ||
                      (ji.code[8] == "4") || (ji.code[8] == "5") || (ji.code[8] == "9")) {
                    String bef = ji.code.substring(0, 8);
                    String aft = ji.code.substring(9);
                    ji.code = "${bef}0$aft";
                  }
                }
              }
              break;
            case 171:
            case 172:
              if (kind == "4") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
                if (pCom.dbTrm.specialconvWeekbook != 0) {
                  if ((ji.code[8] == "1") || (ji.code[8] == "2") || (ji.code[8] == "3") ||
                      (ji.code[8] == "4") || (ji.code[8] == "5") || (ji.code[8] == "9")) {
                    String bef = ji.code.substring(0, 8);
                    String aft = ji.code.substring(9);
                    ji.code = "${bef}0$aft";
                  }
                }
              }
              break;
            case 173:
            case 174:
              if (kind == "5") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
                if (pCom.dbTrm.specialconvWeekbook != 0) {
                  if ((ji.code[8] == "1") || (ji.code[8] == "2") || (ji.code[8] == "3") ||
                      (ji.code[8] == "4") || (ji.code[8] == "5") || (ji.code[8] == "9")) {
                    String bef = ji.code.substring(0, 8);
                    String aft = ji.code.substring(9);
                    ji.code = "${bef}0$aft";
                  }
                }
              }
              break;
            case 175:
            case 176:
              if (kind == "6") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
              }
              break;
            case 177:
            case 178:
              if (kind == "7") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
              }
              break;
            case 179:
            case 180:
              if (kind == "8") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
                if (pCom.dbTrm.specialconvWeekbook != 0) {
                  if (((ji.code[5] == "2") || (ji.code[5] == "3") || (ji.code[5] == "4") || (ji.code[5] == "5") || (ji.code[5] == "6")) &&
                      ((ji.code[8] == "1") || (ji.code[8] == "2") || (ji.code[8] == "3") || (ji.code[8] == "4") || (ji.code[8] == "5") || (ji.code[8] == "9"))) {
                    String bef = ji.code.substring(0, 8);
                    String aft = ji.code.substring(9);
                    ji.code = "${bef}0$aft";
                  }
                }
              }
              break;
            case 181:
            case 182:
              if (kind == "9") {
                ji.format = pCom.dbInstre[i].format_no;
                ji.type = JANInfConsts.JANtypeMagazine18;
              }
              break;
          }
          if (ji.type == JANInfConsts.JANtypeMagazine18) {
            break;
          }
        }
      }
    }
  }

  /// 処理概要：cm_set_mag_specific
  /// パラメータ：JANInf ji - Address of JAN Information
  /// 戻り値：なし
  /// 関連tprxソース: mag_jan.c - cm_set_mag_specific
  static Future<void> cmSetMagSpecific(JANInf ji) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    if (await CmCksys.cmMagazineGenreSystem() != 0) {
      ji.code = ji.code.substring(0, ji.flagDigit + 2).padRight(Ean.ASC_EAN_13, "0");
    } else if((await CmCksys.cmMagazineCollectSystem() != 0) ||
              (pCom.dbTrm.spcialItemCombine != 0)) {
      ji.code = ji.code.substring(0, ji.flagDigit).padRight(Ean.ASC_EAN_13, "0");
    }
  }
}