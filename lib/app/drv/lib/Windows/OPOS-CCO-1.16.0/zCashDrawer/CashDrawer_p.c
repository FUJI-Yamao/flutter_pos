

/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for CashDrawer.idl:
    Oicf, W1, Zp8, env=Win64 (32b run), target_arch=AMD64 8.01.0628 
    protocol : all , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#if defined(_M_AMD64)


#if _MSC_VER >= 1200
#pragma warning(push)
#endif

#pragma warning( disable: 4211 )  /* redefine extern to static */
#pragma warning( disable: 4232 )  /* dllimport identity*/
#pragma warning( disable: 4024 )  /* array to pointer mapping*/
#pragma warning( disable: 4152 )  /* function/data pointer conversion in expression */

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 475
#endif


#include "rpcproxy.h"
#include "ndr64types.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif /* __RPCPROXY_H_VERSION__ */


#include "CashDrawer.h"

#define TYPE_FORMAT_STRING_SIZE   83                                
#define PROC_FORMAT_STRING_SIZE   1951                              
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   1            

typedef struct _CashDrawer_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } CashDrawer_MIDL_TYPE_FORMAT_STRING;

typedef struct _CashDrawer_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } CashDrawer_MIDL_PROC_FORMAT_STRING;

typedef struct _CashDrawer_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } CashDrawer_MIDL_EXPR_FORMAT_STRING;


static const RPC_SYNTAX_IDENTIFIER  _RpcTransferSyntax_2_0 = 
{{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}};

static const RPC_SYNTAX_IDENTIFIER  _NDR64_RpcTransferSyntax_1_0 = 
{{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}};

#if defined(_CONTROL_FLOW_GUARD_XFG)
#define XFG_TRAMPOLINES(ObjectType)\
NDR_SHAREABLE unsigned long ObjectType ## _UserSize_XFG(unsigned long * pFlags, unsigned long Offset, void * pObject)\
{\
return  ObjectType ## _UserSize(pFlags, Offset, (ObjectType *)pObject);\
}\
NDR_SHAREABLE unsigned char * ObjectType ## _UserMarshal_XFG(unsigned long * pFlags, unsigned char * pBuffer, void * pObject)\
{\
return ObjectType ## _UserMarshal(pFlags, pBuffer, (ObjectType *)pObject);\
}\
NDR_SHAREABLE unsigned char * ObjectType ## _UserUnmarshal_XFG(unsigned long * pFlags, unsigned char * pBuffer, void * pObject)\
{\
return ObjectType ## _UserUnmarshal(pFlags, pBuffer, (ObjectType *)pObject);\
}\
NDR_SHAREABLE void ObjectType ## _UserFree_XFG(unsigned long * pFlags, void * pObject)\
{\
ObjectType ## _UserFree(pFlags, (ObjectType *)pObject);\
}
#define XFG_TRAMPOLINES64(ObjectType)\
NDR_SHAREABLE unsigned long ObjectType ## _UserSize64_XFG(unsigned long * pFlags, unsigned long Offset, void * pObject)\
{\
return  ObjectType ## _UserSize64(pFlags, Offset, (ObjectType *)pObject);\
}\
NDR_SHAREABLE unsigned char * ObjectType ## _UserMarshal64_XFG(unsigned long * pFlags, unsigned char * pBuffer, void * pObject)\
{\
return ObjectType ## _UserMarshal64(pFlags, pBuffer, (ObjectType *)pObject);\
}\
NDR_SHAREABLE unsigned char * ObjectType ## _UserUnmarshal64_XFG(unsigned long * pFlags, unsigned char * pBuffer, void * pObject)\
{\
return ObjectType ## _UserUnmarshal64(pFlags, pBuffer, (ObjectType *)pObject);\
}\
NDR_SHAREABLE void ObjectType ## _UserFree64_XFG(unsigned long * pFlags, void * pObject)\
{\
ObjectType ## _UserFree64(pFlags, (ObjectType *)pObject);\
}
#define XFG_BIND_TRAMPOLINES(HandleType, ObjectType)\
static void* ObjectType ## _bind_XFG(HandleType pObject)\
{\
return ObjectType ## _bind((ObjectType) pObject);\
}\
static void ObjectType ## _unbind_XFG(HandleType pObject, handle_t ServerHandle)\
{\
ObjectType ## _unbind((ObjectType) pObject, ServerHandle);\
}
#define XFG_TRAMPOLINE_FPTR(Function) Function ## _XFG
#define XFG_TRAMPOLINE_FPTR_DEPENDENT_SYMBOL(Symbol) Symbol ## _XFG
#else
#define XFG_TRAMPOLINES(ObjectType)
#define XFG_TRAMPOLINES64(ObjectType)
#define XFG_BIND_TRAMPOLINES(HandleType, ObjectType)
#define XFG_TRAMPOLINE_FPTR(Function) Function
#define XFG_TRAMPOLINE_FPTR_DEPENDENT_SYMBOL(Symbol) Symbol
#endif



extern const CashDrawer_MIDL_TYPE_FORMAT_STRING CashDrawer__MIDL_TypeFormatString;
extern const CashDrawer_MIDL_PROC_FORMAT_STRING CashDrawer__MIDL_ProcFormatString;
extern const CashDrawer_MIDL_EXPR_FORMAT_STRING CashDrawer__MIDL_ExprFormatString;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSCashDrawer_1_5_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_5_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSCashDrawer_1_8_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_8_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSCashDrawer_1_9_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_9_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSCashDrawer_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_ProxyInfo;


extern const USER_MARSHAL_ROUTINE_QUADRUPLE NDR64_UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif

static const CashDrawer_MIDL_PROC_FORMAT_STRING CashDrawer__MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure SODataDummy */

			0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/*  2 */	NdrFcLong( 0x0 ),	/* 0 */
/*  6 */	NdrFcShort( 0x7 ),	/* 7 */
/*  8 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 10 */	NdrFcShort( 0x8 ),	/* 8 */
/* 12 */	NdrFcShort( 0x8 ),	/* 8 */
/* 14 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 16 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 18 */	NdrFcShort( 0x0 ),	/* 0 */
/* 20 */	NdrFcShort( 0x0 ),	/* 0 */
/* 22 */	NdrFcShort( 0x0 ),	/* 0 */
/* 24 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Status */

/* 26 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 28 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 30 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 32 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 34 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 36 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SODirectIO */

/* 38 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 40 */	NdrFcLong( 0x0 ),	/* 0 */
/* 44 */	NdrFcShort( 0x8 ),	/* 8 */
/* 46 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 48 */	NdrFcShort( 0x24 ),	/* 36 */
/* 50 */	NdrFcShort( 0x24 ),	/* 36 */
/* 52 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 54 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 56 */	NdrFcShort( 0x1 ),	/* 1 */
/* 58 */	NdrFcShort( 0x1 ),	/* 1 */
/* 60 */	NdrFcShort( 0x0 ),	/* 0 */
/* 62 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter EventNumber */

/* 64 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 66 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 68 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pData */

/* 70 */	NdrFcShort( 0x158 ),	/* Flags:  in, out, base type, simple ref, */
/* 72 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 74 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pString */

/* 76 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 78 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 80 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 82 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 84 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 86 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SOErrorDummy */

/* 88 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 90 */	NdrFcLong( 0x0 ),	/* 0 */
/* 94 */	NdrFcShort( 0x9 ),	/* 9 */
/* 96 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 98 */	NdrFcShort( 0x34 ),	/* 52 */
/* 100 */	NdrFcShort( 0x24 ),	/* 36 */
/* 102 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x5,		/* 5 */
/* 104 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 106 */	NdrFcShort( 0x0 ),	/* 0 */
/* 108 */	NdrFcShort( 0x0 ),	/* 0 */
/* 110 */	NdrFcShort( 0x0 ),	/* 0 */
/* 112 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter ResultCode */

/* 114 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 116 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 118 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ResultCodeExtended */

/* 120 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 122 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 124 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter ErrorLocus */

/* 126 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 128 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pErrorResponse */

/* 132 */	NdrFcShort( 0x158 ),	/* Flags:  in, out, base type, simple ref, */
/* 134 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 138 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 140 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SOOutputCompleteDummy */

/* 144 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 146 */	NdrFcLong( 0x0 ),	/* 0 */
/* 150 */	NdrFcShort( 0xa ),	/* 10 */
/* 152 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 154 */	NdrFcShort( 0x8 ),	/* 8 */
/* 156 */	NdrFcShort( 0x8 ),	/* 8 */
/* 158 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 160 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 162 */	NdrFcShort( 0x0 ),	/* 0 */
/* 164 */	NdrFcShort( 0x0 ),	/* 0 */
/* 166 */	NdrFcShort( 0x0 ),	/* 0 */
/* 168 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter OutputID */

/* 170 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 172 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 174 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 176 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 178 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 180 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SOStatusUpdate */

/* 182 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 184 */	NdrFcLong( 0x0 ),	/* 0 */
/* 188 */	NdrFcShort( 0xb ),	/* 11 */
/* 190 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 192 */	NdrFcShort( 0x8 ),	/* 8 */
/* 194 */	NdrFcShort( 0x8 ),	/* 8 */
/* 196 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 198 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 200 */	NdrFcShort( 0x0 ),	/* 0 */
/* 202 */	NdrFcShort( 0x0 ),	/* 0 */
/* 204 */	NdrFcShort( 0x0 ),	/* 0 */
/* 206 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Data */

