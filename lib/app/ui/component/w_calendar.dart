/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_pos/app/ui/component/w_sound_buttons.dart';
import 'package:flutter_pos/app/ui/page/common/component/w_dicisionbutton.dart';
import 'package:flutter_pos/app/ui/page/common/basepage/common_base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../common/date_util.dart';

///カレンダーのUI通番訂正のAPPBARを継承する
class CalendarScreen extends CommonBasePage {
  final DateTime initialDate;

  CalendarScreen({
    super.key,
    required super.title,
    DateTime? initialDate,
    super.backgroundColor = BaseColor.receiptBottomColor,
  }) : initialDate = initialDate ?? DateTime.now();

  @override
  Widget buildBody(BuildContext context) {
    return CalendarWidget(
      backgroundColor: backgroundColor,
      initialDate: initialDate,
    );
  }
}

///カスタマイズ　カレンダーの　StatefulWidget　UIウイジェット
class CalendarWidget extends StatefulWidget {
  final Color backgroundColor;
  final DateTime initialDate;

  const CalendarWidget(
      {super.key, required this.backgroundColor, required this.initialDate});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

///カレンダーのState
///データとロジックを保持し、状態の更新を応じてUI構築
class CalendarWidgetState extends State<CalendarWidget> {
  ///現在選択されている日付
  late DateTime _selectedDate;

  ///表示されている焦点のある日付
  late DateTime? _focusedDate;

  ///フォーマットあ後の日付文字列を格納するための変数
  String inputData = '';

  @override
  void initState() {
    super.initState();

    ///選択されている日付を今日の日付に設定
    _selectedDate = widget.initialDate;

    ///現在の月の最初の日に初期化
    _focusedDate = DateTime(_selectedDate.year, _selectedDate.month, 1);

    ///対応するロケールが初期化される
    DateUtil.localInitialzed('ja_JP');
  }

