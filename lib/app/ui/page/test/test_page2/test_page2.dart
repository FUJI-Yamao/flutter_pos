/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/w_sound_buttons.dart';
import '/app/ui/component/w_label_trns.dart';
import '/app/ui/controller/c_common_controller.dart';
import '/app/ui/language/l_languagedbcall.dart';
import '/app/ui/model/m_widgetsetting.dart';
import 'test_page_contorller/test_page2_controller.dart';


///ページ2画面
class Page2 extends StatelessWidget {
  ///コンストラクタ
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    ///コントローラー
    CommonController c = Get.find();
    TestPage2Controller tp2 = Get.put(TestPage2Controller());

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child:
              // Obx(
              //     () =>
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Obxをつかわないと再描画されないので1度ページを閉じてあらためて表示させる必要がある。\nしたがってGetxの多言語より再描画を意識して作る必要がある。',
                style: TextStyle(fontSize: 20.sp),
              ),
              Text(
                'f_common_footer_Call_attendant'.trns,
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Page2',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '↓　Obxで囲って再描画（Obx(()=>Text(’多言語key’.trns)))',
                style: TextStyle(fontSize: 20.sp),
              ),
              Obx(
                () => Text(
                  'f_common_footer_Call_attendant'.trns,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '↓　Obxで再描画しているコンポーネントで描画\n（LabelBtnTrnsWidget(setting: BtnSetting(text: ’common_footer_Call_attendant’）\n　Obx(()=>～Text(’＄{setting.value.text}’.trns)).obs～',
                style: TextStyle(fontSize: 20.sp),
              ),
              LabelBtnTrnsWidget(
                setting: BtnSetting(text: 'f_common_footer_Call_attendant').obs,
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 50.h,
                width: 200.w,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    LabelBtnTrnsWidget(
                      setting: tp2.btnSwitchSetting,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    LabelBtnTrnsWidget(
                      setting: tp2.btnChangeSetting,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 50.h,
                width: 380.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow),
                ),
                child: Row(
                  children: [
                    SoundElevatedButton(
                      onPressed: () =>
                          c.intCountry.value = LocaleNo.Japanese.no,
                      child: Text(
                        '日本語',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                      callFunc: runtimeType.toString(),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SoundElevatedButton(
                      onPressed: () => c.intCountry.value = LocaleNo.English.no,
                      callFunc: runtimeType.toString(),
                      child: Text(
                        '英語',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SoundElevatedButton(
                      onPressed: () => c.intCountry.value = LocaleNo.Chinese.no,
                      callFunc: runtimeType.toString(),
                      child: Text(
                        '中国語',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SoundElevatedButton(
                      onPressed: () => c.intCountry.value = LocaleNo.Korean.no,
                      callFunc: runtimeType.toString(),
                      child: Text(
                        '韓国語',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                '多言語Key：notificationarea　国区分：2 ラベル名：通知エリアのみを設定の場合は\nデフォルト国が日本の場合は日本語しか表示されない',
                style: TextStyle(fontSize: 20.sp),
              ),
              Container(
                alignment: Alignment.center,
                child: Obx(() => Text('notificationarea'.trns)),
              ),
              SizedBox(
                height: 10.h,
              ),
              SoundElevatedButton(
                onPressed: () => Get.back(),
                callFunc: runtimeType.toString(),
                child: Text(
                  'l_cmn_back'.trns,
                  style: TextStyle(fontSize: 20.sp),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
