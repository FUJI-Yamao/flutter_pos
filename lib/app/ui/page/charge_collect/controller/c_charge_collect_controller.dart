/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/lib/if_acx.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../regs/checker/rc_acracb.dart';
import '../../../../regs/checker/rc_acracbdsp.dart';
import '../../../../regs/checker/rc_ext.dart';
import '../../../../regs/checker/rc_inout.dart';
import '../../../../regs/checker/rckycpick.dart';
import '../../../../regs/inc/rc_mem.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../p_charge_collect_select.dart';

/// つり機回収画面のコントローラ
class ChargeCollectController extends GetxController {
  /// コンストラクタ
  ChargeCollectController();

  /// 回収作業の進捗
  var progress = CollectProgress.doing.obs;

  /// 回収金額
  var collectPrice = 0.obs;

  /// カセット内金額
  var cassettePrice = 0.obs;

  /// 回収内容
  var collects = <Collect>[].obs;

  /// 選択した回収内容のインデックス番号
  var currentIndexOfInputCollects = defaultIndex;

  /// 選択した回収方法
  var selectedCollectType = CollectType.others.obs;

  /// 回収枚数のデフォルト値
  static const String defaultCollects = "0";

  /// 選択した回収内容のインデックス番号のデフォルト値
  static const int defaultIndex = -1;

  /// 金種の数
  static const int shtDataKinds = 10;

  /// 確定ボタンが押されたかどうか
  bool isDecision = false;