/* 208 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 210 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 212 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 214 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 216 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 218 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SOProcessID */

/* 220 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 222 */	NdrFcLong( 0x0 ),	/* 0 */
/* 226 */	NdrFcShort( 0xc ),	/* 12 */
/* 228 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 230 */	NdrFcShort( 0x0 ),	/* 0 */
/* 232 */	NdrFcShort( 0x24 ),	/* 36 */
/* 234 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 236 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 238 */	NdrFcShort( 0x0 ),	/* 0 */
/* 240 */	NdrFcShort( 0x0 ),	/* 0 */
/* 242 */	NdrFcShort( 0x0 ),	/* 0 */
/* 244 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pProcessID */

/* 246 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 248 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 250 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 252 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 254 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 256 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_OpenResult */

/* 258 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 260 */	NdrFcLong( 0x0 ),	/* 0 */
/* 264 */	NdrFcShort( 0xd ),	/* 13 */
/* 266 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 268 */	NdrFcShort( 0x0 ),	/* 0 */
/* 270 */	NdrFcShort( 0x24 ),	/* 36 */
/* 272 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 274 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 276 */	NdrFcShort( 0x0 ),	/* 0 */
/* 278 */	NdrFcShort( 0x0 ),	/* 0 */
/* 280 */	NdrFcShort( 0x0 ),	/* 0 */
/* 282 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pOpenResult */

/* 284 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 286 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 288 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 290 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 292 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CheckHealthText */

/* 296 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 298 */	NdrFcLong( 0x0 ),	/* 0 */
/* 302 */	NdrFcShort( 0xe ),	/* 14 */
/* 304 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 306 */	NdrFcShort( 0x0 ),	/* 0 */
/* 308 */	NdrFcShort( 0x8 ),	/* 8 */
/* 310 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 312 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 314 */	NdrFcShort( 0x1 ),	/* 1 */
/* 316 */	NdrFcShort( 0x0 ),	/* 0 */
/* 318 */	NdrFcShort( 0x0 ),	/* 0 */
/* 320 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCheckHealthText */

/* 322 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 324 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 326 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 328 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 330 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 332 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_Claimed */

/* 334 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 336 */	NdrFcLong( 0x0 ),	/* 0 */
/* 340 */	NdrFcShort( 0xf ),	/* 15 */
/* 342 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 344 */	NdrFcShort( 0x0 ),	/* 0 */
/* 346 */	NdrFcShort( 0x22 ),	/* 34 */
/* 348 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 350 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 352 */	NdrFcShort( 0x0 ),	/* 0 */
/* 354 */	NdrFcShort( 0x0 ),	/* 0 */
/* 356 */	NdrFcShort( 0x0 ),	/* 0 */
/* 358 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pClaimed */

/* 360 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 362 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 364 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 366 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 368 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 370 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceEnabled */

/* 372 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 374 */	NdrFcLong( 0x0 ),	/* 0 */
/* 378 */	NdrFcShort( 0x10 ),	/* 16 */
/* 380 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 382 */	NdrFcShort( 0x0 ),	/* 0 */
/* 384 */	NdrFcShort( 0x22 ),	/* 34 */
/* 386 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 388 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 390 */	NdrFcShort( 0x0 ),	/* 0 */
/* 392 */	NdrFcShort( 0x0 ),	/* 0 */
/* 394 */	NdrFcShort( 0x0 ),	/* 0 */
/* 396 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDeviceEnabled */

/* 398 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 400 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 402 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 404 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 406 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_DeviceEnabled */

/* 410 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 412 */	NdrFcLong( 0x0 ),	/* 0 */
/* 416 */	NdrFcShort( 0x11 ),	/* 17 */
/* 418 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 420 */	NdrFcShort( 0x6 ),	/* 6 */
/* 422 */	NdrFcShort( 0x8 ),	/* 8 */
/* 424 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 426 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 428 */	NdrFcShort( 0x0 ),	/* 0 */
/* 430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 434 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter DeviceEnabled */

/* 436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 438 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 440 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 442 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 444 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_FreezeEvents */

/* 448 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 450 */	NdrFcLong( 0x0 ),	/* 0 */
/* 454 */	NdrFcShort( 0x12 ),	/* 18 */
/* 456 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 458 */	NdrFcShort( 0x0 ),	/* 0 */
/* 460 */	NdrFcShort( 0x22 ),	/* 34 */
/* 462 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 464 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 466 */	NdrFcShort( 0x0 ),	/* 0 */
/* 468 */	NdrFcShort( 0x0 ),	/* 0 */
/* 470 */	NdrFcShort( 0x0 ),	/* 0 */
/* 472 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pFreezeEvents */

/* 474 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 476 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 478 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 480 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 482 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 484 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_FreezeEvents */

/* 486 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 488 */	NdrFcLong( 0x0 ),	/* 0 */
/* 492 */	NdrFcShort( 0x13 ),	/* 19 */
/* 494 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 496 */	NdrFcShort( 0x6 ),	/* 6 */
/* 498 */	NdrFcShort( 0x8 ),	/* 8 */
/* 500 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 502 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 504 */	NdrFcShort( 0x0 ),	/* 0 */
/* 506 */	NdrFcShort( 0x0 ),	/* 0 */
/* 508 */	NdrFcShort( 0x0 ),	/* 0 */
/* 510 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FreezeEvents */

/* 512 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 514 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 516 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 518 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 520 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 522 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCode */

/* 524 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 526 */	NdrFcLong( 0x0 ),	/* 0 */
/* 530 */	NdrFcShort( 0x14 ),	/* 20 */
/* 532 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 534 */	NdrFcShort( 0x0 ),	/* 0 */
/* 536 */	NdrFcShort( 0x24 ),	/* 36 */
/* 538 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 540 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 542 */	NdrFcShort( 0x0 ),	/* 0 */
/* 544 */	NdrFcShort( 0x0 ),	/* 0 */
/* 546 */	NdrFcShort( 0x0 ),	/* 0 */
/* 548 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pResultCode */

/* 550 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 552 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 554 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 556 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 558 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCodeExtended */

/* 562 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 564 */	NdrFcLong( 0x0 ),	/* 0 */
/* 568 */	NdrFcShort( 0x15 ),	/* 21 */
/* 570 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 574 */	NdrFcShort( 0x24 ),	/* 36 */
/* 576 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 578 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 580 */	NdrFcShort( 0x0 ),	/* 0 */
/* 582 */	NdrFcShort( 0x0 ),	/* 0 */
/* 584 */	NdrFcShort( 0x0 ),	/* 0 */
/* 586 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pResultCodeExtended */

/* 588 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 590 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 596 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_State */

/* 600 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 602 */	NdrFcLong( 0x0 ),	/* 0 */
/* 606 */	NdrFcShort( 0x16 ),	/* 22 */
/* 608 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 610 */	NdrFcShort( 0x0 ),	/* 0 */
/* 612 */	NdrFcShort( 0x24 ),	/* 36 */
/* 614 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 616 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 618 */	NdrFcShort( 0x0 ),	/* 0 */
/* 620 */	NdrFcShort( 0x0 ),	/* 0 */
/* 622 */	NdrFcShort( 0x0 ),	/* 0 */
/* 624 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pState */

/* 626 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 632 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 636 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectDescription */

/* 638 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 640 */	NdrFcLong( 0x0 ),	/* 0 */
/* 644 */	NdrFcShort( 0x17 ),	/* 23 */
/* 646 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 650 */	NdrFcShort( 0x8 ),	/* 8 */
/* 652 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 654 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 656 */	NdrFcShort( 0x1 ),	/* 1 */
/* 658 */	NdrFcShort( 0x0 ),	/* 0 */
/* 660 */	NdrFcShort( 0x0 ),	/* 0 */
/* 662 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pControlObjectDescription */

/* 664 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 666 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 668 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 670 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 672 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectVersion */

/* 676 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 678 */	NdrFcLong( 0x0 ),	/* 0 */
/* 682 */	NdrFcShort( 0x18 ),	/* 24 */
/* 684 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 686 */	NdrFcShort( 0x0 ),	/* 0 */
/* 688 */	NdrFcShort( 0x24 ),	/* 36 */
/* 690 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 692 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 694 */	NdrFcShort( 0x0 ),	/* 0 */
/* 696 */	NdrFcShort( 0x0 ),	/* 0 */
/* 698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 700 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pControlObjectVersion */

/* 702 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 704 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 708 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 710 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectDescription */

/* 714 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 716 */	NdrFcLong( 0x0 ),	/* 0 */
/* 720 */	NdrFcShort( 0x19 ),	/* 25 */
/* 722 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 724 */	NdrFcShort( 0x0 ),	/* 0 */
/* 726 */	NdrFcShort( 0x8 ),	/* 8 */
/* 728 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 730 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 732 */	NdrFcShort( 0x1 ),	/* 1 */
/* 734 */	NdrFcShort( 0x0 ),	/* 0 */
/* 736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 738 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pServiceObjectDescription */

