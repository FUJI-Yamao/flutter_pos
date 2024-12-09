/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../regs/checker/rc_clxos.dart';
import '../../ui/page/common/component/w_msgdialog.dart';


/// 予約レポートの処理
class BatchReport {

  /// 中断フラグ
  bool _isAbort = false;

  /// 予約レポートの処理を開始
  Future<void> start(List<CalcRequestBatchReport> calcRequestBatchReportList) async {
    String callFunc = 'BatchReport start';
    TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.normal, "BatchReport start");

    // 予約レポートの処理
    for (int i = 0; i < calcRequestBatchReportList.length; i++) {
      if (_isAbort) {
        /// 中断
        _end(msgKind: DlgConfirmMsgKind.MSG_STOP);
        return;
      }

      CalcResultBatchReport result;
      try {
        if (!RcClxosCommon.validClxos) {
          result = CalcResultBatchReport(retSts: 0, errMsg: "", totalData: null, digitalReceipt: null);
          String tempRetData = '''{"RetSts":0,"ErrMsg":"","TotalData":{"Amount":210,"Payment":210,"Change":210},"DigitalReceipt":{"Transaction":{"ReceiptDateTime":"2023-11-13T18:46:03+09:00","WorkstationID":"3","ReceiptNumber":"25","TransactionID":"2023111000000000100001031000000000300250026","TRKReceiptImage":[{"LineSpace":6,"PrintType":"Line","CutType":"PartialCut","ReceiptLine":["@bitmap@Logo/receipt.bmp@/bitmap@","　　スーパーアークス　月寒東店    ","　　　　TEL (011)851-5115         ","本日はご来店有難うございます。    ","　                                ","　                                ","　　　　　＜領収書＞              ","                                  ","店No:000010310      ﾚｼﾞNo:000003  ","2023年11月13日(月曜日)  17時22分  ","                     ﾚｼｰﾄNo:0024  ","                                  ","＊＊＊＊＊＊訓練ﾓ-ﾄﾞ＊＊＊＊＊＊  ","外8  逸品　アボカド         ￥195　","----------- 訓練ﾓ-ﾄﾞ -----------  ","--------------------------------  "," 小計                       ￥195  ","(外税8%対象額               ￥195) "," 外税額            8%        ￥15  "," 買上点数                    1点  ","--------------------------------  ","@fontsizeH@合計        ￥210 @/fontsizeH@","@fontsizeH@            ￥210 @/fontsizeH@","           (内消費税等       ￥15) ","@fontsizeH@お釣り        ￥0 @/fontsizeH@","                                  ","外8内8は軽減税率対象商品です      ","@barC128_HNC@98231110002400000000300253@/barC128_HNC@","                                  ","@bitmap@cmlogo00000119.bmp@/bitmap@"]}]}}}''';
          result = CalcResultBatchReport.fromJson(jsonDecode(tempRetData));
        } else {
          result = await CalcApi.batchReport(Tpraid.TPRAID_REPT, calcRequestBatchReportList[i]);
        }
      } catch (e, s) {
        // システムエラー
        TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "BatchReport CalcApi.batchReport error\n$e\n$s");
        _end(msgKind: DlgConfirmMsgKind.MSG_SYSERR);
        return;
      }

      // 正常 かつ 印字データが存在するときに、印字する
      if (result.retSts == 0) {
        try {
          // レポート印字
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(Tpraid.TPRAID_REPT, result.digitalReceipt, callFunc);
          TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.normal, "BatchReport printSendMessage success");
        } catch (e, s) {
          // 印字エラー
          TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.error, "BatchReport printSendMessage error\n$e\n$s");
          _end(msgKind: DlgConfirmMsgKind.MSG_BATREPO_RETRY);
          return;
        }
      } else {
        // CalcApi.batchReportのエラー
        _end(errMsg: result.errMsg);
        return;
      }
    }

    // 正常終了
    _end(msgKind: DlgConfirmMsgKind.MSG_COMPLETE);


    TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.normal, "BatchReport end");
  }

  /// 処理を中断する
  Future<void> abort() async {
    _isAbort = true;
    TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.normal, "BatchReport abort");
  }


  /// 処理終了通知
  void _end({
    DlgConfirmMsgKind? msgKind,
    String? errMsg,
  }) {
    // 表示しているダイアログを全て閉じる
    _closeDialogAll();

    // メッセージ表示
    if (errMsg != null) {
      // エラー終了
      MsgDialog.show(
        MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: errMsg,
        ),
      );
    } else {
      // msgKindがnullの場合は、正常終了として扱う
      msgKind = msgKind ?? DlgConfirmMsgKind.MSG_COMPLETE;

      // 正常終了と中断以外は、エラーとして扱う
      MsgDialogType type = MsgDialogType.info;
      if (msgKind != DlgConfirmMsgKind.MSG_COMPLETE && msgKind != DlgConfirmMsgKind.MSG_STOP) {
        type = MsgDialogType.error;
      }

      // ダイアログを表示する
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
          type: type,
          dialogId: msgKind.dlgId,
        ),
      );
    }

    TprLog().logAdd(Tpraid.TPRAID_REPT, LogLevelDefine.normal, "BatchReport _end");
  }

  /// 表示しているダイアログを全て閉じる
  void _closeDialogAll() {
    while (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
