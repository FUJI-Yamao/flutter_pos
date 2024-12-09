/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/inc/apl/fnc_code.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/page/receipt_void/controller/c_receipt_scan_ctrl.dart';
import 'package:flutter_pos/app/ui/page/receipt_void/enum/e_input_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../colorfont/c_basecolor.dart';
import '../../component/w_sound_buttons.dart';
import '../common/basepage/common_base.dart';
import '../../controller/c_drv_controller.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/tpr_log.dart';
import '../common/component/w_msgdialog.dart';
import '../../../inc/sys/tpr_dlg.dart';
import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../common/cmn_sysfunc.dart';


/// 通番訂正/検索領収書スキャン画面
class ReceiptScanPageWidget extends CommonBasePage with RegisterDeviceEvent{
  ///コンストラクタ
  ReceiptScanPageWidget({super.key, required super.title, required super.funcKey}){
    // registrationEventを呼び出す
    registrationEvent();
  }

  ///コントローラー(仮)
  ReceiptScanController scanCtrl = Get.put(ReceiptScanController());

  /// スキャンしたバーコードをチェック中かどうか
  bool isCheckingData = false;

  /// バーコードの長さ 26桁+先頭の1桁
  static const _voidBarcodeLength = 26 + 1;

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: BaseColor.someTextPopupArea,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'レシートのバーコードを読み込んでください',
                  style: TextStyle(
                      fontSize: BaseFont.font28px, color: BaseColor.baseColor),
                ),
                 SizedBox(
                  height: 88.h,
                ),
                SvgPicture.asset(
                  'assets/images/illust_scanning.svg',
                  width: 480.w,
                  height: 276.h,
                ),
                 SizedBox(
                  height: 88.h,
                ),
                SizedBox(
                    width: 344.w,
                    height: 80.h,
                    child: SoundElevatedButton(
                      onPressed: () {
                        ///仮の支払方法別でラベル設定処理,最初はcash画面に、実行ボタン押すとquicPay画面へ
                        if (scanCtrl.currentPaymentType.value != PaymentType.cash) {
                          scanCtrl.currentPaymentType.value = PaymentType.cash;
                        }
                        PaymentType selectedPayment = PaymentType.cash;
                        List<ReceiptVoidInputFieldLabel> labels =
                        scanCtrl.onPaymentType(selectedPayment);
                        Get.toNamed('/receiptinputpage',arguments: [title,labels,funcKey]);
                      },
                      callFunc: runtimeType.toString(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColor.scanButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        shadowColor: BaseColor.scanBtnShadowColor,
                        elevation: 3,
                      ),
                      child: const Text(
                        'スキャンできない場合',
                        style: TextStyle(
                          fontSize: BaseFont.font22px,
                          color: BaseColor.someTextPopupArea,
                        ),
                      ),
                    ))
              ],
            ),
          ))
    ]);
  }

  /// スキャンコントローラ取得
  @override
  Function(RxInputBuf)? getScanCtrl() {
    return (data) async {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'data.devInf.barData:${data.devInf.barData}');
      scanVoid(data.devInf.barData);
    };
  }

  Future<void> scanVoid(String barData) async {
    if(isCheckingData){
      // 既に読みこんだものを処理中なら何もしない.
      return;
    }
    isCheckingData = true;

    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'バーコード:$barData');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'バーコード長:${barData.length}');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'バーコードスキャン処理開始');
    // 受け取ったバーコード値が先頭の文字を入れて27桁でない場合は1040バーコードフォーマットエラー　エラーダイアログを出す
    if(barData.length != _voidBarcodeLength){
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_BARFMTERR.dlgId,
        ),
      );
      isCheckingData = false;
      return;
    }
    // 受け取ったバーコード値を分解してインストアマーキングフラグに該当する２桁を抽出
    String inStoreMarking = barData.substring(1, 3);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'inStoreMarking:$inStoreMarking');
    // SELECT 文を発行しチェックし、インストアマーキングにそれがなければ1040バーコードフォーマットエラー　エラーダイアログを出す
    Result? localRes;
    Result? results;
    DbManipulationPs db = DbManipulationPs();
    String instoreCheckSQL = "SELECT count(*) AS cnt FROM c_instre_mst WHERE instre_flg = '$inStoreMarking'";
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'instoreCheckSQL:$instoreCheckSQL');
    localRes = await db.dbCon.execute(instoreCheckSQL);
    if ((localRes.isEmpty) || (localRes.affectedRows < 1)) {
       // インストアマーキングが存在しない場合
      MsgDialog.show(
        MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_BARFMTERR.dlgId,
        ),
      );
      isCheckingData = false;
      return;
    }
    // バーコード値から先頭4桁目から6桁の営業日を抽出
    String businessDay = barData.substring(3, 9);
    String formedBussinessDay = "${businessDay.substring(0, 2)}-${businessDay.substring(2, 4)}-${businessDay.substring(4, 6)}";  // yy-mm-dd
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'formedBussinessDay:$formedBussinessDay');
    // バーコード値から先頭10桁目から4桁のレシート番号を抽出　先頭の0を全て取り除く
    String receiptNumString = barData.substring(9, 13);
    int receiptNumber = int.parse(receiptNumString);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'receiptNumber:$receiptNumber');

    // バーコード値から先頭14桁目から9桁のレジ番号を抽出　先頭の0を全て取り除く
    String registerNumString = barData.substring(13, 22);
    int registerNumber = int.parse(registerNumString);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'registerNumber:$registerNumber');

    // バーコード値から先頭23桁目から4桁のジャーナル番号を抽出　先頭の0を全て取り除く
    String journalNumString = barData.substring(22, 26);
    int journalNumber = int.parse(journalNumString);
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'journalNumber:$journalNumber');

    // SELECT文を発行し合計金額を取得する
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      isCheckingData = false;
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'comp_cd:${cBuf.dbRegCtrl.compCd}');
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'stre_cd:${cBuf.dbRegCtrl.streCd}');

    String getAmtSQL = "SELECT n_data1 FROM c_data_log WHERE serial_no = (SELECT serial_no FROM c_header_log WHERE comp_cd = '${cBuf.dbRegCtrl.compCd}' AND stre_cd = '${cBuf.dbRegCtrl.streCd}' AND mac_no = '$registerNumber' AND receipt_no = '$receiptNumber'  AND print_no = '$journalNumber' AND sale_date = '$formedBussinessDay') AND func_cd = '100001'";
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'getAmtSQL:$getAmtSQL');
    results = await db.dbCon.execute(getAmtSQL);
    
    // これが取得できなかった場合、1449取引が存在しないか訂正できない実績です　エラーダイアログを出す
    if (results.isEmpty) {
        TprLog().logAdd(Tpraid.TPRAID_STR, LogLevelDefine.error,
            "合計金額が取得できませんでした。1449取引が存在しないか訂正できない実績です　を表示します。\n");
        MsgDialog.show(
          MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_REFOPR_NOT_FOUND.dlgId,
          ),
        );
        isCheckingData = false;
        return;
    }
    String amt;
    double amtD;
    int amount = 0;
    if (results.affectedRows == 1) {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'koko');

      Map<String, dynamic> data2 = results.first.toColumnMap();
      TprLog()
          .logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'data2:$data2');
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          'data2["n_data1"]:${data2["n_data1"]}');
      amt = data2["n_data1"];
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'amt:$amt');
      amtD = double.parse(amt);
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'amtD:$amtD');
      amount = amtD.toInt();
      TprLog()
          .logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'amount:$amount');
    } else {
      TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal,
          'results.affectedRows=${results.affectedRows}');
    }

    // 次の画面に渡す値をListに格納
    List<String> initValues = ["20${formedBussinessDay.replaceAll("-", "")}", registerNumber.toString(), receiptNumber.toString(), amount.toString()];
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'initValues:$initValues');
    // 通番訂正入力画面への画面遷移(初期表示値ありバージョン)
    if (scanCtrl.currentPaymentType.value != PaymentType.cash) {
      scanCtrl.currentPaymentType.value = PaymentType.cash;
    }
    PaymentType selectedPayment = PaymentType.cash;
    List<ReceiptVoidInputFieldLabel> labels =
    scanCtrl.onPaymentType(selectedPayment);
    isCheckingData = false;
    Get.toNamed('/receiptinputpage',arguments: [title,labels,funcKey,initValues]);
  }

  @override
  IfDrvPage getTag() {
      return IfDrvPage.receiptVoid;
  }
}
