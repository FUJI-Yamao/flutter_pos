/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:progress_state_button/progress_button.dart";

import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../sys/stropncls/rmstcls.dart';
import '../../../sys/stropncls/rmstcom.dart';
import '../../../sys/syst/sys_main.dart';
import '../../../lib/apl_db/db_vacuum.dart';
import '../../../lib/apllib/TmnEj_Make.dart';
import '../../colorfont/c_basecolor.dart';
import '../../component/w_ignore_scrollbar.dart';
import '../../component/w_sound_buttons.dart';
import '../common/component/w_msgdialog.dart';
import 'controller/c_store_close_page.dart';

/// 精算画面
class StoreClosePage extends StatefulWidget {
  const StoreClosePage({super.key});
  @override
  StoreClosePageState createState() => StoreClosePageState();
}
/// label of each button(閉設処理のボタン処理)
class StoreClosePageState extends State<StoreClosePage>{

  late List<ButtonState> buttonStates;
  int _currentIndex = 0;          // 0から始まる
  bool _isAutoRunning = false;    // 自動実行中かどうか
  Timer? _autoRunTimer;           // タイマー

  final ctrl = Get.put(StoreClosePageController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    buttonStates = List.filled(ctrl.activeLabel.length, ButtonState.idle);
    Rmstcls.storecloseflg = true;
  }

  /// ボタン処理
  Future<void> performAsyncTask(int index) async {

    if (!_isAutoRunning || ctrl.isTaskCanceled) return;

    setState(() {
      buttonStates[index] = ButtonState.loading;
    });

    try {
      bool result = false;

      switch (ctrl.activeLabel[index]) {
        case Label.qpDailyProcess:
          // QP日計処理
          await Rmstcls.execProcOpt7();
          if (ctrl.isTaskCanceled) return;
          result = true;
          break;
        case Label.idDailyProcess:
          // iD日計処理
          await Rmstcls.execProcOpt9();
          if (ctrl.isTaskCanceled) return;
          result = true;
          break;
        case Label.recordBackupProcess:
          // 実績バックアップ処理
          result = await Rmstcom.rmstDbToBkup();
          break;
        case Label.fileOrganizeProcess:
          // ファイルの整理処理
          // 常駐isolateを停止する
          SysMain.isolateStop();
          // 10秒待機
          await Future.delayed(const Duration(seconds: 10));
          DbVacuumProgress dbVacuumProgress = DbVacuumProgress();
          result = await dbVacuumProgress.dbvacuum();
          break;
        case Label.logBackupProcess:
          // ログバックアップ処理
          var result1 = await ctrl.zipFileManager();
          var result2 = await Rmstcls.logDeleteProc();
          var result3 = await Rmstcls.execProc3Sub();
          result = result1 && result2 && result3;
          Future.delayed(const Duration(seconds: 3)).then((_) async {
            await ctrl.finishApp();
          });
          break;
        default:
          result = true;
          break;
      }
      if (TmnEjMake.buttonConfirm == false) {
        await updateButtonState(result, index);
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.error, "onPressedStoreClose() : $e $s");
    }
  }

  Future<void> updateButtonState(bool result, int index) async {
    setState(() {
      buttonStates[index] = (result == true) ? ButtonState.success : ButtonState.fail;
    });
  }

