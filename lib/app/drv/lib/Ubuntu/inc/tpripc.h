#ifndef __tpripc_h
#define __tpripc_h

/*
 * TPRMID_SYSFAILACK
 */
struct	tprcommon	{
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */
} ;
typedef	struct	tprcommon	tprcommon_t ;
typedef	struct	tprcommon	tprsysfailack_t ;


/*
 * TPRMID_SYSFAIL
 */
struct	tprsysfail		{
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	int		errnum ;		/* error status of system operation */
} ;
typedef	struct	tprsysfail	tprsysfail_t ;
typedef	struct	tprsysfail	tprapl_t ;

/*
 * TPRMID_READY
 * TPRMID_NO_READY
 * TPRMID_CO_READY
 * TPRMIT_NO_CO_READY
 * TPRMID_SYSNOTIFY
 * TPRMID_SYSNOTIFYACK
 */
struct	tprtstat		{		/* Task Status message */
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	int		tid ;			/* task ID. */
	TPRTID		mode ;			/* status option */
} ;
typedef	struct	tprtstat	tprtstat_t ;
typedef	struct	tprtstat	tprsysnotify_t ;
typedef	struct	tprtstat	tprsysnotifyack_t ;

/*
 * TPRMID_TIMREQ
 */
struct	tprtimreq		{
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	uint		sec ;			/* sec */
	uint		msec ;			/* msec(100msec=1) */
	int		timID ;			/* id set when timer was set */
	int		drvno ;			/* driver pipe No. */
} ;
typedef	struct	tprtimreq	tprtimreq_t ;

/*
 * TPRMID_TIM
 */
struct	tprtim			{
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	int		timID ;			/* id set when timer was set */
} ;
typedef	struct	tprtim		tprtim_t;

/*
 * TPRMID_DEVREQ
 * TPRMID_DEVACK
 * TPRMID_DEVNOTIFY
 */
struct  tprmsgdevreq    {
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	TPRDID		tid;			/* device ID */
	int		io;			/* input or output */
	int		result;			/* device I/O result */
	uint		datalen;		/* datalen & sequence No. */
						/* MSB 2bit */
						/* 00B: 1 packet data */
						/* 01B: multi packes of begining */
						/* 10B: multi packet of continued */
						/* 11B: multi packet of ending */
	char		data[1024];		/* device data */
};
typedef	struct	tprmsgdevreq	tprmsgdevreq_t ;
typedef	struct	tprmsgdevreq	tprmsgdevack_t ;
typedef	struct	tprmsgdevreq	tprmsgdevnotify_t ; 


/*
 * TPRMID_DEVREQ
 * TPRMID_DEVACK
 * TPRMID_DEVNOTIFY
 */
struct  tprmsgdevreq2    {
	TPRMID		mid ;			/* an area of the message receiving */
	int		length ;		/* extention data length */

	TPRDID		tid;			/* device ID */
	TPRTID		src;			/* source task ID */
	int		io;			/* input or output */
	int		result;			/* device I/O result */
	uint		datalen;		/* datalen & sequence No. */
						/* MSB 2bit */
						/* 00B: 1 packet data */
						/* 01B: multi packes of begining */
						/* 10B: multi packet of continued */
						/* 11B: multi packet of ending */
	char		data[1024];		/* device data */
};
typedef	struct	tprmsgdevreq2	tprmsgdevreq2_t ;
typedef	struct	tprmsgdevreq2	tprmsgdevack2_t ;
typedef	struct	tprmsgdevreq2	tprmsgdevnotify2_t ; 


/*
 * TPRMID_DEVREQ
 * TPRMID_DEVACK
 * TPRMID_DEVNOTIFY
 */
struct  tprmsgdevreq3   {
	TPRMID		mid;			/* an area of the message receiving */
	int		length;			/* extention data length */

	TPRDID		tid;			/* device ID */
	TPRTID		src;			/* source task ID */
	int		io;			/* input or output */
	int		result;			/* device I/O result */
	int		tout;			/* command timeout */
	uint		datalen;		/* data length */
	char		data[1025];		/* device data */
};
typedef struct  tprmsgdevreq3   tprmsgdevreq3_t ;
typedef struct  tprmsgdevreq3   tprmsgdevack3_t ;
typedef struct  tprmsgdevreq3   tprmsgdevnotify3_t ;


union	tprmsg	{
	tprcommon_t		common ;
	tprsysfail_t		sysfail ;
	tprsysfailack_t		sysfailack ;
	tprtstat_t		taskstat ;
	tprsysnotify_t		sysnotify ;
	tprsysnotifyack_t	sysnotifyack ;
	tprtimreq_t		timereq ;
	tprtim_t		timeout ;
	tprmsgdevreq_t		devreq ;
	tprmsgdevack_t		devack ;
	tprmsgdevnotify_t	devnotify ; 
	tprmsgdevreq2_t		devreq2 ;
	tprmsgdevack2_t		devack2 ;
	tprmsgdevnotify2_t	devnotify2 ; 
	tprmsgdevreq3_t		devreq3 ;
	tprmsgdevack3_t		devack3 ;
	tprmsgdevnotify3_t	devnotify3 ;
	tprapl_t		apl ;
	char			dummy[1048] ;
} ;
typedef	union	tprmsg	tprmsg_t ;

#endif
/*  End of tpripc.h */
