#ifndef	__tprtypes_h
#define	__tprtypes_h

/*-----------------------------------------------------------------------*
 *	Universal Types
 *-----------------------------------------------------------------------*/
typedef	unsigned char		uchar ;
#ifdef VX_BASE
typedef	unsigned int		uint ;
typedef	unsigned long		ulong ;
#endif


#ifndef	VX_BASE
typedef	unsigned char		UINT8 ;
typedef	unsigned short		UINT16 ;
typedef	unsigned long		UINT32 ;
#endif

typedef	UINT8			BITFIELD8 ;
typedef	UINT16			BITFIELD16 ;
typedef	UINT32			BITFIELD32 ;

/* ID Types */
typedef	UINT8			TPRSCPU ;	/* sub cpu ID */
typedef	UINT32			TPRTID ;	/* Task ID */
typedef	UINT32			TPRDID ;	/* Device ID */
typedef	UINT32			TPRMID ;	/* IPC Message ID */
typedef	UINT32			TPRAID ;	/* Apl Message ID */

/* Error Log Code Types */
typedef	UINT32			TPRLOGC ;	/* Error log Code-Number */
typedef	UINT32			TPRMENTEC ;	/* Mentenance log Code-Number */

/* Stastus Types */
typedef	UINT16			TPRTST ;	/* task status ID */
typedef	UINT8			TPRIO ;		/* device I/O */
typedef	UINT8			TPRSTAT ;	/* device status */

typedef	union {
	UINT8	bitall;
	struct {
		UINT8	b7:1 ;
		UINT8	b6:1 ;
		UINT8	b5:1 ;
		UINT8	b4:1 ;
		UINT8	b3:1 ;
		UINT8	b2:1 ;
		UINT8	b1:1 ;
		UINT8	b0:1 ;
	} bit ;
} BITF ;

#endif
/* end of tprtypes.h */