  @override
  Future<void> onInit() async {
    super.onInit();

    RcKyCpick.complete = true;
    AcMem cMem = SystemFunc.readAcMem();
    await RcAcracb.rcChkAcrAcbChkStock(0);
    CoinData tmpCollectsBefore = cMem.coinData;

    collects.addAll([
      Collect(
        bill: Bill.bill10000,
        collectsBefore: tmpCollectsBefore.holder.bill10000,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.bill10000,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill5000,
        collectsBefore: tmpCollectsBefore.holder.bill5000,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.bill5000,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill2000,
        collectsBefore: tmpCollectsBefore.holder.bill2000,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.bill2000,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill:Bill.bill1000,
        collectsBefore: tmpCollectsBefore.holder.bill1000,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.bill1000,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill500,
        collectsBefore: tmpCollectsBefore.holder.coin500,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin500,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill100,
        collectsBefore: tmpCollectsBefore.holder.coin100,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin100,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill50,
        collectsBefore: tmpCollectsBefore.holder.coin50,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin50,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill10,
        collectsBefore: tmpCollectsBefore.holder.coin10,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin10,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill5,
        collectsBefore: tmpCollectsBefore.holder.coin5,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin5,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
      Collect(
        bill: Bill.bill1,
        collectsBefore: tmpCollectsBefore.holder.coin1,
        collects: int.parse(defaultCollects),
        collectsAfter: tmpCollectsBefore.holder.coin1,
        inputKey: GlobalKey<InputBoxWidgetState>()
      ),
    ]);

    currentIndexOfInputCollects = 0;
    collects[currentIndexOfInputCollects].inputKey.currentState?.setCursorOn();
  }

  /// 回収枚数入力欄を押下した時のハンドラ
  void onTapInputCollects(int index) {
    for (var collect in collects) {
      collect.inputKey.currentState?.setCursorOff();

      var currentCollectState = collect.inputKey.currentState;
      var currentCollectStateValue = currentCollectState?.inputStr;

      // 未入力の項目にデフォルト値を設定する
      if (currentCollectStateValue == null || currentCollectStateValue == "") {
        currentCollectState?.onChangeStr(defaultCollects);
        continue;
      }

      // 入力を確定していない項目に、既に確定済みの値を設定する
      if (currentIndexOfInputCollects != defaultIndex && currentIndexOfInputCollects != index) {
        currentCollectState?.onChangeStr(collect.collects.toString());
        continue;
      }
    }

    currentIndexOfInputCollects = index;
    collects[currentIndexOfInputCollects].inputKey.currentState?.setCursorOn();
  }

  /// テンキーを入力した時のハンドラ
  Future<void> onTapTenKey(KeyType key) async {
    if (currentIndexOfInputCollects <= defaultIndex) {
      return;
    }

    switch (key) {
      case KeyType.delete: // 一文字削除
        collects[currentIndexOfInputCollects].inputKey.currentState?.onDeleteOne();
        break;
      case KeyType.clear: // 全削除
        collects[currentIndexOfInputCollects].inputKey.currentState?.onDeleteAll();
        break;
      case KeyType.check: // 決定キー
        var currentCollect = collects[currentIndexOfInputCollects];
        var currentCollectState = currentCollect.inputKey.currentState;
        var currentCollectStateValue = currentCollectState?.inputStr;

        var decisionedValue = (currentCollectStateValue == null || currentCollectStateValue == "") ?
            int.parse(defaultCollects) : int.parse(currentCollectStateValue);

        // 入力値が回収前の枚数を超過する場合はエラーとする
        if (decisionedValue > currentCollect.collectsBefore) {
          MsgDialog.show(
            MsgDialog.singleButtonDlgId(
              type: MsgDialogType.error,
              dialogId: DlgConfirmMsgKind.MSG_INPUTERR.dlgId,
            ),
          );

          break;
        }

        // 入力を決定した項目の結果を反映する
        currentCollectState?.onChangeStr(decisionedValue.toString());
        collects[currentIndexOfInputCollects] = Collect(
          bill: currentCollect.bill,
          collectsBefore: currentCollect.collectsBefore,
          collects: decisionedValue,
          collectsAfter: currentCollect.collectsBefore - decisionedValue,
          inputKey: currentCollect.inputKey,
        );

        // 回収金額を再計算する
        collectPrice.value = collects
            .map((collect) => collect.collects * collect.bill.price)
            .reduce((current, total) => current + total);

        // 入力欄のフォーカスを次の項目に移動する
        for (var collect in collects) {
          collect.inputKey.currentState?.setCursorOff();
        }
        if (currentIndexOfInputCollects + 1 < collects.length) {
          currentIndexOfInputCollects++;
          collects[currentIndexOfInputCollects].inputKey.currentState?.setCursorOn();
        } else {
          currentIndexOfInputCollects = defaultIndex;
        }

        // 回収方法の選択内容を初期化する
        if (decisionedValue != currentCollect.collects) {
          selectedCollectType.value = CollectType.others;
        }
        break;
      default: // その他（数値キー）
        var currentCollectState = collects[currentIndexOfInputCollects].inputKey.currentState;
        var currentCollectStateValue = currentCollectState?.inputStr;
        var inputValue = key.name;

        if (inputValue == "") {
          break;
        }

        if (currentCollectStateValue == null) {
          break;
        }

        if (currentCollectStateValue == defaultCollects) {
          currentCollectState?.onChangeStr(inputValue);
          break;
        }

        currentCollectState?.onChangeStr(currentCollectStateValue + inputValue);
        break;
    }
  }

  /// 回収方法を選択した時のハンドラ
  Future<void> onSelectCollectType(CollectType type, String title) async {
    currentIndexOfInputCollects = defaultIndex;
    for (var collect in collects) {
      collect.inputKey.currentState?.setCursorOff();
    }

    switch (type) {
      case CollectType.all:
      // 押下したボタンの種類を設定
        RcKyCpick.btnPressFlg = ChgPickBtn.ALLBTN_ON.btnType;
        RcKyCpick.pickMode = ChgPickBtn.ALLBTN_ON.btnType;

        selectedCollectType.value = type;

        await RcKyCpick.rcChgPickAllProc();

        currentIndexOfInputCollects = 0;

        for (int index = 0; index < collects.length; index++) {
          var currentCollect = collects[index];

          currentCollect.inputKey.currentState?.onChangeStr(currentCollect.collectsBefore.toString());
          collects[index] = Collect(
            bill: currentCollect.bill,
            collectsBefore: currentCollect.collectsBefore,
            collects: currentCollect.collectsBefore,
            collectsAfter: 0,
            inputKey: currentCollect.inputKey,
          );
        }

        collectPrice.value = collects
            .map((collect) => collect.collects * collect.bill.price)
            .reduce((current, total) => current + total);

        break;
      case CollectType.remaining:
      // 押下したボタンの種類を設定
        RcKyCpick.btnPressFlg = ChgPickBtn.RESERVEBTN_ON.btnType;
        RcKyCpick.pickMode = ChgPickBtn.RESERVEBTN_ON.btnType;

        selectedCollectType.value = type;
        await RcKyCpick.rcChgPickReserveProc();
        setCollects();
        break;
      default:
        // 対象の回収項目に対し、すべてを回収するよう設定する
        void setFullCollects(bool Function(Bill) isTarget, bool isClearOthers) {
          for (int index = 0; index < collects.length; index++) {
            var currentCollect = collects[index];

            if (!isTarget(currentCollect.bill)) {
              if (isClearOthers) {
                currentCollect.inputKey.currentState
                    ?.onChangeStr(defaultCollects);
                collects[index] = Collect(
                  bill: currentCollect.bill,
                  collectsBefore: currentCollect.collectsBefore,
                  collects: 0,
                  collectsAfter: currentCollect.collectsBefore,
                  inputKey: currentCollect.inputKey,
                );
              }

              continue;
            }

            currentCollect.inputKey.currentState
                ?.onChangeStr(currentCollect.collectsBefore.toString());
            collects[index] = Collect(
              bill: currentCollect.bill,
              collectsBefore: currentCollect.collectsBefore,
              collects: currentCollect.collectsBefore,
              collectsAfter: 0,
              inputKey: currentCollect.inputKey,
            );
          }

          collectPrice.value = collects
              .map((collect) => collect.collects * collect.bill.price)
              .reduce((current, total) => current + total);
        }

        dynamic selected;
        if(isDecision == false) {
          selected = await Get.to(ChargeCollectSelectScreen(title: title));
        }
        selected ??= CollectType.others;
        selectedCollectType.value = selected;
        switch (selectedCollectType.value) {
          case CollectType.cassette:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.CASETBTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.CASETBTN_ON.btnType;
            await RcKyCpick.rcChgPickCasetProc();
            setCollects();
            break;
          case CollectType.full:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.FULLBTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.FULLBTN_ON.btnType;
            await RcKyCpick.rcChgPickFullProc();
            setCollects();
            break;
          case CollectType.banknotes:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.BILLBTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.BILLBTN_ON.btnType;
            await RcKyCpick.rcChgPickBillProc();
            setFullCollects((Bill bill) => bill.isBanknotes(), true);
            break;
          case CollectType.coins:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.COINBTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.COINBTN_ON.btnType;
            await RcKyCpick.rcChgPickCoinProc();
            setFullCollects((Bill bill) => bill.isCoins(), true);
            break;
          case CollectType.large:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.MANBTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.MANBTN_ON.btnType;
            await RcKyCpick.rcChgPickManProc();
            setFullCollects((Bill bill) => bill.isLarge(), true);
            break;
          case CollectType.configured:
          // 押下したボタンの種類を設定
            RcKyCpick.btnPressFlg = ChgPickBtn.USERDATABTN_ON.btnType;
            RcKyCpick.pickMode = ChgPickBtn.USERDATABTN_ON.btnType;
            await RcKyCpick.rcChgPickUserdataProc();
            setCollects();
            break;
          case CollectType.others:
            CBillKind shtData = CBillKind();
            currentIndexOfInputCollects = 0;

            var currentCollect = collects[currentIndexOfInputCollects];
            var currentCollectState = currentCollect.inputKey.currentState;
            var currentCollectStateValue = currentCollectState?.inputStr;
            List<dynamic> decisionedValue = List.generate(ChgInOutDisp.CHGINOUT_DIF_MAX.value, (_) => 0);

            await RcKyCpick.rcChgPickCPickCountClr();

            for (int i = ChgInOutDisp.CHGINOUT_Y10000.value;
                i <= ChgInOutDisp.CHGINOUT_Y1.value; i++) {
              currentCollect = collects[i];
              currentCollectState = currentCollect.inputKey.currentState;
              currentCollectStateValue = currentCollectState?.inputStr;
              decisionedValue[i] = (currentCollectStateValue == null ||
                      currentCollectStateValue == "")
                  ? int.parse(defaultCollects)
                  : int.parse(currentCollectStateValue);
            }

            //枚数指定回収
            //if (RcKyCpick.kindOutInfo.typ != 0) {
            //金種別出金
            shtData.bill10000 =
                decisionedValue[ChgInOutDisp.CHGINOUT_Y10000.value];
            shtData.bill5000 =
                decisionedValue[ChgInOutDisp.CHGINOUT_Y5000.value];
            shtData.bill2000 =
                decisionedValue[ChgInOutDisp.CHGINOUT_Y2000.value];
            shtData.bill1000 =
                decisionedValue[ChgInOutDisp.CHGINOUT_Y1000.value];
            shtData.coin500 = decisionedValue[ChgInOutDisp.CHGINOUT_Y500.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y500.value);
            shtData.coin100 = decisionedValue[ChgInOutDisp.CHGINOUT_Y100.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y100.value);
            shtData.coin50 = decisionedValue[ChgInOutDisp.CHGINOUT_Y50.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y50.value);
            shtData.coin10 = decisionedValue[ChgInOutDisp.CHGINOUT_Y10.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y10.value);
            shtData.coin5 = decisionedValue[ChgInOutDisp.CHGINOUT_Y5.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y5.value);
            shtData.coin1 = decisionedValue[ChgInOutDisp.CHGINOUT_Y1.value];
            -await RcKyCpick.rcCPickKindOutttlshtSet(
                ChgInOutDisp.CHGINOUT_Y1.value);

            int shortFlg = await RcKyCpick.rcCPickShtDataStockChk(shtData);
            if (shortFlg == 1) {
              RegsMem().tTtllog.t105100Sts.cpickErrno =
                  DlgConfirmMsgKind.MSG_TEXT38.dlgId;
            }

            await RcKyCpick.rcCPickCountShtSet(shtData);

            int startPosition = await RcKyCpick.rcChkChgPickStartPosition();
            for (int i = startPosition;
                i < ChgInOutDisp.CHGINOUT_DIF_MAX.value;
                i++) {
              if (RcKyCpick.cPick.btn[i].cPickCount < 0) {
                RcKyCpick.cPick.btn[i].cPickCount = 0;
              }
              await RcKyCpick.rcChgPickAcrData(
                  RcKyCpick.cPick.btn[i].cPickCount,
                  RcInOut.CPick_Length,
                  i,
                  0);
              await RcKyCpick.rcAfterEntryDraw(i);
            }
            await RcKyCpick.rcTotalEntryDraw();
            setCollects();
            break;
          //}
          default: {}
        }
        break;
    }
  }

  /// 対象の回収項目に対し、回収枚数を設定する
  void setCollects() {
    currentIndexOfInputCollects = 0;
    for (int index = 0; index < collects.length; index++) {
      var currentCollect = collects[index];

      currentCollect.inputKey.currentState?.onChangeStr(defaultCollects);
      collects[index] = Collect(
        bill: currentCollect.bill,
        collectsBefore: currentCollect.collectsBefore,
        collects: 0,
        collectsAfter: currentCollect.collectsBefore,
        inputKey: currentCollect.inputKey,
      );

      currentCollect.inputKey.currentState
          ?.onChangeStr(RcKyCpick.cPick.btn[index].cPickCount.toString());
      collects[index] = Collect(
        bill: currentCollect.bill,
        collectsBefore: currentCollect.collectsBefore,
        collects: RcKyCpick.cPick.btn[index].cPickCount,
        collectsAfter:
            currentCollect.collectsBefore - RcKyCpick.cPick.btn[index].cPickCount,
        inputKey: currentCollect.inputKey,
      );
    }

    collectPrice.value = collects
        .map((collect) => collect.collects * collect.bill.price)
        .reduce((current, total) => current + total);
  }

  /// 確定ボタンを押下した時のハンドラ
  Future<void> onConfirm() async {
    for (var collect in collects) {
      collect.inputKey.currentState?.setCursorOff();
    }

      RcKyCpick.complete = true;

      await Future.delayed(const Duration(milliseconds: 500));

      /// TODO: バックエンドの確定処理呼び出し
      await RcKyCpick.rcKyChgPick();

      if (RcKyCpick.complete) {
        progress.value = CollectProgress.done;
        Get.back();
      }
  }
}

/// 回収処理の進捗
enum CollectProgress {
  doing('回収方法を選択し、「確定する」を押してください'),
  done('回収が完了しました。お金をお取りください。');

