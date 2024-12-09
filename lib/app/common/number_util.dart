/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:intl/intl.dart';

///数字のフォーマット共通関数
class NumberFormatUtil {
  /// 前ゼロ/カンマ区切りの金額
  static const String formatForAmountStr = "#,##0"; // デフォルト値
  static const String formatForZeroPaddingStr = "000"; // デフォルト値
  static String getNumberStr(String format, int intVal) {
    return NumberFormat(format).format(intVal);
  }

  static String formatAmount(int amount) {
    final formatter = NumberFormat('#,##0', 'ja_JP');
    return '¥${formatter.format(amount)}';
  }

  static String formatMinusAmount(int amount) {
    final formatter = NumberFormat('#,##0', 'ja_JP');
    return '-¥${formatter.format(amount)}';
  }

  static String formatPercent(int amount) {
    final formatter = NumberFormat('#,##0', 'ja_JP');
    return '${formatter.format(amount)}%';
  }

  ///時間のフォーマット共通関数
  static String formatTime(String timeStr) {
    String cleaningInput = timeStr.replaceAll(RegExp(r'\D'), '');

    switch (cleaningInput.length) {
      case 1:
        return '$cleaningInput';
      case 2:
        int hour = int.parse(cleaningInput);
        return hour < 24 ? '$cleaningInput' : '';
      case 3:
        int hour = int.parse(cleaningInput.substring(0, 2));
        if (hour < 24) {
          return '${cleaningInput.substring(0, 2)}:${cleaningInput[2]}';
        }
        return '';
      case 4:
        int hour = int.parse(cleaningInput.substring(0, 2));
        int minute = int.parse(cleaningInput.substring(2, 4));
        if (hour < 24 && minute < 60) {
          return '${cleaningInput.substring(0, 2)}:${cleaningInput.substring(2, 4)}';
        }
        return '';
      default:
        return '';
    }
  }
}
