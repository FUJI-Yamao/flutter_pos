/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/number_util.dart';
import 'package:flutter_pos/app/ui/component/w_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/date_util.dart';
import '../../regs/checker/rcky_mg.dart';
import '../colorfont/c_basecolor.dart';
import '../page/common/component/w_msgdialog.dart';
import '../page/manual_input/component/w_classification_select_page.dart';
import '../page/manual_input/controller/c_mglogininput_controller.dart';

///入力ボックスモード
enum InputBoxMode {
  /// 普通モード
  defaultMode,

  ///日付モード
  calendar,

  ///金額モード
  formatNumber,

  ///￥付きの支払い金額モード
  payNumber,

  ///-￥付きの支払い金額モード
  minusPayNumber,

  ///割合（％）モード
  percentNumber,

  /// パスワードモード
  password,

  ///時間モード
  timeNumber,

  ///分類登録モード
  mgClassCode,
}

///　日付のセパレータとして使用される文字
const String dateSeparator = '/';

///　金額のセパレータとして使用される文字
const String numberSeparator = ',';

///　時間のセパレータとして使用される文字
const String timeSeparator = ':';

///　支払いのセパレータとして使用される文字
const String paySeparator = '¥';

///　値引きのセパレータとして使用される文字
const String minusPaySeparator = '-';

///　割合表示のセパレータとして使用される文字
const String percentSeparator = '%';

/// 入力ボックスWidget
/// 入力部分にカーソルが表示される.
class InputBoxWidget extends StatefulWidget {
  /// テンキーから入力内容を送るするため、GlobalKey<InputBoxWidgetState> key が必須.
  /// このWidgetを呼び出したWidgetでkeyを定義し、キー処理のControllerに渡す.
  /// キー処理のコントローラーで、キーで行われた処理に合わせてInputBoxWidgetStateの関数を呼びだす.
  const InputBoxWidget({
    required super.key,
    required this.width,
    required this.height,
    required this.fontSize,
    this.iniShowCursor = true,
    this.iniCursorPosition,
    this.unfocusedColor = BaseColor.someTextPopupArea,
    this.fontColor = BaseColor.maintainInputFontColor,
    this.initStr = "",
    this.funcBoxTap,
    this.focusedBorder = BaseColor.maintainInputAreaBorder,
    this.borderRadius = 0,
    this.shadow,
    this.cursorColor = BaseColor.maintainInputCursor,
    this.textAlign = TextAlign.left,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.focusedColor = BaseColor.someTextPopupArea,
    this.focusedShadow = BaseColor.inputShadowColor,
    this.unfocusedBorder = BaseColor.inputFieldColor,
    this.blurRadius = 0,
    this.mode = InputBoxMode.defaultMode,
    this.calendarTitle = "",
    this.onComplete,
    this.onCompleteClass,
    this.initStrTextStyle,
    this.useInitStrTextStyle = false,
  });

  /// boxの横幅.
  final double width;

  /// boxの高さ.
  final double height;

  /// フォントサイズ.
  final double fontSize;

  /// フォントカラー.
  final Color fontColor;

  ///  入力boxの背景色.
  final Color unfocusedColor;

  /// 初期値.
  final String initStr;

  /// 初期値スタイル.
  final TextStyle? initStrTextStyle;

  /// 初期表示時にカーソル表示をするか.
  final bool iniShowCursor;

  /// 初期表示時のカーソルの現在地.0で一番左
  final int? iniCursorPosition;

  /// 入力boxをタップした時の処理.
  final Function? funcBoxTap;

  /// 入力boxをタップした時の枠線.
  final Color focusedBorder;

  ///　入力boxの枠線.
  final Color unfocusedBorder;

  ///　丸角.
  final double borderRadius;

  ///　入力boxシャドウ.
  final List<BoxShadow>? shadow;

  ///　カーソル色.
  final Color cursorColor;

  ///　テキスト配置.
  final TextAlign? textAlign;

  ///　テキスト余白.
  final EdgeInsets padding;

  ///　入力boxをタップした時の背景色.
  final Color focusedColor;

  ///　入力boxをタップした時のシャドウ色.
  final Color focusedShadow;

