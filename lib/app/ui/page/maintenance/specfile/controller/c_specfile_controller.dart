/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../common/cmn_sysfunc.dart';
import '../../../../../inc/apl/rxmem_define.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../inc/sys/tpr_log.dart';
import '../../../../enum/e_presetcd.dart';
import '../../../common/component/w_msgdialog.dart';
import '../component/w_description.dart';
import '../component/w_ipaddress.dart';
import '../component/w_preset_color_selection.dart';
import '../component/w_recogkeytenkey_layout.dart';
import '../component/w_savechangealertmsgdialog.dart';
import '../component/w_selection.dart';
import '../component/w_tenkeydialog.dart';
import '../component/w_urldialog.dart';
import '../model/m_specfile.dart';
import '../model/m_widgetsetting.dart';

/// スペックファイルコントローラー
abstract class SpecfileControllerBase extends GetxController {
  SpecfileControllerBase({
    required this.title,
    required this.breadcrumb,
  });

  /// タイトル
  final String title;

  /// パンくずリストの文字列
  final String breadcrumb;

  /// UI側で表示する項目や設定値、設定種別などが含まれるリスト.
  final lstLblTxtsettings = [].obs;

  /// 表示する行データ.
  List<SpecFileDispRow> dispRowData = [];

  /// 変更があったらtrue
  bool isChangedFlg = false;

  /// 全角と半角を変換するマップ
  final Map<String, String> _fullWidthAndHalfWidth = {
    '０': '0',
    '１': '1',
    '２': '2',
    '３': '3',
    '４': '4',
    '５': '5',
    '６': '6',
    '７': '7',
    '８': '8',
    '９': '9',
  };

  /// 項目一覧データを作成する.
  Future<void> createRow();

  /// 現在保存されている設定値を取得する.
  dynamic getNowSettingValue(SpecFileDispRow element);

  /// 変更チェック関数
  void afterChange(SpecFileDispRow row, String value);

  /// 保存ボタンの処理.
  Future<void> saveChange({bool dspConfirmDlg = true});

  @override
  void onReady() {
    createRow();
  }

