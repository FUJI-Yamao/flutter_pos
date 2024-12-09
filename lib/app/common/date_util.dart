/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter_pos/app/inc/sys/tpr_aid.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import '../inc/apl/rxmem_define.dart';
import '../inc/lib/L_timestamp.dart';
import '../inc/lib/cm_sys.dart';
import '../inc/sys/tpr_log.dart';
import '../lib/apllib/competition_ini.dart';
import 'cmn_sysfunc.dart';
import '../lib/cm_sys/cm_sumgt.dart';

class DateUtil {
  static const String formatDate = "yyyy-MM-dd";
  static const String formatDateSlash = "yyyy/MM/dd";

  static const int daysIn99 = 99;

  /// 関連tprxソース: FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON
  static const String formatForDB = "yyyy-MM-dd HH:mm:ss";
  static const String formatForLogDetail = "yyyy-MM-dd HH:mm:ss";
  static const String formatForEjJst = "yyyy年 MM月dd日(E) HH:mm:ss";
  static const String formatForLogAddTime = "yyyyMMddHHmmss";
  static const String formatForReceipt = "yyyy年MM月dd日(E)HH:mm";

  /// 関連tprxソース: timestamp.h
  static const TIME_STAMP_DATE_LEN = 8;
  static const TIME_STAMP_TIME_LEN = 6;

  /// 日付を使用するときの初期値などに利用する無効日付データ.
  static DateTime get invalidDate => DateTime(1899, 1, 1);

  /// 文字列の日付をDateTime型に変換する
  ///
  /// 文字列の日付の形式を第２パラメータのフォーマットで定義する。
  /// 変換に失敗すると例外になる。
  static DateTime getDateTime(String date, String format) {
    final _dateFormatter = DateFormat(format);
    return _dateFormatter.parseStrict(date);
  }

  /// DateTime型の日付を文字列に変換する
  static String getString(DateTime date, String format) {
    final _dateFormatter = DateFormat(format);
    return _dateFormatter.format(date);
  }

  ///対応するロケールが初期化される
  static void localInitialzed(String localName) {
    initializeDateFormatting(localName, null);
  }

  ///曜日を短縮式で取得する　’土曜日’→’土’
  static String formatShortWeekday(DateTime date) {
    String fullWeekday = DateFormat('EEEE', 'ja_JP').format(date);
    return fullWeekday.length > 1 ? fullWeekday.substring(0, 1) : fullWeekday;
  }

  ///指定された日付文字列が現在の日付の過去oo日以内かどうかを判断するメソッド
  static bool isDateWithinRange(String dateStr, int dayInRange) {
    try {
      DateFormat format = DateFormat('yyyy/MM/dd');
      DateTime inputDate = format.parse(dateStr);

      DateTime now = DateTime.now();
      DateTime startRange = now.subtract(Duration(days: dayInRange));

      return inputDate.isAfter(startRange) && !inputDate.isAfter(now);
    } catch (e) {
      return false;
    }
  }

  static String getNowStr(String format) {
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat(format);
    String date = outputFormat.format(now);
    return date;
  }

  /// 日付・時刻文字列を指定フォーマットで返す
  ///   備考 : 曜日を日本語で返却(E or EEEEで指定された場合)
  static String getNowStrJpn(String format) {
    initializeDateFormatting('en_US');
    initializeDateFormatting('ja_JP');
    DateTime now = DateTime.now();
    DateFormat outputFormat = DateFormat(format, 'Ja_JP');
    String date = outputFormat.format(now);
    return date;
  }

  /// 日付・時刻文字列を指定フォーマットで返す
  ///     引数：char *tdate 日付・時刻を格納するポインタ(元日付・時刻)
  ///                       フォーマット: 左詰めの[YYYYMMDD]or[YYYY-MM-DD]or[YYYY/MM/DD]or[YYYY.MM.DD]
  ///                                     日付と時刻間にspaceはありorなし
  ///                                     時刻なしorあり[HHMMSS]or[HH:MM:SS]or[HHMM]or[HH:MM]or[HH]
  ///         ：char *tdate_new 日付・時刻を格納するポインタ(戻り値)
  ///         ：int type 変換タイプ
  ///                     0 : 営業日取得(counter.json)
  ///                     1 : システム日付・時刻取得
  ///                     2 : 任意日付・時刻変換
  ///                     3 : 営業日取得（c_openclose_mst)
  ///         ：int format_type 戻り日付・時刻フォーマット(YYYY*MM*DD*HH*MM*DD*)
  ///         ：int format_way  戻り日付詰め方(YYYYMMDD, YYYY0M0D, YYYY M D)
  ///                           0 : 元日付と同じ
  ///                           1 : 0詰め
  ///                           2 : スペース詰め
  ///  関連tprxソース:timestamp.c - datetime_change()
  static Future<(int, String)> dateTimeChange(String? tDate, DateTimeChangeType type,
      DateTimeFormatKind formatType, DateTimeFormatWay formatWay) async{
    DateTimeStamp	dateTime = DateTimeStamp();
    DateTimeFormat format = DateTimeFormat();
    String saleDate = '0000-00-00';
    bool error = false;

    if((type.index < DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE.index)
        || (type.index > DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE_MEM.index)){
      return (-1, saleDate);
    }

    if((formatType.id < DateTimeFormatKind.FT_YYYYMMDD.id)
        || (formatType.id > DateTimeFormatKind.FT_YYYYMMDD_KANJI_WEEK_KANJI.id)){
      return (-1, saleDate);
    }

    if((formatWay.index < DateTimeFormatWay.DATE_TIME_FORMAT_OLD.index)
        || (formatWay.index > DateTimeFormatWay.DATE_TIME_FORMAT_SPACE.index)){
      return (-1, saleDate);
    }

    saleDate = await datetimeGetData(tDate, dateTime, format, type.index);
    if(saleDate == '0000-00-00'){
      return (-1, saleDate);
    }

    error = datetimeSetFormat(format, formatType.id);
    if(error == false){
      saleDate = '0000-00-00';
      return (-1, saleDate);
    }

    saleDate = datetimeSetData(dateTime, format, formatWay.index);
    if(saleDate == '0000-00-00'){
      return (-1, saleDate);
    }

    return (0, saleDate);
  }

