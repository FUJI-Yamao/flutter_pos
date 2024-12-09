/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/lib/db_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../inc/apl/rxsys.dart';
import '../../../sys/usetup/freq/freq.dart';
import '../../../sys/usetup/freq/freq_tbl.dart';
import '../../../sys/word/aa/l_freq.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import 'controller/c_freq.dart';

/// ファイルリクエストページ
class FileRequestPage extends StatelessWidget {
  static const List<String> columnTitleList = ["項目", "テーブル名", "結果", "ステータス"];
  /// 選択項目のフォントサイズ
  static const double itemFontSize = BaseFont.font24px;

  FileRequestPage({super.key, int freqCallMode = 0}) {
      Freq.freqCallMode = freqCallMode;
  }

  /// 画面表示
  @override
  Widget build(BuildContext context) {
    FileRequestPageController con = Get.put(FileRequestPageController());
    return Scaffold(
      backgroundColor: BaseColor.storeOpenCloseBackColor,
      appBar: AppBar(
          leading: SoundIconButton(
            icon: const Icon(Icons.arrow_back,
                color: BaseColor.storeCloseFontColor, size: 30.0),
            // 戻るボタン
            onPressed: () {
              Get.back();
            },
            callFunc: '${runtimeType.toString()} ${con.pageTitle.value}',
          ),
          backgroundColor: BaseColor.storeOpenCloseBackColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Obx(() => Text(
                con.pageTitle.value,
                style: const TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  color: BaseColor.storeCloseFontColor,
                ),
              ))),
      body: GetBuilder(
        init: con,
        builder: (controller) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getContents(controller),
              getButtons(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget getContents(FileRequestPageController controller) {
    const double columnNameHeight = 50;
    return Expanded(
        child: Column(children: [
      Obx(() => Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.white),
          children: [
            // １行目のタイトル行
            TableRow(
              decoration: const BoxDecoration(
                color: BaseColor.maintainBaseColor,
              ),
              children: <Widget>[
                for (String title in columnTitleList)
                  Container(
                    height: columnNameHeight,
                    alignment: Alignment.center,
                    child: Text(title,
                        style: const TextStyle(
                          fontFamily: BaseFont.familyDefault,
                          color: BaseColor.storeOpenCloseWhiteColor,
                          fontSize: BaseFont.font20px,
                        )),
                  ),
              ],
            ),
            // 項目行
            ...getData(controller)
          ])),
      SizedBox(height: 10.h),
      Obx(() => Container(
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(controller.execStatus.value,
                style: const TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  fontSize: BaseFont.font24px,
                  color: BaseColor.maintainBaseColor,
                )),
          )),
    ]));
  }

  /// 項目行のListを返す.
  List<TableRow> getData(FileRequestPageController controller) {
    List<TableRow> dataWidget = []; // テーブル項目行
    List<Widget> tableWidget = []; // テーブル名リスト
    List<Widget> resultWidget = []; // 結果リスト
    List<Widget> statusWidget = []; // ステータスリスト
    String callFunc = 'getData';
    for (FReqGroupData data in controller.dispData) {
      tableWidget = [];
      resultWidget = [];
      statusWidget = [];
      dataWidget.add(TableRow(
        children: <Widget>[
          SoundElevatedButton(
              onPressed: () {
                _selectGroup(data.btData, !(data.btData.aFlg));
              },
            callFunc: '$callFunc ${data.name}',
              style: ElevatedButton.styleFrom(
                backgroundColor: data.btData.aFlg
                    ? BaseColor.GrdBdrButtonEndColor
                    : BaseColor.edgeBtnTenkeyColor,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: Text(data.name,
                  style: const TextStyle(
                    fontSize: itemFontSize,
                  )),
          ),
          // ボタン　同じグループを有効にする
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tableWidget,
          ), //テーブル名
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: resultWidget,
          ), // 結果
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: statusWidget,
          ), // ステータス
        ],
      ));

