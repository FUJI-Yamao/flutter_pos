/*-------------------------------------------------------------------------
 * File Name    : IfMultiTmn.h
 *-------------------------------------------------------------------------*/

#ifndef    _IF_MULTITMN_H_
#define    _IF_MULTITMN_H_

typedef enum {
    CMD_NONE = 0,
    CMD_OPOS_OPEN,
    CMD_OPOS_CLOSE,
    CMD_OPOS_CLAIM_DEVICE,
    CMD_OPOS_RELEASE_DEVICE,
    CMD_OPOS_CHECK_HEALTH,
    CMD_OPOS_CLEAR_OUTPUT,
    CMD_OPSOS_DIRECT_IO,
    CMD_CIF_GET_EVENT,
    CMD_CIF_GET_PROPERTY,
    CMD_CIF_SET_PROPERTY,
    CMD_OPOS_AUTHORIZE_SALES,
    CMD_OPOS_AUTHORIZE_VOID,
    CMD_OPOS_ACCESS_DAILY_LOG,
} TMN_OPOS_CMD;

typedef enum {
    RES_NONE = 0,
    RES_OPOS_OPEN,
    RES_OPOS_CLOSE,
    RES_OPOS_CLAIM_DEVICE,
    RES_OPOS_RELEASE_DEVICE,
    RES_OPOS_CHECK_HEALTH,
    RES_OPOS_CLEAR_OUTPUT,
    RES_OPSOS_DIRECT_IO,
    RES_CIF_GET_EVENT,
    RES_CIF_GET_PROPERTY,
    RES_CIF_SET_PROPERTY,
    RES_OPOS_AUTHORIZE_SALES,
    RES_OPOS_AUTHORIZE_VOID,
    RES_OPOS_ACCESS_DAILY_LOG,
} TMN_OPOS_RES;

#endif
/* end of if_multiTmn.h */
