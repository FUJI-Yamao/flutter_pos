/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../../common/cmn_sysfunc.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import 'm_specfile.dart';
import 'm_specfile_common.dart';

/// マシン環境画面の項目と処理
class SpecMachineDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String specBtnlvl1_2 = 'SPEC_BTNLVL1_2';     // マシン番号
  static const String specBtnCmp1_3 = 'SPEC_BTNCMP1_3';     // 企業番号
  static const String specBtnlvl1_4 = 'SPEC_BTNLVL1_4';     // Ｍ／Ｓ仕様
  static const String specBtnlvl1_5 = 'SPEC_BTNLVL1_5';     // マシンタイプ
  static const String specBtnlvl1_3 = 'SPEC_BTNLVL1_3';     // 店舗番号
  static const String specBtnlvl1_11 = 'SPEC_BTNLVL1_11';   // シリアル番号
  static const String specBtnlvl1_17 = 'SPEC_BTNLVL1_17';   // 時刻問い合わせ先

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    SpecFileDispRow(
      key: specBtnlvl1_2,
      title: 'マシン番号',
      description: "マシン番号　　　　\n　１～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 999999),
      configurableFunc: configurableNotSaleDate,
    ),
    SpecFileDispRow(
      key: specBtnCmp1_3,
      title: '企業番号',
      description: "企業番号　　　　　\n　１～９９９９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 999999999),
      configurableFunc: configurableNotSaleDate,
    ),
    const SpecFileDispRow(
      key: specBtnlvl1_4,
      title: "Ｍ／Ｓ仕様",
      description: "Ｍ／Ｓ仕様　　\n　しない／する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1)
      ],
    ),
    const SpecFileDispRow(
      key: specBtnlvl1_5,
      title: "マシンタイプ",
      description: "マシンタイプ（Ｍ／Ｓ仕様：する　の時のみ有効）\n　Ｓ／ＢＳ／Ｍ／ｽﾀﾝﾄﾞｱﾛﾝ",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("Ｓ", 0),
        SelectionSetting("ＢＳ", 1),
        SelectionSetting("Ｍ", 2),
        SelectionSetting("ｽﾀﾝﾄﾞｱﾛﾝ", 3)
      ],
    ),
    SpecFileDispRow(
      key: specBtnlvl1_3,
      title: "店舗番号",
      description: "店舗番号　　　　　\n　１～９９９９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 999999999),
      configurableFunc: configurableNotSaleDate,
    ),
    const SpecFileDispRow(
      key: specBtnlvl1_11,
      title: "シリアル番号",
      description: "シリアル番号\n１～９９９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 99999999),
    ),
    const SpecFileDispRow(
      key: specBtnlvl1_17,
      title: "時刻問い合わせ先",
      description: "時刻問い合わせ先\n　ＴＳ２１００／Ｍレジ／ＳＩＭＳ２１００／タイムサーバー",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("TS2100", 0),
        SelectionSetting("Mレジ", 1),
        SelectionSetting("SIMS2100", 2),
        SelectionSetting("ﾀｲﾑｻｰﾊﾞｰ", 3)
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
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return specSubData;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

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
      case specBtnlvl1_2:       // マシン番号
        return macInfoJsonFile.system.macno;
      case specBtnCmp1_3:       // 企業番号
        return macInfoJsonFile.system.crpno;
      case specBtnlvl1_4:       // Ｍ／Ｓ仕様
        return macInfoJsonFile.mm_system.mm_onoff;
      case specBtnlvl1_5:       // マシンタイプ
        return macInfoJsonFile.mm_system.mm_type;
      case specBtnlvl1_3:       // 店舗番号
        return macInfoJsonFile.system.shpno;
      case specBtnlvl1_11:      // シリアル番号
        return macInfoJsonFile.system.serialno;
      case specBtnlvl1_17:      // 時刻問い合わせ先
        return macInfoJsonFile.timeserver.timeserver;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(Mac_infoJsonFile macInfoJsonFile, String key, dynamic value) {
    switch (key) {
      case specBtnlvl1_2:       // マシン番号
        macInfoJsonFile.system.macno = value;
      case specBtnCmp1_3:       // 企業番号
        macInfoJsonFile.system.crpno = value;
      case specBtnlvl1_4:       // Ｍ／Ｓ仕様
        macInfoJsonFile.mm_system.mm_onoff = value;
      case specBtnlvl1_5:       // マシンタイプ
        macInfoJsonFile.mm_system.mm_type = value;
      case specBtnlvl1_3:       // 店舗番号
        macInfoJsonFile.system.shpno = value;
      case specBtnlvl1_11:      // シリアル番号
        macInfoJsonFile.system.serialno = value;
      case specBtnlvl1_17:      // 時刻問い合わせ先
        macInfoJsonFile.timeserver.timeserver = value;
      default:                  // その他
        throw AssertionError();
    }
  }
}
