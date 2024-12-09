/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///
/// 関連tprxソース:tprmid.h
///

/// TPR-X Message ID List.
class TprMidDef {
  /// System
  /// notification message
  static const TPRMID_NOP = 0x00000000; /* no operation message */
  static const TPRMID_SYSFAIL = (TPRMODEREQ | TPRIPCSYSFAIL | 0);
  static const TPRMID_SYSFAILACK = (TPRMODEACK | TPRIPCSYSFAIL | 0);
  static const TPRMID_SYSFAILWAIT = (TPRMODEBUSY | TPRIPCSYSFAIL | 0);
  static const TPRMID_SYSFAILWAITEND = (TPRMODEBUSY | TPRIPCSYSFAIL | 1);
  static const TPRMID_SYSREBOOT = (TPRMODEBUSY | TPRIPCSYSFAIL | 2);

  /// mode
  static const TPRMODENOTICE = 0x00000000; /* notice */
  static const TPRMODEREQ = 0x01000000; /* request */
  static const TPRMODEACK = 0x02000000; /* ack */
  static const TPRMODEBUSY = 0x04000000; /* busy */
  /// message id (basic);
  static const TPRIPCSYSFAIL = 0x80000000 | 0x0000ff00;
  static const TPRIPCREADY = 0x00100000;
  static const TPRIPCNREADY = 0x00200000;
  static const TPRIPCCREADY = 0x00300000;
  static const TPRIPCNCREADY = 0x00400000;
  static const TPRIPCSNTF = 0x00500000;
  static const TPRIPCTIM = 0x00600000;
  static const TPRIPCDIAG = 0x00700000;
  static const TPRIPCDEV = 0x00800000;
  static const TPRIPCAPL = 0x00900000;

  /// task status
  static const TPRMID_READY = (TPRMODENOTICE | TPRIPCREADY | 0);
  static const TPRMID_NO_READY = (TPRMODENOTICE | TPRIPCNREADY | 0);
  static const TPRMID_CO_READY = (TPRMODENOTICE | TPRIPCCREADY | 0);
  static const TPRMID_NO_CO_READY = (TPRMODENOTICE | TPRIPCNCREADY | 0);

  /// system notice information
  static const TPRMID_SYSNOTIFY = (TPRMODEREQ | TPRIPCSNTF | 0);
  static const TPRMID_SYSNOTIFYACK = (TPRMODEACK | TPRIPCSNTF | 0);

  /// timer task
  static const TPRMID_TIMREQ = (TPRMODEREQ | TPRIPCTIM | 0);
  static const TPRMID_TIM = (TPRMODEACK | TPRIPCTIM | 0);

  /// diag
  static const TPRMID_DIAGREQ = (TPRMODEREQ | TPRIPCDIAG | 0);
  static const TPRMID_DIAGACK = (TPRMODEACK | TPRIPCDIAG | 0);

  /// device driver
  static const TPRMID_DEVREQ = (TPRMODEREQ | TPRIPCDEV | 0);
  static const TPRMID_DEVACK = (TPRMODEACK | TPRIPCDEV | 0);
  static const TPRMID_DEVNOTIFY = (TPRMODENOTICE | TPRIPCDEV | 0);

  /// apl module
  static const TPRMID_APLREQ = (TPRMODEREQ | TPRIPCAPL | 0);
  static const TPRMID_APLACK = (TPRMODEACK | TPRIPCAPL | 0);
  static const TPRMID_APLNOTIFY = (TPRMODENOTICE | TPRIPCAPL | 0);
}
