/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../../common/cls_conf/qc_start_dspJsonFile.dart';
import '../../../../../../common/cls_conf/qcashierJsonFile.dart';
import '../m_specfile.dart';
import '../m_specfile_common.dart';

/// Speeza設定画面の項目と処理
class QCashierOperation extends SpecRowDispCommon {

  /// 表示項目
  static const String fConTblMsgQcReadAlertTime = 'FCONTBL_MSG_QC_READ_ALERT_TIME';                 // お会計券読込後の経過時間警告
  static const String fConTblMsgQcAutoReadInterval = 'FCONTBL_MSG_QC_AUTO_READ_INTERVAL';           // QC指定情報の読込間隔
  static const String fConTblMsgQcInterruptPrint = 'FCONTBL_MSG_QC_INTERRUPT_PRINT';                // 中断時、中断レシートの印字・品券キー入力時に取引送信
  static const String spIniParamDispPrecaBalSht = 'FCONTBL_MSG_QC_UPDFILE_FTPGET_TIME';             // UpdファイルのFTP取得タイムアウト
  static const String spIniParamQCStatusActiveSet = 'FCONTBL_MSG_QC_TRAN_RECEIVE_QTY';              // QC指定時の受付制限数
  static const String spIniParamQCStatusAnotherActiveSet = 'FCONTBL_MSG_QC_CHANGE_CHK';             // お釣り取忘れ時のQC指定

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: fConTblMsgQcReadAlertTime,
      title: 'お会計券読込後の経過時間警告',
      description: "お会計券読込後の経過時間警告（単位：秒）\n  （0の場合、警告なし）※QC指定仕様のみ\n　０～９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcAutoReadInterval,
      title: 'QC指定情報の読込間隔',
      description: "QC指定情報の読込間隔（単位：秒）\n　０～９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 9),
    ),
    const SpecFileDispRow(
      key: fConTblMsgQcInterruptPrint,
      title: '中断時、中断レシートの印字・品券キー入力時に取引送信',
      description: "中断時、中断レシートの印字\n  しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("する", 0),
        SelectionSetting("しない", 1),
      ],
    ),
    const SpecFileDispRow(
      key: spIniParamDispPrecaBalSht,
      title: 'UpdファイルのFTP取得タイムアウト',
      description: "UpdファイルのFTP取得タイムアウト（単位：秒）\n　０～９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 99),
    ),
    const SpecFileDispRow(
      key: spIniParamQCStatusActiveSet,
      title: 'QC指定時の受付制限数',
      description: "QC指定時の受付制限数\n  ０～１     0: 無制限",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 1),
    ),
    const SpecFileDispRow(
      key: spIniParamQCStatusAnotherActiveSet,
      title: 'お釣り取忘れ時のQC指定',
      description: "お釣り取忘れ時のQC指定（受付制限数1に限る）\n  禁止／許可",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("禁止", 0),
        SelectionSetting("許可", 1),
      ],
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // QcashierJsonFileの読み込み
    QcashierJsonFile qcashierJsonFile = QcashierJsonFile();
    await qcashierJsonFile.load();
    // Qc_start_dspJsonFileの読み込み
    Qc_start_dspJsonFile qcStartDspJsonFile = Qc_start_dspJsonFile();
    await qcStartDspJsonFile.load();

    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(qcashierJsonFile, qcStartDspJsonFile, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // QcashierJsonFileの読み込み
    QcashierJsonFile qcashierJsonFile = QcashierJsonFile();
    await qcashierJsonFile.load();
    // Qc_start_dspJsonFileの読み込み
    Qc_start_dspJsonFile qcStartDspJsonFile = Qc_start_dspJsonFile();
    await qcStartDspJsonFile.load();

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(qcashierJsonFile, qcStartDspJsonFile, data.key, specSubData[data]!.after);
    }

    // QcashierJsonFileへ保存
    await qcashierJsonFile.save();
    // Qc_start_dspJsonFileへ保存
    await qcStartDspJsonFile.save();
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(QcashierJsonFile qcashierJsonFile, Qc_start_dspJsonFile qcStartDspJsonFile, String key) {
    switch (key) {
      case fConTblMsgQcReadAlertTime:            // お会計券読込後の経過時間警告
        return qcashierJsonFile.ActSetUp.ReadAlertTime;
      case fConTblMsgQcAutoReadInterval:         // QC指定情報の読込間隔
        return qcashierJsonFile.ActSetUp.AutoReadInterval;
      case fConTblMsgQcInterruptPrint:           // 中断時、中断レシートの印字・品券キー入力時に取引送信
        return qcashierJsonFile.ActSetUp.InterruptPrint;
      case spIniParamDispPrecaBalSht:            // UpdファイルのFTP取得タイムアウト
        return qcashierJsonFile.ActSetUp.UpdGetFtpTimer;
      case spIniParamQCStatusActiveSet:          // QC指定時の受付制限数
        return qcStartDspJsonFile.Private.TranReceiveQty;
      case spIniParamQCStatusAnotherActiveSet:   // お釣り取忘れ時のQC指定
        return qcStartDspJsonFile.Private.ChangeChk;
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(QcashierJsonFile qcashierJsonFile, Qc_start_dspJsonFile qcStartDspJsonFile, String key, dynamic value) {
    switch (key) {
      case fConTblMsgQcReadAlertTime:            // お会計券読込後の経過時間警告
        qcashierJsonFile.ActSetUp.ReadAlertTime = value;
      case fConTblMsgQcAutoReadInterval:         // QC指定情報の読込間隔
        qcashierJsonFile.ActSetUp.AutoReadInterval = value;
      case fConTblMsgQcInterruptPrint:           // 中断時、中断レシートの印字・品券キー入力時に取引送信
        qcashierJsonFile.ActSetUp.InterruptPrint = value;
      case spIniParamDispPrecaBalSht:            // UpdファイルのFTP取得タイムアウト
        qcashierJsonFile.ActSetUp.UpdGetFtpTimer = value;
      case spIniParamQCStatusActiveSet:          // QC指定時の受付制限数
        qcStartDspJsonFile.Private.TranReceiveQty = value;
      case spIniParamQCStatusAnotherActiveSet:   // お釣り取忘れ時のQC指定
        qcStartDspJsonFile.Private.ChangeChk = value;
    }
  }
}
