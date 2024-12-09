/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../common/date_util.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../../menu/register/enum/e_register_page.dart';
import '../maintenance/specfile/model/m_specfile.dart';
import 'controller/c_terminal_info.dart';
import 'p_passwordinput.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../common/cmn_sysfunc.dart';

/// 端末情報画面
class TerminalInfoPage extends StatelessWidget {
  final TerminalInfo terminalInfo = TerminalInfo();

  TerminalInfoPage({super.key});


  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ja');

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf pCom = xRet.object;
    String saleDateString = pCom.iniCounter.tran.sale_date;

    DateTime saleDate = DateTime.parse(saleDateString);

    // 営業日の日付と時刻
    String saleDateStr = DateFormat('yyyy/MM/dd').format(saleDate);
    String weekday = DateFormat('EEE', 'ja').format(saleDate);

    // 現在の日付と時刻
    String todayDate = DateUtil.getNowStrJpn('yyyy/MM/dd(E) HH:mm');

    /// テキストWidget
    Widget buildCustomText(String text) {
      bool isVersionInfo = text == 'バージョン情報';

      return Text(
        text,
        style: TextStyle(
          fontSize: BaseFont.font28px,
          color: BaseColor.baseColor,
          fontWeight: isVersionInfo ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }

    /// ボタンWidget
    Widget buildCustomElevatedButton(String buttonText, VoidCallback onPressedCallback) {
      Color buttonColor = buttonText == 'メンテナンス操作' || buttonText == 'ユーザーセットアップ'
          ? BaseColor.accentsColor
          : BaseColor.maintainInputAreaBorder;
      String callFunc = 'buildCustomElevatedButton';

      return SizedBox(
        height: 80.h,
        width: 350.w,
        child: SoundElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                color: BaseColor.edgeBtnTenkeyColor,
                width: 1,
              ),
            ),
            backgroundColor: buttonColor,
            foregroundColor: BaseColor.someTextPopupArea,
            elevation: 2,
          ),
          onPressed: () {
            onPressedCallback(); // 既存のコールバックを呼び出し
          },
          callFunc: '$callFunc $buttonText',
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28.0,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 80.w,
        leading: SoundElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: BaseColor.someTextPopupArea,
            backgroundColor: BaseColor.maintainButtonAreaBG,
            padding: EdgeInsets.zero,
            minimumSize: Size(80.w, 50.h),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),
          callFunc: '${runtimeType.toString()} ${RegisterPage.terminalInfo.pageTitleName}',
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 50,
          ),
        ),
        backgroundColor: BaseColor.baseColor.withOpacity(0.7),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              RegisterPage.terminalInfo.pageTitleName,
              style: const TextStyle(
                color: BaseColor.someTextPopupArea,
                fontSize: BaseFont.font24px,
              ),
            ),
            SizedBox(width: 100.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '日　付： $todayDate',
                  style: const TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  '営業日： $saleDateStr($weekday)',
                  style: const TextStyle(
                    color: BaseColor.someTextPopupArea,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 70.0),
        child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60.0),
                  decoration: const BoxDecoration(
                    color: BaseColor.someTextPopupArea,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildCustomText('バージョン情報'),
                        SizedBox(height: 40.h),
                        FutureBuilder(
                          future: terminalInfo.getAllInfo(),
                          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError || snapshot.data == null) {
                                return buildCustomText('データなし');
                              }
                              Map<String, dynamic> allInfo = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildCustomText('企業番号：${allInfo['machineNumber']}'),
                                  SizedBox(height: 30.h),
                                  buildCustomText('店舗番号：${allInfo['shopNumber']}'),
                                  SizedBox(height: 30.h),
                                  buildCustomText('マシン番号：${allInfo['macno']}'),
                                  SizedBox(height: 30.h),
                                  buildCustomText('マシンタイプ：${allInfo['mactype']}'),
                                  SizedBox(height: 30.h),
                                  buildCustomText('バージョン：${allInfo['version']}'),
                                  // 他の情報も同様に表示
                                ],
                              );
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              return buildCustomText('データ読込中...');
                            }
                          },
                        ),
                      ]
                  ),
                ),
              ),
              SizedBox(width: 60.w),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCustomElevatedButton('法的情報', () {
                    }),
                    SizedBox(height: 15.h),
                    buildCustomElevatedButton('ファイル確認', () {
                    }),
                    SizedBox(height: 15.h),
                    buildCustomElevatedButton('件数確認', () {
                    }),
                    SizedBox(height: 15.h),
                    buildCustomElevatedButton('エラー情報確認', () {
                    }),
                    SizedBox(height: 15.h),
                    buildCustomElevatedButton('メンテナンス操作', () {
                      Get.to(() => PassWordInputDialog(
                        title: 'パスワード入力',
                        settingName: 'パスワードを入力してください',
                        initValue: '',
                        setting: const NumInputSetting(0,999999999999),
                      ));
                    },),
                    SizedBox(height: 20.h),
                    buildCustomElevatedButton('ユーザーセットアップ', () {
                    },),
                  ]
              ),
            ]
        ),
      ),
      backgroundColor: BaseColor.loginBackColor,
    );
  }
}




