/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../ui/colorfont/c_basecolor.dart';
import '../../ui/component/w_sound_buttons.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import 'sys_main.dart';

/// シャットダウンの種類
enum ShutDownMode {
  halt,   //シャットダウン
  reboot, // 再起動.
}

/// シャットダウンの共通クラス
class SysStdn {

  /// シャットダウンもしくは再起動を行う
  ///  関連tprxソース: sysstdn.c - shutdownStart()
  static Future<void> _shutdownStart({required ShutDownMode mode}) async {
    switch(mode) {
      case ShutDownMode.halt:
        // 同じログを複数箇所に出力する関数
        outputLogs('PowerOFF!![shutdown]');
        if (Platform.isWindows) {
          await Process.run('shutdown', ['/s', '/t', '0']);
        }
        if(Platform.isLinux) {
          await Process.run('shutdown', ['-h', 'now']);
        }
      case ShutDownMode.reboot:
        // 同じログを複数箇所に出力する関数
        outputLogs('PowerOFF!![reboot]');
        if (Platform.isWindows) {
          await Process.run('shutdown', ['/r', '/t', '0']);
        } else if (Platform.isLinux) {
          await Process.run('shutdown', ['-r', 'now']);
        }
    }
  }

  /// シャットダウンをする一連の処理
  static Future<void> finishAppAndShutdown({required ShutDownMode mode}) async {
    // 同じログを複数箇所に出力する関数
    outputLogs('finishAppAndShutdown processing');
    // 常駐isolateを終了する
    await SysMain.isolateAbort();
    // シャットダウンもしくは再起動を行う
    await _shutdownStart(mode: mode);
  }

  /// 再起動確認ダイアログ表示
  static void _reStartDialog() {
    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_VUP_REBOOT.dlgId,
        type: MsgDialogType.info,
        leftBtnFnc: () {
          Get.back();
        },
        leftBtnTxt: "いいえ",
        rightBtnFnc: () async {
          Get.back();
          // シャットダウン処理中ダイアログ表示
          _shutdownProcessingDialog();
          // アプリを終了してシャットダウンをする一連の処理
          await finishAppAndShutdown(mode: ShutDownMode.reboot);
          // アプリ終了
          exit(0);
        },
        rightBtnTxt: "はい",
      ),
    );
  }

  /// シャットダウン処理中ダイアログ表示
  static void _shutdownProcessingDialog() {
    MsgDialog.show(
      MsgDialog.noButtonDlgId(
        dialogId: DlgConfirmMsgKind.MSG_BATTERY_SHUTDOWN.dlgId,
        type: MsgDialogType.info,
      ),
    );
  }

  /// シャットダウン確認ダイアログ表示
  static void _shutdownDialog() {
    MsgDialog.show(
      MsgDialog.twoButtonMsg(
        message: 'シャットダウンします。よろしいですか？',
        type: MsgDialogType.info,
        leftBtnFnc: () {
          Get.back();
        },
        leftBtnTxt: "いいえ",
        rightBtnFnc: () async {
          Get.back();
          // シャットダウン処理中ダイアログ表示
          _shutdownProcessingDialog();
          // アプリを終了してシャットダウンをする一連の処理
          await finishAppAndShutdown(mode: ShutDownMode.halt);
          // アプリ終了
          exit(0);
        },
        rightBtnTxt: "はい",
      ),
    );
  }

  /// 同じログを複数箇所に出力する関数
  static void outputLogs(String logMessage) {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, logMessage);
    TprLog().logAdd(Tpraid.TPRAID_SYSINI, LogLevelDefine.normal, logMessage);
  }

  /// 電源OFFボタンダイアログ → プロトタイプのダイアログに合わせる予定
  static void showShutdownConfirmationDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          backgroundColor: BaseColor.storeOpenCloseWhiteColor,
          buttonPadding: const EdgeInsets.all(50.0),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 電源OFF
                _buttonAndText(
                  icons: Icons.power_settings_new_outlined,
                  color: BaseColor.storeOpenPowerOffColor,
                  onPressed: () async {
                    Get.back();
                    _shutdownDialog();
                  },
                  text: '電源OFF',
                ),
                const SizedBox(width: 60),

                // 再起動
                _buttonAndText(
                  icons: Icons.restart_alt_outlined,
                  color: BaseColor.storeCloseProcessSuccessColor,
                  onPressed: () async {
                    Get.back();
                    _reStartDialog();
                  },
                  text: '再起動',
                ),
                const SizedBox(width: 60),

                // 戻る
                _buttonAndText(
                  icons: Icons.arrow_back_outlined,
                  color: BaseColor.storeCloseGoBackColor,
                  onPressed: () {
                    Get.back();
                  },
                  text: '戻る',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// ダイアログに表示するボタンとテキスト
  static Widget _buttonAndText({
    required IconData icons,
    required Color color,
    required Function() onPressed,
    required String text,
  }) {
    return Column(
      children: [
        _button(
          icons: icons,
          color: color,
          onPressed: onPressed,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            color: BaseColor.storeCloseBlack54Color,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// ダイアログに表示するボタン
  static Widget _button({
    required IconData icons,
    required Color color,
    required Function() onPressed,
  }) {
    String callFunc = '_button';
    return SoundElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        maximumSize: const Size(70, 70),
      ),
      onPressed: onPressed,
      callFunc: callFunc,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: BaseColor.storeOpenCloseWhiteColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

}
