/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 *
 */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/regs/checker/rc_key.dart';
import 'package:flutter_pos/app/sys/mente/sio/sio_def.dart';
import 'package:flutter_pos/app/ui/controller/c_common_controller.dart';
import 'package:flutter_pos/app/ui/page/change_coin_connection/p_change_coin_connection_page.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../backend/history/hist_main.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/apl/rxregmem_define.dart';
import '../../../../inc/apl/t_item_log.dart';
import '../../../../inc/lib/typ.dart';
import '../../../../inc/sys/tpr_dlg.dart';
import '../../../../inc/sys/tpr_log.dart';
import '../../../../inc/sys/tpr_stat.dart';
import '../../../../inc/sys/tpr_type.dart';
import '../../../../lib/cm_sound/sound_def.dart';
import '../../../../regs/checker/rc_chgitm_dsp.dart';
import '../../../../regs/checker/rc_clxos.dart';
import '../../../../regs/checker/rc_prcchk.dart';
import '../../../../regs/checker/rc_set.dart';
import '../../../../regs/checker/rc_sound.dart';
import '../../../../regs/checker/rcky_plu.dart';
import '../../../../regs/checker/rcky_qcselect.dart';
import '../../../../regs/checker/rcky_rfdopr.dart';
import '../../../../regs/checker/rckycpwr.dart';
import '../../../../regs/checker/rcspeeza_com.dart';
import '../../../../regs/checker/rcsyschk.dart';
import '../../../../regs/checker/regs.dart';
import '../../../../regs/common/rxkoptcmncom.dart';
import '../../../../regs/inc/rc_regs.dart';
import '../../../../regs/spool/rsmain.dart';
import '../../../../ui/page/register/controller/w_purchase_scroll_controller.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../menu/register/m_menu.dart';
import '../../../socket/client/customer_socket_client.dart';
import '../../../socket/client/semiself_socket_client.dart';
import '../../common/component/w_msgdialog.dart';
import '../../detail_modifi/basepage/p_purchase_detail_modify.dart';
import '../../manual_input/controller/c_keypresed_controller.dart';
import '../../price_check/p_price_check_page.dart';
import '../../subtotal/controller/c_payment_controller.dart';
import '../../subtotal/controller/c_subtotal_controller.dart';
import '../model/m_membermodels.dart';
import '../model/m_registermodels.dart';
import '../model/m_transaction_data.dart';
import 'c_transaction_management.dart';

/// 手入力操作種別
/// 1:JANコード手入力
/// 2:個数乗算
enum ManualInputType { janInput, multipleInput }

/// 登録画面ボディー部コントローラー
class RegisterBodyController extends GetxController {
  // 顧客種別
  final memberType = ''.obs;
  // 顧客No
  final memberNo = ''.obs;

  //精算機表示するフラグ、初期値を非表示にする
  final RxBool isQcashierVisible = false.obs;

  // ポイント累計
  final pointCumulateTotal = ''.obs;

  // 顧客種別背景色
  var memberBackColor = BaseColor.baseColor.obs;

  // 顧客情報の表示有無
  final viewMemberInfo = false.obs;
  // 顧客情報のアイコン表示有無
  final viewMemberIcon = true.obs;
  // 顧客Noの表示有無
  final viewMemberNo = true.obs;
  // ポイント累計の表示有無
  final viewMemberPoints = true.obs;

  // プレミアム/シルバー（要確認）

  // プリカ残高
  final prepaidCardBalance = '￥2,000'.obs;

  // 有効期限表示
  final expiry = true.obs;
  final dateExpiry = '〇〇月〇〇日に200p失効します'.obs;

  /// タブボタンの最大数
  static const int maxTabBtnCont = 3;

  // 現在表示中リストのタブ位置
  final tabBtnIndex = 0.obs;

  // ＋ボタンのサイズ割合
  final int tabAddSizeFit = 10;

  // タブボタン表示の調整エリア割合
  final tabAdjustmentAreaFit = 0.obs;

  // タブボタンのサイズ割合
  final tabButtonFit = 0.obs;

  // ＋ボタンの表示切替
  final RxBool addTabVisibleFlag = false.obs;

  /// トランザクションデータの管理（タブ切替保存リスト）
  TransactionManagement transactionManagement = TransactionManagement();

  /// スクロールバーのコントローラー
  final PurchaseScrollController purchaseScrollController =
  PurchaseScrollController();

  // 現在表示しているデータ.
  final purchaseData = <Purchase>[].obs;
  final totalData = TTtlLog().obs;

  // 商品明細一覧 scrollが可能な場合はtrue.
  final purchaseScrollON = false.obs;

  // ステータス表示(配列4　未表示は空にする)
  List statusList = ['印紙除外', '領収書宣言', '分類解除', '桁解除'];

  // 精算機待機状態管理
  List<PaymachineState> payMachineStatus = <PaymachineState>[].obs;

  // 変更画面表示
  final changePurchaseShow = false.obs;

  // 値引き割引行
  final discountRow = [].obs;

  final formatter = NumberFormat("#,###", "ja_JP");

  /// 返品モードフラグ
  RxBool refundFlag = false.obs;

  /// 客表画面が開かれている場合はtrue
  static bool customerScreen = false;

  /// 非活性ボタンの不透明度
  static const disableBtnOpacity = 0.4;

  /// 活性ボタンの不透明度
  static const enableBtnOpacity = 1.0;

  /// 商品一覧の上スクロールボタン不透明度
  final upOpacity = disableBtnOpacity.obs;

  /// 商品一覧の下スクロールボタン不透明度
  final downOpacity = enableBtnOpacity.obs;

  /// 商品一覧リストのスクロール量
  final scrollHeight = 0.0.obs;

  Timer? timer;

  /// 価格確認モード
  var prcChkMode = false.obs;
  
