/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_pos/app/ui/colorfont/c_basefont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../if/if_drv_control.dart';
import '../../../../if/if_scan_isolate.dart';
import '../../../../inc/apl/fnc_code.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../inc/sys/tpr_aid.dart';
import '../../../../regs/checker/rc_key.dart';
import '../../../colorfont/c_basecolor.dart';
import '../../../component/w_sound_buttons.dart';
import '../../../controller/c_drv_controller.dart';

/// キータイプenum
enum KeyType {
  zero('0',FuncKey.KY_0),
  doubleZero('00',FuncKey.KY_00),
  one('1',FuncKey.KY_1),
  two('2',FuncKey.KY_2),
  three('3',FuncKey.KY_3),
  four('4',FuncKey.KY_4),
  five('5',FuncKey.KY_5),
  six('6' ,FuncKey.KY_6),
  seven('7',FuncKey.KY_7),
  eight('8',FuncKey.KY_8),
  nine('9',FuncKey.KY_9),
  delete('delete',FuncKey.KY_NONE),
  check('決定', FuncKey.KY_NONE),
  clear('C',FuncKey.KY_CLR);

  /// キータイプを表す文字列
  final String name;
  final FuncKey key;
  ///KeyType enumのコンストラクタ
  const KeyType(this.name,this.key);

  /// キータイプに含まれるか否か
  static bool contains(FuncKey key) {
    for (var keyType in KeyType.values) {
      if (keyType.key == key) {
        return true;
      }
    }
    return false;
  }
}

///キーがタップされた時のコールバック関数
typedef OnKeyTap = void Function(KeyType key);

/// 登録画面のテンキー
class RegisterTenkey extends StatefulWidget {
  ///キーがタップされた時のコールバック関数
  final OnKeyTap onKeyTap;
  final String? addDrvCtrlTag;
   ///コンストラクタ
   /// [addDrvCtrlTag] 特定の文字列をテンキーのRegisterDeviceEventのタグに付加する場合に使用する.
   /// 指定しなかった場合は、RegisterDeviceEvent内で日時がタグに付加される.
   /// 例えば従業員オープンクローズなどcontrollerの自動破棄が行われないような画面で、
   /// 手動でコントローラーを破棄したい場合に[addDrvCtrlTag]を指定する.
  const RegisterTenkey({super.key, required this.onKeyTap,this.addDrvCtrlTag});

   @override
  RegisterTenkeyState createState() => RegisterTenkeyState();
}

 /// 登録画面のテンキーのstate
class RegisterTenkeyState extends State<RegisterTenkey>  with RegisterDeviceEvent {

  ///共通のテキストスタイル
  static const _keyTextStyle = TextStyle(
      fontSize: BaseFont.font24px, fontFamily: BaseFont.familyNumber);


  @override
  IfDrvPage getTag() {
    return IfDrvPage.tenkey;
  }

  @override
  KeyDispatch? getKeyCtrl() {
    return getTenKeyCtrl(widget.onKeyTap);
  }

  static KeyDispatch getTenKeyCtrl(OnKeyTap onKeyTap) {
    late  KeyDispatch keyCon ;
    if(IfDrvControl().mkeyIsolateCtrl.dispatch == null){
          keyCon = KeyDispatch(Tpraid.TPRAID_CHK);
    }else{
      // キー登録の処理が既にあるなら引き継ぐ.
      keyCon = KeyDispatch.copy(IfDrvControl().mkeyIsolateCtrl.dispatch!);
    }

    keyCon.funcNum = (key){
      onKeyTap(KeyType.values.firstWhere((element) => element.key == key));
    };
    keyCon.funcClr = (){
      onKeyTap(KeyType.clear);
    };
    return keyCon;
  }
  @override
   Function(RxInputBuf)? getScanCtrl(){
    // スキャンの処理が既にあるなら引き継ぐ.
    if(IfDrvControl().scanMap.isEmpty){
      // 登録されていない
          return null;
    }
    return IfScanIsolate().funcScan;
  }

  @override
  void initState() {
    super.initState();
    registrationEvent(addTag: widget.addDrvCtrlTag);     
  }


  ///キーのたタイプによって高さと幅構築
  Widget _buildKey(KeyType key) {
    return SizedBox(
      width: (key == KeyType.check) ? 162.w : 80.w,
      height: 80.h,
      child: Stack(children: [
        Container(
          decoration: _keyDecoration(key),
          margin: EdgeInsets.all(2.w),
          child: Center(child: _keyWidget(key)),
        ),
        Positioned.fill(
          child: Material(
            color: BaseColor.transparent,
            child: SoundInkWell(
              onTap: () => widget.onKeyTap(key),
              child: null,
              callFunc: runtimeType.toString(),
            ),
          ),
        )
      ]),
    );
  }


  ///行の構築
  Widget buildKeyRow(List<KeyType> keys) {
    return Row(
      children: keys.map((key) => _buildKey(key)).toList(),
    );
  }

  ///キーの色設定
  BoxDecoration _keyDecoration(KeyType key) {
    ///キーの色設定
    Color? color;

    /// 色の変化
    LinearGradient? gradient;

    if (key == KeyType.delete) {
      color = BaseColor.tenkeyBackColor1;
    } else if (key == KeyType.clear) {
      color = BaseColor.tenkeyBackColor2;
    } else if (key == KeyType.check) {
      gradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          BaseColor.confirmBtnFrom,
          BaseColor.confirmBtnTo,
        ],
      );
    } else {
      color = BaseColor.mainColor;
    }

    return BoxDecoration(
      gradient: gradient,
      color: color,
    );
  }

  ///戻るタイプによってキーのアイコンと数字設定
  Widget _keyWidget(KeyType key) {
    switch (key) {
      case KeyType.delete:
        return const Icon(Icons.backspace, size: 30);
      case KeyType.check:
        return const Text('決定',
            style: TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font22px,
                fontFamily: BaseFont.familySub));
      case KeyType.clear:
        return Text(
          key.name,
          style: const TextStyle(fontSize: BaseFont.font26px),
        );
      default:
        return Text(
          key.name,
          style: _keyTextStyle,
        );
    }
  }

  ///テンキーのレイアウト
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268.w,
      height: 432.h,
      padding: EdgeInsets.all(12.w),
      decoration: const BoxDecoration(
        color: BaseColor.baseColor,
      ),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildKeyRow([KeyType.seven, KeyType.eight, KeyType.nine]),
          buildKeyRow([KeyType.four, KeyType.five, KeyType.six]),
          buildKeyRow([KeyType.one, KeyType.two, KeyType.three]),
          buildKeyRow([KeyType.zero, KeyType.doubleZero, KeyType.delete]),
          buildKeyRow([KeyType.clear, KeyType.check]),
        ],
      ),
    );
  }
}
