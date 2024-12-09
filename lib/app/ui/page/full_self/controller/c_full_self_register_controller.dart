/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/number_util.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../common/component/w_msgdialog.dart';
import '../../customer/model/m_discount.dart';
import '../../customer/model/m_merchandise.dart';
import '../page/p_full_self_maintenance_page.dart';
import 'c_full_self_pay_complete_controller.dart';

/// フルセルフの商品登録画面のコントローラー
class FullSelfRegisterController extends GetxController {
  /// 合計金額
  final RxString totalAmount = '0'.obs;

  /// 合計点数の文字列
  final RxString totalQty = ''.obs;

  /// ポイント
  final RxString point = '0'.obs;

  /// 商品データリスト
  List<MerchandiseData> merchandiseDataList = <MerchandiseData>[];

  /// ポイント表示フラグ
  final RxBool flgPoint = false.obs;

  /// 返品モードフラグ
  RxBool refundFlag = false.obs;

  /// 取り消し表示判定用の値
  static const int itemTypeCancel = 1;

  ///お預かり金額
  final RxInt receiveAmount = 0.obs;

  ///現金支払い画面で入金した額
  RxInt changeReceivedAmount = 0.obs;

  ///不足金額
  final RxInt notEnough = 0.obs;

  ///お釣り金額
  final RxInt change = 0.obs;

  ///釣りモードを判断
  final RxBool isChangeMode = false.obs;

  ///釣り銭支払  0:あり 1:なし
  RxInt nochgFlg = 0.obs;

  ///金額を更新するメソッド
  void updateAmounts() {
    if (nochgFlg.value == 1) {
      notEnough.value = 0;
      change.value = 0;
    } else {
      notEnough.value = (int.tryParse(totalAmount.value) ?? 0) - receiveAmount.value - changeReceivedAmount.value;
      change.value = receiveAmount.value + changeReceivedAmount.value - (int.tryParse(totalAmount.value) ?? 0);
    }
    isChangeMode.value = receiveAmount.value + changeReceivedAmount.value >= (int.tryParse(totalAmount.value) ?? 0);
    if (receiveAmount.value + changeReceivedAmount.value >= (int.tryParse(totalAmount.value) ?? 0)) {
      // TODO:10159 フルセルフ 釣銭機入金対応のみの為一旦コメントアウト
      // currentPaymentMethod.value = 'paymentComplete';
    } else {
      // TODO:10159 フルセルフ 釣銭機入金対応のみの為一旦コメントアウト
      // currentPaymentMethod.value =
      // currentPaymentMethod.value == 'noChangeMachine'
      //     ? 'noChangeMachine'
      //     : 'haveChangeMachine';
    }
    playConfirmSound();
  }

  ///金額の日本円フォーマットメソッド
  String formatAmountFullSelf(String amount) {
    double parsedAmount = double.tryParse(amount.replaceAll(',', '')) ?? 0.0;
    return NumberFormatUtil.getNumberStr(
        NumberFormatUtil.formatForAmountStr, parsedAmount.toInt());
  }

