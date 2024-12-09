/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:flutter_pos/webapi/src/webapi.dart';

void main() async {
  var api = WebAPI();

  // 履歴ログ検索実行例
  // 期待値：履歴ログコード(hist_cd)が2以降のレコード
  print(await api.getHistlog(1, 1, 1, 0));
  //print(await api.getHistlog(1, 1, 1));

  // 期待値：履歴ログコード(hist_cd)が4以降のレコード + 履歴ログコードが1のレコード
  print(await api.getHistlog(1, 1, 3, 50));
  //print(await api.getHistlog(1, 1, 3, [1], 50));

  // 実績ジャーナルデータログ実行例
  // CEjLogのオブジェクトを用意
  var ejLog = CEjLog();
  ejLog.serial_no = "999";
  ejLog.comp_cd = 1;
  ejLog.stre_cd = 1;
  ejLog.mac_no = 1;
  ejLog.print_no = 1;
  ejLog.seq_no = 1;
  ejLog.receipt_no = 1;
  ejLog.end_rec_flg = 1;
  ejLog.only_ejlog_flg = 1;
  ejLog.cshr_no = 1;
  ejLog.chkr_no = 1;
  ejLog.now_sale_datetime = "120000";
  ejLog.sale_date = "20221130";
  ejLog.ope_mode_flg = 1;
  ejLog.print_data = "aaa";
  ejLog.sub_only_ejlog_flg = 1;
  ejLog.trankey_search = "bbb";
  ejLog.etckey_search = "ccc";

  // 実績ジャーナルデータログ登録実行
  // 期待値：送信したCEjLogオブジェクトの内容
  print(await api.postEjLog([ejLog], 1));
}
