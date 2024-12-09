/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../../inc/sys/tpr_ch_field.dart';
import '../../../../../inc/sys/tpr_dlg.dart';
import '../../../../../sys/mente/sio/sio01.dart';
import '../../../../../sys/mente/sio/sio02.dart';
import '../../../../../sys/mente/sio/sio_def.dart';
import '../../../../model/m_widgetsetting.dart';
import '../../../common/component/w_msgdialog.dart';
import '../component/w_savechangealertmsgdialog.dart';
import '../component/w_selection.dart';


/// SIO画面コントローラー
class SioController  extends GetxController{
  Sio01 sio01 = Get.put(Sio01());
  late Sio02 sio02;
  late Sio02 result;

  // UI側で表示する項目や設定値、設定種別などが含まれるリスト.
  final lstLblTxtsettings = [].obs;


  late RxList<Sio01BtnStat> btnStat = <Sio01BtnStat>[].obs;

  List<SelectValue> deviceSelectValueList = [];

  /// 画面のタイトル
  final String title;
  /// パンくずリストの文字列
  final String breadcrumb;

  /// コンストラクタ
  SioController({required this.title, required this.breadcrumb});

  ///初期化の完了を追跡
  final _initializationCompleter = Completer<void>();

  ///初期化処理.
  @override
  void onInit() {
    _initializeController();
  }

  ///初期化の重複呼び出す防止処理.
  Future<void> _initializeController() async {
    if (_initializationCompleter.isCompleted) {
      return _initializationCompleter.future;
    }
    try {
      bool result = await sio01.sio01Init();
      if (result) {
        btnStat = (sio01.btnStat).obs;
        createSioRow(btnStat);
        _initializationCompleter.complete();
      } else {
        throw Exception("Initialization failed.");
      }
    } catch (e) {
      _initializationCompleter.completeError(e);
    }
    return _initializationCompleter.future;
  }


  /// 項目一覧データを作成する.
  void createSioRow(List<Sio01BtnStat> btnStat) {
    for (int sioId = 0; sioId < sio01.btnStat.length; sioId++) {
      final element = sio01.btnStat[sioId];
      if (!element.sioOutput) {
        continue;
      }
      List<String> settings = [
        element.sio,
        element.baud,
        element.stopB,
        element.dataB,
        element.parity
      ];
      List<String> settingTypes = [
        "Sio",
        "Baud",
        "StopB",
        "DataB",
        "Parity",
      ];
      //　 SIO#id タイトル部分
      lstLblTxtsettings.add(
        SioLblTxtBtnSetting(
          axis: Axis.horizontal,
          lblsetting: SioLblSetting(
            showBoxDecoration: false,
            margin: const EdgeInsets.all(4),
            alignment: Alignment.centerLeft,
            text: 'SIO #${sioId + 1}',
          ).obs,
        ),
      );
      // SIO#ごとの設定項目.
      for (int j = 0; j < settings.length; j++) {
        if (settings[j] == '' ||
            (settingTypes[j] != "Sio" && !element.slvOutput)) {
          continue;
        }
        // 項目名\n値で帰ってくるため、項目名と値と２つに分離する.
        List<String> splitSetting = settings[j].split('\n');
        String firstPart = splitSetting[0];
        String secondPart = splitSetting.length > 1 ? splitSetting[1] : "";
        // 項目名
        SioLblTxtBtnSetting newSetting = SioLblTxtBtnSetting(
            axis: Axis.horizontal,
            lblsetting: SioLblSetting(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.centerLeft,
              text: firstPart,
            ).obs);

        if (splitSetting.length > 1) {
          // 値.
          newSetting.txtsetting = SioTxtSetting(
            alignment: Alignment.topLeft,
            text: secondPart,
          ).obs;
        }
        // リストのindex.
        int currentIndex = lstLblTxtsettings.length;
        newSetting.btnsetting = BtnSetting(onTap: () {
          // タップされたときの処理.
          // 選択画面に入る前に選択されていた項目.
          String initSelected;
          if (settingTypes[j] == "Sio") {
            // SIOにセットしている機器選択.
            initSelected = newSetting.lblsetting!.value.text;
          } else {
            // 機器の設定.
            initSelected = newSetting.txtsetting!.value.text;
          }
          // 選択画面に入る前に機器が選択されていたかどうか.
          bool preSlvOutput = element.slvOutput;
          //　選択画面表示.
          _showSelectPage(
              sioId, initSelected, settingTypes[j], currentIndex, preSlvOutput);
        }).obs;
        lstLblTxtsettings.add(newSetting);
      }
    }
  }

  /// 表示を更新する.
  void _refreshRow() {
    lstLblTxtsettings.value.clear();
    createSioRow(sio01.btnStat);
    lstLblTxtsettings.refresh();
  }