  /// UI表示用のデータを作成する.
  Future<void> createLabelSettingData(SpecFileDispRow element, int index) async {
    // 画面に表示する文字列を取得する
    String dispValue = getNowSettingValueString(element);

    // リストからの選択画面ではなく、switchによる切り替えを行う場合.
    if (element.editKind == SpecFileEditKind.selection &&
        changeSwitch(element.setting)) {
      // int setting =
      //     min(int.tryParse(nowValue) ?? 0, element.setting.length - 1);
      // SwitchSetting swSetting = SwitchSetting(
      //   offText: element.setting[0],
      //   onText: element.setting[1],
      //   onTap: onTap(i, element),
      // );
      // swSetting.isSwitchedOn.value = setting == 1 ? true : false;
      // swSetting.switched.value = element.setting[setting];
      //
      // lstLblTxtsettings.add(
      //   LblSwitchSetting(
      //     axis: Axis.horizontal.obs,
      //     lblsetting: SpecFileLblSetting(
      //       specInfo: element,
      //       margin: const EdgeInsets.all(4),
      //       alignment: Alignment.centerLeft,
      //       text: element.title,
      //       onTap: () => Get.dialog(
      //         DiscriptionDialog(discription: element.description),
      //       ),
      //     ).obs,
      //     switchsetting: swSetting,
      //     containsSwitch: true,
      //   ),
      // );
      // lstLblTxtsettings.refresh();
    } else if (element.editKind == SpecFileEditKind.presetGroupCode) {
      String dbText = "";
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        dbText = await getDBResult(dispValue);
        lstLblTxtsettings[index].txtsetting.value.dbText = dbText;
        lstLblTxtsettings.refresh();
      });
      lstLblTxtsettings.add(
        LblTxtBtnSetting(
          axis: Axis.horizontal.obs,
          lblsetting: SpecFileLblSetting(
            specInfo: element,
            margin: const EdgeInsets.all(4),
            alignment: Alignment.centerLeft,
            text: element.title,
            onTap: () => Get.dialog(
              DiscriptionDialog(discription: element.description),
            ),
          ).obs,
          txtsetting: SpecFileTxtSetting2(
            alignment: Alignment.topLeft,
            text: dispValue,
            onTap: onChangeValue(index, element),
            dbText: dbText,
          ).obs,
          btnsetting: SpecFileBtnSetting(
            onTap: onChangeValue(index, element),
          ).obs,
          containsSwitch: false,
        ),
      );
      lstLblTxtsettings.refresh();
    } else {
      lstLblTxtsettings.add(
        LblTxtBtnSetting(
          axis: Axis.horizontal.obs,
          lblsetting: SpecFileLblSetting(
            specInfo: element,
            margin: const EdgeInsets.all(4),
            alignment: Alignment.centerLeft,
            text: element.title,
            onTap: () => Get.dialog(
              DiscriptionDialog(discription: element.description),
            ),
          ).obs,
          txtsetting: SpecFileTxtSetting(
            alignment: Alignment.topLeft,
            text: dispValue,
            onTap: element.editKind == SpecFileEditKind.none
                ? null
                : onChangeValue(index, element),
          ).obs,
          btnsetting: element.editKind == SpecFileEditKind.none
              ? null
              : SpecFileBtnSetting(
                  onTap: onChangeValue(index, element),
                ).obs,
          containsSwitch: false,
        ),
      );
      lstLblTxtsettings.refresh();
    }
  }

  /// DBを読み込んだ値を取得する
  Future<String> getDBResult(String dispValue) async {
    String kyName = '';

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "getDBResult() rxMemRead RXMEM_COMMON get error");
      return kyName;
    }
    RxCommonBuf pCom = xRet.object;

    String selectSql = """
        SELECT ky_name
        FROM public.c_preset_mst
        WHERE comp_cd = @p1 AND stre_cd = @p2 AND preset_grp_cd = @p3 AND preset_cd = @p4;
      """;
    Map<String, dynamic>? subValues = {
      "p1" : pCom.dbRegCtrl.compCd,
      "p2" : pCom.dbRegCtrl.streCd,
      "p3" : dispValue,
      "p4" : 9999,
    };
    try {
      // DBのインスタンスを取得
      DbManipulationPs db = DbManipulationPs();
      // DBから値を取得
      Result result = await db.dbCon.execute(Sql.named(selectSql),parameters:subValues);
      if (result.isEmpty) {
        // データがない場合は、ログを出力する
        TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "non exist data [$selectSql]");
      } else {
        Map<String, dynamic> data = result[0].toColumnMap();
        // 取得したデータの文字列が空でないときのみ、()を付けて返す
        if (data["ky_name"] != "") {
          kyName = data["ky_name"];
          return "\n($kyName)";
        }
      }
    } catch (e, s) {
      // DB読込エラー
      TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "db error [$selectSql]\n$e \n$s");
    }
    return kyName;
  }

  /// 画面に表示する文字列を取得する
  String getNowSettingValueString(SpecFileDispRow element) {
    String dispValue = "";
    dynamic nowValue = getNowSettingValue(element);
    if (element.editKind == SpecFileEditKind.selection) {
      List<SelectionSetting> editSetting = element.setting;
      for (var data in editSetting) {
        if (data.settingValue == nowValue) {
          dispValue = data.dispValue;
          break;
        }
      }
    } else {
      dispValue = nowValue.toString();
      if (element.editKind == SpecFileEditKind.PLUCode) {
        dispValue = dispValue.padLeft(13, "0");
      }
    }

    return dispValue;
  }

  /// オンタップ時の設定画面表示（ダイアログからページに変更予定）
  Function() onChangeValue(int idx, SpecFileDispRow element) {
    return () async {
      // 設定変更が可能かどうか.
      if (element.configurableFunc != null) {
        final (bool isConfigurable, String reason) =
            await element.configurableFunc!();
        if (!isConfigurable) {
          // 値を変更できないのでダイアログを出して終了.
          MsgDialog.show(
          //todo ダイアログメッセージ確定出来たらdialogKindを追加
            MsgDialog.singleButtonMsg(
              type: MsgDialogType.error,
              message: reason,
            ),
          );
          return;
        }
      }

      // 設定方式ごとに設定画面を表示する.
      if (element.editKind == SpecFileEditKind.numInput) {
        String? strRtn = await goToTenkey(
          initValue: lstLblTxtsettings[idx].txtsetting.value.text,
          element: element,
        );
        if (strRtn != null) {
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn;
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.presetGroupCode) {
        String? strRtn = await goToTenkey(
          initValue: lstLblTxtsettings[idx].txtsetting.value.text,
          element: element,
        );
        if (strRtn != null) {
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn;
          lstLblTxtsettings[idx].txtsetting.value.dbText = await getDBResult(strRtn);
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.PLUCode) {
        String? strRtn = await goToTenkey(
          initValue: int.tryParse(lstLblTxtsettings[idx].txtsetting.value.text)!.toString(),
          element: element,
        );
        if (strRtn != null) {
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn.padLeft(13, "0");
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.combinedNumInput) {
        String textPart = "";
        String numPart = "";
        // 文字列を後ろから前に見る
        for (int i = lstLblTxtsettings[idx].txtsetting.value.text.length - 1; i >= 0; i--) {
          String char = lstLblTxtsettings[idx].txtsetting.value.text[i];
          // 抜き出した文字が数字かどうか
          if (_fullWidthAndHalfWidth.containsKey(char)) {
            // mapの全角から半角にして、数字に追加
            numPart = _fullWidthAndHalfWidth[char]! + numPart;
          } else {
            // 数字でない文字が見つかったらそれ以降は文字部分と判断
            textPart = lstLblTxtsettings[idx].txtsetting.value.text.substring(0, i + 1);
            break;
          }
        }
        if (textPart.isEmpty) {
          textPart = "精算機";
        }
        if (numPart.length > 2) {
          numPart = "";
        }
        // テンキーダイアログに遷移し、その結果をnull許容の変数に代入
        String? strRtn = await goToTenkey(
          initValue: numPart,
          element: element,
          combineTextPart: textPart,
        );
        // テンキーダイアログの返り値がnullでなかった時
        if (strRtn != null) {
          // 文字と数字を連結する
          strRtn = combineTextAndNum(element, textPart, strRtn);
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn;
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.ipAddressInput) {
        IpAddressInputSetting editSetting = element.setting;
        String? strRtn = await Get.to(() => IpaddressInputWidget(
          title: title,
          currentBreadcrumb: breadcrumb,
          settingName: element.title,
          setting: editSetting,
          initValue:
          lstLblTxtsettings[idx].txtsetting.value.text.split('.'),
        ));
        if (strRtn != null) {
          afterChange(element, strRtn);
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn;
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.hexInput) {
        StringInputSetting editSetting = element.setting;
        String? strRtn = await Get.to(() => RecogkeyTenkeyDialog(
          title: title,
          currentBreadcrumb: breadcrumb,
          settingName: element.title,
          setting: editSetting,
          initValue: "", // 文字削除キーがないので空っぽの状態で開く
        ));
        if (strRtn != null) {
          afterChange(element, strRtn);
          lstLblTxtsettings[idx].txtsetting.value.text = strRtn;
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      } else if (element.editKind == SpecFileEditKind.selection) {
        List<SelectionSetting> editSetting = element.setting;
        List<SelectValue> itemList = [];
        dynamic selectedSettingValue;
        for (int index = 0; index < editSetting.length; index++) {
          SelectionSetting row = editSetting[index];
          if (row.displayableFunc != null && !(await row.displayableFunc!())) {
            continue;
          }
          itemList.add(
              SelectValue(name: row.dispValue, selectId: row.settingValue));
          if (lstLblTxtsettings[idx].txtsetting.value.text == row.dispValue) {
            // 表示と一致する選択肢を選択済みとする.
            selectedSettingValue = row.settingValue;
          }
        }
        if (itemList.isEmpty) {
          return;
        }
        // selectedSettingValueがnullだった場合、itemListの先頭のselectIdを代入する。
        selectedSettingValue ??= itemList.first.selectId;
        await Get.to(() => SelectionPage(
          title: title,
          currentBreadcrumb: breadcrumb,
          settingName: element.title,
          itemList: itemList,
          initSelectedId: selectedSettingValue,
          oncallback: (SelectValue selected) {
            afterChange(element, selected.selectId.toString());
            lstLblTxtsettings[idx].txtsetting.value.text = selected.name;
            lstLblTxtsettings[idx].txtsetting.refresh();
          },
        ));
      } else if (element.editKind == SpecFileEditKind.presetColor) {
        List<SelectionSetting> editSetting = element.setting;
        List<PresetColorSelectValue> itemList = [];
        int selectedSettingValue = editSetting.first.settingValue;
        for (int index = 0; index < editSetting.length; index++) {
          SelectionSetting row = editSetting[index];
          if (row.displayableFunc != null && !(await row.displayableFunc!())) {
            continue;
          }
          itemList.add(
              PresetColorSelectValue(name: row.dispValue, selectId: row.settingValue));
          if (lstLblTxtsettings[idx].txtsetting.value.text == row.dispValue) {
            // 表示と一致する選択肢を選択済みとする.
            selectedSettingValue = row.settingValue;
          }
        }
        if (itemList.isEmpty) {
          return;
        }
        await Get.to(() => PresetColorSelectionPage(
          title: title,
          currentBreadcrumb: breadcrumb,
          settingName: element.title,
          itemList: itemList,
          initSelectedId: selectedSettingValue,
          oncallback: (PresetColorSelectValue selected) {
            afterChange(element, selected.selectId.toString());
            lstLblTxtsettings[idx].txtsetting.value.text = selected.name;
            lstLblTxtsettings[idx].txtsetting.value.backcolor = PresetCd.getBtnColor(selected.selectId);
            lstLblTxtsettings[idx].txtsetting.refresh();
          },
        ));
      } else if (element.editKind == SpecFileEditKind.stringInput) {
        StringInputSetting editSetting = element.setting;
        String? urlStr = await Get.to(() => UrlDialog(
          title: title,
          currentBreadcrumb: breadcrumb,
          text: element.title,
          setting: editSetting,
          initValue: lstLblTxtsettings[idx].txtsetting.value.text ?? "",
          isShow: false,
        ));
        if (urlStr != null) {
          afterChange(element, urlStr);
          lstLblTxtsettings[idx].txtsetting.value.text = urlStr;
          lstLblTxtsettings[idx].txtsetting.refresh();
        }
      }
    };
  }

  /// テンキー画面に遷移し、入力された値を取得する
  Future<String?> goToTenkey({
    required String initValue,
    required SpecFileDispRow element,
    String? combineTextPart,
  }) async {
    NumInputSetting editSetting = element.setting;
    return await Get.to(() => TenkeyDialog(
      title: title,
      currentBreadcrumb: breadcrumb,
      settingName: element.title,
      setting: editSetting,
      initValue: initValue,
      oncallback: (value) {
        if (combineTextPart != null) {
          value = combineTextAndNum(element, combineTextPart, value);
        }
        afterChange(element, value);
      },
    ));
  }

  /// 文字と数字を連結する
  String combineTextAndNum(SpecFileDispRow element, String textPart, String numPart) {
    String afterNum = "";
    // 文字列を後ろから前に見る
    for (int i = numPart.length - 1; i >= 0; i--) {
      String char = numPart[i];
      // 数字かどうか
      if (_fullWidthAndHalfWidth.containsValue(char)) {
        // mapの半角から全角にして、数字に追加
        afterNum = _fullWidthAndHalfWidth.entries.firstWhereOrNull((element) => element.value == char)!.key + afterNum;
      }
    }
    return "$textPart$afterNum";
  }

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  Future<bool> onEndMaintenancePage() async {
    if (isChangedFlg) {
      //flg trueなら、<-押すと、メッセージボックス作成
      bool? saveBack = await Get.dialog(
        const SaveChangeAlertMsgDialog(
            msgList: ['設定の変更は保存されていません', 'ページを移動する前に設定を保存しますか？']),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.3),
      );
      if (saveBack == null) {
        // 編集画面に戻る
        return false;
      } else if (saveBack) {
        // 保存して移動ボタンを押した.
        await saveChange(dspConfirmDlg: false);
        return true;
      } else {
        // 保存しないで移動
        return true;
      }
    } else {
      return true;
    }
  }

  /// 保存ダイアログ.
  void showSaveDialog(bool success, {String errMsg = ""}) {
    if (success) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.info,
          dialogId: DlgConfirmMsgKind.MSG_SAVE_COMPLETE.dlgId,
        ),
      );

    } else {
      // 失敗した.
      //todo ダイアログメッセージ確定出来たらdialogKindを追加
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: errMsg,
        ),
      );
    }
  }

  /// 選択画面ではなく、switchで設定を行うかどうかの判定.
  /// 今は一律選択画面のため、常にfalse.
  bool changeSwitch(List<SelectionSetting> list) {
    return false;
  }

  // 画面上に表示されているデータを保存する形式に変換して取得
  Future<dynamic> getDispData4Setting({
    required SpecFileDispRow specInfo,
    required dynamic element,
  }) async {
    dynamic afterValue = "";
    if (specInfo.editKind == SpecFileEditKind.selection) {
      List<SelectionSetting> editSetting = specInfo.setting;
      for (var data in editSetting) {
        if (data.dispValue == element.txtsetting.value.text) {
          afterValue = data.settingValue;
        }
      }
    } else {
      afterValue = element.txtsetting.value.text;
    }
    return afterValue;
  }
}