  /*----------------------------------------------------------------------
	日付・時刻のデータ(年月日時分秒,フォーマット)取得
------------------------------------------------------------------------*/
  ///  関連tprxソース:timestamp.c - datetime_get_data()
  static Future<String> datetimeGetData(String? tDate, DateTimeStamp dateTime,
      DateTimeFormat format, int type) async{
    DateTime theTime = DateTime.now();
    String buf = '';
    String saleDate = '0000-00-00';
    int	yearSize = 0;
    int	monSize = 0;
    int	hourSize = 0;
    int	minSize = 0;
    int	yobiSize = 0;
    int	sLen = 0;
    int	timeColCnt = 0;
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRetC.isInvalid()){
      return saleDate;
    }
    RxCommonBuf cBuf = xRetC.object;

    if(type == DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE.index){
      if(xRetC.isInvalid()){
        return saleDate;
      }

      CompetitionIniRet ret
      = await CompetitionIni.competitionIniGet(Tpraid.TPRAID_SYSTEM,
          CompetitionIniLists.COMPETITION_INI_SALE_DATE,
          CompetitionIniType.COMPETITION_INI_GETMEM);
      saleDate = ret.value;

      if(CmSys.DD_MM_YY != 0){
        dateTime.day = saleDate.substring(0,2);
        dateTime.mon = saleDate.substring(3,5);
        dateTime.year = saleDate.substring(6,10);
      }else if(CmSys.MM_DD_YY != 0){
        dateTime.mon = saleDate.substring(0,2);
        dateTime.day = saleDate.substring(3,5);
        dateTime.year = saleDate.substring(6,10);
      }else{ /* Default YY_MM_DD */
        dateTime.year = saleDate.substring(0,4);
        dateTime.mon = saleDate.substring(5,7);
        dateTime.day = saleDate.substring(8,10);
      }

      dateTime.hour = '00';
      dateTime.min = '00';
      dateTime.sec = '00';
    }else if(type == DateTimeChangeType.DATE_TIME_CHANGE_SYSTEM.index){
      dateTime.year = theTime.toString().substring(0, 4); // 'yyyy'
      dateTime.mon = theTime.toString().substring(5, 7); // 'MM'
      dateTime.day = theTime.toString().substring(8, 10); // 'dd'
      dateTime.hour = theTime.toString().substring(11, 13); // 'HH'
      dateTime.min = theTime.toString().substring(14, 16); // 'mm'
      dateTime.sec = theTime.toString().substring(17, 19); // 'ss'
    }else if(type == DateTimeChangeType.DATE_TIME_CHANGE.index){
      if(tDate == null){
        return saleDate;
      }

      if(tDate.isEmpty){
        return saleDate;
      }

      buf = tDate;

      if(buf.isNotEmpty){
        format.dateFlg = 1;
        if(CmSys.DD_MM_YY != 0){
          if(buf[2] == '-'){
            format.dateHyp = 1;
          }else if(buf[2] == '/'){
            format.dateSla = 1;
          }else if(buf[2] == '.'){
            format.dateDot = 1;
          }
        }else if(CmSys.MM_DD_YY != 0){
          if(buf[2] == '-'){
            format.dateHyp = 1;
          }else if(buf[2] == '/'){
            format.dateSla = 1;
          }else if(buf[2] == '.'){
            format.dateDot = 1;
          }
        }else{ /* Default YY_MM_DD */
          if(buf[4] == '-'){
            format.dateHyp = 1;
          }else if(buf[4] == '/'){
            format.dateSla = 1;
          }else if(buf[4] == '.'){
            format.dateDot = 1;
          }else{
            if(buf.contains(LTimeStamp.TIMESTAMP_YEAR)){
              yearSize = LTimeStamp.TIMESTAMP_YEAR.length;
              format.dateKanji += yearSize;
            }

            if(buf.contains(LTimeStamp.TIMESTAMP_MON)){
              monSize = LTimeStamp.TIMESTAMP_MON.length;
              format.dateKanji += monSize;
            }

            if(buf.contains(LTimeStamp.TIMESTAMP_DAY)){
              format.dateKanji += LTimeStamp.TIMESTAMP_DAY.length;
            }
          }

        }
        format.dateLen = TIME_STAMP_DATE_LEN + 2*format.dateHyp + 2*format.dateSla + 2*format.dateDot + format.dateKanji;
      }

      /* (曜) がある場合の対応 */
      if(buf.substring(format.dateLen, format.dateLen + 1) == '('){
        format.weekFlg = 1;

        /* 正しい曜日はこの関数の下部で詰める。日曜日のバイト数で対応 */
        yobiSize = LTimeStamp.yobi[0].length + 2;	/* 曜日の文字列 + 括弧 */
        format.weekKanji = yobiSize;
      }

      sLen = format.dateLen + yobiSize;
      if(buf.substring(sLen, sLen + 1) == ' '){
        format.spaceFlg = 1;
      }

      sLen += format.spaceFlg;
      timeColCnt = 0;
      if(buf.length > sLen){
        format.timeFlg = 1;

        if(buf.substring(sLen + 2, sLen + 3) == ':'){ /* 日付 + HH */
          format.timeCol = 1;
          timeColCnt = 1;

          if(buf.length > sLen + 2 + 1 + 2){	/* s_len + HH + : + MM (秒があるか)*/
            timeColCnt = 2;
          }else{
            format.notSecFlg = 1;
          }
        }else{/* '時''分''秒'を検索 */
          if(buf.contains(LTimeStamp.TIMESTAMP_HOUR)){
            hourSize = LTimeStamp.TIMESTAMP_HOUR.length;
            format.timeKanji += hourSize;
          }

          if(buf.contains(LTimeStamp.TIMESTAMP_MIN)){
            minSize = LTimeStamp.TIMESTAMP_MIN.length;
            format.timeKanji += minSize;
          }

          if(buf.contains(LTimeStamp.TIMESTAMP_SEC)){
            format.timeKanji += LTimeStamp.TIMESTAMP_SEC.length;
          }else{
            if(format.timeKanji != 0){ /* 漢字がひとつでも見つかっていて、"秒"がない */
              format.notSecFlg = 1;
            }else{ /* ':'がない、漢字ではないので HHMMSSの文字列 */
              if(buf.length < sLen + TIME_STAMP_TIME_LEN){
                format.notSecFlg = 1;
              }
            }
          }
        }
        format.timeLen = TIME_STAMP_TIME_LEN + timeColCnt*format.timeCol + format.timeKanji;
        if(format.notSecFlg == 1){
          format.timeLen -= 2;	/* 秒の時間をマイナスする */
        }
      }

      if(format.dateFlg == 1){
        if(CmSys.DD_MM_YY != 0){
          dateTime.day = buf.substring(0, 2);
          dateTime.mon = buf.substring(2 + (format.dateHyp + format.dateSla + format.dateDot), 4 + (format.dateHyp + format.dateSla + format.dateDot));
          dateTime.year = buf.substring(2 + 2 * (format.dateHyp + format.dateSla + format.dateDot) + 2, 8 + 2 * (format.dateHyp + format.dateSla + format.dateDot));
        }else if(CmSys.MM_DD_YY != 0){
          dateTime.mon = buf.substring(0, 2);
          dateTime.day = buf.substring(2 + (format.dateHyp + format.dateSla + format.dateDot), 4 + (format.dateHyp + format.dateSla + format.dateDot));
          dateTime.year = buf.substring(2 + 2 * (format.dateHyp + format.dateSla + format.dateDot) + 2, 8 + 2 * (format.dateHyp + format.dateSla + format.dateDot));
        }else{ /* Default YY_MM_DD */
          dateTime.year = buf.substring(0, 4);
          dateTime.mon = buf.substring(4 + (format.dateHyp + format.dateSla + format.dateDot), 6 + (format.dateHyp + format.dateSla + format.dateDot));
          dateTime.day = buf.substring(4 + 2 * (format.dateHyp + format.dateSla + format.dateDot) + 2, 8 + 2 * (format.dateHyp + format.dateSla + format.dateDot));
        }
      }

      if(format.timeFlg == 1){
        sLen = format.dateLen + yobiSize + format.spaceFlg;	/* 日付 + 日付と時間の間の空白 */
        dateTime.hour = buf.substring(sLen, sLen + 2);

        if(buf.length > (sLen + 2)){	/* 分があるか */
          sLen += 2 + format.timeCol + hourSize;	/* HH + ':'または'時' */
          dateTime.min = buf.substring(sLen, sLen + 2);
        }

        if(buf.length > (sLen + 2)){	/* 秒があるか */
          sLen += 2 + format.timeCol + minSize;	/* MM + ':'または'分' */
          dateTime.sec = buf.substring(sLen, sLen + 2);
        }
      }
    }else if(type == DateTimeChangeType.DATE_TIME_CHANGE_SALE_DATE_MEM.index){
      if(xRetC.isInvalid()){
        return saleDate;
      }

      saleDate = '0000-00-00';
      if(cBuf.dbOpenClose.sale_date != null){
        saleDate = cBuf.dbOpenClose.sale_date!.substring(0, 10);
      }

      if(CmSys.DD_MM_YY != 0){
        dateTime.day = saleDate.substring(0, 2);
        dateTime.mon = saleDate.substring(3, 5);
        dateTime.year = saleDate.substring(6, 10);
      }else if(CmSys.MM_DD_YY != 0){
        dateTime.mon = saleDate.substring(0, 2);
        dateTime.day = saleDate.substring(3, 5);
        dateTime.year = saleDate.substring(6, 10);
      }else{ /* Default YY_MM_DD */
        dateTime.year = saleDate.substring(0, 4);
        dateTime.mon = saleDate.substring(5, 7);
        dateTime.day = saleDate.substring(8, 10);
      }
      dateTime.hour = "00";
      dateTime.min = "00";
      dateTime.sec = "00";
    }else{
      return saleDate;
    }

