/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../../../../../common/cls_conf/speezaJsonFile.dart';
import '../../../../../../common/cls_conf/speeza_comJsonFile.dart';
import '../m_specfile.dart';
import '../m_specfile_common.dart';

/// Speeza設定画面の項目と処理
class SpeezaDisplayData extends SpecRowDispCommon {

  /// 表示項目
  static const String spIniParamChangeAmountType = 'SPINI_PARAM_CHANGEAMOUNTTYPE';                   // お釣あり取引時に指定キーを選択する
  static const String spIniParamQCSelectRprItemPrn = 'SPINI_PARAM_QCSELECTRPRITEMPRN';               // QC指定時の再発行で登録商品を印字
  static const String spIniParamChaTranSpeezaUpd = 'SPINI_PARAM_CHATRANSPEEZAUPD';                   // 小計額以上の会計・品券キー入力時に取引送信
  static const String spIniParamDispPrecaBalSht = 'SPINI_PARAM_DISP_PRECA_BAL_SHT';                  // 精算機で電子マネー残高不足時登録機に通知する
  static const String spIniParamQCStatusActiveSet = 'SPINI_PARAM_QCSTATUS_ACTIVE_SET';               // 自レジからのQC指定で取引中の表示
  static const String spIniParamQCStatusAnotherActiveSet = 'SPINI_PARAM_QCSTATUS_ANOTHERACTIVE_SET'; // 他レジからのQC指定で取引中の表示
  static const String spIniParamQCStatusCreateMaxSet = 'SPINI_PARAM_QCSTATUS_CREATE_MAX_SET';        // 受付制限数に到達した取引中の表示
  static const String spIniParamCautionACXErr = 'SPINI_PARAM_CAUTION_ACX_ERR';                       // 釣銭釣札機にエラーが発生の表示
  static const String spIniParamCautionACXEnd = 'SPINI_PARAM_CAUTION_ACX_END';                       // 保留枚数がニアエンド枚数より少ないの表示
  static const String spIniParamCautionACXFull = 'SPINI_PARAM_CAUTION_ACX_FULL';                     // 保留枚数がニアフル枚数より多いの表示
  static const String spIniParamCautionPrnEnd = 'SPINI_PARAM_CAUTION_PRN_END';                       // レシートがニアエンド状態(要設定・センサ)の表示
  static const String spIniParamConMacNo1 = 'SPINI_PARAM_CONMACNO1';                                 // QC指定：マシン番号
  static const String spIniParamConMacName1 = 'SPINI_PARAM_CONMACNAME1';                             // QC指定：名称：
  static const String spIniParamConMacColor1 = 'SPINI_PARAM_CONMACCOLOR1';                           // QC指定：プリセット色：
  static const String spIniParamConMacNo2 = 'SPINI_PARAM_CONMACNO2';                                 // QC指定：マシン番号
  static const String spIniParamConMacName2 = 'SPINI_PARAM_CONMACNAME2';                             // QC指定：名称：
  static const String spIniParamConMacColor2 = 'SPINI_PARAM_CONMACCOLOR2';                           // QC指定：プリセット色：
  static const String spIniParamConMacNo3 = 'SPINI_PARAM_CONMACNO3';                                 // QC指定：マシン番号
  static const String spIniParamConMacName3 = 'SPINI_PARAM_CONMACNAME3';                             // QC指定：名称：
  static const String spIniParamConMacColor3 = 'SPINI_PARAM_CONMACCOLOR3';                           // QC指定：プリセット色：

  /// プリセット色のリスト
  final List<SelectionSetting> presetColorList = [
    const SelectionSetting("201", 201),
    const SelectionSetting("202", 202),
    const SelectionSetting("203", 203),
    const SelectionSetting("204", 204),
    const SelectionSetting("205", 205),
    const SelectionSetting("206", 206),
    const SelectionSetting("207", 207),
    const SelectionSetting("208", 208),
    const SelectionSetting("209", 209),
    const SelectionSetting("210", 210),
    const SelectionSetting("211", 211),
    const SelectionSetting("212", 212),
  ];

