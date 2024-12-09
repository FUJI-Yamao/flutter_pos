/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/page/staff_open/enum/e_openclose_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/apllib_staffpw.dart';
import '../../component/w_inputbox.dart';
import '../../controller/c_drv_controller.dart';
import '../subtotal/component/w_register_tenkey.dart';
import 'controller/c_open_close_page_controller.dart';

/// 従業員オープンクローズ画面マネージャ
class StaffOpenClosePageManager {

  /// ページを開いているか否か
  static bool _isOpen = false;
  static bool isOpen() => _isOpen;
}

///従業員オープンクローズの画面構築
class StaffOpenClosePage extends StatelessWidget {
  final List<OpenCloseInputFieldLabel> labels;

  const StaffOpenClosePage({
    super.key,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return _StaffOpenClosePageWidget(labels: labels);
  }
}

class _StaffOpenClosePageWidget extends StatefulWidget {
  final List<OpenCloseInputFieldLabel> labels;

  const _StaffOpenClosePageWidget({
    required this.labels,
  });

  @override
  _StaffOpenClosePageState createState() => _StaffOpenClosePageState(labels: labels);
}

class _StaffOpenClosePageState extends State<_StaffOpenClosePageWidget> with RegisterDeviceEvent {
  final List<OpenCloseInputFieldLabel> labels;
  late final String drvCtrlTag;
  late final OpenCloseInputController openCloseCtrl;

  _StaffOpenClosePageState({required this.labels}) {
    // ダイアログのため、正常にコントローラーが破棄されない場合がある
    // その場合、ダイアログが開かれるたびにコントローラーが作成されるのを防ぐため、tagに日付の付与はしない.
    drvCtrlTag = registrationEvent(addTag: "");
    openCloseCtrl = Get.put(OpenCloseInputController(labels: labels, drvCtrlTag: drvCtrlTag));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: BaseColor.baseColor, width: 2),
      ),
      backgroundColor: BaseColor.someTextPopupArea,
      child: SizedBox(
        width: 912.w,
        height: 656.h,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              child: _buildCloseButton(),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 45.h,
                  ),
                  const Icon(
                    Icons.lock,
                    size: 45,
                    color: BaseColor.loginTabTextColor,
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  const Text(
                    '従業員コードをスキャンするか、入力してください',
                    style: TextStyle(
                      fontSize: BaseFont.font22px,
                      color: BaseColor.baseColor,
                      fontFamily: BaseFont.familyDefault,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 188.w,
              top: 228.h,
              child: Column(children: [
                _openCloseListWidget(labels[0], 0, 32, true),
                SizedBox(
                  height: 56.h,
                ),
                _openCloseListWidget(labels[1], 1, 50, false),
              ]),
            ),
            Positioned(
              right: 32.w,
              bottom: 32.h,
              child: RegisterTenkey(
                addDrvCtrlTag: drvCtrlTag,
                onKeyTap: (key) async {
                  await openCloseCtrl.inputKeyType(key);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///右上のメインメニューへボタン構築
  Widget _buildCloseButton() {
    String callFunc = '_buildCloseButton';
    return SoundTextButton(
        onPressed: () async {
          openCloseCtrl.removeCtrl();
          Get.back(result: false);
        },
        callFunc: callFunc,
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.close,
              color: BaseColor.baseColor,
              size: 45,
            ),
            SizedBox(
              width: 19.w,
            ),
            const Text('メインメニューへ',
                style: TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font18px,
                  fontFamily: BaseFont.familyDefault,
                )),
          ],
        ));
  }

  /// 各入力widgetの作成
  Widget _openCloseListWidget(OpenCloseInputFieldLabel labelEnum, int index,
      double spacing, bool iniShowCursor) {
    /// ラベルの取得
    String label = labelEnum.labelText;

    ///パスワードの入力が　’●'になる
    InputBoxMode mode = labelEnum.OpenCloseieldType == OpenCloseInputFieldType.passwordNumber ? InputBoxMode.password
        : InputBoxMode.defaultMode;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    bool usePassword = pCom.dbTrm.chkPasswordClkOpen != 0;

    if(!usePassword && mode == InputBoxMode.password) {
      return const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: BaseFont.font18px,
              color: BaseColor.baseColor,
              fontFamily: BaseFont.familyDefault,
            )),
        SizedBox(width: spacing),
        Container(
          alignment: Alignment.centerLeft,
          child: InputBoxWidget(
            key: openCloseCtrl.opencloseinputBoxList[index],
            width: 240.w,
            height: 56.h,
            fontSize: BaseFont.font22px,
            textAlign: TextAlign.right,
            padding: EdgeInsets.only(right: 32.w),
            cursorColor: BaseColor.baseColor,
            unfocusedBorder: BaseColor.inputFieldColor,
            focusedBorder: BaseColor.accentsColor,
            focusedColor: BaseColor.inputBaseColor,
            borderRadius: 4,
            blurRadius: 6,
            funcBoxTap: () {
              openCloseCtrl.onInputBoxTap(index);
            },
            iniShowCursor: iniShowCursor,
            mode: mode,
          ),
        ),
      ],
    );
  }

  /// 関連tprxソース: AplLib_StaffPW.c - apllib_StaffPW_event()
  /// バーコードスキャン時の処理のため、ページクラスに移動
  Future<void> event(String barData) async {
    if(AplLibStaffPw.staffPw.exeFlg != 0) {
      return;
    }

    if (AplLibStaffPw.STAFFPW_DEBUG_LOG != 0) {
      TprLog().logAdd(AplLibStaffPw.staffPw.tid, LogLevelDefine.normal,
          "event(): scan event");
    }
    AplLibStaffPw.staffPw.scanBuf = barData;

    // 従業員コードが妥当ならstaffPw.inpCodeにセットされる
    await AplLibStaffPw.inputBufGet(1, 0);
    AplLibStaffPw.staffPw.inpStart = 1;

    await openCloseCtrl.decideButtonPressed();
  }

  @override
  void initState() {
    super.initState();
    StaffOpenClosePageManager._isOpen = true;
  }

  @override
  void dispose() {
    StaffOpenClosePageManager._isOpen = false;
    super.dispose();
  }

  /// スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) {
      // 従業員番号入力フィールドがなければスキップ
      if (openCloseCtrl. opencloseinputBoxList[0].currentState != null) {
        event(data.devInf.barData);
      }
    };
  }

  /// タグを取得
  @override
  IfDrvPage getTag() {
    return IfDrvPage.openclose;
  }
}
