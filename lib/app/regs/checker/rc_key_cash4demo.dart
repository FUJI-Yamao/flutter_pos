/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/apllib/cnct.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_atct.dart';
import 'package:flutter_pos/app/regs/checker/rc_clxos_payment.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rcsyschk.dart';
import 'package:flutter_pos/app/ui/page/cash_payment/controller/c_cashpayment_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../../postgres_library/src/db_manipulation_ps.dart';
import '../../common/cmn_sysfunc.dart';
import '../../drv/ffi/library.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/db/c_ttllog.dart';
import '../../inc/lib/if_acx.dart';

import '../../inc/lib/if_th.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/if_acx/acx_cend.dart';
import '../../lib/if_acx/acx_coin.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../lib/if_acx/acx_cstp.dart';
import '../../lib/cm_chg/ltobcd.dart';
import '../../sys/mente/sio/sio_def.dart';
import '../../ui/menu/register/m_menu.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/full_self/controller/c_full_self_register_controller.dart';
import '../../ui/page/subtotal/controller/c_subtotal_controller.dart';

import '../../inc/apl/rxregmem_define.dart';
import '../../ui/socket/server/semiself_socket_server.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_spool_in.dart';
import 'rckyccin_acb.dart';

// **************************************************************
// 釣銭機テスト  --->
// **************************************************************
import '/app/if/if_changer_isolate.dart';
import '/app/inc/sys/tpr_did.dart';
import 'rc_atctd.dart';

///　「現計」処理.
/// 関連tprxソース:rckycash.c
class RcKeyCashDemo {
  static bool isDebugWin = isWithoutDevice();
  static bool isDecideCinAmount = false;
  static bool isCancel = false;
  static bool validAcx = false;

  // 手入力金額
  static int inputHandy = 0;
  static int cinAmount = 0;
  static String paymentMethod = 'noChangeMachine';
  static int selfMode = 0;

  // static String getPaymentMethod() {
  //   return paymentMethod;
  // }

  static Future<bool> getAcxValidation() async {
    paymentMethod = 'noChangeMachine';
    bool sioSetting = false;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    RxCommonBuf pCom = xRet.object;

    var db = DbManipulationPs();
    String sql = SioDef.SIO_SQL_GET_REGCNCT_SIO_DATA;
    Map<String, dynamic>? subValues = {
      "comp" : pCom.iniMacInfoCrpNoNo,
      "stre" : pCom.iniMacInfoShopNo,
      "mac"  : pCom.iniMacInfoMacNo
    };
    // SIO設定＝釣銭釣札機が設定されている。
    Result dataList = await db.dbCon.execute(Sql.named(sql),parameters: subValues);
    if (!dataList.isEmpty) {
      for (int i = 0; i < dataList.length; i++) {
        Map<String ,dynamic> data = dataList[i].toColumnMap();
        if ((data["cnct_grp"] == 2) && (data["drv_sec_name"] == "acb")) {
          sioSetting = true;
          break;
        }
      }
    }
    if (sioSetting != true) {
      return false;
    }
    // 周辺装置：自動釣銭釣札機が釣銭釣札機に設定されている。
    if (Cnct.cnctMemGet(0, CnctLists.CNCT_ACR_CNCT) != 2) {
      return false;
    }
    // 周辺装置：釣銭釣札機接続時の入金確定処理が自動確認に設定されいている。
    if (Cnct.cnctMemGet(0, CnctLists.CNCT_ACB_DECCIN) != 2) {
      return false;
    }
    // 自動釣機ON/OFFフラグが「OFF」になってない
    if (Cnct.cnctMemGet(0, CnctLists.CNCT_ACR_ONOFF) == 1) {
      return false;
    }
    // オペモード＝登録モード
    // オペモード＝訓練モード（ターミナル設定、操作禁止（訓練モードでの釣銭機・ドロア動作を禁止）が「する」時は除外）
    if (RcSysChk.rcRGOpeModeChk() ||
       (RcSysChk.rcTROpeModeChk() && (pCom.dbTrm.traningDrawAcxFlg == 1))) {
    } else {
      return false;
    }
    paymentMethod = 'haveChangeMachine';
    return true;
  }

