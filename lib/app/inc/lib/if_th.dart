/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

//  関連tprxソース:if_th.h
//  このファイルは上記ヘッダーファイルを元にdart化したものです。

// ************************************************************************
// File:      if_th.h
// contents:	if_th_cSendParam( TPRTID src, int num, IF_TH_PARAM *ptParam);
// ************************************************************************


import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/if/common/interface_define.dart';
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../lib/if_th/if_th_alloc.dart';
import '../../lib/if_th/if_th_creadsts.dart';
import '../apl/rxregmem_define.dart';
import '../sys/tpr_ipc.dart';
import '../../lib/if_th/if_th_com.dart';
import '../../lib/if_th/if_th_ccut.dart';
import '../../lib/if_th/if_th_clogoprint.dart';
import '../../lib/if_th/if_th_creset.dart';
import '../../lib/if_th/if_th_csnddata.dart';
import '../../lib/if_th/if_th_csndpara.dart';
import '../../lib/if_th/if_th_feed.dart';
import '../../lib/if_th/if_th_flushb.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_type.dart';
import '../../inc/sys/tpr_log.dart';
import '../../if/common/interface_define.dart';
import '../../if/if_print_isolate.dart';
import '../../ui/page/common/component/w_msgdialog.dart';

///  関連tprxソース:if_th.h  #defineによる定義値
class IfTh {
  /// ダイアログ表示終了フラグ
  static bool fEnd = false;
  static const PRINT_DIALOG_DELAY = 10;           // 10msc
  // ********************************************************************
  // 印字インターフェイス（ラッパー）
  // ********************************************************************
  // ******************************************************
  // IfThFlushB
  // ******************************************************
  static Future<void> printSendMessage(TprTID src, PayDigitalReceipt? sndData, {bool ejConfMode = false}) async {
    _clearErrorStatus();
    await IfThFlushB.printSendMessage(src, sndData, ejConfModeT : ejConfMode);

    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_PRN_STAT);
    if (xRetC.isInvalid()) {
      return ;
    }
    RxPrnStat stat = xRetC.object;

    if( !stat.Ctrl.ctrl ) {
      // driver timeout
      stat.DevInf.stat = InterfaceDefine.IF_TH_PRNERR_NO_ANSWER;
    }

