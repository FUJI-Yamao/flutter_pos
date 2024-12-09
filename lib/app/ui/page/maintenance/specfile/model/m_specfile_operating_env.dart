/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../../../../../common/cls_conf/mac_infoJsonFile.dart';
import 'm_specfile.dart';
import 'm_specfile_common.dart';

class SpecOperatingEnvDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String specBtnlvl3_4 = 'SPEC_BTNLVL3_4';     // スキャナコマンド制御（卓上）
  static const String specBtnlvl3_5 = 'SPEC_BTNLVL3_5';     // スキャナコマンド制御（タワー）

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: specBtnlvl3_4,
      title: "スキャナコマンド制御（卓上）",
      description: "スキャナコマンド制御（卓上）\n しない/PSC/HONEYWELL",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("PSC", 1),
        SelectionSetting("HONEYWELL", 2)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl3_5,
      title: "スキャナコマンド制御（タワー）",
      description: "スキャナコマンド制御（タワー）\n しない/PSC/HONEYWELL",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("PSC", 1),
        SelectionSetting("HONEYWELL", 2)
      ],
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // MacInfoJsonFileの読み込み
    late Mac_infoJsonFile macInfoJsonFile;
    late RxCommonBuf pCom;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      macInfoJsonFile = Mac_infoJsonFile();
      await macInfoJsonFile.load();
    } else {
      pCom = xRet.object;
      macInfoJsonFile = pCom.iniMacInfo;
    }


    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(macInfoJsonFile, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // MacInfoJsonFileの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(macInfoJsonFile, data.key, specSubData[data]!.after);
    }

    // MacInfoJsonFileへ保存
    await macInfoJsonFile.save();
    if(xRet.isValid()) {
      SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
    }
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(Mac_infoJsonFile macInfoJsonFile, String key) {
    switch (key) {
      case specBtnlvl3_4:       // スキャナコマンド制御（卓上）
        return macInfoJsonFile.scanner.scn_cmd_desktop;
      case specBtnlvl3_5:       // スキャナコマンド制御（タワー）
        return macInfoJsonFile.scanner.scn_cmd_tower;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(Mac_infoJsonFile macInfoJsonFile, String key, dynamic value) {
    switch (key) {
      case specBtnlvl3_4:       // スキャナコマンド制御（卓上）
        macInfoJsonFile.scanner.scn_cmd_desktop = value;
      case specBtnlvl3_5:       // スキャナコマンド制御（タワー）
        macInfoJsonFile.scanner.scn_cmd_tower = value;
      default:                  // その他
        throw AssertionError();
    }
  }

}
