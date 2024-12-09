/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../clxos/calc_api.dart';
import '../../../../../clxos/calc_api_data.dart';
import '../../../../../clxos/calc_api_result_data.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../regs/checker/rcky_mg.dart';
import '../../../component/w_inputbox.dart';
import '../../common/component/w_msgdialog.dart';
import '../../register/controller/c_registerbody_controller.dart';
import '../../subtotal/component/w_register_tenkey.dart';
import '../component/w_mglogin_dialogpage.dart';


/// 手入力パターン
enum ManualInputType {
  ///売価入力欄
  priceSelected,

  ///分類入力欄
  clsCodeSelected
}

class MGTitleConstants {
  static const String mgTitle = '分類登録';
}

///分類登録ダイアログのコントローラ
class MGLoginInputController extends GetxController {

  ///先に金額を入力した場合の表示
  String? initialPrice;

  ///先に分類を入力した場合の表示
  String? initialMGIndex;

  ///先に分類を入力した場合の表示
  String? searchedClsName;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  /// 分類登録画面初期化処理
  ///         onInit()で実行すると初回実行時しか走らないため分類登録画面を起動する度に毎回コールする
  /// パラメータ：int initialPrice：手入力金額
  ///         ：int initialMGIndex：手入力コード
  /// 戻り値：なし
  Future<void> createClsCodeList(
      String? initialPrice, String? initialMGIndex) async {
    this.initialPrice = initialPrice;
    this.initialMGIndex = initialMGIndex;

    /// クラウドPOSから分類コードリストを取得
    listClsCode = await getSmlClsCdList();

    ///　プルダウン表示用のリストを作成
    displayCodeList = await getClsCdList();

    ///売価未入力の場合は分類名称を取得する
    if (initialPrice == null) {
      searchedClsName = getClsName(initialMGIndex);
    }

    ///初期分類コードが存在する場合、その分類を入力欄に設定
    if (initialMGIndex != null && initialMGIndex.isNotEmpty) {
      ManualSmlCls? selectedClass = listClsCode?.firstWhere(
        (cls) => cls.clsNo.trim() == initialMGIndex.trim(),
        orElse: () => ManualSmlCls(clsNo: '', clsVal: 0, itemName: ''),
      );

      if (selectedClass != null && selectedClass.clsNo.isNotEmpty) {
        selectedClassification = selectedClass;
        classificationInputKey.currentState
            ?.onChangeStr('[${selectedClass.clsNo}] ${selectedClass.itemName}');
      } else {
        classificationInputKey.currentState?.onChangeStr(initialMGIndex);
      }
    }

    ///初期売価が存在する場合、その分類を入力欄に設定
    if (initialPrice != null && initialPrice.isNotEmpty) {
      mgLoginPriceInputKey.currentState?.onChangeStr(initialPrice);
    }

    ///全ての入力欄が入力したかどうかのチェック,ページ初期化時にボタン状態の確認
    checkAllInput();

    updateFocusState();
    return;
  }

  ///入力boxの状態を管理ための価格のGlobalKey
  final GlobalKey<InputBoxWidgetState> mgLoginPriceInputKey =
      GlobalKey<InputBoxWidgetState>();

  //分類登録のGlobalKey
  final GlobalKey<InputBoxWidgetState> classificationInputKey =
      GlobalKey<InputBoxWidgetState>();

  ///売価金額最大桁数
  static const int priceNumLength = 7;

  ///売価金額最大値
  static const int priceAmountMax = 99999999;

  ///分類登録最大桁数,分類コード表示スペース数
  static const int classCodeLength = 6;

  ///テンキー表示フラグ
  var showRegisterTenKey = false.obs;

  ///確定ボタン表示するかどうか
  var showConfirmButton = false.obs;

  /// 選択されたリストのインデックス
  int selectedIndex = -1;

  /// 入力ボックスに最初の文字入力を行う状態
  var isFirstInput = true.obs;

  /// 分類コードリスト
  List<ManualSmlCls>? listClsCode;

  /// 分類コード表示用リスト
  List<String> displayCodeList = [];

  ///選択された分類アイテムを保存
  ManualSmlCls? selectedClassification;

  ///最初の入力インプットボックスタイプ
  ManualInputType? currentInputType;

