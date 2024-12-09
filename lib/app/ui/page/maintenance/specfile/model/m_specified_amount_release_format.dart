/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/ui/page/maintenance/specfile/model/m_specfile.dart';
import 'package:flutter_pos/app/ui/page/maintenance/specfile/model/m_specfile_common.dart';

import '../../../../../common/cls_conf/mac_infoJsonFile.dart';

class SpecSpecifiedAmountReleaseFormatDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String acb50Ssw24_0 = 'ACB50_SSW24_0';     // 金額指定放出フォーマット

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: acb50Ssw24_0,
      title: "金額指定放出フォーマット",
      description: "金額指定放出フォーマット\n 5桁/6桁",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("5桁", 0),
        SelectionSetting("6桁", 1)
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
      case acb50Ssw24_0:       // 金額指定放出フォーマット
        return macInfoJsonFile.acx_flg.acb50_ssw24_0;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(Mac_infoJsonFile macInfoJsonFile, String key, dynamic value) {
    switch (key) {
      case acb50Ssw24_0:       // 金額指定放出フォーマット
        macInfoJsonFile.acx_flg.acb50_ssw24_0 = value;
      default:                  // その他
        throw AssertionError();
    }
  }

}
