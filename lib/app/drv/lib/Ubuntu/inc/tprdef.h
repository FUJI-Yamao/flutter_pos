#ifndef	__tprdef_h
#define	__tprdef_h

/*
 * byte or bit meanings
  +---------------+
  |a|b|c|d|e|f|g|h|
  +---------------+
   | | | | | | | +--- apl number
   | | | | | | +----- apl number
   | | | | | +------- systask number
   | | | | +--------- systask number
   | | | +----------- driver number
   | | +------------- driver number
   | +--------------- SCPU number
   +----------------- not use.
   see. tprdef.h
 */

/* extrack mask */
#define	TPRMSKTID		0x00ffff00
#define	TPRMSKDID		0x0000ff00
#define	TPRMSKSCPU		0x0f000000

/* get mask */
#define	IS_GETTID(m)	(m & TPRMSKTID)
#define	IS_GETDID(m)	(m & TPRMSKDID)
#define	IS_GETSCPU(m)	(m & TPRMSKSCPU)

/* sub cpu id. */
#define	TPRSCPU1	0x01000000	/* sub cpu 1 */
#define	TPRSCPU2	0x02000000	/* sub cpu 2 */
#define	TPRSCPU3	0x03000000	/* serial */
#define	TPRSCPU4	0x04000000	/* serial */
#define	TPRSCPU5	0x05000000	/* serial */
#define	TPRSCPU6	0x06000000	/* serial */

/* system task */
#define TPRMAXTCT       45
                                /*  0 to 35 : use USB */
                                /* 36 to 39 : use serial */
                                /* 40 to 45 : other(test-mode) */
#define TPRSTSERIAL     36
#define TPRSIO_DNUM1    (TPRSTSERIAL)
#define TPRSIO_DNUM2    (TPRSTSERIAL+1)
#define TPRSIO_DNUM3    (TPRSTSERIAL+2)
#define TPRSIO_DNUM4    (TPRSTSERIAL+3)
#define TPRSTOTHER1     (TPRSTSERIAL+4)
#define TPRSTOTHER2     (TPRSTSERIAL+5)
#define TPRSTOTHER3     (TPRSTSERIAL+6)
#define TPRSTOTHER4     (TPRSTSERIAL+7)
#define TPRSTOTHER5     (TPRSTSERIAL+8)

/* main menu button max */
#define SYS_WIN_TBLMAX  36

/* main menu label max */
#define SYS_WIN_LABEL_MAX       36

/* system initial menu */
#define	TPRMENUMAX	21

/* path length max */
#define	TPRMAXPATHLEN	256		/* 1024 -> 256 */
#define	MAXPATHLEN	1024

/* top window max size */
#define	TPRWINDOW_W	645
#define	TPRWINDOW_H	487

#endif
/* End of tprdef.h */