  ///　シャドウのぼかし.
  final double blurRadius;

  /// 入力ボックスモード
  final InputBoxMode mode;

  ///　カレンダー画面タイトル
  final String calendarTitle;

  /// コールバック関数
  final Function? onComplete;

  ///分類登録専用 コールバック関数
  final Function(ManualSmlCls)? onCompleteClass;

  /// 表示テキストのスタイル指定有無
  final bool useInitStrTextStyle;


  @override
  InputBoxWidgetState createState() => InputBoxWidgetState();
}

/// 入力ボックスのState.
/// カーソルの位置や入力文字列の操作を行う.
class InputBoxWidgetState extends State<InputBoxWidget>
    with SingleTickerProviderStateMixin {
  InputBoxWidgetState();

  /// カーソルを点滅させるためのアニメーションコントローラー.
  late AnimationController animationController;

  /// 入力文字.
  String inputStr = "";

  /// カーソルの現在地.0で一番左
  int cursorPosition = 0;

  /// カーソル表示.
  bool showCursor = true;

  /// 表示用データ.
  List<String> displayData = [];

  /// 選択された日付を保持する変数
  /// 初期値は現在の日付
  DateTime selectedDate = DateTime.now();

  /// 初期値のテキストスタイル使うかどうか
  bool useInitStrTextStyle = false;

  ///  可変モード
  InputBoxMode flexibleMode = InputBoxMode.minusPayNumber;

  ///分類登録からの値なのか
  bool isFromMGSelection = false;

  ///　初期化処理.
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    )..repeat(reverse: true);

    inputStr = widget.initStr;
    displayData = widget.initStr.isNotEmpty ? [widget.initStr] : [];
    useInitStrTextStyle = widget.useInitStrTextStyle;
    cursorPosition = widget.iniCursorPosition ?? inputStr.length;
    showCursor = widget.iniShowCursor;
    updateDisp();
  }

  /// リソース解放
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///　カレンダーアイコンの場合のPadding設置
    EdgeInsets adjustedPadding;
    if (widget.mode == InputBoxMode.calendar || widget.mode == InputBoxMode.mgClassCode) {
      adjustedPadding = const EdgeInsets.only(right: 0);
    } else if(isFromMGSelection){
      adjustedPadding = EdgeInsets.only(left: 16.w);
    }
    else  {
      adjustedPadding = widget.padding;
    }

    /// inputboxのmode切り替え時の内容更新
    if (widget.mode == InputBoxMode.percentNumber ||
        widget.mode == InputBoxMode.minusPayNumber ||
        widget.mode == InputBoxMode.payNumber) {
      updateDisp();
    }

    TextAlign? currentTextAlign = isFromMGSelection ? TextAlign.left : (widget.textAlign);


    return InkWell(
      onTap: onBoxTap,
      child: Container(
        alignment:currentTextAlign == TextAlign.left ? Alignment.centerLeft : Alignment.centerRight,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: showCursor ? widget.focusedColor : widget.unfocusedColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: showCursor
                ? [
              BoxShadow(
                color: widget.focusedShadow,
                blurRadius: widget.blurRadius,
              )
            ]
                : [],
            border: Border.all(
                color:
                showCursor ? widget.focusedBorder : widget.unfocusedBorder,
                width: 1)),
        child: Padding(
          padding: adjustedPadding,
          child: Row(children: [
            if (currentTextAlign == TextAlign.right) const Spacer(),
            const SizedBox(width: 5),
            for (int index = 0; index < displayData.length; index++) ...{
              getCursorWidget(index),

              if (widget.mode == InputBoxMode.password)
                Text(
                  "●",
                  style: TextStyle(
                    color: widget.fontColor,
                    fontSize: widget.fontSize,
                  ),
                )
              else
                Text(
                  displayData[index],
                  style: useInitStrTextStyle
                      ? widget.initStrTextStyle
                      : TextStyle(
                    color: widget.fontColor,
                    fontSize: isFromMGSelection ? 18.sp : widget.fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
            },
            getCursorWidget(displayData.length),
            if (currentTextAlign == TextAlign.left) const Spacer(),

            /// 文字とアイコン間の距離
            /// アイコンをinputBoxの一番右に設置
            if (widget.mode == InputBoxMode.calendar) ...{
              const SizedBox(width: 24),
              _buildCalendarIcon(selectedDate, (newSelectedDate) {
                setState(() {
                  selectedDate = newSelectedDate;
                });
              }),
            }
            else if (widget.mode == InputBoxMode.mgClassCode) ...{
              const SizedBox(width: 24),
              _buildClassificationIcon(),

            }
          ]),
        ),
      ),
    );
  }

  /// 分類登録のアイコン実装
  Widget _buildClassificationIcon() {
    return Container(
      width: 48.w,
      height: widget.height,
      color: BaseColor.baseColor,
      child: InkWell(
        onTap: () async {
          /// アイコンボタン押されたらカスタマイズカレンダーに移動
          final selectedClass = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassificationSelectionPage(title: MGTitleConstants.mgTitle)),
          );

          if (selectedClass != null) {
            setState(() {
              inputStr = '[${selectedClass.clsNo} ${selectedClass.itemName}';
              displayData = [inputStr];
              cursorPosition = inputStr.length;
              isFromMGSelection = true;
            });

            if(widget.onCompleteClass != null) {
              widget.onCompleteClass!(selectedClass);
            }
            MGLoginInputController mgLogCtrl = Get.find<MGLoginInputController>();
            mgLogCtrl.checkAllInput();
          }
        },

        child: Center(
          child: SvgPicture.asset(
            'assets/images/icon_next.svg',
          ),
        ),
      ),
    );
  }

  /// カレンダーのアイコン実装
  Widget _buildCalendarIcon(
      DateTime selectedDate, Function(DateTime newSelectedDate) callBackDate) {
    return Container(
      width: 48.w,
      height: widget.height,
      color: BaseColor.baseColor,
      child: InkWell(
        onTap: () async {
          /// アイコンボタン押されたらカスタマイズカレンダーに移動
          final DateTime? pickedDate = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CalendarScreen(
                    title: widget.calendarTitle,
                    initialDate: selectedDate,
                    backgroundColor: BaseColor.receiptBottomColor)),
          );
          selectedDate = pickedDate ?? selectedDate;
          callBackDate(selectedDate);

          String formattedDate = DateFormat('yyyy/MM/dd').format(selectedDate);

          //選択さえた日付が99日以内かの確認、範囲外の場合はエラーダイアログを表示
          if (!DateUtil.isDateWithinRange(formattedDate, DateUtil.daysIn99)) {
            MsgDialog.show(
              MsgDialog.singleButtonMsg(
                type: MsgDialogType.error,
                message: "99日以内の日付を入力してください",
              ),
            );
          } else {
            if (pickedDate != null) {
              updateDate(pickedDate);
              _handleComplete();
              toggleUseInitStrTextStyle();
            }
          }
        },
        child: Center(
          child: SvgPicture.asset(
            'assets/images/icon_calendar.svg',
          ),
        ),
      ),
    );
  }

  ///日付更新の独自のinputDataメソッド
  ///文字列を個々文字のリストに文割する
  ///カーソル位置を一番右に設定
  void updateDate(DateTime pickedDate) {
    setState(() {
      inputStr = DateFormat('yyyyMMdd').format(pickedDate);
      updateDisp();
      setCursorPositionLast();
    });
  }

  ///初期TextStyleをデフォルトTextStyleと切り替わるメソッド,通番訂正へ影響なし
  void toggleUseInitStrTextStyle() {
    setState(() {
      useInitStrTextStyle = false;
    });
  }

  /// 点滅するカーソルWidgetを取得.
  Widget getCursorWidget(int index) {
    return showCursor && (cursorPosition == index)
        ? FadeTransition(
        opacity: animationController.drive(
          Tween<double>(
            begin: 0,
            end: 1,
          ),
        ),
        child: SizedBox(
            height: widget.fontSize + 2,
            width: 0,
            child: VerticalDivider(
              //width: ,
              thickness: 2,
              color: widget.cursorColor,
            )))
        : SizedBox(height: widget.height * 0.8, width: 0);
  }

  /// 入力ボックスがタップされたときの処理.
  void onBoxTap() {
    widget.funcBoxTap?.call();
  }

  /// 文字列をカーソルの位置に追加する.
  /// defaultMode使用
  void onAddStr(String data) {
    setState(() {
      inputStr = inputStr.substring(0, cursorPosition) +
          data +
          inputStr.substring(cursorPosition);
      updateDisp();
      setCursorPosition(updatePos(data));
    });
  }

  /// 文字列を全て差し替える.
  /// カーソルは末尾に移動する.
  /// calendarとformatNumberMode使用
  void onChangeStr(String data ) {
    setState(() {
      inputStr = data;
      updateDisp();
      setCursorPositionLast();
    });
  }

  /// カーソル位置で一文字削除する
  void onDeleteOne() {
    if (inputStr.isNotEmpty && cursorPosition > 0) {
      setState(() {
        int actualCursorPosition = calculateActualCursorPosition();
        if (actualCursorPosition > 0 &&
            actualCursorPosition <= inputStr.length) {
          inputStr = inputStr.substring(0, actualCursorPosition - 1) +
              inputStr.substring(actualCursorPosition);
          updateDisp();
          cursorPosition = calculateNewCursorAfterDeletion(
              cursorPosition, displayData.join());
        }
      });
    } else {
      setCursorPosition(0);
    }
  }

  /// 文字列を全て削除する.
  /// カーソルは先頭に移動する.
  void onDeleteAll() {
    setState(() {
      inputStr = "";
      setCursorPosition(0);
      updateDisp();
    });
  }

  /// カーソルの位置をセットする.
  /// 0で一番左端.
  void setCursorPosition(int index) {
    setState(() {
      cursorPosition = max(0, min(displayData.length, index));
    });
  }

  /// カーソルの位置を一つ左にずらす.
  /// 既に一番左の場合は何もおこらない.
  void setCursorPositionLeft({int movePos = 1}) {
    int newPos = cursorPosition - movePos;
    while (newPos > 0 &&
        (displayData[newPos - 1] == dateSeparator ||
            displayData[newPos - 1] == numberSeparator)) {
      newPos--;
    }
    setCursorPosition(newPos);
  }

  /// カーソルの位置を一つ右にずらす.
  /// 既に一番右の場合は何もおこらない.
  void setCursorPositionRight({int movePos = 1}) {
    int newPos = cursorPosition + movePos;
    newPos = min(newPos, displayData.length);
    while (newPos < displayData.length &&
        (displayData[newPos - 1] == dateSeparator ||
            displayData[newPos - 1] == numberSeparator)) {
      newPos++;
    }
    setCursorPosition(newPos);
  }

  /// カーソルの位置を一番初めへ変更する.
  /// 既に一番右の場合は何もおこらない.
  void setCursorPositionFirst() {
    setCursorPosition(0);
  }

  /// カーソルの位置を一番最後へ変更する.
  /// 既に一番右の場合は何もおこらない.
  void setCursorPositionLast() {
    setCursorPosition(displayData.length);
  }

  /// カーソルを非表示にする.
  void setCursorOff() {
    setState(() {
      showCursor = false;
    });
  }

  /// カーソルを表示する.
  void setCursorOn() {
    setState(() {
      showCursor = true;
    });
  }

  /// 表示用データ更新する
  void updateDisp() {
    setState(() {
      switch (widget.mode) {
        case InputBoxMode.calendar:
          displayData = _formatDate(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.calendar);
          break;
        case InputBoxMode.formatNumber:
          displayData = _formatNumber(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.formatNumber);
          break;
        case InputBoxMode.payNumber:
          displayData = _formatpayNumber(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.payNumber);
          break;
        case InputBoxMode.timeNumber:
          displayData = _formatTime(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.timeNumber);
          break;
        case InputBoxMode.minusPayNumber:
          displayData = _formatminuspayNumber(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.minusPayNumber);
          break;
        case InputBoxMode.percentNumber:
          displayData = _formatpercentNumber(inputStr).split('');
          cursorPosition = calculateNewCursorPosition(inputStr,
              displayData.join(), cursorPosition, InputBoxMode.percentNumber);
          break;
        default:
          displayData = inputStr.split('');
      }
    });
  }

  /// 日付フォーマット処理
  String _formatDate(String dateStr) {
    if (dateStr.length >= 4) {
      String year = dateStr.substring(0, 4);
      String month = '';
      String day = '';

      if (dateStr.length > 4) {
        int monthLength = dateStr.length >= 6 ? 2 : dateStr.length - 4;
        month = dateStr.substring(4, 4 + monthLength);
      }
      if (dateStr.length > 6) {
        day = dateStr.substring(6);
      }
      return year +
          (month.isNotEmpty ? "/$month" : "") +
          (day.isNotEmpty ? "/$day" : "");
    } else {
      return dateStr;
    }
  }

  /// ￥支払いの金額フォーマット処理
  String _formatpayNumber(String inputStr) {
    String payInputStr =
    inputStr.replaceAll(numberSeparator, '').replaceAll(paySeparator, '');
    int? number = int.tryParse(payInputStr);
    return number != null ? NumberFormatUtil.formatAmount(number) : inputStr;
  }

  /// -￥支払いの金額フォーマット処理
  String _formatminuspayNumber(String inputStr) {
    String payInputStr = inputStr
        .replaceAll(numberSeparator, '')
        .replaceAll(minusPaySeparator, '')
        .replaceAll(paySeparator, '');
    int? number = int.tryParse(payInputStr);
    return number != null
        ? NumberFormatUtil.formatMinusAmount(number)
        : inputStr;
  }

  /// 割合表示のフォーマット処理
  String _formatpercentNumber(String inputStr) {
    String payInputStr = inputStr
        .replaceAll(numberSeparator, '')
        .replaceAll(percentSeparator, '');
    int? number = int.tryParse(payInputStr);
    return number != null ? NumberFormatUtil.formatPercent(number) : inputStr;
  }

  /// 金額フォーマット処理
  String _formatNumber(String inputStr) {
    int? number = int.tryParse(inputStr.replaceAll(numberSeparator, ''));
    return number != null
        ? NumberFormatUtil.getNumberStr(
        NumberFormatUtil.formatForAmountStr, number)
        : inputStr;
  }

  /// 時間フォーマット処理
  String _formatTime(String inputStr) {
    return NumberFormatUtil.formatTime(inputStr);
  }

  ///入力ボックスモードに基づいてカーソル位置を更新
  int calculateActualCursorPosition() {
    int actualCursorPosition = cursorPosition;
    switch (widget.mode) {
      case InputBoxMode.calendar:
        int slashCount = 0;
        for (int i = 0; i < min(cursorPosition, displayData.length); i++) {
          if (displayData[i] == dateSeparator) slashCount++;
        }
        actualCursorPosition -= slashCount;
        break;
      case InputBoxMode.payNumber:
        int commaCount = 0;
        for (int i = 0; i < cursorPosition && i < displayData.length; i++) {
          if (displayData[i] == numberSeparator) commaCount++;
          if (displayData[i] == paySeparator) actualCursorPosition--;
        }
        actualCursorPosition -= commaCount;
        break;
      case InputBoxMode.formatNumber:
        int commaCount = 0;
        for (int i = 0; i < cursorPosition && i < displayData.length; i++) {
          if (displayData[i] == numberSeparator) commaCount++;
        }
        actualCursorPosition -= commaCount;
        break;
      case InputBoxMode.timeNumber:
        int timeCount = 0;
        for (int i = 0; i < cursorPosition && i < displayData.length; i++) {
          if (displayData[i] == timeSeparator) timeCount++;
        }
        actualCursorPosition -= timeCount;
        break;
      case InputBoxMode.minusPayNumber:
        int commaCount = 0;
        for (int i = 0; i < cursorPosition && i < displayData.length; i++) {
          if (displayData[i] == numberSeparator) commaCount++;
          if (displayData[i] == paySeparator) actualCursorPosition--;
          if (displayData[i] == minusPaySeparator) actualCursorPosition--;
        }
        actualCursorPosition -= commaCount;
        break;
      case InputBoxMode.percentNumber:
        int commaCount = 0;
        for (int i = 0; i < cursorPosition && i < displayData.length; i++) {
          if (displayData[i] == percentSeparator) actualCursorPosition--;
        }
        actualCursorPosition -= commaCount;
        break;
      default:
        return cursorPosition;
    }

    return actualCursorPosition;
  }

  ///削除後のカーソル位置を更新する
  ///削除する際に「/」[￥] [:]「,」をスキップする
  int calculateNewCursorAfterDeletion(
      int oldCursorPosition, String displayData) {
    int newCursorPosition = oldCursorPosition;
    bool shouldDecrement = true;

    while (newCursorPosition > 0 && shouldDecrement) {
      shouldDecrement = false;
      switch (widget.mode) {
        case InputBoxMode.calendar:
          if (displayData[newCursorPosition - 1] == dateSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        case InputBoxMode.payNumber:
          if (displayData[newCursorPosition - 1] == paySeparator ||
              displayData[newCursorPosition - 1] == numberSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        case InputBoxMode.formatNumber:
          if (displayData[newCursorPosition - 1] == numberSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        case InputBoxMode.timeNumber:
          if (displayData[newCursorPosition - 1] == timeSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        case InputBoxMode.minusPayNumber:
          if (displayData[newCursorPosition - 1] == paySeparator ||
              displayData[newCursorPosition - 1] == minusPaySeparator ||
              displayData[newCursorPosition - 1] == numberSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        case InputBoxMode.percentNumber:
          if (displayData[newCursorPosition - 1] == percentSeparator) {
            newCursorPosition--;
            shouldDecrement = true;
          }
          break;
        default:
          return max(0, oldCursorPosition - 1);
      }
    }
    return newCursorPosition;
  }

  /// 表示用データ更新用
  /// 入力ボックスモードに基づいてカーソル位置を更新
  int calculateNewCursorPosition(
      String oldStr, String newStr, int oldCursorPosition, InputBoxMode mode) {
    int newCursorPosition = oldCursorPosition;
    for (int i = 0; i < min(newCursorPosition, newStr.length); i++) {
      switch (widget.mode) {
        case InputBoxMode.calendar:
          if (newStr[i] == dateSeparator) newCursorPosition++;
          break;
        case InputBoxMode.payNumber:
          if (newStr[i] == paySeparator || newStr[i] == numberSeparator) {
            newCursorPosition++;
          }
          break;
        case InputBoxMode.formatNumber:
          if (newStr[i] == numberSeparator) newCursorPosition++;
          break;
        case InputBoxMode.timeNumber:
          if (newStr[i] == timeSeparator) newCursorPosition++;
          break;
        case InputBoxMode.minusPayNumber:
          if (newStr[i] == paySeparator ||
              newStr[i] == minusPaySeparator ||
              newStr[i] == numberSeparator) newCursorPosition++;
          break;
        case InputBoxMode.percentNumber:
          if (newStr[i] == percentSeparator) newCursorPosition++;
          break;
        default:
          break;
      }
    }
    return min(newCursorPosition, newStr.length);
  }

  /// onAddStringカーソル位置を更新
  int updatePos(String data) {
    int newCursorPosition = cursorPosition;
    int dataLength = data.length;
    newCursorPosition += dataLength;

    Map<InputBoxMode, String> modeSeparator = {
      InputBoxMode.calendar: dateSeparator,
      InputBoxMode.formatNumber: numberSeparator,
      InputBoxMode.payNumber: numberSeparator,
      InputBoxMode.minusPayNumber: minusPaySeparator,
      InputBoxMode.percentNumber: percentSeparator,
      InputBoxMode.timeNumber: timeSeparator,
    };

    String? currentSeparator = modeSeparator[widget.mode];

    if (currentSeparator != null) {
      for (int i = cursorPosition; i < newCursorPosition; i++) {
        if (i < displayData.length && displayData[i] == currentSeparator) {
          newCursorPosition++;
        }
      }
    }
    return min(newCursorPosition, displayData.length);
  }

  ///　「決定」処理を行うハンドラ
  void _handleComplete() {
    if (widget.onComplete != null) {
      widget.onComplete!();
    }
  }
}
