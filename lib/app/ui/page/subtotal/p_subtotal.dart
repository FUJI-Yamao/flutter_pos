/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';
import 'package:flutter_pos/app/regs/checker/rckycrdtin.dart';
import 'package:flutter_pos/app/regs/inc/rc_crdt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/cmn_sysfunc.dart';
import '../../../common/dual_cashier_util.dart';
import '../../../inc/apl/fnc_code.dart';
import '../../../inc/apl/rxregmem_define.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/apl/rxtbl_buff.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../regs/checker/rc_clxos.dart';
import '../../../regs/checker/rc_crdt_fnc.dart';
import '../../../regs/checker/rc_flrda.dart';
import '../../../regs/checker/rc_key.dart';
import '../../../regs/checker/rc_key_cash.dart';
import '../../../regs/checker/rc_key_cash4demo.dart';
import '../../../regs/checker/rc_touch_key.dart';
import '../../../regs/checker/rcsyschk.dart';
import '../../../regs/inc/L_rccrdt.dart';
import '../../../regs/inc/rc_mem.dart';
import '../../../regs/inc/rc_regs.dart';
import '../../../regs/spool/rsmain.dart';
import '../../../regs/checker/rcky_stl.dart';
import '../../colorfont/c_basecolor.dart';
import '../../component/w_background_design.dart';
import '../../component/w_trainingModeText.dart';
import '../../controller/c_common_controller.dart';
import '../../controller/c_drv_controller.dart';
import '../../socket/client/register2_socket_client.dart';
import '../cash_payment/p_cashpayment_page.dart';
import '../common/component/w_msgdialog.dart';
import '../credit_payment/controller/c_credit_declaration_controller.dart';
import '../credit_payment/model/m_creditpaymentmethodmodels.dart';
import '../credit_payment/p_credit_declaration_page.dart';
import '../electronic_money/basepage/p_electronic_money_basepage.dart';
import '../register/basepage/registerheader.dart';
import '../register/component/w_pointshow.dart';
import '../register/controller/c_registerbody_controller.dart';
import 'basepage/p_giftcertificate_page.dart';
import 'basepage/p_left_section.dart';
import 'basepage/p_right_section.dart';
import 'component/w_backtoregister_button.dart';
import 'controller/c_payment_controller.dart';
import 'controller/c_subtotal_controller.dart';

// todo 業務宣言画面の実装後にコメントを解除
// import 'controller/c_member_call_controller.dart';
// import '../register/model/m_membermodels.dart';
// import '../../enum/e_member_kind.dart';

/// 小計画面
class SubtotalPage extends StatelessWidget with RegisterDeviceEvent {
  ///コンストラクタ
  SubtotalPage({
    super.key,
  }) {
    registrationEvent();
  }

