/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import '../../common/date_util.dart';
import '../../inc/lib/cm_sys.dart';

///　関連tprxソース: cm_sumgt.c
class CmSumgt {

  /// 関連tprxソース: cm_sumgt.c - cm_sumdayget
  static int cmSumdayGet(ChkDate date) {
    int pyear, pmonth;
    int year = 1970, month = 01, day = 01;
    int sumday = 0;
    List<int> nrDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, -1];

    if (date.year < year || date.month < month || date.day < day) {
      return 0;
    }

    // 年を日に
    pyear = date.year;
    for (int iLoop = year; iLoop < pyear; iLoop++) {
      // For Year
      for (int jLoop = 1; nrDays[jLoop] != -1; jLoop++) {
        if (jLoop == 2 && CmSys.chkDateLeap(iLoop)) {
          sumday += 29;
        } else {
          sumday += nrDays[jLoop];
        }
      }
    }

    // 月を日に
    pmonth = date.month;
    for (int iLoop = month; iLoop < pmonth; iLoop++) {
      if (iLoop == 2 && CmSys.chkDateLeap(pyear)) {
        sumday += 29;
      } else {
        sumday += nrDays[iLoop];
      }
    }

    // 日を合算
    pmonth = date.day;
    sumday += (pmonth - day) + 1;

    return sumday;
  }
}