  @override
  void dispose() {
    _autoRunTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  /// 自動実行処理
  void _startAutoRun() {
    if (!_isAutoRunning && _currentIndex < ctrl.activeLabel.length) {
      _isAutoRunning = true;
      _processNextTask();
    }
  }

  /// 次のタスクを処理する
  void _processNextTask() {
    ctrl.isTaskCanceled = false;

    if (_currentIndex >= ctrl.activeLabel.length) {
      _stopAutoRun();
      return;
    }

    performAsyncTask(_currentIndex).then((_) {
      if (!_isAutoRunning || ctrl.isTaskCanceled) return;

      if (TmnEjMake.buttonConfirm) {
        TmnEjMake.buttonConfirm = false;
      } else {
        setState(() {
          _currentIndex++;
        });
      }

      if (_currentIndex < ctrl.activeLabel.length) {
        setState(() {
          buttonStates[_currentIndex] = ButtonState.loading;
        });
        // 1秒待機してから次の処理を開始
        _autoRunTimer = Timer(const Duration(seconds: 1), _processNextTask);
      } else {
        _stopAutoRun();
      }
    });
  }

  /// 自動実行を中断する
  Future<void> _cancelAutoRun() async {

    if (_isAutoRunning) {
      switch (ctrl.activeLabel[_currentIndex]) {
        case Label.programProcess: // プログラム処理
        case Label.qpDailyProcess: // QP日計処理
        case Label.idDailyProcess: // iD日計処理
        case Label.unsentRecordProcess: // 未送信実績処理
          ctrl.isTaskCanceled = true;
          await _stopAutoRun();
          setState(() {
            buttonStates = List.filled(ctrl.activeLabel.length, ButtonState.idle);
            _currentIndex = 0;
          });
          break;
        default:
        // 実績バックアップ処理以降は処理を中止できない
          break;
      }
    }
  }

  /// 自動実行を止める
  Future<void> _stopAutoRun() async{
    _isAutoRunning = false;
    _autoRunTimer?.cancel();
  }

  String callFunc = '_stopAutoRun';

  /// 画面表示
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.storeOpenCloseBackColor,
      appBar: AppBar(
          title: Obx(() => Text(
              ctrl.nowTime.value,
              style: const TextStyle(
                color: BaseColor.storeCloseBlack54Color,
                fontSize: 15,))), // 現在時刻
          leading: SoundIconButton(
            icon: const Icon(
                Icons.arrow_back,
                color: BaseColor.storeCloseFontColor,
                size: 30.0),
            // 戻るボタン
            onPressed: () {
              if (!_isAutoRunning) {
                Rmstcls.storecloseflg = false;
                Get.back();
              }
            },
            callFunc: callFunc,
          ),
          backgroundColor: BaseColor.storeOpenCloseBackColor,
          bottomOpacity: 0.0, elevation: 0.0),
      body:
      GetBuilder(
        init: StoreClosePageController(),
        builder: (controller) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 500,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        const Text('閉設処理',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Container(
                          width: 130,
                          height: 2,
                          color: BaseColor.storeCloseFontColor,
                        ),
                        const SizedBox(height: 15),
                        const Text('実行する場合は、実行を押してください。',
                            style: TextStyle(
                                fontSize: 20,
                                color: BaseColor.storeCloseFontColor)),
                      ]
                  )
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 420,
                width: 500,
                child: IgnoreScrollbar(
                  scrollController: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: ctrl.activeLabel.length,
                    itemBuilder: (context, index) {
                      return ProgressButtonWidget(
                        label: ctrl.activeLabel[index].name,
                        state: buttonStates[index],
                        controller: ctrl,
                      );
                      },
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: SoundElevatedButton(
                      onPressed: () async{
                        await _cancelAutoRun();
                        controller.zipFileManager;
                      },
                      callFunc: '$callFunc 中止',
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: BaseColor.storeCloseStartButtonColor,
                            width: 1.0),
                        backgroundColor: BaseColor.storeOpenCloseWhiteColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('中止',
                          style: TextStyle(
                              fontSize: 20,
                              color: BaseColor.storeCloseBlack54Color)),
                    ),
                  ),const SizedBox(width: 40),
                  SizedBox(
                    width: 180,
                    height: 50,
                    child: SoundElevatedButton(
                      onPressed: () async{
                        _showRunButtonMessage();
                      },
                      callFunc: '$callFunc 実行',
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColor.storeCloseStartButtonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('実行',
                          style: TextStyle(
                              fontSize: 20,
                              color: BaseColor.storeOpenCloseWhiteColor)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// 実行ダイヤログ
  Future<void> _showRunButtonMessage() async {
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_CLOSEACTCONF.dlgId,
        type: MsgDialogType.info,
        rightBtnFnc: () async {
          Get.back();
          if (!_isAutoRunning) {
            _startAutoRun();
            await ctrl.onPressedStoreClose();
          }
        },
        leftBtnTxt: 'いいえ',
        leftBtnFnc: () {
          Get.back();
        },
      ),
    );
  }

}

/// ボタンの状態
class ProgressButtonWidget extends StatelessWidget{
  final String label;           // ボタンのラベル
  final ButtonState state;      // ボタンの状態
  final StoreClosePageController controller;  // コントローラー

  const ProgressButtonWidget({
    super.key,
    required this.label,
    required this.state,
    required this.controller});

  @override
  Widget build(BuildContext context) {
    final buttonContent = _getButtonContent(state);
    return SizedBox(
      height: 70,
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                  height: 50,
                  width: 320,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:BaseColor.storeCloseBlack54Color,
                    ),
                    textAlign: TextAlign.left,
                  )
              ),
            ],
          ),
          SizedBox(
            height: 50,
            width: 80,
            child: Container(
              decoration: BoxDecoration(
                color: buttonContent.color,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: buttonContent.content,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ButtonContent _getButtonContent(ButtonState state) {
    switch (state) {
      case ButtonState.loading:
        return ButtonContent(
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
                BaseColor.storeOpenCloseWhiteColor),
          ),
          BaseColor.storeCloseFontColor,
        );
      case ButtonState.fail:
        return ButtonContent(
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cancel,
                  color: BaseColor.storeOpenCloseWhiteColor,
                ),
                SizedBox(width: 3),
                Text(
                  "FAILED",
                  style: TextStyle(color: BaseColor.storeOpenCloseWhiteColor),
                ),
              ]
          ),
          BaseColor.storeCloseProcessFailColor,
        );
      case ButtonState.success:
        return ButtonContent(
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: BaseColor.storeOpenCloseWhiteColor,
              ),
              SizedBox(width: 8),
              Text(
                "OK",
                style: TextStyle(color: BaseColor.storeOpenCloseWhiteColor),
              ),
            ],
          ),
          BaseColor.storeCloseProcessSuccessColor,
        );
      default:
        return ButtonContent(
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.send,
                color: BaseColor.storeOpenCloseWhiteColor,
              ),
              SizedBox(width: 3),
              Text(
                "待機中",
                style: TextStyle(color: BaseColor.storeOpenCloseWhiteColor),
              ),
            ],
          ),
          BaseColor.storeCloseFontColor,
        );
    }
  }
}

class ButtonContent {
  final Widget content;
  final Color color;

  ButtonContent(this.content, this.color);
}