    if (stat.DevInf.stat != 0 ) {
      // エラーダイアログ表示
      int errCode = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      if((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_CUTERR) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_CUTTERERR2.dlgId;
      } else if((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_HOPN) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_SETCASETTE.dlgId;
      } else if ((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_PEND) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_SETPAPER.dlgId;
      } else if ((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_NEND) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_PAPER_NEAREND.dlgId;
      } else if ((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_RESET) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_PRINTERERR.dlgId;
      } else if ((stat.DevInf.stat & InterfaceDefine.IF_TH_PRNERR_NO_ANSWER) != 0 ) {
        errCode = DlgConfirmMsgKind.MSG_PRN_NO_ANSWER.dlgId;
      }

      fEnd = false;
      await _showErrorMessage(errCode);
      while(!fEnd) {
        await Future.delayed(const Duration(milliseconds: PRINT_DIALOG_DELAY));
      }
    }
    return;
  }

  /// エラーダイアログ表示処理
  ///    引数：エラーNo
  static Future<void> _showErrorMessage(int errCode) async {
    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errCode,
        btnFnc: () async{
          fEnd = true;
         Get.back();
        })
     );
  }

  /// プリンターエラーステータス　クリア処理
  ///    引数：なし
  static Future<void> _clearErrorStatus() async {
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_PRN_STAT);
    if (xRetC.isInvalid()) {
      return ;
    }
    RxPrnStat stat = xRetC.object;
    stat.DevInf.stat = 0;
    await SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_PRN_STAT, stat, RxMemAttn.MAIN_TASK, "");
  }

  // ******************************************************
  // IfThCSenddata
  // ******************************************************
  static Future<int> ifThCSendData(TprTID src, String ptData0, int wSize, int wCtl, int event_flg) async {
    return await IfThCSenddata.ifThCSendData(src, ptData0, wSize, wCtl, event_flg);
  }
  static Future<int> ifThCSendDataS(TprTID src, String ptData0, int wSize, int wCtl, String cmd, int event_flg) async {
    return await IfThCSenddata.ifThCSendDataS(src, ptData0, wSize, wCtl, cmd, event_flg);
  }
  // ******************************************************
  // IfThCom
  // ******************************************************
  static Future<int> ifThSetChar(int edit_type) async {
    return await IfThCom.ifThSetChar(edit_type);
  }
  static Future<void> ifThCmd(TprTID src, String cmd, int len, int flg) async {
    await IfThCom.ifThCmd(src, cmd, len, flg);
  }
  // ******************************************************
  // IfThCSndpara
  // ******************************************************
  static Future<int> ifThCSendParam(TprTID src, int num, List<IfThParam> ptParam) async {
    return await IfThCSndPara.ifThCSendParam(src, num, ptParam);
  }
  // ******************************************************
  // IfThCCut
  // ******************************************************
  static Future<int> ifThCCut(TprTID src, int wLogo) async {
    return await IfThCCut.ifThCCut(src, wLogo);
  }
  static Future<int> ifThCCut2(TprTID src, int wLogo, int kind) async {
    return await IfThCCut.ifThCCut2(src, wLogo, kind);
  }
  // ******************************************************
  // IfThCLogoPrint
  // ******************************************************
  static Future<int> ifThCLogoPrint(TprTID src, int wLogo, String logoPath) async {
    return await IfThCLogoPrint.ifThCLogoPrint(src, wLogo, logoPath);
  }

  // ******************************************************
  // IfThCReset
  // ******************************************************
  static Future<int> ifThCReset(int src) async {
    return await IfThCReset.ifThCReset(src);
  }

  static Future<int> ifThAllocArea(int a, int b) async {
    return await IfThAlloc.ifThAllocArea(a, b);
  }

    // ******************************************************
  // IfThFlushB
  // ******************************************************
  static Future<int> ifThFlushBuf(TprTID src, int lines) async {
    return await IfThFlushB.ifThFlushBuf(src, lines);
  }

  // ******************************************************
  // IfThFeed
  // ******************************************************
  static Future<int> ifThFeed(TprTID src, int wLine) async {
    return await IfThFeed.ifThFeed(src, wLine);
  }

  // ******************************************************
  // IfThCReadSts
  // ******************************************************
  static Future<int> ifThCReadStatus(int src) async {
    return await IfThCReadSts.ifThCReadStatus(src);
  }

  // ******************************************************
  // デバッグ表示
  // ******************************************************
  static void debugPrintMsgBuff(TprMsgDevReq2 msgbuff, int datalen) {
    datalen += 2;
    debugPrint("##### Output massage ---->");
    debugPrint("mid     = (${msgbuff.mid.toRadixString(16)}H)");
    debugPrint("length  = (${msgbuff.length})");
    debugPrint("tid     = (${msgbuff.tid.toRadixString(16)}H)");
    debugPrint("src     = (${msgbuff.src.toRadixString(16)}H)");
    debugPrint("io      = (${msgbuff.io.toRadixString(16)}H)");
    debugPrint("result  = (${msgbuff.result.toRadixString(16)}H)");
    debugPrint("datalen = (${msgbuff.datalen.toRadixString(16)}H)");
    debugPrint("dataStr(${datalen}) ==>(${msgbuff.dataStr})");
    for (int i = 0; i < msgbuff.dataStr.length; i++) {
      debugPrint("[${i}] (${msgbuff.dataStr.codeUnitAt(0).toRadixString(16).padLeft(2,"0")}H) ${msgbuff.dataStr.codeUnitAt(0)}");
    }
  }

  // ******************************************************
  // デバッグ表示（プリンタコマンド用）
  // ******************************************************
  static void debugPrintCommand(String cmd) {
    String tempStr = "";
    for(int i = 0; i < cmd.length; i++) {
      tempStr += "[0x${cmd.codeUnitAt(i).toRadixString(16).padLeft(2,"0")}]";
    }
    debugPrint("##### Output massage ---->");
    debugPrint("cmd:(${tempStr})");
    debugPrint("cmd.len = ${cmd.length}");
  }

  /// 印字データバックアップ処理、印字処理、印字データクリア処理を行う関数
  /// bkEnable : true 会計データをバックアップ、クリアしたい場合（再発行対象のものはtrue）
  /// 　　　　　 : false 印字処理のみ行う
  static Future<void> printReceipt(TprTID src, PayDigitalReceipt? sndData, String callFunc, {bool ejConfMode = false, bool bkEnable = false}) async {
    TprLog().logAdd(src, LogLevelDefine.normal, "printReceipt callFunc: $callFunc");

    // 印字データバックアップ
    if (bkEnable == true) {
      await RxCommonBuf.backUpRprRfmData();
    }
    // 印字処理
    await IfTh.printSendMessage(src, sndData);

    // 印字データクリア処理
    if (bkEnable == true) {
      RegsMem().resetTranData();
    }
  }

}