  /// コモンコントローラー
  final CommonController commonctrl = Get.find();

  /// 釣機ON/OFF許可状態
  static RxBool changePermission = true.obs;

  /// キャンセル時のバックアップデータ
  ResultItemData? backupResultItemData;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    RegistInitData.main();
    // 客側を客表表示へ変更
    CustomerSocketClient().sendItemClear();

    // ステータスサンプル
    payMachineStatus.add(PaymachineState(
        title: "",
        idx: 0,
        nearstate: "",
        state: "",
        function: RckyQcSelect.qcSelectKey));
    payMachineStatus.add(PaymachineState(
        title: "",
        idx: 0,
        nearstate: "",
        state: "",
        function: RckyQcSelect.qcSelectKey));

    payMachineStatus.add(PaymachineState(
        title: "",
        idx: 0,
        nearstate: "",
        state: "",
        function: RckyQcSelect.qcSelectKey));
    payMachineStatus.add(PaymachineState(
        title: '',
        idx: 0,
        nearstate: "",
        state: "",
        function: RckyQcSelect.qcSelectKey));

    // TODO:10152 履歴ログ 引数突貫
    HistConsole().sendSysNotify(TprStatDef.TPRTST_IDLE);

    // TODO:10159 フルセルフ 現計でも実装されているが一旦実装
    await RegistInitData.main();

    // QCashierとの接続を初期化
    await startQcConnection();

    // 各フラグ初期化
    await RcSet.rcClearKyItem();

    // 精算機問合せ定期処理開始
    if (isQcashierVisible.value) {
      timer ??= Timer.periodic(const Duration(milliseconds: 1000), _onTimer);
    }
    
    // 画面遷移かエラー画面表示かを判断
    changePermission.value = await isChangeEnable();

    // 釣機ONOFFの状態を取得
    getLatestChangeStatus();