  final String value;
  const CollectProgress(this.value);
}

/// 回収方法
enum CollectType {
  all('すべて'),
  remaining('残置'),
  others('その他'),
  cassette('カセット'),
  full('フル金種'),
  banknotes('紙幣のみ'),
  coins('硬貨のみ'),
  large('万券のみ'),
  configured('設定データ');

  final String value;
  const CollectType(this.value);

  /// 回収方法（その他）の選択肢
  static Iterable<CollectType> valuesForOthers() {
    return CollectType.values.where((element) =>
    element == CollectType.cassette
        || element == CollectType.full
        || element == CollectType.banknotes
        || element == CollectType.coins
        || element == CollectType.large
        || element == CollectType.configured
    );
  }

  /// 回収方法（その他）か否か
  bool isOtherValues() {
    return this == CollectType.cassette
        || this == CollectType.full
        || this == CollectType.banknotes
        || this == CollectType.coins
        || this == CollectType.large
        || this == CollectType.configured;
  }
}

/// 回収内容の最小単位
class Collect {

  /// 貨幣
  Bill bill;

  /// 回収前の枚数
  int collectsBefore;

  /// 入力を確定済みの回収枚数
  int collects;

  /// 回収後の枚数
  int collectsAfter;

  /// 入力中（未確定）の回数枚数の状態管理
  GlobalKey<InputBoxWidgetState> inputKey;

