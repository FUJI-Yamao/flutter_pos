/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/sys/syst/sys_main.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // var dbAccess1 = DbManipulation();
  // await dbAccess1.openDB(); //awaitを絶対つけなくてはならない、またコンストラクタ作成直後、必ず最初に呼ぶこと
  //
  // // ログ出力テスト.
  // TprLog().logAdd(LogTprMidDefine.chk, LogLevelDefine.error, "1");
  //
  // TprLog().logAdd(LogTprMidDefine.chk, LogLevelDefine.error, "2");
  // TprLog().logAdd(LogTprMidDefine.chk, LogLevelDefine.error, "3");
  try {
    await SysMain.startAppIniRegister();
  } catch (e, s) {
    debugPrint("$e,$s");
    TprLog().logAdd(0, LogLevelDefine.error, e.toString());
  }
  // データ取得テスト.
  // List<RegistPresetButtonSet> dataList =
  //     await RegistInitData.getRegistPresetData(0);
  // debugPrint("presetData:${dataList.length}");
  // for (var data in dataList) {
  //   debugPrint("----------------------------");
  //   debugPrint("presetCd:${data.presetMst.preset_cd}");
  //   debugPrint("keyCd:${data.presetMst.ky_cd}");
  //   debugPrint("pluCd:${data.presetMst.ky_plu_cd}");
  //   debugPrint("imgNum:${data.presetMst.img_num}");
  //   debugPrint("imgName:${data.presetImgName}");
  // }
  //
  // List<CTaxMstColumns> taxDataList = await RegistInitData.getTaxData();
  // debugPrint("taxData:${taxDataList.length}");
  // for (var data in taxDataList) {
  //   debugPrint("----------------------------");
  //   debugPrint("presetCd:${data.tax_cd}");
  // }
  // List<CPresetMstColumns> extCollection =
  //     await RegistInitData.getExtCollectPreset();
  // debugPrint("collectionNum:${extCollection.length}");
  // for (var data in extCollection) {
  //   debugPrint("----------------------------");
  //   debugPrint("presetCd:${data.preset_cd}");
  //   debugPrint("keyCd:${data.ky_cd}");
  //   debugPrint("pluCd:${data.ky_plu_cd}");
  //   debugPrint("imgNum:${data.img_num}");
  // }
}
