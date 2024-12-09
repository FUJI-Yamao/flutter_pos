/////////////////////////////////////////////////////////////////////
//
// COPOSDRW.H
//
//   POS Printer header file for OPOS Applications.
//
// Modification history
// ------------------------------------------------------------------
//
/////////////////////////////////////////////////////////////////////
#pragma once


/////////////////////////////////////////////////////////////////////
// RPC Connection
/////////////////////////////////////////////////////////////////////

// Sender
#define DRW_CMD_OPEN				0x01
#define DRW_CMD_GET_OPENED			0x02

// Receiver
#define DRW_STAT_CLOSE				0x01
#define DRW_STAT_OPEN				0x02
#define DRW_SUE_POWER_ONLINE		0x03
#define DRW_SUE_POWER_OFF			0x04
#define DRW_SUE_POWER_OFFLINE		0x05
#define DRW_SUE_POWER_OFF_OFFLINE	0x06

#define DRW_EPTR_NO_ERROR			0x00
// ...
#define DRW_EPTR_FAIL				0xFF