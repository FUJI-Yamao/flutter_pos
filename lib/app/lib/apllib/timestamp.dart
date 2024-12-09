/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

/// 関連tprxソース: timestamp.c
class TimeStamp{
  ///  日時データ間の秒数を返す関数
  /// 引数:	startTime	基準となる日時 (日時のフォーマットはdatetime_change()に使用出来るもの)
  /// 	endTime		終了となる日時 ( 〃 )
  /// 	ret		startTime, endTime間の秒数を格納するポインタ
  /// 戻値:	0:成功  -1:失敗  結果はretに格納
  /// 関連tprxソース: timestamp.c - GetDiffSec
  static (int, int) getDiffSec(String? startTime, String? endTime, int ret) {
    DateTime? startSec; // startTimeのカレンダー時刻を格納
    DateTime? endSec; // endTimeのカレンダー時刻を格納

    if (startTime == null || endTime == null) {
      return (-1, ret);
    }

    // 引数データよりカレンダー時刻を取得する
    startSec = DateTime.tryParse(startTime);
    endSec = DateTime.tryParse(endTime);
    if (startSec == null || endSec == null) {
      return (-1, ret);
    }

    // startTime, endTime間の秒数を取得
    ret = endSec.difference(startSec).inSeconds;
    return (0, ret);
  }
}