  /// 選択画面表示処理.
  void _showSelectPage(
      int sioId, initSelected, settingTypes, currentIndex, preSlvOutput) async {
    if (settingTypes == 'Sio') {
      Sio02 result = await sio01.sio01BtClicked(sioId);
      sioNavigateSelectPage(result, settingTypes, sioId, initSelected,
          currentIndex, preSlvOutput);
    } else {
      int initSelectedId = getInitSelectedId(initSelected, settingTypes);
      navigateSelectPage(settingTypes, sioId, initSelectedId, currentIndex);
    }
  }

  Future<void> saveChange() async {
    if (!sio01.sio01CompareTable()) {
      bool result = await sio01.sio01ConfirmClicked();
      if (result) {
        showSaveDialog(true);
      } else {
        showSaveDialog(
          false,
          errMsg: 'errmsg',
        );
      }
    }
  }

  /// 「メンテナンスを終了」ボタン、もしくは、戻るボタンを押したときの処理
  Future<bool> onEndMaintenancePage() async {
    if (!sio01.sio01CompareTable()) {
      bool? result = await Get.dialog(
        const SaveChangeAlertMsgDialog(
            msgList: ['設定の変更は保存されていません', 'ページを移動する前に設定を保存しますか？']),
      );
      if (result == true) {
        await saveChange();
      }
      return true;
    } else {
      return true;
    }
  }

  /// 保存ダイアログ表示処理.
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
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          //データの構成が異なります、保存データを確認してください
          dialogId: DlgConfirmMsgKind.MSG_DATA_DIFF_CONF.dlgId,
        ),
      );
    }
  }

  /// 接続端末変更後の孫メニューデータ取得処理.
  String? getKeyword(List<TprChTbl> table, int index) {
    if (index >= 0 && index < table.length) {
      return table[index].kyword;
    } else {
      return null;
    }
  }

  ///選択画面遷移処理.
  Future<void> navigateSelectPage(
    String settingTypes,
    int index,
    int initSelectedId,
    int currentIndex,
  ) async {
    if (settingTypes == 'Sio') {
      return;
    }
    var titleMap = {
      'Baud': 'ボーレート',
      'StopB': 'ストップビット',
      'DataB': 'レコード長',
      'Parity': 'パリティ',
    };
    List<String> itemList = getItemList(settingTypes);
    List<SelectValue> selectValueList = itemList
        .map((item) => SelectValue(
              name: item,
              selectId: itemList.indexOf(item),
            ))
        .toList();
    void handleSelectedCallback(SelectValue selected) {
      switch (settingTypes) {
        case 'Baud':
          sio01.sio01BaudClicked(index, selected.selectId);
          break;
        case 'StopB':
          sio01.sio01StopbitClicked(index, selected.selectId);
          break;
        case 'DataB':
          sio01.sio01DatabitClicked(index, selected.selectId);
          break;
        case 'Parity':
          sio01.sio01ParityClicked(index, selected.selectId);
      }
      _refreshRow();
    }

    await Get.to(() => SelectionPage(
      title: title,
      currentBreadcrumb: breadcrumb,
      settingName: titleMap[settingTypes]!,
      itemList: selectValueList,
      initSelectedId: initSelectedId,
      oncallback: handleSelectedCallback,
    ));
  }

  /// sio一覧画面遷移処理
  Future<void> sioNavigateSelectPage(
      Sio02 result,
      String settingTypes,
      int sioId,
      String initSelected,
      int currentIndex,
      bool preSlvOutput) async {
    var btnStat = result.btnStat;
    int initialIndex = btnStat.btnLbl.indexOf(initSelected);
    deviceSelectValueList = btnStat.btnLbl
        .asMap()
        .entries
        .map((item) => SelectValue(name: item.value, selectId: item.key))
        .toList();
    await Get.to(() => SelectionPage(
      title: title,
      currentBreadcrumb: breadcrumb,
      settingName: btnStat.titleLbl,
      itemList: deviceSelectValueList,
      initSelectedId: initialIndex,
      oncallback: (SelectValue selected) {
        if (selected.selectId == initialIndex) {
          // 選択が変わっていないなら何もしない.
          return;
        }
        result.sio02BtClicked(selected.selectId);
        _refreshRow();
      },
    ));
  }

  /// 初期値index取得.
  int getInitSelectedId(String initElementVal, String settingTypes) {
    var itemList = getItemList(settingTypes);
    return itemList.indexOf(initElementVal);
  }

  /// 孫メニューのItemList取得.
  List<String> getItemList(String settingTypes) {
    var itemListMap = {
      'Baud': SioDef.sioBaudTbl,
      'StopB': SioDef.sioStopbTbl,
      'DataB': SioDef.sioDatabTbl,
      'Parity': SioDef.sioPariTbl,
    };
    return itemListMap[settingTypes]!
        .where((item) => item.kyword != null)
        .map((item) => item.kyword!)
        .toList();
  }

}