  /// 確定ボタン出現時に音声出力
  void playConfirmSound() {
    // 支払い完了時のコントローラ
    final FullSelfPayCompleteController completeCtrl =
        Get.put(FullSelfPayCompleteController());

    if (changeReceivedAmount.value != 0 &&
        isChangeMode.value &&
        !completeCtrl.complete.value) {
      // ガイダンス音声番号から音声を出力
      RcSound.playFromSoundNum(
        soundNum: SoundDef.guidanceFullSelfPayChangeNumber,
        isLoop: true
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateAmounts();
  }


  @override
  void onReady() {
    super.onReady();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfRegisterNumber,
      isLoop: true
    );
  }

  /// フルセルフのメンテナンス画面に遷移
  void toMaintenance() {
    // ガイダンス音声の停止
    RcSound.stop();

    MsgDialog.show(
      MsgDialog.twoButtonDlgId(
        type: MsgDialogType.info,
        dialogId: DlgConfirmMsgKind.MSG_SG_MENTENANSE.dlgId,
        rightBtnFnc: () {
          Get.back();
          Get.to(() =>  FullSelfMaintenancePage());
        },
        leftBtnTxt: 'いいえ',    // 「はい」と「いいえ」を表示する
      ),
    );
  }

  /// 支払い方法選択画面に遷移する
  void toSelectPay() {
    // ガイダンス音声の停止
    RcSound.stop();

    Get.toNamed('/fullself_selectpay');
  }

  /// バーコードがない商品ボタンを押したときの処理
  void funcNoBarcodeItem() {
    // ガイダンス音声の停止
    RcSound.stop();

    // TODO: バーコードがない商品ボタンを押したときの処理の中身を作成する
  }

  // TODO: (テスト用)商品仮登録ボタンを押したときの処理。削除予定
  void funcTestButtonPushed() {
    // ガイダンス音声の停止
    RcSound.stop();

    IfDrvControl().scanIsolateCtrl.barcodeLoopbackIn("F4902777021294" + "\x0D");
  }

  /// リストデータの作成
  void setData(CalcResultItem calcResultItem) {
    merchandiseDataList.clear();

    // 返品フラグの判定
    refundFlag.value = judgeRefund(calcResultItem);

    // 受信したデータからリストを作成
    _createDataList(calcResultItem);

    // 合計点数
    _setTotalQty(calcResultItem);

    // ポイント
    // 会員情報があれば、ポイントをフォーマットしたものをsetする
    _setPoint(calcResultItem);

    // 合計金額
    // 合計金額のデータがあって、そのデータ内のリストが空でなければ、合計金額をフォーマットをsetする
    _setTotalAmount(calcResultItem);

    //金額を更新するメソッド
    updateAmounts();

    update();

    // ガイダンス音声番号から音声を出力
    RcSound.playFromSoundNum(
      soundNum: SoundDef.guidanceFullSelfRegisterAfterNumber,
      isLoop: true
    );
  }

  /// 返品フラグの判定
  /// refundFlagが0なら通常モード、refundFlagなら返品モード
  bool judgeRefund(CalcResultItem calcResultItem) {
    return calcResultItem.totalDataList?[0].refundFlag == 1;
  }

  /// 受信したデータからリストを作成
  void _createDataList(CalcResultItem calcResultItem) {
    if (calcResultItem.calcResultItemList != null) {
            // 順番を入れ替えるためオリジナルのコピーを作成する.
      List<ResultItemData> itemList = List.from(calcResultItem.calcResultItemList!);
      itemList.sort((a, b) {
        int seqNoA = a.seqNo ?? 0;
        int seqNoB = b.seqNo ?? 0;
        return seqNoB.compareTo(seqNoA);
      });
      for (int i = 0; i < itemList.length; i++) {
        if (itemList[i].retSts == 0) {
          int qty = itemList[i].qty ?? 0;
          int unitPrice = itemList[i].price ?? 0;
          int price = qty * unitPrice;
          List<ModelDiscountData> discountList = [];
          int type = itemList[i].type ?? 0;
          if (itemList[i].discountList != null) {
            List<DiscountData> allDiscountList = itemList[i].discountList!;
            for (int j = 0; j < allDiscountList.length; j++) {
              // 値引き成立している場合
              if (allDiscountList[j].formedFlg == 1) {
                int discountType = allDiscountList[j].type ?? 0;
                String discountName = allDiscountList[j].name ?? '';
                int discountPrice =  allDiscountList[j].discountPrice ?? 0;
                discountList.add(
                  ModelDiscountData(
                    discountType: discountType,
                    discountName: discountName,
                    discountPrice: discountPrice,
                  ),
                );
              }
            }
          }
          merchandiseDataList.add(
            MerchandiseData(
              name: itemList[i].name ?? '',
              price: price,
              discountList: discountList,
              qty: qty,
              type: type,
            ),
          );
        }
      }
    }
  }

  /// numを#,##0の形にフォーマットして返す
  String formatNumber(int num) {
    if (refundFlag.value) {
      num *= -1;
    }
    return NumberFormatUtil.getNumberStr(NumberFormatUtil.formatForAmountStr, num);
  }

  /// 会員のデータがあれば、ポイントをフォーマットしたものをsetする
  void _setPoint(CalcResultItem calcResultItem) {
    if (calcResultItem.custData != null) {
      int lastPoint = calcResultItem.custData!.lastPoint ?? 0;
      flgPoint.value = true;
      point.value = NumberFormatUtil.getNumberStr(NumberFormatUtil.formatForAmountStr, lastPoint);
    } else {
      flgPoint.value = false;
    }
  }

  /// 合計金額のデータがあって、そのデータ内のリストが空でなければ、合計金額をフォーマットをsetする
  void _setTotalAmount(CalcResultItem calcResultItem) {
    if (calcResultItem.totalDataList != null && calcResultItem.totalDataList!.isNotEmpty) {
      List<TotalData> totalDataList = calcResultItem.totalDataList!;
      int amount = totalDataList[0].amount ?? 0;
      // 合計金額
      totalAmount.value = NumberFormatUtil.getNumberStr(NumberFormatUtil.formatForAmountStr, amount);
    } else {
      totalAmount.value = '0';
    }
  }

  /// 合計点数のデータがあって、そのデータ内のリストが空でなければ、合計点数をフォーマットをsetする
  void _setTotalQty(CalcResultItem calcResultItem) {
    if (calcResultItem.totalDataList != null && calcResultItem.totalDataList!.isNotEmpty) {
      List<TotalData> totalDataList = calcResultItem.totalDataList!;
      int qty = totalDataList[0].totalQty ?? 0;
      // 合計点数
      totalQty.value = NumberFormatUtil.getNumberStr(NumberFormatUtil.formatForAmountStr, qty);
    } else {
      totalQty.value = '0';
    }
  }

  // TODO: 現在未使用→将来も使わなければ削除
  /// お客様側のクリア
  void clearData() {
    totalAmount.value = '0';
    totalQty.value = '';
    point.value = '';
    merchandiseDataList.clear();
    flgPoint.value = false;
    refundFlag.value = false;
    update();
  }

  /// oldItemMaxCountの数を計算する
  int calcOldItemMaxCount(double constraintsMaxHeight, double newItemHeight, double oldItemHeight) {
    // oldItemMaxCount = (リストの最大の高さ - newItemHeight(最新の商品明細の高さ)) / oldItemHeight（1行の高さ）をintに
    int oldItemMaxCount = ((constraintsMaxHeight - newItemHeight) / oldItemHeight).floor().toInt();
    return oldItemMaxCount;
  }

  /// 商品の金額をフォーマットされた文字列に変換する
  String getStrMerchandisePrice({required int itemRow}) {
    MerchandiseData merchandiseData = merchandiseDataList[itemRow];
    int displayedOldItemPrice = merchandiseData.price;
    if (merchandiseData.discountList.isNotEmpty) {
      for (int i = 0; i < merchandiseData.discountList.length; i++) {
        displayedOldItemPrice -= merchandiseData.discountList[i].discountPrice;
      }
    }
    if (refundFlag.value) {
      displayedOldItemPrice *= -1;
    }
    return NumberFormatUtil.formatAmount(displayedOldItemPrice);
  }

  /// 最新の商品明細で表示される値引の数を取得する
  int getDisplayedNewItemDiscountCount() {
    if (merchandiseDataList.isNotEmpty) {
      return merchandiseDataList[0].discountList.length;
    } else {
      return 0;
    }
  }

  /// 最新の商品明細の値引情報を取得する
  ModelDiscountData getModelDiscountData(int discountIndex) {
    return merchandiseDataList[0].discountList[discountIndex];
  }

  /// 取り消しがあったかどうかを判定
  bool judgeCancel(int itemRow) {
    return merchandiseDataList[itemRow].type == itemTypeCancel;
  }

  /// 値引タイプが特売でなく会員でないか、を判定
  bool judgeDiscountType(int discountIndex) {
    return getModelDiscountData(discountIndex).discountType != 1
        && getModelDiscountData(discountIndex).discountType != 8;
  }

  /// 値引き額を計算する
  int getDisplayedDiscountPrice(int discountIndex) {
    if (refundFlag.value) {
      return getModelDiscountData(discountIndex).discountPrice;
    } else {
      return (getModelDiscountData(discountIndex).discountPrice * -1);
    }
  }

}


