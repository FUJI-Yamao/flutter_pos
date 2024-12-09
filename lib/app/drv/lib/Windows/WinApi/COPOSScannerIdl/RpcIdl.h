

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for RpcIdl.idl:
    Oicf, W4, Zp8, env=Win64 (32b run), target_arch=AMD64 8.01.0628 
    protocol : all , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */



/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 500
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif /* __RPCNDR_H_VERSION__ */


#ifndef __RpcIdl_h__
#define __RpcIdl_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifndef DECLSPEC_XFGVIRT
#if defined(_CONTROL_FLOW_GUARD_XFG)
#define DECLSPEC_XFGVIRT(base, func) __declspec(xfg_virtual(base, func))
#else
#define DECLSPEC_XFGVIRT(base, func)
#endif
#endif

/* Forward Declarations */ 

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __RpcIdl_INTERFACE_DEFINED__
#define __RpcIdl_INTERFACE_DEFINED__

/* interface RpcIdl */
/* [explicit_handle][version][uuid] */ 

typedef /* [context_handle] */ void *CONTEXT_HANDLE;

typedef struct SCAN_DATA
    {
    /* [string] */ const char *scanData;
    /* [string] */ const char *scanType;
    /* [string] */ const char *scanLabel;
    } 	SCAN_DATA;

CONTEXT_HANDLE Open( 
    /* [in] */ handle_t hBinding,
    /* [full][in] */ SCAN_DATA *psData);

void ScanData( 
    /* [in] */ CONTEXT_HANDLE hContext);

void Close( 
    /* [out][in] */ CONTEXT_HANDLE *phContext);



extern RPC_IF_HANDLE RpcIdl_v1_0_c_ifspec;
extern RPC_IF_HANDLE RpcIdl_v1_0_s_ifspec;
#endif /* __RpcIdl_INTERFACE_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

void __RPC_USER CONTEXT_HANDLE_rundown( CONTEXT_HANDLE );

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


