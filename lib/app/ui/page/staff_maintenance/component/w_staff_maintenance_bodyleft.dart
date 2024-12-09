/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import '/app/ui/page/staff_maintenance/component/w_staff_navigationbuttons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../component/w_sound_buttons.dart';
import '../controller/c_staff_timecontroller.dart';

/// メンテナス画面ファンクションボタンウイジェット
class FunctionButtonsGrid extends StatefulWidget {
  const FunctionButtonsGrid({super.key});

  @override
  FunctionButtonsGridState createState() => FunctionButtonsGridState();
}
class FunctionButtonsGridState extends State<FunctionButtonsGrid> {
  ///システム日付けコントローラー
  final TimeController timeController = Get.put(TimeController());

  ///ボタンラベルリスト
  final  List<String> buttonLabels = [
    '再発行',
    '領収書',
    '記載確認',
    '釣機再精査',
    '釣準備',
    '釣機参照',
    '釣機入金',
    '釣機払出',
    '釣機両替',
    '異常チェック',
    '釣機回収',
    '売上回収',

    ///他のボタンラベルを必要に応じて追加
    ...List.generate(40, (index) => 'ボタン${index + 13}'),
  ];

  ///1ページあたりの表示するボタンの数
  final int itemsPerPage = 20;
  ///現行ページインデックス
  int currenPageIndex = 0;
  ///総ページ数を精算
  int get totalPages => (buttonLabels.length / itemsPerPage).ceil();
  ///ページネーションが必要かどうかを判断
  bool get isPaginationNeeded => buttonLabels.length > itemsPerPage;
  /// bool get isPaginationNeeded => true;

  ///TODO:後日、端末のAPIからpreset_noに基づいてbuttonLabelsを取得し、表示する。
  ///TODO:会員読込済みかつ商品登録済みの場合はpreset_cd = 9105と9106を表示する。
  ///TODO:会員未読込かつ商品未登録の場合はpreset_cd = 9105と9106を表示する。
  @override
  Widget build(BuildContext context) {
    //現行のページインデックスに基づいて表示するボタンリストを取得
    final startIndex = currenPageIndex * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage) > buttonLabels.length
        ?buttonLabels.length
        :(startIndex + itemsPerPage);
    final visibleButtons = buttonLabels.sublist(startIndex,endIndex);
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 500.h,
              child:  GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding:  EdgeInsets.all(24.h),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 80,
                ),
                itemCount: visibleButtons.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 152.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BaseColor.someTextPopupArea,
                        foregroundColor: BaseColor.maintainTenkeyBG,
                      ),
                      onPressed: () {
                        ///TODO:API完了後、ボタンごとに異なる操作を実装する
                      },
                      child: Text(
                        visibleButtons[index],
                        style: const TextStyle(
                          fontFamily: BaseFont.familySub,
                          fontSize: BaseFont.font18px,
                          color: BaseColor.maintainTenkeyBG,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
            if(isPaginationNeeded) ...[
              Container(
                margin: EdgeInsets.only(top: 10.h,left: 24.h,right: 24.h),
                height: 10.h,
                width: double.infinity,
                child: CustomPaint(
                  painter: _ScrollbarPainter(
                    currenPageIndex:currenPageIndex,
                    totalPages:totalPages,
                  ),
                ),
              ),
              NavigtionButtons(
                canGoLeft: currenPageIndex > 0,
                canGoRight: currenPageIndex < totalPages -1,
                onLeftPressed: (){
                  if (currenPageIndex > 0){
                    setState(() {
                      currenPageIndex--;
                    });
                  }
                },
                onRightPressed: (){
                  if(currenPageIndex < totalPages -1){
                    setState(() {
                      currenPageIndex++;
                    });
                  }
                },
              )
            ]
          ],
        ),
        Positioned(
          bottom: 40.h,
          right: 23.w,
          child: Container(
            width: 152.w,
            height: 80.h,
            color: BaseColor.someTextPopupArea,
            alignment: Alignment.center,
            child: SoundElevatedButton(
              onPressed: () {},
              callFunc: runtimeType.toString(),
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.someTextPopupArea,
                fixedSize:  Size(152.w, 80.h),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              child: const Text(
                '現計',
                style: TextStyle(
                  color: BaseColor.baseColor,
                  fontSize: BaseFont.font18px,
                  fontFamily: BaseFont.familySub,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.h,
          left: 0.w,
          child: Container(
            width: 152.w,
            height: 56.h,
            color: BaseColor.changeCoinReferTitleColor,
            alignment: Alignment.center,
            child: Obx(
                  () => Text(
                textAlign: TextAlign.center,
                timeController.currentTime.value,
                style: const TextStyle(
                    fontFamily: BaseFont.familyDefault,
                    fontSize: BaseFont.font18px,
                    color: BaseColor.someTextPopupArea),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


///スクロール
class _ScrollbarPainter extends CustomPainter {
  ///現行ページインデックス
  final int currenPageIndex;
  ///総ページ
  final int totalPages;
  _ScrollbarPainter({required this.currenPageIndex,required this.totalPages});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    ///スクロールバー背景色
    paint.color = BaseColor.edgeBtnTenkeyColor;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width.w, size.height),
      paint,
    );
    
    double thumbWidth = size.width / totalPages;
    
    double thumbLeft = thumbWidth * currenPageIndex;

    ///スクロール進捗バー色
    paint.color = BaseColor.staffMaintenanceScrollbarColor;
    canvas.drawRect(
      Rect.fromLTWH(thumbLeft,0,thumbWidth,size.height),
      paint,
    );

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
