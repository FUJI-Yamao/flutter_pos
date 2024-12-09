/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../backend/history/hist_main.dart';
import '../../../../common/cls_conf/counterJsonFile.dart';
import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../common/environment.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../inc/sys/tpr_stat.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../sys/syst/sys_stdn.dart';

/// 精算画面のコントローラー
class StoreClosePageController extends GetxController {
  /// 現在の時間を表すObservable文字列
  final nowTime = ''.obs;
  /// 現在の日付を表すObservable文字列
  final nowDate = ''.obs;

  Future<CalcResultStore> closeStore(CalcRequestStore para) async {
    CalcResultStore result = CalcResultStore(
        retSts: 0, errMsg: null, saleDate: null, forcedClose: null);
    return result;
  }

  @override
  void onInit() async {
    initializeDateFormatting('ja_JP'); // 日本語化
    _onTimer();
    Timer.periodic(const Duration(seconds: 1), (timer) => _onTimer()); // 1秒ごとに日時を更新
    super.onInit();

    // TODO:10152 履歴ログ 引数突貫
    HistConsole().sendSysNotify(TprStatDef.TPRTST_IDLE);

    updateLabelVisibility();
  }

  final ScrollController scrollCtrl = ScrollController();

  @override
  void onClose() {
    scrollCtrl.dispose();
    super.onClose();
  }

  void _onTimer() {
    DateTime nowDateTime = DateTime.now();
    nowTime.value = DateFormat('yyyy年MM月dd日 (E) HH:mm', 'ja_JP').format(nowDateTime); // 現在日時
    nowDate.value = DateFormat('yyyy-MM-dd (E)', 'ja_JP').format(nowDateTime); // 現在日付
  }

  Future<void> onPressedStoreClose() async {
    await _storeClose();

  }

  // タスクのキャンセル状態を管理する
  bool isTaskCanceled = false;

  // 表示するラベルのリスト
  late List<Label> activeLabel;