  /// 編集中の現在売価
  var currentCoinOutPrc = 0.obs;

  //タップされた処理
  void onInBoxTap(int index) {
    currentInputType = index == 0
        ? ManualInputType.priceSelected
        : ManualInputType.clsCodeSelected;
    updateFocusState();
    showRegisterTenKey.value = true;
    isFirstInput.value = true;
    showConfirmButton.value = false;
  }

  /// 金額欄入力範囲
  bool isValueInRange(String value) {
    if (value.isEmpty) {
      return false;
    }
    int intValue = int.tryParse(value) ?? 0;
    return (intValue >= -priceAmountMax) && (intValue <= priceAmountMax);
  }

  ///お預かり金額の入力処理.
  void _handlePriceKeys(KeyType key) {
    String currentValue = getPriceInput();
    String keyValue = key.name;

    if (!_isValidNumberInput(currentValue, keyValue, priceNumLength)) {
      _showErrorMessage("入力上限額は9,999,999円までです");
      return;
    }
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      mgLoginPriceInputKey.currentState?.onChangeStr(currentValue);
    } else {
      return;
    }
  }

  ///分類選択の入力処理.
  void _handleClassKeys(KeyType key) {
    String currentValue = getClassInput();
    String keyValue = key.name;

    if (!_isValidNumberInput(currentValue, keyValue, classCodeLength)) {
      _showErrorMessage("分類コードは六桁まで");
      return;
    }
    if ((currentValue.isEmpty || currentValue == "0") &&
        (keyValue == "0" || keyValue == "00")) {
      return;
    }

    String newValue = currentValue + keyValue;
    if (isValueInRange(newValue)) {
      currentValue += keyValue;
      classificationInputKey.currentState?.onChangeStr(currentValue);
    } else {
      return;
    }
  }

  ///全ての入力欄が入力したかどうかのチェックし、確定ボタンの表示状態を更新
  bool checkAllInput() {
    String priceInput = getPriceInput();
    String classInput = getClassInput();

    bool allInput = priceInput.isNotEmpty && classInput.isNotEmpty;
    showConfirmButton.value = allInput;
    showRegisterTenKey.value = !allInput;

    return allInput;
  }

  ///現在のインプットボックス入力状態
  InputBoxWidgetState? get currentInputBoxState {
    switch (currentInputType) {
      case ManualInputType.priceSelected:
        return mgLoginPriceInputKey.currentState;
      case ManualInputType.clsCodeSelected:
        return classificationInputKey.currentState;
      default:
        return null;
    }
  }

  ///キータイプに応じた入力処理.
  Future<void> inputKeyType(KeyType key) async {
    if (!showRegisterTenKey.value || currentInputType == null) {
      return;
    }

    switch (key) {
      case KeyType.delete:
        _deleteOneChar();
        break;
      case KeyType.check:
        _decideButtonPressed();
        break;
      case KeyType.clear:
        _clearString();
        break;
      default:
        // タップ直後は文字入力時に古い内容をクリアする
        if (isFirstInput.value) {
          // 一文字でも入力したらクリアしないようにフラグ削除
          isFirstInput.value = false;
          _clearString();
        }
        if (currentInputType == ManualInputType.priceSelected) {
          _handlePriceKeys(key);
        } else if (currentInputType == ManualInputType.clsCodeSelected) {
          _handleClassKeys(key);
        }
        break;
    }
  }

  ///売価入力の文字列取得
  String getPriceInput() {
    return mgLoginPriceInputKey.currentState?.inputStr ?? '';
  }

  ///分類入力の文字列取得
  String getClassInput() {
    return classificationInputKey.currentState?.inputStr ?? '';
  }

  ///　タップした入力boxから文字列取得処理
  String getNowStr() {
    String inputStr = currentInputBoxState?.inputStr ?? '';
    return inputStr.replaceAll(',', '').replaceAll('¥', '');
  }

  /// 一文字削除処理.
  void _deleteOneChar() {
    String value = getNowStr();
    if (value.isEmpty) return;
    currentInputBoxState?.onDeleteOne();
  }

  /// 番号入力条件
  bool _isValidNumberInput(
      String currentValue, String keyValue, int maxLength) {
    if (currentValue.length + keyValue.length > maxLength) return false;

    return true;
  }

  /// Cをタップされた場合のクリア関数
  void _clearString() {
    currentInputBoxState?.onDeleteAll();
  }

  /// エラーダイアログ表示処理（引数：メッセージ）
  void _showErrorMessage(String message) {
    MsgDialog.show(
      MsgDialog.singleButtonMsg(
        type: MsgDialogType.error,
        message: message,
      ),
    );
  }

  /// 現在の入力boxのカーソルを非表示.
  void _closeCurrentCursor() {
    currentInputBoxState?.setCursorOff();
  }

  /// 更新フォーカス.
  void updateFocusState() {
    switch (currentInputType) {
      case ManualInputType.priceSelected:
        mgLoginPriceInputKey.currentState?.setCursorOn();
        classificationInputKey.currentState?.setCursorOff();
        break;
      case ManualInputType.clsCodeSelected:
        classificationInputKey.currentState?.setCursorOn();
        mgLoginPriceInputKey.currentState?.setCursorOff();
        break;
      default:
        mgLoginPriceInputKey.currentState?.setCursorOff();
        classificationInputKey.currentState?.setCursorOff();
        break;
    }
  }

  /// テンキーの「決定」ボタンで入金完了の処理
  void _decideButtonPressed() {
    String price = getNowStr();
    String classification = "";

    /// 選択された分類コードを取得
    if (selectedIndex >= 0 && selectedIndex < displayCodeList.length) {
      classification = displayCodeList[selectedIndex];
    }
    String manualInputClass = getClassInput();

    /// すべての入力欄が入力済であることチェック
    if (checkAllInput()) {
      return;
    }
    if (price.isEmpty) {
      _showErrorMessage('売価を入力してください');
      return;
    }

    if (classification.isEmpty && manualInputClass.isEmpty) {
      _showErrorMessage('分類を入力してください');
      return;
    }

    /// 手入力の分類コードが存在する場合、その値を使用
    if (manualInputClass.isNotEmpty) {
      classification = manualInputClass;
    }

    _closeCurrentCursor();
  }

  ///「確定」ボタン押された処理
  Future<void> confirmButtonPressed() async {
    String price = getPriceInput();
    String classification = "";

    String manualInputClass = getClassInput();

    ///手入力された分類コードが存在する場合、その値を使用
    if (manualInputClass.isNotEmpty) {
      classification = manualInputClass;
    } else if (selectedIndex >= 0 && selectedIndex < displayCodeList.length) {
      classification = displayCodeList[selectedIndex];
    } else {
      return;
    }

    MGLoginPageManager.closePage();

    String selectedCode = '';

    ///分類コードの中から実際のコードを抽出
    int startIndex = classification.indexOf("[");
    int endIndexIndex = classification.indexOf("]");
    if (startIndex > -1 && endIndexIndex > startIndex) {
      selectedCode = classification.substring(startIndex + 1, endIndexIndex);
    } else {
      selectedCode = classification.trim();
    }

    ///サーバーに分類コードと売価金額を登録
    await inputManualRegistSmlCls(selectedCode, price);
    Get.back();
  }

  /// 処理概要：手入力操作 サーバから分類コードリスト取得
  /// パラメータ：なし
  /// 戻り値：サーバから取得した分類コードリスト
  static Future<List<ManualSmlCls>> getSmlClsCdList() async {
    List<ManualSmlCls> returnList = [];

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return returnList;
    }
    RxCommonBuf pCom = xRet.object;

    /// 分類情報取得パラメータ作成
    GetClassInfoParaChanger para = GetClassInfoParaChanger(
        compCd: pCom.dbRegCtrl.compCd,
        streCd: pCom.dbRegCtrl.streCd,
        macNo: pCom.dbRegCtrl.macNo);

    /// 分類情報取得実施
    final stopWatch = Stopwatch();
    stopWatch.start();
    GetClassInfo retData = await CalcApi.getClassInfoApi(para);
    stopWatch.stop();
    debugPrint(
        'Clxos CalcApi.changerIn() ${stopWatch.elapsedMilliseconds}[ms]');

    int itemCount = retData.clsList?.length ?? 0;
    if (itemCount == 0) {
      return returnList;
    }

    /// 取得した情報をリストに取得
    for (int i = 0; i < itemCount; i++) {
      ClsListData data = retData.clsList?[i] as ClsListData;
      String clsCd = data.code.toString().padLeft(classCodeLength, ' ');
      ManualSmlCls item =
          ManualSmlCls(clsNo: clsCd, clsVal: 0, itemName: data.name ?? '');
      returnList.add(item);
    }
    return returnList;
  }

  /// 処理概要：手入力操作 小分類登録
  /// パラメータ：smlClsCd 分類コード
  ///           smlClsVal 金額
  /// 戻り値：なし
  Future<void> inputManualRegistSmlCls(
      String smlClsCd, String smlClsVal) async {
    try {
      int sendClsCNo = int.parse(smlClsCd.trim());
      int sendClsVal = int.parse(smlClsVal.trim());
      var bodyCtrl = Get.find<RegisterBodyController>();
      bodyCtrl.selectedPlu('', 1, sendClsCNo, sendClsVal);
    } catch (e) {
      _showErrorMessage('入力された値は正しくありません');
      return;
    }
  }

  /// 処理概要：手入力操作 小分類登録 プルダウンリスト表示用リスト作成処理
  /// パラメータ：なし
  /// 戻り値：プルダウン表示リスト
  Future<List<String>> getClsCdList() async {
    List<String> resultList = [];
    String addString = '';

    /// nullableを展開
    String inputCodeString = '';
    List<ManualSmlCls> clsList = listClsCode ?? [];

    if (initialMGIndex != null) {
      inputCodeString = initialMGIndex!;
      addString = inputCodeString.padLeft(classCodeLength, ' ');
    }
    if (clsList.isEmpty) {
      resultList.add('[$addString]');

      ///Windows用のダミーデータ
      listClsCode = [
        ManualSmlCls(clsNo: '      1', clsVal: 1, itemName: '分類1'),
        ManualSmlCls(clsNo: '      2', clsVal: 2, itemName: '分類2'),
        ManualSmlCls(clsNo: '      3', clsVal: 3, itemName: '分類3'),
        ManualSmlCls(clsNo: '      4', clsVal: 4, itemName: '分類4'),
        ManualSmlCls(clsNo: '      5', clsVal: 5, itemName: '分類5'),
        ManualSmlCls(clsNo: '      6', clsVal: 6, itemName: '分類6'),
      ];
    }
    clsList = listClsCode!;

    /// 画面表示用ボタン文言作成
    for (ManualSmlCls cls in listClsCode!) {
      String displayText = '[${cls.clsNo}] ${cls.itemName}';
      resultList.add(displayText);
    }

    return resultList;
  }

  /// 処理概要：選択された文字列を取得
  /// パラメータ：なし
  /// 戻り値：選択中の小分類コード文字列
  String getDefaultItem() {
    String result = "";
    if (displayCodeList.isNotEmpty) {
      result = displayCodeList[selectedIndex];
    }
    return result;
  }

  /// 処理概要：手入力操作 小分類登録 分類名称取得処理
  /// パラメータ：手入力された分類コード
  /// 戻り値：分類コードから逆引きした分類名称
  String getClsName(String? clsNo) {
    if (clsNo == null || listClsCode == null) {
      return '';
    }

    ManualSmlCls? selectedClass = listClsCode?.firstWhere(
      (cls) => cls.clsNo == clsNo.padLeft(classCodeLength, ' '),
      orElse: () => ManualSmlCls(clsNo: '', clsVal: 0, itemName: 'xxx'),
    );

    return '[${selectedClass?.clsNo}] ${selectedClass?.itemName}';
  }

  ///分類リストから選択された分類の情報処理と保存、入力欄に反映させる
  void onClassificationSelected(ManualSmlCls selectedClass) {
    selectedClassification = selectedClass;
    selectedIndex =
        listClsCode?.indexWhere((cls) => cls.clsNo == selectedClass.clsNo) ??
            -1;

    String displayText =
        '[${selectedClassification!.clsNo}] ${selectedClassification!.itemName}';
    classificationInputKey.currentState?.onChangeStr(displayText);
  }
}
