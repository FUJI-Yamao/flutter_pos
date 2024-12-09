/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rcky_srchreg.dart';
import 'package:get/get.dart';

import '../../common/cmn_sysfunc.dart';
import '../../common/dual_cashier_util.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/image.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../../lib/apllib/image_label_dbcall.dart';
import '../../ui/menu/register/enum/e_register_page.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/code_payment/p_codepayment_page.dart';
import '../../ui/page/manual_input/component/w_mglogin_dialogpage.dart';
import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';
import '../../ui/page/manual_input/controller/c_mglogininput_controller.dart';
import '../../ui/page/register/component/w_returnwidget.dart';
import '../../ui/page/register/controller/c_cancel_process_handler.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../../ui/page/staff_open/w_open_close_page.dart';
import '../../ui/page/subtotal/component/w_register_tenkey.dart';
import '../../ui/page/workin/controller/c_workin.dart';
import '../../ui/page/workin/p_workin.dart';
import '../inc/rc_mem.dart';
import 'rc_ajs_emoney.dart';
import 'rc_cogca.dart';
import 'rc_key_ejconf.dart';
import 'rc_key_qcselect.dart';
import 'rc_key_stf.dart';
import 'rc_msrctrl.dart';
import 'rc_trk_preca.dart';
import 'rc_repica.dart';
import 'rc_value_card.dart';
import 'rcky_brand.dart';
import 'rcky_cat_cardread.dart';
import 'rcky_cha.dart';
import 'rcky_dsc.dart';
import 'rcky_erctfm.dart';
import 'rcky_hcrdtin.dart';
import 'rcky_mdl.dart';
import 'rcky_mg.dart';
import 'rcky_mul.dart';
import 'rcky_outdummy.dart';
import 'rcky_prc.dart';
import 'rcky_qcnotpay_list.dart';
import 'rcky_rfdopr.dart';
import 'rckyccin.dart';
import 'rckycpick.dart';
import 'rckycrefdummy.dart';
import 'rckydifcheck.dart';
import 'rckymbre.dart';
import 'rckypchg.dart';
import 'rckysalescollection.dart';
import 'rckyworkin.dart';
import 'rcmbrflrd.dart';
import 'rcmbrkymbr.dart';
import 'rcstllcd.dart';
import 'rcsyschk.dart';

/// 指定のkeyが押されたときの処理.
/// 関連tprxソース:rc_key.c
class KeyDispatch {
  static bool _busy = false;
  final TprMID tid;

  Function? funcNum;
  Function? funcClr;
  Function? funcCha;
  Map<FuncKey, Function> funcMap = {};
  KeyDispatch(this.tid);
  /// コピーコンストラクタ.
  KeyDispatch.copy(KeyDispatch ori)
  :tid = ori.tid {
      funcNum = ori.funcNum;
      funcClr = ori.funcClr;
      funcCha = ori.funcCha;
      funcMap = Map.from(ori.funcMap);
  }


  /// PLUコードが選択されたときの処理.
  /// 引数にはFuncKeyのkeyIdを取得する.
  Future<void> rcDKeyByKeyId(int keyId, dynamic option) async {
    FuncKey funcKey = FuncKey.getKeyDefine(keyId);
    await rcDKeyByFuncKey(funcKey, option);
  }

