/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:path/path.dart';

import '../../app/inc/sys/tpr_aid.dart';
import '../../app/inc/sys/tpr_log.dart';
import '../../postgres_library/src/db_manipulation_ps.dart';
import '../bean/hist_log_down_response.dart';
import '../bean/openclose_status_response.dart';
import '../bean/ts_base_response.dart';
import 'webapi.dart';

class WebAPIDummy implements WebAPI {
  static const fileRequestDummyDir = ""; // ファイルリクエストAPIから返されるzipの格納フォルダ

  @override
  Future<List<int>> getFileRequest(int rCompCd, int rStreCd, String rTableName, {String rColumns = ""}) async {
    Directory dir = Directory(fileRequestDummyDir);
    if (dir.existsSync()) {
      File? zipFile = dir.listSync().whereType<File>().firstWhereOrNull((element) => basename(element.path) == "$rTableName.txt");
      if (zipFile != null) {
        return zipFile.readAsBytesSync();
      }
    }
    throw Exception("getFileRequest dummy api: file not found $rTableName.zip");
  }

  @override
  Future<HistLogDownResponse> getHistlog(
    int rHistCd, 
    int rCompCd, 
    int rStreCd, 
    int rNumber
  ) async {
    List<HistLog> histLog = List.generate(
      rNumber, (_) => HistLog(
        histCd: rHistCd, 
        insDatetime: "2024-01-18 18:46:04", 
        compCd: rCompCd, 
        streCd: rStreCd, 
        tableName: "c_cashrecycle_mst", 
        mode: 0, 
        macFlg: 1, 
        data1: "$rCompCd\t$rStreCd\t1\t1\t0.00\t0\t2024-01-18 18:46:04.78019\t2024-01-18 18:46:04.78019\t00\t999999\t2",
        data2: ""
      )
    );
    HistLogDownResponse bean = HistLogDownResponse(retSts: 0, errMsg: "", histLog: histLog);
    return bean;
  }

  @override
  Future<String> getStaffOpencloseStatus(int rCompCd, int rStreCd, int rStaffCd) async {
    String response = '{"RetSts": 0, "ErrMsg": "", "MacNo":"101", "ChkrStatus":"0", "CshrStatus":"1"}';
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "getStaffOpencloseStatus dummy response: $response");
    return response;
  }

  @override
  // TODO: implement port
  String get port => throw UnimplementedError();

  @override
  Future<List<Map<String, dynamic>>> postEjLog(List<CEjLog> ejLogs, int day) {
    // TODO: implement postEjLog
    throw UnimplementedError();
  }

  @override
  Future<String> setStaffOpenclose(int rCompCd, int rStreCd, int rMacNo, int rCheckerCd, int rCheckerStatus, int rCashierCd, int rCashierStatus) async {
    String response = '{"RetSts": 0,"ErrMsg": ""}';
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "setStaffOpenclose dummy response: $response");
    return response;
  }
  
  @override
  Future<TsBaseResponse> postOpenClose(int rCompCd, int rStreCd, int rMacNo, int rOpenClose, DateTime rSaleDate) async {
    return TsBaseResponse(retSts: "0", errMsg: "");
  }
  
  @override
  Future<OpenCloseStatusResponse> getOpenCloseStatus(int rCompCd, int rStreCd, int rMacNo, DateTime rSaleDate) async {
    return OpenCloseStatusResponse(retSts: "0", errMsg: "", openFlg: true, closeFlg: false);
  }

}