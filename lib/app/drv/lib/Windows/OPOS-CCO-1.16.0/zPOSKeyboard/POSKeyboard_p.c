

/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for POSKeyboard.idl:
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


#include "POSKeyboard.h"

#define TYPE_FORMAT_STRING_SIZE   83                                
#define PROC_FORMAT_STRING_SIZE   2155                              
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   1            

typedef struct _POSKeyboard_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } POSKeyboard_MIDL_TYPE_FORMAT_STRING;

typedef struct _POSKeyboard_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } POSKeyboard_MIDL_PROC_FORMAT_STRING;

typedef struct _POSKeyboard_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } POSKeyboard_MIDL_EXPR_FORMAT_STRING;


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



extern const POSKeyboard_MIDL_TYPE_FORMAT_STRING POSKeyboard__MIDL_TypeFormatString;
extern const POSKeyboard_MIDL_PROC_FORMAT_STRING POSKeyboard__MIDL_ProcFormatString;
extern const POSKeyboard_MIDL_EXPR_FORMAT_STRING POSKeyboard__MIDL_ExprFormatString;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_5_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_5_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_8_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_8_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_9_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_9_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSKeyboard_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_ProxyInfo;


extern const USER_MARSHAL_ROUTINE_QUADRUPLE NDR64_UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif

static const POSKeyboard_MIDL_PROC_FORMAT_STRING POSKeyboard__MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure SOData */

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

	/* Procedure SOError */

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

	/* Procedure get_DataEventEnabled */

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

	/* Parameter pDataEventEnabled */

/* 398 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 400 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 402 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 404 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 406 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_DataEventEnabled */

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

	/* Parameter DataEventEnabled */

/* 436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 438 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 440 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 442 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 444 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceEnabled */

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

	/* Parameter pDeviceEnabled */

/* 474 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 476 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 478 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 480 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 482 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 484 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_DeviceEnabled */

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

	/* Parameter DeviceEnabled */

/* 512 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 514 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 516 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 518 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 520 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 522 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_FreezeEvents */

/* 524 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 526 */	NdrFcLong( 0x0 ),	/* 0 */
/* 530 */	NdrFcShort( 0x14 ),	/* 20 */
/* 532 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 534 */	NdrFcShort( 0x0 ),	/* 0 */
/* 536 */	NdrFcShort( 0x22 ),	/* 34 */
/* 538 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 540 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 542 */	NdrFcShort( 0x0 ),	/* 0 */
/* 544 */	NdrFcShort( 0x0 ),	/* 0 */
/* 546 */	NdrFcShort( 0x0 ),	/* 0 */
/* 548 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pFreezeEvents */

/* 550 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 552 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 554 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 556 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 558 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_FreezeEvents */

/* 562 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 564 */	NdrFcLong( 0x0 ),	/* 0 */
/* 568 */	NdrFcShort( 0x15 ),	/* 21 */
/* 570 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 572 */	NdrFcShort( 0x6 ),	/* 6 */
/* 574 */	NdrFcShort( 0x8 ),	/* 8 */
/* 576 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 578 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 580 */	NdrFcShort( 0x0 ),	/* 0 */
/* 582 */	NdrFcShort( 0x0 ),	/* 0 */
/* 584 */	NdrFcShort( 0x0 ),	/* 0 */
/* 586 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FreezeEvents */

/* 588 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 590 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 592 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 596 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCode */

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

	/* Parameter pResultCode */

/* 626 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 632 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 636 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCodeExtended */

/* 638 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 640 */	NdrFcLong( 0x0 ),	/* 0 */
/* 644 */	NdrFcShort( 0x17 ),	/* 23 */
/* 646 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 650 */	NdrFcShort( 0x24 ),	/* 36 */
/* 652 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 654 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 656 */	NdrFcShort( 0x0 ),	/* 0 */
/* 658 */	NdrFcShort( 0x0 ),	/* 0 */
/* 660 */	NdrFcShort( 0x0 ),	/* 0 */
/* 662 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pResultCodeExtended */

/* 664 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 666 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 668 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 670 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 672 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_State */

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

	/* Parameter pState */

/* 702 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 704 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 708 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 710 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectDescription */

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

	/* Parameter pControlObjectDescription */

/* 740 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 742 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 744 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 746 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 748 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 750 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectVersion */

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

	/* Parameter pControlObjectVersion */

/* 778 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 780 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 782 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 784 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 786 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectDescription */

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

	/* Parameter pServiceObjectDescription */

/* 816 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 818 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 820 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 822 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 824 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 826 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectVersion */

/* 828 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 830 */	NdrFcLong( 0x0 ),	/* 0 */
/* 834 */	NdrFcShort( 0x1c ),	/* 28 */
/* 836 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 838 */	NdrFcShort( 0x0 ),	/* 0 */
/* 840 */	NdrFcShort( 0x24 ),	/* 36 */
/* 842 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 844 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 846 */	NdrFcShort( 0x0 ),	/* 0 */
/* 848 */	NdrFcShort( 0x0 ),	/* 0 */
/* 850 */	NdrFcShort( 0x0 ),	/* 0 */
/* 852 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pServiceObjectVersion */

/* 854 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 856 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 858 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 860 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 862 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 864 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceDescription */

