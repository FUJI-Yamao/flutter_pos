/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../colorfont/c_basefont.dart';
import '../../../component/w_sound_buttons.dart';

/// 確定ボタン
class DecisionButton extends StatefulWidget {
  const DecisionButton({
    super.key,
    this.oncallback,
    this.text = '確定する',
    this.maxWidth = 200.0,
    this.maxHeight = 80.0,
    this.isdecision = false,
    this.isplus = false,
    this.useGradient = true,
    this.debounceDuration = const Duration(milliseconds: 2000),
  });

  final oncallback;
  final String text;
  final double maxWidth;
  final double maxHeight;

  ///確定ボタンであるかどうか
  final bool isdecision;

  ///プラスボタンであるかどうか（主に支払方法追加ボタン）
  final bool isplus;

  ///グラデーション使用するかどうか（基本使用）
  final bool useGradient;

  ///ボタンが無効になる時間間隔を設定する変数
  final Duration debounceDuration;

  @override
  _DecisionButtonState createState() => _DecisionButtonState();
}

class _DecisionButtonState extends State<DecisionButton> {
  ///ボタンがクリック可能かどうかを示すフラグ
  bool _isClickable = true;

  ///ボタンが押された時の処理
  ///連打防止のため、クリックされた場合一時的に無効化
  void _handleOnPressed() {
    if (_isClickable) {
      setState(() {
        _isClickable = false;
      });

      widget.oncallback();
      //指定した継続時間後にボタンを再び有効化
      Future.delayed(widget.debounceDuration, () {
        if (mounted) {
          setState(() {
            _isClickable = true;
          });
        }
      });
    } else {
      debugPrint('ボタンのが連打されてるため、現在無効化しています');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SoundElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize:
        MaterialStateProperty.all(Size(widget.maxWidth, widget.maxHeight)),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              //ボタンを無効化されていた場合、ink効果表示しない
          if (!_isClickable) {
            return Colors.transparent;
          }
          return null;
        }),
      ),
      onPressed: _handleOnPressed,
      callFunc: '${runtimeType.toString()} text ${widget.text}',
      child: Ink(
        decoration: BoxDecoration(
          gradient: widget.useGradient
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    BaseColor.confirmBtnFrom,
                    BaseColor.confirmBtnTo,
                  ],
                )
              : null,
          color: widget.isdecision ? null : BaseColor.someTextPopupArea,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: BaseColor.edgeBtnColor, width: 1.0.w),
          boxShadow: const [
            BoxShadow(
              color: BaseColor.dropShadowColor,
              spreadRadius: 3,
              blurRadius: 0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth,
            maxHeight: widget.maxHeight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: widget.useGradient
                          ? BaseColor.someTextPopupArea
                          : BaseColor.baseColor,
                      fontSize: BaseFont.font22px,
                      fontFamily: BaseFont.familySub),
                  maxLines: 2,
                ),
              )),

              ///確定ボタンとプラスボタンのアイコン配置
              if (widget.isdecision || widget.isplus)
                Padding(
                  padding: EdgeInsets.only(right: 24.w),
                  child: SvgPicture.asset(
                    widget.isplus
                        ? 'assets/images/icon_add.svg'
                        : 'assets/images/icon_enter.svg',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
