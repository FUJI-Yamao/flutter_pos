/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../../inc/sys/tpr_stat.dart';
import '../../inc/sys/tpr_type.dart';
import 'sys_types.dart';

/// シングルトンクラス.
/// 関連tprxソース:sysdata.c
class SysData {
  /// system status
  /// 関連tprxソース:sysdata.c - SysMenuStatus
  TprTST sysMenuStatus = TprStatDef.TPRTST_START;

  /// execut task count
  /// 関連tprxソース:sysdata.c - SysExec_cnt
  int sysExeCount = 0;

  /// touch key calibration
  /// 関連tprxソース:sysdata.c - sysToukyCalCnt
  int sysTouchKeyCalCount = 0;

  ///i dol mecha-key buffer
  /// 関連tprxソース:sysdata.c - tprIdolKeyBuf
  String tprIdolKeyBuf = "";

  /// window style
  /// 0=TOPLEVEL, 1=POPUP
  /// 関連tprxソース:sysdata.c - SysWindowStyle
  int sysWindowStyle = 0;

  ///  system fail flag
  ///  true=normal, false=Fail
  /// 関連tprxソース:sysdata.c - SysFail_flg
  bool sysFailFlag = false;

  ///  machine type
  ///  true=tower, false=desktop
  /// 関連tprxソース:sysdata.c - tower
  bool isTower = false;

  ///  prime type
  ///  0=prime_desktop/1=prime_tower
  /// 関連tprxソース:sysdata.c - prime_type
  int primeType = 0;

  ///  prime type
  ///  1=auto to openclose 2=close 3=clicked or failed
  /// 関連tprxソース:sysdata.c - qs_at_flg
  int qsAtFlg = 0;

  /// menu button action type
  /// 関連tprxソース:sysdata.c - qs_at_flg
  String buttonType = "clicked";

  /* touch key calibration */
  /// 関連tprxソース:sysdata.c - sysToukyCalCnt
  int sysTouKyCalCnt = 0;

  late SysLogin_T sysLogin = SysLogin_T();

  /// volume,tone,bright control mode
  ///  0=scpu1/1=scpu2
  int sysCtrlMode = 0;

  static final SysData _instance = SysData._internal();
  factory SysData() {
    return _instance;
  }
  SysData._internal();
}