/* 866 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 868 */	NdrFcLong( 0x0 ),	/* 0 */
/* 872 */	NdrFcShort( 0x1d ),	/* 29 */
/* 874 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 876 */	NdrFcShort( 0x0 ),	/* 0 */
/* 878 */	NdrFcShort( 0x8 ),	/* 8 */
/* 880 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 882 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 884 */	NdrFcShort( 0x1 ),	/* 1 */
/* 886 */	NdrFcShort( 0x0 ),	/* 0 */
/* 888 */	NdrFcShort( 0x0 ),	/* 0 */
/* 890 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDeviceDescription */

/* 892 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 894 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 896 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 898 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 900 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceName */

/* 904 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 906 */	NdrFcLong( 0x0 ),	/* 0 */
/* 910 */	NdrFcShort( 0x1e ),	/* 30 */
/* 912 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 914 */	NdrFcShort( 0x0 ),	/* 0 */
/* 916 */	NdrFcShort( 0x8 ),	/* 8 */
/* 918 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 920 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 922 */	NdrFcShort( 0x1 ),	/* 1 */
/* 924 */	NdrFcShort( 0x0 ),	/* 0 */
/* 926 */	NdrFcShort( 0x0 ),	/* 0 */
/* 928 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDeviceName */

/* 930 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 932 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 934 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 936 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 938 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 940 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CheckHealth */

/* 942 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 944 */	NdrFcLong( 0x0 ),	/* 0 */
/* 948 */	NdrFcShort( 0x1f ),	/* 31 */
/* 950 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 952 */	NdrFcShort( 0x8 ),	/* 8 */
/* 954 */	NdrFcShort( 0x24 ),	/* 36 */
/* 956 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 958 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 960 */	NdrFcShort( 0x0 ),	/* 0 */
/* 962 */	NdrFcShort( 0x0 ),	/* 0 */
/* 964 */	NdrFcShort( 0x0 ),	/* 0 */
/* 966 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Level */

/* 968 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 970 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 972 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 974 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 976 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 978 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 980 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 982 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 984 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClaimDevice */

/* 986 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 988 */	NdrFcLong( 0x0 ),	/* 0 */
/* 992 */	NdrFcShort( 0x20 ),	/* 32 */
/* 994 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 996 */	NdrFcShort( 0x8 ),	/* 8 */
/* 998 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1000 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 1002 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1004 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1006 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1008 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1010 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Timeout */

/* 1012 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1014 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1016 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 1018 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1020 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1022 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1024 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1026 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1028 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClearInput */

/* 1030 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1032 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1036 */	NdrFcShort( 0x21 ),	/* 33 */
/* 1038 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1040 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1042 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1044 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1046 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1048 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1050 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1054 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1056 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1058 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1060 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1062 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1064 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1066 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Close */

/* 1068 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1070 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1074 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1076 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1080 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1082 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1084 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1086 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1088 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1092 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1094 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1096 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1098 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1100 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1102 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1104 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure DirectIO */

/* 1106 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1108 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1112 */	NdrFcShort( 0x23 ),	/* 35 */
/* 1114 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 1116 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1118 */	NdrFcShort( 0x40 ),	/* 64 */
/* 1120 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 1122 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 1124 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1126 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1130 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Command */

/* 1132 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1134 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pData */

/* 1138 */	NdrFcShort( 0x158 ),	/* Flags:  in, out, base type, simple ref, */
/* 1140 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pString */

/* 1144 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 1146 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1148 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 1150 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1152 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1154 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1156 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1158 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 1160 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Open */

/* 1162 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1164 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1168 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1170 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1172 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1174 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1176 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1178 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1180 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1182 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1184 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1186 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter DeviceName */

/* 1188 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1190 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1192 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1194 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1196 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1198 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1200 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1202 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ReleaseDevice */

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

	/* Procedure get_POSKeyData */

/* 1244 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1246 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1250 */	NdrFcShort( 0x26 ),	/* 38 */
/* 1252 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1254 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1256 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1258 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1260 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1262 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1264 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1266 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1268 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPOSKeyData */

/* 1270 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1272 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1274 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1276 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1278 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1280 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_AutoDisable */

/* 1282 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1284 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1288 */	NdrFcShort( 0x27 ),	/* 39 */
/* 1290 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1292 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1294 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1296 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1298 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1300 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1302 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1304 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1306 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pAutoDisable */

/* 1308 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1310 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1312 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1314 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1316 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1318 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_AutoDisable */

/* 1320 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1322 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1326 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1328 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1330 */	NdrFcShort( 0x6 ),	/* 6 */
/* 1332 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1334 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1336 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1338 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1340 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1342 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1344 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter AutoDisable */

/* 1346 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1348 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1350 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1352 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1354 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1356 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_BinaryConversion */

/* 1358 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1360 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1364 */	NdrFcShort( 0x29 ),	/* 41 */
/* 1366 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1368 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1370 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1372 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1374 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1376 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1378 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1380 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1382 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pBinaryConversion */

/* 1384 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1386 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1388 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1390 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1392 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1394 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_BinaryConversion */

/* 1396 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1398 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1402 */	NdrFcShort( 0x2a ),	/* 42 */
/* 1404 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1406 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1408 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1410 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1412 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1414 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1416 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1418 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1420 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter BinaryConversion */

