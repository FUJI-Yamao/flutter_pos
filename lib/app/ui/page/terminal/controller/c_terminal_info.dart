/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/cls_conf/mac_infoJsonFile.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';

class TerminalInfo {
  Future<Map<String, dynamic>> getAllInfo() async {
    try {
      /// mac_info.json
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if(xRet.isInvalid()){
        return {};
      }
      RxCommonBuf pCom = xRet.object;
      Mac_infoJsonFile macInfoJsonFile = pCom.iniMacInfo;

      String mactypeText = convertMactype(macInfoJsonFile.mm_system.mm_type);

      // バージョン情報
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      return {
        'machineNumber': macInfoJsonFile.system.crpno,
        'shopNumber': macInfoJsonFile.system.shpno,
        'macno': macInfoJsonFile.system.macno,
        'mactype': mactypeText,
        'version': '${packageInfo.version}.${packageInfo.buildNumber}',
      };
    } catch (e) {
      debugPrint("Error loading information: $e");
      return {};
    }
  }

  /// マシンタイプを文字列に変換する
  String convertMactype(int mactype) {
    switch (mactype) {
      case 0:
        return "Ｓ";
      case 1:
        return "ＢＳ";
      case 2:
        return "Ｍ";
      case 3:
        return "ｽﾀﾝﾄﾞｱﾛﾝ";
      default:
        return "未定義"; // 必要に応じてデフォルトの値を設定
    }
  }
}