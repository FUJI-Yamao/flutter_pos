/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/regs/checker/rc_acracb.dart';
import 'package:flutter_pos/app/regs/checker/rc_depo_in_plu.dart';
import 'package:flutter_pos/app/regs/checker/rc_dpoint.dart';
import 'package:flutter_pos/app/regs/checker/rc_ext.dart';
import 'package:flutter_pos/app/regs/checker/rc_mbr_com.dart';
import 'package:flutter_pos/app/regs/checker/rc_reserv.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl.dart';
import 'package:flutter_pos/app/regs/checker/rc_stl_cal.dart';
import 'package:flutter_pos/app/regs/checker/rc_utcnctwork.dart';
import 'package:flutter_pos/app/regs/checker/rcfncchk.dart';
import 'package:flutter_pos/app/regs/checker/rcitmchk.dart';
import 'package:flutter_pos/app/regs/checker/rcky_mul.dart';
import 'package:flutter_pos/app/regs/checker/rcky_rfdopr.dart';
import 'package:flutter_pos/app/regs/checker/rcky_yao_detail.dart';
import 'package:flutter_pos/app/regs/checker/rckyccin.dart';
import 'package:flutter_pos/app/regs/checker/rcmg_dsp.dart';
import 'package:flutter_pos/app/regs/checker/rcnoteplu.dart';
import 'package:flutter_pos/app/regs/checker/rcqr_com.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_pos/app/inc/lib/if_acx.dart';
import 'package:flutter_pos/app/inc/lib/jan_inf.dart';
import 'package:flutter_pos/app/inc/lib/typ.dart';

import '../../../clxos/calc_api.dart';
import '../../../clxos/calc_api_data.dart';
import '../../../clxos/calc_api_result_data.dart';
import '../../common/cmn_sysfunc.dart';
import '../../common/date_util.dart';
import '../../fb/fb2gtk.dart';
import '../../inc/apl/compflag.dart';
import '../../inc/apl/fnc_code.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../inc/apl/rxregmem_define.dart';
import '../../inc/sys/tpr_dlg.dart';
import '../../inc/sys/tpr_log.dart';
import '../../lib/cm_jan/set_jinf.dart';
import '../../lib/cm_jan/set_zero.dart';
import '../../lib/cm_sys/cm_cksys.dart';
import '../../lib/if_acx/acx_com.dart';
import '../../ui/page/common/component/w_msgdialog.dart';
import '../../ui/page/manual_input/controller/c_keypresed_controller.dart';
import '../../ui/page/register/controller/c_registerbody_controller.dart';
import '../common/rx_log_calc.dart';
import '../inc/rc_mbr.dart';
import '../inc/rc_mem.dart';
import '../inc/rc_regs.dart';
import 'rc_clxos.dart';
import 'rc_set.dart';
import 'rcmbrkymbr.dart';
import 'rcsyschk.dart';

enum PluErr {
  none(""),
  failed("商品を登録できませんでした"), // 失敗した.
  noData("指定された商品は存在しません"), // 指定されたPLUのデータがなかった.
  sqlErr("DBに接続できませんでした"); // DBと接続できなかった.

  final String msg;
  const PluErr(this.msg);
  bool get isErr => this != none;
}

/// 関連tprxソース: rcky_plu.c
class RcKyPlu{

  final String _selectedPluCd;
  final int _selectedQty;
  static JANInfConsts lastJanType = JANInfConsts.JANtype;   // JANタイプ退避フラグ
  /// 二段バーコード用乗算個数（個数手入力×二段バーコード時に個数を保持する）
  static int twoLineBarcodeQty = 0;

  /// 客表画面が開かれている場合はtrue
  static bool customerScreen = true;

  static int loyLimitOverDlg = 0;	// ロイヤリティ制限個数超過登録: 0=非表示  1=表示中
  static int loyRegOverDlg = 0; // ロイヤリティオーバーエラー: 0=非表示  1=表示中
  static int callFlg = 0; // 0=PLUからの呼出  1=会員からの呼出

  static const barcodeDigit13 = 13;  // バーコード13桁
  static const barcodeDigit18 = 18;  // バーコード18桁
  static int deptMbrFlag = 0;
  static int staffOpen = 1; // 従業員オープン処理判別フラグ
  static int rcGtkTimerCinStart = 0;
  static Object? popMsgWin0;

  static int? clsNo; /// 小分類コード
  static int? clsVal; /// 小分類登録金額

  RcKyPlu(this._selectedPluCd, this._selectedQty);


  /// PLUボタンを押したときの処理.
  ///
  /// ■repeat処理について
  /// 本来はRepeaet処理ははtItemをまるっとコピーするものですが、、Dartではオブジェクトのディープコピーが簡単に出来ないため、
  /// プロトタイプ向けでは簡易的に、Normalの処理の中でDB取得部分を省く処理として実装しています.
  ///
  /// rcky_plu.c rcKyPlu
  Future<(bool,int,CalcResultItem?)> rcKyPlu({bool isPrcChk = false}) async {

    final stopWatch = Stopwatch();
    stopWatch.start();

   var result =  await rcKyPluClxos(isPrcChk: isPrcChk);

    stopWatch.stop();
    debugPrint('rcKyPlu()  ${stopWatch.elapsedMilliseconds}[ms]');

    return result;
  }

  /// PLUボタンを押したときの処理.
  ///
  /// ■repeat処理について
  /// 本来はRepeaet処理ははtItemをまるっとコピーするものですが、、Dartではオブジェクトのディープコピーが簡単に出来ないため、
  /// プロトタイプ向けでは簡易的に、Normalの処理の中でDB取得部分を省く処理として実装しています.
  ///
  /// rcky_plu.c rcKyPlu
  Future<(bool,int,CalcResultItem?)> rcKyPluClxos({bool isPrcChk = false}) async {

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.error, "PLU rxMemRead error");
      return (false, DlgConfirmMsgKind.MSG_INPUTERR.dlgId,null);
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();

    late CalcRequestParaItem req;
    if(RegsMem().lastRequestData == null || isPrcChk){
      // uuidを取得.
      var uuidC = const Uuid();
      // TODO:00001 日向 バージョンは適当.要検討.
      String uuid = uuidC.v4();

      var item = CalcRequestParaItem(compCd:pCom.dbRegCtrl.compCd,streCd: pCom.dbRegCtrl.streCd,uuid: uuid );
      if (isPrcChk) {
        req = item;
      } else {
        RegsMem().lastRequestData = item;
      }
    }
    if (!isPrcChk) {
      req = RegsMem().lastRequestData!;
    }