/* 1422 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1424 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1426 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1428 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1430 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1432 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DataCount */

/* 1434 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1436 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1440 */	NdrFcShort( 0x2b ),	/* 43 */
/* 1442 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1444 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1446 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1448 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1450 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1452 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1454 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1456 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1458 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pDataCount */

/* 1460 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1462 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1464 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1466 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1468 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1470 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapKeyUp */

/* 1472 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1474 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1478 */	NdrFcShort( 0x2c ),	/* 44 */
/* 1480 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1484 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1486 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1488 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1490 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1492 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1494 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1496 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapKeyUp */

/* 1498 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1500 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1502 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1504 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1506 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1508 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_EventTypes */

/* 1510 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1512 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1516 */	NdrFcShort( 0x2d ),	/* 45 */
/* 1518 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1522 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1524 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1526 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1528 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1530 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1532 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1534 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pEventTypes */

/* 1536 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1538 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1540 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1542 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1544 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_EventTypes */

/* 1548 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1550 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1554 */	NdrFcShort( 0x2e ),	/* 46 */
/* 1556 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1558 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1560 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1562 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1564 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1566 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1570 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1572 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter EventTypes */

/* 1574 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1576 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1578 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1580 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1582 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1584 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_POSKeyEventType */

/* 1586 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1588 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1592 */	NdrFcShort( 0x2f ),	/* 47 */
/* 1594 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1596 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1598 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1600 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1602 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1604 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1606 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1610 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPOSKeyEventType */

/* 1612 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1614 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1616 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1618 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1620 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1622 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapPowerReporting */

/* 1624 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1626 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1630 */	NdrFcShort( 0x30 ),	/* 48 */
/* 1632 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1634 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1636 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1638 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1640 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1642 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1644 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1648 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapPowerReporting */

/* 1650 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1652 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1654 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1656 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1658 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerNotify */

/* 1662 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1664 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1668 */	NdrFcShort( 0x31 ),	/* 49 */
/* 1670 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1672 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1674 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1676 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1678 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1680 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1682 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1684 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1686 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerNotify */

/* 1688 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1690 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1692 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1694 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1696 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1698 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PowerNotify */

/* 1700 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1702 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1706 */	NdrFcShort( 0x32 ),	/* 50 */
/* 1708 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1710 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1712 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1714 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1716 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1718 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1720 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1722 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1724 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PowerNotify */

/* 1726 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1728 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1730 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1732 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1734 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1736 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerState */

/* 1738 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1740 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1744 */	NdrFcShort( 0x33 ),	/* 51 */
/* 1746 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1748 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1750 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1752 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1754 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1756 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1758 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1760 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1762 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerState */

/* 1764 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1766 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1768 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1770 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1772 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1774 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapStatisticsReporting */

/* 1776 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1778 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1782 */	NdrFcShort( 0x34 ),	/* 52 */
/* 1784 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1786 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1788 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1790 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1792 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1794 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1796 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1798 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1800 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapStatisticsReporting */

/* 1802 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1804 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1806 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1808 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1810 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1812 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateStatistics */

/* 1814 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1816 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1820 */	NdrFcShort( 0x35 ),	/* 53 */
/* 1822 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1824 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1826 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1828 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1830 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1832 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1834 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1836 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1838 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateStatistics */

/* 1840 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1842 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1844 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1846 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1848 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1850 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ResetStatistics */

/* 1852 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1854 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1858 */	NdrFcShort( 0x36 ),	/* 54 */
/* 1860 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1864 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1866 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1868 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1870 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1872 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1874 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1876 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 1878 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1880 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1882 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1884 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1886 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1888 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1890 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1892 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1894 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure RetrieveStatistics */

/* 1896 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1898 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1902 */	NdrFcShort( 0x37 ),	/* 55 */
/* 1904 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1906 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1908 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1910 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1912 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 1914 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1916 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1918 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1920 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pStatisticsBuffer */

/* 1922 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 1924 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1926 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 1928 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1930 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1932 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1934 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1936 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1938 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateStatistics */

/* 1940 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1942 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1946 */	NdrFcShort( 0x38 ),	/* 56 */
/* 1948 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1950 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1952 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1954 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1956 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1958 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1960 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1962 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1964 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 1966 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1968 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1970 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1972 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1974 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1976 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1978 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1980 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1982 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapCompareFirmwareVersion */

/* 1984 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1986 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1990 */	NdrFcShort( 0x39 ),	/* 57 */
/* 1992 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1994 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1996 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1998 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2000 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2004 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2006 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2008 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapCompareFirmwareVersion */

/* 2010 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2012 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2014 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2016 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2018 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2020 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateFirmware */

/* 2022 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2024 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2028 */	NdrFcShort( 0x3a ),	/* 58 */
/* 2030 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2032 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2034 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2036 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2038 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2040 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2042 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2044 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2046 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateFirmware */

/* 2048 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2050 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2052 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2054 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2056 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2058 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CompareFirmwareVersion */