      addTableData(data, tableWidget, resultWidget, statusWidget);
    }
    return dataWidget;
  }

  void addTableData(FReqGroupData group, List<Widget> tableWidget,
      List<Widget> resultWidget, List<Widget> statusWidget) {
    String callFunc = 'addTableData';
    double height = 30;
    for (TDataTbl data in group.tableData) {
      // 各項目の高さをそろえる
      tableWidget.add(SoundTextButton(
          onPressed: () {
            _selectTable(data, !data.selFlg);
          },
          callFunc: '$callFunc ${data.tableName}',
          child: Container(
            height: height,
            alignment: Alignment.centerLeft,
            color: data.selFlg
                ? BaseColor.maintainSwitchOnColor
                : Colors.transparent,
            child: Text(data.tableName,
                style: const TextStyle(
                  fontFamily: BaseFont.familyDefault,
                  color: BaseColor.storeCloseBlack54Color,
                  fontSize: itemFontSize,
                )),
          )));
      resultWidget.add(Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Text(data.execFlg != 0 ? _getResultStr(data.result) :"",
            style: const TextStyle(
              fontFamily: BaseFont.familyDefault,
              color: BaseColor.storeCloseBlack54Color,
              fontSize: itemFontSize,
            )),
      ));
      statusWidget.add(Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: Text(data.status,
            style: const TextStyle(
              fontFamily: BaseFont.familyDefault,
              color: BaseColor.storeCloseBlack54Color,
              fontSize: itemFontSize,
            )),
      ));
    }
  }

  Widget getButtons(FileRequestPageController controller) {
    String callFunc = 'getButtons';
    double buttonAreaWidth = 80;
    return SizedBox(
        width: buttonAreaWidth,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            width: buttonAreaWidth,
            height: buttonAreaWidth,
            child: SoundElevatedButton(
              onPressed: _prev,
              callFunc: '$callFunc 前項',
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.storeCloseStartButtonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('前項',
                  style: TextStyle(
                      fontSize: 20, color: BaseColor.storeOpenCloseWhiteColor)),
            ),
          ),
          SizedBox(
            width: buttonAreaWidth,
            height: buttonAreaWidth,
            child: SoundElevatedButton(
              onPressed: _next,
              callFunc: '$callFunc 次項',
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.storeCloseStartButtonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('次項',
                  style: TextStyle(
                      fontSize: 20, color: BaseColor.storeOpenCloseWhiteColor)),
            ),
          ),
          SizedBox(
            height: buttonAreaWidth,
          ),
          SizedBox(
            width: buttonAreaWidth,
            height: buttonAreaWidth,
            child: Obx(
              () => SoundElevatedButton(
                  onPressed: _selectAll,
                  callFunc: '$callFunc ${(controller.allSelectFlg.value) ? '全部解除' : '全部選択'}',
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.allSelectFlg.value
                        ? BaseColor.GrdBdrButtonEndColor
                        : BaseColor.edgeBtnTenkeyColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text((controller.allSelectFlg.value) ? '全部解除' : '全部選択',
                      style: const TextStyle(
                        fontSize: 20,
                        color: BaseColor.storeOpenCloseWhiteColor,
                      ))),
            ),
          ),
          SizedBox(
            height: buttonAreaWidth,
          ),
          SizedBox(
            height: buttonAreaWidth,
          ),
          SizedBox(
            width: buttonAreaWidth,
            height: buttonAreaWidth,
            child: SoundElevatedButton(
              onPressed: _execFreq,
              callFunc: '$callFunc 実行',
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.storeCloseStartButtonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('実行',
                  style: TextStyle(
                      fontSize: 20, color: BaseColor.storeOpenCloseWhiteColor)),
            ),
          ),
        ]));
  }

  /// intの結果を表示用の文言に変換.
  String _getResultStr(int? result){
    if(result == null){
      return "";
    }
    if (Freq.freqCallMode == Rxsys.RXSYS_MSG_FINIT.id) { // ファイル初期化
      switch(result){
        case DbError.DB_SUCCESS:
        case DbError.DB_FILENOTEXISTERR:
          return  LFreq.SPEC_OK;
        case DbError.DB_SKIP:
          return  LFreq.MSG_SKIP;
        default:
          return  LFreq.SPEC_NG;
      }
    } else { // ファイルリクエスト
      switch(result){
        case DbError.DB_SUCCESS:
          return  LFreq.DISP_OK;
        case DbError.DB_SKIP  || DbError.DB_SKIP2  :
          return  LFreq.DISP_SKIP;
        default:
          return  LFreq.DISP_NG;
      }
    }

  }

  /// 前項へ
  void _prev() {
    Freq.freqPrevious();
  }
  /// 次項へ
  void _next() {
    Freq.freqNext();
  }

  /// テーブルを選択した時の処理.
  void _selectTable(tblData tblData, bool select) {
    Freq.freqSelectTable(tblData, select);
  }

  /// グループを選択した時の処理
  void _selectGroup(btData btData, bool select) {
    Freq.freqSelectGroup(btData, select, allCheck: true);
  }

  /// 全選択を押したときの処理.
  void _selectAll() {
    Freq.freqSelectAll();
  }

  /// 実行を押したときの処理.
  Future<void> _execFreq() async {
    Freq.freqExecute();
  }
}
