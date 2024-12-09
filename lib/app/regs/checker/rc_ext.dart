/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';

import '../../ui/controller/c_common_controller.dart';
import '../../ui/menu/register/m_menu.dart';
import 'rc_ewdsp.dart';
import 'rc_ifevent.dart';
import 'rc_set.dart';
import 'rcky_rfm.dart';
import 'rckyccin_acb.dart';

///  関連tprxソース: rc_ext.h
class RcExt {

  ///  関連tprxソース: rc_ext.h - #define rcClearErr_Stat()	rcClearErr_Stat2(__FUNCTION__)
  static Future<void> rcClearErrStat(String functionName) async {
    await RcSet.rcClearErrStat2(functionName);
  }

  /// エラーダイアログ表示（小計画面に戻る）
  ///  関連tprxソース: rc_ext.h - #define rcErr(a)	rcErr2(__FUNCTION__, a)
  static Future<void> rcErr(String functionName, int errNo) async {
    await RcEwdsp.rcErr2(functionName, errNo, SetMenu1.navigateToPaymentSelectPage);
  }

  /// エラーダイアログ表示（画面遷移先：登録画面）
  ///  関連tprxソース: rc_ext.h - #define rcErr(a)	rcErr2(__FUNCTION__, a)
  static Future<void> rcErrToRegister(String functionName, int errNo) async {
    await RcEwdsp.rcErr2(functionName, errNo, SetMenu1.navigateToRegisterPage);
  }

  ///  関連tprxソース: rc_ext.h - #define rxChkModeSet()	rxChkModeSet2(__FUNCTION__)
  static Future<void> rxChkModeSet(String functionName) async {
    await RcIfEvent.rxChkModeSet2(functionName);
  }

  /// 関連tprxソース: rc_ext.h - #define rxChkModeReset()	rxChkModeReset2(__FUNCTION__)
  static Future<void> rxChkModeReset(String functionName) async {
    await RcIfEvent.rxChkModeReset2(functionName);
  }

  /// 関連tprxソース: rc_ext.h - #define rcWarn_PopDownLcd()	rcWarn_PopDownLcd2(__FUNCTION__)
  static void rcWarnPopDownLcd(String functionName) {
    RcEwdsp.rcWarnPopDownLcd2(functionName);
  }

  /// 関連tprxソース: rc_ext.h - #define Cash_Stat_Set() Cash_Stat_Set2(__FUNCTION__)
  static Future<void> cashStatSet(String functionName) async {
    await RcSet.cashStatSet2(functionName);
  }

  /// 関連tprxソース: rc_ext.h - #define rcChkMember_ChargeSlipCard() rcChkMember_ChargeSlipCard2(NULL)
  static Future<bool> rcChkMemberChargeSlipCard() async {
    //実装は必要だがARKS対応では除外
    // return rcChkMemberChargeSlipCard2(null);
    return true;
  }

  /// 関連tprxソース: rc_ext.h - #define rcKyRfm() rcKyRfm2(0)
  static Future<void> rcKyRfm() async {
    await RckyRfm.rcKyRfm2(0);
  }

  /// 関連tprxソース: rc_ext.h - #define rcEnd_Ky_Rfm() rcEnd_Ky_Rfm2(0)
  static Future<void> rcEndKyRfm() async {
    await RckyRfm.rcEndKyRfm2(0);
  }

  /// 関連tprxソース: rc_ext.h - #define rcCinReadGet_Wait() rcCinReadGet_Wait2(__FUNCTION__)
  static Future<int> rcCinReadGetWait(String functionName) async {
    return await RckyccinAcb.rcCinReadGetWait2(functionName);
  }
}