    if(DateTime(int.tryParse(dateTime.year) ?? 0000, int.tryParse(dateTime.mon) ?? 00,
        int.tryParse(dateTime.day) ?? 00).compareTo(DateTime(0000,00,00)) != 0){
      theTime = DateTime(int.parse(dateTime.year), int.parse(dateTime.mon),
          int.parse(dateTime.day));
      // dateTimeに格納したyear、mon、dayをDateTime型に変換したあとでUNIX時刻に変換し、
      // 1970年1月1日0:00:00からの経過時間を比較
      if((theTime.millisecondsSinceEpoch / 1000).floor() >
          DateTime.parse('1970-01-01 00:00:00Z').millisecondsSinceEpoch / 1000){
        saleDate = theTime.toString();
        dateTime.week = sprintf("%i", [theTime.weekday]);
      }

    }

//  printf("func[%25s]date_flg[%d]date_hyp[%d]date_sla[%d]date_dot[%d]date_kanji[%d]space_flg[%d]time_flg[%d]time_col[%d]time_kanji[%d]date_len[%d]time_len[%d]week_flg[%d]week_kanji[%d]not_year_flg[%d]not_sec_flg[%d]\n",
//  	__FUNCTION__,format->date_flg, format->date_hyp,format->date_sla,format->date_dot,format->date_kanji,format->space_flg,format->time_flg,format->time_col,format->time_kanji,format->date_len,format->time_len,format->week_flg,format->week_kanji,format->not_year_flg,format->not_sec_flg);
    return saleDate;
  }

