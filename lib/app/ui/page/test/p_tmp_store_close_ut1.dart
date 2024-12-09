/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/app/common/cls_conf/counterJsonFile.dart';
import 'package:flutter_pos/app/common/date_util.dart';
import 'package:flutter_pos/app/ui/component/w_inputbox.dart';
import 'package:flutter_pos/app/ui/language/l_languagedbcall.dart';
import 'package:flutter_pos/app/ui/page/test/test_setup/p_setup_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/sys/ex/L_tprdlg.dart';
import '../../../lib/apllib/TmnEj_Make.dart';
import '../../../lib/apllib/rm_db_read.dart';
import '../../../lib/apllib/rm_ini_read.dart';
import '../../../sys/stropncls/rmstcls.dart';
import '../../colorfont/c_basecolor.dart';
import '../../colorfont/c_basefont.dart';
import '../../component/w_sound_buttons.dart';
import '../common/component/w_msgdialog.dart';
import '../maintenance/specfile/model/m_specfile.dart';
import 'test_page2/test_page_contorller/test_page_controller.dart';

/// 動作テストをするための設定やテストを行うページ
// TODO:10130 テストコード(リリース前削除)
class TmpStoreCloseUT1 extends StatefulWidget {
  const TmpStoreCloseUT1({super.key});


  @override
  State<TmpStoreCloseUT1> createState() => _TmpStoreCloseUT1State();
}

class _TmpStoreCloseUT1State extends State<TmpStoreCloseUT1> {
  ///コンストラクタ

  TestPageController ctrl = Get.put(TestPageController());
  bool isRunning = false;

  @override
  void initState() {

    Rmstcls.rmStoreCloseDrawMain();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: BaseColor.storeOpenCloseBackColor,
      appBar: AppBar(
          title: const Text("UT1日計処理"), // 現在時刻
          leading: SoundIconButton(
            icon: const Icon(
                Icons.arrow_back,
                color: BaseColor.storeCloseFontColor,
                size: 30.0),
            // 戻るボタン
            onPressed: () {
              Get.back();
            },
            callFunc: runtimeType.toString(),
          ),
          backgroundColor: BaseColor.storeOpenCloseBackColor,
          bottomOpacity: 0.0, elevation: 0.0),
      body: Container(
        alignment: Alignment.center,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Obx(() => Text(
                    'QUICPay日計処理状況:${ctrl.nowStatusQP.value}',
                    style: const TextStyle(
                      fontSize: 24,))),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => Text(
                    'iD日計処理状況:${ctrl.nowStatusiD.value}',
                    style: const TextStyle(
                      fontSize: 24,))),

                SizedBox(
                  height: 150.h,
                ),

                SoundElevatedButton(
                  onPressed: () => closeUt1Proc(),
                  callFunc: runtimeType.toString(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BaseColor.storeCloseStartButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "QUICPay/iD 日計実行",
                    style: TextStyle(fontSize: BaseFont.font20px),
                  ),
                ),

              ],
            )),
      ),
    );
  }
  Future<void> closeUt1Proc() async {
      if(!isRunning){
      isRunning = true;
      
    Rmstcls.rmStoreCloseDrawMain();
      await Rmstcls.execBeforeProc2();
      // TODO:10131 日計UI 突貫対応 日計処理自体が終わることを確認できたらwhile文を抜ける
      while(Rmstcls.opt7End == false || Rmstcls.opt9End == false) {
        await Future.delayed(const Duration(milliseconds: 50));
        ctrl.nowStatusQP.value = getStatusStr(Rmstcls.opt7Status);
        ctrl.nowStatusiD.value = getStatusStr(Rmstcls.opt9Status);
      }
      // 最後にもう一回更新.
       ctrl.nowStatusQP.value = getStatusStr(Rmstcls.opt7Status);
       ctrl.nowStatusiD.value = getStatusStr(Rmstcls.opt9Status);
      debugPrint("EndDailyClose iD/QUICPay");
      isRunning = false;
    }else{
        MsgDialog.show(MsgDialog.singleButtonMsg(
          type: MsgDialogType.error,
          message: "実行中です",
        ));
    }
  }

  String getStatusStr(CloseEndStatus status){
    switch(status){
      case CloseEndStatus.GOING:
        return "実行中";
      case CloseEndStatus.NORMAL_END:
        return "完了";
      case CloseEndStatus.ABNORMAL:
        return "異常";
      case CloseEndStatus.CANCEL:
        return "中止";
      default:
        return "なし";
    }

  }
}
