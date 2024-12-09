/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
///
/// 関連tprxソース:tprdef.h
///

class TprDef {
    /// extrack mask
    static const TPRMSKTID  = 0x00ffff00;
    static const TPRMSKDID  = 0x0000ff00;
    static const TPRMSKSCPU = 0x0f000000;

    /// get mask
    static IS_GETTID(m)   => (m & TPRMSKTID);
    static IS_GETDID(m)   => (m & TPRMSKDID);
    static IS_GETSCPU(m)  => (m & TPRMSKSCPU);

    /// sub cpu id.
    static const TPRSCPU1 = 0x01000000;	/* sub cpu 1 */
    static const TPRSCPU2 = 0x02000000;	/* sub cpu 2 */
    static const TPRSCPU3 = 0x03000000;	/* serial */
    static const TPRSCPU4 = 0x04000000;	/* serial */
    static const TPRSCPU5 = 0x05000000;	/* serial */
    static const TPRSCPU6 = 0x06000000;	/* serial */

    /// system task
    static const TPRMAXTCT = 45;
                                    /*  0 to 35 : use USB */
                                    /* 36 to 39 : use serial */
                                    /* 40 to 45 : other(test-mode) */
    static const TPRSTSERIAL    = 36;
    static const TPRSIO_DNUM1   = (TPRSTSERIAL);
    static const TPRSIO_DNUM2   = (TPRSTSERIAL + 1);
    static const TPRSIO_DNUM3   = (TPRSTSERIAL + 2);
    static const TPRSIO_DNUM4   = (TPRSTSERIAL + 3);
    static const TPRSTOTHER1    = (TPRSTSERIAL + 4);
    static const TPRSTOTHER2    = (TPRSTSERIAL + 5);
    static const TPRSTOTHER3    = (TPRSTSERIAL + 6);
    static const TPRSTOTHER4    = (TPRSTSERIAL + 7);
    static const TPRSTOTHER5    = (TPRSTSERIAL + 8);

    /// main menu button max
    static const SYS_WIN_TBLMAX = 36;

    /// main menu label max
    static const SYS_WIN_LABEL_MAX = 36;

    /// system initial menu
    static const TPRMENUMAX	= 21;

    /// path length max
    static const TPRMAXPATHLEN  = 256;		/* 1024 -> 256 */
    static const MAXPATHLEN	    = 1024;

    /// top window max size
    static const TPRWINDOW_W = 645;
    static const TPRWINDOW_H = 487;

    /// isolate終了のタイムアウト時間（秒）
    static const int timeoutIsolateAbort = 30;
}