/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

// REGS Common Function for Schedule
// rcsch.c

import 'package:intl/intl.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/lib/cm_sys.dart';

/// 関連tprxソース:rcsch.c
class RcSch {
  static const RCSCH_ENDOFMONTH = 99;    // 日付指定で月末とみなす値

  /// 最優先スケジュールのサーチ用where句の作成
  /// [cdName］	スケジュールコードのフィールド名称
  // 	[tblName]	NULL可. セットされていれば, 各フィールドにtableの別名をセットする. ドット(.)はセットしない
  // 	[readData]	NULL可. セットされていれば該当日付を, していなければシステム日付となる
  // [param]作成するSQLの要素のタイプ. テーブルによって使い分ける. NULLの場合はデフォルトSQL作成
  /// 関連tprxソース: rcsch.h - rcSch_PrioritySqlCreate
  static String rcSchPrioritySqlCreate(String cdName, String? tblName,
      DateTime? readDate, SchPriorityParam? param) {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return "";
    }
    RxCommonBuf pCom = xRet.object;
    String tableSql = "";
    String limitSql = "";
    String elementSql = "";
    String orderSql = "";
    String weekField = "";
    if (tblName != null) {
      tableSql = "$tblName.";
    }
    if (param == null) {
      limitSql = "LIMIT 1";
      elementSql =
          " AND ${tableSql}comp_cd = '${pCom.dbRegCtrl.compCd}'  AND ${tableSql}stre_cd = '${pCom.dbRegCtrl.streCd}'";

      orderSql =
          " ORDER BY ${tableSql}start_datetime DESC, ${tableSql}end_datetime, $tableSql$cdName ";
    } else {
      if (param.limit > 0) {
        limitSql = "LIMIT ${param.limit}";
      }

      if (param.keyType == SchSqlKeyType.SCHSQL_KEY_NORMAL) {
        elementSql =
            " AND ${tableSql}comp_cd = '${pCom.dbRegCtrl.compCd}'  AND ${tableSql}stre_cd = '${pCom.dbRegCtrl.streCd}'";
      } else if (param.keyType == SchSqlKeyType.SCHSQL_KEY_COMP_ONLY) {
        elementSql = " AND ${tableSql}comp_cd = '${pCom.dbRegCtrl.compCd}'  ";
      }
      if (param.orderType == SchSqlOrderType.SCHSQL_ORDER_NORMAL) {
        elementSql =
            " ORDER BY ${tableSql}start_datetime DESC, ${tableSql}end_datetime, $tableSql$cdName ";
      }
    }

    // 該当日時の曜日情報を取得.
    // 指定がないなら現在時刻.
    DateTime date = readDate ?? DateTime.now();
    switch (date.weekday) {
      //　月曜が1,日曜が7
      case 0:
        weekField = "sun_flg";
        break;
      case 1:
        weekField = "mon_flg";
        break;
      case 2:
        weekField = "tue_flg";
        break;
      case 3:
        weekField = "wed_flg";
        break;
      case 4:
        weekField = "thu_flg";
        break;
      case 5:
        weekField = "fri_flg";
        break;
      case 6:
        weekField = "sat_flg";
        break;
      case 7:
        weekField = "sun_flg";
        break;
      default:
        return "";
    }

    String dateTimeStr = DateFormat(DateUtil.formatForDB).format(date);
    String retSql = '''  ${tableSql}stop_flg = '0' 
		 $elementSql 
		 AND $tableSql$weekField = '1' 
		 AND ${tableSql}start_datetime <= '$dateTimeStr' 
		 AND ${tableSql}end_datetime >= '$dateTimeStr' 
		 AND 
		(CASE WHEN ${tableSql}timesch_flg = '1' 
		 THEN ${tableSql}start_datetime <= to_timestamp('$dateTimeStr', 'DD Mon YYYY') 
		  AND ${tableSql}end_datetime   >= to_timestamp('$dateTimeStr', 'DD Mon YYYY') 
		 ELSE 1 = 1 END)  
		 $orderSql $limitSql
        ''';

    return retSql;
  }

  /// 日付情報を取得する（YYYY-MM-DD HH:MM）
  /// 引数: 該当日時
  /// 戻り値:[String] 日時（YYYY-MM-DD HH:MM）
  /// 戻り値:[int] 曜日（0:日 / 1:月 / 2:火 / 3:水 / 4:木 / 5:金 / 6:土）
  /// 関連tprxソース: rcsch.h - rcSchGetDtm_Add
  static (String, int) rcSchGetDtmAdd(String? dateTime) {
    DateTime dt;
    if ((dateTime == null) || (dateTime == "")) {
      dt = DateTime.now();  //システム日付の取得
    } else {
      dt = DateTime.parse(dateTime);
    }
    String retDt = "${dt.year}-${"${dt.month}".padLeft(2,"0")}-${"${dt.day}".padLeft(2,"0")} ${"${dt.hour}".padLeft(2,"0")}:${"${dt.minute}".padLeft(2,"0")}";
    int retWd = dt.weekday;

    return (retDt, retWd);
  }

  /// 日付を取得する（YYYY-MM-DD HH:MM）
  /// 引数: rcSchGetDtmAdd()で取得した本日の日付
  /// 戻り値:日付
  /// 関連tprxソース: rcsch.h - rcSchDateGet
  static int rcSchDateGet(String dateBuf) {
    return int.parse(dateBuf.substring(8, 10));
  }

  /// 月末であるかをチェックする
  /// 引数: rcSchGetDtmAdd()で取得した本日の日付
  /// 戻り値: false=月末でない  true=月末
  /// 関連tprxソース: rcsch.h - rcSchChk_EndOfMonth
  static bool rcSchChkEndOfMonth(String dateBuf) {
    int year = int.parse(dateBuf.substring(0, 4));
    int month = int.parse(dateBuf.substring(5, 7));
    int day = int.parse(dateBuf.substring(8, 10));

    List<int> aDayTbl = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    if (CmSys.chkDateLeap(year)) {
      aDayTbl[1] = 29;
    }

    if (aDayTbl[month-1] == day) {
      return true;
    }
    return false;
  }
}

/// 関連tprxソース: rcsch.c - SchPriorityParam
class SchPriorityParam {
  int limit = 0;
  SchSqlKeyType keyType = SchSqlKeyType.SCHSQL_KEY_NORMAL;
  SchSqlOrderType orderType = SchSqlOrderType.SCHSQL_ORDER_NORMAL;
}
/**********************************************************************
    フラグに関する定義
 ***********************************************************************/

/// 関連tprxソース:rcsch.h - enum SCHSQL_KEY_TYPE
enum SchSqlKeyType {
  SCHSQL_KEY_NORMAL, // 企業, 店舗コードあり
  SCHSQL_KEY_COMP_ONLY, // 企業コードのみ
  SCHSQL_KEY_NOT_KEY, // 企業, 店舗コード無し
}

/// 関連tprxソース:rcsch.h - enum SCHSQL_ORDER_TYPE
enum SchSqlOrderType {
  SCHSQL_ORDER_NORMAL, // 開始日時が現在日付に近いもの, 終了日時が現在日付に近いもの, スケジュールコードが小さい順
  SCHSQL_ORDER_NOT, // 並び替え無し
}