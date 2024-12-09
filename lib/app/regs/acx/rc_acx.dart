/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../drv/ffi/library.dart';
import '../../if/if_changer_isolate.dart';
import '../../if/if_drv_control.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/if_th.dart';
import '../../inc/lib/typ.dart';
import '../../inc/sys/tpr_aid.dart';
import '../../inc/sys/tpr_did.dart';
import '../../inc/sys/tpr_ipc.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_macro.dart';
import '../../lib/if_acx/acx_cend.dart';
import '../../lib/if_acx/acx_coin.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../lib/if_acx/acx_cread.dart';
import '../../lib/if_acx/acx_creadg.dart';
import '../../lib/if_acx/acx_csta.dart';
import '../../lib/if_acx/acx_resu.dart';
import '../../lib/if_acx/ecs_cend.dart';
import '../../lib/if_acx/ecs_creadg.dart';
import '../../lib/if_acx/ecs_stag.dart';
import '../../lib/if_acx/ecs_star.dart';
import '../../lib/if_acx/fal2_statuss.dart';
import '../../tprlib/tprlib_data.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/subtotal/controller/c_payment_controller.dart';
import '../../ui/page/subtotal/controller/c_subtotal_controller.dart';
import '../checker/rc_acracb.dart';
import '../checker/rc_atct.dart';
import '../checker/rc_clxos_payment.dart';
import '../checker/rc_ext.dart';
import '../checker/rcsyschk.dart';
import '../inc/rc_if.dart';
import '../inc/rc_mem.dart';

class RcAcx {
  static int CIN_END_RETRY_MAX = 100;
  // isolate処理で使用する
  static bool isDebugWin = isWithoutDevice();
  static bool isDecideCinAmount = false;
  static bool isCancel = false;
  // 手入力金額
  static int inputHandy = 0;
  static int cinAmount = 0;

  static int fEnd = 0;
  static int notify = 0;
  static int cmdContinue = 0;
  static int tmpErrNo = 0;
  static int overflowMode = 0;
  static int cinEndErrNo = 0;
  static int cinEndRetryCnt = 0;

  static ReceivePort receivePort2= ReceivePort();
  static Isolate? isolate2;
  static Capability capability = Capability();

  /// 関連tprxソース: rc_acx.c - rc_Acx_CinRead
  static Future<void> rcAcxCinRead() async {
    String log;
    int i;
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((tsBuf.acx.order == AcxProcNo.ACX_CIN_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.FAL2_CIN_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.SST_CIN_READ.no)) {
      errNo = await AcxCread.ifAcxCinRead(Tpraid.TPRAID_ACX, CoinChanger.ACR_COINBILL);
      if (errNo != Typ.OK) {
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "acx CIN READ error");
        tsBuf.acx.stat = errNo;
        rcAcxNotOrderSet();
        return;
      }
    }