/* 740 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 742 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 744 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 746 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 748 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 750 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectVersion */

/* 752 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 754 */	NdrFcLong( 0x0 ),	/* 0 */
/* 758 */	NdrFcShort( 0x1a ),	/* 26 */
/* 760 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 764 */	NdrFcShort( 0x24 ),	/* 36 */
/* 766 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 768 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 770 */	NdrFcShort( 0x0 ),	/* 0 */
/* 772 */	NdrFcShort( 0x0 ),	/* 0 */
/* 774 */	NdrFcShort( 0x0 ),	/* 0 */
/* 776 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pServiceObjectVersion */

/* 778 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 780 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 782 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 784 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 786 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceDescription */

/* 790 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 792 */	NdrFcLong( 0x0 ),	/* 0 */
/* 796 */	NdrFcShort( 0x1b ),	/* 27 */
/* 798 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 802 */	NdrFcShort( 0x8 ),	/* 8 */
/* 804 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 806 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 808 */	NdrFcShort( 0x1 ),	/* 1 */
/* 810 */	NdrFcShort( 0x0 ),	/* 0 */
/* 812 */	NdrFcShort( 0x0 ),	/* 0 */
/* 814 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDeviceDescription */

/* 816 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 818 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 820 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 822 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 824 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 826 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceName */

/* 828 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 830 */	NdrFcLong( 0x0 ),	/* 0 */
/* 834 */	NdrFcShort( 0x1c ),	/* 28 */
/* 836 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 838 */	NdrFcShort( 0x0 ),	/* 0 */
/* 840 */	NdrFcShort( 0x8 ),	/* 8 */
/* 842 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 844 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 846 */	NdrFcShort( 0x1 ),	/* 1 */
/* 848 */	NdrFcShort( 0x0 ),	/* 0 */
/* 850 */	NdrFcShort( 0x0 ),	/* 0 */
/* 852 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDeviceName */

/* 854 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 856 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 858 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 860 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 862 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 864 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CheckHealth */

/* 866 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 868 */	NdrFcLong( 0x0 ),	/* 0 */
/* 872 */	NdrFcShort( 0x1d ),	/* 29 */
/* 874 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 876 */	NdrFcShort( 0x8 ),	/* 8 */
/* 878 */	NdrFcShort( 0x24 ),	/* 36 */
/* 880 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 882 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 884 */	NdrFcShort( 0x0 ),	/* 0 */
/* 886 */	NdrFcShort( 0x0 ),	/* 0 */
/* 888 */	NdrFcShort( 0x0 ),	/* 0 */
/* 890 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Level */

/* 892 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 894 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 896 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 898 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 900 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 904 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 906 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 908 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClaimDevice */

/* 910 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 912 */	NdrFcLong( 0x0 ),	/* 0 */
/* 916 */	NdrFcShort( 0x1e ),	/* 30 */
/* 918 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 920 */	NdrFcShort( 0x8 ),	/* 8 */
/* 922 */	NdrFcShort( 0x24 ),	/* 36 */
/* 924 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 926 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 928 */	NdrFcShort( 0x0 ),	/* 0 */
/* 930 */	NdrFcShort( 0x0 ),	/* 0 */
/* 932 */	NdrFcShort( 0x0 ),	/* 0 */
/* 934 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Timeout */

/* 936 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 938 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 940 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 942 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 944 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 946 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 948 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 950 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 952 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Close */

/* 954 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 956 */	NdrFcLong( 0x0 ),	/* 0 */
/* 960 */	NdrFcShort( 0x1f ),	/* 31 */
/* 962 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 964 */	NdrFcShort( 0x0 ),	/* 0 */
/* 966 */	NdrFcShort( 0x24 ),	/* 36 */
/* 968 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 970 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 972 */	NdrFcShort( 0x0 ),	/* 0 */
/* 974 */	NdrFcShort( 0x0 ),	/* 0 */
/* 976 */	NdrFcShort( 0x0 ),	/* 0 */
/* 978 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 980 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 982 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 984 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 986 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 988 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 990 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure DirectIO */

/* 992 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 994 */	NdrFcLong( 0x0 ),	/* 0 */
/* 998 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1000 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 1002 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1004 */	NdrFcShort( 0x40 ),	/* 64 */
/* 1006 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 1008 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 1010 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1012 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1016 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Command */

/* 1018 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1020 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1022 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pData */

/* 1024 */	NdrFcShort( 0x158 ),	/* Flags:  in, out, base type, simple ref, */
/* 1026 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1028 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pString */

/* 1030 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 1032 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1034 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 1036 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1038 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1040 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1042 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1044 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 1046 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Open */

/* 1048 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1050 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1054 */	NdrFcShort( 0x21 ),	/* 33 */
/* 1056 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1058 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1060 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1062 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1064 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1066 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1068 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1070 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1072 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter DeviceName */

/* 1074 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1076 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1078 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1080 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1082 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1084 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1086 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1088 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1090 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ReleaseDevice */

/* 1092 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1094 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1098 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1100 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1102 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1104 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1106 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1108 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1110 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1112 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1114 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1116 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1118 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1120 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1122 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1124 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1126 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1128 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapStatus */

/* 1130 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1132 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1136 */	NdrFcShort( 0x23 ),	/* 35 */
/* 1138 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1140 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1142 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1144 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1146 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1148 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1150 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1152 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1154 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapStatus */

/* 1156 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1158 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1160 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1162 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1164 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1166 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DrawerOpened */

/* 1168 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1170 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1174 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1176 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1178 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1180 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1182 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1184 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1186 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1190 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1192 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDrawerOpened */

/* 1194 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1196 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1198 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1200 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1202 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure OpenDrawer */

/* 1206 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1208 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1212 */	NdrFcShort( 0x25 ),	/* 37 */
/* 1214 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1216 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1218 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1220 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1222 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1224 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1226 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1228 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1230 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1232 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1234 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1236 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1238 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1240 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1242 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure WaitForDrawerClose */

/* 1244 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1246 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1250 */	NdrFcShort( 0x26 ),	/* 38 */
/* 1252 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 1254 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1256 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1258 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x6,		/* 6 */
/* 1260 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1262 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1264 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1266 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1268 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter BeepTimeout */

/* 1270 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1272 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter BeepFrequency */

/* 1276 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1278 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1280 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter BeepDuration */

/* 1282 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1284 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1286 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter BeepDelay */

/* 1288 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1290 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1292 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 1294 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1296 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 1298 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1300 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1302 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 1304 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_BinaryConversion */

/* 1306 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1308 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1312 */	NdrFcShort( 0x27 ),	/* 39 */
/* 1314 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1316 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1318 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1320 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1322 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1324 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1326 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1328 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1330 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pBinaryConversion */

/* 1332 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1334 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1336 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1338 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1340 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1342 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_BinaryConversion */

/* 1344 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1346 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1350 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1352 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1354 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1356 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1358 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1360 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1362 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1364 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1366 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1368 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter BinaryConversion */

/* 1370 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1372 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1374 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1376 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1378 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1380 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapPowerReporting */

/* 1382 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1384 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1388 */	NdrFcShort( 0x29 ),	/* 41 */
/* 1390 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1392 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1394 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1396 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1398 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1400 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1402 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1404 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1406 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapPowerReporting */

/* 1408 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1410 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1412 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1414 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1416 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1418 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerNotify */

/* 1420 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1422 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1426 */	NdrFcShort( 0x2a ),	/* 42 */
/* 1428 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1432 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1434 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1436 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1438 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1440 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1442 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1444 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerNotify */

/* 1446 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1448 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1450 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1452 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1454 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1456 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PowerNotify */

/* 1458 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1460 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1464 */	NdrFcShort( 0x2b ),	/* 43 */
/* 1466 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1468 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1470 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1472 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1474 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1476 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1478 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1480 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1482 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PowerNotify */

/* 1484 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1486 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1488 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1490 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1492 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerState */

/* 1496 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1498 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1502 */	NdrFcShort( 0x2c ),	/* 44 */
/* 1504 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1506 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1508 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1510 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1512 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1514 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1516 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1518 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1520 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerState */

/* 1522 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1524 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1526 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1528 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1530 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1532 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapStatusMultiDrawerDetect */

/* 1534 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1536 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1540 */	NdrFcShort( 0x2d ),	/* 45 */
/* 1542 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1544 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1546 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1548 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1550 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1552 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1554 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1556 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1558 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapStatusMultiDrawerDetect */

/* 1560 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1562 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1564 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1566 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1568 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapStatisticsReporting */

/* 1572 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1574 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1578 */	NdrFcShort( 0x2e ),	/* 46 */
/* 1580 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1582 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1584 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1586 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1588 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1590 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1592 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1594 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1596 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapStatisticsReporting */

/* 1598 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1600 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1602 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1604 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1606 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1608 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateStatistics */

/* 1610 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1612 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1616 */	NdrFcShort( 0x2f ),	/* 47 */
/* 1618 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1620 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1622 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1624 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1626 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1628 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1630 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1632 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1634 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateStatistics */

/* 1636 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1638 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1640 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1642 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1644 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1646 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ResetStatistics */