  /// PLUコードが選択されたときの処理.
  /// 引数にはFuncKeyのFuncKeyを取得する.
  Future<void> rcDKeyByFuncKey(FuncKey funcKey, dynamic option) async {
    debugPrint("rcDKeyByFuncKey: ${funcKey.name}");
    RcInfoMemLists rcInfoMem = RcInfoMemLists();
    if (_busy) {
      // 複数の処理が同時に走らないようにセーフティ.
      AcMem cMem = SystemFunc.readAcMem();
      TprLog().logAdd(tid, LogLevelDefine.error,
          "push key:${funcKey.name} is canceled. already key:${cMem.stat.fncCode} process  running.");
      return;
    }
    if (StaffOpenClosePageManager.isOpen() && !KeyType.contains(funcKey)) {
      debugPrint("push key:${funcKey.name} is invalid because StaffOpenClosePage is opening.");
      TprLog().logAdd(tid, LogLevelDefine.warning,
          "push key:${funcKey.name} is invalid because StaffOpenClosePage is opening.");
      return;
    }
    try{
      _busy = true;

      switch (funcKey) {
        case FuncKey.KY_1:
        case FuncKey.KY_2:
        case FuncKey.KY_3:
        case FuncKey.KY_4:
        case FuncKey.KY_5:
        case FuncKey.KY_6:
        case FuncKey.KY_7:
        case FuncKey.KY_8:
        case FuncKey.KY_9:
        case FuncKey.KY_0:
        case FuncKey.KY_00:
        case FuncKey.KY_000:
          selectedNumber(funcKey);
          break;
        case FuncKey.KY_CLR:
          if(MsgDialog.isDialogShowing && !MsgDialog.isError){
             TprLog().logAdd(tid, LogLevelDefine.normal, "push key:${funcKey.name} NG: isDialogShowing");
             return; // メッセージダイアログ表示中は禁止.
          }
          await funcClr?.call();
          break;
        case FuncKey.KY_PLU: //optionにはPLUが入ってくる.
          // スキャン処理をするタイミングを絞る。スキャン処理が必要・不要を振り分けたい場合はcurrentRouteの判定の追加が必要。
          String currentRoute = Get.currentRoute;
          if (currentRoute == RegisterPage.register.routeName ||
          currentRoute == RegisterPage.tranining.routeName ||
          currentRoute == '/FullSelfRegisterPage') {
            await selectedPlu(option as String?);
          }
          break;
        case   FuncKey.KY_CHA11   :                                  /* 会計11 */
        case   FuncKey.KY_CHA12   :                                  /* 会計12 */
        case   FuncKey.KY_CHA13   :                                  /* 会計13 */
        case   FuncKey.KY_CHA14   :                                  /* 会計14 */
        case   FuncKey.KY_CHA15   :                                  /* 会計15 */
        case   FuncKey.KY_CHA16   :                                  /* 会計16 */
        case   FuncKey.KY_CHA17   :                                  /* 会計17 */
        case   FuncKey.KY_CHA18   :                                  /* 会計18 */
        case   FuncKey.KY_CHA19   :                                  /* 会計19 */
        case   FuncKey.KY_CHA20   :                                  /* 会計20 */
        case   FuncKey.KY_CHA21   :                                  /* 会計21 */
        case   FuncKey.KY_CHA22   :                                  /* 会計22 */
        case   FuncKey.KY_CHA23   :                                  /* 会計23 */
        case   FuncKey.KY_CHA24   :                                  /* 会計24 */
        case   FuncKey.KY_CHA25   :                                  /* 会計25 */
        case   FuncKey.KY_CHA26   :                                  /* 会計26 */
        case   FuncKey.KY_CHA27   :                                  /* 会計27 */
        case   FuncKey.KY_CHA28   :                                  /* 会計28 */
        case   FuncKey.KY_CHA29   :                                  /* 会計29 */
        case   FuncKey.KY_CHA30   :                                  /* 会計30 */
        case   FuncKey.KY_CHK1    :                                  /* 品券1 */
        case   FuncKey.KY_CHK2    :                                  /* 品券2 */
        case   FuncKey.KY_CHK3    :                                  /* 品券3 */
        case   FuncKey.KY_CHK4    :                                  /* 品券4 */
        case   FuncKey.KY_CHK5    :                                  /* 品券5 */
        case   FuncKey.KY_CHA1    :                                  /* 会計1 */
        case   FuncKey.KY_CHA2    :                                  /* 会計2 */
        case   FuncKey.KY_CHA3    :                                  /* 会計3 */
        case   FuncKey.KY_CHA4    :                                  /* 会計4 */
        case   FuncKey.KY_CHA5    :                                  /* 会計5 */
        case   FuncKey.KY_CHA7    :                                  /* 会計7 */
        case   FuncKey.KY_CHA8    :                                  /* 会計8 */
        case   FuncKey.KY_CHA9    :                                  /* 会計9 */
        case   FuncKey.KY_CHA10   :                                  /* 会計10 */
          String kyName = option is PresetInfo ? option.kyName : '';
          int presetCd = option is PresetInfo ? option.presetCd : 0;
          await selectedCha(funcKey, kyName, presetCd);
          break;  /* 会計10 */
        case   FuncKey.KY_CHA6    :                                  /* 会計6 */
          //　コード決済
          Get.to(() => CodePaymentScreen(title: "コード決済でお支払い"));
          break;
        case FuncKey.KY_STAFF:
         //従業員
          RcKyStf.openStaffInputDialog();
        case FuncKey.KY_CNCL: 
          //取消.
            CancelProcessHandler().cancelProcessDialog();
        case FuncKey.KY_MBR:
          // 会員呼出
          String title = option is PresetInfo ? option.kyName : '会員呼出';
          Rcmbrkymbr.openMbrPage(title);
        case FuncKey.KY_CHGREF:
          // 釣機参照
          String title = option is PresetInfo ? option.kyName : '釣機参照';
          RckyCrefDummy.openCrefPage(title);
                  case FuncKey.KY_DRWCHK:
          // 差異ﾁｪｯｸ
          String title = option is PresetInfo ? option.kyName : '差異ﾁｪｯｸ';
          RckyDifCheck.openDifCheckPage(title, funcKey);

        case FuncKey.KY_PICK: //  売上回収:
          // 売り上げ回収
          String title = option is PresetInfo ? option.kyName : '売上回収';
          RckySalesCollection.openSalesCollection(title, funcKey);
          
        case FuncKey.KY_CHGCIN: /* 釣機入金 */
        case FuncKey.KY_CIN1: /* 入金1 */
        case FuncKey.KY_CIN2: /* 入金2 */
        case FuncKey.KY_CIN3: /* 入金3 */
        case FuncKey.KY_CIN4: /* 入金4 */
        case FuncKey.KY_CIN5: /* 入金5 */
        case FuncKey.KY_CIN6: /* 入金6 */
        case FuncKey.KY_CIN7: /* 入金7 */
        case FuncKey.KY_CIN8: /* 入金8 */
        case FuncKey.KY_CIN9: /* 入金9 */
        case FuncKey.KY_CIN10: /* 入金10 */
        case FuncKey.KY_CIN11: /* 入金11 */
        case FuncKey.KY_CIN12: /* 入金12 */
        case FuncKey.KY_CIN13: /* 入金13 */
        case FuncKey.KY_CIN14: /* 入金14 */
        case FuncKey.KY_CIN15: /* 入金15 */
        case FuncKey.KY_CIN16: /* 入金16 */
          String title = option is PresetInfo ? option.kyName : '';
          RcKyccin.openCinPage(title, funcKey);
        case FuncKey.KY_CHGOUT: // 釣機払出
        case FuncKey.KY_OUT1: //  支払1
        case FuncKey.KY_OUT2: //  支払2
        case FuncKey.KY_OUT3: //  支払3
        case FuncKey.KY_OUT4: //  支払4
        case FuncKey.KY_OUT5: //  支払5
        case FuncKey.KY_OUT6: //  支払6
        case FuncKey.KY_OUT7: //  支払7
        case FuncKey.KY_OUT8: //  支払8
        case FuncKey.KY_OUT9: //  支払9
        case FuncKey.KY_OUT10: //  支払10
        case FuncKey.KY_OUT11: //  支払11
        case FuncKey.KY_OUT12: //  支払12
        case FuncKey.KY_OUT13: //  支払13
        case FuncKey.KY_OUT14: //  支払14
        case FuncKey.KY_OUT15: //  支払15
        case FuncKey.KY_OUT16: //  支払16
          String title = option is PresetInfo ? option.kyName : '';
          RckyOutDummy.openCoutPage(title, funcKey);
        case FuncKey.KY_RCPT_VOID:
          // 通番訂正
          String title = option is PresetInfo ? option.kyName : '通番訂正';
          RckyRfdopr.openReceiptScanPage(title, funcKey);
        case FuncKey.KY_SRCHREG:
          // 検索登録
          String title = option is PresetInfo ? option.kyName : '検索登録';
          RckySrchreg.openSearchRegistrationPage(title, funcKey);
        case FuncKey.KY_EJCONF:
          // 記録確認
          String title = option is PresetInfo ? option.kyName : '記録確認';
          RcKeyEjConf.openRecordConfirmation(title);
        case FuncKey.KY_2PERSON:
          // 2人制
          await DualCashierUtil.key2Person();
        case FuncKey.KY_RFDOPR:
          // 返品
          String title = option is PresetInfo ? option.kyName : '返品';
          ReturnPageWidget.returnConfirmation(title);
        case FuncKey.KY_ERCTFM:
          // 検索領収書
          await RckyErctfm.rcKyERctfm();
        case FuncKey.KY_QCSELECT:
        case FuncKey.KY_QCSELECT2:
        case FuncKey.KY_QCSELECT3:
         // QC指定
         RcKyQcSelect.rcKyQcSelect();
        case FuncKey.KY_QC_NOTPAY_LIST:  
         // 未清算一覧
         RckyQcNotPayList.rcKyQcNotPayList();
        case FuncKey.KY_MG:
        /// プリセットキーのPLUに設定がなく、小分類コードのみ登録されている場合は
        /// 小分類登録画面を呼び出し
          if(option != null && option.kyPluCd == "" && option.kySmlclsCd > 0) {
            /// 小分類登録画面を呼び出し
            Get.to(
              MGLoginPage(initialMGIndex: option.kySmlclsCd.toString(), title: MGTitleConstants.mgTitle),

            );
          } else {
            // 小分類
            RcKyMg.rcKyMg();
          }
        case FuncKey.KY_MDL:
          // 中分類
          RcKyMdl.rcKyMdl();
        case FuncKey.KY_MUL:
          // ×
          RckyMul.rcKyMul();   
        case FuncKey.KY_PRC:
          // 金額
          RcKyPrc.rcKyPrc();
        case FuncKey.KY_PCHG:
          // 価格変更
          RcKyPrcChg.rcKyPrcChg();
          // 値引・割引
        case FuncKey.KY_DSC1: /// 値引1
        case FuncKey.KY_DSC2: /// 値引2
        case FuncKey.KY_DSC3: /// 値引3
        case FuncKey.KY_DSC4: /// 値引4
        case FuncKey.KY_DSC5: /// 値引5
        case FuncKey.KY_PM1: /// 値引1
        case FuncKey.KY_PM2: /// 値引2
        case FuncKey.KY_PM3: /// 値引3
        case FuncKey.KY_PM4: /// 値引4
        case FuncKey.KY_PM5: /// 値引5
          String currentRoute = Get.currentRoute;
          if (currentRoute == RegisterPage.register.routeName ||
              currentRoute == RegisterPage.tranining.routeName) {
            KeyPressController keyPressCtrl = Get.find();
            RegisterBodyController registerBodyController = Get.find();
            await registerBodyController.manualDiscount(funcKey, keyPressCtrl.funcKeyValue.value);
            keyPressCtrl.resetKey();
          } else {
            String keyName = '';
            AcMem cMem = SystemFunc.readAcMem();
            RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
            if (xRet.isValid()) {
              /// 共有メモリの取得に成功した場合はファンクションキーのDB情報を使用する
              RxCommonBuf pCom = xRet.object;
              keyName = pCom.dbKfnc[cMem.stat.fncCode].fncName;
            }
            String title = option is PresetInfo
                ? option.kyName
                : keyName;
            await RckyDsc.openDscSetPage(title, funcKey);
          }
        case FuncKey.KY_WORKIN:
          // 業務宣言
          if (CompileFlag.DEPARTMENT_STORE) {
            RckyWorkin.rcKyWorkin(0);
          } else {
            await RcKyBrand.rcKyBrnd(FuncKey.KY_WORKIN);
          }
          break;
        case FuncKey.KY_CHGPICK:
          // つり機回収
          String title = option is PresetInfo ? option.kyName : 'つり機回収';
          RcKyCpick.openDifCheckPage(title,funcKey);
        case FuncKey.KY_CAT_CARDREAD: // 端末読込
          String title = option is PresetInfo ? option.kyName : '会員選択';
          RcKyCatCardRead.openDeviceLoadingPage(title);
          break;
        case FuncKey.KY_PRECA_IN:
          // プリカ宣言
          if (await RcSysChk.rcChkMsrCtrlSystem()) {
            RcMsrCtrl.rcMsrCtrlMainProc(funcKey);
          } else if (rcInfoMem.rcRecog.recogTrkPreca != 0) {
            RcTrkPreca.rcKyTRKPrecaIn();
          } else if (rcInfoMem.rcRecog.recogRepicaSystem != 0) {
            RcRepica.rcKyRepicaIn();
          } else if (rcInfoMem.rcRecog.recogCogcaSystem != 0) {
            RcCogca.rcKyCogcaIn();
          } else if(rcInfoMem.rcRecog.recogValuecardSystem != 0) {
            RcValueCard.rcKyValueCardIn();
          } else if(rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) {
            RcAjsEmoney.rcKyAjsEmoneyIn();
          }
          // TODO 上記、空関数のため、一時的にif文外で画面遷移処理を記述
          WorkinController workinController = WorkinController();
          await workinController.onWorkinButtonPressed(ImageDefinitions.IMG_PRECA_IN);
          break;
        case FuncKey.KY_HCRDTIN:
          // ハウス宣言(自社クレジット宣言)
          if (await RcSysChk.rcChkMsrCtrlSystem()) {
            RcMsrCtrl.rcMsrCtrlMainProc(funcKey);
          } else {
            RcKyHcrdtin.rcKyHouseCrdtIn();
          }
          // TODO 上記、空関数のため、一時的にif文外で画面遷移処理を記述
          WorkinController workinController = WorkinController();
          await workinController.onWorkinButtonPressed(ImageDefinitions.IMG_HOUSE_IN);
          break;
        case FuncKey.KY_PRECA_REF:
          // プリカ残高照会
          if (await RcSysChk.rcChkMsrCtrlSystem()) {
            RcMsrCtrl.rcMsrCtrlMainProc(funcKey);
          } else if (rcInfoMem.rcRecog.recogTrkPreca != 0) {
            RcTrkPreca.rcKyTRKPrecaRef();
          } else if (rcInfoMem.rcRecog.recogRepicaSystem != 0) {
            RcRepica.rcKyRepicaRef();
          } else if (rcInfoMem.rcRecog.recogCogcaSystem != 0) {
            RcCogca.rcKyCogcaRef();
          } else if(rcInfoMem.rcRecog.recogValuecardSystem != 0) {
            RcValueCard.rcKyValueCardRef();
          } else if(rcInfoMem.rcRecog.recogAjsEmoneySystem != 0) {
            RcAjsEmoney.rcKyAjsEmoneyRef();
          }
          // TODO 上記、空関数のため、一時的にif文外で画面遷移処理を記述
          WorkinController workinController = WorkinController();
          await workinController.onWorkinButtonPressed(ImageDefinitions.IMG_PRECA_REF);
          break;
        case FuncKey.KY_MBRCLR: // 会員取消
          if (!RcMbrFlrd.isCalledMember()) {
            MsgDialog.show(
              MsgDialog.singleButtonDlgId(
                dialogId: DlgConfirmMsgKind.MSG_OPEERR.dlgId,
                type: MsgDialogType.error,
              ),
            );
            break;
          }

          MsgDialog.show(MsgDialog.twoButtonDlgId(
            dialogId: DlgConfirmMsgKind.MSG_FREE_MESSAGE.dlgId,
            replacements: [ImageDefinitions.IMG_CNCLCONF_MBR.imageData],
            type: MsgDialogType.info,
            leftBtnFnc: () async {
              Get.back();
              // 会員取消処理を実行する
              await RckyMbre.rcKyMbrRemoved();
            },
            leftBtnTxt: "はい",
            rightBtnFnc: () => Get.back(),
            rightBtnTxt: "いいえ",
          ));
          break;
        case FuncKey.KY_PRCCHK:
        case FuncKey.KY_PREPRC:
          // 価格確認
          RcKyPrc.rcKyPrePrc();
        case FuncKey.KY_CHGPTN: // 釣機両替
          MsgDialog.showNotImplDialog();
          break;
        default:
          await selectedFuncKey(funcKey);
          break;
      }
    }finally{
      // reset.
      SystemFunc.readAtSingl().inputbuf.Fcode = 0;
      AcMem cMem = SystemFunc.readAcMem();
      cMem.stat.fncCode = 0;
      _busy = false;
    }
  }

