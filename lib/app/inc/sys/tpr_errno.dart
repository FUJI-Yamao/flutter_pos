/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// 関連tprxソース:tprerrno.h
///

/// Error Numbers.
/// Error Numbers are used by TPR-X Library.
class TprErrNo {
    /// mask bit
    static const TPRECATEGORY   = 0xffff0000;
    static const TPRESUBKIND    = 0x0000ffff;

    /// err code
    static const TPREBUSY       = 0x80000001;     /* xxx busy */
    static const TPRERPARAM     = 0x80000002;	    /* parameter error */
    static const TPREINVTID	    = 0x80000003;	    /* invalid task ID */
    static const TPREINVTIB     = 0x80000004;	    /* invalid task information block */
    static const TPREINVMID     = 0x80000005;	    /* invalid message id */
    static const TPREINVACK     = 0x80000006;	    /* invalid ack message */
    static const TPREOVERFLOW   = 0x80000007;	    /* buffer over flow */
    static const TPREUNKNOWN    = 0x80000008;	    /* unknown error */
    static const TPRETOOLATE    = 0x80000009;	    /* request too late */
    static const TPRESYSCALL    = 0x8000000A;	    /* system call err */

    /// database error code
    static const TPREDBINVKEY   = 0x70000100;	    /* invalid key (db) */
    static const TPREDBINVREC   = 0x70000101;	    /* invalid recode (db) */
    static const TPREDBNOSUCH   = 0x70000102;	    /* no such database */
    static const TPREDBBROKEN   = 0xf0000103;	    /* database is broken */
}