/* 1648 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1650 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1654 */	NdrFcShort( 0x30 ),	/* 48 */
/* 1656 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1658 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1660 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1662 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1664 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1666 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1668 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1670 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1672 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 1674 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1676 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1678 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1680 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1682 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1684 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1686 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1688 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1690 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure RetrieveStatistics */

/* 1692 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1694 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1698 */	NdrFcShort( 0x31 ),	/* 49 */
/* 1700 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1702 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1704 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1706 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1708 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 1710 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1712 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1714 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1716 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pStatisticsBuffer */

/* 1718 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 1720 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1722 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 1724 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1726 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1728 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1730 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1732 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1734 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateStatistics */

/* 1736 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1738 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1742 */	NdrFcShort( 0x32 ),	/* 50 */
/* 1744 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1746 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1748 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1750 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1752 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1754 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1756 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1758 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1760 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 1762 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1764 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1766 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1768 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1770 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1772 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1774 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1776 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1778 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapCompareFirmwareVersion */

/* 1780 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1782 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1786 */	NdrFcShort( 0x33 ),	/* 51 */
/* 1788 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1790 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1792 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1794 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1796 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1798 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1802 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1804 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapCompareFirmwareVersion */

/* 1806 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1808 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1810 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1812 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1814 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1816 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateFirmware */

/* 1818 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1820 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1824 */	NdrFcShort( 0x34 ),	/* 52 */
/* 1826 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1828 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1830 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1832 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1834 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1836 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1838 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1840 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1842 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateFirmware */

/* 1844 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1846 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1848 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1850 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1852 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1854 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CompareFirmwareVersion */

/* 1856 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1858 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1862 */	NdrFcShort( 0x35 ),	/* 53 */
/* 1864 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 1866 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1868 */	NdrFcShort( 0x40 ),	/* 64 */
/* 1870 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 1872 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1874 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1876 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1878 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1880 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 1882 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1884 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1886 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pResult */

/* 1888 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1890 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1892 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 1894 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1896 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1898 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1900 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1902 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1904 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateFirmware */

/* 1906 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1908 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1912 */	NdrFcShort( 0x36 ),	/* 54 */
/* 1914 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1916 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1918 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1920 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1922 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1924 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1926 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1928 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1930 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 1932 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1934 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1936 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1938 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1940 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1942 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1944 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1946 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1948 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const CashDrawer_MIDL_TYPE_FORMAT_STRING CashDrawer__MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */
/*  2 */	
			0x11, 0x8,	/* FC_RP [simple_pointer] */
/*  4 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */
/*  6 */	
			0x11, 0x0,	/* FC_RP */
/*  8 */	NdrFcShort( 0x26 ),	/* Offset= 38 (46) */
/* 10 */	
			0x13, 0x0,	/* FC_OP */
/* 12 */	NdrFcShort( 0x18 ),	/* Offset= 24 (36) */
/* 14 */	
			0x1b,		/* FC_CARRAY */
			0x1,		/* 1 */
/* 16 */	NdrFcShort( 0x2 ),	/* 2 */
/* 18 */	0x9,		/* Corr desc: FC_ULONG */
			0x0,		/*  */
/* 20 */	NdrFcShort( 0xfffc ),	/* -4 */
/* 22 */	NdrFcShort( 0x1 ),	/* Corr flags:  early, */
/* 24 */	0x0 , 
			0x0,		/* 0 */
/* 26 */	NdrFcLong( 0x0 ),	/* 0 */
/* 30 */	NdrFcLong( 0x0 ),	/* 0 */
/* 34 */	0x6,		/* FC_SHORT */
			0x5b,		/* FC_END */
/* 36 */	
			0x17,		/* FC_CSTRUCT */
			0x3,		/* 3 */
/* 38 */	NdrFcShort( 0x8 ),	/* 8 */
/* 40 */	NdrFcShort( 0xffe6 ),	/* Offset= -26 (14) */
/* 42 */	0x8,		/* FC_LONG */
			0x8,		/* FC_LONG */
/* 44 */	0x5c,		/* FC_PAD */
			0x5b,		/* FC_END */
/* 46 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 48 */	NdrFcShort( 0x0 ),	/* 0 */
/* 50 */	NdrFcShort( 0x8 ),	/* 8 */
/* 52 */	NdrFcShort( 0x0 ),	/* 0 */
/* 54 */	NdrFcShort( 0xffd4 ),	/* Offset= -44 (10) */
/* 56 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 58 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */
/* 60 */	
			0x11, 0x4,	/* FC_RP [alloced_on_stack] */
/* 62 */	NdrFcShort( 0xfff0 ),	/* Offset= -16 (46) */
/* 64 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 66 */	0x6,		/* FC_SHORT */
			0x5c,		/* FC_PAD */
/* 68 */	
			0x12, 0x0,	/* FC_UP */
/* 70 */	NdrFcShort( 0xffde ),	/* Offset= -34 (36) */
/* 72 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 74 */	NdrFcShort( 0x0 ),	/* 0 */
/* 76 */	NdrFcShort( 0x8 ),	/* 8 */
/* 78 */	NdrFcShort( 0x0 ),	/* 0 */
/* 80 */	NdrFcShort( 0xfff4 ),	/* Offset= -12 (68) */

			0x0
        }
    };

XFG_TRAMPOLINES(BSTR)

static const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ] = 
        {
            
            {
            (USER_MARSHAL_SIZING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserSize)
            ,(USER_MARSHAL_MARSHALLING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserMarshal)
            ,(USER_MARSHAL_UNMARSHALLING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserUnmarshal)
            ,(USER_MARSHAL_FREEING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserFree)
            
            }
            

        };



