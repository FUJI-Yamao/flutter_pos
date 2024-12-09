/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../postgres_library/src/db_manipulation_ps.dart';
import '../../postgres_library/src/pos_log_table_access.dart';
import '../bean/hist_log_down_response.dart';
import '../bean/openclose_status_response.dart';
import '../bean/ts_base_response.dart';
import 'webapi dummy.dart';

class WebAPI {
  static const bool dummyResponse = false;
  final port = "4047";

  String get _host => "127.0.0.1:$port";
  static final WebAPI _instance = WebAPI._internal();

  factory WebAPI() {
    if (dummyResponse) {
      return WebAPIDummy();
    } else {
      return _instance;
    }
  }

  /// コンストラクタ
  WebAPI._internal() {
    HttpOverrides.global = MyHttpOverrides();
  }


  /// 履歴ログ検索をWebAPIにリクエストする
  ///
  /// 引数 histCd: 履歴ログカウンタ(下り)
  ///      compCd: 企業コード
  ///      streCd: 店舗コード
  ///      number: 要求件数
  Future<HistLogDownResponse> getHistlog(
    int rHistCd, 
    int rCompCd, 
    int rStreCd, 
    int rNumber
  ) async {
    var url = Uri.https(_host, "getHistoryLog",
      {
        'rHistCd': rHistCd.toString(),
        'rCompCd': rCompCd.toString(),
        'rStreCd': rStreCd.toString(),
        'rNumber': rNumber.toString()
      },
    );
    var response = await get(url);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("status code error.${response.statusCode}");
    }
    return HistLogDownResponse.fromJson(jsonDecode(response.body));
  }

  /// 実績ジャーナルデータログ登録をWebAPIにリクエストする
  ///
  /// [day]は営業日の日の部分を渡す(2022/11/30なら30)
  Future<List<Map<String, dynamic>>> postEjLog(
      List<CEjLog> ejLogs, int day) async {
    // var dateset = ejLogs.map((e) => e.sale_date)

    // requestBodyに入れるjsonの作成
    var json = [];
    for (var ejLog in ejLogs) {
      json.add({
        CEjLogField.serial_no: ejLog.serial_no,
        CEjLogField.comp_cd: ejLog.comp_cd,
        CEjLogField.stre_cd: ejLog.stre_cd,
        CEjLogField.mac_no: ejLog.mac_no,
        CEjLogField.print_no: ejLog.print_no,
        CEjLogField.seq_no: ejLog.seq_no,
        CEjLogField.receipt_no: ejLog.receipt_no,
        CEjLogField.end_rec_flg: ejLog.end_rec_flg,
        CEjLogField.only_ejlog_flg: ejLog.only_ejlog_flg,
        CEjLogField.cshr_no: ejLog.cshr_no,
        CEjLogField.chkr_no: ejLog.chkr_no,
        CEjLogField.now_sale_datetime: ejLog.now_sale_datetime,
        CEjLogField.sale_date: ejLog.sale_date,
        CEjLogField.ope_mode_flg: ejLog.ope_mode_flg,
        CEjLogField.print_data: ejLog.print_data,
        CEjLogField.sub_only_ejlog_flg: ejLog.sub_only_ejlog_flg,
        CEjLogField.trankey_search: ejLog.trankey_search,
        CEjLogField.etckey_search: ejLog.etckey_search,
      });
    }
    var body = jsonEncode(json);

    // リクエスト送信
    var url = Uri.parse("$_host/ej_log/$day");
    var response = await post(url,
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: body);

    // TODO:10020 webAPI 例外処理  ステータスコード毎に例外処理を入れる
    if (response.statusCode != 200) {
      throw Exception("status code error.${response.statusCode}");
    }

    // responseBodyのjson文字列をList<Map<String, dynamic>>に変換
    List<dynamic> responseBody = jsonDecode(response.body);
    List<Map<String, dynamic>> castedResponseBody =
        responseBody.map((e) => e as Map<String, dynamic>).toList();
    return castedResponseBody;
  }

  /// 従業員OPENCLOSE状態確認APIを実行
  /// 引数 rCompCd 企業コード
  ///      rStreCd 店舗コード
  ///      rStaffCd 従業員コード
  /// 戻り値 HTTPレスポンスボディ
  Future<String> getStaffOpencloseStatus(
    int rCompCd, 
    int rStreCd, 
    int rStaffCd
  ) async {

    var url = Uri.https(_host, "getStaffOpencloseStatus",
      {
        'rCompCd': rCompCd.toString(),
        'rStreCd': rStreCd.toString(),
        'rStaffCd': rStaffCd.toString()
      },
    );
    var response = await get(url);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("status code error.${response.statusCode}");
    }
    return response.body;
  }

  /// 従業員OPENCLOSE変更APIを実行
  /// 引数 rCompCd 企業コード
  ///      rStreCd 店舗コード
  ///      rMacNo マシン番号
  ///      rCheckerCd,チェッカー従業員番号
  ///      rCheckerStatus,チェッカー従業員状態
  ///      rCashierCd,キャッシャー従業員番号
  ///      rCashierStatusキャッシャー従業員状態
  /// 戻り値 HTTPレスポンスボディ
  Future<String> setStaffOpenclose(
    int rCompCd, 
    int rStreCd, 
    int rMacNo,
    int rCheckerCd,
    int rCheckerStatus,
    int rCashierCd,
    int rCashierStatus
  ) async {

    var url = Uri.https(_host, "setStaffOpenclose");
    Map<String, dynamic> params = {
      'rCompCd': rCompCd, 
      'rStreCd': rStreCd,
      'rMacNo': rMacNo,
      'rCheckerCd': rCheckerCd,
      'rCheckerStatus': rCheckerStatus,
      'rCashierCd': rCashierCd,
      'rCashierStatus': rCashierStatus
    };
    var response = await post(
      url, 
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(params)
    );
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("status code error.${response.statusCode}");
    }
    return response.body;
  }

  /// ファイルリクエストAPIを実行
  /// 引数 rCompCd 企業コード
  ///      rStreCd 店舗コード
  ///      rTableName テーブル名
  Future<List<int>> getFileRequest(
    int rCompCd, 
    int rStreCd, 
    String rTableName,
    {String rColumns = ""}
  ) async {
    Map<String, String> params = {
      'rCompCd': rCompCd.toString(), 
      'rStreCd': rStreCd.toString(),
      'rTableName': rTableName
    };
    if (rColumns.isNotEmpty) {
      params['rColumns'] = rColumns;
    }
    var url = Uri.https(_host, "getFileRequest",
      params,
    );
    var request = Request("GET", url);
    var responseStream = await request.send();
    if (responseStream.statusCode == HttpStatus.ok) {
      List<int> response = [];
      // レスポンスストリームからバイナリを取得
      await for (var lis in responseStream.stream) {
        response.addAll(lis);
      }
      return response;
    } else {
      throw Exception("status code error.${responseStream.statusCode}");
    }
  }

  /// 開閉設状態確認APIを実行
  ///
  /// 引数 rCompCd: 企業コード
  ///      rStreCd: 店舗コード
  ///      rMacNo: マシン番号
  ///      rSaleDate: 営業日（YYYY-MM-DD)
  Future<OpenCloseStatusResponse> getOpenCloseStatus(
    int rCompCd, 
    int rStreCd, 
    int rMacNo, 
    DateTime rSaleDate
  ) async {
    var url = Uri.https(_host, "getOpenCloseStatus",
      {
        'rCompCd': rCompCd.toString(),
        'rStreCd': rStreCd.toString(),
        'rMacNo': rMacNo.toString(),
        'rSaleDate': DateFormat("yyyy-MM-dd").format(rSaleDate)
      },
    );
    var response = await get(url);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("status code error.${response.statusCode}");
    }
    return OpenCloseStatusResponse.fromJson(jsonDecode(response.body));
  }

  /// 開閉設APIを実行
  ///
  /// 引数 rCompCd: 企業コード
  ///      rStreCd: 店舗コード
  ///      rMacNo: マシン番号
  ///      rOpenClose: 開閉店フラグ(1:オープン, 2:クローズ)
  ///      rSaleDate: 営業日（YYYY-MM-DD)
  Future<TsBaseResponse> postOpenClose(
    int rCompCd, 
    int rStreCd, 
    int rMacNo, 
    int rOpenClose, 
    DateTime rSaleDate
  ) async {
    var url = Uri.https(_host, "postOpenClose");
    Map<String, dynamic> params = {
      'rCompCd': rCompCd,
      'rStreCd': rStreCd,
      'rMacNo': rMacNo,
      'rOpenClose': rOpenClose,
      'rSaleDate': DateFormat("yyyy-MM-dd").format(rSaleDate)
    };
    var response = await post(
      url, 
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(params)
    );
    if (response.statusCode != HttpStatus.ok) {
      throw Exception("status code error.${response.statusCode}");
    }
    return TsBaseResponse.fromJson(jsonDecode(response.body));
  }

}

//=========================================
// HTTPエラー無視クラス
//=========================================
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}