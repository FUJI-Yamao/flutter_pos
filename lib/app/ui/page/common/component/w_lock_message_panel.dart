/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/dual_cashier_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../controller/c_common_controller.dart';
import '../../../socket/client/register2_socket_client.dart';

/// 動作概要：画面上にメッセージを表示する
/// 起動方法：Get.dialog(
//             barrierColor: BaseColor.transparentColor,
//             LockMessagePanel(message: 'チェッカーで登録中'),
//           );　など

/// 画面状にメッセージを表示する
class LockMessagePanel extends StatelessWidget {
  LockMessagePanel({
    super.key,
    this.message = '',
    this.backgroundColor = BaseColor.receiptBottomColor,
  });

  static bool isShowing = false;
  String message;
  Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColor.transparentColor,
      body: GestureDetector(
          onTap: () async {
            try {
              CommonController commonCtrl = Get.find();
              // 1人制のときのみ、タップ時にロック解除可能とする
              if (await DualCashierUtil.check2Person() && commonCtrl.isUnlockEnabled.value) {
                commonCtrl.isMainMachine.value = true;
                Register2SocketClient().sendLockRequest(true);
                DualCashierUtil.setLockStatus(false, '');
              }
            } catch(e) {
              TprLog().logAdd(
                  Tpraid.TPRAID_NONE, LogLevelDefine.error,
                  "MessagePanel error $e",
              );
            }
          },
          child: Container(
            color: BaseColor.transparentColor,
            child: Center(
              child: Container(
                width: 500.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: BaseColor.newMainColor.withOpacity(0.9),
                  border: Border.all(
                    color: BaseColor.edgeBtnColor,
                    width: 1.w,
                  ),
                ),
                child: Stack(
                    children: [
                      ///ダイアログメッセージ
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 500.w,
                          height: 100.h,
                          child: Center(
                            child: Text(
                              message,
                              style: const TextStyle(
                                color: BaseColor.accentsColor,
                                fontSize: BaseFont.font44px,
                                fontFamily: BaseFont.familyDefault,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ),
        //),
      ),
    );
  }
}