    req.macNo = pCom.dbRegCtrl.macNo;

    // 新しいデータを追加
    int seqNo = 1;
    if( RegsMem().lastResultData != null &&  RegsMem().lastResultData!.calcResultItemList != null){
      for (var data in RegsMem().lastResultData!.calcResultItemList!) {
        if (data.retSts != 0) {
          continue;
        }
        seqNo = data.seqNo! + 1;
      }
    }

    String pluCd = _selectedPluCd;
    String addOnCd = "";
    if (pluCd.length == barcodeDigit18) {
      pluCd = _selectedPluCd.substring(0, barcodeDigit13);
      addOnCd = _selectedPluCd.substring(barcodeDigit13, barcodeDigit18);
    }
    // JAN情報の設定
    RcSysChk.rcClearJanInf();
    cMem.working.janInf.code = SetZero.cmPluSetZero(pluCd);
    await SetJinf.cmSetJanInf(cMem.working.janInf, 1, RcRegs.CHKDGT_CALC);

    // 2段バーコードチェック
    if (checkTwoLineBarcode(cMem)) {
      // 2段バーコードのエラーチェック
      if (errorCheckTwoLineBarcode(cMem)) {
        await endBarcodeProc(cMem);
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "rcKyPluClxos:  An error occurred in errorCheckTwoLineBarcode.");
        return (false, DlgConfirmMsgKind.MSG_INPUTERR.dlgId, null);
      }
      // スキャンされたバーコードのJANタイプを保持
      lastJanType = cMem.working.janInf.type;

