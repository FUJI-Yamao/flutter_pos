/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../backend/history/hist_main.dart';
import '../../../../common/cls_conf/counterJsonFile.dart';
import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../inc/sys/tpr_stat.dart';
import '../../../../lib/apllib/rm_ini_read.dart';
import '../../../../sys/stropncls/rmstcom.dart';
import '../../../../sys/stropncls/rmstopn.dart';
import '../../../menu/register/enum/e_register_page.dart';
import '../../common/component/w_msgdialog.dart';

/// 開設画面のコントローラー
class StoreOpenPageController extends GetxController {
  /// 現在の時間を表すObservable文字列
  final nowTime = ''.obs;
  /// 現在の日付を表すObservable文字列
  final nowDate = ''.obs;
  /// 過去の日付を表すObservable文字列DropdownButtonFormFieldのため
  final pastDate = ''.obs;
  /// 未来の日付を表すObservable文字列DropdownButtonFormFieldのため
  final futureDate = ''.obs;
  /// 前回精算日を表すObservable文字列
  final Rx<String> _lastsaleDate = "".obs;
  /// 選択された日付を表すObservable文字列
  final selectedValue = ''.obs;
  /// 前回精算日を表すObservable文字列
  String get lastsaleDate => _lastsaleDate.value;


  /// open store method 定義
  Future<CalcResultStore> openStore(CalcRequestStore para) async {
    CalcResultStore result = CalcResultStore(
        retSts: 0, errMsg: null, saleDate: null, forcedClose: null);
    debugPrint('Calling openStore API with parameters: $para');
    return result;
  }
  /// open staff method 定義
  Future<CalcResultStaff> openStaff(CalcRequestStaff para) async {
    CalcResultStaff result = CalcResultStaff(
        retSts: 0,errMsg: null,posErrCd: null,staffCd: null,staffName: null,menuAuthNotCodeList: null,keyAuthNotCodeList: null);
    debugPrint('Calling getStaff API with parameters: $para');
    return result;
  }

  /// windowsの場合の精算処理
  Future<CalcResultStore> openStoreWindows(CalcRequestStore requestData) async {
    return CalcResultStore(
        retSts: 0, errMsg: null, saleDate: null, forcedClose: null);
  }
  /// windowsの場合の従業員処理
  Future<CalcResultStaff> openStaffWindows(CalcRequestStaff requestDataStaff) async {
    return CalcResultStaff(
        retSts: 0,errMsg: null,posErrCd: null,staffCd: null,staffName: null,menuAuthNotCodeList: null,keyAuthNotCodeList: null);
  }
  @override
  void onInit() async {
    onTimerForOpen();
    initializeDateFormatting('ja_JP');// 日本語化
    _onTimer();
    Timer.periodic(const Duration(seconds: 1), (timer) => _onTimer());
    selectedValue.value = nowDate.value;
    super.onInit();
    late CounterJsonFile counterJson;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      await counterJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
    }
    String formattedLastSaleDate = counterJson.tran.last_sale_date;

    if (formattedLastSaleDate.isNotEmpty && formattedLastSaleDate != '0000-00-00') {
      DateTime lastSaleDateTime = DateTime.parse(formattedLastSaleDate);
      _lastsaleDate.value = DateFormat('yyyy-MM-dd (E)', 'ja_JP').format(lastSaleDateTime);
    }

    await Rmstopn.updateRetryGet();

    /// バックグラウンドの履歴ログ取得停止
    HistConsole().sendHistStop();

    /// 履歴ログの最新情報取得.
    await Rmstopn.macNoChk();

    /// バックグラウンドの履歴ログ取得再開
    HistConsole().sendHistReStart();