  /// ファンクションキーボタンが押されたときの処理.
  Future<void> selectedFuncKey(FuncKey key ) async {
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "push key:${key.name}");
    await funcMap[key]?.call();
  }

  /// pluボタンが押されたときの処理.
  Future<void> selectedPlu(String? pluCd) async {
    TprLog().logAdd(tid, LogLevelDefine.normal,
        "push key:${FuncKey.KY_PLU.name}:option=$pluCd");
    await funcMap[FuncKey.KY_PLU]?.call(pluCd);
  }

  /// 数字キーが押されたときの処理.
  void selectedNumber(FuncKey funcKey) async {
    if (funcNum == null) {
      return;
    }
    TprLog().logAdd(tid, LogLevelDefine.normal, "push key:${funcKey.name}");
    if(MsgDialog.isDialogShowing){
      TprLog().logAdd(tid, LogLevelDefine.normal, "push key:${funcKey.name} NG:  isDialogShowing");
      return; // メッセージダイアログ表示中は禁止.
    }
    await funcNum?.call(funcKey);
  }

  /// pluボタンが押されたときの処理.
  Future<void> selectedCha(FuncKey funcKey, String kyName, int presetCd) async {
    TprLog().logAdd(tid, LogLevelDefine.normal, "push key:${funcKey.name}");
    // 電子マネーか商品券か判定する
    if ((await RckyCha.rcChkMultiQPKeyOpt()) || (await RckyCha.rcChkMultiiDKeyOpt())) {
      await RckyCha.rcKyCharge();
    } else {
      await RckyCha.changeScreenGiftCertificate(funcKey, kyName);
    }
  }

  /// TODO:00010 長田 定義のみ追加
  /// 関連tprxソース:rc_key.c - rcScanner_Command_Proc()
  static void rcScannerCommandProc(int fncCode) {
    return ;
  }
}