/*----------------------------------------------------------------------
		日付・時刻を 指定フォーマットに 変換
------------------------------------------------------------------------*/
  ///  関連tprxソース:timestamp.c - datetime_set_data()
  static String datetimeSetData(DateTimeStamp dateTime, DateTimeFormat format, int formatWay){
    String dateBuf = '';	// 整形した年月日
    String timeBuf = '';	// 整形した時分秒
    String spaceBuf = '';	// 年月日と時分秒の間のスペース

    // 年月日のセット  + 曜日のセット
    if(format.dateFlg == 1){
      String setYear = '';
      String setMonth = '';
      String setDay = '';
      String sepa1st = '';
      String sepa2nd = '';
      String sepa3rd = '';
      String weekDay = '';

      // 年月日のデータを取込
      if(formatWay == DateTimeFormatWay.DATE_TIME_FORMAT_OLD.index){
        setYear = sprintf("%s", [int.parse(dateTime.year)]);
        setMonth = sprintf("%s", [int.parse(dateTime.mon)]);
        setDay = sprintf("%s", [int.parse(dateTime.day)]);
      }else if(formatWay == DateTimeFormatWay.DATE_TIME_FORMAT_ZERO.index){
        setYear = sprintf("%04i", [int.parse(dateTime.year)]);
        setMonth = sprintf("%02i", [int.parse(dateTime.mon)]);
        setDay = sprintf("%02i", [int.parse(dateTime.day)]);
      }else if(formatWay == DateTimeFormatWay.DATE_TIME_FORMAT_SPACE.index){
        setYear = sprintf("%4i", [int.parse(dateTime.year)]);
        setMonth = sprintf("%2i", [int.parse(dateTime.mon)]);
        setDay = sprintf("%2i", [int.parse(dateTime.day)]);
      }

      // 年月日の区切り文字をセット
      if(format.dateHyp == 1){
        sepa1st = "-";
        sepa2nd = "-";
      }else if(format.dateSla == 1){
        sepa1st = "/";
        sepa2nd = "/";
      }else if(format.dateDot == 1){
        sepa1st = ".";
        sepa2nd = ".";
      }else if(format.dateKanji >= 1){
        if(CmSys.DD_MM_YY != 0){
          sepa1st = LTimeStamp.TIMESTAMP_DAY;
          sepa2nd = LTimeStamp.TIMESTAMP_MON;
          sepa3rd = LTimeStamp.TIMESTAMP_YEAR;
        }else if(CmSys.MM_DD_YY != 0){
          sepa1st = LTimeStamp.TIMESTAMP_MON;
          sepa2nd = LTimeStamp.TIMESTAMP_DAY;
          sepa3rd = LTimeStamp.TIMESTAMP_YEAR;
        }else{
          /* Default YY_MM_DD */
          sepa1st = LTimeStamp.TIMESTAMP_YEAR;
          sepa2nd = LTimeStamp.TIMESTAMP_MON;
          sepa3rd = LTimeStamp.TIMESTAMP_DAY;
        }
      }

      if(format.weekFlg == 1){
        if(format.weekKanji >= 1){
          weekDay = sprintf("(%s)", [LTimeStamp.yobi[int.parse(dateTime.week)]]);
        }
      }

      // 年無しの場合
      if(format.notYearFlg == 1){
        setYear = '';
        sepa1st = '';
      }

      // 国別表記ごとに年月日をセット
      if(CmSys.DD_MM_YY != 0){
        dateBuf = sprintf("%s%s%s%s%s%s",
            [setDay, sepa1st, setMonth, sepa2nd, setYear, sepa3rd]);
      }else if(CmSys.MM_DD_YY != 0){
        dateBuf = sprintf("%s%s%s%s%s%s",
            [setMonth, sepa1st, setDay, sepa2nd, setYear, sepa3rd]);
      }else{
        /* Default YY_MM_DD */
        dateBuf = sprintf("%s%s%s%s%s%s%s",
            [setYear, sepa1st, setMonth, sepa2nd, setDay, sepa3rd, weekDay]);
      }
    }

    // 年月日と時刻の間のスペース
    if(format.spaceFlg == 1){
      spaceBuf = " ";
    }

    // 時刻のセット
    if(format.timeFlg == 1){
      String setHour = '';
      String setMin = '';
      String setSec = '';
      String sepa1st = '';
      String sepa2nd = '';
      String sepa3rd = '';

      // 時刻のデータを取込
      setHour = sprintf("%s", [dateTime.hour]);
      setMin = sprintf("%s", [dateTime.min]);
      setSec = sprintf("%s", [dateTime.sec]);

      // 時刻の区切り文字をセット
      if(format.timeCol == 1){
        sepa1st = ":";
        sepa2nd = ":";
      }else if(format.timeKanji >= 1){
        sepa1st = LTimeStamp.TIMESTAMP_HOUR;
        sepa2nd = LTimeStamp.TIMESTAMP_MIN;
        sepa3rd = LTimeStamp.TIMESTAMP_SEC;
      }

      // 秒無しフラグ
      if(format.notSecFlg == 1){
        setSec = '';
        if(format.timeCol == 1){
          sepa2nd = '';
        }else if(format.timeKanji >= 1){
          sepa3rd = '';
        }
      }
      timeBuf = sprintf("%s%s%s%s%s%s", [setHour, sepa1st, setMin, sepa2nd, setSec, sepa3rd]);
    }
    String tDateNew = sprintf("%s%s%s", [dateBuf, spaceBuf, timeBuf]);
    return tDateNew;
  }