  ///選択された新しい日付で状態を更新する
  void updateDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      inputData = DateFormat('yyyy/MM/dd').format(newDate);
    });
  }

  ///前の月に移動する関数
  void goToPreviousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate!.year, _focusedDate!.month - 1);
    });
  }

  ///次の月に移動する関数
  void goToNextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate!.year, _focusedDate!.month + 1);
    });
  }

  ///カレンダー日付と週の初めの曜日を計算し、UI構築
  @override
  Widget build(BuildContext context) {
    ///月の最初の日が週の何日目かを取得
    final firstDayOfWeek = _focusedDate?.weekday;

    ///月の総日数と前にある空白日数を計算
    final daysInMonth =
        DateUtils.getDaysInMonth(_focusedDate!.year, _focusedDate!.month);

    final emptyDays = (firstDayOfWeek! - DateTime.sunday) % 7;
    final totalDays = emptyDays + daysInMonth;

    ///頂部のカレンダーから日付を指定してください部分
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(88.h),
        child: Container(
          height: 88.h,
          color: BaseColor.someTextPopupArea.withOpacity(0.7),
          alignment: Alignment.center,
          child: const Text(
            'カレンダーから日付を指定してください',
            style: TextStyle(
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familyDefault),
          ),
        ),
      ),

      ///左側の日付の選択部分
      body: Stack(
        children: [
          Row(
            children: [
              Container(
                width: 264.w,
                color: BaseColor.accentsColor,
                child: Stack(
                  children: [
                    Positioned(
                      left: 40.w,
                      top: 40.h,
                      child: const Text(
                        '日付の選択',
                        style: TextStyle(
                            color: BaseColor.someTextPopupArea,
                            fontSize: BaseFont.font18px,
                            fontFamily: BaseFont.familyDefault),
                      ),
                    ),
                    Positioned(
                      left: 40.w,
                      top: 119.h,
                      child: Text(
                        DateFormat('yyyy/MM/dd').format(_selectedDate),
                        style: const TextStyle(
                            color: BaseColor.someTextPopupArea,
                            fontSize: BaseFont.font34px,
                            fontFamily: BaseFont.familyNumber),
                      ),
                    ),
                    Positioned(
                      left: 40.w,
                      top: 169.h,
                      child: Text(
                        DateUtil.formatShortWeekday(_selectedDate),
                        style: const TextStyle(
                            color: BaseColor.someTextPopupArea,
                            fontSize: BaseFont.font34px,
                            fontFamily: BaseFont.familyNumber),
                      ),
                    ),
                  ],
                ),
              ),
              _buildCalendarview(
                  context,
                  _focusedDate!,
                  totalDays,
                  emptyDays,
                  _selectedDate,
                  updateDate,
                  goToPreviousMonth,
                  goToNextMonth,
                  daysInMonth),
            ],
          ),

          ///決定ボタンを含む下のコンテナー
          Positioned(
            bottom: 24.h,
            right: 25.w,
            child: DecisionButton(
              oncallback: () {
                updateDate(_selectedDate);

                ///日付を戻り値として渡す
                Navigator.pop(context, _selectedDate);
              },
              text: '決定する',
              maxWidth: 200.0.w,
              maxHeight: 56.0.h,
            ),
          ),
        ],
      ),
    );
  }

  ///カレンダー上部に操作エリア構築
  Widget buildCalendarHeader(DateTime focusedDate, VoidCallback onPreviousMonth,
      VoidCallback onNextMonth) {
    String callFunc = 'buildCalendarHeader';
    return Container(
      padding: EdgeInsets.only(left: 120.w, right: 120.w, top: 30.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///左側'前の月'と操作ボタン
          SoundElevatedButton(
            onPressed: onPreviousMonth,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0),
            callFunc: callFunc,
            child: Row(children: [
              SvgPicture.asset(
                'assets/images/icon_back.svg',
                width: 48.w,
                height: 48.h,
              ),
              SizedBox(width: 8.w),
              const Text(
                '前の月',
                style: TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.baseColor,
                    fontFamily: BaseFont.familyDefault),
              ),
            ]),
          ),

          ///現在の年と月を表示
          Text(
            DateFormat('yyyy/MM').format(focusedDate),
            style: const TextStyle(
                fontFamily: BaseFont.familyDefault,
                color: BaseColor.baseColor,
                fontSize: BaseFont.font22px),
          ),

          ///右側'次の月'と操作ボタン
          SoundElevatedButton(
            onPressed: onNextMonth,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0),
            callFunc: callFunc,
            child: Row(children: [
              const Text(
                '次の月',
                style: TextStyle(
                    fontSize: BaseFont.font18px,
                    color: BaseColor.baseColor,
                    fontFamily: BaseFont.familyDefault),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(
                'assets/images/icon_next.svg',
                width: 48.w,
                height: 48.h,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  ///カレンダーの曜日のタイトル構築
  Widget _buildWeekdayTitle() {
    List<String> weekdays = ['日', '月', '火', '水', '木', '金', '土'];
    return Container(
      padding: EdgeInsets.only(left: 181.w, right: 181.w, top: 40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekdays.map((day) {
          return Container(
            width: 50.w,
            child: Text(
              day,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: BaseFont.font14px,
                  color: day == '土'
                      ? BaseColor.accentsColor
                      : (day == '日'
                          ? BaseColor.attentionColor
                          : BaseColor.baseColor),
                  fontFamily: BaseFont.familyNumber),
            ),
          );
        }).toList(),
      ),
    );
  }

  ///右側のカレンダービュー構築
  ///カレンダーのヘッダー、曜日のタイトル、GridViewで日付表示、および決定ボタン
  Widget _buildCalendarview(
      BuildContext context,
      DateTime focusedDate,
      int totalDays,
      int emptyDays,
      DateTime selectedDate,
      Function(DateTime) updateDate,
      VoidCallback goToPreviousMonth,
      VoidCallback goToNextMonth,
      int daysInMonth) {
    String callFunc = '_buildCalendarview';
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 760.w,
              height: 512.h,
              color: BaseColor.someTextPopupArea,
              child: Column(
                children: [
                  buildCalendarHeader(
                      focusedDate, goToPreviousMonth, goToNextMonth),
                  _buildWeekdayTitle(),
                  Expanded(
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
//スクロール禁止
                        padding: EdgeInsets.only(
                            left: 176.w, right: 176.w, top: 30.h),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                        ),
                        itemCount: totalDays,
                        itemBuilder: (context, index) {
                          ///各セルが表す日付の計算
                          final dayOffset = index - emptyDays + 1;
                          final day = DateTime(
                              focusedDate.year, focusedDate.month, dayOffset);

                          ///選択されたれた日付かどうかの確認
                          bool isSelected = selectedDate.year == day.year &&
                              selectedDate.month == day.month &&
                              selectedDate.day == day.day;

                          ///選択状態と曜日に基づいて色を設定
                          Color textColor;
                          if (isSelected) {
                            textColor = BaseColor.someTextPopupArea;
                          } else if (day.weekday == DateTime.saturday) {
                            textColor = BaseColor.accentsColor;
                          } else if (day.weekday == DateTime.sunday) {
                            textColor = BaseColor.attentionColor;
                          } else {
                            textColor = BaseColor.baseColor;
                          }

                          return SoundElevatedButton(
                            onPressed: () {
                              updateDate(day);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: textColor,
                              backgroundColor: isSelected
                                  ? BaseColor.accentsColor
                                  : BaseColor.someTextPopupArea,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            callFunc: callFunc,
                            child: Center(
                              child: Text(
                                dayOffset > 0 && dayOffset <= daysInMonth
                                    ? dayOffset.toString()
                                    : '',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: BaseFont.font24px,
                                    fontFamily: BaseFont.familyNumber),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
