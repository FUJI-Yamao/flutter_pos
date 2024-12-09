/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../colorfont/c_basecolor.dart';
import '../controller/c_sound_setting_controller.dart';

/// 音量の増減
enum VolumeButtonAction {
  up,    // 増
  down,  // 減
}

/// 音量の増減を行う＋(ー)ボタン
class VolumeButton extends StatefulWidget {

  const VolumeButton({super.key, required this.soundSettingInfo, required this.volumeButtonAction});
  final SoundSettingInfo soundSettingInfo;
  final VolumeButtonAction volumeButtonAction;

  @override
  State<VolumeButton> createState() => _VolumeButtonState();
}

/// 音量の増減を行う＋(ー)ボタンのState
class _VolumeButtonState extends State<VolumeButton> {

  /// 長押しされているかの判定フラグ
  bool _longPressFlag = false;
  /// 表示するアイコン
  late final IconData _volumeIcon;
  /// ボタン押下（onTap）の処理
  late final Function _volumeFunc;

  @override
  void initState() {
    super.initState();

    final soundSettingController = Get.put(SoundSettingController());
    if (widget.volumeButtonAction == VolumeButtonAction.down) {
      _volumeIcon = Icons.remove;
      _volumeFunc = soundSettingController.volumeDown;
    } else {
      _volumeIcon = Icons.add;
      _volumeFunc = soundSettingController.volumeUp;
    }
  }

  @override
  Widget build(BuildContext context) {
    final soundSettingController = Get.put(SoundSettingController());
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: BaseColor.soundSettingButtonBackgroundColor, // ボタンの色
          ),
          child: Icon(_volumeIcon, size: 36.0, color: Colors.white,),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {},
              child: GestureDetector(
                onTap: () {
                  // 音量上下
                  _volumeFunc(widget.soundSettingInfo);
                  // 変更した音量を確定させる
                  soundSettingController.decideSoundVolume(widget.soundSettingInfo);
                },
                onLongPress: () async {
                  _longPressFlag = true;
                  while (_longPressFlag) {
                    // 音量上下
                    // volumeが最小もしくは最大の時ループを抜ける
                    if (!_volumeFunc(widget.soundSettingInfo)) {
                      break;
                    }
                    await Future.delayed(const Duration(milliseconds: 50));
                  }
                },
                onLongPressEnd: (detail) {
                  _longPressFlag = false;
                  // 変更した音量を確定させる
                  soundSettingController.decideSoundVolume(widget.soundSettingInfo);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

}