  ///コントローラー
  final subtotalCtrl = Get.put(SubtotalController());
  final RegisterBodyController registerbodyCtrl = Get.find();
  final paymentCtrl = Get.put(PaymentController());
  final commonCtrl = Get.find<CommonController>();
  final creditCtrl = Get.put(CreditPaymentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: RegsMem().refundFlag ? BaseColor.refundBackColor : BaseColor.backColor,
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: SpriteDesignMode(),
            ),
            Flex(
              direction: Axis.vertical,
              children: <Widget>[
                createHeader(context),
                Expanded(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 45,
                        child: SizedBox(
                          width: 200.w,
                          child: Flex(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const PointShowWidget(),
                                ),
                              ),
                              Expanded(
                                child: LeftSection(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 55,
                        child: (!(commonCtrl.enable2Person.value &&
                                    commonCtrl.rcKySelf.value ==
                                        RcRegs.KY_CHECKER) ||
                                !commonCtrl.isDualMode.value)
                            ? RightSection()
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(() => commonCtrl.enable2Person.value &&
                    commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR &&
                    commonCtrl.dualModeDataReceived.value &&
                    paymentCtrl.isPaymentSuccess.value
                ? Positioned(
                    right: 0,
                    bottom: 8.h,
                    child: Stack(children: [
                      BackRegisterButton(
                        text: 'データ呼出',
                        icon: Icons.arrow_forward,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(5)),
                        onTap: () {
                          TchKeyDispatch.rcDTchByFuncKey(FuncKey.KY_STL, null);
                        },
                        backgroundColor: BaseColor.dataCallButtonColor,
                      ),
                    ]),
                  )
                : commonCtrl.enable2Person.value &&
                        commonCtrl.rcKySelf.value == RcRegs.KY_CHECKER &&
                        commonCtrl.isDualMode.value &&
                        !paymentCtrl.isPaymentSuccess.value
                    ? Positioned(
                        right: 0,
                        bottom: 8.h,
                        child: Stack(children: [
                          BackRegisterButton(
                            text: 'データ送出',
                            icon: Icons.arrow_forward,
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(5)),
                            onTap: () {
                              TchKeyDispatch.rcDTchByFuncKey(
                                  FuncKey.KY_CASH, null);
                            },
                            backgroundColor: BaseColor.dataCallButtonColor,
                          ),
                        ]),
                      )
                    : const SizedBox.shrink()),
            TrainingModeText(),
          ],
        ),
      ),
    )
    );
  }

  Widget createHeader(BuildContext context) {
    return RegisterHeader();
  }

  @override
  IfDrvPage getTag() {
    return IfDrvPage.subtotal;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    KeyDispatch keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    keyCon.funcMap[FuncKey.KY_CASH] = () async {
      // 現計を押したときの処理.
      // isRunning.value = true;
      CommonController commonCtrl = Get.find();
      if (await DualCashierUtil.check2Person() &&
          await DualCashierUtil.isChecker(commonCtrl.isDualMode.value)) {
        // 2人制のタワー側の場合、登録データを卓上側へ送信する
        _sendRegistData();
      } else {
        if (registerbodyCtrl.refundFlag.value) {
          // 返品の場合は支払いダイアログは出さず、直接確定時の処理へ
          await RcKeyCashDemo.keyCash();
        } else {
          Get.to(() => CashPaymentScreen(
                title: "現金でお支払い",
              ));
          await RckyStl.rcKyStl(); // 現金ボタン押下処理の所に入れる必要がある。テストのために書き換え中
        }
      }
      // RcKeyCash cash = RcKeyCash();
      // final (isSuccess, err) = await cash.rcKeyCash();
      //
      // if (!isSuccess) {
      //   MsgDialog.show(MsgDialog.singleButtonMsg(
      //     type: MsgDialogType.error,
      //     message: err.isEmpty ? "エラー" : err,
      //   ));
      //
      //   return;
      // } else {
      //   debugPrint('正常終了しました。');
      //
      //   ///お支払い完了画面を出す
      //   paymentCtrl.setPaymentSuccess(true);
      //   // todo 小計画面で精算された時のLISTの削除を仮でここで処理を行っています
      //   // todo 現計/クレジット等ボタンを押された場合の処理に移動してください。
      //   // TODO:10138 再発行、領収書対応 のためコメントアウト PaymentControllerに移動
      //   // registerbodyCtrl.delTabList();
      //
      //   // Get.dialog(
      //   //   MsgDialog(
      //   //     dialogKind: DlgConfirmMsgKind.MSG_COMPLETE,
      //   //   	//完了しました
      //   //   	type:MsgDialogType.info,
      //   //   	message: "現金精算完了",
      //   //   	onBack: (){
      //   //       // ダイアログを消す
      //   //       Get.back();
      //   //       // レジ登録画面へ戻る
      //   //       Get.offNamed('/register');
      //   //       //ドロアを閉じる処理
      //   //       // TODO:00004 小出
      //   //       IfDrvControl().drwIsolateCtrl.closeDrw();
      //   //     },
      //   //   ),
      //   //   barrierDismissible: false,
      //   // );
      // }
    };

    keyCon.funcMap[FuncKey.KY_CRDTIN] = () async {
      // todo フロント・バックエンド結合後：以下のコメントを外す
      await startCreditPayment(FuncKey.KY_CRDTIN);

      // todo フロント・バックエンド結合後：以下を削除
      // await startCreditPaymentTest();
    };

    // 電子マネー
    keyCon.funcMap[FuncKey.KY_PAY_LIST1] = () async {
      Get.to(() => ElectronicMoneyScreen(title: "電子マネー"));
    };
    //　商品券
    keyCon.funcMap[FuncKey.KY_PAY_LIST2] = () async {
      Get.to(() => GiftCertificatePage(title: "商品券"));
    };
    // 小計
    keyCon.funcMap[FuncKey.KY_STL] = () async {
      CommonController commonCtrl = Get.find();
      if (await DualCashierUtil.isDualCashier(commonCtrl.isDualMode.value)) {
        // 2人制で卓上側の場合はタワー側からの送信データを呼び出す
        _receiveRegistData();
      }
    };

    return keyCon;
  }

  /// 登録データ送信処理
  void _sendRegistData() async {
    debugPrint('データ送出押下');

    // 登録データ送信確認
    var sendOk = await RsMain.isSpoolFileSend();
    if (!sendOk && RcClxosCommon.validClxos) {
      MsgDialog.show(MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: '登録データの送出に失敗しました。',
      ));
      return;
    }

    RcKeyCash cash = RcKeyCash();
    final (isSuccess, err) = await cash.rcKeyCash();
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
        "rcKeyCash return isSuccess=${isSuccess.toString()}");
    if (!isSuccess && RcClxosCommon.validClxos) {
      MsgDialog.show(MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: err.isEmpty ? "エラー" : err,
      ));
    } else {
      TprLog().logAdd(
          Tpraid.TPRAID_NONE, LogLevelDefine.normal, "_sendRegistData ok}");

      // 送信処理完了後
      Register2SocketClient().sendDualModeSendRegistData();
      registerbodyCtrl.delTabList();
      DualCashierUtil.transRegister();
    }
  }

  /// 登録データ受信処理
  void _receiveRegistData() async {
    debugPrint('データ呼出押下');

    if (   commonCtrl.enable2Person.value
        && commonCtrl.rcKySelf.value == RcRegs.KY_DUALCSHR
        && commonCtrl.dualModeDataReceived.value
        && paymentCtrl.isPaymentSuccess.value == false) {
      return;
    }

    if (!await DualCashierUtil.paymentPostProcess()) {
      subtotalCtrl.receiveDataPaymentProcessing = false;
      subtotalCtrl.startIsolateRegistData();
    }
  }

  /// クレジットカードの読み取りを促し、クレジット宣言画面に遷移する。
  Future<void> startCreditPayment(FuncKey key) async {
    creditCtrl.onInit();
    Get.to(() => CreditDeclarationPage(title: "クレジット取引中"));

    // todo クレ宣言バックエンド1
    // カード読み込みの処理を記載

    AcMem cMem = SystemFunc.readAcMem();
    cMem.stat.fncCode = key.keyId;

    // todo クレ宣言　暫定対応1
    KopttranBuff kopttran = KopttranBuff();
    await RcFlrda.rcReadKopttran(cMem.stat.fncCode, kopttran);
    RcRegs.kyStS1(cMem.keyStat,FncCode.KY_REG.keyId);
    cMem.stat.scrMode = RcRegs.RG_STL;

    if (await RcSysChk.rcChkMsrCtrlSystem()) {
      // TODO:10166 クレジット 20241004実装対象外
      //  rcMsrCtrl_MainProc(KY_CRDTIN);
    } else {
      if (await RcSysChk.rcChkFselfMain()) {
        await RcCrdtFnc.rccrdtfncCheckCrdtin();
      } else {
        await RckyCrdtIn.rcKyCrdtIn();
      }
    }

    // todo クレ宣言　暫定対応2
    // カード読込画面に遷移し、5秒後にカード情報を表示する
    // 本番のカード読込処理が入ったら下記処理は削除する
    creditCtrl.setCreditPaymentStatus(CreditProcessState.readCard);
    await Future.delayed(const Duration(seconds: 5));

    // カード読み込みの処理を記載
    // todo クレ宣言　暫定対応3
    // カード読込の処理を追加するまで以下テスト用の値を設定
    cMem.working.crdtReg.cdno = '1234567890123456';
    cMem.working.crdtReg.date = '1112';
    cMem.working.refData.crdtTbl.card_company_name = 'VISA';
    cMem.working.refData.crdtTbl.lump = 1;
    cMem.working.refData.crdtTbl.twice = 1;
    cMem.working.refData.crdtTbl.divide = 1;
    cMem.working.refData.crdtTbl.bonus_lump = 1;
    cMem.working.refData.crdtTbl.bonus_use = 1;
    cMem.working.refData.crdtTbl.ribo = 1;
    bool result = true; // 読み込み結果

    if (cMem.ent.errNo == 0) {
      // todo クレ宣言バックエンド2
      // カード番号、有効期限を加工する
      String cardNo = await _editCrdtCardNo(cMem.working.crdtReg.cdno);
      String goodThru = await _editCrdtCardGoodThru(cMem.working.crdtReg.date);
      // カード名称、カード番号、有効期限を文字列で設定
      creditCtrl.setCreditInfo(cMem.working.refData.crdtTbl.card_company_name,
          cardNo, goodThru);
      // methodsに該当カードで可能な支払方法を設定
      List<CreditPaymentMethod> methods = _setCreditPaymentList();
      creditCtrl.setPaymentMethods(methods);

      // クレジット取り引き中画面の状態を支払方法選択へ進ませる
      creditCtrl.setCreditPaymentStatus(CreditProcessState.selectPayment);
    } else {
      // Get.back(); // クレジットカード読み込みのCommonMessagePageを先に閉じる
      // 失敗時はバックエンド側でエラーメッセージ表示
    }
  }

  /// 一部参考　rccrdtdsp.c - rc104InchBaseKeep
  Future<String> _editCrdtCardNo(String cardNo) async {
    String editCardNo = '';
    AcMem cMem = SystemFunc.readAcMem();

    try{
      // カード番号　編集
      // ＃表示は XXXX-XXXX-XXXX-XXXX で表示する
      if (cardNo.isNotEmpty) {
        editCardNo = cardNo.substring(0, 4);
        editCardNo += '-';
        editCardNo += cardNo.substring(4, 8);
        editCardNo += '-';
        editCardNo += cardNo.substring(8, 12);
        editCardNo += '-';
        editCardNo += cardNo.substring(12, 16);
      }
      if (await CmCksys.cmCapsPqvicSystem() != 0) {
        if (cMem.working.crdtReg.step > KyCrdtInStep.PLES_CARD.cd) {
          // ＃表示は ****-****-****-**** で表示する
          editCardNo = '****-****-****-****';
        }
      } else if (await CmCksys.cmNttaspSystem() != 0) {
        if (RcSysChk.rcChkRalseCardSystem()) {
          if (cMem.working.crdtReg.step > KyCrdtInStep.PLES_CARD.cd) {
            // ＃表示は XXXX-XXXX-XXXX-XXXX で表示する
            editCardNo = 'XXXX-XXXX-XXXX-XXXX';
          }
        }
      }
    } catch (e) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "editCrdtCardNo err: ${e.toString()}");
    }
    return editCardNo;
  }

  /// 一部参考　rccrdtdsp.c - rc104InchBaseKeep
  Future<String> _editCrdtCardGoodThru(String goodThru) async {
    String editGoodThru = '';
    AcMem cMem = SystemFunc.readAcMem();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return '';
    }
    RxCommonBuf cBuf = xRet.object;

    try{
      // カード有効期限
      // 有効期限は XX/XX で表示する
      if (goodThru.isNotEmpty) {
        if (cBuf.dbTrm.goodThruDsp == 0) { // MM/YY
          editGoodThru = goodThru.substring(0, 2);
          editGoodThru += '/';
          editGoodThru += goodThru.substring(2, 4);
        } else { // YY/MM
          editGoodThru += goodThru.substring(2, 4);
          editGoodThru += '/';
          editGoodThru = goodThru.substring(0, 2);
        }

        if (await CmCksys.cmNttaspSystem() != 0) {
          if (RcSysChk.rcChkRalseCardSystem()) {
            if (cMem.working.crdtReg.step > KyCrdtInStep.PLES_CARD.cd) {
              // 有効期限は XX/XX で表示する
              editGoodThru = 'XX/XX';
            }
          }
        }
      }
    } catch (e) {
      TprLog()
          .logAdd(0, LogLevelDefine.error, "editGoodThru err: ${e.toString()}");
    }
    return editGoodThru;
  }

  /// 一部参考　rccrdtdsp.c - rcCredit_PaymKeys, rc_Pay_A_Way_Keys
  List<CreditPaymentMethod> _setCreditPaymentList() {
    List<CreditPaymentMethod> methods = <CreditPaymentMethod>[];
    AcMem cMem = SystemFunc.readAcMem();
    if (cMem.working.refData.crdtTbl.lump == 1) {
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_LUMP, paymentType: 1, orgCode: RcCrdt.LUMP);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.twice == 1) {
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_TWICE, paymentType: 2, orgCode: RcCrdt.TWICE);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide == 1) {
      // todo クレ宣言　暫定対応4 分割払い押下時処理を3回払いにする
      // コメントアウト部分は本来の押下時の処理なので、
      // 本番対応時に暫定処理部分(3行)を削除し、コメント化を解除すること
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_DIVID,
          paymentType: 3,
          paymentDetailTopic1: '分割回数',
          paymentDetailContent1: '3回',
          orgCode: RcCrdt.DIVIDE);
      methods.add(method);
      setInstallmentTestDataRealAll();
      // CreditPaymentMethod method = CreditPaymentMethod(
      //     paymentMethodName: LRccrdt.KEY_DIVID, paymentType: 3, orgCode: RcCrdt.DIVIDE);
      // methods.add(method);
      //
      // _setCrdtDivideList(methods);
    }
    if (cMem.working.refData.crdtTbl.bonus_lump == 1) {
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_BONUS_LUMP, paymentType: 4, orgCode: RcCrdt.B_LUMP);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.bonus_twice == 1) {
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_BONUS_TWICE, paymentType: 5, orgCode: RcCrdt.B_TWICE);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.bonus_use == 1) {
      // todo クレ宣言　暫定対応4 分割払い押下時処理を3回払いにする
      // コメントアウト部分は本来の押下時の処理なので、
      // 本番対応時に暫定処理部分(3行)を削除し、コメント化を解除すること
      // ボーナス併用でも分割と同じ引数を使用する。
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_BONUS_USE,
          paymentType: 6,
          paymentDetailTopic1: 'ボーナス回数',
          paymentDetailContent1: '3回',
          paymentDetailTopic2: 'ボーナス月',
          paymentDetailContent2: '8月/2月',
          orgCode: RcCrdt.DIVIDE3);
      methods.add(method);
      // CreditPaymentMethod method = CreditPaymentMethod(
      //     paymentMethodName: LRccrdt.KEY_BONUS_USE, paymentType: 16, orgCode: RcCrdt.B_USE);
      // methods.add(method);
      // _setCrdtDivideList(methods);
    }
    if (cMem.working.refData.crdtTbl.ribo == 1) {
      CreditPaymentMethod method = CreditPaymentMethod(
          paymentMethodName: LRccrdt.KEY_RIBO, paymentType: 7, orgCode: RcCrdt.RIBO);
      methods.add(method);
    }
    return methods;
  }

  /// 本関数は分割支払とボーナス併用において共通で使用する
  void _setCrdtDivideList(List<CreditPaymentMethod> methods){
    AcMem cMem = SystemFunc.readAcMem();

    if (cMem.working.refData.crdtTbl.divide3 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '３回', paymentType: 8, orgCode: RcCrdt.DIVIDE3);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide5 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '５回', paymentType: 9, orgCode: RcCrdt.DIVIDE5);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide6 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '６回', paymentType: 10, orgCode: RcCrdt.DIVIDE6);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide10 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '１０回', paymentType: 11, orgCode: RcCrdt.DIVIDE10);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide12 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '１２回', paymentType: 12, orgCode: RcCrdt.DIVIDE12);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide15 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '１５回', paymentType: 13, orgCode: RcCrdt.DIVIDE15);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide18 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '１８回', paymentType: 14, orgCode: RcCrdt.DIVIDE18);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide20 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '２０回', paymentType: 15, orgCode: RcCrdt.DIVIDE20);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide24 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '２４回', paymentType: 16, orgCode: RcCrdt.DIVIDE24);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide30 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '３０回', paymentType: 17, orgCode: RcCrdt.DIVIDE30);
      methods.add(method);
    }
    if (cMem.working.refData.crdtTbl.divide36 == 1) {
      CreditPaymentMethod method =
          CreditPaymentMethod(paymentMethodName: '３６回', paymentType: 18, orgCode: RcCrdt.DIVIDE36);
      methods.add(method);
    }
  }

  // todo フロント・バックエンド結合後：以下変数宣言とメソッドを削除
  bool pushAbort = false;

  /// クレジットカードの読み取りを促し、クレジット宣言画面に遷移する。結合前の動作確認用。
  Future<void> startCreditPaymentTest() async {
    creditCtrl.onInit();
    pushAbort = false;
    // Get.to(() => CommonMessagePage(
    //     title: "クレジット宣言",
    //     message1: '端末でクレジットカードを読ませてください。',
    //     initFunc: () {
    //       debugPrint('call initFunc');
    //     },
    //     cancelFunc: () {
    //       pushAbort = true;
    //       Get.back(); // CommonMessagePageを閉じる
    //     }
    // ));
    Get.to(() => CreditDeclarationPage(title: "クレジット取引中"));
    await waitBackEndProcess();
  }

  // todo フロント・バックエンド結合後：以下メソッドを削除
  Future<void> waitBackEndProcess() async {
    // メッセージ表示後5秒経過したらカード読み込みができたとしてクレジット宣言画面に進む
    await Future.delayed(const Duration(seconds: 5));
    if (!pushAbort) {
      creditCtrl.setCreditPaymentStatus(CreditProcessState.selectPayment);
      //
      // Get.to(() => CreditDeclarationPage(title: "クレジット取引中"));
    }
  }

  // todo フロント・バックエンド結合後：以下メソッドを削除
  /// 分割回数のリストを全項目分で設定する
  void setInstallmentTestDataRealAll() {
    AcMem cMem = SystemFunc.readAcMem();
    var tbl = cMem.working.refData.crdtTbl;
    tbl.divide3 = 1;
    tbl.divide4 = 0;
    tbl.divide5 = 1;
    tbl.divide6 = 1;
    tbl.divide7 = 0;
    tbl.divide8 = 0;
    tbl.divide9 = 0;
    tbl.divide10 = 1;
    tbl.divide11 = 0;
    tbl.divide12 = 1;
    tbl.divide15 = 1;
    tbl.divide18 = 1;
    tbl.divide20 = 1;
    tbl.divide24 = 1;
    tbl.divide25 = 0;
    tbl.divide30 = 1;
    tbl.divide35 = 0;
    tbl.divide36 = 1;
  }
}
