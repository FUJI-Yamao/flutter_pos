/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../common/cls_conf/counterJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rcky_rfdopr.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_calendar.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../menu/register/m_menu.dart';
import '../../common/basepage/common_base.dart';
import '../../common/component/w_msgdialog.dart';
import '../controller/c_registerbody_controller.dart';

/// 返品モード選択画面
class ReturnPageWidget extends CommonBasePage {
  ReturnPageWidget({Key? key, required String title})
      : super(key: key, title: title);

  DateTime selectedDate = DateTime.now();

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(100.0, 80.0, 0, 0),
        child: Column(
          children: [
            Row(
              children: [
                _buildButton(
                  text: 'レシート返品',
                  onPressed: () {},
                  description:
                  '返品するレシートが1週間以内の時、\n元の取引を呼出して操作します。',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildButton(
                  text: '手動返品',
                  onPressed: () => _navigateToCalendarScreen(context),
                  description:
                  '返品するレシートが1週間より前の時、\n返品登録を行います。',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ボタンの共通部分をメソッドとして切り出し
  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required String description,
  }) {
    String callFunc = '_buildButton';
    return Row(
      children: [
        SizedBox(
          height: 80.0,
          width: 400.0,
          child: SoundElevatedButton(
            onPressed: onPressed,
            callFunc: callFunc,
            style: ElevatedButton.styleFrom(
              backgroundColor: BaseColor.scanButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              shadowColor: BaseColor.scanBtnShadowColor,
              elevation: 3,
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: BaseFont.font22px,
                color: BaseColor.someTextPopupArea,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
            description,
            style: const TextStyle(
              fontSize: BaseFont.font22px,
              color: BaseColor.baseColor,
              fontFamily: BaseFont.familyDefault,
            ),
          ),
      ],
    );
  }

  /// カレンダー画面に遷移する関数
  void _navigateToCalendarScreen(BuildContext context) {
    final RegisterBodyController regBodyCtrl = Get.find();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(
          title: title,
          initialDate: selectedDate,
        ),
      ),
    ).then((selectedDate) {
      if (selectedDate != null) {
        String formattedSaleDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
        // 返品モードの開始
        regBodyCtrl.startRefundflag(formattedSaleDate);
        // 背景を登録画面まで戻す
        SetMenu1.navigateToRegisterPage();
      }
    });
  }

  /// 返品操作が行えるかチェックする静的関数
  static Future<void> returnConfirmation(String title) async {
    final RegisterBodyController regBodyCtrl = Get.find();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;

    if (!await RckyRfdopr.rcKyRfdOpr()) {
      return;
    }

    late CounterJsonFile counterJson;
    if (xRet.isInvalid()) {
      counterJson = CounterJsonFile();
      await counterJson.load();
    } else {
      RxCommonBuf pCom = xRet.object;
      counterJson = pCom.iniCounter;
    }

    if (RegsMem().refundFlag && RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGERROR_EXPLAIN.dlgId,
          type: MsgDialogType.error,
        ),
      );
    }
    else if (RegsMem().tTtllog.getItemLogCount() > 0) {
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          dialogId: DlgConfirmMsgKind.MSG_REGSTART_ERROR.dlgId,
          type: MsgDialogType.error,
        ),
      );
    }
    else if ((await executeSelectSql(tableName: "c_trm_mst", columnName: "trm_cd", value: 1412) == true) && (pCom.dbTrm.useReceiptRefund == 0)) {
      // 返品モードの開始
      regBodyCtrl.startRefundflag(counterJson.tran.sale_date);
      // 返品方法選択画面を挟まずに背景を登録画面まで戻す
      SetMenu1.navigateToRegisterPage();
    }
    else {
      // 返品画面
      Get.to(() => ReturnPageWidget(title: title));
    }
  }

  /// 指定されたテーブルからデータを取得するためのSQL実行処理
  static Future<bool> executeSelectSql({
    required String tableName,
    required String columnName,
    required dynamic value,
  }) async {
    DbManipulationPs db = DbManipulationPs();
    String sql = "SELECT * FROM $tableName WHERE $columnName = $value";
    try {
      var result = await db.dbCon.execute(sql);
      debugPrint("SQL result: $result");
      return true;
    } catch (e) {
      debugPrint("Error executing SQL: $e");
      return false;
    }
  }

}