  // 「現計」ボタンが押されたときの処理.
  /// 関連tprxソース:rckycash.c rcKyCash()
  static Future<(bool, String)> rcKeyCash4Demo({CalcRequestParaPay? requestParaPay}) async {
    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
    RegsMem regsMem = SystemFunc.readRegsMem();
    isCancel = false;
    isDecideCinAmount = false;
    cinAmount = 0;
    inputHandy = 0;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RcKeyCash rxMemRead error");
      return (false, "rxMemRead error");
    }
    RxCommonBuf pCom = xRet.object;
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "RcKeyCash rxMemRead error");
      return (false, "rxMemRead error");
    }
    RxTaskStatBuf tsBuf = xRet2.object;

    selfMode = pCom.iniMacInfo.select_self.kpi_hs_mode;

    // セミセルフ 支払い中ステータス設定
    if (selfMode == 2) {
      tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPaying;
    }
    // 二人制タワー側処理
    if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
      await RcSpoolIn.rcSpoolIn();
    }
    validAcx = await getAcxValidation() && (!isDebugWin) || isDummyAcx();

    if(!await RcSysChk.rcSGChkSelfGateSystem() && (selfMode != 2)) {
      SubtotalController subtotalCtrl = Get.find();
      CashPaymentInputController cashPayCtrl = Get.find();

      if (paymentMethod == 'noChangeMachine') {
        // 手入力に切り換え、テンキーを表示する。
        subtotalCtrl.updatePaymentMethod('noChangeMachine');
        cashPayCtrl.onInputBoxTap();
      } else {
        subtotalCtrl.updatePaymentMethod('haveChangeMachine');
      }
    }

    try {
      // 入金開始!
      int changerRet = 0;
      if (validAcx) {
        changerRet = await RcAcracb.rcAcrAcbCinStartDtl(0);
        // 暫定：コマンド送信失敗したら接続なしと判断して手入力を設定
        if (changerRet != IfAcxDef.MSG_ACROK) {
          if(!await RcSysChk.rcSGChkSelfGateSystem() && (selfMode != 2)) {
            SubtotalController subtotalCtrl = Get.find();
            subtotalCtrl.updatePaymentMethod('noChangeMachine');
          }
        } else {
          if(!await RcSysChk.rcSGChkSelfGateSystem() && (selfMode != 2)) {
            SubtotalController subtotalCtrl = Get.find();
            subtotalCtrl.updatePaymentMethod('haveChangeMachine');
          }
        }
      }

      int charge = 0;

      while (!isDecideCinAmount && !isCancel) {
        //  入金金額の取得命令.(※金額の返り値はcinAmountに入ってくる)
        if (validAcx) {
          await RcAcracb.rcAcrAcbCinReadDtl();
          await RcAcracb.rcCcinPriceSetCom();
          if (isDummyAcx()) {
            // TODO:セミセルフ確認用（完成後削除する）
            await Future.delayed(const Duration(seconds: 2));
            charge += 100;
          }
          cinAmount = cMem.acbData.ccinPrice + charge;
          if(await RcSysChk.rcSGChkSelfGateSystem() || (selfMode == 2)){
            fullSelfUpdateInCoin();
          }else {
            SubtotalController subtotalCtrl = Get.find();
            updateInCoin(subtotalCtrl);
          }
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (isCancel) {
        changerRet = await cancelCharger();
        if (selfMode == 2) {
          tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPrePay;
        }
      } else {
        // 確定ボタンを押したときの処理.
        return await keyCash(
          requestParaPay: requestParaPay, 
          changerRet: changerRet, 
          cinAmount: cinAmount, 
          inputHandy: inputHandy
        );
      }
      // 合計金額
      return (true, "rcKeyCash()");
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error, "RcKeyCash $e $s");
      if (selfMode == 2) {
        tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPrePay;
      }
      return (false, "rcKeyCash()");
    } finally {
      // スプリット対応：現金額の初期化
      cinAmount = 0;
      inputHandy = 0;
    }
  }

  /// 確定ボタンを押したときの処理
  static Future<(bool, String)> keyCash({
    CalcRequestParaPay? requestParaPay, 
    int changerRet = 0, 
    int cinAmount = 0, 
    int inputHandy = 0
  }) async {
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem regsMem = SystemFunc.readRegsMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "keyCash rxMemRead error");
      return (false, "rxMemRead error");
    }
    RxCommonBuf pCom = xRet.object;
    RxMemRet xRet2 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet2.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
          "keyCash rxMemRead error");
      return (false, "rxMemRead error");
    }
    RxTaskStatBuf tsBuf = xRet2.object;
    String callFunc = 'keyCash';
    try {
      // 合計値.
      int totalAmount = regsMem.tTtllog.getSubTtlTaxInAmt();
      // スプリット対応：現金額をcmLtobcdで文字列に変換
      String bcd =
          Ltobcd.cmLtobcd((cinAmount + inputHandy), cMem.ent.entry.length);
      for (int i = 0; i < cMem.ent.entry.length; i++) {
        // 文字列bcdを文字コードに変換して代入
        cMem.ent.entry[i] = bcd.codeUnits[i];
      }
      // スプリット対応：現金額の桁設定とスプリット設定処理を追加
      cMem.ent.tencnt = (cinAmount + inputHandy).toString().length;
      TendType eTendType = await RcAtct.rcATCTProc(); // to Common function
      if (eTendType == TendType.TEND_TYPE_ERROR) {
        return (false, "keyCash()");
      }

      if (regsMem.lastRequestData == null) {
        // uuidを取得.
        var uuidC = const Uuid();
        // TODO:00001 日向 バージョンは適当.要検討.
        String uuid = uuidC.v4();
        regsMem.lastRequestData = CalcRequestParaItem(
            compCd: pCom.dbRegCtrl.compCd,
            streCd: pCom.dbRegCtrl.streCd,
            uuid: uuid); 
      }
      cMem.stat.fncCode = FuncKey.KY_CASH.keyId;
      regsMem.tTtllog.t100001Sts.sptendCnt = 1;
      regsMem.tTtllog.t100100[0].sptendData = cinAmount + inputHandy;
      regsMem.tTtllog.t100100[0].sptendCd = cMem.stat.fncCode;

      CalcResultPay retDataCheck =
          await RcClxosPayment.payment(pCom, isCheck: true, requestParaPay: requestParaPay);
      int err = retDataCheck.getErrId();
      if (err > 0) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: err,
          btnFnc: () async {
              SetMenu1.navigateToPaymentSelectPage();
          },
        ));
        regsMem.tTtllog.t100001Sts.sptendCnt = 0;
        regsMem.tTtllog.t100100[0] = T100100(); //リセット

        //エラーダイアログを表示してキャンセル処理を行う
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error,
            "clxosPayment check error ${retDataCheck.posErrCd}");
        changerRet = await cancelCharger();

        if (selfMode == 2) {
          tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPrePay;
        }
        return (false, "keyCash()");
      }

      if (validAcx) {
      //await Future.delayed(const Duration(seconds: 1));
        debugPrint("call ifAcxCinStop");
        changerRet = await RcAcracb.rcAcrAcbCinStopDtl();
        if (changerRet == 0) {
          changerRet = await RckyccinAcb.rcAcrAcbStopWait2(0);
        }
        debugPrint("call ifAcxCinEnd");
        changerRet = await RcAcracb.rcAcrAcbCinEndDtl();
        if (changerRet == 0) {
          changerRet = await RckyccinAcb.rcAcrAcbStopWait2(1);
        }
      }
      debugPrint("deceide in: $cinAmount total:$totalAmount");
      int bill = cinAmount + inputHandy - totalAmount;
      if (bill > 0) {
        if (validAcx) {
          // お釣り返す
          await Future.delayed(const Duration(milliseconds: 500));
          debugPrint("call ifAcxChangeOut");
          await RcAcracb.rcAcrAcbChangeOut(bill);
        }
      }

      CalcResultPay retData = await RcClxosPayment.payment(pCom, requestParaPay: requestParaPay);

      // 全商品返品操作扱い：締め状態とする。
      int refundFlag = retData.totalData?.refundFlag ?? 0;
      if (refundFlag == 1) {
        eTendType = TendType.TEND_TYPE_TEND_AMOUNT;
      }

      // スプリット対応：締め完了状態の場合のみ印字開始処理を実行する
      if (eTendType == TendType.TEND_TYPE_TEND_AMOUNT) {
        if (0 != retData.retSts) {
          TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error,
              "keyCash ${retData.errMsg}");
          if (selfMode == 2) {
            tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPrePay;
          }
          return (false, retData.errMsg ?? "");
        } else {
          // 印字データバックアップ、印字処理、印字データクリア関数を呼び出す
          await IfTh.printReceipt(Tpraid.TPRAID_CASH, retData.digitalReceipt, callFunc, bkEnable : true);
        }
      }
      if (validAcx) {
        await RcAcracb.rcAcrAcbStockUpdate(0);
      }

      // TODO:10138 再発行、領収書対応 の為
      // スプリット対応：締め状態によって画面遷移先を判別する
      RcAtctD.rcATCTDisplay(eTendType);
      await RcAtct.rcATCTEnd(eTendType, cMem.stat.fncCode);

      // セミセルフの場合、登録機へのステータスを支払い完了にする。
      if (selfMode == 2) {
        tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPayEnd;
      }

      // RcKeyCash cash = RcKeyCash();
      // cash.rcCashAmount();
      return (false, "keyCash()");
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_CASH, LogLevelDefine.error, "keyCash $e $s");
      if (selfMode == 2) {
        tsBuf.qcConnect.MyStatus.qcStatus = SemiSelfSocketServer.msgStatusPrePay;
      }
      return (false, "keyCash()");
    }
  }

  static Future<int> cancelCharger() async {
    int changerRet = 0;
    AcMem cMem = SystemFunc.readAcMem();
    debugPrint("cancel");
    if (validAcx) {
      debugPrint("入金額返却");

      // 以下のグローリー(RT-300)は暫定処理。
      // 最終的には「await RcAcracb.rcChgCinCancelDtl()」だけを共通処理として残す。
      if(AcxCom.ifAcbSelect() == CoinChanger.ECS_777) {
        // 入金額を返金
        debugPrint("call ifAcxChangeOut");
        changerRet = await RcAcracb.rcChgCinCancelDtl();
      } else if(AcxCom.ifAcbSelect() == CoinChanger.RT_300) {
        debugPrint("call ifAcxCinStop");
        changerRet = await AcxCstp.ifAcxCinStop(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
        await Future.delayed( const Duration(seconds: 1));
        debugPrint("call ifAcxCinEnd");
        changerRet = await AcxCend.ifAcxCinEnd(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL);
        // 入金額を返金
        await Future.delayed( const Duration(milliseconds: 500));
        debugPrint("call ifAcxChangeOut");
        changerRet = await AcxCoin.ifAcxChangeOut(
            TprDidDef.TPRTIDCHANGER, CoinChanger.ACR_COINBILL, cinAmount);
      }
    }

    if(!await RcSysChk.rcSGChkSelfGateSystem() && (selfMode != 2)) {
      SubtotalController subtotalCtrl = Get.find();
      subtotalCtrl.changeReceivedAmount.value = 0;
      subtotalCtrl.calculateAmounts();
    }
    if (selfMode == 2) {
      FullSelfRegisterController selfCtrl = Get.find();
      selfCtrl.changeReceivedAmount.value = 0;
      selfCtrl.receiveAmount.value = 0;
      selfCtrl.updateAmounts();
    }
    await RcExt.rxChkModeReset("rcKeyCash4Demo");
    cMem.stat.fncCode = 0;
    return changerRet;
  }

  /// 釣銭機からのデータを受信する.
  static Future<void> kyCashChangerDataReceive(List<dynamic> args) async {
    IfChangerIsolate changerIsolateCtrl = args[0];
    SendPort mainPort = args[1];
    while (true) {
      if (!isDebugWin) {
        final changerRet =
            await changerIsolateCtrl.changerAcxReceive(TprDidDef.TPRTIDCHANGER);
        mainPort.send(changerRet.msg);
      } else {
        break;
      }
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
    con.changeReceivedAmount.value = inputHandy + cinAmount;
    con.calculateAmounts();
  }

  static fullSelfUpdateInCoin(){
    FullSelfRegisterController fullSelfRegisterCtrl = Get.find();
    fullSelfRegisterCtrl.changeReceivedAmount.value = inputHandy + cinAmount;
    fullSelfRegisterCtrl.updateAmounts();
  }
}