  /// 表示するラベルのリストを取得
  void updateLabelVisibility() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      activeLabel = Label.values.where((label) => label != Label.qpDailyProcess && label != Label.idDailyProcess).toList();
    }
    RxCommonBuf pCom = xRet.object;

    // マルチ端末機接続がUT1の場合、閉設処理にQP日計処理とID日計処理を追加
    if (pCom.iniMacInfo.internal_flg.multi_cnct == 3) {
      activeLabel = List<Label>.from(Label.values);
    } else {
      activeLabel = Label.values.where((label) => label != Label.qpDailyProcess && label != Label.idDailyProcess).toList();
    }
  }

  /// 精算処理を実行する
  Future<void> _storeClose() async {

    late CounterJsonFile counterJson;
    late Mac_infoJsonFile macinfoJson;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late RxCommonBuf pCom;
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "onPressedStoreClose() : SystemFunc.rxMemRead[RXMEM_COMMON]");
      return;
    } else {
      pCom = xRet.object;
      macinfoJson = pCom.iniMacInfo;
      counterJson = pCom.iniCounter;
    }

    // 精算APIを実行
    CalcRequestStore requestData = CalcRequestStore(
      compCd: macinfoJson.system.crpno, // 会社番号
      streCd: macinfoJson.system.shpno, // 店舗番号
      macNo: macinfoJson.system.macno, // マシン番号
      saleDate: counterJson.tran.sale_date, // 精算日時
    );
    // 精算APIを実行
    try {
      CalcResultStore result;
      // Windowsの場合は、APIを呼び出さずに処理を行う
      if (Platform.isWindows) {
        result = await closeStoreWindows(requestData);
      }
      else {
        result = await CalcApi.closeStore(requestData);
      }
      if (result.retSts != null && result.retSts == 0) {
        debugPrint("close Store API ok");
      }else {
        debugPrint('close Store API fail: ${result.errMsg}');
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "onPressedStoreClose() : $e $s");
    } finally {

      counterJson.tran.last_sale_date = counterJson.tran.sale_date;
      counterJson.tran.sale_date = '0000-00-00';

      if (counterJson.tran.last_sale_date.isNotEmpty) {
        var save = counterJson.save();
        await save;
        SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
      }
    }
  }

  /// windowsの場合の精算処理
  Future<CalcResultStore> closeStoreWindows(CalcRequestStore requestData) async {
    return CalcResultStore(
        retSts: 0, errMsg: null, saleDate: null, forcedClose: null);
  }

  /// 店舗番号とレジ番号のフォーマット
  String getFormattedShopNumber(int shopNumber) {
    return shopNumber.toString().padLeft(9, '0');
  }
  String getFormattedMachineNumber(int machineNumber) {
    return machineNumber.toString().padLeft(6, '0');
  }
  String getCurrentDateTimeFormatted() {
    String currentDateTime = DateTime.now().toString();
    return currentDateTime.replaceAll(':', '').replaceAll('-', '').
    replaceAll(' ', '').substring(0, currentDateTime.length - 14);
  }
  /// zipファイル作り
  Future<bool> zipFileManager() async {
    final logFolderPath = getLogFolderPath();
    bool errStat = true;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    final macInfojson = pCom.iniMacInfo;
    final counterJson = pCom.iniCounter;

    final zipFilePath = getZipFilePath(logFolderPath, macInfojson);

    final shopNo = getFormattedShopNumber(macInfojson.system.shpno);
    final macNo = getFormattedMachineNumber(macInfojson.system.macno);
    final currentDate = getCurrentDateTimeFormatted();

    var ret = await backupSalesLogData();
    if(ret == false){
      errStat = false;
    }

    createZipArchive(logFolderPath, zipFilePath, shopNo, macNo, currentDate);

    ret = await deleteOldZipFile(logFolderPath);
    if(ret == false) {
      errStat = false;
    }

    return errStat;
  }

  String logDirectoryPath = EnvironmentData().sysHomeDir;

  String getLogFolderPath() {
    return Platform.isWindows ? 'C:$logDirectoryPath' : logDirectoryPath;
  }

  String getZipFilePath(String logFolderPath,Mac_infoJsonFile macInfojson) {
    final currentDate = getCurrentDateTimeFormatted();
    final shopNo = getFormattedShopNumber(macInfojson.system.shpno);
    final macNo = getFormattedMachineNumber(macInfojson.system.macno);

    return '${logFolderPath.trim()}/log${currentDate.trim()}_${shopNo.trim()}_$macNo.zip';
  }

  void createZipArchive(String sourceDir, String zipFile, String shopNo, String macNo, String currentDate) async {
    final encoder = ZipFileEncoder();
    encoder.create(zipFile);
    Directory rootPath;
    rootPath = Directory(EnvironmentData.TPRX_HOME);
    final directories = [
      Directory('$sourceDir/log'),
      Directory('$sourceDir/tmp'),
      Directory('${rootPath.path.trim()}/assets/conf'),
    ];

    for (var directory in directories) {
      if (directory.existsSync()) {
        encoder.addDirectory(directory);
      }
    }

    encoder.close();
  }

  Future<bool> deleteOldZipFile(String logFolderPath) async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    final DateTime date = DateTime.now();
    int wlogDate = pCom.dbTrm.logDelDate;
    if (wlogDate <= 0) wlogDate = 62;
    var logdeldate = date.subtract(Duration(days: wlogDate));
    String formattedlogdeldate = DateFormat('yyyyMMdd').format(logdeldate);

    final directory = Directory(logFolderPath);

    if (directory.existsSync()) {
      var entities = directory.listSync();
      for (var entity in entities) {
        if (entity is File) {
          final fileName = entity.path.split(Platform.pathSeparator).last;
          if (fileName.startsWith('log20')) {
            String datePart = fileName.substring(3, 11);
            if (datePart.compareTo(formattedlogdeldate) < 0) {
              entity.deleteSync();
              debugPrint('${entity.path} 期限超過ファイルを削除しました');
            }
          }
        }
      }
    } else {
      debugPrint('フォルダーが存在しません: $logFolderPath');
      return false;
    }
    return true;
  }

  /// p_sales_logのバックアップを実行
  Future<bool> backupSalesLogData() async {
    DbManipulationPs db = DbManipulationPs();
    String logFolderPath = join(EnvironmentData().sysHomeDir, 'log');

    try {
      if (Platform.isWindows) {
        String sql = "copy p_sales_log to '${join(logFolderPath, 'p_sales_log.cpy')}'";
        await db.dbCon.execute(sql);
      } else if (Platform.isLinux) {
        final file = File(join(logFolderPath, 'p_sales_log.cpy'));
        final sink = file.openWrite(mode: FileMode.append);
        String sql = "SELECT * FROM p_sales_log";
        final result = await db.dbCon.execute(sql);
        for (final row in result) {
          sink.writeln(row.toString());
        }
        sink.close;
      }
    } catch (e, s) {
      TprLog().logAdd(
          Tpraid.TPRAID_STR, LogLevelDefine.error,
          "Error exporting data: $e\n$s"
      );
      return false;
    }
    return true;
  }

  Future<void> finishApp() async {
    debugPrint('finish program');
    
    // シャットダウンをする一連の処理
    await SysStdn.finishAppAndShutdown(mode: ShutDownMode.halt);
    // アプリ終了
    exit(0);
  }

}

enum Label {
  programProcess("プログラム処理"),
  qpDailyProcess('QP日計処理'),
  idDailyProcess('iD日計処理'),
  unsentRecordProcess('未送信実績処理'),
  recordBackupProcess('実績バックアップ処理'),
  closeProcess('クローズ処理'),
  fileOrganizeProcess('ファイルの整理処理'),
  logBackupProcess('ログバックアップ処理');

  final String name;

  const Label(this.name);
}