/* 2060 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2062 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2066 */	NdrFcShort( 0x3b ),	/* 59 */
/* 2068 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 2070 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2072 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2074 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 2076 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 2078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2080 */	NdrFcShort( 0x1 ),	/* 1 */
/* 2082 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2084 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 2086 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 2088 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2090 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pResult */

/* 2092 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2094 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2096 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 2098 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2100 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2102 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2104 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2106 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 2108 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateFirmware */

/* 2110 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2112 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2116 */	NdrFcShort( 0x3c ),	/* 60 */
/* 2118 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 2120 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2122 */	NdrFcShort( 0x24 ),	/* 36 */
/* 2124 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 2126 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 2128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2130 */	NdrFcShort( 0x1 ),	/* 1 */
/* 2132 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2134 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 2136 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 2138 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2140 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 2142 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2144 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 2148 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2150 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2152 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const POSKeyboard_MIDL_TYPE_FORMAT_STRING POSKeyboard__MIDL_TypeFormatString =
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


/* Object interface: IOPOSPOSKeyboard_1_5, ver. 0.0,
   GUID={0xCCB91141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSKeyboard_1_5_FormatStringOffsetTable[] =
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
    904,
    942,
    986,
    1030,
    1068,
    1106,
    1162,
    1206,
    1244,
    1282,
    1320,
    1358,
    1396,
    1434,
    1472,
    1510,
    1548,
    1586,
    1624,
    1662,
    1700,
    1738
    };



/* Object interface: IOPOSPOSKeyboard_1_8, ver. 0.0,
   GUID={0xCCB92141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSKeyboard_1_8_FormatStringOffsetTable[] =
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
    904,
    942,
    986,
    1030,
    1068,
    1106,
    1162,
    1206,
    1244,
    1282,
    1320,
    1358,
    1396,
    1434,
    1472,
    1510,
    1548,
    1586,
    1624,
    1662,
    1700,
    1738,
    1776,
    1814,
    1852,
    1896,
    1940
    };



/* Object interface: IOPOSPOSKeyboard_1_9, ver. 0.0,
   GUID={0xCCB93141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSKeyboard_1_9_FormatStringOffsetTable[] =
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
    904,
    942,
    986,
    1030,
    1068,
    1106,
    1162,
    1206,
    1244,
    1282,
    1320,
    1358,
    1396,
    1434,
    1472,
    1510,
    1548,
    1586,
    1624,
    1662,
    1700,
    1738,
    1776,
    1814,
    1852,
    1896,
    1940,
    1984,
    2022,
    2060,
    2110
    };



/* Object interface: IOPOSPOSKeyboard, ver. 0.0,
   GUID={0xCCB94141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSKeyboard_FormatStringOffsetTable[] =
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
    904,
    942,
    986,
    1030,
    1068,
    1106,
    1162,
    1206,
    1244,
    1282,
    1320,
    1358,
    1396,
    1434,
    1472,
    1510,
    1548,
    1586,
    1624,
    1662,
    1700,
    1738,
    1776,
    1814,
    1852,
    1896,
    1940,
    1984,
    2022,
    2060,
    2110,
    0
    };



#endif /* defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for POSKeyboard.idl:
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
__midl_frag246_t;
extern const __midl_frag246_t __midl_frag246;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag244_t;
extern const __midl_frag244_t __midl_frag244;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag243_t;
extern const __midl_frag243_t __midl_frag243;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag242_t;
extern const __midl_frag242_t __midl_frag242;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag241_t;
extern const __midl_frag241_t __midl_frag241;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag233_t;
extern const __midl_frag233_t __midl_frag233;

typedef 
NDR64_FORMAT_CHAR
__midl_frag231_t;
extern const __midl_frag231_t __midl_frag231;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag230_t;
extern const __midl_frag230_t __midl_frag230;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag229_t;
extern const __midl_frag229_t __midl_frag229;

typedef 
NDR64_FORMAT_CHAR
__midl_frag228_t;
extern const __midl_frag228_t __midl_frag228;

typedef 
NDR64_FORMAT_CHAR
__midl_frag227_t;
extern const __midl_frag227_t __midl_frag227;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag226_t;
extern const __midl_frag226_t __midl_frag226;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag225_t;
extern const __midl_frag225_t __midl_frag225;

typedef 
NDR64_FORMAT_CHAR
__midl_frag224_t;
extern const __midl_frag224_t __midl_frag224;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag222_t;
extern const __midl_frag222_t __midl_frag222;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag221_t;
extern const __midl_frag221_t __midl_frag221;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag220_t;
extern const __midl_frag220_t __midl_frag220;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag219_t;
extern const __midl_frag219_t __midl_frag219;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag215_t;
extern const __midl_frag215_t __midl_frag215;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
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
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag212_t;
extern const __midl_frag212_t __midl_frag212;

typedef 
NDR64_FORMAT_CHAR
__midl_frag204_t;
extern const __midl_frag204_t __midl_frag204;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag203_t;
extern const __midl_frag203_t __midl_frag203;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag202_t;
extern const __midl_frag202_t __midl_frag202;

typedef 
NDR64_FORMAT_CHAR
__midl_frag201_t;
extern const __midl_frag201_t __midl_frag201;

typedef 
NDR64_FORMAT_CHAR
__midl_frag200_t;
extern const __midl_frag200_t __midl_frag200;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag199_t;
extern const __midl_frag199_t __midl_frag199;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag198_t;
extern const __midl_frag198_t __midl_frag198;

typedef 
NDR64_FORMAT_CHAR
__midl_frag197_t;
extern const __midl_frag197_t __midl_frag197;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag195_t;
extern const __midl_frag195_t __midl_frag195;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag194_t;
extern const __midl_frag194_t __midl_frag194;

typedef 
NDR64_FORMAT_CHAR
__midl_frag193_t;
extern const __midl_frag193_t __midl_frag193;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag191_t;
extern const __midl_frag191_t __midl_frag191;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag188_t;
extern const __midl_frag188_t __midl_frag188;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag187_t;
extern const __midl_frag187_t __midl_frag187;

typedef 
NDR64_FORMAT_CHAR
__midl_frag170_t;
extern const __midl_frag170_t __midl_frag170;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag169_t;
extern const __midl_frag169_t __midl_frag169;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag168_t;
extern const __midl_frag168_t __midl_frag168;

typedef 
NDR64_FORMAT_CHAR
__midl_frag167_t;
extern const __midl_frag167_t __midl_frag167;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag165_t;
extern const __midl_frag165_t __midl_frag165;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag164_t;
extern const __midl_frag164_t __midl_frag164;

typedef 
NDR64_FORMAT_CHAR
__midl_frag163_t;
extern const __midl_frag163_t __midl_frag163;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag161_t;
extern const __midl_frag161_t __midl_frag161;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag158_t;
extern const __midl_frag158_t __midl_frag158;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag157_t;
extern const __midl_frag157_t __midl_frag157;

typedef 
NDR64_FORMAT_CHAR
__midl_frag155_t;
extern const __midl_frag155_t __midl_frag155;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag154_t;
extern const __midl_frag154_t __midl_frag154;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag151_t;
extern const __midl_frag151_t __midl_frag151;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag150_t;
extern const __midl_frag150_t __midl_frag150;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag138_t;
extern const __midl_frag138_t __midl_frag138;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag137_t;
extern const __midl_frag137_t __midl_frag137;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag136_t;
extern const __midl_frag136_t __midl_frag136;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag132_t;
extern const __midl_frag132_t __midl_frag132;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag131_t;
extern const __midl_frag131_t __midl_frag131;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag130_t;
extern const __midl_frag130_t __midl_frag130;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag128_t;
extern const __midl_frag128_t __midl_frag128;

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
__midl_frag113_t;
extern const __midl_frag113_t __midl_frag113;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag104_t;
extern const __midl_frag104_t __midl_frag104;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag103_t;
extern const __midl_frag103_t __midl_frag103;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag73_t;
extern const __midl_frag73_t __midl_frag73;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag72_t;
extern const __midl_frag72_t __midl_frag72;

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

static const __midl_frag246_t __midl_frag246 =
0x5    /* FC64_INT32 */;