/*  ----------------------------------------------------------------------
	  	日付・時刻のフォーマット設定
--  ----------------------------------------------------------------------*/
  ///  関連tprxソース:timestamp.c - datetime_set_format()
  static bool datetimeSetFormat(DateTimeFormat format, int formatType){
    int	yearSize = 0;
    int	secSize = 0;

    DateTimeFormatKind define = DateTimeFormatKind.getDefine(formatType);
    switch (define){
      case DateTimeFormatKind.FT_YYYYMMDD:				/* YYYYMMDD */
        format.dateFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HHMMSS :			/* YYYYMMDDHHMMSS */
        format.dateFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HHMMSS_COLON :			/* YYYYMMDDHH:MM:SS */
        format.dateFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HHMMSS_KANJI :			/* YYYYMMDDHH時MM分SS秒 */
        format.dateFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HHMM :				/* YYYYMMDDHHMM */
        format.dateFlg = 1;
        format.timeFlg = 1;
        format.notSecFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SPACE_HHMMSS :			/* YYYYMMDD HHMMSS */
        format.dateFlg = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SPACE_HHMMSS_COLON :		/* YYYYMMDD HH:MM:SS */
        format.dateFlg = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SPACE_HHMMSS_KANJI :		/* YYYYMMDD HH時MM分SS秒 */
        format.dateFlg = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN :			/* YYYY-MM-DD */
        format.dateFlg = 1;
        format.dateHyp = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_HHMMSS :		/* YYYY-MM-DDHHMMSS */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_HHMMSS_COLON :		/* YYYY-MM-DDHH:MM:SS */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_HHMMSS_KANJI :		/* YYYY-MM-DDHH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS :		/* YYYY-MM-DD HHMMSS */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON :	/* YYYY-MM-DD HH:MM:SS */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_KANJI :	/* YYYY-MM-DD HH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_HYPHEN_SPACE_HHMM_COLON :	/* YYYY-MM-DD HH:MM  */
        format.dateFlg = 1;
        format.dateHyp = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        format.notSecFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH :			/* YYYY/MM/DD */
        format.dateFlg = 1;
        format.dateSla = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_HHMMSS :			/* YYYY/MM/DDHHMMSS */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_HHMMSS_KANJI :		/* YYYY/MM/DDHH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_SPACE_HHMMSS :		/* YYYY/MM/DD HHMMSS */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_SPACE_HHMMSS_COLON :	/* YYYY/MM/DD HH:MM:SS */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_SPACE_HHMMSS_KANJI :	/* YYYY/MM/DD HH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_SPACE_HHMM_COLON :	/* YYYY/MM/DD HH:MM *//* FT_YYYYMMDD_SLASH_HHMM_COLON,とフォーマットが重複 */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        format.notSecFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_SLASH_HHMM_COLON :		/* YYYY/MM/DD HH:MM *//* enum変数名と実際のフォーマット内容が異なっている FT_YYYYMMDD_SLASH_SPACE_HHMM_COLON が正しい */
        format.dateFlg = 1;
        format.dateSla = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        format.notSecFlg = 1;
        format.spaceFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT :				/* YYYY.MM.DD */
        format.dateFlg = 1;
        format.dateDot = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_HHMMSS :			/* YYYY.MM.DDHHMMSS */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_HHMMSS_COLON :		/* YYYY.MM.DDHH:MM:SS */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_HHMMSS_KANJI :		/* YYYY.MM.DDHH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_SPACE_HHMMSS :		/* YYYY.MM.DD HHMMSS */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_SPACE_HHMMSS_COLON :	/* YYYY.MM.DD HH:MM:SS */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_DOT_SPACE_HHMMSS_KANJI :	/* YYYY.MM.DD HH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateDot = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI :			/* YYYY年MM月DD日 */
        format.dateFlg = 1;
        format.dateKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_HHMMSS :			/* YYYY年MM月DD日HHMMSS */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_HHMMSS_COLON :		/* YYYY年MM月DD日HH:MM:SS */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_HHMMSS_KANJI :		/* YYYY年MM月DD日HH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_SPACE_HHMMSS :		/* YYYY年MM月DD日 HHMMSS */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_SPACE_HHMMSS_COLON :	/* YYYY年MM月DD日 HH:MM:SS */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_SPACE_HHMMSS_KANJI :	/* YYYY年MM月DD日 HH時MM分SS秒 */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_SPACE_HHMM_COLON :	/* YYYY年MM月DD日 HH:MM */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.spaceFlg = 1;
        format.timeFlg = 1;
        format.notSecFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_HHMMSS :				/* HHMMSS */
        format.timeFlg = 1;
        break;
      case DateTimeFormatKind.FT_HHMMSS_COLON :				/* HH:MM:SS */
        format.timeFlg = 1;
        format.timeCol = 1;
        break;
      case DateTimeFormatKind.FT_HHMMSS_KANJI :				/* HH時MM分SS秒 */
        format.timeFlg = 1;
        format.timeKanji = 1;
        break;
      case DateTimeFormatKind.FT_HHMM :					/* HHMM */
        format.timeFlg = 1;
        format.notSecFlg = 1;
        break;
      case DateTimeFormatKind.FT_HHMM_COLON :				/* HH:MM */
        format.timeFlg = 1;
        format.timeCol = 1;
        format.notSecFlg = 1;
        break;
      case DateTimeFormatKind.FT_HHMM_KANJI :				/* HH時MM分 */
        format.timeFlg = 1;
        format.timeKanji = 1;
        format.notSecFlg = 1;
        break;

    // datetime_changeにしか現状は使えない
      case DateTimeFormatKind.FT_MMDD :					/* MMDD */
        format.dateFlg = 1;
        format.notYearFlg = 1;
        break;
      case DateTimeFormatKind.FT_MMDD_KANJI :				/* MM月DD日 */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.notYearFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_HHMM :			/* YYYY年MM月DD日(曜) HH:MM */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.weekFlg = 1;
        format.weekKanji = 1;
        format.timeFlg = 1;
        format.timeCol = 1;
        format.notSecFlg = 1;
        format.spaceFlg = 1;
        break;
      case DateTimeFormatKind.FT_YYYYMMDD_KANJI_WEEK_KANJI:              /* YYYY年MM月DD日(曜) */
        format.dateFlg = 1;
        format.dateKanji = 1;
        format.weekFlg = 1;
        format.weekKanji = 1;
        break;
      default:
        return false;
    }

    if(format.dateKanji != 0){
      format.dateKanji = 0;
      yearSize = LTimeStamp.TIMESTAMP_YEAR.length;
      format.dateKanji += yearSize;

      format.dateKanji += LTimeStamp.TIMESTAMP_MON.length;

      format.dateKanji += LTimeStamp.TIMESTAMP_DAY.length;
    }

    if(format.timeKanji != 0){
      format.timeKanji = 0;
      format.timeKanji += LTimeStamp.TIMESTAMP_HOUR.length;
      format.timeKanji += LTimeStamp.TIMESTAMP_MIN.length;
      secSize = LTimeStamp.TIMESTAMP_SEC.length;
      format.timeKanji += secSize;
    }

    if(format.weekKanji != 0){
      format.weekKanji = LTimeStamp.yobi[0].length + 2; /* 曜日の文字列 + 括弧 */
    }

    if(format.dateFlg == 1){
      format.dateLen = TIME_STAMP_DATE_LEN + 2 * format.dateHyp + 2 * format.dateSla + 2 * format.dateDot + format.dateKanji;
    }

    if(format.timeFlg == 1){
      format.timeLen = TIME_STAMP_TIME_LEN + 2 * format.timeCol + format.timeKanji;
    }

    if((format.dateFlg == 1) && (format.notYearFlg == 1)){
      format.dateLen = format.dateLen - (4 + format.dateHyp + format.dateSla + format.dateDot + yearSize);
      format.dateKanji -= yearSize;
    }

    if((format.timeFlg == 1) && (format.notSecFlg == 1)){
      format.timeLen = format.timeLen - (2 + format.timeCol + secSize);
      format.timeKanji -= secSize;
    }
//  printf("func[%25s]date_flg[%d]date_hyp[%d]date_sla[%d]date_dot[%d]date_kanji[%d]space_flg[%d]time_flg[%d]time_col[%d]time_kanji[%d]date_len[%d]time_len[%d]week_flg[%d]week_kanji[%d]notYearFlg[%d]not_sec_flg[%d]\n",
//  	__FUNCTION__,format->date_flg, format->date_hyp,format->date_sla,format->date_dot,format->date_kanji,format->space_flg,format->time_flg,format->time_col,format->time_kanji,format->date_len,format->time_len,format->week_flg,format->week_kanji,format->not_year_flg,format->not_sec_flg);

    return true;
  }

  /// 機能：指定日付・時刻より、指定日数以降の日付・時刻を返す
  /// 引数：String tdate 日付・時刻を格納するポインタ(元日付)
  ///                   フォーマット: 左詰めの[YYYYMMDD]or[YYYY-MM-DD]or[YYYY/MM/DD]or[YYYY.MM.DD]
  ///                                日付と時刻間にspaceはありorなし
  ///                                時刻なしorあり[HHMMSS]or[HH:MM:SS]or[HHMM]or[HH:MM]or[HH]
  ///     ：long days 指定日数
  /// 戻値：int 0 : 正常終了 / -1: 異常終了(元日付・時刻フォーマットエラー .ect)
  ///     ：String 日付・時刻
  ///  関連tprxソース:timestamp.c - datetime_datecalc
  static (int, String) datetimeDatecalc(String tdate, int days) {
    List<int> monDays = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (days == 0) {
      return (0, tdate);
    }

    var datetime = DateTimeStamp();
    var format = DateTimeFormat();
    datetimeGetData(tdate, datetime, format, 2);

    int pyear;
    int pmon;
    int pday;
    if (datetime.year.isEmpty) {
      return (-1, '');
    } else {
      pyear = int.parse(datetime.year);
    }
    if (datetime.mon.isEmpty) {
      pmon = 1;
    } else {
      pmon = int.parse(datetime.mon);
    }
    if (datetime.day.isEmpty) {
      pday = 1;
    } else {
      pday = int.parse(datetime.day);
    }

    int tdays;
    if (days > 0) {
      tdays = days;

      do {
        if ((((CmSys.chkDateLeap(pyear)) && (pmon == 2)) &&
                ((pday + tdays) > 29)) ||
            ((!((CmSys.chkDateLeap(pyear)) && (pmon == 2))) &&
                ((pday + tdays) > monDays[pmon]))) {
          if ((CmSys.chkDateLeap(pyear)) && (pmon == 2)) {
            tdays -= (29 - pday);
          } else {
            tdays -= (monDays[pmon] - pday);
          }
          pmon += 1;
          if (pmon > 12) {
            pmon = 1;
            pyear += 1;
          }
          pday = 0;
        } else {
          pday += tdays;
          tdays = 0;
        }
      } while (tdays != 0);
    } else if (days < 0) {
      tdays = 0 - days;

      do {
        if ((pday - tdays) < 1) {
          tdays -= pday;
          pmon -= 1;
          if (pmon < 1) {
            pmon = 12;
            pyear -= 1;
          }
          if ((CmSys.chkDateLeap(pyear)) && (pmon == 2)) {
            pday = 29;
          } else {
            pday = monDays[pmon];
          }
        } else {
          pday -= tdays;
          tdays = 0;
        }
      } while (tdays != 0);
    }

    if ((datetime.mon[0] == ' ') || (datetime.day[0] == ' ')) {
      datetime.year = pyear.toString().padLeft(4, '0');
      datetime.mon = pmon.toString().padLeft(2, '0');
      datetime.day = pday.toString().padLeft(2, '0');
    } else {
      datetime.year = pyear.toString().padLeft(4, '0');
      datetime.mon = pmon.toString().padLeft(2, '0');
      datetime.day = pday.toString().padLeft(2, '0');
    }

    var tdateNew = datetimeSetData(datetime, format, 0);
    if (tdateNew.isEmpty) {
      return (-1, '');
    }

    return (0, tdateNew);
  }

  static int datetimeDaysCalc(String tdateStart, String tdateEnd) {
    var tdate = [tdateStart, tdateEnd];
    var days = [0, 0];
   
    for (int i = 0; i < 2; i++) {

      var chkDate = ChkDate();
      var datetime = DateTimeStamp();
      var format = DateTimeFormat();
    
      datetimeGetData(tdate[i], datetime, format, 2);
    
      chkDate.year = int.parse(datetime.year);
      chkDate.month = int.parse(datetime.mon);
      chkDate.day = int.parse(datetime.day);

      days[i] = CmSumgt.cmSumdayGet(chkDate);
    }

    return days[1] - days[0];	
  }

  /// 日時データからDatetime型のデータを返す. ただし, 年や月はそのまま使用できる数値となる.
  /// 引数:[date] 日時データ (type = 2の場合のみセット必須. 日時のフォーマットはdatetime_change()に使用出来るもの)
  ///	引数:[type] 変換タイプ (0:営業日取得  1:システム日付・時刻取得  2:任意日付・時刻変換)
  /// 戻値:[int]	0=成功  -1=失敗
  ///	戻値:[Datetime] 変換後の日時データ
  ///  関連tprxソース:timestamp.c - datetime_gettm
  static Future<(int, DateTime)> datetimeGettm(String? date, DateTimeChangeType type) async {
    if ((type == DateTimeChangeType.DATE_TIME_CHANGE) && (date == null)) {
      return (-1, DateTime.now());
    }
    int ret = 0;
    String getDate = "";
    (ret, getDate) = await dateTimeChange(date, type, DateTimeFormatKind.FT_YYYYMMDD_HHMMSS, DateTimeFormatWay.DATE_TIME_FORMAT_ZERO);
    if (ret != 0) {
      return (-1, DateTime.now());
    }
    // 各要素を抜き出してセットしていく(各要素の説明は man time.h で確認)
    int year = int.parse(getDate.substring(0, 4));
    int month = int.parse(getDate.substring(4, 6));
    int day = int.parse(getDate.substring(6, 8));
    int hour = int.parse(getDate.substring(8, 10));
    int min = int.parse(getDate.substring(10, 12));
    int sec = int.parse(getDate.substring(12, 14));
    DateTime dt = DateTime(year, month, day, hour, min, sec);
    return (0, dt);
  }
}