    // 登録画面に状態を表示
    displayChangeOnOrOff();
  }

  @override
  void onReady() {
    super.onReady();

    // 保留されているトランザクションデータの読み込み
    transactionManagement.load();
    // タブリスト切替
    _changeTabList(0);
  }

  /// rcStartQcConnectTaskを呼び出し、各QCashierとの接続
  Future<void> startQcConnection() async {
    const TprMID tid = Tpraid.TPRAID_CHK;
    int chkCash = 0;

    try {
      // 設定ファイル展開
      await RcSpeezaCom.rcSpeezaReadIni();
      // セミセルフ登録機ソケット通信開始
      int result = await RckyQcSelect.rcStartQcConnectTask(tid, chkCash);
      if (result == Typ.OK) {
        debugPrint('QCashier 接続成功');
      }
      // QC指定ボタンエリアの表示
      if (await RcSysChk.rcQRChkPrintSystem()) {
        updateQcashierVisibility(true);
      } else {
        updateQcashierVisibility(false);
      }
    } catch (e) {
      TprLog()
          .logAdd(
          Tpraid.TPRAID_NONE, LogLevelDefine.error, 'QCashier 異常: $e');
    }
  }


  // 精算機問合せ定期処理
  Future<void> _onTimer(Timer timer) async {
    SemiSelfSocketClient().getQcStatus();
    SemiSelfSocketClient().updateQcStatus(payMachineStatus);
  }

  @override
  void onClose() {
    super.onClose();
    // 客側をロゴ表示に変更
    CustomerSocketClient().sendLogoDisplay();
    // 精算機問合せ定期処理停止
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
  }

  /// 登録処理
  Future<void> selectedPlu(String? pluCd, int qty, [int? clsNo, int? clsVal]) async {
    pluCd ??= "";
    RcKyPlu plu = RcKyPlu(pluCd, qty);
    // 価格確認モード時は商品登録は行わずに価格確認画面に遷移する
    if (prcChkMode.value) {
      final (isSuccess, err, calcResultItem) = await plu.rcKyPlu(isPrcChk: true);
      if (!isSuccess) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: err,
        ));

        return;
      }
      // todo 価格確認バックエンド処理４
      //      商品情報をクラウドPOSから取得して価格確認画面に表示する内容を設定する。
      RcPrcChk.setPriceCheckData(calcResultItem!);

      // 価格確認画面に遷移
      Get.to(() =>
          PriceCheckPage(title: '価格確認',
            backgroundColor: BaseColor.someTextPopupArea,));
      return;
    }

    if (clsNo != null || clsVal != null) {
      plu.setClsRegisterInfo(clsNo ?? 0, clsVal ?? 0);
    }

    final (isSuccess, err, _) = await plu.rcKyPlu();
    if (!isSuccess) {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: err,
      ));
      return;
    }

    int itemIndex = RegsMem().tTtllog.getItemLogCount() - 1;
    if (itemIndex < 0) {
      return;
    }
    TItemLog itemLog = RegsMem().tItemLog[itemIndex];

    // 警告商品のダイアログ表示実績
    bool isAlreadyWarning = transactionManagement.getAt(tabBtnIndex.value).isAlreadyWarning;

    // 警告商品のダイアログ表示するか？
    if (checkWarningDisplayDialog(itemLog.itemData)
        && !isAlreadyWarning) {
      // 音声「年齢確認が必要な商品です」の再生
      RcSound.play(sndFile: SoundDef.ageCautionFile);

      // 警告商品ダイアログは1品目だけ表示
      isAlreadyWarning = await MsgDialog.showConfirm(MsgDialog.twoButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_AGE_CHECK.dlgId,
        leftBtnTxt: '取消',
        leftBtnFnc: () {
          Get.back(result: false);
        },
        rightBtnTxt: '登録',
        rightBtnFnc: () {
          Get.back(result: true);
        },
      ));

      if (!isAlreadyWarning) {
        // 該当商品を取消にして、再度クラウドPOSと通信する
        final resultWithJson = await RcKeyChangeItem.rcChgItmCalcMain(
            itemIndex,
            prcChgVal: itemLog.itemData.prcChgVal ?? 0,
            dscType: DscChangeType.values.firstWhere((e) => e.index == (itemLog.itemData.itemDscType ?? 0)),
            dscValue: itemLog.itemData.itemDscVal ?? 0,
            dscCode: itemLog.itemData.itemDscCode ?? 0,
            qty: itemLog.itemData.qty ?? 0,
            type: 1,    // 取り消しにする
        );

        if (resultWithJson.result.retSts != 0) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: resultWithJson.result.getErrId(),
          ));
          return;
        }

        // 再取得
        itemLog = RegsMem().tItemLog[itemIndex];
      }
    }

    // トランザクションデータの保存（RegsMemのデータを保存）
    saveTransactionData(isAlreadyWarning: isAlreadyWarning);

    // 画面に表示
    addItem(itemIndex, itemLog);

    // itemTypeが800以外、且つ売価が0円の場合は明細変更画面を表示する
    if (checkPurchaseDetailModifyDisplay(
        purchaseData[itemIndex].itemLogIndex)) {
      /// purchaseData更新前にバックアップを取得
      setPurchaseDataBackup(itemIndex);
      await Get.to(
        () => PurchaseDetailModifyScreen(
          title: '明細変更',
          purchaseDataIndex: purchaseData[itemIndex].itemLogIndex,
          enabledCancelButton: false,
          setForcus: DetailModifyFocusType.focusNone,
          addInfo: '※この取引きのみに適用されます',
        ),
      );
    }
  }

  /// 登録処理
  void addItem(int itemLogIndex, TItemLog itemLog) {
    // purchaseデータに未登録のデータを、表示リストに追加.
    Purchase? data = purchaseData
        .firstWhereOrNull((element) => element.itemLog.seqNo == itemLog.seqNo);
    if (data == null) {
      purchaseData.insert(0, Purchase(
        itemLog: itemLog,
        itemLogIndex: itemLogIndex,
        isDeleted: itemLog.itemData.type == 1,
      ));
      _listKey?.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 200));
    }

    refreshPurchaseData();
    purchaseScrollController.scrollToTop();
    setButtonState();

    // ＋ボタンの表示切替
    setAddTabVisibleFlag();
  }

  /// 表示データの登録処理（全件）
  void _addItemAll() {
    // 商品情報を登録する
    int itemCount = RegsMem().tTtllog.getItemLogCount();
    for (int index = 0; index < itemCount; index++) {
      purchaseData.insert(0, Purchase(
        itemLog: RegsMem().tItemLog[index],
        itemLogIndex: index,
        isDeleted: RegsMem().tItemLog[index].itemData.type == 1,
      ));
    }
    _listKey?.currentState?.insertAllItems(0, itemCount);

    refreshPurchaseData();
    purchaseScrollController.scrollToTop();
    setButtonState();

    // ＋ボタンの表示切替
    setAddTabVisibleFlag();
  }

  /// 表示用データのリフレッシュ.
  Future<void> refreshPurchaseData() async {
    totalData.value = RegsMem().tTtllog;
    purchaseData.refresh();
    totalData.refresh();
  }

  // ポイント処理（処理不明につき関数名も暫定:右側青のボタン部分）
  void pointShow() {
    Get.defaultDialog(title: 'ポイント処理（処理内容確認後関数名変更');
  }

  /// タブボタン追加
  void addTabButton(String currentRoute) {
    // 小計画面で押された場合は、登録画面に戻る
    if (currentRoute == '/subtotal') {
      Get.back();
    }

    // リストにトランザクションデータを追加して、表示位置を追加された位置にする
    transactionManagement.add();

    // 位置が変わったのでリスト変更
    _changeTabList(transactionManagement.count - 1);

    // タブボタンのサイズ比率
    tabExpanedCalc();
  }

  /// タブ幅計算
  void tabExpanedCalc() {
    int tabAdjustArea = 0;
    // タブボタンのサイズ比率
    double resultTabFit = 100 * 0.9 / transactionManagement.count;
    if (resultTabFit > 35) {
      // 横幅が広くなりすぎないようにするため
      tabButtonFit.value = 35;
    } else {
      // 切り捨て
      tabButtonFit.value = resultTabFit.floor();
    }

    tabAdjustArea =
        100 - tabAddSizeFit - tabButtonFit.value * transactionManagement.count;
    debugPrint(
        'tabBtnCount: ${transactionManagement.count *
            tabButtonFit.value}  tabAdjustmentAreaFit: $tabAdjustArea');

    if (tabAdjustArea < 10) {
      tabAdjustmentAreaFit.value = 0;
    } else {
      tabAdjustmentAreaFit.value = tabAdjustArea;
    }
  }

  /// タブ切替
  Future<void> changeTab(int newIndex) async {
    // 現在のタブが取引開始していなければ削除する
    if (transactionManagement.getAt(tabBtnIndex.value).isExsitData() == false) {
      // 現在のインデックスの要素を削除する
      transactionManagement.removeAt(tabBtnIndex.value);
    }

    // タブリスト切替
    _changeTabList(newIndex);
  }

  /// タブリスト切替
  Future<void> _changeTabList(int newIndex) async {
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, '_changeTabList newIndex=$newIndex');

    // 表示データを初期化して、画面を初期化する
    _clearDisplay();

    // タブ位置を変更する
    tabBtnIndex.value = newIndex;

    // 取引データが存在するか
    TransactionData transactionData = transactionManagement.getAt(tabBtnIndex.value);
    if (transactionData.isExsitData()) {
      // 返品モードか？
      if (transactionData.isRefund) {
        /// 返品モードの開始
        startRefundflag(transactionData.refundDate);
      }

      // RegsMemをリセットして、保存されている取引データを設定する
      CalcResultItem lastResultData = transactionData.lastResultData;
      RcClxosCommon.settingMemResultData(lastResultData);

      // 表示データの登録処理（全件）
      _addItemAll();

      // RegsMemのクラウドPOSへ商品登録request情報に、保存されている取引データを設定する
      RegsMem().lastRequestData = transactionData.getRequestData();

      // 客側に商品登録メッセージを送る
      String json = jsonEncode(lastResultData.toJson());
      CustomerSocketClient().sendItemRegister(json);

      // スプールテンポラリファイル出力
      if (await RcSysChk.rcKySelf() == RcRegs.KY_CHECKER) {
        RsMain.rsWriteTempFile(json);
      }
    } else {
      // ＋ボタンの表示切替
      setAddTabVisibleFlag();
    }

    // 現在の画面が、小計画面の場合
    if (Get.currentRoute == '/subtotal') {
      // 小計情報を更新する
      SubtotalController subtotalController = Get.find();
      subtotalController.changeDiscountValue();
    }
  }

  /// 小計精算後にタブ位置のデータを削除する
  void delTabList() {
    if (tabBtnIndex.value > 0 || transactionManagement.count > 1) {
      // インデックスが0でない、もしくは、インデックスが0でも要素数が2以上の場合は、
      // 現在のインデックスの要素を削除する
      transactionManagement.removeAt(tabBtnIndex.value);
      // 位置が変わったのでリスト変更
      int newIndex = tabBtnIndex.value < transactionManagement.count
          ? tabBtnIndex.value : transactionManagement.count - 1;
      _changeTabList(newIndex);
    } else {
      // トランザクションデータの初期化
      transactionManagement.clear();

      // 表示データを初期化して、画面を初期化する
      _clearDisplay();
    }
  }

  /// 表示データを初期化して、画面を初期化する
  void _clearDisplay() {

    /*
    AnimatedListのremoveAllItemsを使用した場合に以下の問題があったので、removeItemを使用するように変更した
    詳細
    登録画面で取引を2つ以上（タブ表示を2以上）にし、小計画面に遷移して、タブの切替をする
    ケース1：小計画面で、タブを1から2に変更して、登録画面に戻る ⇒ 正常
    ケース2：小計画面で、タブを1から2に変更し、さらに2から1に変更する ⇒ 以下エラー発生
     Unhandled Exception: 'package:flutter/src/widgets/animated_scroll_view.dart': Failed assertion: line 1184 pos 12: 'itemIndex >= 0 && itemIndex < _itemsCount': is not true.
     */
    // _listKey?.currentState?.removeAllItems((context, animation) => Container());
    for (var i = 0; i <= purchaseData.length - 1; i++) {
      _listKey?.currentState?.removeItem(0, (context, animation) => Container());
    }
    purchaseData.value = <Purchase>[];

    tabExpanedCalc();
    RegsMem().resetTranData();
    refreshPurchaseData();
    purchaseScrollON.value = false;

    // 客側に商品クリアメッセージを送る
    CustomerSocketClient().sendItemClear();

    // 返品モードのクリア
    clearRefundflag();

    // 顧客情報のクリア
    clearMemberInfo();
  }

  /// 商品の個数を変更する.
  Future<void> changePurchaseQuantity(int index, int add) async {
    if (index < 0 || purchaseData.length <= index) {
      debugPrint("purchaseData rangeError $index");
      return;
    }
    int target = purchaseData[index].itemLogIndex;
    int afterQty = purchaseData[index].itemLog.getItemQty();
    afterQty += add;
    if (afterQty < 0) {
      afterQty = 0;
    }
    if (afterQty > 999) {
      afterQty = 999;
    }

    final resultWithJson =
    await RcKeyChangeItem.rcChgItmCalcMain(target, qty: afterQty);

    int errId = resultWithJson.result.getErrId();

    if (errId == 0) {
      // トランザクションデータの保存（RegsMemのデータを保存）
      saveTransactionData();

      changeItemForDisp(index);
    } else {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: errId,
      ));
    }
  }

  /// アイテムの購入情報に変更があった時に、表示に反映する
  void changeItemForDisp(int purchaseDataIndex) {
    purchaseData[purchaseDataIndex].itemLog =
    RegsMem().tItemLog[purchaseData[purchaseDataIndex].itemLogIndex];
    refreshPurchaseData();
  }

  // 値引き割引関連----------------------------------
  /// 有効な値下げ情報のリスト
  List<DiscountData> getShowDiscountList(Purchase data) {
    List<DiscountData> showList = [];
    if (data.itemLog.itemData.discountList == null) {
      return showList;
    }
    for (var discount in data.itemLog.itemData.discountList!) {
      if (discount.discountPrice! > 0) {
        showList.add(discount);
      }
    }
    return showList;
  }

  // -アニメーション
  GlobalKey<AnimatedListState>? _listKey;

  void setKey(GlobalKey<AnimatedListState> key) {
    _listKey = key;
  }

  /// スクロール位置に応じて上下ボタンの活性・非活性状態を設定する
  void setButtonState() {
    /// 上ボタン
    bool isTop = purchaseScrollController.position.pixels ==
        purchaseScrollController.position.minScrollExtent;

    /// スクロール位置が先頭
    if (isTop) {
      upOpacity.value = disableBtnOpacity;
    }

    /// スクロール位置が先頭以外
    else {
      upOpacity.value = enableBtnOpacity;
    }

    /// 下ボタン
    bool isBottom = purchaseScrollController.position.pixels ==
        purchaseScrollController.position.maxScrollExtent;

    /// スクロール位置が最後
    if (isBottom) {
      downOpacity.value = RegisterBodyController.disableBtnOpacity;
    }

    /// スクロール位置が最後以外
    else {
      downOpacity.value = RegisterBodyController.enableBtnOpacity;
    }

    /// スクロールバー、ボタンの表示要否を設定
    if (upOpacity.value == RegisterBodyController.enableBtnOpacity ||
        downOpacity.value == RegisterBodyController.enableBtnOpacity) {
      purchaseScrollON.value = true;
    } else {
      purchaseScrollON.value = false;
    }
  }

  ///　機能概要：商品の個数変更可否チェック
  ///        ：商品タイプが30または31の場合は変更不可、それ以外は変更可を返す
  ///　パラメータ：int purchaseDataIndex：明細データ配列のインデックス
  ///　戻り値：bool true :変更可
  ///     　　　　　false:変更不可
  bool checkPurchaseQuantityChange(int purchaseDataIndex) {
    if ((purchaseData[purchaseDataIndex].itemLog.itemData.itemType == 30) ||
        (purchaseData[purchaseDataIndex].itemLog.itemData.itemType == 31)) {
      return false;
    }
    return true;
  }

  ///　機能概要：売価変更可否チェック
  ///        ：売価変更許可フラグが2の場合は変更不可、それ以外は変更可を返す
  ///　パラメータ：int purchaseDataIndex：明細データ配列のインデックス
  ///　戻り値：bool true :変更可
  ///     　　　　　false:変更不可
  bool checkPriceChangeFlag(int purchaseDataIndex) {
    if (purchaseData[purchaseDataIndex].itemLog.itemData.prcChgFlg == 2) {
      return false;
    }
    return true;
  }

  ///　機能概要：値引・割引可否チェック
  ///        ：値引・割引許可フラグが2の場合は実施不可、それ以外は実施可を返す
  ///　パラメータ：int purchaseDataIndex：明細データ配列のインデックス
  ///　戻り値：bool true :実施可
  ///     　　　　　false:実施不可
  bool checkDiscountAvailable(int purchaseDataIndex) {
    if (purchaseData[purchaseDataIndex].itemLog.itemData.discChgFlg == 2) {
      return false;
    }
    return true;
  }

  ///　機能概要：警告商品表示可否チェック
  ///        ：選択された明細データがの警告タイプが100であれば警告表示、それ以外は表示しないを返す
  ///　パラメータ：ResultItemData itemData：明細データ
  ///　戻り値：bool true :表示する
  ///     　　　　　false:表示しない
  bool checkWarningDisplayDialog(ResultItemData itemData) {
    if (itemData.warningType == 100) {
      return true;
    }
    return false;
  }

  ///　機能概要：売価0円商品選択時の明細変更画面表示チェック
  ///        ：売価0円且つ、商品タイプが800以外の場合は明細変更画面を表示する、それ以外は表示しないを返す
  ///　パラメータ：int purchaseDataIndex：明細データ配列のインデックス
  ///　戻り値：bool true :表示する
  ///     　　　　　false:表示しない
  bool checkPurchaseDetailModifyDisplay(int purchaseDataIndex) {
    if ((purchaseData[purchaseDataIndex].itemLog.itemData.price == 0) &&
        (purchaseData[purchaseDataIndex].itemLog.itemData.itemType != 800)) {
      return true;
    }
    return false;
  }

  /// 処理概要：値引き額合計
  /// パラメータ：int index
  ///           商品明細データリストのインデックス
  /// 戻り値：int 値引き金額合計
  int getDiscountPrice(int index) {
    int totalDiscountPrice = 0;
    var list = getShowDiscountList(purchaseData[index]);
    for (var info in list) {
      totalDiscountPrice += info.discountPrice ?? 0;
    }
    return totalDiscountPrice;
  }

  void dispMachineSuccess(int no) {
    PaymentController paymentCtrl = Get.find();
    paymentCtrl.isSentToMachineSuccess.value = true;
    paymentCtrl.machineName.value = "精算機$no";
    timer = Timer(const Duration(seconds: 5), () async {
      if (timer != null) {
        timer = null;
        SetMenu1.navigateToRegisterPage();
      }
    });
  }

  ///登録機と精算機の表示状態を更新する関数
  void updateQcashierVisibility(bool isVisible) {
    isQcashierVisible.value = isVisible;
  }

  /// 処理概要：アイテムデータ取得
  /// パラメータ：int index
  ///           商品明細データリストのインデックス
  /// 戻り値：ResultItemData 指定したIndexのアイテムデータ
  ResultItemData getpurchaseItemData(int index) {
    return purchaseData[index].itemLog.itemData;
  }

  /// 処理概要：手入力操作
  /// パラメータ：key 押されたキー
  ///           inputString 手入力された情報
  ///           pluCd スキャンしたPLUコード
  /// 戻り値：なし
  Future<void> manualRegistration(
      FuncKey key, String inputString, String? pluCd) async {
    int qty = 1;

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet.object;

    ManualInputType inputType = ManualInputType.janInput;

    /// 手入力された情報に'x'が含まれている場合は乗算
    /// 入力文字列にxが含まれていない場合（-1）は乗算無しのPLUコードとして続行
    int posX = inputString.indexOf('x');

    /// 先頭がxの場合は入力エラーメッセージ表示
    if (posX == 0) {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_INPUTERR.dlgId,
      ));
      return;
    }

    /// xの前に1文字以上入力されていたら乗算
    if (posX > 0) {
      /// 乗算キーに設定されている桁数をオーバーした場合は桁数エラー
      if (pCom.dbKfnc[FuncKey.KY_MUL.keyId].opt.mul.digit < posX) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_INPUTOVER.dlgId,
        ));
        return;
      }
      inputType = ManualInputType.multipleInput;
    }

    String setPlu = '';
    if (inputType == ManualInputType.multipleInput) {
      /// 乗算の場合は個数を変更して登録処理を実施
      qty = int.parse(inputString.substring(0, posX));
      setPlu = inputString.substring(posX + 1);
    } else {
      setPlu = inputString;
    }

    /// 手入力されたコードがなければPLUコードを使用する
    if (setPlu == '') {
      setPlu = pluCd ?? '0';
    }
    await selectedPlu(setPlu, qty);

    /// バーコード二段目待ちの場合は処理終了
    final keyPressCtrl = Get.find<KeyPressController>();
    if (keyPressCtrl.currentMode == MKInputMode.waitingSecond.obs) {
      return;
    }

    keyPressCtrl.resetKey();
  }

  /// 処理概要：割引き手入力
  /// パラメータ：key 押されたキー
  ///           inputString 手入力された情報
  /// 戻り値：なし
  Future<void> manualDiscount(FuncKey key, String inputString) async {

    RxMemRet xRet1 = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet1.isInvalid()) {
      return;
    }
    RxCommonBuf pCom = xRet1.object;

    int itemDscType = 0;
    int itemDscVal = 0;
    int itemDscCode = key.keyId;

    /// 登録されているアイテムがない場合はエラー
    int itemCount = RegsMem().lastTotalData?.totalQty ?? 0;
    if (itemCount == 0) {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_NOT_REGISTRATION.dlgId,
      ));
      return;
    }

    /// 押されたキーが値引き1～5の場合
    if (!Rxkoptcmncom.rxChkKeyKindPdsc(pCom, key.keyId)) {

      itemDscType = DscChangeType.dsc.index;

      /// 単体値引きが禁止されている場合は小計のみ値引きエラー
      if (pCom.dbKfnc[key.keyId].opt.dsc.itemDscpdscFlg == 1) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_DSC_FOR_ITEM_ERR.dlgId,
        ));
        return;
      }

      /// 手入力された値引き額がある
      if (inputString != '') {

        itemDscVal = int.parse(inputString);

        /// 置数値引きが無効の場合は値引き禁止エラー
        if (pCom.dbKfnc[key.keyId].opt.dsc.entryFlg == 1) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_DSC_CHG_ERR.dlgId,
          ));
          return;
        }

        /// 桁数オーバーの場合は桁数オーバーエラー
        if (pCom.dbKfnc[key.keyId].opt.dsc.digit < inputString.length) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_INPUTOVER.dlgId,
          ));
          return;
        }

        /// purchaseData更新前にバックアップを取得
        setPurchaseDataBackup(0);
        /// 値引きを実施
        updateDiscountValue(
            0, DscChangeType.dsc.index, int.parse(inputString), key.keyId);
        changeListData(0);
        return;
      }

      /// purchaseData更新前にバックアップを取得
      setPurchaseDataBackup(0);
      int dscValue = pCom.dbKfnc[key.keyId].opt.dsc.dscAmt;
      if (dscValue > 0) {
        /// 直前のアイテムを値引き
        updateDiscountValue(0, DscChangeType.dsc.index, dscValue, key.keyId);
        changeListData(0);
      } else {
        await showManualDiscountModify(0, itemDscType, itemDscVal, itemDscCode);
      }
      return;
    } else {
      /// 押されたキーが割引き1～5の場合
      itemDscType = DscChangeType.pdsc.index;

      /// 単体割引きが禁止されている場合は小計のみ割引きエラー
      if (pCom.dbKfnc[key.keyId].opt.pdsc.itemDscpdscFlg == 1) {
        MsgDialog.show(MsgDialog.singleButtonDlgId(
          type: MsgDialogType.error,
          dialogId: DlgConfirmMsgKind.MSG_PDSC_FOR_ITEM_ERR.dlgId,
        ));
        return;
      }

      /// 手入力された値引き額がある
      if (inputString != '') {

        itemDscVal = int.parse(inputString);

        /// 置数値引きが無効の場合は割引き禁止エラー
        if (pCom.dbKfnc[key.keyId].opt.pdsc.entryFlg == 1) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_PDSC_CHG_ERR.dlgId,
          ));
          return;
        }

        /// 桁数オーバーの場合は桁数オーバーエラー
        if (2 < inputString.length) {
          MsgDialog.show(MsgDialog.singleButtonDlgId(
            type: MsgDialogType.error,
            dialogId: DlgConfirmMsgKind.MSG_INPUTOVER.dlgId,
          ));
          return;
        }

        /// purchaseData更新前にバックアップを取得
        setPurchaseDataBackup(0);
        /// 直前のアイテムを割引き
        updateDiscountValue(
            0, DscChangeType.pdsc.index, int.parse(inputString), key.keyId);
        changeListData(0);
        return;
      }

      /// purchaseData更新前にバックアップを取得
      setPurchaseDataBackup(0);
      int parValur = pCom.dbKfnc[key.keyId].opt.pdsc.pdscPer;
      if (parValur > 0) {
        /// 直前のアイテムを割引き
        updateDiscountValue(0, DscChangeType.pdsc.index, parValur, key.keyId);
        changeListData(0);
      } else {
        await showManualDiscountModify(0, itemDscType, itemDscVal, itemDscCode);
      }
    }
  }

  /// 処理概要：明細変更画面表示
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int itemDscType：値引き／割引き種別
  ///         　　　　　　　　　　　　dsc：1.単品値引き
  ///         　　　　　　　　　　　　pdsc：2.単品割引
  ///         ：int itemDscVal：値引き／割引き値
  ///         ：int itemDscCode：値引き／割引きキーコード
  /// 戻り値：なし
  Future<void> showManualDiscountModify(int purchaseIndex, int itemDscType, int itemDscVal, int itemDscCode) async {

    /// 明細変更画面を呼び出し
    await Get.to(
          () =>
          PurchaseDetailModifyScreen(
            title: '明細変更',
            purchaseDataIndex: purchaseIndex,
            enabledCancelButton: true,
            setForcus: DetailModifyFocusType.discount,
            addInfo: '※この取引きのみに適用されます',
          ),
    );
  }
  
  /// 処理概要：値引き／割引き値を更新する
  ///         discountTypeが1、2の場合は更新処理を実施、それ以外の場合は実施しない。
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  ///         ：int discountType：値引き／割引き種別
  ///         　　　　　　　　　　　　dsc：1.単品値引き
  ///         　　　　　　　　　　　　pdsc：2.単品割引
  ///         ：int discountValue：値引き／割引き値
  /// 戻り値：bool true：更新済み
  ///　          false：更新なし
  bool updateDiscountValue(int purchaseIndex, int discountType,
      int discountValue, int keyCode) {

    if ((discountType == DscChangeType.dsc.index) ||
        (discountType == DscChangeType.pdsc.index)) {
      ResultItemData itemData = purchaseData[purchaseIndex].itemLog.itemData;
      itemData.itemDscType = discountType;
      itemData.itemDscVal = discountValue;
      itemData.itemDscCode = keyCode;
      return true;
    }
    return false;
  }

  /// 処理概要：手入力操作 売価変更
  /// パラメータ：key 押されたキー
  ///           inputString 手入力された情報
  ///           pluCd スキャンしたPLUコード
  /// 戻り値：なし
  Future<void> inputManualChgPrice(
      FuncKey key, String inputString, String pluCd) async {

    /// スキャンまたはタッチパネル入力の場合はinputStringが空になるため上書き
    if (inputString == "") {
      inputString = pluCd;
    }

    /// 売価変更の場合はまず商品を登録
    await selectedPlu(inputString, 1);

    /// バーコード二段目待ちの場合は処理終了
    final  keyPressCtrl = Get.find<KeyPressController>();
    if (keyPressCtrl.currentMode == MKInputMode.waitingSecond.obs) {
      return;
    }

    /// 客表にデータがない場合は処理終了
    int itemIndex = RegsMem().tTtllog.getItemLogCount() - 1;
    if (itemIndex < 0) {
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_NOT_REGISTRATION.dlgId,
      ));
      keyPressCtrl.resetKey();
      return;
    }

    /// 明細変更画面を呼び出し
    await Get.to(
          () =>
          PurchaseDetailModifyScreen(
            title: '明細変更',
            purchaseDataIndex: purchaseData[0].itemLogIndex,
            enabledCancelButton: true,
            addInfo: '※この取引きのみに適用されます',
            setForcus: DetailModifyFocusType.priceChg,
          ),
    );

    keyPressCtrl.resetKey();
  }

  /// 処理概要：登録画面商品List更新処理
  /// パラメータ：int purchaseIndex：明細データ配列のインデックス
  /// 戻り値：なし
  Future<void> changeListData(int index) async {
    if (purchaseData[index].itemLog.itemData.itemDscType == null) {
      purchaseData[index].itemLog.itemData.itemDscType = 0;
    }
    // クラウドPOSと通信して変更する
    debugPrint('changeListData');
    final resultWithJson = await RcKeyChangeItem.rcChgItmCalcMain(
        purchaseData[index].itemLogIndex,
        prcChgVal: purchaseData[index].itemLog.itemData.prcChgVal ?? 0,
        dscType: DscChangeType.values.firstWhere((element) =>
        element.index == purchaseData[index].itemLog.itemData.itemDscType),
        dscValue: purchaseData[index].itemLog.itemData.itemDscVal ?? 0,
        dscCode: purchaseData[index].itemLog.itemData.itemDscCode ?? 0,
        qty: purchaseData[index].itemLog.itemData.qty ?? 0,
        type: purchaseData[index].itemLog.itemData.type ?? 0);

    bool success = resultWithJson.result.retSts == 0;
    int errId = resultWithJson.result.getErrId();

    if (success) {
      // トランザクションデータの保存（RegsMemのデータを保存）
      saveTransactionData();

      changeItemForDisp(index);
      /// 更新が終わったらバックアップを削除
      backupResultItemData = null;
    } else {

      /// 更新に失敗した場合はitemDataをリセット
      resetResultItemData(index);

      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error, 
        dialogId: errId,
      ));
    }
  }

  /// 処理概要：顧客情報を設定する
  /// パラメータ：MemberInfo memberInfo
  ///           表示する顧客情報
  /// 戻り値：なし
  void setMemberType(MemberInfo memberInfo) {
    // 顧客情報の表示有無
    viewMemberInfo.value = memberInfo.isViewMemberInfo;
    // 顧客情報の背景色
    memberBackColor.value = memberInfo.memberBackColor;
    // 顧客種別
    memberType.value = memberInfo.memberType;
    // アイコン表示有無
    viewMemberIcon.value = memberInfo.isViewMemberIcon;
    // 顧客Noの表示有無
    viewMemberNo.value = memberInfo.isViewMemberNo;
    // 顧客No
    memberNo.value = memberInfo.memberNoString;
    // ポイント累計の表示有無
    viewMemberPoints.value= memberInfo.isViewMemberPoints;
    // ポイント累計
    pointCumulateTotal.value = memberInfo.pointCumulateTotalString;
  }

  /// 処理概要：顧客情報をクリアする
  /// 戻り値：なし
  void clearMemberInfo() {
    // 顧客情報の表示有無
    viewMemberInfo.value = false;
    // 顧客情報の背景色
    memberBackColor.value = BaseColor.baseColor;
    // 顧客種別
    memberType.value = '';
    // アイコン表示有無
    viewMemberIcon.value = false;
    // 顧客Noの表示有無
    viewMemberNo.value = false;
    // 顧客No
    memberNo.value = '';
    // ポイント累計の表示有無
    viewMemberPoints.value= false;
    // ポイント累計
    pointCumulateTotal.value = '';
  }

  /// 返品モードの開始
  void startRefundflag(String refundDate) {
    RegsMem().refundDate = refundDate;
    RegsMem().refundFlag = true;
    refundFlag.value = true;
    RckyRfdopr.rcRfdOprBtnClicked(RfdOprFuncBtnType.RFDOPR_FUNC_MANUAL_RFD);

    // ＋ボタンの表示切替
    setAddTabVisibleFlag();
  }

  /// 返品モードのクリア
  void clearRefundflag() {
    RegsMem().refundDate = '';
    RegsMem().refundFlag = false;
    refundFlag.value = false;
    RckyRfdopr.rfdSaveData.refundMode = RefundModeList.RFDOPR_MODE_SELECT;
    RckyRfdopr.rcRfdOprBtnClicked(RfdOprFuncBtnType.RFDOPR_FUNC_QUIT);

    // ＋ボタンの表示切替
    setAddTabVisibleFlag();
  }

  /// ＋ボタンの表示切替
  void setAddTabVisibleFlag() {
    addTabVisibleFlag.value = refundFlag.value == false
        && tabBtnIndex.value < transactionManagement.count
        && transactionManagement.getAt(tabBtnIndex.value).isExsitData()
        && transactionManagement.count < maxTabBtnCont;
  }


  /// トランザクションデータの保存（RegsMemのデータを保存）
  void saveTransactionData({
    bool? isAlreadyWarning
  }) {
    transactionManagement.save(
      index: tabBtnIndex.value,
      lastRequestData: RegsMem().lastRequestData,
      lastResultData: RegsMem().lastResultData,
      refundDate: RegsMem().refundDate,
      isAlreadyWarning: isAlreadyWarning,
    );
    TprLog().logAdd(Tpraid.TPRAID_NONE, LogLevelDefine.normal, 'saveTransactionData index=${tabBtnIndex.value}');
  }

  /// 処理概要：商品明細データのバックアップ保存
  /// パラメータ：int purchaseDataIndex
  ///           商品明細データリストのインデックス
  /// 戻り値：なし
  void setPurchaseDataBackup(int purchaseDataIndex) {
    // バックアップ対象の商品明細をJSON形式に変換
    var itemDataJson =
    jsonEncode(purchaseData[purchaseDataIndex].itemLog.itemData.toJson());
    debugPrint("商品明細データのバックアップ取得：$itemDataJson");
    // 商品明細のバックアップデータを保存
    backupResultItemData = ResultItemData.fromJson(jsonDecode(itemDataJson));
    return;
  }

  /// 処理概要：商品明細データのバックアップ書き戻し
  /// パラメータ：int purchaseDataIndex
  ///           商品明細データリストのインデックス
  /// 戻り値：なし
  void resetResultItemData(int purchaseDataIndex) {
    if (backupResultItemData != null) {
      purchaseData[purchaseDataIndex].itemLog.itemData =
      backupResultItemData!;
      backupResultItemData = null;
    }
    return;
  }
  
  /// 釣機の有効無効取得
  Future<bool> isChangeEnable() async {
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
    if (dataList.isNotEmpty) {
      for (int i = 0; i < dataList.length; i++) {
        Map<String ,dynamic> data = dataList[i].toColumnMap();
        if ((data["cnct_grp"] == 2) && (data["drv_sec_name"] == "acb")) {
          sioSetting = true;
          break;
        }
      }
    }
    return sioSetting;
  }
 
  /// 釣機の最新の状態を取得して保持
  void getLatestChangeStatus() {
    CommonController.changeStatusType = _convertChangeType(Cpwr.getChangeStatus());
  }

  /// 釣機ONOFFの状態表示用
  /// パラメータ：なし
  /// 戻り値：なし
  void setDisplayStatus() {
    commonctrl.removeDisplayStatus();
    switch (CommonController.changeStatusType) {
      case ChangeType.none:
        commonctrl.changeDisplay.add(StatusType.notChange);
        break;
      case ChangeType.all:
        break;
      case ChangeType.billOff:
        commonctrl.changeDisplay.add(StatusType.billOff);
        break;
      case ChangeType.coinOff:
        commonctrl.changeDisplay.add(StatusType.coinOff);
        break;
    }
  }

  // 釣機ONOFF機能が許可されているか判定
  void displayChangeOnOrOff() {
    if (RegisterBodyController.changePermission.value) {
      setDisplayStatus();
    }
  }

  /// 画面遷移かエラー画面表示かを判定
  /// パラメータ：釣機ONOFF機能が許可されているかいないか
  /// 戻り値：なし
  void checkHasError(bool checkNoError) {
    if (checkNoError) {
      // 釣機ON/OFFが許可されている為、釣機ON/OFF画面表示
      getLatestChangeStatus();
      Get.to(() => ChangeCoinConnectionPage(title: "つり機接続"));
    } else {
      // 釣機が無効な場合、エラーダイアログを表示
      MsgDialog.show(MsgDialog.singleButtonDlgId(
        type: MsgDialogType.error,
        dialogId: DlgConfirmMsgKind.MSG_ACB_NEED.dlgId,
        btnFnc: () {
          Get.back();
          ChangeCoinConnectionPage.isProcessing = false;
        },
      ));
    }
  }

  /// 釣機状態の取得値をフロント側のChangeTypeに変換する
  ChangeType _convertChangeType((int ,int) value) {
    if (value.$1 == ChangeOnOff.on.index && value.$2 == ChangeOnOff.on.index) {
      return ChangeType.all;
    } else if (value.$1 == ChangeOnOff.on.index && value.$2 == ChangeOnOff.off.index) {
      return ChangeType.coinOff;
    } else if (value.$1 == ChangeOnOff.off.index && value.$2 == ChangeOnOff.on.index) {
      return ChangeType.billOff;
    }

    return ChangeType.none;
  }
}
