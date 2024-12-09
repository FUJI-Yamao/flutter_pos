/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../inc/sys/tpr_log.dart';
import '../../../../../sys/mente/spec/spec_sub_ret.dart';
import '../model/e_speckind.dart';
import '../model/m_specfile.dart';
import '../model/m_specfile_common.dart';
import '../model/m_widgetsetting.dart';
import 'c_specfile_controller.dart';


/// json管理されるスペックファイルのコントローラー
class SpecfileJsonController extends SpecfileControllerBase {

  /// コンストラクタ
  SpecfileJsonController(SpecKind dispSpecKind, {
    required super.title,
    required super.breadcrumb,
  }) {
    /// スペックファイルの表示項目と処理
    specRowDispCommon = SpecRowDispCommon.factory(dispSpecKind);
  }

  /// スペックファイルの表示項目と処理
  late SpecRowDispCommon specRowDispCommon;

  /// 行データと、現在設定されている値.
  Map<SpecFileDispRow,SettingData> specSubData = {};

  /// 変更があったアイテムのリスト.
  Set<SpecFileDispRow> changeDataList = {};


  /// 項目一覧データを作成する.
  @override
  Future<void> createRow() async {

    await _createDisplayableData();
    // 初期値データをセット.
    await _setIniData();
    int i = 0;
    for (var element in dispRowData) {
      await createLabelSettingData(element,  i);
      i++;
    }
  }

  @override
  dynamic getNowSettingValue(SpecFileDispRow element){
    return specSubData[element]!.after;
  }

  /// JSON → スペックファイル変数作成
  Future<void> _createDisplayableData() async {
    /// 行データを取得する.
    List<SpecFileDispRow> rowList = specRowDispCommon.rowList;
    for (var row in rowList) {
      if (row.displayableFunc != null ) {
        bool result = await row.displayableFunc!.call();
        if(!result){
          // 表示条件が定義されていて、その条件を満たしていないので飛ばす.
          continue;
        }
      }
      dispRowData.add(row);
    }
  }

  /// 初期値のデータを取得.
  Future<SpecSubRet> _setIniData() async {
    SpecSubRet initRet = SpecSubRet();

    // 変更フラグ初期化.
    changeDataList.clear();
    // 初期表示、jsonファイル読み取り
    try {
      /// 設定ファイルを読み込んで、表示項目毎の設定値を取得する
      specSubData = await specRowDispCommon.loadJsonData(dispRowData);
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "_setIniData(), $e,$s");
      initRet.retFlg = false;
      initRet.confirmMsg = DlgConfirmMsgKind.MSG_READERR;
      return initRet;
    }

    // 初期表示処理正常終了
    return initRet;
  }

  /// 変更チェック関数
  @override
  void afterChange(SpecFileDispRow row, String value) {
    // 変更後の値を更新
    specSubData[row]!.after = _getTypeData(row, value);
    if (specSubData[row]!.before != specSubData[row]!.after) {
      // データが最初jsonファイルから読み込んだ値と異なる
      changeDataList.add(row);
    } else {
      // データが最初jsonファイルから読み込んだ値と一致する
      changeDataList.remove(row);
    }
    isChangedFlg =  changeDataList.isNotEmpty;
  }

  /// 保存ボタンの処理.
  @override
  Future<void> saveChange({bool dspConfirmDlg = true}) async {
    if (!isChangedFlg) {
      // 変更なし.
      return;
    }

    // jsonへ保存.
    SpecSubRet ret = await _saveJson(specSubData);
    isChangedFlg = changeDataList.isNotEmpty;
    if (dspConfirmDlg) {
      showSaveDialog(ret.retFlg, errMsg: ret.confirmMsg.name);
    }
  }

  /// 保存ボタンの押下処理.
  /// 変更した値を設定ファイルに保存する.
  Future<SpecSubRet> _saveJson(Map<SpecFileDispRow, SettingData> specSubData) async {
    SpecSubRet setJsonRet = SpecSubRet();

    try {
      // 表示項目毎の設定値を、設定ファイルに保存する
      await specRowDispCommon.saveJsonData(specSubData);
      // 変更フラグ初期化.
      changeDataList.clear();
    } catch (e, s) {
      // ファイル書き込み中エラー発生
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "_saveJson(), $e,$s");
      setJsonRet.confirmMsg = DlgConfirmMsgKind.MSG_WRITEERR;
      setJsonRet.retFlg = false;
      return setJsonRet;
    }

    // 所持データを初期化.
    setJsonRet = await _setIniData();
    // 画面を再描画
    updateDispData(lstLblTxtsettings);

    return setJsonRet;
  }

  /// 表示用データを更新
  void updateDispData(RxList<dynamic> lstLblTxtsettings) {
    // 表示用データのループ
    for (var element in lstLblTxtsettings) {
      // dynamicなので型判別する
      if (element is LblTxtBtnSetting) {
        SpecFileDispRow? specFileDispRow = element.lblsetting?.value.specInfo;
        if (specFileDispRow != null) {
          // 画面に表示する文字列を取得する
          element.txtsetting?.value.text = getNowSettingValueString(specFileDispRow);
        }
      } else {
        // 想定外の型なので、エラーにする
        throw AssertionError();
      }
    }
    // 画面の再描画
    lstLblTxtsettings.refresh();
  }

  /// 表示上のStringデータから設定ファイルに対応する型の値を取得する.
  dynamic _getTypeData(SpecFileDispRow data, dynamic afterValue ) {

    switch(specSubData[data]!.before.runtimeType){
      case int:
        if(afterValue.runtimeType == int){
          return afterValue;
        }
        return  int.tryParse(afterValue) ?? 0;
      case String:
        if(afterValue.runtimeType == String){
          return afterValue;
        }
        return  afterValue.toString();
      default:
        return afterValue;
    }
  }
}
