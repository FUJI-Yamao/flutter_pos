/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../common/cls_conf/counterJsonFile.dart';
import '../../../../../common/cmn_sysfunc.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import '../../../../../lib/cm_sys/cm_cksys.dart';
import 'm_specfile.dart';
import 'm_specfile_common.dart';

/// カウンター画面の項目と処理
class SpecCounterDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String specBtnLvl4_3 = 'SPEC_BTNLVL4_3';       // 取引レシート番号
  static const String specBtnLvl4_2_2 = 'SPEC_BTNLVL4_2_2';   // ジャーナル番号
  static const String specBtnLvl4_2 = 'SPEC_BTNLVL4_2';       // 領収書発行番号
  static const String specBtnLvl4_7 = 'SPEC_BTNLVL4_7';       // 保証書発行番号
  static const String specBtnLvl4_6 = 'SPEC_BTNLVL4_6';       // クレジット売上通番
  static const String specBtnLvl4_9 = 'SPEC_BTNLVL4_9';       // 総合ＡＳＰ端末処理通番
  static const String specBtnLvl4_35 = 'SPEC_BTNLVL4_35';     // VEGAクレジット売上通番

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    SpecFileDispRow(
      key: specBtnLvl4_3,
      title: '取引レシート番号',
      description: "取引レシート番号　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 9999),
      configurableFunc: configurableNotSaleDate,
    ),
    SpecFileDispRow(
      key: specBtnLvl4_2_2,
      title: 'ジャーナル番号',
      description: "ジャーナル番号　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 9999),
      configurableFunc: configurableNotSaleDate,
    ),
    const SpecFileDispRow(
      key: specBtnLvl4_2,
      title: "領収書発行番号",
      description: "領収書発行番号　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 9999),
    ),
    const SpecFileDispRow(
      key: specBtnLvl4_7,
      title: "保証書発行番号",
      description: "保証書発行番号　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 9999),
    ),
    SpecFileDispRow(
      key: specBtnLvl4_6,
      title: "クレジット売上通番",
      description: "クレジット売上通番　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: const NumInputSetting(1, 9999),
      displayableFunc: _displayableCrdtNo,
    ),
    const SpecFileDispRow(
      key: specBtnLvl4_9,
      title: "総合ＡＳＰ端末処理通番",
      description: "総合ＡＳＰ端末処理通番　　　　\n　１～９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 99999),
    ),
    const SpecFileDispRow(
      key: specBtnLvl4_35,
      title: "VEGAクレジット売上通番",
      description: "VEGAクレジット売上通番　　　　\n　１～９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(1, 9999),
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // CounterJsonFileの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late CounterJsonFile counterJson;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      await counterJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
    }

    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(counterJson, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // CounterJsonFileの読み込み
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late CounterJsonFile counterJson;
    late RxCommonBuf pCom;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      await counterJson.load();
    } else {
      pCom = xRet.object;
      counterJson = pCom.iniCounter;
    }

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(counterJson, data.key, specSubData[data]!.after);
    }

    // CounterJsonFileへ保存
    await counterJson.save();
    if (xRet.isValid()) {
      SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);
    }
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(CounterJsonFile counterJson, String key) {
    switch (key) {
      case specBtnLvl4_3:        // 取引レシート番号
        return counterJson.tran.rcpt_no;
      case specBtnLvl4_2_2:      // ジャーナル番号
        return counterJson.tran.print_no;
      case specBtnLvl4_2:       // 領収書発行番号
        return counterJson.tran.receipt_no;
      case specBtnLvl4_7:        // 保証書発行番号
        return counterJson.tran.guarantee_no;
      case specBtnLvl4_6:       // クレジット売上通番
        return counterJson.tran.credit_no;
      case specBtnLvl4_9:       // 総合ＡＳＰ端末処理通番
        return counterJson.tran.nttasp_credit_no;
      case specBtnLvl4_35:      // VEGAクレジット売上通番
        return counterJson.tran.credit_no_vega;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(CounterJsonFile counterJson, String key, dynamic value) {
    switch (key) {
      case specBtnLvl4_3:       // 取引レシート番号
        counterJson.tran.rcpt_no = value;
      case specBtnLvl4_2_2:     // ジャーナル番号
        counterJson.tran.print_no = value;
      case specBtnLvl4_2:       // 領収書発行番号
        counterJson.tran.receipt_no = value;
      case specBtnLvl4_7:       // 保証書発行番号
        counterJson.tran.guarantee_no = value;
      case specBtnLvl4_6:       // クレジット売上通番
        counterJson.tran.credit_no = value;
      case specBtnLvl4_9:       // 総合ＡＳＰ端末処理通番
        counterJson.tran.nttasp_credit_no = value;
      case specBtnLvl4_35:      // VEGAクレジット売上通番
        counterJson.tran.credit_no_vega = value;
      default:                  // その他
        throw AssertionError();
    }
  }

  /// クレジット仕様なら表示.
  Future<bool> _displayableCrdtNo() async {
    return await CmCksys.cmCrdtSystem() != 0;
  }
}
