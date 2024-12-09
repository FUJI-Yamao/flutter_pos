/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/inc/lib/apllib.dart';
import 'package:sprintf/sprintf.dart';
import 'package:flutter_pos/app/inc/lib/cm_sys.dart';

import '../../inc/apl/image.dart';
import '../apllib/apllib_img_read.dart';

/// 関連tprxソース: cm_mkdat.c
class CmMkDat {

  /// 関連tprxソース: lib_com.h
  static const DATE_SIZE = 30;

  /// 関連tprxソース: cm_mkdat.h
  static const SUN = "SUN";
  static const MON = "MON";
  static const TUE = "TUE";
  static const WED = "WED";
  static const THU = "THU";
  static const FRI = "FRI";
  static const SAT = "SAT";
  static const ETC = "   ";

  static const DATE_FORM1 = "%04d/%2d/%2d %3s";
  static const DATE_FORM2 = "%04d/%2d/%2d";
  static const DATE_FORM3 = "%04d/%2d/%2d %3s";
  static const DATE_FORM4 = "%04d/%2d/%2d";
  static const DATE_FORM5 = "%04d/%2d/%2d %3s";
  static const DATE_FORM6 = "%04d/%2d/%2d %3s";
  static const DATE_FORM7 = "%4d/%2d/%2d";
  static const DATE_FORM8	= "%04d年%2d月%2d日(%2s)  ";
  static const DATE_FORM9	= "%4s年%4s月%4s日";	// 空の年月日
  static const DATE_FORM10 = "%04d年%2d月%2d日(%2s%s)";
  static const DATE_WAREKI = "%s%2d年%2d月%2d日(%2s)";  	/* @@@ */
  static const DATE_FIRST_Y = "%s元年%2d月%2d日(%2s)";		/* @@@ */

  /// 関連tprxソース: cm_mkdat.c cm_mkdate
  static (int, String)   cmMkDate(int type, DateTime ptDate) {
    List<String> weekt = [SUN, MON, TUE, WED, THU, FRI, SAT, ETC];
    List<String> alphaWeek = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT", "   "];
    String wk = '';
    int date1 = 0;
    int date2 = 0;
    int date3 = 0;
    int week = 0;
    int firstYear = 0;
    int wareki = 0;
    EucAdj adj = EucAdj();
    String nengou = '';

    int inf = DATE_SIZE;

    date1 = ptDate.year;
    date2 = ptDate.month;
    date3 = ptDate.day;

    if (ptDate.weekday < 7) {
      week = ptDate.weekday;
    }
    else {
      week = 7;
    }

    switch (type) {
      case CmSys.DATE_TYPE1:
        wk = sprintf(DATE_FORM1, [date1, date2, date3, alphaWeek[week]]);
        break;
      case CmSys.DATE_TYPE2:
        wk = sprintf(DATE_FORM2, [date1, date2, date3]);
        break;
      case CmSys.DATE_TYPE3:
        wk = sprintf(DATE_FORM3, [date1, date2, date3, weekt[week]]);
        break;
      case CmSys.DATE_TYPE4:
        wk = sprintf(DATE_FORM4, [date1, date2, date3]);
        break;
      case CmSys.DATE_TYPE5:
        wk = sprintf(DATE_FORM5, [date1, date2, date3, weekt[week]]);
        break;
      case CmSys.DATE_TYPE6:
        wk = sprintf(DATE_FORM6, [date1, date2, date3, weekt[week]]);
        break;
      case CmSys.DATE_TYPE7:
        wk = sprintf(DATE_FORM7, [ptDate.year, date2, date3]);
        break;
      case CmSys.DATE_TYPE8:
        adj = AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_FIRST_YEAR);
        ///TODO:00014 日向 aplLibImgRead()実装後に要修正
        //firstYear = atoi(buf);
        adj = AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_WAREKI);
        wareki = date1 - firstYear + 1;
        if (wareki == 1) {
          wk = sprintf(DATE_FIRST_Y, [nengou, date2, date3, weekt[week]]);
        }
        else if (wareki < 1) {
          wk = sprintf(DATE_FORM8, [date1, date2, date3, weekt[week]]);
        }
        else {
          adj = AplLibImgRead.aplLibImgRead(ImageDefinitions.IMG_PRN_WEEK);
          wk = sprintf(DATE_WAREKI, [nengou, wareki, date2, date3, weekt[week]]);
        }
        break;
      case CmSys.DATE_TYPE9:
        wk = sprintf(DATE_FORM9, ["", "", ""]);
        break;
      case CmSys.DATE_TYPE10:
        wk = sprintf(DATE_FORM3, [date1, date2, date3, weekt[week]]);
        break;
      default:
          inf = 0;
    }
    return (inf, wk);
  }
}