/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IDispatch, ver. 0.0,
   GUID={0x00020400,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IOPOSCashDrawer_1_5, ver. 0.0,
   GUID={0xCCB91041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSCashDrawer_1_5_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    38,
    88,
    144,
    182,
    220,
    258,
    296,
    334,
    372,
    410,
    448,
    486,
    524,
    562,
    600,
    638,
    676,
    714,
    752,
    790,
    828,
    866,
    910,
    954,
    992,
    1048,
    1092,
    1130,
    1168,
    1206,
    1244,
    1306,
    1344,
    1382,
    1420,
    1458,
    1496,
    1534
    };



/* Object interface: IOPOSCashDrawer_1_8, ver. 0.0,
   GUID={0xCCB92041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSCashDrawer_1_8_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    38,
    88,
    144,
    182,
    220,
    258,
    296,
    334,
    372,
    410,
    448,
    486,
    524,
    562,
    600,
    638,
    676,
    714,
    752,
    790,
    828,
    866,
    910,
    954,
    992,
    1048,
    1092,
    1130,
    1168,
    1206,
    1244,
    1306,
    1344,
    1382,
    1420,
    1458,
    1496,
    1534,
    1572,
    1610,
    1648,
    1692,
    1736
    };



/* Object interface: IOPOSCashDrawer_1_9, ver. 0.0,
   GUID={0xCCB93041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSCashDrawer_1_9_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    38,
    88,
    144,
    182,
    220,
    258,
    296,
    334,
    372,
    410,
    448,
    486,
    524,
    562,
    600,
    638,
    676,
    714,
    752,
    790,
    828,
    866,
    910,
    954,
    992,
    1048,
    1092,
    1130,
    1168,
    1206,
    1244,
    1306,
    1344,
    1382,
    1420,
    1458,
    1496,
    1534,
    1572,
    1610,
    1648,
    1692,
    1736,
    1780,
    1818,
    1856,
    1906
    };



/* Object interface: IOPOSCashDrawer, ver. 0.0,
   GUID={0xCCB94041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSCashDrawer_FormatStringOffsetTable[] =
    {
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    (unsigned short) -1,
    0,
    38,
    88,
    144,
    182,
    220,
    258,
    296,
    334,
    372,
    410,
    448,
    486,
    524,
    562,
    600,
    638,
    676,
    714,
    752,
    790,
    828,
    866,
    910,
    954,
    992,
    1048,
    1092,
    1130,
    1168,
    1206,
    1244,
    1306,
    1344,
    1382,
    1420,
    1458,
    1496,
    1534,
    1572,
    1610,
    1648,
    1692,
    1736,
    1780,
    1818,
    1856,
    1906,
    0
    };



#endif /* defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for CashDrawer.idl:
    Oicf, W1, Zp8, env=Win64 (32b run), target_arch=AMD64 8.01.0628 
    protocol : all , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#if defined(_M_AMD64)



extern const USER_MARSHAL_ROUTINE_QUADRUPLE NDR64_UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif


#include "ndr64types.h"
#include "pshpack8.h"
#ifdef __cplusplus
namespace {
#endif


typedef 
NDR64_FORMAT_CHAR
__midl_frag229_t;
extern const __midl_frag229_t __midl_frag229;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag227_t;
extern const __midl_frag227_t __midl_frag227;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag226_t;
extern const __midl_frag226_t __midl_frag226;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag225_t;
extern const __midl_frag225_t __midl_frag225;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag224_t;
extern const __midl_frag224_t __midl_frag224;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag216_t;
extern const __midl_frag216_t __midl_frag216;

typedef 
NDR64_FORMAT_CHAR
__midl_frag214_t;
extern const __midl_frag214_t __midl_frag214;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag213_t;
extern const __midl_frag213_t __midl_frag213;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag212_t;
extern const __midl_frag212_t __midl_frag212;

typedef 
NDR64_FORMAT_CHAR
__midl_frag211_t;
extern const __midl_frag211_t __midl_frag211;

typedef 
NDR64_FORMAT_CHAR
__midl_frag210_t;
extern const __midl_frag210_t __midl_frag210;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag209_t;
extern const __midl_frag209_t __midl_frag209;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag208_t;
extern const __midl_frag208_t __midl_frag208;

typedef 
NDR64_FORMAT_CHAR
__midl_frag207_t;
extern const __midl_frag207_t __midl_frag207;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag205_t;
extern const __midl_frag205_t __midl_frag205;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag204_t;
extern const __midl_frag204_t __midl_frag204;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag203_t;
extern const __midl_frag203_t __midl_frag203;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag202_t;
extern const __midl_frag202_t __midl_frag202;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag198_t;
extern const __midl_frag198_t __midl_frag198;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag197_t;
extern const __midl_frag197_t __midl_frag197;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag196_t;
extern const __midl_frag196_t __midl_frag196;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag195_t;
extern const __midl_frag195_t __midl_frag195;

typedef 
NDR64_FORMAT_CHAR
__midl_frag187_t;
extern const __midl_frag187_t __midl_frag187;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag186_t;
extern const __midl_frag186_t __midl_frag186;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag185_t;
extern const __midl_frag185_t __midl_frag185;

typedef 
NDR64_FORMAT_CHAR
__midl_frag184_t;
extern const __midl_frag184_t __midl_frag184;

typedef 
NDR64_FORMAT_CHAR
__midl_frag183_t;
extern const __midl_frag183_t __midl_frag183;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag182_t;
extern const __midl_frag182_t __midl_frag182;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag181_t;
extern const __midl_frag181_t __midl_frag181;

typedef 
NDR64_FORMAT_CHAR
__midl_frag180_t;
extern const __midl_frag180_t __midl_frag180;

typedef 
NDR64_FORMAT_CHAR
__midl_frag179_t;
extern const __midl_frag179_t __midl_frag179;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag178_t;
extern const __midl_frag178_t __midl_frag178;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag177_t;
extern const __midl_frag177_t __midl_frag177;

typedef 
NDR64_FORMAT_CHAR
__midl_frag176_t;
extern const __midl_frag176_t __midl_frag176;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag174_t;
extern const __midl_frag174_t __midl_frag174;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag173_t;
extern const __midl_frag173_t __midl_frag173;

typedef 
NDR64_FORMAT_CHAR
__midl_frag172_t;
extern const __midl_frag172_t __midl_frag172;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag170_t;
extern const __midl_frag170_t __midl_frag170;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag167_t;
extern const __midl_frag167_t __midl_frag167;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag166_t;
extern const __midl_frag166_t __midl_frag166;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
    struct _NDR64_PARAM_FORMAT frag6;
    struct _NDR64_PARAM_FORMAT frag7;
}
__midl_frag147_t;
extern const __midl_frag147_t __midl_frag147;

typedef 
NDR64_FORMAT_CHAR
__midl_frag141_t;
extern const __midl_frag141_t __midl_frag141;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag140_t;
extern const __midl_frag140_t __midl_frag140;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag139_t;
extern const __midl_frag139_t __midl_frag139;

typedef 
NDR64_FORMAT_CHAR
__midl_frag138_t;
extern const __midl_frag138_t __midl_frag138;

typedef 
NDR64_FORMAT_CHAR
__midl_frag137_t;
extern const __midl_frag137_t __midl_frag137;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag136_t;
extern const __midl_frag136_t __midl_frag136;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag135_t;
extern const __midl_frag135_t __midl_frag135;

typedef 
NDR64_FORMAT_CHAR
__midl_frag134_t;
extern const __midl_frag134_t __midl_frag134;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag132_t;
extern const __midl_frag132_t __midl_frag132;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag131_t;
extern const __midl_frag131_t __midl_frag131;

typedef 
NDR64_FORMAT_CHAR
__midl_frag130_t;
extern const __midl_frag130_t __midl_frag130;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag128_t;
extern const __midl_frag128_t __midl_frag128;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag127_t;
extern const __midl_frag127_t __midl_frag127;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag126_t;
extern const __midl_frag126_t __midl_frag126;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag125_t;
extern const __midl_frag125_t __midl_frag125;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag121_t;
extern const __midl_frag121_t __midl_frag121;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag120_t;
extern const __midl_frag120_t __midl_frag120;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag119_t;
extern const __midl_frag119_t __midl_frag119;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag117_t;
extern const __midl_frag117_t __midl_frag117;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
    struct _NDR64_PARAM_FORMAT frag6;
}
__midl_frag115_t;
extern const __midl_frag115_t __midl_frag115;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag111_t;
extern const __midl_frag111_t __midl_frag111;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag106_t;
extern const __midl_frag106_t __midl_frag106;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag97_t;
extern const __midl_frag97_t __midl_frag97;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag96_t;
extern const __midl_frag96_t __midl_frag96;

typedef 
NDR64_FORMAT_CHAR
__midl_frag59_t;
extern const __midl_frag59_t __midl_frag59;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag58_t;
extern const __midl_frag58_t __midl_frag58;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag55_t;
extern const __midl_frag55_t __midl_frag55;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag54_t;
extern const __midl_frag54_t __midl_frag54;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag35_t;
extern const __midl_frag35_t __midl_frag35;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag27_t;
extern const __midl_frag27_t __midl_frag27;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
    struct _NDR64_PARAM_FORMAT frag6;
}
__midl_frag17_t;
extern const __midl_frag17_t __midl_frag17;

typedef 
struct 
{
    NDR64_FORMAT_UINT32 frag1;
    struct _NDR64_EXPR_VAR frag2;
}
__midl_frag14_t;
extern const __midl_frag14_t __midl_frag14;

typedef 
struct 
{
    struct _NDR64_CONF_ARRAY_HEADER_FORMAT frag1;
    struct _NDR64_ARRAY_ELEMENT_INFO frag2;
}
__midl_frag13_t;
extern const __midl_frag13_t __midl_frag13;

typedef 
struct 
{
    struct _NDR64_CONF_STRUCTURE_HEADER_FORMAT frag1;
}
__midl_frag12_t;
extern const __midl_frag12_t __midl_frag12;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag5_t;
extern const __midl_frag5_t __midl_frag5;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag2_t;
extern const __midl_frag2_t __midl_frag2;

typedef 
NDR64_FORMAT_UINT32
__midl_frag1_t;
extern const __midl_frag1_t __midl_frag1;

static const __midl_frag229_t __midl_frag229 =
0x5    /* FC64_INT32 */;

static const __midl_frag227_t __midl_frag227 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag229
};

static const __midl_frag226_t __midl_frag226 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag225_t __midl_frag225 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag226
};

