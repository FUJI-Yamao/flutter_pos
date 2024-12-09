/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/regs/checker/rc_elog.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_log.dart';

class RckyBuyHist {
  /// 数か月前のランクを求める
  /// 引数: 何ヶ月前か（12以下とする）
  /// 戻り値:ランク
  ///  関連tprxソース: rcky_buy_hist.c - rcky_buy_hist_calc_rank_hist
  static Future<int> calcRankHist(int ago) async {
    int res = 0;
    String nowBuf = "";
    (res, nowBuf) = await DateUtil.dateTimeChange(null,
      DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE,
        DateTimeFormatKind.FT_YYYYMMDD, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
    int yyyy = int.parse(nowBuf.substring(0, 4));
    int mm = int.parse(nowBuf.substring(4, 6));
    int dd = int.parse(nowBuf.substring(6, 8));

    // 1ヶ月前の日付を確認する
    String buf = setDate(yyyy, mm, 1);
    int year = int.parse(buf.substring(0, 4));
    int month = int.parse(buf.substring(5, 7));
    String buf2 = "";
    int rank = 0;
    (rank, buf2) = setDateRank(month);

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          "RckyBuyHist.calcRankHist(): rxMemRead error");
      return 0;
    }
    RxCommonBuf cBuf = xRet.object;

    if (dd <= cBuf.dbTrm.ds2PrerankReferTerm) {
      // 前月と同じ情報を表示するように日付をセット
      buf = setDate(yyyy, mm, ago+1);
    } else {
      // 今月用の情報を表示するように日付をセット
      setDate(yyyy, mm, ago);
    }
    month = int.parse(buf.substring(5, 7));
    (rank, buf2) = setDateRank(month);

    if (buf != buf2) { // 日付が正しくない
      rank = 0;	// ランク外
    }
    return rank;
  }

  /// 数ヶ月前が何年何月かを求める
  /// 引数:[yyyy] 元の年
  /// 引数:[mm] 元の月
  /// 引数:[ago] 何ヶ月前か（12以下とする）
  /// 戻り値:年月
  ///  関連tprxソース: rcky_buy_hist.c - rcky_buy_hist_set_date
  static String setDate(int yyyy, int mm, int ago) {
    int month = mm - ago;
    int year = yyyy;

    if (month <= 0) {
      year -= 1;
      month += 12;
    }

    return "${yyyy.toString().padLeft(4, "0")}-${mm.toString().padLeft(2, "0")}";
  }

  /// 参照月の日付をセットしてランクを返す
  /// 引数: 参照する月
  /// 戻り値:[int] ランク
  /// 戻り値:[String] セット日付
  ///  関連tprxソース: rcky_buy_hist.c - rcky_buy_hist_set_date_rank
  static (int, String) setDateRank(int month) {
    int rank = 0;
    String date = "";

    RegsMem mem = SystemFunc.readRegsMem();
    switch (month) {
      case 1:
        date = mem.custTtlTbl.month_visit_date_1 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_1;
        break;
      case 2:
        date = mem.custTtlTbl.month_visit_date_2 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_2;
        break;
      case 3:
        date = mem.custTtlTbl.month_visit_date_3 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_3;
        break;
      case 4:
        date = mem.custTtlTbl.month_visit_date_4 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_4;
        break;
      case 5:
        date = mem.custTtlTbl.month_visit_date_5 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_5;
        break;
      case 6:
        date = mem.custTtlTbl.month_visit_date_6 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_6;
        break;
      case 7:
        date = mem.custTtlTbl.month_visit_date_7 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_7;
        break;
      case 8:
        date = mem.custTtlTbl.month_visit_date_8 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_8;
        break;
      case 9:
        date = mem.custTtlTbl.month_visit_date_9 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_9;
        break;
      case 10:
        date = mem.custTtlTbl.month_visit_date_10 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_10;
        break;
      case 11:
        date = mem.custTtlTbl.month_visit_date_11 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_11;
        break;
      case 12:
        date = mem.custTtlTbl.month_visit_date_12 ?? "00000000";
        rank = mem.custTtlTbl.month_amt_12;
        break;
     default	:
        break;
    }
    return (rank, date);
  }
}