      // 2段バーコードのフラグセット、バーコード値セット
      if (setTwoLineBarcodeFlags(cMem, pluCd)) {
        if (!await RcSysChk.rcSGChkSelfGateSystem()) {
          //　フルセルフではない場合
          KeyPressController keyPressCtrl = Get.find<KeyPressController>();
          // 「2段バーコード入力待ち」表示を開始
          keyPressCtrl.startSecondBarcodeState();
          /// 個数が手入力されていた場合に個数を保持
          twoLineBarcodeQty = _selectedQty;
        }
        // １、２段ともに揃って無い場合は処理終了
        return (true, 0, null);
      }
      // ２段バーコードがすべて揃ったかのチェック
      final (bool isCompleted, String barcode1, String barcode2, int errNo) =
          await checkTwoLineBarcodeComplete(cMem);
      if (errNo != DlgConfirmMsgKind.MSG_NONE.dlgId) {
        await endBarcodeProc(cMem);
        TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
            "rcKyPluClxos:  An error occurred in checkTwoLineBarcodeComplete.");
        return (false, errNo, null);
      }
      // 2段バーコードが1、2段とも揃ったらリストに追加
      if (isCompleted) {
        req.itemList.add(ItemData(
            seqNo: seqNo,
            qty: twoLineBarcodeQty,
            type: 0,
            // 登録
            barcode1: barcode1,
            barcode2: barcode2,
            // スキャン時間.
            cnctTime: DateFormat(DateUtil.formatForDB).format(DateTime.now()),
            clsNo: 0,
            clsVal: 0));
      }
    } else if (clsNo != null || clsVal != null) {
      // 小分類手入力
      req.itemList.add(ItemData(
          seqNo: seqNo,
          qty: 1,
          type: 0,
          barcode1: '',
          // スキャン時間.
          cnctTime: DateFormat(DateUtil.formatForDB).format(DateTime.now()),
          clsNo: clsNo ?? 0,
          clsVal: clsVal ?? 0));
    } else {
      if (!await RcSysChk.rcSGChkSelfGateSystem()) {
        //　フルセルフではない場合
        KeyPressController keyPressCtrl = Get.find<KeyPressController>();
        if (keyPressCtrl.waitDisplayState) {
          await endBarcodeProc(cMem);
          TprLog().logAdd(Tpraid.TPRAID_CHK, LogLevelDefine.normal,
              "rcKyPluClxos:  keyPressCtrl.waitDisplayState:${keyPressCtrl.waitDisplayState}");
          // 「2段バーコード入力待ち」表示中に、2段バーコード以外が読み込まれた場合はエラー
          return (false, DlgConfirmMsgKind.MSG_INPUTERR.dlgId, null);
        }
      }
      // 2段バーコード以外のフラグ、バーコード値、アドオン値セット
      setBarcodeFlagsAddOn(cMem, pluCd, addOnCd);
      // 2段バーコード以外、リストに追加
      req.itemList.add(ItemData(
          seqNo: seqNo,
          qty: _selectedQty,
          type: 0,
          // 登録
          barcode1: _selectedPluCd,
          // スキャン時間.
          cnctTime: DateFormat(DateUtil.formatForDB).format(DateTime.now()),
          clsNo: 0,
          clsVal: 0));
    }
    endBarcodeProc(cMem);

    req.opeMode = RegsMem().tHeader.ope_mode_flg;
    req.refundFlag = RegsMem().refundFlag ? 1 : 0;
    req.posSpec = 0;// 通常状態
    final stopWatch = Stopwatch();
    stopWatch.start();

    CalcResultWithRawJson resultWithRawJson;
    CalcResultItem resultInAllCase;

    if(!RcClxosCommon.validClxos){
      resultWithRawJson = await RcClxosCommon.stabItem(req);
      resultInAllCase = resultWithRawJson.result;
    }else{
      if (isPrcChk) {
        resultInAllCase = await CalcApi.checkPrice(req);
        resultWithRawJson = CalcResultWithRawJson(rawJson:'{}', result:resultInAllCase);
      } else {
        resultWithRawJson = await CalcApi.loadItem(req);
        resultInAllCase = resultWithRawJson.result;
      }
    }
    stopWatch.stop();
    clsNo = null;
    clsVal = null;
    if (isPrcChk) {
      debugPrint('Clxos CalcApi.checkPrice()  ${stopWatch.elapsedMilliseconds}[ms]');
    } else {
      debugPrint('Clxos CalcApi.loadItem()  ${stopWatch.elapsedMilliseconds}[ms]');
    }
    // 全体のエラーIDを取得.
    int err = resultInAllCase.getErrId();
    if(err == 0){
      // 登録したアイテムのエラーIDを取得.
      err = resultInAllCase.calcResultItemList?.last.getErrId() ?? 0 ;
    }
    if (err != 0) {
      // 何らかのエラー.
      // エラーが出た商品を削除.
      req.itemList.removeLast();
      await rcKyPluEndProc();
      TprLog().logAdd(
          Tpraid.TPRAID_CHK, LogLevelDefine.error, "PLU ${resultInAllCase.errMsg}");
      return (false,err,null);
    }

    // 価格確認モードでは商品情報を参照するだけなので処理不要
    if (!isPrcChk) {
      RcClxosCommon.itemLoadAfterClxos(resultWithRawJson,sendCustomerScreen:customerScreen);
    }

    await rcKyPluEndProc();

    return (true,0,resultInAllCase);
  }

  /// 処理概要：2段バーコードのフラグ、バーコード値のセット
  /// パラメータ：AcMem cMem
  ///           String スキャンされたバーコード
  /// 戻り値：bool true 1段、2段ともに設定されていない状態
  ///           false 1段、2段ともに設定された状態
  ///           または、どの2段バーコードにも該当しなかった場合
  static bool setTwoLineBarcodeFlags(AcMem cMem, String scanBcd) {
    if (CompileFlag.CLOTHES_BARCODE) {
      // 衣料バーコードのフラグ、バーコード値のセット
      if ((cMem.working.janInf.type == JANInfConsts.JANtypeJan261) ||
          (cMem.working.janInf.type == JANInfConsts.JANtypeJan262)) {
        return setClothBarcodeFlags(cMem, scanBcd);
      }
    }
    if (CompileFlag.DISC_BARCODE) {
      // 値下バーコードの場合
      if ((cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu1) ||
          (cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu2)) {
        return setDiscountBarcodeFlags(cMem, scanBcd);
      }
    }
    return false;
  }

  /// 処理概要：衣料バーコードのフラグ、バーコード値のセット
  /// パラメータ：AcMem cMem
  ///           String スキャンされたバーコード
  /// 戻り値：bool true 1段、2段ともに設定されていない状態
  ///           false 1段、2段ともに設定された状態
  static bool setClothBarcodeFlags(AcMem cMem, String scanBcd) {
    cMem.clothesBar ??= ClothesBar();

    // 衣料バーコード1段目のフラグセット、バーコード値セット
    if (cMem.working.janInf.type == JANInfConsts.JANtypeJan261) {
      cMem.clothesBar?.clothesBar1Flg = "1";
      cMem.clothesBar?.clothesBarCd1 = scanBcd;
      if (cMem.clothesBar?.clothesBar2Flg == "1") {
        // 1、2段目ともに設定された場合
        cMem.clothesBar?.clothesBarFlg = "1";
      } else {
        return true;
      }
    }
    // 衣料バーコード2段目のフラグセット、バーコード値セット
    if (cMem.working.janInf.type == JANInfConsts.JANtypeJan262) {
      cMem.clothesBar?.clothesBar2Flg = "1";
      cMem.clothesBar?.clothesBarCd2 = scanBcd;
      if (cMem.clothesBar?.clothesBar1Flg == "1") {
        // 1、2段目ともに設定された場合
        cMem.clothesBar?.clothesBarFlg = "1";
      } else {
        return true;
      }
    }
    return false;
  }

  /// 処理概要：値下バーコードのフラグ、バーコード値のセット
  /// パラメータ：AcMem cMem
  ///           String スキャンされたバーコード
  /// 戻り値：bool true 1段、2段ともに設定されていない状態
  ///           false 1段、2段ともに設定された状態
  static bool setDiscountBarcodeFlags(AcMem cMem, String scanBcd) {
    cMem.dscBar ??= DscBar();

    // 値下バーコード1段目のフラグセット、バーコード値セット
    if (cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu1) {
      cMem.dscBar?.dscBar1Flg = "1";
      cMem.dscBar?.dscBarCd1 = scanBcd;
      if (cMem.dscBar?.dscBar2Flg == "1") {
        // 1、2段目ともに設定された場合
        cMem.dscBar?.dscBarFlg = "1";
      } else {
        return true;
      }
    }
    // 値下バーコード2段目のフラグセット、バーコード値セット
    if (cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu2) {
      cMem.dscBar?.dscBar2Flg = "1";
      cMem.dscBar?.dscBarCd2 = scanBcd;
      if (cMem.dscBar?.dscBar1Flg == "1") {
        // 1、2段目ともに設定された場合
        cMem.dscBar?.dscBarFlg = "1";
      } else {
        return true;
      }
    }
    return false;
  }

  /// 処理概要：2段バーコード以外のフラグ、バーコード値、アドオン値のセット
  /// パラメータ：AcMem cMem
  ///           String スキャンされたバーコード
  ///           String アドオン値
  /// 戻り値：なし
  static void setBarcodeFlagsAddOn(AcMem cMem, String scanBcd, String addOnCd) {
    cMem.magazineBar ??= MagazineBar();
    AtSingl atSing = SystemFunc.readAtSingl();

    // 定期刊行物（雑誌）バーコードのフラグ、バーコード値、アドオン値のセット
    if (cMem.working.janInf.type == JANInfConsts.JANtypeMagazine18) {
      cMem.magazineBar?.mgznBarFlg = "1";
      cMem.magazineBar?.mgznClsCode = cMem.working.janInf.clsCode;
      cMem.magazineBar?.mgznBarCd1_1 = scanBcd;
      atSing.inputbuf.ADcode = addOnCd;
    }
  }

  /// 処理概要：２段バーコードのチェック
  /// パラメータ：AcMem cMem
  /// 戻り値：bool true ２段バーコードである
  ///           false 2段バーコードではない
  static bool checkTwoLineBarcode(AcMem cMem) {
    if (CompileFlag.CLOTHES_BARCODE) {
      // 衣料バーコードの場合
      if ((cMem.working.janInf.type == JANInfConsts.JANtypeJan261) ||
          (cMem.working.janInf.type == JANInfConsts.JANtypeJan262)) {
        return true;
      }
      // 値下バーコードの場合
      if (CompileFlag.DISC_BARCODE) {
        if ((cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu1) ||
            (cMem.working.janInf.type == JANInfConsts.JANtypeDscPlu2)) {
          return true;
        }
      }
    }
    return false;
  }

  /// 処理概要：２段バーコードがすべて揃ったかのチェック
  ///         揃っている場合は、１段目バーコード、２段目バーコードの値も返却する
  /// パラメータ：AcMem cMem
  /// 戻り値：bool true ２段バーコードが揃った状態
  ///           false 2段バーコードが揃っていない
  ///       String バーコード1段目の値
  ///       String バーコード2段目の値
  ///       int メッセージID
  static Future<(bool, String, String, int)> checkTwoLineBarcodeComplete(AcMem cMem) async {
    if (CompileFlag.CLOTHES_BARCODE) {
      // 衣料バーコードがすべて揃ったかのチェック
      if (cMem.clothesBar?.clothesBarFlg == "1") {
        return (
        true,
        cMem.clothesBar!.clothesBarCd1,
        cMem.clothesBar!.clothesBarCd2,
        DlgConfirmMsgKind.MSG_NONE.dlgId
        );
      }
    }
    if (CompileFlag.DISC_BARCODE) {
      // 値下げバーコードがすべて揃ったかのチェック
      if (cMem.dscBar?.dscBarFlg == "1") {
        return (
        true,
        cMem.dscBar!.dscBarCd1,
        cMem.dscBar!.dscBarCd2,
        await setDiscountBarCordData(cMem)
        );
      }
    }
    return (false, "", "", DlgConfirmMsgKind.MSG_NONE.dlgId);
  }

  /// 処理概要：2段バーコードのエラーチェック
  /// パラメータ：AcMem cMem
  /// 戻り値：bool true エラーあり
  ///           false　エラーなし
  static bool errorCheckTwoLineBarcode(AcMem cMem) {
    if ((lastJanType == JANInfConsts.JANtypeDscPlu1) ||
        (lastJanType == JANInfConsts.JANtypeDscPlu2)) {
      if ((cMem.working.janInf.type != JANInfConsts.JANtypeDscPlu1) &&
          (cMem.working.janInf.type != JANInfConsts.JANtypeDscPlu2)){
        return true;
      }
    }
    return false;
  }

  /// 処理概要：値下バーコードのデータ設定
  /// パラメータ：AcMem cMem
  /// 戻り値：   int メッセージID
  static Future<int> setDiscountBarCordData(AcMem cMem) async {
    if (CompileFlag.DISC_BARCODE) {
      return await RcSet.rcSetDscBarData();
    }
    return DlgConfirmMsgKind.MSG_NONE.dlgId;
  }

  /// 処理概要：フラグリセット
  /// パラメータ：AcMem cMem
  /// 戻り値：なし
  static void clearBarCordFlags(AcMem cMem) {
    if (CompileFlag.CLOTHES_BARCODE) {
      // 衣料バーコードのフラグリセット
      cMem.clothesBar = ClothesBar();
    }
    if (CompileFlag.DISC_BARCODE) {
      // 値下バーコードのフラグリセット
      cMem.dscBar = DscBar();
    }
    // 雑誌バーコードのフラグリセット
    cMem.magazineBar = MagazineBar();
  }

  /// 処理概要：バーコード終了処理
  /// パラメータ：AcMem cMem
  /// 戻り値：なし
  static Future<void> endBarcodeProc(AcMem cMem) async {
    if (!await RcSysChk.rcSGChkSelfGateSystem()) {
      // フルセルフではない場合
      KeyPressController keyPressCtrl = Get.find<KeyPressController>();
      /// 売価変更手入力の場合は明細変更画面を表示後にリセット
      if (keyPressCtrl.currentMode.value != MKInputMode.priceChange) {
        // 「2段バーコード入力待ち」表示を終了
        keyPressCtrl.resetKey();
      }
    }
    // バーコードフラグのリセット
    clearBarCordFlags(cMem);
    // JANタイプ退避フラグのリセット
    lastJanType = JANInfConsts.JANtype;

    /// 二段バーコード用乗算個数をリセット
    twoLineBarcodeQty = 0;
  }

  /// 関連tprxソース: rcky_plu.c - rcKy_Plu_End_Proc
  Future<void> rcKyPluEndProc() async {
    await rcKyPluEnd();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "PLU rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();

    if (cMem.ent.errNo == 0) {
      if (await RcSysChk.rcCheckItemDetailAuto()) {
        if (((pCom.dbStaffopen.cshr_status == 1) &&
            (pCom.dbTrm.frcClkFlg == 1)) || (pCom.dbTrm.frcClkFlg == 0)) {
          if ((RcFncChk.rcCheckRegistration()) && (deptMbrFlag == 0)) {
            RckyYaoDetail.rcKyItmDetail(1);
          }
          deptMbrFlag = 0;
        }
      }
    }

    if (cMem.ent.errNo == 0) {
      if (await CmCksys.cmUTCnctSystem() != 0 &&
          RcFncChk.rcCheckRegistration() &&
          !RcFncChk.rcCheckScanCheck() &&
          (((mem.tTtllog.t100003.refundQty != 0 ||
              mem.tTtllog.t100003.refundAmt != 0) ||
              (mem.tHeader.ope_mode_flg == OpeModeFlagList.OPE_MODE_VOID)) &&
              (mem.tTtllog.t100001Sts.itemlogCnt == 1))) {
        RcUtcnctWork.rcUtcnctworkDraw(1);
      }
    }

    if ((cMem.ent.errNo == 0) && (await RcFncChk.rcChkDPointOrgTran() != 0)) {
      await RcDpoint.rcdPointOrgTranSet();
    }

    if (CompileFlag.BDL_PER) {
      if (cMem.ent.errNo == 0) {
        if (((await CmCksys.cmIchiyamaMartSystem() != 0)
            || (await RcSysChk.rcChkSchMultiSelectSystem()))
            && (await RcFncChk.rcCheckRegAssistPChgMode()) // ０円商品の売価変更画面
            && !(RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))
            && !(RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_VOID.keyId]))
            && !(RcFncChk.rcCheckScanCheck())) {
          if (await RckyMul.rcChkKyMulBusyIchiyama(
              cMem.working.dataReg.kMul1)) {
            cMem.working.dataReg.kMul1++;
            rcKyPlu();
          }
          else {
            if (cMem.scrData.mulkey != 0) {
              cMem.working.dataReg.kMul1++;
              RcSet.rcClearRepeatBuf();
            }
            await RcSet.rcClearDataReg();
            RcSet.rcClearPluReg();
          }
        }
      }
    }
    return;
  }

  /// 関連tprxソース: rcky_plu.c - rcKy_Plu_End
  static Future<void> rcKyPluEnd() async {
    int tmpFncCode;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      TprLog().logAdd(
          await RcSysChk.getTid(), LogLevelDefine.error, "PLU rxMemRead error");
      return;
    }
    RxCommonBuf pCom = xRet.object;
    AcMem cMem = SystemFunc.readAcMem();
    RegsMem mem = SystemFunc.readRegsMem();
    AtSingl atSing = SystemFunc.readAtSingl();

    if (RcFncChk.rcCheckScanWtCheck()) {
      return;
    }
    if (RcmgDsp.rcNonPluDspChk() != 0) {
      return;
    }
    if (await RcFncChk.rcCheckRegAssistPChgMode()) {
      if ((RckyRfdopr.rcRfdOprCheckManualRefundMode()) // 手動返品
          && (RcSysChk.rcCheckTECOperation() != 0)) // 寺岡標準操作でない
          {
        RcRegs.kyStR0(cMem.keyStat, FuncKey.KY_REF.keyId);
      }
      return;
    }
     Onetime().nonPFLData  = NonFlData();

    if (CompileFlag.BDL_PER) {
      if ((!((await CmCksys.cmIchiyamaMartSystem() != 0)
          || (await RcSysChk.rcChkSchMultiSelectSystem())))
          || (((await CmCksys.cmIchiyamaMartSystem() != 0)
              || (await RcSysChk.rcChkSchMultiSelectSystem()))
              && !(await RckyMul.rcChkKyMulBusyIchiyama(
                  cMem.working.dataReg.kMul1 - 1)))) {
        tmpFncCode = cMem.stat.fncCode;
        // before no item check
        if (mem.tTtllog.t100001Sts.itemlogCnt > 0) {
          if (RcStl.rcChkItmRBufNotePlu(
              mem.tTtllog.t100001Sts.itemlogCnt - 1)) {
            cMem.stat.fncCode = FuncKey.KY_PLU.keyId;
          }
          if (RcStl.rcChkItmRBufBeniya(mem.tTtllog.t100001Sts.itemlogCnt - 1)) {
            cMem.stat.fncCode = FuncKey.KY_PLU.keyId;
          }
        }
        // 小計以上の金種商品を登録したときの確認ダイアログが出ている否かを判断
        if (RcNotePlu.rcNotePluConfDlgDspFlgChk() == 0) {
          RcqrCom.rcQRSystemOthToTxt(cMem.stat.fncCode);
        }
        cMem.stat.fncCode = tmpFncCode;
      }
    } else {
      tmpFncCode = cMem.stat.fncCode;
      // before no item check
      if (mem.tTtllog.t100001Sts.itemlogCnt > 0) {
        if (RcStl.rcChkItmRBufNotePlu(
            mem.tTtllog.t100001Sts.itemlogCnt - 1)) {
          cMem.stat.fncCode = FuncKey.KY_PLU.keyId;
        }
        if (RcStl.rcChkItmRBufBeniya(mem.tTtllog.t100001Sts.itemlogCnt - 1)) {
          cMem.stat.fncCode = FuncKey.KY_PLU.keyId;
        }
      }
      // 小計以上の金種商品を登録したときの確認ダイアログが出ている否かを判断
      if (RcNotePlu.rcNotePluConfDlgDspFlgChk() == 0) {
        RcqrCom.rcQRSystemOthToTxt(cMem.stat.fncCode);
      }
      cMem.stat.fncCode = tmpFncCode;
    }
    RcSet.rcClearEntry();
    if (!await RcFncChk.rcCheckRegAssistPChgMode()) {
      if ((((RcSysChk.rcCheckTECOperation() == 0) &&
          (!await RcFncChk.rcCheckPriceMagazine())) ||
          ((!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_VOID.keyId])) &&
              (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId])))) &&
          (await RcmgDsp.rcChkMgNonPluDsp(0) == 0)) {
        RcSet.rcClearPluReg();
      }
      if (RcFncChk.rcChkErrNon()) {
        RcSet.rcClearDataReg();
        if (staffOpen == 0) {
          // PLUキーの動作が従業員オープンでない場合
          await rcAfterRegCinStartProc();
        }
      }
    }

    if (atSing.halfWinFlg == 1) {
      // rcHalfMsg_Destroy2(); //描画処理なので移植しない
      atSing.halfWinFlg = 0;
    }

    atSing.reductVoidCouponFlg = 0;
    if (CompileFlag.DISC_BARCODE) {
      if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_WIZSTART.keyId])) {
        await RcSet.rcClearKyItem();
        RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_WIZSTART.keyId);
      }
      else if (await RcItmChk.rcCheckItemReductCoupon()) {
        await RcSet.rcClearKyItem();
        RcSet.rcClearRepeatBuf();
        RcRegs.kyStS1(cMem.keyStat, FuncKey.KY_CLR.keyId);
      }
      else {
        await RcSet.rcClearKyItem();
      }
    }
    else {
      if (RcRegs.kyStC0(cMem.keyStat[FuncKey.KY_WIZSTART.keyId])) {
        await RcSet.rcClearKyItem();
        RcRegs.kyStS0(cMem.keyStat, FuncKey.KY_WIZSTART.keyId);
      }
      else {
        await RcSet.rcClearKyItem();
      }
    }

    if (CompileFlag.FRESH_BARCODE) {
      if ((cMem.freshBar?.freshFlg == 0) || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
        RcSet.rcClearFreshBar();
      }
    }
    if (CompileFlag.DISC_BARCODE) {
      if ((cMem.dscBar?.dscBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
        RcSet.rcClearDscBar();
      }
    }
    if (CompileFlag.BOOK_BARCODE) {
      if ((cMem.bookBar?.bookBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
        RcSet.rcClearBookBar();
      }
    }
    if (CompileFlag.CLOTHES_BARCODE) {
      if ((cMem.clothesBar?.clothesBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
        RcSet.rcClearClothesBar();
      }
    }
    if ((cMem.magazineBar?.mgznBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearMagazineBar();
    }
    if ((cMem.itfBar?.itfBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearItfBar();
    }
    if (CompileFlag.SALELMT_BAR) {
      if ((cMem.sallmtBar?.sallmtBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
        RcSet.rcClearSalLmtBar();
      }
    }
    if ((cMem.gs1Bar?.gs1barFlg == 0) || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearGs1Bar();
    }
    if ((cMem.benefitBar?.couponBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearBenefitBar();
    }
    if ((cMem.cardforgetBar?.forgetBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearCardForgetBar();
    }
    if ((cMem.rptagBar?.rptagBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearRedPriceTagBar();
    }
    if ((cMem.gnBar?.goodsnumBarFlg == "") || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcClearGoodsNumBar();
    }

    if ((cMem.ayahaBar?.giftPointBarFlg == "")
        || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcSet.rcSetAyahaGiftPointClear();
    }

    if (RcSysChk.rcChkWSSystem()) {
      RcSet.rcClearWsUsedItemInfo();
    }
    RcSet.rcClearDivdata();

    if ((!RcItmChk.rcCheckProd2StItem()) || (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId]))) {
      RcItmChk.rcClearProdBar2St();
    }

    if (!RcDepoInPlu.rcCheckDepoInPluItem()) {
      RcDepoInPlu.rcClearDepoInPluBar();
    }
    else {
      if (cMem.ent.errNo == 0) {
        RcDepoInPlu.rcDepoInPluSet();
        if (cMem.ent.errNo != 0) {
          mem.tTtllog.t100001Sts.itemlogCnt--;
          StlItemCalcMain.rcStlItemCalcMain(RcStl.STLCALC_INC_MBRRBT);
          // rcDepoControlIdiCncl_Item_Reset();  // 描画処理なので移植しない
          if (mem.tTtllog.t100001Sts.itemlogCnt == 0) {
            if ((await RcMbrCom.rcmbrChkStat() != 0) &&
                (mem.tTtllog.t100700.mbrInput == MbrInputType.nonInput.index))
            {
              RcRegs.kyStR0(cMem.keyStat, FncCode.KY_REG.keyId);
              RcRegs.kyStR1(cMem.keyStat, FncCode.KY_REG.keyId);
              RcRegs.kyStS3(cMem.keyStat, FncCode.KY_FNAL.keyId);
            }
          }
          cMem.stat.fncCode = FuncKey.KY_UP.keyId;
          // rcKyUp();　// 描画処理なので移植しない
          cMem.stat.fncCode = FuncKey.KY_DOWN.keyId;
          // rcKyDown();　// 描画処理なので移植しない
          if (await RcSysChk.rcChkRegAssistSystem()) {
            // rcKy_CollectKey(); // 描画処理なので移植しない
          }
        }
      }
      RcDepoInPlu.rcClearDepoInPluBar();
    }

    if ((RcSysChk.rcSysChkPublicBarcodePay3System() != 0)
        && (pCom.dbKfnc[FuncKey.KY_READ_MONEY.keyId].opt.readMoney.bar1ExpdateDisp != 0)) {
      RcSet.rcClearPublicBar3Expdate();
    }
  }

  /// 関数：rc_AnyTime_CinStart_Proc(void)
  /// 機能：対面セルフ常時入金仕様の制御
  /// 戻値：なし
  /// 関連tprxソース: rcky_plu.c - rc_AnyTime_CinStart_Proc
  static Future<void> rcAnyTimeCinStartProc() async {
//	short  itemcnt_chk;
    String log = '';
    int resetFlg = 0;
    String callFunc = 'rcAnyTimeCinStartProc';
    AcMem cMem = SystemFunc.readAcMem();
    AtSingl atSing = SystemFunc.readAtSingl();
    RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRetC.isInvalid()) {
      return;
    }
    RxCommonBuf cBuf = xRetC.object;

    if (RcSysChk.rcChkAcrAcbAnyTimeCinStart()) {
      resetFlg = 0;
      // TODO:00013 三浦 ここは通らないため実装保留
      // rcGtkTimerRemoveCinStart();

      if (cBuf.auto_stropncls_run != 0) {
        log = sprintf("%s : no action because auto_stropncls_run[%i]\n",
            [callFunc, cBuf.auto_stropncls_run]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      if (cMem.acracbFirstAnswer != Typ.OK) {
        log = sprintf("%s : no action because acracb_first_answer[%i]\n",
            [callFunc, cMem.acracbFirstAnswer]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      if (cMem.ent.docMemStat != '0') {
        if (cMem.ent.docMemStat != '11') {
          // 釣銭機設定コマンドはOK
          log = sprintf("%s : no action because doc_mem_stat[%i]\n",
              [callFunc, cMem.ent.docMemStat]);
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return;
        }
      }

      if (cBuf.dbTrm.frcClkFlg != 0) {
        if (cBuf.dbStaffopen.cshr_status == 0) {
          /* 簡易従業員クローズ中には動作させない */
          log = sprintf("%s : no action because cshr_status[%i]\n",
              [callFunc, cBuf.dbStaffopen.cshr_status]);
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return;
        }
      }

      if (atSing.fselfInoutChk == 1) {
        log = sprintf("%s : no action because fself_inout_chk[%i]\n",
            [callFunc, atSing.fselfInoutChk]);
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      // TODO:00013 三浦 ここは通らないため実装保留
      // if (rcCheck_ScanCheck()) {
      //   log = sprintf("%s : no action because ScanCheck now!!\n", [callFunc]);
      //   TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
      //   return;
      // }

      // TODO:00013 三浦 ここは通らないため実装保留
      // if ((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER ||
      //         await RcSysChk.rcCheckQCJCSystem()) &&
      //     !await RcSysChk.rcSGChkSelfGateSystem() &&
      //     !await RcSysChk.rcQCChkQcashierSystem() &&
      //     rcChk_AutoDecision_System() &&
      //     await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL &&
      //     !RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId]) &&
      //     !RcRegs.kyStC1(cMem.keyStat[FncCode.KY_REG]) &&
      //     (await CmCksys.cmReservSystem() == 0 &&
      //         !RcFncChk.rcCheckReservMode() &&
      //         RcReserv.rcReservItmAddChk()) &&
      //     (cMem.ent.errStat != 1)) {
      //   rc_AfterReg_Start_Ccin();
      //   if (tsBuf.chk.chk_registration == 1) {
      //     resetFlg = 1;
      //   }
      //
      //   if (!rcCheck_Chkr_Sus()) {
      //     resetFlg = 1;
      //   }

      if (resetFlg == 1) {
        await RcSet.cashStatReset2(callFunc);
      }
    }
  }

  /// ロイヤリティ制限個数超過登録を行ったときのメッセージ表示
  /// 引数: 0=PLU  1=会員
  /// 関連tprxソース: rcky_plu.c - rcPlu_LoyLimitOverDlg
  static Future<void> rcPluLoyLimitOverDlg(int flg) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        'rcPlu_LoyLimitOverDlg Show');

    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_LOY_LIMIT_OVER.dlgId,
        btnTxt: '確認',
        btnFnc: rcPluLoyLimitOverDlgRegi,
      ),
    );
  }

  /// ロイヤリティ制限個数超過登録を行ったときのメッセージ表示(「登録」押下)
  /// 引数: 0=PLU  1=会員
  /// 関連tprxソース: rcky_plu.c - rcPlu_LoyLimitOverDlg_Regi
  static Future<void> rcPluLoyLimitOverDlgRegi() async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        'rcPlu_LoyLimitOverDlg_Regi');

    TprDlg.tprLibDlgClear('rcPluLoyLimitOverDlgRegi');
    loyLimitOverDlg = 0;

    RegsMem mem = SystemFunc.readRegsMem();
    int itmCnt = mem.tTtllog.t100001Sts.itemlogCnt - 1;
    if (itmCnt < 0) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error,
          'RcKyPlu.rcPluLoyLimitOverDlgRegi(): before no item');
    }

    // 既に登録を押した商品かを後で判断できるようにするためフラグセット
    for (int i = 0; i <= itmCnt; i++) {
      if (mem.tItemLog[i].t10000.pluCd1_2 != mem.tItemLog[itmCnt].t10000.pluCd1_2) {
        mem.tItemLog[i].t10000Sts.loyLimitOverRegFlg = 1;
      }
    }

    if (callFlg == 1) {
      // MBR
      await Rcmbrkymbr.rcmbrProcDlgAndSound(
          MbrDlgChkOrder.MBRDLG_ORDER_LOYREGOVER);
    } else {
      // PLU
      rcPluDlgProc(PluDlgChkStep.PLUDLG_STEP_LOYLIMITOVER_END,
          PluDlgItemType.PLUDLG_ITEM_NONE);
    }
  }

  /// ロイヤリティオーバーエラーメッセージ表示
  /// 引数: 0=PLU  1=会員
  /// 関連tprxソース: rcky_plu.c - rcPlu_LoyRegOverDlg
  static Future<void> rcPluLoyRegOverDlg(int flg) async {
    TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
        'rcPlu_LoyRegOverDlg Show');
    loyRegOverDlg = 1;
    callFlg = flg;

    MsgDialog.show(
      MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_LOY_REGOVER.dlgId,
        btnTxt: '確認',
        btnFnc: rcPluLoyRegOverDlgBtn,
      ),
    );
  }

  /// ロイヤリティオーバーエラーメッセージ表示（「確認」押下）
  /// 関連tprxソース: rcky_plu.c - rcPlu_LoyRegOverDlg_Btn
  static Future<void> rcPluLoyRegOverDlgBtn() async {
    loyRegOverDlg = 0;

    if (callFlg == 1) {
      // MBR
      await Rcmbrkymbr.rcmbrProcDlgAndSound(
          MbrDlgChkOrder.MBRDLG_ORDER_FANFARE);
    } else {
      // PLU
      rcPluDlgProc(PluDlgChkStep.PLUDLG_STEP_RBTMSG_END,
          PluDlgItemType.PLUDLG_ITEM_NONE);
    }
  }

  /// 関連tprxソース: rcky_plu.c - rcGtkTimerAddCinStart
  static int rcGtkTimerAddCinStart(int timer, Function func) {
    if (rcGtkTimerCinStart != -1) {
      return (DlgConfirmMsgKind.MSG_SYSERR.dlgId);
    }
    rcGtkTimerCinStart = Fb2Gtk.gtkTimeoutAdd(timer, func, 0);
    return (OK);
  }

  /// 関連tprxソース: rcky_plu.c - rcGtkTimerRemoveCinStart
  static int rcGtkTimerRemoveCinStart() {
    if (rcGtkTimerCinStart != -1) {
      Fb2Gtk.gtkTimeoutRemove(rcGtkTimerCinStart);
      rcGtkTimerInitCinStart();
    }
    return (OK);
  }

  /// 関連tprxソース: rcky_plu.c - rcGtkTimerInitCinStart
  static void rcGtkTimerInitCinStart() {
    rcGtkTimerCinStart = -1;
  }

  /// 関連tprxソース: rcky_plu.c - rc_AfterReg_Start_Ccin
  static Future<void> rcAfterRegStartCcin() async {
    int errNo;
    RcInfoMemLists rcInfoMem = RcInfoMemLists();
    AcMem cMem = SystemFunc.readAcMem();

    rcGtkTimerRemoveCinStart();
    Onetime().flags.fself_aft_start_timer = 0; //入金開始タイマー解除

    errNo = await RcAcracb.rcAcrAcbCinReadDtl();
    if (errNo == IfAcxDef.MSG_ACROK) {
      if ((rcInfoMem.rcCnct.cnctAcbDeccin == 4) &&
          (cMem.acbData.totalPrice == 0)) {
        if (await RcFncChk.rcChkCCINOperation()) {
          await RcKyccin.rcKyChgCin();
        }
      } else {
        await RcKyccin.rcKyChgCin();
      }
    } else {
      if ((AcxCom.ifAcbSelect() != 0 & CoinChanger.RT_300_X) &&
          (RcAcracb.rcChkAcrAcbFullErr(errNo))) {
        cMem.acbData.acbFullNodisp = 0; //フルエラー非表示制御解除(入金確定開始時はフルであればエラー表示したい)
      }
      await RcKyccin.ccinErrDialog2("rcAfterRegStartCcin", errNo, 0);
    }
  }

  /// 関連tprxソース: rcky_plu.c - rc_AfterReg_CinStart_Proc
  static Future<void> rcAfterRegCinStartProc() async {
    int errNo;
    String log = "";

    if (await RcFncChk.rcChkAcrAcbAfterRegCinStart()) {
      rcGtkTimerRemoveCinStart();

      if (RcFncChk.rcCheckScanCheck()) {
        log = "rcAfterRegCinStartProc : no action because scan check mode";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }
      AcMem cMem = SystemFunc.readAcMem();

      // 売価変更キー -> 商品登録 -> 金額キーでの商品登録仕様の場合 キーステイタスチェックでオペエラーになる為
      if (RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_PCHG.keyId])) {
        log = "rcAfterRegCinStartProc : no action because KY_PCHG\n";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      if (cMem.acracbFirstAnswer != OK) {
        log =
            "rcAfterRegCinStartProc : no action because acracb_first_answer[${cMem.acracbFirstAnswer}]";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      // リアル顧客仕様の会員呼出し時に、stl_tax_in_amt がクリアされない為、顧客バーコードを除外
      switch (cMem.working.janInf.type) {
        case JANInfConsts.JANtypeMbr8:
        case JANInfConsts.JANtypeMbr82:
        case JANInfConsts.JANtypeMbr13:
        case JANInfConsts.JANtypeMbr19Ikea:
        case JANInfConsts.JANtypeMbrNw7L:
          log =
              "rcAfterRegCinStartProc : no action because jan_inf_type[${cMem.working.janInf.type}]";
          TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
          return;
        default:
          break;
      }
      RegsMem mem = SystemFunc.readRegsMem();

      if (mem.tTtllog.t100001Sts.itemlogCnt > 0) {
        if ((!await RcNotePlu.rcChkNotePluItemDsp()) &&
            (RcItmChk.rcCheckNoteItmRec(mem
                .tItemLog[mem.tTtllog.t100001Sts.itemlogCnt - 1]
                .t10003
                .recMthdFlg))) {
          return;
        }
      }
      RxMemRet xRetC = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if (xRetC.isInvalid()) {
        return;
      }
      RxCommonBuf cBuf = xRetC.object;

      // RM-3800 「市場トラブル：14351」登録開始後入金設定
      //「釣機入金：商品取引開始後」で計量商品選択の状態の場合、「cMem.ent.errNo」はセットしているがrcErr()は実行していない為に、
      // rc_AfterReg_Start_Ccin()の処理を実行すると「釣機入金」になる事が発生した。
      if ((cMem.ent.errNo == DlgConfirmMsgKind.MSG_OPERR_WITEM.dlgId) &&
          (cBuf.vtclRm5900RegsOnFlg)) {
        log =
            "rcAfterRegCinStartProc : RM-5900 scale item select no act rc_AfterReg_Start_Ccin()";
        TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal, log);
        return;
      }

      if (CompileFlag.RESERV_SYSTEM) {
        if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
                (await RcSysChk.rcCheckQCJCSystem())) &&
            (!(await RcSysChk.rcSGChkSelfGateSystem())) &&
            (!(await RcSysChk.rcQCChkQcashierSystem())) &&
            (await RcSysChk.rcChkAutoDecisionSystem()) &&
            (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
            (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) &&
            (RxLogCalc.rxCalcStlTaxInAmt(mem) > 0) &&
            (!(await CmCksys.cmReservSystem() != 0 &&
                !RcFncChk.rcCheckReservMode() &&
                RcReserv.rcReservItmAdd())) &&
            (cMem.ent.errStat != 1)) {
          errNo = rcGtkTimerAddCinStart(500, rcAfterRegStartCcin);
          if (errNo != 0) {
            log = "rcAfterRegCinStartProc : Timer Error !!";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
            rcGtkTimerRemoveCinStart();
            await RcExt.rcErr("rcAfterRegCinStartProc", errNo);
          } else {
            Onetime().flags.fself_aft_start_timer = 1; //入金開始タイマー機動
          }
        }
      } else {
        if (((await RcSysChk.rcKySelf() != RcRegs.KY_CHECKER) ||
                (await RcSysChk.rcCheckQCJCSystem())) &&
            (!(await RcSysChk.rcSGChkSelfGateSystem())) &&
            (!(await RcSysChk.rcQCChkQcashierSystem())) &&
            (await RcSysChk.rcChkAutoDecisionSystem()) &&
            (await RcAcracb.rcCheckAcrAcbON(1) == CoinChanger.ACR_COINBILL) &&
            (!RcRegs.kyStC4(cMem.keyStat[FuncKey.KY_CHGCIN.keyId])) &&
            (RxLogCalc.rxCalcStlTaxInAmt(mem) > 0) &&
            (cMem.ent.errStat != 1)) {
          errNo = rcGtkTimerAddCinStart(500, rcAfterRegStartCcin);
          if (errNo != 0) {
            log = "rcAfterRegCinStartProc : Timer Error !!";
            TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.error, log);
            rcGtkTimerRemoveCinStart();
            await RcExt.rcErr("rcAfterRegCinStartProc", errNo);
          } else {
            Onetime().flags.fself_aft_start_timer = 1; //入金開始タイマー機動
          }
        }
      }
    }
  }

  /// 関連tprxソース: rcky_plu.c - rcPopMsg_Check
  static Future<int> rcPopMsgCheck() async {
    if (popMsgWin0 != null) {
      TprLog().logAdd(await RcSysChk.getTid(), LogLevelDefine.normal,
          "rcPopMsg_Check Now Popup");
      return 1;
    }
    return 0;
  }

  // TODO:00002 佐野 - checker関数実装のため、定義のみ追加（フロント側処理）
  /// 商品登録後のダイアログ表示をステップでまとめたもの
  /// 各関数の終了時(確定や閉じるボタン押下後)にPLUDLG_CHK_STEPをセットすることで、次のステップにいくことができる
  /// 引数:[step] enum PLUDLG_CHK_STEPをセット.
  /// 引数:[type] enum PLUDLG_ITEM_TYPEをセット. 途中のステップは0で良い.
  /// 関連tprxソース: rcky_plu.c - rcPlu_Dlg_Proc
  static void rcPluDlgProc(PluDlgChkStep step, PluDlgItemType type) {}

  /// 小分類登録情報をセット
  void setClsRegisterInfo(int setClsNo, int setClsVal){
    clsNo = setClsNo;
    clsVal = setClsVal;
  }

  //実装は必要だがARKS対応では除外
  // 関連tprxソース: rcky_plu.c - rcPlu_ChkCatalinaBarcode
  static int rcPluChkCatalinaBarcode(){
    return 0;
  }

}