static const __midl_frag224_t __midl_frag224 =
{ 
/* UpdateFirmware */
    { 
    /* UpdateFirmware */      /* procedure UpdateFirmware */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 32 /* 0x20 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 3 /* 0x3 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* FirmwareFileName */      /* parameter FirmwareFileName */
        &__midl_frag225,
        { 
        /* FirmwareFileName */
            1,
            1,
            0,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag229,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag229,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    }
};

static const __midl_frag216_t __midl_frag216 =
{ 
/* CompareFirmwareVersion */
    { 
    /* CompareFirmwareVersion */      /* procedure CompareFirmwareVersion */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 40 /* 0x28 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 72 /* 0x48 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 4 /* 0x4 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* FirmwareFileName */      /* parameter FirmwareFileName */
        &__midl_frag225,
        { 
        /* FirmwareFileName */
            1,
            1,
            0,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pResult */      /* parameter pResult */
        &__midl_frag229,
        { 
        /* pResult */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag229,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag229,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        32 /* 0x20 */,   /* Stack offset */
    }
};

static const __midl_frag214_t __midl_frag214 =
0x4    /* FC64_INT16 */;

static const __midl_frag213_t __midl_frag213 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag214
};

static const __midl_frag212_t __midl_frag212 =
{ 
/* get_CapUpdateFirmware */
    { 
    /* get_CapUpdateFirmware */      /* procedure get_CapUpdateFirmware */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapUpdateFirmware */      /* parameter pCapUpdateFirmware */
        &__midl_frag214,
        { 
        /* pCapUpdateFirmware */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag229,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag211_t __midl_frag211 =
0x5    /* FC64_INT32 */;

static const __midl_frag210_t __midl_frag210 =
0x4    /* FC64_INT16 */;

static const __midl_frag209_t __midl_frag209 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag210
};

static const __midl_frag208_t __midl_frag208 =
{ 
/* get_CapCompareFirmwareVersion */
    { 
    /* get_CapCompareFirmwareVersion */      /* procedure get_CapCompareFirmwareVersion */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapCompareFirmwareVersion */      /* parameter pCapCompareFirmwareVersion */
        &__midl_frag210,
        { 
        /* pCapCompareFirmwareVersion */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag211,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag207_t __midl_frag207 =
0x5    /* FC64_INT32 */;

static const __midl_frag205_t __midl_frag205 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag207
};

static const __midl_frag204_t __midl_frag204 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag203_t __midl_frag203 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag204
};

static const __midl_frag202_t __midl_frag202 =
{ 
/* UpdateStatistics */
    { 
    /* UpdateStatistics */      /* procedure UpdateStatistics */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 32 /* 0x20 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 3 /* 0x3 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* StatisticsBuffer */      /* parameter StatisticsBuffer */
        &__midl_frag203,
        { 
        /* StatisticsBuffer */
            1,
            1,
            0,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag207,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag207,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    }
};

static const __midl_frag198_t __midl_frag198 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag197_t __midl_frag197 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag198
};

static const __midl_frag196_t __midl_frag196 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag197
};

static const __midl_frag195_t __midl_frag195 =
{ 
/* RetrieveStatistics */
    { 
    /* RetrieveStatistics */      /* procedure RetrieveStatistics */
        (NDR64_UINT32) 7209283 /* 0x6e0143 */,    /* auto handle */ /* IsIntrepreted, [object], ServerMustSize, ClientMustSize, HasReturn, ServerCorrelation, ClientCorrelation */
        (NDR64_UINT32) 32 /* 0x20 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 3 /* 0x3 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pStatisticsBuffer */      /* parameter pStatisticsBuffer */
        &__midl_frag197,
        { 
        /* pStatisticsBuffer */
            1,
            1,
            0,
            1,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], [out], SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag207,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag207,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    }
};

static const __midl_frag187_t __midl_frag187 =
0x4    /* FC64_INT16 */;

static const __midl_frag186_t __midl_frag186 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag187
};

static const __midl_frag185_t __midl_frag185 =
{ 
/* get_CapUpdateStatistics */
    { 
    /* get_CapUpdateStatistics */      /* procedure get_CapUpdateStatistics */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapUpdateStatistics */      /* parameter pCapUpdateStatistics */
        &__midl_frag187,
        { 
        /* pCapUpdateStatistics */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag207,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag184_t __midl_frag184 =
0x5    /* FC64_INT32 */;

static const __midl_frag183_t __midl_frag183 =
0x4    /* FC64_INT16 */;

static const __midl_frag182_t __midl_frag182 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag183
};

static const __midl_frag181_t __midl_frag181 =
{ 
/* get_CapStatisticsReporting */
    { 
    /* get_CapStatisticsReporting */      /* procedure get_CapStatisticsReporting */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapStatisticsReporting */      /* parameter pCapStatisticsReporting */
        &__midl_frag183,
        { 
        /* pCapStatisticsReporting */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag184,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag180_t __midl_frag180 =
0x5    /* FC64_INT32 */;

static const __midl_frag179_t __midl_frag179 =
0x4    /* FC64_INT16 */;

static const __midl_frag178_t __midl_frag178 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag179
};

static const __midl_frag177_t __midl_frag177 =
{ 
/* get_CapStatusMultiDrawerDetect */
    { 
    /* get_CapStatusMultiDrawerDetect */      /* procedure get_CapStatusMultiDrawerDetect */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapStatusMultiDrawerDetect */      /* parameter pCapStatusMultiDrawerDetect */
        &__midl_frag179,
        { 
        /* pCapStatusMultiDrawerDetect */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag180,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag176_t __midl_frag176 =
0x5    /* FC64_INT32 */;

static const __midl_frag174_t __midl_frag174 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag176
};

static const __midl_frag173_t __midl_frag173 =
{ 
/* get_PowerState */
    { 
    /* get_PowerState */      /* procedure get_PowerState */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pPowerState */      /* parameter pPowerState */
        &__midl_frag176,
        { 
        /* pPowerState */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag176,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag172_t __midl_frag172 =
0x5    /* FC64_INT32 */;

static const __midl_frag170_t __midl_frag170 =
{ 
/* put_PowerNotify */
    { 
    /* put_PowerNotify */      /* procedure put_PowerNotify */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* PowerNotify */      /* parameter PowerNotify */
        &__midl_frag172,
        { 
        /* PowerNotify */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag172,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag167_t __midl_frag167 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag172
};

static const __midl_frag166_t __midl_frag166 =
{ 
/* get_PowerNotify */
    { 
    /* get_PowerNotify */      /* procedure get_PowerNotify */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pPowerNotify */      /* parameter pPowerNotify */
        &__midl_frag172,
        { 
        /* pPowerNotify */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag172,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag147_t __midl_frag147 =
{ 
/* WaitForDrawerClose */
    { 
    /* WaitForDrawerClose */      /* procedure WaitForDrawerClose */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 56 /* 0x38 */ ,  /* Stack size */
        (NDR64_UINT32) 32 /* 0x20 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 6 /* 0x6 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* BeepTimeout */      /* parameter BeepTimeout */
        &__midl_frag172,
        { 
        /* BeepTimeout */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* BeepFrequency */      /* parameter BeepFrequency */
        &__midl_frag172,
        { 
        /* BeepFrequency */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* BeepDuration */      /* parameter BeepDuration */
        &__midl_frag172,
        { 
        /* BeepDuration */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* BeepDelay */      /* parameter BeepDelay */
        &__midl_frag172,
        { 
        /* BeepDelay */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        32 /* 0x20 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag172,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        40 /* 0x28 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag172,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        48 /* 0x30 */,   /* Stack offset */
    }
};

static const __midl_frag141_t __midl_frag141 =
0x4    /* FC64_INT16 */;

static const __midl_frag140_t __midl_frag140 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag141
};

static const __midl_frag139_t __midl_frag139 =
{ 
/* get_DrawerOpened */
    { 
    /* get_DrawerOpened */      /* procedure get_DrawerOpened */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pDrawerOpened */      /* parameter pDrawerOpened */
        &__midl_frag141,
        { 
        /* pDrawerOpened */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag172,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag138_t __midl_frag138 =
0x5    /* FC64_INT32 */;

static const __midl_frag137_t __midl_frag137 =
0x4    /* FC64_INT16 */;

static const __midl_frag136_t __midl_frag136 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag137
};

static const __midl_frag135_t __midl_frag135 =
{ 
/* get_CapStatus */
    { 
    /* get_CapStatus */      /* procedure get_CapStatus */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pCapStatus */      /* parameter pCapStatus */
        &__midl_frag137,
        { 
        /* pCapStatus */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag138,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag134_t __midl_frag134 =
0x5    /* FC64_INT32 */;

static const __midl_frag132_t __midl_frag132 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag134
};

static const __midl_frag131_t __midl_frag131 =
{ 
/* ReleaseDevice */
    { 
    /* ReleaseDevice */      /* procedure ReleaseDevice */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag134,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag134,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag130_t __midl_frag130 =
0x5    /* FC64_INT32 */;

static const __midl_frag128_t __midl_frag128 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag130
};

static const __midl_frag127_t __midl_frag127 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag126_t __midl_frag126 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag127
};

static const __midl_frag125_t __midl_frag125 =
{ 
/* Open */
    { 
    /* Open */      /* procedure Open */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 32 /* 0x20 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 3 /* 0x3 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* DeviceName */      /* parameter DeviceName */
        &__midl_frag126,
        { 
        /* DeviceName */
            1,
            1,
            0,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag130,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    }
};

static const __midl_frag121_t __midl_frag121 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag120_t __midl_frag120 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag121
};

static const __midl_frag119_t __midl_frag119 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag120
};

static const __midl_frag117_t __midl_frag117 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 8 /* 0x8 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag130
};

static const __midl_frag115_t __midl_frag115 =
{ 
/* DirectIO */
    { 
    /* DirectIO */      /* procedure DirectIO */
        (NDR64_UINT32) 7209283 /* 0x6e0143 */,    /* auto handle */ /* IsIntrepreted, [object], ServerMustSize, ClientMustSize, HasReturn, ServerCorrelation, ClientCorrelation */
        (NDR64_UINT32) 48 /* 0x30 */ ,  /* Stack size */
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT32) 72 /* 0x48 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 5 /* 0x5 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Command */      /* parameter Command */
        &__midl_frag130,
        { 
        /* Command */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pData */      /* parameter pData */
        &__midl_frag130,
        { 
        /* pData */
            0,
            0,
            0,
            1,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], [out], Basetype, SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* pString */      /* parameter pString */
        &__midl_frag120,
        { 
        /* pString */
            1,
            1,
            0,
            1,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], [out], SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag130,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        32 /* 0x20 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        40 /* 0x28 */,   /* Stack offset */
    }
};

static const __midl_frag111_t __midl_frag111 =
{ 
/* Close */
    { 
    /* Close */      /* procedure Close */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag130,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag106_t __midl_frag106 =
{ 
/* ClaimDevice */
    { 
    /* ClaimDevice */      /* procedure ClaimDevice */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 32 /* 0x20 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 3 /* 0x3 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Timeout */      /* parameter Timeout */
        &__midl_frag130,
        { 
        /* Timeout */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag130,
        { 
        /* pRC */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    }
};

static const __midl_frag97_t __midl_frag97 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 4 /* 0x4 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag120
};

static const __midl_frag96_t __midl_frag96 =
{ 
/* get_DeviceName */
    { 
    /* get_DeviceName */      /* procedure get_DeviceName */
        (NDR64_UINT32) 4849987 /* 0x4a0143 */,    /* auto handle */ /* IsIntrepreted, [object], ServerMustSize, HasReturn, ClientCorrelation */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pDeviceName */      /* parameter pDeviceName */
        &__midl_frag120,
        { 
        /* pDeviceName */
            1,
            1,
            0,
            0,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* MustSize, MustFree, [out], SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag59_t __midl_frag59 =
0x4    /* FC64_INT16 */;

static const __midl_frag58_t __midl_frag58 =
{ 
/* put_FreezeEvents */
    { 
    /* put_FreezeEvents */      /* procedure put_FreezeEvents */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 6 /* 0x6 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* FreezeEvents */      /* parameter FreezeEvents */
        &__midl_frag59,
        { 
        /* FreezeEvents */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag55_t __midl_frag55 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag59
};

static const __midl_frag54_t __midl_frag54 =
{ 
/* get_FreezeEvents */
    { 
    /* get_FreezeEvents */      /* procedure get_FreezeEvents */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 38 /* 0x26 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* pFreezeEvents */      /* parameter pFreezeEvents */
        &__midl_frag59,
        { 
        /* pFreezeEvents */
            0,
            0,
            0,
            0,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            1
        },    /* [out], Basetype, SimpleRef, UseCache */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag35_t __midl_frag35 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag130
};

static const __midl_frag27_t __midl_frag27 =
{ 
/* SOStatusUpdate */
    { 
    /* SOStatusUpdate */      /* procedure SOStatusUpdate */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Data */      /* parameter Data */
        &__midl_frag130,
        { 
        /* Data */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag17_t __midl_frag17 =
{ 
/* SOErrorDummy */
    { 
    /* SOErrorDummy */      /* procedure SOErrorDummy */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 48 /* 0x30 */ ,  /* Stack size */
        (NDR64_UINT32) 56 /* 0x38 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 5 /* 0x5 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* ResultCode */      /* parameter ResultCode */
        &__midl_frag130,
        { 
        /* ResultCode */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* ResultCodeExtended */      /* parameter ResultCodeExtended */
        &__midl_frag130,
        { 
        /* ResultCodeExtended */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* ErrorLocus */      /* parameter ErrorLocus */
        &__midl_frag130,
        { 
        /* ErrorLocus */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* pErrorResponse */      /* parameter pErrorResponse */
        &__midl_frag130,
        { 
        /* pErrorResponse */
            0,
            0,
            0,
            1,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], [out], Basetype, SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        32 /* 0x20 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        40 /* 0x28 */,   /* Stack offset */
    }
};

static const __midl_frag14_t __midl_frag14 =
{ 
/*  */
    (NDR64_UINT32) 1 /* 0x1 */,
    { 
    /* struct _NDR64_EXPR_VAR */
        0x3,    /* FC_EXPR_VAR */
        0x6,    /* FC64_UINT32 */
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT32) 4 /* 0x4 */
    }
};

static const __midl_frag13_t __midl_frag13 =
{ 
/*  */
    { 
    /* struct _NDR64_CONF_ARRAY_HEADER_FORMAT */
        0x41,    /* FC64_CONF_ARRAY */
        (NDR64_UINT8) 1 /* 0x1 */,
        { 
        /* struct _NDR64_CONF_ARRAY_HEADER_FORMAT */
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
        },
        (NDR64_UINT8) 0 /* 0x0 */,
        (NDR64_UINT32) 2 /* 0x2 */,
        &__midl_frag14
    },
    { 
    /* struct _NDR64_ARRAY_ELEMENT_INFO */
        (NDR64_UINT32) 2 /* 0x2 */,
        &__midl_frag59
    }
};

static const __midl_frag12_t __midl_frag12 =
{ 
/* FLAGGED_WORD_BLOB */
    { 
    /* FLAGGED_WORD_BLOB */
        0x32,    /* FC64_CONF_STRUCT */
        (NDR64_UINT8) 3 /* 0x3 */,
        { 
        /* FLAGGED_WORD_BLOB */
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0
        },
        (NDR64_UINT8) 0 /* 0x0 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        &__midl_frag13
    }
};

static const __midl_frag5_t __midl_frag5 =
{ 
/* SODirectIO */
    { 
    /* SODirectIO */      /* procedure SODirectIO */
        (NDR64_UINT32) 7209283 /* 0x6e0143 */,    /* auto handle */ /* IsIntrepreted, [object], ServerMustSize, ClientMustSize, HasReturn, ServerCorrelation, ClientCorrelation */
        (NDR64_UINT32) 40 /* 0x28 */ ,  /* Stack size */
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 4 /* 0x4 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* EventNumber */      /* parameter EventNumber */
        &__midl_frag130,
        { 
        /* EventNumber */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* pData */      /* parameter pData */
        &__midl_frag130,
        { 
        /* pData */
            0,
            0,
            0,
            1,
            1,
            0,
            1,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], [out], Basetype, SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* pString */      /* parameter pString */
        &__midl_frag120,
        { 
        /* pString */
            1,
            1,
            0,
            1,
            1,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* MustSize, MustFree, [in], [out], SimpleRef */
        (NDR64_UINT16) 0 /* 0x0 */,
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        32 /* 0x20 */,   /* Stack offset */
    }
};

static const __midl_frag2_t __midl_frag2 =
{ 
/* SODataDummy */
    { 
    /* SODataDummy */      /* procedure SODataDummy */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Status */      /* parameter Status */
        &__midl_frag130,
        { 
        /* Status */
            0,
            0,
            0,
            1,
            0,
            0,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [in], Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        8 /* 0x8 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag130,
        { 
        /* HRESULT */
            0,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            0,
            0,
            0,
            (NDR64_UINT16) 0 /* 0x0 */,
            0
        },    /* [out], IsReturn, Basetype, ByValue */
        (NDR64_UINT16) 0 /* 0x0 */,
        16 /* 0x10 */,   /* Stack offset */
    }
};

static const __midl_frag1_t __midl_frag1 =
(NDR64_UINT32) 0 /* 0x0 */;
#ifdef __cplusplus
}
#endif


#include "poppack.h"


XFG_TRAMPOLINES64(BSTR)

static const USER_MARSHAL_ROUTINE_QUADRUPLE NDR64_UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ] = 
        {
            
            {
            (USER_MARSHAL_SIZING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserSize64)
            ,(USER_MARSHAL_MARSHALLING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserMarshal64)
            ,(USER_MARSHAL_UNMARSHALLING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserUnmarshal64)
            ,(USER_MARSHAL_FREEING_ROUTINE)XFG_TRAMPOLINE_FPTR(BSTR_UserFree64)
            
            }
            

        };



/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IDispatch, ver. 0.0,
   GUID={0x00020400,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: IOPOSCashDrawer_1_5, ver. 0.0,
   GUID={0xCCB91041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSCashDrawer_1_5_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag27,
    &__midl_frag27,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag54,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag96,
    &__midl_frag106,
    &__midl_frag106,
    &__midl_frag111,
    &__midl_frag115,
    &__midl_frag125,
    &__midl_frag131,
    &__midl_frag135,
    &__midl_frag139,
    &__midl_frag166,
    &__midl_frag147,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag166,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag173,
    &__midl_frag177
    };


static const MIDL_SYNTAX_INFO IOPOSCashDrawer_1_5_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_5_FormatStringOffsetTable[-3],
    CashDrawer__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSCashDrawer_1_5_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_5_ProxyInfo =
    {
    &Object_StubDesc,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_5_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_5_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSCashDrawer_1_5_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSCashDrawer_1_5_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_5_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(46) _IOPOSCashDrawer_1_5ProxyVtbl = 
{
    &IOPOSCashDrawer_1_5_ProxyInfo,
    &IID_IOPOSCashDrawer_1_5,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOErrorDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatus */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DrawerOpened */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::OpenDrawer */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::WaitForDrawerClose */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerState */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatusMultiDrawerDetect */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSCashDrawer_1_5_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSCashDrawer_1_5StubVtbl =
{
    &IID_IOPOSCashDrawer_1_5,
    &IOPOSCashDrawer_1_5_ServerInfo,
    46,
    &IOPOSCashDrawer_1_5_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSCashDrawer_1_8, ver. 0.0,
   GUID={0xCCB92041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSCashDrawer_1_8_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag27,
    &__midl_frag27,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag54,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag96,
    &__midl_frag106,
    &__midl_frag106,
    &__midl_frag111,
    &__midl_frag115,
    &__midl_frag125,
    &__midl_frag131,
    &__midl_frag135,
    &__midl_frag139,
    &__midl_frag166,
    &__midl_frag147,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag166,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag173,
    &__midl_frag177,
    &__midl_frag181,
    &__midl_frag185,
    &__midl_frag202,
    &__midl_frag195,
    &__midl_frag202
    };


static const MIDL_SYNTAX_INFO IOPOSCashDrawer_1_8_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_8_FormatStringOffsetTable[-3],
    CashDrawer__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSCashDrawer_1_8_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_8_ProxyInfo =
    {
    &Object_StubDesc,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_8_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_8_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSCashDrawer_1_8_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSCashDrawer_1_8_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_8_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(51) _IOPOSCashDrawer_1_8ProxyVtbl = 
{
    &IOPOSCashDrawer_1_8_ProxyInfo,
    &IID_IOPOSCashDrawer_1_8,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOErrorDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatus */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DrawerOpened */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::OpenDrawer */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::WaitForDrawerClose */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerState */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatusMultiDrawerDetect */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::get_CapStatisticsReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::get_CapUpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::ResetStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::RetrieveStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::UpdateStatistics */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSCashDrawer_1_8_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSCashDrawer_1_8StubVtbl =
{
    &IID_IOPOSCashDrawer_1_8,
    &IOPOSCashDrawer_1_8_ServerInfo,
    51,
    &IOPOSCashDrawer_1_8_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSCashDrawer_1_9, ver. 0.0,
   GUID={0xCCB93041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSCashDrawer_1_9_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag27,
    &__midl_frag27,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag54,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag96,
    &__midl_frag106,
    &__midl_frag106,
    &__midl_frag111,
    &__midl_frag115,
    &__midl_frag125,
    &__midl_frag131,
    &__midl_frag135,
    &__midl_frag139,
    &__midl_frag166,
    &__midl_frag147,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag166,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag173,
    &__midl_frag177,
    &__midl_frag181,
    &__midl_frag185,
    &__midl_frag202,
    &__midl_frag195,
    &__midl_frag202,
    &__midl_frag208,
    &__midl_frag212,
    &__midl_frag216,
    &__midl_frag224
    };


static const MIDL_SYNTAX_INFO IOPOSCashDrawer_1_9_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_9_FormatStringOffsetTable[-3],
    CashDrawer__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSCashDrawer_1_9_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_1_9_ProxyInfo =
    {
    &Object_StubDesc,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_1_9_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_9_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSCashDrawer_1_9_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSCashDrawer_1_9_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_1_9_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(55) _IOPOSCashDrawer_1_9ProxyVtbl = 
{
    &IOPOSCashDrawer_1_9_ProxyInfo,
    &IID_IOPOSCashDrawer_1_9,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOErrorDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatus */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_DrawerOpened */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::OpenDrawer */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::WaitForDrawerClose */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_PowerState */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_5::get_CapStatusMultiDrawerDetect */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::get_CapStatisticsReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::get_CapUpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::ResetStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::RetrieveStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_8::UpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_9::get_CapCompareFirmwareVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_9::get_CapUpdateFirmware */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_9::CompareFirmwareVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSCashDrawer_1_9::UpdateFirmware */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSCashDrawer_1_9_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSCashDrawer_1_9StubVtbl =
{
    &IID_IOPOSCashDrawer_1_9,
    &IOPOSCashDrawer_1_9_ServerInfo,
    55,
    &IOPOSCashDrawer_1_9_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSCashDrawer, ver. 0.0,
   GUID={0xCCB94041,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSCashDrawer_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag27,
    &__midl_frag27,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag54,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag54,
    &__midl_frag58,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag111,
    &__midl_frag96,
    &__midl_frag96,
    &__midl_frag106,
    &__midl_frag106,
    &__midl_frag111,
    &__midl_frag115,
    &__midl_frag125,
    &__midl_frag131,
    &__midl_frag135,
    &__midl_frag139,
    &__midl_frag166,
    &__midl_frag147,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag166,
    &__midl_frag166,
    &__midl_frag170,
    &__midl_frag173,
    &__midl_frag177,
    &__midl_frag181,
    &__midl_frag185,
    &__midl_frag202,
    &__midl_frag195,
    &__midl_frag202,
    &__midl_frag208,
    &__midl_frag212,
    &__midl_frag216,
    &__midl_frag224,
    0
    };


static const MIDL_SYNTAX_INFO IOPOSCashDrawer_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_FormatStringOffsetTable[-3],
    CashDrawer__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSCashDrawer_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSCashDrawer_ProxyInfo =
    {
    &Object_StubDesc,
    CashDrawer__MIDL_ProcFormatString.Format,
    &IOPOSCashDrawer_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSCashDrawer_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    CashDrawer__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSCashDrawer_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSCashDrawer_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(55) _IOPOSCashDrawerProxyVtbl = 
{
    0,
    &IID_IOPOSCashDrawer,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SODataDummy */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SODirectIO */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SOErrorDummy */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SOOutputCompleteDummy */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SOStatusUpdate */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::SOProcessID */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_OpenResult */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_CheckHealthText */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_Claimed */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_DeviceEnabled */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::put_DeviceEnabled */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_FreezeEvents */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::put_FreezeEvents */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ResultCode */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ResultCodeExtended */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_State */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ControlObjectDescription */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ControlObjectVersion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ServiceObjectDescription */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_ServiceObjectVersion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_DeviceDescription */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_DeviceName */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::CheckHealth */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::ClaimDevice */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::Close */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::DirectIO */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::Open */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::ReleaseDevice */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_CapStatus */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_DrawerOpened */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::OpenDrawer */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::WaitForDrawerClose */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_BinaryConversion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::put_BinaryConversion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_CapPowerReporting */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_PowerNotify */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::put_PowerNotify */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_PowerState */ ,
    0 /* forced delegation IOPOSCashDrawer_1_5::get_CapStatusMultiDrawerDetect */ ,
    0 /* forced delegation IOPOSCashDrawer_1_8::get_CapStatisticsReporting */ ,
    0 /* forced delegation IOPOSCashDrawer_1_8::get_CapUpdateStatistics */ ,
    0 /* forced delegation IOPOSCashDrawer_1_8::ResetStatistics */ ,
    0 /* forced delegation IOPOSCashDrawer_1_8::RetrieveStatistics */ ,
    0 /* forced delegation IOPOSCashDrawer_1_8::UpdateStatistics */ ,
    0 /* forced delegation IOPOSCashDrawer_1_9::get_CapCompareFirmwareVersion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_9::get_CapUpdateFirmware */ ,
    0 /* forced delegation IOPOSCashDrawer_1_9::CompareFirmwareVersion */ ,
    0 /* forced delegation IOPOSCashDrawer_1_9::UpdateFirmware */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSCashDrawer_table[] =
{
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    STUB_FORWARDING_FUNCTION,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSCashDrawerStubVtbl =
{
    &IID_IOPOSCashDrawer,
    &IOPOSCashDrawer_ServerInfo,
    55,
    &IOPOSCashDrawer_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};

#ifdef __cplusplus
namespace {
#endif
static const MIDL_STUB_DESC Object_StubDesc = 
    {
    0,
    NdrOleAllocate,
    NdrOleFree,
    0,
    0,
    0,
    0,
    0,
    CashDrawer__MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x60001, /* Ndr library version */
    0,
    0x8010274, /* MIDL Version 8.1.628 */
    0,
    UserMarshalRoutines,
    0,  /* notify & notify_flag routine table */
    0x2000001, /* MIDL flag */
    0, /* cs routines */
    0,   /* proxy/server info */
    0
    };
#ifdef __cplusplus
}
#endif

const CInterfaceProxyVtbl * const _CashDrawer_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_IOPOSCashDrawer_1_5ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSCashDrawer_1_8ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSCashDrawer_1_9ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSCashDrawerProxyVtbl,
    0
};

const CInterfaceStubVtbl * const _CashDrawer_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_IOPOSCashDrawer_1_5StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSCashDrawer_1_8StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSCashDrawer_1_9StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSCashDrawerStubVtbl,
    0
};

PCInterfaceName const _CashDrawer_InterfaceNamesList[] = 
{
    "IOPOSCashDrawer_1_5",
    "IOPOSCashDrawer_1_8",
    "IOPOSCashDrawer_1_9",
    "IOPOSCashDrawer",
    0
};

const IID *  const _CashDrawer_BaseIIDList[] = 
{
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    0
};


#define _CashDrawer_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _CashDrawer, pIID, n)

int __stdcall _CashDrawer_IID_Lookup( const IID * pIID, int * pIndex )
{
    IID_BS_LOOKUP_SETUP

    IID_BS_LOOKUP_INITIAL_TEST( _CashDrawer, 4, 2 )
    IID_BS_LOOKUP_NEXT_TEST( _CashDrawer, 1 )
    IID_BS_LOOKUP_RETURN_RESULT( _CashDrawer, 4, *pIndex )
    
}

EXTERN_C const ExtendedProxyFileInfo CashDrawer_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _CashDrawer_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _CashDrawer_StubVtblList,
    (const PCInterfaceName * ) & _CashDrawer_InterfaceNamesList,
    (const IID ** ) & _CashDrawer_BaseIIDList,
    & _CashDrawer_IID_Lookup, 
    4,
    2,
    0, /* table of [async_uuid] interfaces */
    0, /* Filler1 */
    0, /* Filler2 */
    0  /* Filler3 */
};
#if _MSC_VER >= 1200
#pragma warning(pop)
#endif


#endif /* defined(_M_AMD64)*/