static const __midl_frag244_t __midl_frag244 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag246
};

static const __midl_frag243_t __midl_frag243 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag242_t __midl_frag242 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag243
};

static const __midl_frag241_t __midl_frag241 =
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
        &__midl_frag242,
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
        &__midl_frag246,
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
        &__midl_frag246,
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

static const __midl_frag233_t __midl_frag233 =
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
        &__midl_frag242,
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
        &__midl_frag246,
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
        &__midl_frag246,
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
        &__midl_frag246,
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

static const __midl_frag231_t __midl_frag231 =
0x4    /* FC64_INT16 */;

static const __midl_frag230_t __midl_frag230 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag231
};

static const __midl_frag229_t __midl_frag229 =
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
        &__midl_frag231,
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
        &__midl_frag246,
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

static const __midl_frag228_t __midl_frag228 =
0x5    /* FC64_INT32 */;

static const __midl_frag227_t __midl_frag227 =
0x4    /* FC64_INT16 */;

static const __midl_frag226_t __midl_frag226 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag227
};

static const __midl_frag225_t __midl_frag225 =
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
        &__midl_frag227,
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
        &__midl_frag228,
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

static const __midl_frag224_t __midl_frag224 =
0x5    /* FC64_INT32 */;

static const __midl_frag222_t __midl_frag222 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag224
};

static const __midl_frag221_t __midl_frag221 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag220_t __midl_frag220 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag221
};

static const __midl_frag219_t __midl_frag219 =
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
        &__midl_frag220,
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
        &__midl_frag224,
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
        &__midl_frag224,
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

static const __midl_frag215_t __midl_frag215 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag214_t __midl_frag214 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag215
};

static const __midl_frag213_t __midl_frag213 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag214
};

static const __midl_frag212_t __midl_frag212 =
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
        &__midl_frag214,
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
        &__midl_frag224,
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
        &__midl_frag224,
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

static const __midl_frag204_t __midl_frag204 =
0x4    /* FC64_INT16 */;

static const __midl_frag203_t __midl_frag203 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag204
};

static const __midl_frag202_t __midl_frag202 =
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
        &__midl_frag204,
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
        &__midl_frag224,
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

static const __midl_frag201_t __midl_frag201 =
0x5    /* FC64_INT32 */;