  Collect({
    required this.bill,
    required this.collectsBefore,
    required this.collects,
    required this.collectsAfter,
    required this.inputKey,
  });
}

/// 貨幣
enum Bill {
  bill10000('assets/images/icon_bill_large.svg', 10000),
  bill5000('assets/images/icon_bill_large.svg', 5000),
  bill2000('assets/images/icon_bill_large.svg', 2000),
  bill1000('assets/images/icon_bill_large.svg', 1000),
  bill500('assets/images/icon_coin_large.svg', 500),
  bill100('assets/images/icon_coin_large.svg', 100),
  bill50('assets/images/icon_coin_large.svg', 50),
  bill10('assets/images/icon_coin_large.svg', 10),
  bill5('assets/images/icon_coin_large.svg', 5),
  bill1('assets/images/icon_coin_large.svg', 1);

  final String icon;
  final int price;
  const Bill(this.icon, this.price);

  /// 万券か否か
  bool isLarge() {
    return this == Bill.bill10000;
  }

  /// 紙幣か否か
  bool isBanknotes() {
    return this == Bill.bill10000
        || this == Bill.bill5000
        || this == Bill.bill2000
        || this == Bill.bill1000;
  }

  /// 硬貨か否か
  bool isCoins() {
    return this == Bill.bill500
        || this == Bill.bill100
        || this == Bill.bill50
        || this == Bill.bill10
        || this == Bill.bill5
        || this == Bill.bill1;
  }
}