  /// 表示項目のリスト
  @override
  List<SpecFileDispRow> get rowList => [
    const SpecFileDispRow(
      key: spIniParamChangeAmountType,
      title: 'お釣あり取引時に指定キーを選択する',
      description: "お釣あり取引時に指定キーを選択する\n  (QC指定キーを使用する場合のみ動作)\n  しない/する/拡大連動",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
        SelectionSetting("拡大運動", 2),
      ],
    ),
    const SpecFileDispRow(
      key: spIniParamQCSelectRprItemPrn,
      title: 'QC指定時の再発行で登録商品を印字',
      description: "QC指定時の再発行で登録商品を印字\n  しない/する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: spIniParamChaTranSpeezaUpd,
      title: '小計額以上の会計・品券キー入力時に取引送信',
      description: "小計額以上の会計・品券キー入力時に取引送信\n  する/しない/する(釣りあり)",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("する", 0),
        SelectionSetting("しない", 1),
        SelectionSetting("する(釣りあり)", 2),
      ],
    ),
    const SpecFileDispRow(
      key: spIniParamDispPrecaBalSht,
      title: '精算機で電子マネー残高不足時登録機に通知する',
      description: "精算機で電子マネー残高不足時登録機に通知する\n  しない/する",
      editKind: SpecFileEditKind.selection,
      setting: [
        SelectionSetting("しない", 0),
        SelectionSetting("する", 1),
      ],
    ),
    const SpecFileDispRow(
      key: spIniParamQCStatusActiveSet,
      title: '自レジからのQC指定で取引中の表示',
      description: "自レジからのQC指定で取引中の表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamQCStatusAnotherActiveSet,
      title: '他レジからのQC指定で取引中の表示',
      description: "他レジからのQC指定で取引中の表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamQCStatusCreateMaxSet,
      title: '受付制限数に到達した取引中の表示',
      description: "受付制限数に到達した取引中の表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamCautionACXErr,
      title: '釣銭釣札機にエラーが発生の表示',
      description: "釣銭釣札機にエラーが発生の表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamCautionACXEnd,
      title: '保留枚数がニアエンド枚数より少ないの表示',
      description: "保留枚数がニアエンド枚数より少ないの表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamCautionACXFull,
      title: '保留枚数がニアフル枚数より多いの表示',
      description: "保留枚数がニアフル枚数より多いの表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamCautionPrnEnd,
      title: 'レシートがニアエンド状態(要設定・センサ)の表示',
      description: "レシートがニアエンド状態(要設定・センサ)の表示",
      editKind: SpecFileEditKind.none,
      setting: null,
    ),
    const SpecFileDispRow(
      key: spIniParamConMacNo1,
      title: 'QC指定１：マシン番号',
      description: "マシン番号\n  (0の場合は使用不可)\n　０～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: spIniParamConMacName1,
      title: 'QC指定１：名称',
      description: "名称\n　０～９９",
      editKind: SpecFileEditKind.combinedNumInput,
      setting: NumInputSetting(0, 99),
    ),
    SpecFileDispRow(
      key: spIniParamConMacColor1,
      title: 'QC指定１：プリセット色',
      description: "プリセット色",
      editKind: SpecFileEditKind.presetColor,
      setting: presetColorList,
    ),
    const SpecFileDispRow(
      key: spIniParamConMacNo2,
      title: 'QC指定２：マシン番号',
      description: "マシン番号\n  (0の場合は使用不可)\n　０～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: spIniParamConMacName2,
      title: 'QC指定２：名称',
      description: "名称\n　０～９９",
      editKind: SpecFileEditKind.combinedNumInput,
      setting: NumInputSetting(0, 99),
    ),
    SpecFileDispRow(
      key: spIniParamConMacColor2,
      title: 'QC指定２：プリセット色',
      description: "プリセット色",
      editKind: SpecFileEditKind.presetColor,
      setting: presetColorList,
    ),
    const SpecFileDispRow(
      key: spIniParamConMacNo3,
      title: 'QC指定３：マシン番号',
      description: "マシン番号\n  (0の場合は使用不可)\n　０～９９９９９９",
      editKind: SpecFileEditKind.numInput,
      setting: NumInputSetting(0, 999999),
    ),
    const SpecFileDispRow(
      key: spIniParamConMacName3,
      title: 'QC指定３：名称',
      description: "名称\n　０～９９",
      editKind: SpecFileEditKind.combinedNumInput,
      setting: NumInputSetting(0, 99),
    ),
    SpecFileDispRow(
      key: spIniParamConMacColor3,
      title: 'QC指定３：プリセット色',
      description: "プリセット色",
      editKind: SpecFileEditKind.presetColor,
      setting: presetColorList,
    ),
  ];

  /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
  /// dispRowDataには、非表示項目は含まれない
  @override
  Future<Map<SpecFileDispRow, SettingData>> loadJsonData(List<SpecFileDispRow> dispRowData) async {
    // 表示項目と設定値の組み合わせ
    Map<SpecFileDispRow, SettingData> specSubData = {};

    // SpeezaJsonFileの読み込み
    SpeezaJsonFile speezaJsonFile = SpeezaJsonFile();
    await speezaJsonFile.load();
    // Speeza_comJsonFileの読み込み
    Speeza_comJsonFile speezaComJsonFile = Speeza_comJsonFile();
    await speezaComJsonFile.load();

    // 表示項目のループ
    for (var data in dispRowData) {
      // 設定ファイルから設定値を取得
      var value = _getJsonData(speezaJsonFile, speezaComJsonFile, data.key);
      specSubData[data] = SettingData(before: value, after: value);
    }

    return specSubData;
  }

  /// 表示項目毎の設定値を、設定ファイルに保存する
  @override
  Future<void> saveJsonData(Map<SpecFileDispRow, SettingData> specSubData) async {
    // SpeezaJsonFileの読み込み
    SpeezaJsonFile speezaJsonFile = SpeezaJsonFile();
    await speezaJsonFile.load();
    // Speeza_comJsonFileの読み込み
    Speeza_comJsonFile speezaComJsonFile = Speeza_comJsonFile();
    await speezaComJsonFile.load();

    for (var data in specSubData.keys) {
      // 設定ファイルに設定値を設定
      _setJsonData(speezaJsonFile, speezaComJsonFile, data.key, specSubData[data]!.after);
    }

    // SpeezaJsonFileへ保存
    await speezaJsonFile.save();
    // Speeza_comJsonFileへ保存
    await speezaComJsonFile.save();
  }

  /// 設定ファイルから設定値を取得
  dynamic _getJsonData(SpeezaJsonFile speezaJsonFile, Speeza_comJsonFile speezaComJsonFile, String key) {
    switch (key) {
      case spIniParamChangeAmountType:           // お釣あり取引時に指定キーを選択する
        return speezaComJsonFile.QcSelect.ChangeAmountType;
      case spIniParamQCSelectRprItemPrn:         // QC指定時の再発行で登録商品を印字
        return speezaComJsonFile.QcSelect.QCSel_Rpr_ItemPrn;
      case spIniParamChaTranSpeezaUpd:           // 小計額以上の会計・品券キー入力時に取引送信
        return speezaComJsonFile.QcSelect.ChaTranSpeezaUpd;
      case spIniParamDispPrecaBalSht:            // 精算機で電子マネー残高不足時登録機に通知する
        return speezaComJsonFile.QcSelect.Disp_Preca_Bal_Sht;
      case spIniParamQCStatusActiveSet:          // 自レジからのQC指定で取引中の表示
        return speezaComJsonFile.StatusActive.Message;
      case spIniParamQCStatusAnotherActiveSet:   // 他レジからのQC指定で取引中の表示
        return speezaComJsonFile.StatusAnotherActive.Message;
      case spIniParamQCStatusCreateMaxSet:       // 受付制限数に到達した取引中の表示
        return speezaComJsonFile.StatusCreateMax.Message;
      case spIniParamCautionACXErr:              // 釣銭釣札機にエラーが発生の表示
        return speezaComJsonFile.CautionAcxErr.Message;
      case spIniParamCautionACXEnd:              // 保留枚数がニアエンド枚数より少ないの表示
        return speezaComJsonFile.CautionAcxEnd.Message;
      case spIniParamCautionACXFull:             // 保留枚数がニアフル枚数より多いの表示
        return speezaComJsonFile.CautionAcxFull.Message;
      case spIniParamCautionPrnEnd:              // レシートがニアエンド状態(要設定・センサ)の表示
        return speezaComJsonFile.CautionRcptEnd.Message;
      case spIniParamConMacNo1:                  // QC指定1：マシン番号
        return speezaJsonFile.QcSelect.ConMacNo1;
      case spIniParamConMacName1:                // QC指定1：名称
        return speezaJsonFile.QcSelect.ConMacName1;
      case spIniParamConMacColor1:               // QC指定1：プリセット色
        return speezaJsonFile.QcSelect.ConColor1;
      case spIniParamConMacNo2:                  // QC指定2：マシン番号
        return speezaJsonFile.QcSelect.ConMacNo2;
      case spIniParamConMacName2:                // QC指定2：名称
        return speezaJsonFile.QcSelect.ConMacName2;
      case spIniParamConMacColor2:               // QC指定2：プリセット色
        return speezaJsonFile.QcSelect.ConColor2;
      case spIniParamConMacNo3:                  // QC指定3：マシン番号
        return speezaJsonFile.QcSelect.ConMacNo3;
      case spIniParamConMacName3:                // QC指定3：名称
        return speezaJsonFile.QcSelect.ConMacName3;
      case spIniParamConMacColor3:               // QC指定3：プリセット色
        return speezaJsonFile.QcSelect.ConColor3;
    }
  }

  /// 設定ファイルに設定値を設定
  void _setJsonData(SpeezaJsonFile speezaJsonFile, Speeza_comJsonFile speezaComJsonFile, String key, dynamic value) {
    switch (key) {
      case spIniParamChangeAmountType:           // お釣あり取引時に指定キーを選択する
        speezaComJsonFile.QcSelect.ChangeAmountType = value;
      case spIniParamQCSelectRprItemPrn:         // QC指定時の再発行で登録商品を印字
        speezaComJsonFile.QcSelect.QCSel_Rpr_ItemPrn = value;
      case spIniParamChaTranSpeezaUpd:           // 小計額以上の会計・品券キー入力時に取引送信
        speezaComJsonFile.QcSelect.ChaTranSpeezaUpd = value;
      case spIniParamDispPrecaBalSht:            // 精算機で電子マネー残高不足時登録機に通知する
        speezaComJsonFile.QcSelect.Disp_Preca_Bal_Sht = value;
      case spIniParamQCStatusActiveSet:          // 自レジからのQC指定で取引中の表示
        speezaComJsonFile.StatusActive.Message = value;
      case spIniParamQCStatusAnotherActiveSet:   // 他レジからのQC指定で取引中の表示
        speezaComJsonFile.StatusAnotherActive.Message = value;
      case spIniParamQCStatusCreateMaxSet:       // 受付制限数に到達した取引中の表示
        speezaComJsonFile.StatusCreateMax.Message = value;
      case spIniParamCautionACXErr:              // 釣銭釣札機にエラーが発生の表示
        speezaComJsonFile.CautionAcxErr.Message = value;
      case spIniParamCautionACXEnd:              // 保留枚数がニアエンド枚数より少ないの表示
        speezaComJsonFile.CautionAcxEnd.Message = value;
      case spIniParamCautionACXFull:             // 保留枚数がニアフル枚数より多いの表示
        speezaComJsonFile.CautionAcxFull.Message = value;
      case spIniParamCautionPrnEnd:              // レシートがニアエンド状態(要設定・センサ)の表示
        speezaComJsonFile.CautionRcptEnd.Message = value;
      case spIniParamConMacNo1:                  // QC指定1：マシン番号
        speezaJsonFile.QcSelect.ConMacNo1 = value;
      case spIniParamConMacName1:                // QC指定1：名称
        speezaJsonFile.QcSelect.ConMacName1 = value;
      case spIniParamConMacColor1:               // QC指定1：プリセット色
        speezaJsonFile.QcSelect.ConColor1 = value;
      case spIniParamConMacNo2:                  // QC指定2：マシン番号
        speezaJsonFile.QcSelect.ConMacNo2 = value;
      case spIniParamConMacName2:                // QC指定2：名称
        speezaJsonFile.QcSelect.ConMacName2 = value;
      case spIniParamConMacColor2:               // QC指定2：プリセット色
        speezaJsonFile.QcSelect.ConColor2 = value;
      case spIniParamConMacNo3:                  // QC指定3：マシン番号
        speezaJsonFile.QcSelect.ConMacNo3 = value;
      case spIniParamConMacName3:                // QC指定3：名称
        speezaJsonFile.QcSelect.ConMacName3 = value;
      case spIniParamConMacColor3:               // QC指定3：プリセット色
        speezaJsonFile.QcSelect.ConColor3 = value;
    }
  }
}