static const __midl_frag200_t __midl_frag200 =
0x4    /* FC64_INT16 */;

static const __midl_frag199_t __midl_frag199 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag200
};

static const __midl_frag198_t __midl_frag198 =
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
        &__midl_frag200,
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
        &__midl_frag201,
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

static const __midl_frag197_t __midl_frag197 =
0x5    /* FC64_INT32 */;

static const __midl_frag195_t __midl_frag195 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag197
};

static const __midl_frag194_t __midl_frag194 =
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
        &__midl_frag197,
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
        &__midl_frag197,
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

static const __midl_frag193_t __midl_frag193 =
0x5    /* FC64_INT32 */;

static const __midl_frag191_t __midl_frag191 =
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
        &__midl_frag193,
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
        &__midl_frag193,
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

static const __midl_frag188_t __midl_frag188 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag193
};

static const __midl_frag187_t __midl_frag187 =
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
        &__midl_frag193,
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
        &__midl_frag193,
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

static const __midl_frag170_t __midl_frag170 =
0x4    /* FC64_INT16 */;

static const __midl_frag169_t __midl_frag169 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag170
};

static const __midl_frag168_t __midl_frag168 =
{ 
/* get_CapKeyUp */
    { 
    /* get_CapKeyUp */      /* procedure get_CapKeyUp */
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
    /* pCapKeyUp */      /* parameter pCapKeyUp */
        &__midl_frag170,
        { 
        /* pCapKeyUp */
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
        &__midl_frag193,
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
0x5    /* FC64_INT32 */;

static const __midl_frag165_t __midl_frag165 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag167
};

static const __midl_frag164_t __midl_frag164 =
{ 
/* get_DataCount */
    { 
    /* get_DataCount */      /* procedure get_DataCount */
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
    /* pDataCount */      /* parameter pDataCount */
        &__midl_frag167,
        { 
        /* pDataCount */
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
        &__midl_frag167,
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

static const __midl_frag163_t __midl_frag163 =
0x5    /* FC64_INT32 */;

static const __midl_frag161_t __midl_frag161 =
{ 
/* put_BinaryConversion */
    { 
    /* put_BinaryConversion */      /* procedure put_BinaryConversion */
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
    /* BinaryConversion */      /* parameter BinaryConversion */
        &__midl_frag163,
        { 
        /* BinaryConversion */
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
        &__midl_frag163,
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

static const __midl_frag158_t __midl_frag158 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag163
};

static const __midl_frag157_t __midl_frag157 =
{ 
/* get_BinaryConversion */
    { 
    /* get_BinaryConversion */      /* procedure get_BinaryConversion */
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
    /* pBinaryConversion */      /* parameter pBinaryConversion */
        &__midl_frag163,
        { 
        /* pBinaryConversion */
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
        &__midl_frag163,
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

static const __midl_frag155_t __midl_frag155 =
0x4    /* FC64_INT16 */;

static const __midl_frag154_t __midl_frag154 =
{ 
/* put_AutoDisable */
    { 
    /* put_AutoDisable */      /* procedure put_AutoDisable */
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
    /* AutoDisable */      /* parameter AutoDisable */
        &__midl_frag155,
        { 
        /* AutoDisable */
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
        &__midl_frag163,
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

static const __midl_frag151_t __midl_frag151 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag155
};

static const __midl_frag150_t __midl_frag150 =
{ 
/* get_AutoDisable */
    { 
    /* get_AutoDisable */      /* procedure get_AutoDisable */
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
    /* pAutoDisable */      /* parameter pAutoDisable */
        &__midl_frag155,
        { 
        /* pAutoDisable */
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
        &__midl_frag163,
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
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag137_t __midl_frag137 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag138
};

static const __midl_frag136_t __midl_frag136 =
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
        &__midl_frag137,
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
        &__midl_frag163,
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
        &__midl_frag163,
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

static const __midl_frag132_t __midl_frag132 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag131_t __midl_frag131 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag132
};

static const __midl_frag130_t __midl_frag130 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag131
};

static const __midl_frag128_t __midl_frag128 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 8 /* 0x8 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag163
};

static const __midl_frag126_t __midl_frag126 =
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag131,
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
        &__midl_frag163,
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
        &__midl_frag163,
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

static const __midl_frag113_t __midl_frag113 =
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag163,
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

static const __midl_frag104_t __midl_frag104 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 4 /* 0x4 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag131
};

static const __midl_frag103_t __midl_frag103 =
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
        &__midl_frag131,
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
        &__midl_frag163,
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

static const __midl_frag73_t __midl_frag73 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag163
};

static const __midl_frag72_t __midl_frag72 =
{ 
/* get_ResultCodeExtended */
    { 
    /* get_ResultCodeExtended */      /* procedure get_ResultCodeExtended */
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
    /* pResultCodeExtended */      /* parameter pResultCodeExtended */
        &__midl_frag163,
        { 
        /* pResultCodeExtended */
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
        &__midl_frag163,
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
/* SOError */
    { 
    /* SOError */      /* procedure SOError */
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag155
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
        &__midl_frag163,
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
        &__midl_frag163,
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
        &__midl_frag131,
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
        &__midl_frag163,
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
/* SOData */
    { 
    /* SOData */      /* procedure SOData */
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
        &__midl_frag163,
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
        &__midl_frag163,
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


/* Object interface: IOPOSPOSKeyboard_1_5, ver. 0.0,
   GUID={0xCCB91141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSKeyboard_1_5_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag161,
    &__midl_frag161,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag103,
    &__midl_frag150,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag164,
    &__midl_frag72,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag103,
    &__midl_frag113,
    &__midl_frag113,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag126,
    &__midl_frag136,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag157,
    &__midl_frag161,
    &__midl_frag164,
    &__midl_frag168,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag194
    };


static const MIDL_SYNTAX_INFO IOPOSPOSKeyboard_1_5_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_5_FormatStringOffsetTable[-3],
    POSKeyboard__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSKeyboard_1_5_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_5_ProxyInfo =
    {
    &Object_StubDesc,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_5_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_5_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_5_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSKeyboard_1_5_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_5_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(52) _IOPOSPOSKeyboard_1_5ProxyVtbl = 
{
    &IOPOSPOSKeyboard_1_5_ProxyInfo,
    &IID_IOPOSPOSKeyboard_1_5,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClearInput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataCount */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapKeyUp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyEventType */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerState */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSKeyboard_1_5_table[] =
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
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSPOSKeyboard_1_5StubVtbl =
{
    &IID_IOPOSPOSKeyboard_1_5,
    &IOPOSPOSKeyboard_1_5_ServerInfo,
    52,
    &IOPOSPOSKeyboard_1_5_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSKeyboard_1_8, ver. 0.0,
   GUID={0xCCB92141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSKeyboard_1_8_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag161,
    &__midl_frag161,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag103,
    &__midl_frag150,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag164,
    &__midl_frag72,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag103,
    &__midl_frag113,
    &__midl_frag113,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag126,
    &__midl_frag136,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag157,
    &__midl_frag161,
    &__midl_frag164,
    &__midl_frag168,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag194,
    &__midl_frag198,
    &__midl_frag202,
    &__midl_frag219,
    &__midl_frag212,
    &__midl_frag219
    };


static const MIDL_SYNTAX_INFO IOPOSPOSKeyboard_1_8_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_8_FormatStringOffsetTable[-3],
    POSKeyboard__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSKeyboard_1_8_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_8_ProxyInfo =
    {
    &Object_StubDesc,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_8_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_8_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_8_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSKeyboard_1_8_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_8_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(57) _IOPOSPOSKeyboard_1_8ProxyVtbl = 
{
    &IOPOSPOSKeyboard_1_8_ProxyInfo,
    &IID_IOPOSPOSKeyboard_1_8,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClearInput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataCount */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapKeyUp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyEventType */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerState */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::get_CapStatisticsReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::get_CapUpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::ResetStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::RetrieveStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::UpdateStatistics */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSKeyboard_1_8_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSPOSKeyboard_1_8StubVtbl =
{
    &IID_IOPOSPOSKeyboard_1_8,
    &IOPOSPOSKeyboard_1_8_ServerInfo,
    57,
    &IOPOSPOSKeyboard_1_8_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSKeyboard_1_9, ver. 0.0,
   GUID={0xCCB93141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSKeyboard_1_9_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag161,
    &__midl_frag161,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag103,
    &__midl_frag150,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag164,
    &__midl_frag72,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag103,
    &__midl_frag113,
    &__midl_frag113,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag126,
    &__midl_frag136,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag157,
    &__midl_frag161,
    &__midl_frag164,
    &__midl_frag168,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag194,
    &__midl_frag198,
    &__midl_frag202,
    &__midl_frag219,
    &__midl_frag212,
    &__midl_frag219,
    &__midl_frag225,
    &__midl_frag229,
    &__midl_frag233,
    &__midl_frag241
    };


static const MIDL_SYNTAX_INFO IOPOSPOSKeyboard_1_9_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_9_FormatStringOffsetTable[-3],
    POSKeyboard__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSKeyboard_1_9_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_1_9_ProxyInfo =
    {
    &Object_StubDesc,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_1_9_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_9_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSKeyboard_1_9_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSKeyboard_1_9_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_1_9_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(61) _IOPOSPOSKeyboard_1_9ProxyVtbl = 
{
    &IOPOSPOSKeyboard_1_9_ProxyInfo,
    &IID_IOPOSPOSKeyboard_1_9,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOOutputCompleteDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DataEventEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ClearInput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyData */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_AutoDisable */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_BinaryConversion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_DataCount */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapKeyUp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_EventTypes */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_POSKeyEventType */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_CapPowerReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::put_PowerNotify */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_5::get_PowerState */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::get_CapStatisticsReporting */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::get_CapUpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::ResetStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::RetrieveStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_8::UpdateStatistics */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_9::get_CapCompareFirmwareVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_9::get_CapUpdateFirmware */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_9::CompareFirmwareVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSKeyboard_1_9::UpdateFirmware */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSKeyboard_1_9_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSPOSKeyboard_1_9StubVtbl =
{
    &IID_IOPOSPOSKeyboard_1_9,
    &IOPOSPOSKeyboard_1_9_ServerInfo,
    61,
    &IOPOSPOSKeyboard_1_9_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSKeyboard, ver. 0.0,
   GUID={0xCCB94141,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSKeyboard_Ndr64ProcTable[] =
    {
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    (FormatInfoRef)(LONG_PTR) -1,
    &__midl_frag2,
    &__midl_frag5,
    &__midl_frag17,
    &__midl_frag161,
    &__midl_frag161,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag103,
    &__midl_frag150,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag164,
    &__midl_frag72,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag164,
    &__midl_frag103,
    &__midl_frag103,
    &__midl_frag113,
    &__midl_frag113,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag126,
    &__midl_frag136,
    &__midl_frag157,
    &__midl_frag157,
    &__midl_frag150,
    &__midl_frag154,
    &__midl_frag157,
    &__midl_frag161,
    &__midl_frag164,
    &__midl_frag168,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag187,
    &__midl_frag191,
    &__midl_frag194,
    &__midl_frag198,
    &__midl_frag202,
    &__midl_frag219,
    &__midl_frag212,
    &__midl_frag219,
    &__midl_frag225,
    &__midl_frag229,
    &__midl_frag233,
    &__midl_frag241,
    0
    };


static const MIDL_SYNTAX_INFO IOPOSPOSKeyboard_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_FormatStringOffsetTable[-3],
    POSKeyboard__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSKeyboard_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSKeyboard_ProxyInfo =
    {
    &Object_StubDesc,
    POSKeyboard__MIDL_ProcFormatString.Format,
    &IOPOSPOSKeyboard_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSKeyboard_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSKeyboard__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSKeyboard_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSKeyboard_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(61) _IOPOSPOSKeyboardProxyVtbl = 
{
    0,
    &IID_IOPOSPOSKeyboard,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SOData */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SODirectIO */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SOError */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SOOutputCompleteDummy */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SOStatusUpdate */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::SOProcessID */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_OpenResult */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_CheckHealthText */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_Claimed */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_DataEventEnabled */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_DataEventEnabled */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ResultCode */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ResultCodeExtended */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_State */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ControlObjectDescription */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ControlObjectVersion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ServiceObjectDescription */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_ServiceObjectVersion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_DeviceDescription */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_DeviceName */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::CheckHealth */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::ClaimDevice */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::ClearInput */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::Close */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::DirectIO */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::Open */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::ReleaseDevice */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_POSKeyData */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_AutoDisable */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_AutoDisable */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_BinaryConversion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_BinaryConversion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_DataCount */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_CapKeyUp */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_EventTypes */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_EventTypes */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_POSKeyEventType */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_CapPowerReporting */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_PowerNotify */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::put_PowerNotify */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_5::get_PowerState */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_8::get_CapStatisticsReporting */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_8::get_CapUpdateStatistics */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_8::ResetStatistics */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_8::RetrieveStatistics */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_8::UpdateStatistics */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_9::get_CapCompareFirmwareVersion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_9::get_CapUpdateFirmware */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_9::CompareFirmwareVersion */ ,
    0 /* forced delegation IOPOSPOSKeyboard_1_9::UpdateFirmware */
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSKeyboard_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3
};

CInterfaceStubVtbl _IOPOSPOSKeyboardStubVtbl =
{
    &IID_IOPOSPOSKeyboard,
    &IOPOSPOSKeyboard_ServerInfo,
    61,
    &IOPOSPOSKeyboard_table[-3],
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
    POSKeyboard__MIDL_TypeFormatString.Format,
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

const CInterfaceProxyVtbl * const _POSKeyboard_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_IOPOSPOSKeyboard_1_5ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSKeyboard_1_8ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSKeyboard_1_9ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSKeyboardProxyVtbl,
    0
};

const CInterfaceStubVtbl * const _POSKeyboard_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_IOPOSPOSKeyboard_1_5StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSKeyboard_1_8StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSKeyboard_1_9StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSKeyboardStubVtbl,
    0
};

PCInterfaceName const _POSKeyboard_InterfaceNamesList[] = 
{
    "IOPOSPOSKeyboard_1_5",
    "IOPOSPOSKeyboard_1_8",
    "IOPOSPOSKeyboard_1_9",
    "IOPOSPOSKeyboard",
    0
};

const IID *  const _POSKeyboard_BaseIIDList[] = 
{
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    0
};


#define _POSKeyboard_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _POSKeyboard, pIID, n)

int __stdcall _POSKeyboard_IID_Lookup( const IID * pIID, int * pIndex )
{
    IID_BS_LOOKUP_SETUP

    IID_BS_LOOKUP_INITIAL_TEST( _POSKeyboard, 4, 2 )
    IID_BS_LOOKUP_NEXT_TEST( _POSKeyboard, 1 )
    IID_BS_LOOKUP_RETURN_RESULT( _POSKeyboard, 4, *pIndex )
    
}

EXTERN_C const ExtendedProxyFileInfo POSKeyboard_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _POSKeyboard_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _POSKeyboard_StubVtblList,
    (const PCInterfaceName * ) & _POSKeyboard_InterfaceNamesList,
    (const IID ** ) & _POSKeyboard_BaseIIDList,
    & _POSKeyboard_IID_Lookup, 
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