enum DateTimeChangeType {
  DATE_TIME_CHANGE_SALE_DATE,
  /* 営業日を指定フォーマットで取得 */
  DATE_TIME_CHANGE_SYSTEM,
  /* システム(現在の)日付・時刻を指定フォーマットで取得 */
  DATE_TIME_CHANGE,
  /* 任意の日付・時刻を指定フォーマットに変換 */
  DATE_TIME_CHANGE_SALE_DATE_MEM /* 営業日を指定フォーマットで取得(c_openclose_mst) */
}

enum DateTimeFormatWay {
  // 20100401->20100401, 2010 4 1->2010 4 1
  DATE_TIME_FORMAT_OLD,
  // 20100401->20100401, 2010 4 1->20100401
  DATE_TIME_FORMAT_ZERO,
//  20100401->2010 4 1, 2010 4 1->2010 4 1
  DATE_TIME_FORMAT_SPACE
}

///  関連tprxソース:timestamp.h - DateTimeStamp()
class DateTimeStamp{
  String year = '';
  String mon = '';
  String day = '';
  String hour = '';
  String min = '';
  String sec = '';
  String week = '';
}

///  関連tprxソース:timestamp.h - DateTimeFormat()
class DateTimeFormat{
  int dateFlg = 0;
  int dateHyp = 0;
  int dateSla = 0;
  int dateDot = 0;
  int dateKanji = 0;
  int spaceFlg = 0;
  int timeFlg = 0;
  int timeCol = 0;
  int timeKanji = 0;
  int dateLen = 0;
  int timeLen = 0;
  int weekFlg = 0;
  int weekKanji = 0;
  int notYearFlg = 0;
  int notSecFlg = 0;
}

