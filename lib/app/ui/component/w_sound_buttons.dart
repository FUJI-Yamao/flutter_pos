/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';

import '../../common/environment.dart';
import '../../if/if_sound.dart';
import '../../inc/sys/tpr_log.dart';
import '../../inc/sys/tpr_type.dart';
import '../enum/e_screen_kind.dart';

/// 音関連の関数群.
class SoundUtil {
  /// プッシュ/タップした時の音.
  /// SoundInkWell系が使えるなら、こちらではなくSoundInkWell系Widgetを使う事.
  static void playPushSound() {
    if (EnvironmentData().screenKind == ScreenKind.register) {
      // 本体側は右で鳴らす
      IfSound.ifBz();
    } else {
      // タワー側 or 客側表示パネルを左で鳴らす
      IfSound.ifBzCshr();
    }
  }

  /// ボタン押下時のログ出力関数.
  /// playPushSoundにログを追加.
  /// SoundInkWell系を使用せずに直接playPushSoundを呼び出す場合はこちらを使用する.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  static void playPushSoundLog(String callFunc){
    TprMID tid;
    SoundUtil.playPushSound();

    // TODO:00013 三浦 tidの指定は暫定
    // 店員操作画面と客操作画面でtidを分岐
    if (EnvironmentData().screenKind == ScreenKind.register) {
      // 本体側
      tid = Tpraid.TPRAID_STAFF_BUTTON;
    } else if (EnvironmentData().screenKind == ScreenKind.register2) {
      // タワー側
      tid = Tpraid.TPRAID_STAFF_BUTTON;
    } else {
      // 客側
      tid = Tpraid.TPRAID_CUSTOMER_BUTTON;
    }

    TprLog().logAdd(tid, LogLevelDefine.normal, "$callFunc: Tap button");
  }
}

/// タップ時に音が鳴るInkWell
class SoundInkWell extends StatelessWidget {
  const SoundInkWell({
    super.key,
    this.child,
    required this.onTap,
    this.borderRadius,
    required this.callFunc
  });

  final Widget? child;
  final GestureTapCallback? onTap;
  final BorderRadius? borderRadius;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: (onTap == null) ? null : () {
        SoundUtil.playPushSoundLog(callFunc);
        onTap!.call();
      },
      child: child,
    );
  }
}

/// タップ時に音が鳴るElevatedButton
class SoundElevatedButton extends StatelessWidget {
  const SoundElevatedButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.child,
    required this.callFunc
  });

  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return
      ElevatedButton(
        style: style,
        onPressed: () {
          SoundUtil.playPushSoundLog(callFunc);
          onPressed.call();
        },
        child:  child,
      )
    ;
  }
}

/// タップ時に音が鳴るElevatedButton(Icon+Text)
class SoundElevatedIconTextButton extends StatelessWidget {
  const SoundElevatedIconTextButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.icon,
    required this.label,
    required this.callFunc
  });

  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Icon icon;
  final Text label;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          SoundUtil.playPushSoundLog(callFunc);
          onPressed.call();
        },
        style: style,
        icon: icon, //アイコン
        label: label //テキスト
    );
  }
}

/// タップ時に音が鳴るOutlinedButton
class SoundOutlinedButton extends StatelessWidget {
  const SoundOutlinedButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.child, required this.callFunc,
  });

  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: style,
      onPressed: () {
        SoundUtil.playPushSoundLog(callFunc);
        onPressed.call();
      },
      child: child,
    );
  }
}

/// タップ時に音が鳴るTextButton
class SoundTextButton extends StatelessWidget {
  const SoundTextButton({
    super.key,
    required this.onPressed,
    this.style,
    required this.child, required this.callFunc,
  });

  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: () {
        SoundUtil.playPushSoundLog(callFunc);
        onPressed.call();
      },
      child: child,
    );
  }
}

/// タップ時に音が鳴るIconButton
class SoundIconButton extends StatelessWidget {
  const SoundIconButton({
    super.key,
    required this.onPressed,
    this.iconSize,
    required this.icon, required this.callFunc,
  });

  final VoidCallback? onPressed;
  final double? iconSize;
  final Icon icon;
  /// ボタン押下時のログ出力用.
  /// どのボタンを押したかわかるように.
  /// callFuncには関数名 or クラス名 + できればボタンに出力されているテキストを指定.
  final String callFunc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      onPressed: (onPressed == null) ? null : () {
        SoundUtil.playPushSoundLog(callFunc);
        onPressed!.call();
      },
      icon: icon,
    );
  }
}