    // TODO:10152 履歴ログ 引数突貫
    HistConsole().sendSysNotify(TprStatDef.TPRTST_IDLE);
  }


  /// 現在時間表示
  void _onTimer() {
    DateTime nowDateTime = DateTime.now();
    nowTime.value = DateFormat('yyyy/MM/dd(E) HH:mm', 'ja_JP').format(nowDateTime);
  }

  /// 日付選択時の処理
  void onTimerForOpen() {
    initializeDateFormatting('ja_JP');
    DateTime nowDateTime = DateTime.now();
    DateTime pastDateTime = nowDateTime.subtract(const Duration(days: 1));
    DateTime futureDateTime = nowDateTime.add(const Duration(days: 1));
    nowDate.value = DateFormat('yyyy-MM-dd (E)', 'ja_JP').format(nowDateTime);
    pastDate.value = DateFormat('yyyy-MM-dd (E)', 'ja_JP').format(pastDateTime);
    futureDate.value = DateFormat('yyyy-MM-dd (E)', 'ja_JP').format(futureDateTime);
  }

  /// 日付選択時の処理
  Future<void> onPressedSelectDate(String selectedValue ) async{
    this.selectedValue.value = selectedValue;
  }

  /// 実行ボタン押下の処理
  Future<void> onPressedStoreOpen() async {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late CounterJsonFile counterJson;
    late Mac_infoJsonFile macinfoJson;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      macinfoJson = Mac_infoJsonFile();
      await counterJson.load();
      await macinfoJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
      macinfoJson = pCom.iniMacInfo;
    }

    String formattedDate = selectedValue.value.split(' ')[0];

    if (counterJson.tran.last_sale_date != '0000-00-00' || counterJson.tran.last_sale_date.isNotEmpty ) {
      DateTime saleDateTime = DateTime.parse(formattedDate);
      DateTime lastSaleDateTime = DateTime.parse(counterJson.tran.last_sale_date);
      int comparisonResult = saleDateTime.compareTo(lastSaleDateTime);
      String saledateDay = saleDateTime.day.toString().padLeft(2, '0');

      if (comparisonResult > 0) {
        storeOpenProcessingDialog();
        await Rmstcom.rmstDailyClear(formattedDate, saledateDay);
        await openStoreStart(counterJson, formattedDate, false);
      } else if (comparisonResult == 0){
        sameDateErrorDialog(formattedDate, counterJson);
      } else {
        lastDateErrorDialog();
        return;
      }
    } else {
      storeOpenProcessingDialog();
      await openStoreStart(counterJson, formattedDate, true);
    }
  }

  /// 開設中止ボタン押下の処理
  void onPressedSkipStoreOpen() {
    // 開設処理をしないで、メインメニューに遷移する
    Get.offNamed(RegisterPage.mainMenu.routeName);
  }

  /// storeOpenのAPIコール
  Future<void> storeOpenProc(bool storeAgain) async
  {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late CounterJsonFile counterJson;
    late Mac_infoJsonFile macinfoJson;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      macinfoJson = Mac_infoJsonFile();
      await counterJson.load();
      await macinfoJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
      macinfoJson = pCom.iniMacInfo;
    }

    CalcRequestStore requestData = CalcRequestStore(
      compCd: macinfoJson.system.crpno,     // 会社コード
      streCd: macinfoJson.system.shpno,     // 店舗コード
      macNo: macinfoJson.system.macno,      // 端末番号
      saleDate: counterJson.tran.sale_date, // 精算日
      again: storeAgain?1:0,
    );
    try {
      // API コール
      CalcResultStore result;

      if (Platform.isWindows) {
        result = await openStoreWindows(requestData);

      } else {
        result = await CalcApi.openStore(requestData);
      }
      if (result.retSts != null && result.retSts == 0) {
        debugPrint("open Store API ok");
      }else {
        debugPrint('open Store API fail: ${result.errMsg}');
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "onPressedStoreOpen() : $e $s");
    } finally {}
  }

  /// staffOpenのAPIコール
  Future<void> openStaffProc() async
  {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    late CounterJsonFile counterJson;
    late Mac_infoJsonFile macinfoJson;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      macinfoJson = Mac_infoJsonFile();
      await counterJson.load();
      await macinfoJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
      macinfoJson = pCom.iniMacInfo;
    }

    CalcRequestStaff requestDataStaff = CalcRequestStaff(
      compCd: macinfoJson.system.crpno,     // 会社コード
      streCd: macinfoJson.system.shpno,     // 店舗コード
      macNo: macinfoJson.system.macno,      // 端末番号
      staffCd: "999999",
      passwd: "12345678",
      scanFlag: 0,
    );
    try {
      // API コール
      CalcResultStaff result;

      if (Platform.isWindows) {
        result = await openStaffWindows(requestDataStaff);
      } else {
        result = await CalcApi.openStaff(requestDataStaff);
      }
      if (result.retSts != null && result.retSts == 0) {
        debugPrint("open Staff API ok");
      }else {
        debugPrint('open Staff API fail: ${result.errMsg}');
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error,
          "onPressedStoreOpen() : $e $s");
    } finally {}
  }

  /// 共有メモリーに保存
  Future<void> openStoreMemory() async {
    RmIniRead read = RmIniRead();
    await read.rmIniCounterRead();
  }

  /// 営業日の保存、精算処理、スタッフ情報取得、共有メモリーに保存
  Future<void> openStoreStart(CounterJsonFile counterJson, String formattedDate, bool isFirstSale) async {
    counterJson.tran.sale_date = formattedDate;
    var save = counterJson.save();
    await save;
    await storeOpenProc(isFirstSale);
    await openStaffProc();
    await openStoreMemory();
    while (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.offNamed(RegisterPage.mainMenu.routeName);
  }

  /// 過去の営業日のダイアログ表示
  void lastDateErrorDialog(){
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_SALEDATE_ERR2.dlgId,
      ),
    );
  }

  /// 同一営業日のダイアログ表示
  void sameDateErrorDialog(String formattedDate, CounterJsonFile counterJson) {
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_SAME_SALE_DATE_ERR.dlgId,
        rightBtnFnc:() {
          storeOpenProcessingDialog();
          openStoreStart(counterJson, formattedDate, true);
        },
        rightBtnTxt: 'はい',
        leftBtnTxt: 'いいえ',
      ),
    );
  }

  /// 開設処理中のダイアログ表示
  void storeOpenProcessingDialog() {
    MsgDialog.show(
      MsgDialog.noButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_OPENTRAN.dlgId,
      ),
    );
  }

}