    for(i = 0; i < RcAcrAcbDef.ACX_CREADGET_CNT; i++) {
      if ((tsBuf.acx.order != AcxProcNo.ACX_CIN_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.ECS_CIN_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.FAL2_CIN_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.SST_CIN_READ.no)) {
        log = "ACX CIN READ SKIP order[${tsBuf.acx.order}]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
        rcAcxOrderResetChk();
        break;
      }
      if (rcIFevent() == 0) {
        if (notify != 1000) {
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ACX_CIN_READ:
              tsBuf.acx.order = AcxProcNo.ACX_CIN_READ_RES.no;
              await rcAcxCinReadGet();
              break;
            case AcxProcNo.ECS_CIN_READ:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_READ_RES.no;
              await rcAcxCinReadGet();
              break;
            case AcxProcNo.SST_CIN_READ:
              tsBuf.acx.order = AcxProcNo.SST_CIN_READ_RES.no;
              await rcAcxCinReadGet();
              break;
            case AcxProcNo.FAL2_CIN_READ:
              tsBuf.acx.order = AcxProcNo.FAL2_CIN_READ_RES.no;
              await rcAcxCinReadGet();
              break;
            default:
            log = "ACX CIN READ ORDER FAIL order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              break;
          }
          break;
        }
      }
      await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_CREADGET_WAIT));
    }
    if(i == RcAcrAcbDef.ACX_CREADGET_CNT) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "CINREAD RETRY OVER");
    }
    return;
  }

  /// 関連tprxソース: rc_acx.c - rc_Acx_CinReadGet
  static Future<void> rcAcxCinReadGet() async {
    String log;
    int errNo = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    log = "acx1 order[${tsBuf.acx.order}]\n";
    TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);

    if ((tsBuf.acx.order == AcxProcNo.ACX_CIN_READ_RES.no ) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_READ_RES.no ) ||
        (tsBuf.acx.order == AcxProcNo.FAL2_CIN_READ_RES.no) ||
        (tsBuf.acx.order == AcxProcNo.SST_CIN_READ_RES.no ) )
    {
      if(tsBuf.acx.order == AcxProcNo.ECS_CIN_READ_RES.no) {
        errNo = EcsCreadg.ifEcsCinReadGet(Tpraid.TPRAID_ACX,
            tsBuf.acx.cinInfoEcs, tsBuf.acx.devAck);
      } else if(tsBuf.acx.order == AcxProcNo.FAL2_CIN_READ_RES.no) {
        errNo = Fal2Statuss.ifFal2StatSenseGet(Tpraid.TPRAID_ACX,
            tsBuf.acx.stateFal2, tsBuf.acx.devAck);
      } else {
        errNo = AcxCreadg.ifAcxCinReadGet(Tpraid.TPRAID_ACX, CoinChanger.ACR_COINBILL,
            tsBuf.acx.cinInfo, tsBuf.acx.devAck); /* 入金確定時の処理なのでACR_COINBILLでOK */
      }
      switch (errNo) {
        case Typ.OK:
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ACX_CIN_READ_RES:
            case AcxProcNo.FAL2_CIN_READ_RES:
              tsBuf.acx.order = AcxProcNo.ACX_CIN_GET.no;
              await rcAcxMain();
              break;
            case AcxProcNo.ECS_CIN_READ_RES:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_STATE_READ.no;
              cmdContinue = 1;
              await rcAcxMain();
              break;
            case AcxProcNo.SST_CIN_READ_RES:
              tsBuf.acx.order = AcxProcNo.SST_CIN_STATE01.no;
              cmdContinue = 1;
              await rcAcxMain();
              break;
            default:
              break;
          }
          break;
        default:
          log = "CIN READ DATA error[$errNo]\n";
          TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ECS_CIN_READ_RES:
              //富士電機の場合、エラー詳細をとるためにSTATE_READを行わせる
              tsBuf.acx.order = AcxProcNo.ECS_CIN_STATE_READ.no;
              cmdContinue = 1;
              await rcAcxMain();
              break;
            default:
              rcAcxNotOrderSet();
              break;
          }
          break;
      }
      tsBuf.acx.stat = errNo;
    }
    return;
  }

  /// 関数A 釣銭機ONになったら起動する　OFFになったら終了
  static Future<(bool, String)> rcAcxMainIsolate() async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
    RegsMem mem = RegsMem();
    isCancel = false;
    isDecideCinAmount = false;
    int cinAmount = 0;
    int inputHandy = 0;
    SubtotalController subtotalCtrl = Get.find();
    String callFunc = 'rcAcxMainIsolate';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return (false, "rxMemRead error");
    }
    RxTaskStatBuf tsBuf = xRet.object;
    // データ受信  --->
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(dataReceive,
        [IfDrvControl().changerIsolateCtrl, receivePort.sendPort]);
    receivePort.listen((notify2) async {
      // 共有メモリにデータをセットする
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
      if (xRet.isInvalid()) {
        return ;
      }
      tsBuf = xRet.object;
      tsBuf.catchDateTime2 = DateTime.now();
      tsBuf.acx.devAck = notify2 as TprMsgDevNotify2_t;
      updateInCoin(subtotalCtrl);
    });
    try {
      // 合計値.
      int totalAmount = mem.tTtllog.getSubTtlTaxInAmt();

      // 入金開始!
      int changerRet = 0;
      if (!isDebugWin) {
        changerRet = await AcxCsta.ifAcxCinStart(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
      }

      int charge = 0;

      while (!isDecideCinAmount && !isCancel) {
        await Future.delayed(const Duration(milliseconds: 50));
        //  入金金額の取得命令.(※金額の返り値はcinAmountに入ってくる)
        if (!isDebugWin) {
          charge = await AcxCread.ifAcxCinRead(
              TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
        }
      }
      // keycash が呼ばれる予定で暫定処理
      await Future.delayed(const Duration(seconds: 1));
      if (isCancel) {
        changerRet = await cancelCharger();
      } else {
        // 確定ボタンを押したときの処理.
        RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
        if (xRet.isInvalid()) {
          TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
              "RcKeyCash rxMemRead error");
          return (false, "rxMemRead error");
        }
        RxCommonBuf pCom = xRet.object;

        if (RegsMem().lastRequestData == null) {
          // uuidを取得.
          var uuidC = const Uuid();
          // TODO:00001 日向 バージョンは適当.要検討.
          String uuid = uuidC.v4();
          RegsMem().lastRequestData = CalcRequestParaItem(
              compCd: pCom.dbRegCtrl.compCd,
              streCd: pCom.dbRegCtrl.streCd,
              uuid: uuid);
        }
        RegsMem().tTtllog.t100001Sts.sptendCnt = 1;
        RegsMem().tTtllog.t100100[0].sptendData = cinAmount + inputHandy;
        RegsMem().tTtllog.t100100[0].sptendCd = cMem.stat.fncCode;

        CalcResultPay retDataCheck = await RcClxosPayment.payment(pCom, isCheck: true);
        int err = retDataCheck.getErrId();
        if (err > 0) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: err,
            btnFnc: () async {
              Get.until((route) => route.settings.name == '/subtotal');
            },
          ));
          RegsMem().tTtllog.t100001Sts.sptendCnt = 0;
          RegsMem().tTtllog.t100100[0] = T100100(); //リセット

          //エラーダイアログを表示してキャンセル処理を行う
          TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
              "clxosPayment check error ${retDataCheck.posErrCd}");
          changerRet = await cancelCharger();

          return (false, "rcKeyCash()");
        }

        if (!isDebugWin) {
          debugPrint("call ifAcxCinEnd");
          changerRet = await AcxCend.ifAcxCinEnd(
              TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
        }
        debugPrint("deceide in: $cinAmount total:$totalAmount");
        int bill = cinAmount + inputHandy - totalAmount;
        if (bill > 0) {
          if (!isDebugWin) {
            // お釣り返す
            await Future.delayed(const Duration(milliseconds: 500));
            debugPrint("call ifAcxChangeOut");
            changerRet = await AcxCoin.ifAcxChangeOut(
                TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL, bill);
          }
        }

        CalcResultPay retData = await RcClxosPayment.payment(pCom);

        if (0 != retData.retSts) {
          TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
              "RcKeyCash ${retData.errMsg}");
          return (false, retData.errMsg ?? "");
        } else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(await RcSysChk.getTid(), retData.digitalReceipt, callFunc);
        }

        // TODO:10138 再発行、領収書対応 の為
        await RcAtct.rcATCTEnd(
            TendType.TEND_TYPE_TEND_AMOUNT, cMem.stat.fncCode);

        //
        // RcKeyCash cash = RcKeyCash();
        // cash.rcCashAmount();
        PaymentController paymentCtrl = Get.find();
        await paymentCtrl.setPaymentSuccess(true);
      }

      Get.until((route) => route.settings.name == '/subtotal');

      // 合計金額
      return (true, "rcKeyCash()");
    } finally {
      isolate.kill();
      receivePort.close();
    }
  }

  static Future<int> cancelCharger() async {
    int changerRet = 0;
    AcMem cMem = SystemFunc.readAcMem();
    SubtotalController subtotalCtrl = Get.find();
    debugPrint("cancel");
    if (!isDebugWin) {
      // 入金額を返金
      debugPrint("call ifAcxChangeOut");
      int changerRet = await EcsCend.ifEcsCinEnd(TprDidDef.TPRTIDCHANGER, 0, 1);
    }
    subtotalCtrl.receivedAmount.value = 0;
    subtotalCtrl.calculateAmounts();
    await RcExt.rxChkModeReset("rcAcxMainIsolate");
    cMem.stat.fncCode = 0;
    return changerRet;
  }

  /// 釣銭機からのデータを受信する.
  static Future<void> dataReceive(List<dynamic> args) async {
    IfChangerIsolate changerIsolateCtrl = args[0];
    SendPort mainPort = args[1];
    int amount = 0;
    DateTime dt = DateTime.now();

    while (true) {
      final changerRet = await changerIsolateCtrl.changerAcxReceive(TprDidDef.TPRTIDCHANGER);
      if (isDummyAcx()) {
        // windowsチェック用 (WITHOUT_DEVICE).
        if (DateTime.now().difference(dt).inSeconds >= 2) {
          amount++;
          dt = DateTime.now();
        }
        // ECS_777
        // data[2]~ 500円硬貨、data[17]~ 1円硬貨、data[20]~ 10000円札、data[29]~ 1000円札
        if ((changerRet.msg.data[0] == "2") && (changerRet.msg.data[1] == "3")) {
          changerRet.msg.data[17] = latin1.decode([0x30 + (amount ~/ 100)]);
          changerRet.msg.data[18] = latin1.decode([0x30 + (((amount % 100) ~/ 10))]);
          changerRet.msg.data[19] = latin1.decode([0x30 + (amount % 10)]);
        }
        // // RT_300
        // // data[7]~ 10000円札、data[16]~ 1000円札、data[19]~ 500円硬貨、data[34]~ 1円硬貨　
        // if ((changerRet.msg.data[0] == "2") && (changerRet.msg.data[1] == "7")) {
        //   changerRet.msg.data[34] = latin1.decode([0x30 + (amount ~/ 100)]);
        //   changerRet.msg.data[35] = latin1.decode([0x30 + (((amount % 100) ~/ 10))]);
        //   changerRet.msg.data[36] = latin1.decode([0x30 + (amount % 10)]);
        // }
      }
      mainPort.send(changerRet.msg);
    }
  }

  static int getCinAmount(CinData data) {
    int amount = 0;
    amount += data.bill10000 * 10000;
    amount += data.bill5000 * 5000;
    amount += data.bill2000 * 2000;
    amount += data.bill1000 * 1000;
    amount += data.coin500 * 500;
    amount += data.coin100 * 100;
    amount += data.coin50 * 50;
    amount += data.coin10 * 10;
    amount += data.coin5 * 5;
    amount += data.coin1 * 1;

    return amount;
  }
  static updateInCoin(SubtotalController con) {
    con.receivedAmount.value = inputHandy + cinAmount;
    con.calculateAmounts();
    // 手入力金額初期化
    inputHandy = 0;
  }

  /// 関連tprxソース: rc_acx.c - main
  static Future<void> rcAcxMain() async {
    String log = '';
    int i = 0;
    int wait_cnt = 0;
    int wait_time = 0;
    RxTaskStatBuf tsBuf = RxTaskStatBuf();

    fEnd = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, "cBuf get error\n");
      fEnd = 1;
    }
    xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, "tsBuf get error\n");
      fEnd = 1;
    } else {
      tsBuf = xRet.object;
      if (tsBuf.mcftp.content_play_flg != -1) {
        tsBuf.mcftp.content_play_flg = 1;
      }
    }
    // while文が不要になったため、削除
      cmdContinue = 0;
      if (tsBuf.acx.order != 0) {
        switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
          case AcxProcNo.ACX_STATE_READ :
            log = "Aacx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_STATE_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_STATE_READ.no) {
                log = "ACX STATE READ SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_STATE_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_STATE_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_STATE_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_STATE_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "STATE RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_STATE_SET:
          case AcxProcNo.ACX_SSW_SET:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_STATE_CNT; i++) {
              if ((tsBuf.acx.order != AcxProcNo.ACX_STATE_SET.no) &&
                  (tsBuf.acx.order != AcxProcNo.ACX_SSW_SET.no)) {
                log = "ACX SSW SET SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_STATE_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_STATE_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ECS_OPE_SET:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ECS_OPESET_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ECS_OPE_SET.no) {
                log = "ECS OPE SET SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ECS_OPESET_WAIT));
            }
            if (i == RcAcrAcbDef.ECS_OPESET_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_STOCK_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_STOCK_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_STOCK_READ.no) {
                log = "ACX STOCK READ SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_STOCK_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_STOCK_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_STOCK_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_STOCK_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "STOCK RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_CHANGE_OUT:
          case AcxProcNo.ACX_SPECIFY_OUT:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            wait_cnt = RcAcrAcbDef.ACX_RESULT_CNT * 6;
            for (i = 0; i < wait_cnt; i++) {
              if ((tsBuf.acx.order != AcxProcNo.ACX_CHANGE_OUT.no) &&
                  (tsBuf.acx.order != AcxProcNo.ACX_SPECIFY_OUT.no)) {
                log = "ACX CHGOUT SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                tsBuf.acx.order = AcxProcNo.ACX_CHANGE_OUT_GET.no;
                break;
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_CHANGE_OUT_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_RESULT_WAIT));
            }
            if (i == wait_cnt) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_CANCEL:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
              wait_cnt = RcAcrAcbDef.ECS_END_CNT;
              wait_time = RcAcrAcbDef.ECS_END_WAIT;
            }
            else {
              wait_cnt = RcAcrAcbDef.SST_CANCEL_CNT;
              wait_time = RcAcrAcbDef.SST_CANCEL_WAIT;
            }
            for (i = 0; i < wait_cnt; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_CANCEL.no) {
                log = "ACX CANCEL SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              if ((i > 0) && ((i % 100) == 0)) {
                log = "ACX_CANCEL RESULT RETRY cnt[$i]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              }
              await Future.delayed(Duration(microseconds: wait_time));
            }
            if (i == wait_cnt) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_DATETIMESET:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACB_DTSET_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_DATETIMESET.no) {
                log = "ACX DATETIME SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACB_DTSET_WAIT));
            }
            if (i == RcAcrAcbDef.ACB_DTSET_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_PICKUP:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_PICKUP_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_PICKUP.no) {
                log = "ACX PICKUP SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_PICKUP_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_PICKUP_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_PICKUP_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_PICKUP_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_START:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_START.no) {
                log = "ACX START SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_START_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_START_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_ANSWER_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_ANS_READ:
          case AcxProcNo.ACX_RESET:
          case AcxProcNo.ACX_STOP:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
              if ((tsBuf.acx.order != AcxProcNo.ACX_ANS_READ.no) &&
                  (tsBuf.acx.order != AcxProcNo.ACX_RESET.no) &&
                  (tsBuf.acx.order != AcxProcNo.ACX_STOP.no)) {
                log = "ACX ANS SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_ANSWER_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_END:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            if (AcxCom.ifAcbSelect() & CoinChanger.ECS_X != 0) {
              wait_cnt = RcAcrAcbDef.ECS_END_CNT;
              wait_time = RcAcrAcbDef.ECS_END_WAIT;
            }
            else {
              wait_cnt = RcAcrAcbDef.ACX_ANSWER_CNT;
              wait_time = RcAcrAcbDef.ACX_ANSWER_WAIT;
            }
            for (i = 0; i < wait_cnt; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_END.no) {
                log = "ACX END SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_RESULT_GET.no;
                break;
              }
              if ((i > 0) && ((i % 100) == 0)) {
                log = "ACX_END RESULT RETRY order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              }
              await Future.delayed(Duration(microseconds: wait_time));
            }
            if (i == RcAcrAcbDef.ACX_ANSWER_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_CIN_END:
          case AcxProcNo.ECS_CIN_END:
          case AcxProcNo.ECS_CIN_END_MOTION2:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            await rcAcxCinEnd();
            break;
          case AcxProcNo.ACX_CIN_END_RES:
          case AcxProcNo.ECS_CIN_END_RES:
          case AcxProcNo.ECS_CIN_END_MOTION2_RES:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcxCinEndGet();
            break;
          case AcxProcNo.ACX_CIN_READ:
          case AcxProcNo.ECS_CIN_READ:
          case AcxProcNo.SST_CIN_READ:
          case AcxProcNo.FAL2_CIN_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            await rcAcxCinRead();
            break;
          case AcxProcNo.ECS_STATE_READ:
          case AcxProcNo.ECS_CIN_STATE_READ:
          case AcxProcNo.ECS_CIN_END_STATE_READ:
          case AcxProcNo.ECS_CIN_END_MOTION2_STATE_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            await rcEcsStateRead();
            break;
          case AcxProcNo.SST_STATE01:
          case AcxProcNo.SST_CIN_STATE01:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcSstState01Read();
            break;
          case AcxProcNo.SST_STATE80:
          case AcxProcNo.SST_CIN_STATE80:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcSstState80Read();
            break;
          case AcxProcNo.ACB_STATE80:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcbState80Read();
            break;
          case AcxProcNo.ACB_STATE_LASTDATA:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcbStateLastDataRead(AcrUnitCmd.BILL_CMD.id);
            break;
          case AcxProcNo.ACB_STATE_LASTDATA2:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcbStateLastDataRead(AcrUnitCmd.COIN_CMD.id);
            break;
          case AcxProcNo.ACX_DRW_OPEN:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcxDrwOpen();
            break;
          case AcxProcNo.ECS_DRW_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ECS_DRW_READ.no) {
                log = "ECS DRW READ SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  tsBuf.acx.order = AcxProcNo.ECS_DRW_GET.no;
                  break;
                }
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ECS_DRW_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
            }
            if (i == wait_cnt) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_CALCMODE_SET:
          case AcxProcNo.ACX_CALCMODE_CHK:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcxCalcModeSet();
            break;
          case AcxProcNo.ACX_ENUM_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ACX_ENUM_CNT; i++) {
              if (tsBuf.acx.order != AcxProcNo.ACX_ENUM_READ.no) {
                log = "ACX ENUM READ SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                tsBuf.acx.order = AcxProcNo.ACX_ENUM_GET.no;
                break;
              }
              if (isDummyAcx()) {
                tsBuf.acx.order = AcxProcNo.ACX_ENUM_GET.no;
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ENUM_WAIT));
            }
            if (i == RcAcrAcbDef.ACX_ENUM_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "ENUM RETRY OVER");
            }
            break;
          case AcxProcNo.ECS_RAS_SETTING_READ:
          case AcxProcNo.ECS_RAS_SETTING_SET:
          case AcxProcNo.ECS_PAYOUT_READ:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            for (i = 0; i < RcAcrAcbDef.ECS_OPESET_CNT; i++) {
              if ((tsBuf.acx.order != AcxProcNo.ECS_RAS_SETTING_READ.no)
                  && (tsBuf.acx.order != AcxProcNo.ECS_RAS_SETTING_SET.no)
                  && (tsBuf.acx.order != AcxProcNo.ECS_PAYOUT_READ.no)) {
                log = "ECS EXPANSION CMD SKIP order[${tsBuf.acx.order}]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                rcAcxOrderResetChk();
                break;
              }
              if (rcIFevent() == 0) {
                if (notify != 1000) {
                  if (tsBuf.acx.order == AcxProcNo.ECS_PAYOUT_READ.no) {
                    tsBuf.acx.order = AcxProcNo.ECS_PAYOUT_GET.no;
                  }
                  else {
                    tsBuf.acx.order = AcxProcNo.ECS_RAS_SETTING_GET.no;
                  }
                  break;
                }
              }
              if (isDummyAcx()) {
                if (tsBuf.acx.order == AcxProcNo.ECS_PAYOUT_READ.no) {
                  tsBuf.acx.order = AcxProcNo.ECS_PAYOUT_GET.no;
                }
                else {
                  tsBuf.acx.order = AcxProcNo.ECS_RAS_SETTING_GET.no;
                }
                break;
              }
              await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ECS_OPESET_WAIT));
            }
            if (i == RcAcrAcbDef.ECS_OPESET_CNT) {
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "RESULT RETRY OVER");
            }
            break;
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_START:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_01_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_02_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_03_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_04_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_05_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_06_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_07_CMD:
          case AcxProcNo.ACX_OVERFLOW_MOVE_AUTO_08_CMD:
            log = "acx1 order[${tsBuf.acx.order}]\n";
            TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
            rcAcxOverFlowMoveAutoCmd();
            break;
          default:
            rcAcxOrderResetChk();
            break;
        }
      }
      if (tsBuf.acx.order == AcxProcNo.ACX_NOT_ORDER.no) {
        rcIFevent();
      } else {
        log = "acx2 order[${tsBuf.acx.order}]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
      }
      if (cmdContinue == 1) {
        await Future.delayed(const Duration(microseconds: 10000));
      } else {
        await Future.delayed(const Duration(microseconds: 50000));
      }
      if (tsBuf.mcftp.content_play_flg == 0) {
        tsBuf.mcftp.content_play_flg = 1;
      }
    TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "acx process end\n");
    return ;
  }

  /// 関連tprxソース: rc_acx.c - rc_Acx_Cin_End
  static Future<void> rcAcxCinEnd() async {
    String log;
    int i;
    int errNo;
    int waitCnt = RcAcrAcbDef.ACX_ANSWER_CNT;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((tsBuf.acx.order == AcxProcNo.ACX_CIN_END.no)
        || (tsBuf.acx.order == AcxProcNo.ECS_CIN_END.no)
        || (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2.no)) {
      if (tsBuf.acx.order == AcxProcNo.ECS_CIN_END.no) {
        errNo = await EcsCend.ifEcsCinEnd(Tpraid.TPRAID_ACX, 0, 0);
      }
      else if (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2.no) {
        errNo = await EcsCend.ifEcsCinEnd(Tpraid.TPRAID_ACX, 0, 2);
      }
      else {
        if (tsBuf.acx.pData != CoinChanger.ACR_COINONLY) {
          tsBuf.acx.pData = CoinChanger.ACR_COINBILL;
        }
        errNo = await AcxCend.ifAcxCinEnd(Tpraid.TPRAID_ACX, tsBuf.acx.pData);
      }

      if (errNo != 0) {
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "acx CIN END error");
        tsBuf.acx.stat = errNo;
        rcAcxNotOrderSet();
        return;
      }
    }

    if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
      waitCnt = RcAcrAcbDef.ECS_END_CNT;
    } else {
      waitCnt = RcAcrAcbDef.ACX_ANSWER_CNT;
    }

    for (i = 0; i < waitCnt; i++) {
      if ((tsBuf.acx.order != AcxProcNo.ACX_CIN_END.no)
          && (tsBuf.acx.order != AcxProcNo.ECS_CIN_END.no)
          && (tsBuf.acx.order != AcxProcNo.ECS_CIN_END_MOTION2.no)) {
        log = "ACX CIN END SKIP order[${tsBuf.acx.order}]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
        rcAcxOrderResetChk();
        break;
      }
      if (rcIFevent() == 0) {
        if (notify != 1000) {
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ACX_CIN_END:
              tsBuf.acx.order = AcxProcNo.ACX_CIN_END_RES.no;
              rcAcxCinEndGet();
              break;
            case AcxProcNo.ECS_CIN_END:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_END_RES.no;
              rcAcxCinEndGet();
              break;
            case AcxProcNo.ECS_CIN_END_MOTION2:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_END_MOTION2_RES.no;
              rcAcxCinEndGet();
              break;
            default:
              log = "ACX CIN END ORDER FAIL order[${tsBuf.acx.order}]\n";
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              break;
          }
          break;
        }
      }
      if ((AcxCom.ifAcbSelect() & CoinChanger.ECS_X) != 0) {
        await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ECS_END_WAIT));
      } else {
        await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
      }
    }
    if (i == waitCnt) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "CIN END RETRY OVER");
    }
    return;
  }

  /// 関連tprxソース: rc_acx.c - rc_Acx_Cin_End_Get
  static void rcAcxCinEndGet() {
    String log;
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    log = "acx1 order[${tsBuf.acx.order}]\n";
    TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);

    if ((tsBuf.acx.order == AcxProcNo.ACX_CIN_END_RES.no)
        || (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_RES.no)
        || (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2_RES.no)) {
      errNo = AcxResu.ifAcxResultGet(Tpraid.TPRAID_ACX, tsBuf.acx.devAck);

      switch (errNo) {
        case 0:
          cinEndRetryCnt = 0;
          tsBuf.acx.order = AcxProcNo.ACX_CIN_END_GET.no;
          break;
        default:
          log = "CIN END DATA error[$errNo]\n";
          TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ACX_CIN_END_RES:
              cinEndRetryCnt = 0;
              tsBuf.acx.order = AcxProcNo.ACX_CIN_END_GET.no;
              break;
            case AcxProcNo.ECS_CIN_END_RES:
              if (cinEndRetryCnt > CIN_END_RETRY_MAX) {
                log = "CIN END DATA error[$errNo] retry_over[$cinEndRetryCnt] -> RESULT\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
                cinEndRetryCnt = 0;
                tsBuf.acx.order = AcxProcNo.ACX_CIN_END_GET.no;
              } else {
                //富士電機の場合、入金終了が効いたか判定のため装置情報取得
                tsBuf.acx.order = AcxProcNo.ECS_CIN_END_STATE_READ.no;
                cmdContinue = 1;
              }
              break;
            case AcxProcNo.ECS_CIN_END_MOTION2_RES:
              if (cinEndRetryCnt > CIN_END_RETRY_MAX) {
                log = "CIN END DATA error[$errNo] retry_over[$cinEndRetryCnt] -> RESULT\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
                cinEndRetryCnt = 0;
                tsBuf.acx.order = AcxProcNo.ACX_CIN_END_GET.no;
              } else {
                //富士電機の場合、入金終了が効いたか判定のため装置情報取得
                tsBuf.acx.order = AcxProcNo.ECS_CIN_END_MOTION2_STATE_READ.no;
                cmdContinue = 1;
              }
              break;
            default:
              rcAcxNotOrderSet();
              break;
          }
          break;
      }
      if (cmdContinue == 1) {
        //入金終了がエラー。エラー状況の判定のため装置情報を取得したいのでエラーで終えるのを回避するため保存。エラーは装置情報取得後に戻す。
        cinEndErrNo = errNo;
        log = "CIN END DATA save_error[$cinEndErrNo]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
        errNo = 0;
        tsBuf.acx.stat = errNo;
      } else {
        tsBuf.acx.stat = errNo;
      }
    }
    return;
  }

  /// 関連tprxソース: rc_acx.c - rc_Acx_Order_ResetChk
  static void rcAcxOrderResetChk() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    if (tsBuf.acx.order == AcxProcNo.ACX_ORDER_RESET.no) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal,
          "rcAcxOrderResetChk() NOT_ORDER Set");
      rcAcxNotOrderSet();
    }
  }

  /// 関連tprxソース: rc_acx.c - rc_Acx_NotOrder_Set
  static void rcAcxNotOrderSet() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    tsBuf.acx.order = AcxProcNo.ACX_NOT_ORDER.no;
    cinEndRetryCnt = 0;
  }

  ///  関連tprxソース: rc_acx.c - rc_IFevent
  static int rcIFevent() {
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return -1;
    }
    RxTaskStatBuf tsBuf = xRet.object;
    RxInputBuf buf = RxInputBuf();

    // 受け取った通知があれば処理実行 (timeチェック)
    if (tsBuf.catchDateTime1.isBefore(tsBuf.catchDateTime2)) {
      xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_ACX_STAT);
      if (xRet.isInvalid()) {
        return -1;
      }
      buf = xRet.object;
      notify = buf.hardKey;
      tsBuf.catchDateTime1 = tsBuf.catchDateTime2;
      if((tsBuf.acx.devAck.tid & RcIf.APL_DEVICE_MASK) == TprDidDef.TPRTIDCHANGER) {
        return 0; /* OK return */
      } else {
        return 0; /* OK but other data */
        // return 1; /* OK but other data */
      }
    } else {
      return -1; /* NO data */
    }
  }

  ///  関連tprxソース: rc_acx.c - rc_Acx_OverFlow_Move_Auto_Cmd
  /// TODO:00010 長田 定義のみ追加
  static void rcAcxOverFlowMoveAutoCmd() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Acx_CalcModeSet
  /// TODO:00010 長田 定義のみ追加
  static void rcAcxCalcModeSet() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Acx_Drw_Open
  /// TODO:00010 長田 定義のみ追加
  static void rcAcxDrwOpen() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Acb_State_LastDataRead
  /// TODO:00010 長田 定義のみ追加
  static void rcAcbStateLastDataRead(int type) {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Acb_State80_Read
  /// TODO:00010 長田 定義のみ追加
  static void rcAcbState80Read() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Sst_State80_Read
  /// TODO:00010 長田 定義のみ追加
  static void rcSstState80Read() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Sst_State01_Read
  /// TODO:00010 長田 定義のみ追加
  static void rcSstState01Read() {
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Ecs_State_Read
  static Future<void> rcEcsStateRead() async {
    String log;
    int i;
    int errNo;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    if ((tsBuf.acx.order == AcxProcNo.ECS_STATE_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_STATE_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_STATE_READ.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2_STATE_READ.no)) {
      errNo = await EcsStar.ifEcsStateRead(Tpraid.TPRAID_ACX);

      if (errNo != 0) {
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "acx STATE error");
        tsBuf.acx.stat = errNo;
        rcAcxNotOrderSet();
        return;
      }
    }

    for (i = 0; i < RcAcrAcbDef.ACX_ANSWER_CNT; i++) {
      if ((tsBuf.acx.order != AcxProcNo.ECS_STATE_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.ECS_CIN_STATE_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.ECS_CIN_END_STATE_READ.no) &&
          (tsBuf.acx.order != AcxProcNo.ECS_CIN_END_MOTION2_STATE_READ.no)) {
        log = "ECS STATE READ SKIP order[${tsBuf.acx.order}]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
        rcAcxOrderResetChk();
        break;
      }
      if (rcIFevent() == 0) {
        if (notify != 1000) {
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ECS_STATE_READ:
              tsBuf.acx.order = AcxProcNo.ECS_STATE_RES.no;
              await rcEcsStateReadGet();
              break;
            case AcxProcNo.ECS_CIN_STATE_READ:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_STATE_RES.no;
              await rcEcsStateReadGet();
              break;
            case AcxProcNo.ECS_CIN_END_STATE_READ:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_END_STATE_RES.no;
              await rcEcsStateReadGet();
              break;
            case AcxProcNo.ECS_CIN_END_MOTION2_STATE_READ:
              tsBuf.acx.order = AcxProcNo.ECS_CIN_END_MOTION2_STATE_RES.no;
              await rcEcsStateReadGet();
              break;
            default:
              log = "ECS STATE READ ORDER FAIL order[${tsBuf.acx.order}]\n";
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              break;
          }
          break;
        }
      }
      await Future.delayed(const Duration(microseconds: RcAcrAcbDef.ACX_ANSWER_WAIT));
    }
    if (i == RcAcrAcbDef.ACX_ANSWER_CNT) {
      TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, "ECS STATE READ RETRY OVER");
    }
    return;
  }

  ///  関連tprxソース: rc_acx.c - rc_Ecs_State_ReadGet
  static Future<void> rcEcsStateReadGet() async {
    String log;
    int errNo;
    int endRetryFlg = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return;
    }
    RxTaskStatBuf tsBuf = xRet.object;

    log = "acx1 order[${tsBuf.acx.order}]\n";
    TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);

    if ((tsBuf.acx.order == AcxProcNo.ECS_STATE_RES.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_STATE_RES.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_STATE_RES.no) ||
        (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2_STATE_RES.no)) {
      errNo = EcsStag.ifEcsStateGet(Tpraid.TPRAID_ACX, tsBuf.acx.stateEcs, tsBuf.acx.devAck);

      switch (errNo) {
        case 0:
          switch (AcxProcNo.getDefine(tsBuf.acx.order)) {
            case AcxProcNo.ECS_STATE_RES:
              tsBuf.acx.order = AcxProcNo.ECS_STATE_GET.no;
              break;
            case AcxProcNo.ECS_CIN_STATE_RES:
              tsBuf.acx.order = AcxProcNo.ACX_CIN_GET.no;
              break;
            case AcxProcNo.ECS_CIN_END_STATE_RES:
            case AcxProcNo.ECS_CIN_END_MOTION2_STATE_RES:
              if (tsBuf.acx.stateEcs.sensor.billIn == 1) //紙幣投入口残留あり
              {
                log = "CIN END bill_in -> retry[$cinEndRetryCnt/$CIN_END_RETRY_MAX]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                endRetryFlg = 1;
              }
              if (tsBuf.acx.stateEcs.sensor.coinIn == 1) //硬貨投入口残留あり
                  {
                log = "CIN END coin_in -> retry[$cinEndRetryCnt/$CIN_END_RETRY_MAX]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                endRetryFlg = 1;
              }
              // if (memcmp(tsBuf.acx.stateEcs.detail.bill, "31",
              //     sizeof(tsBuf.acx.stateEcs.detail.bill)) == 0) {
              if (tsBuf.acx.stateEcs.detail.bill == "31") {
                log = "CIN END bill act -> retry[$cinEndRetryCnt/$CIN_END_RETRY_MAX]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                endRetryFlg = 1;
              }
              // if (memcmp(tsBuf.acx.stateEcs.detail.coin, "31",
              //     sizeof(tsBuf.acx.stateEcs.detail.coin)) == 0) {
              if (tsBuf.acx.stateEcs.detail.coin == "31") {
                log = "CIN END coin act -> retry[$cinEndRetryCnt/$CIN_END_RETRY_MAX]\n";
                TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
                endRetryFlg = 1;
              }

              if (endRetryFlg == 1) {
                await Future.delayed(const Duration(microseconds: 300000));
                //投入残留あり->入金動作されるはず、もしくは入金動作中なので取り込み完了するまではすぐには終了を受け付けないので調整
                cinEndRetryCnt ++;
                if (tsBuf.acx.order == AcxProcNo.ECS_CIN_END_MOTION2_STATE_RES.no) {
                  tsBuf.acx.order = AcxProcNo.ECS_CIN_END_MOTION2.no;
                } else {
                  tsBuf.acx.order = AcxProcNo.ECS_CIN_END.no;
                }
              }
              else {
                cinEndRetryCnt = 0;
                tsBuf.acx.order = AcxProcNo.ACX_CIN_END_GET.no;
              }
              break;
            default:
              log = "ECS STATE GET ORDER FAIL order[${tsBuf.acx.order}]\n";
              TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.normal, log);
              break;
          }
          break;
        default:
          log = "ECS STATE GET error[$errNo]\n";
          TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
          rcAcxNotOrderSet();
          break;
      }
      if (tsBuf.acx.order == AcxProcNo.ACX_CIN_END_GET.no) {
        //入金終了処理NGを戻す。入金終了NGに対して装置情報を取得したがそれがNGかは重要でないので破棄する
        log = "CIN END DATA RESULT load_error[$cinEndErrNo]\n";
        TprLog().logAdd(Tpraid.TPRAID_ACX, LogLevelDefine.error, log);
        tsBuf.acx.stat = cinEndErrNo;
        cinEndErrNo = 0;
      }
      else {
        tsBuf.acx.stat = errNo;
      }
    }
    return;
  }

  ///  関連tprxソース: オリジナル
  static Future<void> rcAcxReceiveStart() async {
    bool validAcx = true;
    try {
      if (validAcx) {
        if (isolate2 == null) {
          isolate2 = await Isolate.spawn(dataReceive,
              [IfDrvControl().changerIsolateCtrl, receivePort2.sendPort]);
          receivePort2.listen((notify) async {
            await AcxCom.ifAcxReceive(notify);
          });
        } else {
            isolate2!.resume(capability);
        }
      }
    } catch(e,s) {
      TprLog().logAdd(TprDidDef.TPRTIDCHANGER,
          LogLevelDefine.error, "cinReceiveStart $e,$s");
    }
  }

}
