/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
import 'dart:io';


import 'package:sprintf/sprintf.dart';

import '../../common/environment.dart';
// ignore: avoid_relative_lib_imports
import '../../inc/lib/apllib.dart';
import '../../inc/lib/spqc.dart';
import '../../inc/sys/tpr_type.dart';
import 'apllib_other.dart';
import 'apllib_std_add.dart';

///  関連tprxソース: AplLib_SpeedSelf.c

enum SpSelfDirIndex {
  SVR_B_DIR(0), // QRSrv/
  SVR_M_DIR(1), //       Make/
  SVR_L_DIR(2), //       Load/
  SVR_E_DIR(3), //       Edit/
  SVR_T_DIR(4), //       Tran/
  CLT_B_DIR(5), // QRClt/
  CLT_M_DIR(6), //       Make/
  CLT_S_DIR(7), //       Send/
  CLT_T_DIR(8), //       Tran/
  CLT_A_DIR(9), //       Action/
  SPSELF_DIR_MAX_NUM(10);

  const SpSelfDirIndex(this.idx);
  final int idx;
}

///  関連tprxソース: AplLib_SpeedSelf.c - SpSelfDirUnit
class	SpSelfDirUnit
{
	final SpSelfDirIndex	ssdi;
	final String			    dir;

  SpSelfDirUnit(this.ssdi, this.dir);
}

///  関連tprxソース: AplLib_SpeedSelf.c
class AplLibSpeedSelf {


  /// スピードセルフ用のディレクトリ操作関数
  ///  関連tprxソース: AplLib_SpeedSelf.c - AplLib_SpeedSelfDirProc
  static Future<void> aplLibSpeedSelfDirProc(TprMID tid, SpSelfDirProcParam dirParam) async {
   
    // List<String> dirPath = List.filled(SpSelfDirIndex.SPSELF_DIR_MAX_NUM.idx, '', growable: false);
    // 0 :TPRX_HOME/tmp/QRSrv/
    // 1 :TPRX_HOME/tmp/QRSrv/Make/
    // 2 :TPRX_HOME/tmp/QRSrv/Load/
    // 3 :TPRX_HOME/tmp/QRSrv/Edit/
    // 4 :TPRX_HOME/tmp/QRSrv/Tran/
    // 5 :TPRX_HOME/tmp/QRClt/
    // 6 :TPRX_HOME/tmp/QRClt/Make/
    // 7 :TPRX_HOME/tmp/QRClt/Send/
    // 8 :TPRX_HOME/tmp/QRClt/Tran/
    // 9 :TPRX_HOME/tmp/QRClt/Action/
    // 10:TPRX_HOME/tmp/QRSrv/Make
    List<SpSelfDirUnit> dirUnit = [
      SpSelfDirUnit(SpSelfDirIndex.SVR_B_DIR, EnvironmentData.TPRX_HOME + SPQCS_BASE_DIR),
      SpSelfDirUnit(SpSelfDirIndex.SVR_M_DIR, EnvironmentData.TPRX_HOME + SPQCS_MAKE_DIR),
      SpSelfDirUnit(SpSelfDirIndex.SVR_L_DIR, EnvironmentData.TPRX_HOME + SPQCS_LOAD_DIR),
      SpSelfDirUnit(SpSelfDirIndex.SVR_E_DIR, EnvironmentData.TPRX_HOME + SPQCS_EDIT_DIR),
      SpSelfDirUnit(SpSelfDirIndex.SVR_T_DIR, EnvironmentData.TPRX_HOME + SPQCS_TRAN_DIR),
      SpSelfDirUnit(SpSelfDirIndex.CLT_B_DIR, EnvironmentData.TPRX_HOME + SPQCC_BASE_DIR),
      SpSelfDirUnit(SpSelfDirIndex.CLT_M_DIR, EnvironmentData.TPRX_HOME + SPQC_CLT_MAKE_DIR),
      SpSelfDirUnit(SpSelfDirIndex.CLT_S_DIR, EnvironmentData.TPRX_HOME + SPQC_CLT_SEND_DIR),
      SpSelfDirUnit(SpSelfDirIndex.CLT_T_DIR, EnvironmentData.TPRX_HOME + SPQC_CLT_TRAN_DIR),
      SpSelfDirUnit(SpSelfDirIndex.CLT_A_DIR, EnvironmentData.TPRX_HOME + SPQC_CLT_ACTION_DIR),
    ];
    switch (dirParam.Type) {
      case SPSELF_DIR_PROC_TYPE.SPSELF_PROC_MAKEDIR:
        // dirUnitのDIRパスに対してディレクトリを作成
        for (var unit in dirUnit) {
          await AplLibStdAdd.aplLibMkdir(tid, unit.dir, '777');
        }
        break;
      case SPSELF_DIR_PROC_TYPE.SPSELF_PROC_INITDIR:
        for (var unit in dirUnit) {
          // dirUnitのDIRパスに対してディレクトリを削除
          Directory unitDir = TprxPlatform.getDirectory(unit.dir);
          if (unitDir.existsSync()) {
            unitDir.deleteSync(recursive: true);
          }
        }
      case SPSELF_DIR_PROC_TYPE.SPSELF_PROC_OPENDIR:
        for (var unit in dirUnit) {
          if (unit.ssdi == SpSelfDirIndex.SVR_B_DIR) {
            Directory unitDir = TprxPlatform.getDirectory(unit.dir);
            if (unitDir.existsSync()) {
              unitDir.deleteSync(recursive: true);
            }
          } else {
            int len = SPQC_FLG_SIZ + SPQC_OPE_MODE_FLG_SIZ;
            AplLibOther.dirFileAction(
                tid, unit.dir, "", "", dirParam.SaleDate, len
              , APL_MATCH_PROC_TYPE.PROCESS_UNMATCH, APL_ACTION_TYPE.APL_ACTION_REMOVE, "");
          }
        }
        break;
      default:
        break;
    }
  }
}