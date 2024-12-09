import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basecolor.dart';
import '../../../../colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///フルセルフタイトルバー
class FullSelfHeaderTextWidget extends StatelessWidget {
  ///タイトルテキスト
  final String text;

  const FullSelfHeaderTextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.h,
      color: BaseColor.otherButtonColor,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
            fontFamily: BaseFont.familyDefault,
            fontSize: BaseFont.font24px,
            color: BaseColor.someTextPopupArea),
      ),
    );
  }
}