class ChkDate {
  late int year;
  late int month;
  late int day;
}

///  関連tprxソース:timestamp.h - DATE_TIME_FORMAT_KIND()
enum DateTimeFormatKind{
  FT_NONE(-1),
  FT_YYYYMMDD(0),			/* YYYYMMDD */
  FT_YYYYMMDD_HHMMSS(1),			/* YYYYMMDDHHMMSS */
  FT_YYYYMMDD_HHMMSS_COLON(2),		/* YYYYMMDDHH:MM:SS */
  FT_YYYYMMDD_HHMMSS_KANJI(3),		/* YYYYMMDDHH時MM分SS秒 */
  FT_YYYYMMDD_HHMM(4),			/* YYYYMMDDHHMM */
  FT_YYYYMMDD_SPACE_HHMMSS(5),		/* YYYYMMDD HHMMSS */
  FT_YYYYMMDD_SPACE_HHMMSS_COLON(6),		/* YYYYMMDD HH:MM:SS */
  FT_YYYYMMDD_SPACE_HHMMSS_KANJI(7),		/* YYYYMMDD HH時MM分SS秒 */
  FT_YYYYMMDD_HYPHEN(8),			/* YYYY-MM-DD */
  FT_YYYYMMDD_HYPHEN_HHMMSS(9),		/* YYYY-MM-DDHHMMSS */
  FT_YYYYMMDD_HYPHEN_HHMMSS_COLON(10),	/* YYYY-MM-DDHH:MM:SS */
  FT_YYYYMMDD_HYPHEN_HHMMSS_KANJI(11),	/* YYYY-MM-DDHH時MM分SS秒 */
  FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS(12),	/* YYYY-MM-DD HHMMSS */
  FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_COLON(13),	/* YYYY-MM-DD HH:MM:SS */
  FT_YYYYMMDD_HYPHEN_SPACE_HHMMSS_KANJI(14),	/* YYYY-MM-DD HH時MM分SS秒 */
  FT_YYYYMMDD_HYPHEN_SPACE_HHMM_COLON(15),	/* YYYY-MM-DD HH:MM */
  FT_YYYYMMDD_SLASH(16),			/* YYYY/MM/DD */
  FT_YYYYMMDD_SLASH_HHMMSS(17),		/* YYYY/MM/DDHHMMSS */
  FT_YYYYMMDD_SLASH_HHMMSS_KANJI(18),		/* YYYY/MM/DDHH時MM分SS秒 */
  FT_YYYYMMDD_SLASH_SPACE_HHMMSS(19),		/* YYYY/MM/DD HHMMSS */
  FT_YYYYMMDD_SLASH_SPACE_HHMMSS_COLON(20),	/* YYYY/MM/DD HH:MM:SS */
  FT_YYYYMMDD_SLASH_SPACE_HHMMSS_KANJI(21),	/* YYYY/MM/DD HH時MM分SS秒 */
  FT_YYYYMMDD_SLASH_SPACE_HHMM_COLON(22),	/* YYYY/MM/DD HH:MM *//* FT_YYYYMMDD_SLASH_HHMM_COLON,とフォーマットが重複 */
  FT_YYYYMMDD_SLASH_HHMM_COLON(23),		/* YYYY/MM/DD HH:MM *//* enum変数名と実際のフォーマット内容が異なっている FT_YYYYMMDD_SLASH_SPACE_HHMM_COLON が正しい */
  FT_YYYYMMDD_DOT(24),			/* YYYY.MM.DD */
  FT_YYYYMMDD_DOT_HHMMSS(25),			/* YYYY.MM.DDHHMMSS */
  FT_YYYYMMDD_DOT_HHMMSS_COLON(26),		/* YYYY.MM.DDHH:MM:SS */
  FT_YYYYMMDD_DOT_HHMMSS_KANJI(27),		/* YYYY.MM.DDHH時MM分SS秒 */
  FT_YYYYMMDD_DOT_SPACE_HHMMSS(28),		/* YYYY.MM.DD HHMMSS */
  FT_YYYYMMDD_DOT_SPACE_HHMMSS_COLON(29),	/* YYYY.MM.DD HH:MM:SS */
  FT_YYYYMMDD_DOT_SPACE_HHMMSS_KANJI(30),	/* YYYY.MM.DD HH時MM分SS秒 */
  FT_YYYYMMDD_KANJI(31),			/* YYYY年MM月DD日 */
  FT_YYYYMMDD_KANJI_HHMMSS(32),		/* YYYY年MM月DD日HHMMSS */
  FT_YYYYMMDD_KANJI_HHMMSS_COLON(33),		/* YYYY年MM月DD日HH:MM:SS */
  FT_YYYYMMDD_KANJI_HHMMSS_KANJI(34),		/* YYYY年MM月DD日HH時MM分SS秒 */
  FT_YYYYMMDD_KANJI_SPACE_HHMMSS(35),		/* YYYY年MM月DD日 HHMMSS */
  FT_YYYYMMDD_KANJI_SPACE_HHMMSS_COLON(36),	/* YYYY年MM月DD日 HH:MM:SS */
  FT_YYYYMMDD_KANJI_SPACE_HHMMSS_KANJI(37),	/* YYYY年MM月DD日 HH時MM分SS秒 */
  FT_YYYYMMDD_KANJI_SPACE_HHMM_COLON(38),	/* YYYY年MM月DD日 HH:MM */
  /* 年がはいっていないものは datetime_check()でエラーになる */
  FT_HHMMSS(39),				/* HHMMSS */
  FT_HHMMSS_COLON(40),			/* HH:MM:SS */
  FT_HHMMSS_KANJI(41),			/* HH時MM分SS秒 */
  FT_HHMM(42),				/* HHMM */
  FT_HHMM_COLON(43),				/* HH:MM */
  FT_HHMM_KANJI(44),				/* HH時MM分 */
  FT_MMDD(45),				/* MMDD */
  FT_MMDD_KANJI(46),				/* MM月DD日 */
  FT_YYYYMMDD_KANJI_HHMM(47),			/* YYYY年MM月DD日(曜) HH:MM */


  FT_YYYYMMDD_KANJI_WEEK_KANJI(48);           /* YYYY年MM月DD日(曜) *//*必ず最後にしておくこと */

  final int id;
  const DateTimeFormatKind(this.id);


  /// keyIdから対応するDateTimeFormatKindを取得する.
  static DateTimeFormatKind getDefine(int id){
    DateTimeFormatKind? define =
    DateTimeFormatKind.values.firstWhereOrNull((a) => a.id == id);
    define ??= DateTimeFormatKind.FT_NONE; // 定義されているものになければnoneを入れておく.
    return define;
  }
}
