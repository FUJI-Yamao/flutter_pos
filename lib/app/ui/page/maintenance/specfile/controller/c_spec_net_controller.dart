/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */


import '../../../../../sys/mente/spec/spec_net.dart';
import '../../../../../sys/mente/spec/spec_sub_ret.dart';
import '../model/m_specfile.dart';
import 'c_specfile_controller.dart';


/// スペックファイルコントローラー
class SpecfileNetController extends SpecfileControllerBase {
  SpecfileNetController({
    required super.title,
    required super.breadcrumb,
  });

  SpecNet data  = SpecNet();


  /// 項目一覧データを作成する.
  @override
  Future<void> createRow() async {

    //SpecSubRet initRet = SpecSubRet();
    // 初期値データをセット.
    SpecSubRet ret = await data.initialize();
    if(!ret.retFlg){
        return;
    }
    int i = 0;
    for (var element in SpecNetItems.values) {

      dynamic nowValue = getNowSettingValue(element.dispRow);
      if(nowValue == null){
        // 非表示の項目.
        continue;
      }

      dispRowData.add(element.dispRow);
      await createLabelSettingData(element.dispRow, i);
      i++;
    }

  }

  @override
  dynamic getNowSettingValue(SpecFileDispRow element){
    return  data.netWorkDataDef[SpecNetItems.getDefine(element )];
  }


  //変更チェック関数
  @override
  void afterChange(SpecFileDispRow row, String value) {
    SpecNetItems? key = SpecNetItems.getDefine(row);
    if(key == null){
      return;
    }
    data.inputClicked(SpecNetWorkData(key,value));
    isChangedFlg = data.existChangeData();
  }

  /// 保存ボタンの処理.
  @override
  Future<void> saveChange({bool dspConfirmDlg = true}) async {
    if (!isChangedFlg) {
      // 変更なし.
      return;
    }
     List<SpecNetWorkData> newValues = [];
    for (var element in lstLblTxtsettings) {
      SpecNetItems? key = SpecNetItems.getDefine(element.lblsetting.value.specInfo);
      if(key == null){
        continue;
      }
     dynamic newSettingValue = await getDispData4Setting(
          specInfo: element.lblsetting.value.specInfo, element: element);

      newValues.add(SpecNetWorkData(key,newSettingValue));
    }
    // 設定ファイルへ保存.
    SpecSubRet ret = await data.saveSettingFile(newValues);
    isChangedFlg = data.existChangeData();
    if (dspConfirmDlg) {
      showSaveDialog(ret.retFlg, errMsg: ret.confirmMsg.name);
    }
  }

}
