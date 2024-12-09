

/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for POSPrinter.idl:
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


#include "POSPrinter.h"

#define TYPE_FORMAT_STRING_SIZE   83                                
#define PROC_FORMAT_STRING_SIZE   8675                              
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   1            

typedef struct _POSPrinter_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } POSPrinter_MIDL_TYPE_FORMAT_STRING;

typedef struct _POSPrinter_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } POSPrinter_MIDL_PROC_FORMAT_STRING;

typedef struct _POSPrinter_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } POSPrinter_MIDL_EXPR_FORMAT_STRING;


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



extern const POSPrinter_MIDL_TYPE_FORMAT_STRING POSPrinter__MIDL_TypeFormatString;
extern const POSPrinter_MIDL_PROC_FORMAT_STRING POSPrinter__MIDL_ProcFormatString;
extern const POSPrinter_MIDL_EXPR_FORMAT_STRING POSPrinter__MIDL_ExprFormatString;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_5_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_5_ProxyInfo;

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineHeight)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  128,
                  0,
                  ( unsigned char * )This,
                  pSlpLineHeight);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpLineHeight)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  129,
                  0,
                  ( unsigned char * )This,
                  SlpLineHeight);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLinesNearEndToEnd)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  130,
                  0,
                  ( unsigned char * )This,
                  pSlpLinesNearEndToEnd);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineSpacing)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  131,
                  0,
                  ( unsigned char * )This,
                  pSlpLineSpacing);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpLineSpacing)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  132,
                  0,
                  ( unsigned char * )This,
                  SlpLineSpacing);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineWidth)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  133,
                  0,
                  ( unsigned char * )This,
                  pSlpLineWidth);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpMaxLines)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  134,
                  0,
                  ( unsigned char * )This,
                  pSlpMaxLines);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  135,
                  0,
                  ( unsigned char * )This,
                  pSlpNearEnd);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpSidewaysMaxChars)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  136,
                  0,
                  ( unsigned char * )This,
                  pSlpSidewaysMaxChars);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpSidewaysMaxLines)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  137,
                  0,
                  ( unsigned char * )This,
                  pSlpSidewaysMaxLines);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_BeginInsertion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Timeout,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  138,
                  0,
                  ( unsigned char * )This,
                  Timeout,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_BeginRemoval_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Timeout,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  139,
                  0,
                  ( unsigned char * )This,
                  Timeout,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_CutPaper_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Percentage,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  140,
                  0,
                  ( unsigned char * )This,
                  Percentage,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_EndInsertion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  141,
                  0,
                  ( unsigned char * )This,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_EndRemoval_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  142,
                  0,
                  ( unsigned char * )This,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintBarCode_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [in] */ long Symbology,
    /* [in] */ long Height,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [in] */ long TextPosition,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  143,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Data,
                  Symbology,
                  Height,
                  Width,
                  Alignment,
                  TextPosition,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintBitmap_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR FileName,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  144,
                  0,
                  ( unsigned char * )This,
                  Station,
                  FileName,
                  Width,
                  Alignment,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintImmediate_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  145,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Data,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintNormal_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  146,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Data,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Stations,
    /* [in] */ BSTR Data1,
    /* [in] */ BSTR Data2,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  147,
                  0,
                  ( unsigned char * )This,
                  Stations,
                  Data1,
                  Data2,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_RotatePrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ long Rotation,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  148,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Rotation,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_SetBitmap_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long BitmapNumber,
    /* [in] */ long Station,
    /* [in] */ BSTR FileName,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  149,
                  0,
                  ( unsigned char * )This,
                  BitmapNumber,
                  Station,
                  FileName,
                  Width,
                  Alignment,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_SetLogo_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Location,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  150,
                  0,
                  ( unsigned char * )This,
                  Location,
                  Data,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapCharacterSet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  151,
                  0,
                  ( unsigned char * )This,
                  pCapCharacterSet);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapTransaction)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  152,
                  0,
                  ( unsigned char * )This,
                  pCapTransaction);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pErrorLevel)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  153,
                  0,
                  ( unsigned char * )This,
                  pErrorLevel);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_ErrorString_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pErrorString)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  154,
                  0,
                  ( unsigned char * )This,
                  pErrorString);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pFontTypefaceList)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  155,
                  0,
                  ( unsigned char * )This,
                  pFontTypefaceList);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pRecBarCodeRotationList)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  156,
                  0,
                  ( unsigned char * )This,
                  pRecBarCodeRotationList);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRotateSpecial)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  157,
                  0,
                  ( unsigned char * )This,
                  pRotateSpecial);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long RotateSpecial)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  158,
                  0,
                  ( unsigned char * )This,
                  RotateSpecial);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pSlpBarCodeRotationList)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  159,
                  0,
                  ( unsigned char * )This,
                  pSlpBarCodeRotationList);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_TransactionPrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ long Control,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  160,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Control,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_ValidateData_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  161,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Data,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pBinaryConversion)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  162,
                  0,
                  ( unsigned char * )This,
                  pBinaryConversion);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long BinaryConversion)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  163,
                  0,
                  ( unsigned char * )This,
                  BinaryConversion);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapPowerReporting)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  164,
                  0,
                  ( unsigned char * )This,
                  pCapPowerReporting);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pPowerNotify)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  165,
                  0,
                  ( unsigned char * )This,
                  pPowerNotify);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long PowerNotify)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  166,
                  0,
                  ( unsigned char * )This,
                  PowerNotify);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_PowerState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pPowerState)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  167,
                  0,
                  ( unsigned char * )This,
                  pPowerState);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapJrnCartridgeSensor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  168,
                  0,
                  ( unsigned char * )This,
                  pCapJrnCartridgeSensor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapJrnColor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  169,
                  0,
                  ( unsigned char * )This,
                  pCapJrnColor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecCartridgeSensor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  170,
                  0,
                  ( unsigned char * )This,
                  pCapRecCartridgeSensor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecColor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  171,
                  0,
                  ( unsigned char * )This,
                  pCapRecColor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecMarkFeed)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  172,
                  0,
                  ( unsigned char * )This,
                  pCapRecMarkFeed);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  173,
                  0,
                  ( unsigned char * )This,
                  pCapSlpBothSidesPrint);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapSlpCartridgeSensor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  174,
                  0,
                  ( unsigned char * )This,
                  pCapSlpCartridgeSensor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapSlpColor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  175,
                  0,
                  ( unsigned char * )This,
                  pCapSlpColor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCartridgeNotify)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  176,
                  0,
                  ( unsigned char * )This,
                  pCartridgeNotify);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long CartridgeNotify)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  177,
                  0,
                  ( unsigned char * )This,
                  CartridgeNotify);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pJrnCartridgeState)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  178,
                  0,
                  ( unsigned char * )This,
                  pJrnCartridgeState);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pJrnCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  179,
                  0,
                  ( unsigned char * )This,
                  pJrnCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long JrnCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  180,
                  0,
                  ( unsigned char * )This,
                  JrnCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRecCartridgeState)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  181,
                  0,
                  ( unsigned char * )This,
                  pRecCartridgeState);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRecCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  182,
                  0,
                  ( unsigned char * )This,
                  pRecCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long RecCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  183,
                  0,
                  ( unsigned char * )This,
                  RecCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpCartridgeState)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  184,
                  0,
                  ( unsigned char * )This,
                  pSlpCartridgeState);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  185,
                  0,
                  ( unsigned char * )This,
                  pSlpCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpCurrentCartridge)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  186,
                  0,
                  ( unsigned char * )This,
                  SlpCurrentCartridge);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpPrintSide)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  187,
                  0,
                  ( unsigned char * )This,
                  pSlpPrintSide);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Side,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  188,
                  0,
                  ( unsigned char * )This,
                  Side,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_MarkFeed_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Type,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_5_ProxyInfo,
                  189,
                  0,
                  ( unsigned char * )This,
                  Type,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_7_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_7_ProxyInfo;

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_7_ProxyInfo,
                  190,
                  0,
                  ( unsigned char * )This,
                  pCapMapCharacterSet);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_7_ProxyInfo,
                  191,
                  0,
                  ( unsigned char * )This,
                  pMapCharacterSet);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [in] */ VARIANT_BOOL MapCharacterSet)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_7_ProxyInfo,
                  192,
                  0,
                  ( unsigned char * )This,
                  MapCharacterSet);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ BSTR *pRecBitmapRotationList)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_7_ProxyInfo,
                  193,
                  0,
                  ( unsigned char * )This,
                  pRecBitmapRotationList);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ BSTR *pSlpBitmapRotationList)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_7_ProxyInfo,
                  194,
                  0,
                  ( unsigned char * )This,
                  pSlpBitmapRotationList);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_8_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_8_ProxyInfo;

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_8_ProxyInfo,
                  195,
                  0,
                  ( unsigned char * )This,
                  pCapStatisticsReporting);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_8_ProxyInfo,
                  196,
                  0,
                  ( unsigned char * )This,
                  pCapUpdateStatistics);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_ResetStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [in] */ BSTR StatisticsBuffer,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_8_ProxyInfo,
                  197,
                  0,
                  ( unsigned char * )This,
                  StatisticsBuffer,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [out][in] */ BSTR *pStatisticsBuffer,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_8_ProxyInfo,
                  198,
                  0,
                  ( unsigned char * )This,
                  pStatisticsBuffer,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [in] */ BSTR StatisticsBuffer,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_8_ProxyInfo,
                  199,
                  0,
                  ( unsigned char * )This,
                  StatisticsBuffer,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_9_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_9_ProxyInfo;

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  200,
                  0,
                  ( unsigned char * )This,
                  pCapCompareFirmwareVersion);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  201,
                  0,
                  ( unsigned char * )This,
                  pCapUpdateFirmware);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR FirmwareFileName,
    /* [out] */ long *pResult,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  202,
                  0,
                  ( unsigned char * )This,
                  FirmwareFileName,
                  pResult,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR FirmwareFileName,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  203,
                  0,
                  ( unsigned char * )This,
                  FirmwareFileName,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  204,
                  0,
                  ( unsigned char * )This,
                  pCapConcurrentPageMode);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  205,
                  0,
                  ( unsigned char * )This,
                  pCapRecPageMode);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  206,
                  0,
                  ( unsigned char * )This,
                  pCapSlpPageMode);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ BSTR *pPageModeArea)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  207,
                  0,
                  ( unsigned char * )This,
                  pPageModeArea);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeDescriptor)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  208,
                  0,
                  ( unsigned char * )This,
                  pPageModeDescriptor);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeHorizontalPosition)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  209,
                  0,
                  ( unsigned char * )This,
                  pPageModeHorizontalPosition);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeHorizontalPosition)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  210,
                  0,
                  ( unsigned char * )This,
                  PageModeHorizontalPosition);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ BSTR *pPageModePrintArea)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  211,
                  0,
                  ( unsigned char * )This,
                  pPageModePrintArea);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR PageModePrintArea)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  212,
                  0,
                  ( unsigned char * )This,
                  PageModePrintArea);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModePrintDirection)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  213,
                  0,
                  ( unsigned char * )This,
                  pPageModePrintDirection);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModePrintDirection)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  214,
                  0,
                  ( unsigned char * )This,
                  PageModePrintDirection);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeStation)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  215,
                  0,
                  ( unsigned char * )This,
                  pPageModeStation);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeStation)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  216,
                  0,
                  ( unsigned char * )This,
                  PageModeStation);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeVerticalPosition)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  217,
                  0,
                  ( unsigned char * )This,
                  pPageModeVerticalPosition);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeVerticalPosition)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  218,
                  0,
                  ( unsigned char * )This,
                  PageModeVerticalPosition);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  219,
                  0,
                  ( unsigned char * )This,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_PageModePrint_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long Control,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_9_ProxyInfo,
                  220,
                  0,
                  ( unsigned char * )This,
                  Control,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_10_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_10_ProxyInfo;

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy( 
    IOPOSPOSPrinter_1_10 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [in] */ long Type,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_10_ProxyInfo,
                  221,
                  0,
                  ( unsigned char * )This,
                  Station,
                  Data,
                  Type,
                  Width,
                  Alignment,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_10_zz_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_10_zz_ProxyInfo;

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_1_13_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_13_ProxyInfo;

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_get_CapRecRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [retval][out] */ long *pCapRecRuledLine)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_13_ProxyInfo,
                  222,
                  0,
                  ( unsigned char * )This,
                  pCapRecRuledLine);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_get_CapSlpRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [retval][out] */ long *pCapSlpRuledLine)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_13_ProxyInfo,
                  223,
                  0,
                  ( unsigned char * )This,
                  pCapSlpRuledLine);
return ( HRESULT  )_RetVal.Simple;

}

/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_DrawRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR PositionList,
    /* [in] */ long LineDirection,
    /* [in] */ long LineWidth,
    /* [in] */ long LineStyle,
    /* [in] */ long LineColor,
    /* [retval][out] */ long *pRC)
{
CLIENT_CALL_RETURN _RetVal;

_RetVal = NdrClientCall3(
                  ( PMIDL_STUBLESS_PROXY_INFO  )&IOPOSPOSPrinter_1_13_ProxyInfo,
                  224,
                  0,
                  ( unsigned char * )This,
                  Station,
                  PositionList,
                  LineDirection,
                  LineWidth,
                  LineStyle,
                  LineColor,
                  pRC);
return ( HRESULT  )_RetVal.Simple;

}

#ifdef __cplusplus
namespace {
#endif

extern const MIDL_STUB_DESC Object_StubDesc;
#ifdef __cplusplus
}
#endif


extern const MIDL_SERVER_INFO IOPOSPOSPrinter_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_ProxyInfo;


extern const USER_MARSHAL_ROUTINE_QUADRUPLE NDR64_UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN64__)
#error  Invalid build platform for this stub.
#endif

static const POSPrinter_MIDL_PROC_FORMAT_STRING POSPrinter__MIDL_ProcFormatString =
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

	/* Procedure SOOutputComplete */

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

	/* Procedure get_OutputID */

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

	/* Parameter pOutputID */

/* 550 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 552 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 554 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 556 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 558 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCode */

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

	/* Parameter pResultCode */

/* 588 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 590 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 596 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ResultCodeExtended */

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

	/* Parameter pResultCodeExtended */

/* 626 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 632 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 636 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_State */

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

	/* Parameter pState */

/* 664 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 666 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 668 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 670 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 672 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectDescription */

/* 676 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 678 */	NdrFcLong( 0x0 ),	/* 0 */
/* 682 */	NdrFcShort( 0x18 ),	/* 24 */
/* 684 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 686 */	NdrFcShort( 0x0 ),	/* 0 */
/* 688 */	NdrFcShort( 0x8 ),	/* 8 */
/* 690 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 692 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 694 */	NdrFcShort( 0x1 ),	/* 1 */
/* 696 */	NdrFcShort( 0x0 ),	/* 0 */
/* 698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 700 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pControlObjectDescription */

/* 702 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 704 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 706 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 708 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 710 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ControlObjectVersion */

/* 714 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 716 */	NdrFcLong( 0x0 ),	/* 0 */
/* 720 */	NdrFcShort( 0x19 ),	/* 25 */
/* 722 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 724 */	NdrFcShort( 0x0 ),	/* 0 */
/* 726 */	NdrFcShort( 0x24 ),	/* 36 */
/* 728 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 730 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 732 */	NdrFcShort( 0x0 ),	/* 0 */
/* 734 */	NdrFcShort( 0x0 ),	/* 0 */
/* 736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 738 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pControlObjectVersion */

/* 740 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 742 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 744 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 746 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 748 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 750 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectDescription */

/* 752 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 754 */	NdrFcLong( 0x0 ),	/* 0 */
/* 758 */	NdrFcShort( 0x1a ),	/* 26 */
/* 760 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 764 */	NdrFcShort( 0x8 ),	/* 8 */
/* 766 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 768 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 770 */	NdrFcShort( 0x1 ),	/* 1 */
/* 772 */	NdrFcShort( 0x0 ),	/* 0 */
/* 774 */	NdrFcShort( 0x0 ),	/* 0 */
/* 776 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pServiceObjectDescription */

/* 778 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 780 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 782 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 784 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 786 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ServiceObjectVersion */

/* 790 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 792 */	NdrFcLong( 0x0 ),	/* 0 */
/* 796 */	NdrFcShort( 0x1b ),	/* 27 */
/* 798 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 802 */	NdrFcShort( 0x24 ),	/* 36 */
/* 804 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 806 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 808 */	NdrFcShort( 0x0 ),	/* 0 */
/* 810 */	NdrFcShort( 0x0 ),	/* 0 */
/* 812 */	NdrFcShort( 0x0 ),	/* 0 */
/* 814 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pServiceObjectVersion */

/* 816 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 818 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 820 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 822 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 824 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 826 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceDescription */

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

	/* Parameter pDeviceDescription */

/* 854 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 856 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 858 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 860 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 862 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 864 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_DeviceName */

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

	/* Parameter pDeviceName */

/* 892 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 894 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 896 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 898 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 900 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CheckHealth */

/* 904 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 906 */	NdrFcLong( 0x0 ),	/* 0 */
/* 910 */	NdrFcShort( 0x1e ),	/* 30 */
/* 912 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 914 */	NdrFcShort( 0x8 ),	/* 8 */
/* 916 */	NdrFcShort( 0x24 ),	/* 36 */
/* 918 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 920 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 922 */	NdrFcShort( 0x0 ),	/* 0 */
/* 924 */	NdrFcShort( 0x0 ),	/* 0 */
/* 926 */	NdrFcShort( 0x0 ),	/* 0 */
/* 928 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Level */

/* 930 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 932 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 934 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 936 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 938 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 940 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 942 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 944 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 946 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClaimDevice */

/* 948 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 950 */	NdrFcLong( 0x0 ),	/* 0 */
/* 954 */	NdrFcShort( 0x1f ),	/* 31 */
/* 956 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 958 */	NdrFcShort( 0x8 ),	/* 8 */
/* 960 */	NdrFcShort( 0x24 ),	/* 36 */
/* 962 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 964 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 966 */	NdrFcShort( 0x0 ),	/* 0 */
/* 968 */	NdrFcShort( 0x0 ),	/* 0 */
/* 970 */	NdrFcShort( 0x0 ),	/* 0 */
/* 972 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Timeout */

/* 974 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 976 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 978 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 980 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 982 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 984 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 986 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 988 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 990 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClearOutput */

/* 992 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 994 */	NdrFcLong( 0x0 ),	/* 0 */
/* 998 */	NdrFcShort( 0x20 ),	/* 32 */
/* 1000 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1004 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1006 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1008 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1010 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1012 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1016 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1018 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1020 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1022 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1024 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1026 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1028 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Close */

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

	/* Procedure DirectIO */

/* 1068 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1070 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1074 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1076 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 1078 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1080 */	NdrFcShort( 0x40 ),	/* 64 */
/* 1082 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 1084 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 1086 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1088 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1092 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Command */

/* 1094 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1096 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1098 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pData */

/* 1100 */	NdrFcShort( 0x158 ),	/* Flags:  in, out, base type, simple ref, */
/* 1102 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1104 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pString */

/* 1106 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 1108 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1110 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 1112 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1114 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1116 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1118 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1120 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 1122 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure Open */

/* 1124 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1126 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1130 */	NdrFcShort( 0x23 ),	/* 35 */
/* 1132 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 1134 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1136 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1138 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 1140 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 1142 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1144 */	NdrFcShort( 0x1 ),	/* 1 */
/* 1146 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1148 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter DeviceName */

/* 1150 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 1152 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1154 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 1156 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1158 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1160 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1162 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1164 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1166 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ReleaseDevice */

/* 1168 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1170 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1174 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1176 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1178 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1180 */	NdrFcShort( 0x24 ),	/* 36 */
/* 1182 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1184 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1186 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1190 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1192 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 1194 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1196 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1198 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 1200 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1202 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1204 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_AsyncMode */

/* 1206 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1208 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1212 */	NdrFcShort( 0x25 ),	/* 37 */
/* 1214 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1216 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1218 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1220 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1222 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1224 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1226 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1228 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1230 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pAsyncMode */

/* 1232 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1234 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1236 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1238 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1240 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1242 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_AsyncMode */

/* 1244 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1246 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1250 */	NdrFcShort( 0x26 ),	/* 38 */
/* 1252 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1254 */	NdrFcShort( 0x6 ),	/* 6 */
/* 1256 */	NdrFcShort( 0x8 ),	/* 8 */
/* 1258 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1260 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1262 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1264 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1266 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1268 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter AsyncMode */

/* 1270 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 1272 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1274 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1276 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1278 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1280 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapConcurrentJrnRec */

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

	/* Parameter pCapConcurrentJrnRec */

/* 1308 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1310 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1312 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1314 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1316 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1318 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapConcurrentJrnSlp */

/* 1320 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1322 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1326 */	NdrFcShort( 0x28 ),	/* 40 */
/* 1328 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1332 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1334 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1336 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1338 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1340 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1342 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1344 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapConcurrentJrnSlp */

/* 1346 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1348 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1350 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1352 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1354 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1356 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapConcurrentRecSlp */

/* 1358 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1360 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1364 */	NdrFcShort( 0x29 ),	/* 41 */
/* 1366 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1368 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1370 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1372 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1374 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1376 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1378 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1380 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1382 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapConcurrentRecSlp */

/* 1384 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1386 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1388 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1390 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1392 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1394 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapCoverSensor */

/* 1396 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1398 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1402 */	NdrFcShort( 0x2a ),	/* 42 */
/* 1404 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1406 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1408 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1410 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1412 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1414 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1416 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1418 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1420 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapCoverSensor */

/* 1422 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1424 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1426 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1428 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1430 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1432 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrn2Color */

/* 1434 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1436 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1440 */	NdrFcShort( 0x2b ),	/* 43 */
/* 1442 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1444 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1446 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1448 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1450 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1452 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1454 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1456 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1458 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrn2Color */

/* 1460 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1462 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1464 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1466 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1468 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1470 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnBold */

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

	/* Parameter pCapJrnBold */

/* 1498 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1500 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1502 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1504 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1506 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1508 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnDhigh */

/* 1510 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1512 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1516 */	NdrFcShort( 0x2d ),	/* 45 */
/* 1518 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1522 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1524 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1526 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1528 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1530 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1532 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1534 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnDhigh */

/* 1536 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1538 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1540 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1542 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1544 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1546 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnDwide */

/* 1548 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1550 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1554 */	NdrFcShort( 0x2e ),	/* 46 */
/* 1556 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1558 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1560 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1562 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1564 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1566 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1570 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1572 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnDwide */

/* 1574 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1576 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1578 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1580 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1582 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1584 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnDwideDhigh */

/* 1586 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1588 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1592 */	NdrFcShort( 0x2f ),	/* 47 */
/* 1594 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1596 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1598 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1600 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1602 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1604 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1606 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1610 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnDwideDhigh */

/* 1612 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1614 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1616 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1618 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1620 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1622 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnEmptySensor */

/* 1624 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1626 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1630 */	NdrFcShort( 0x30 ),	/* 48 */
/* 1632 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1634 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1636 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1638 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1640 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1642 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1644 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1648 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnEmptySensor */

/* 1650 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1652 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1654 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1656 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1658 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnItalic */

/* 1662 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1664 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1668 */	NdrFcShort( 0x31 ),	/* 49 */
/* 1670 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1672 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1674 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1676 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1678 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1680 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1682 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1684 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1686 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnItalic */

/* 1688 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1690 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1692 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1694 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1696 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1698 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnNearEndSensor */

/* 1700 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1702 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1706 */	NdrFcShort( 0x32 ),	/* 50 */
/* 1708 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1710 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1712 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1714 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1716 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1718 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1720 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1722 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1724 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnNearEndSensor */

/* 1726 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1728 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1730 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1732 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1734 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1736 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnPresent */

/* 1738 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1740 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1744 */	NdrFcShort( 0x33 ),	/* 51 */
/* 1746 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1748 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1750 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1752 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1754 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1756 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1758 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1760 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1762 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnPresent */

/* 1764 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1766 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1768 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1770 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1772 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1774 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnUnderline */

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

	/* Parameter pCapJrnUnderline */

/* 1802 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1804 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1806 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1808 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1810 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1812 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRec2Color */

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

	/* Parameter pCapRec2Color */

/* 1840 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1842 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1844 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1846 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1848 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1850 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecBarCode */

/* 1852 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1854 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1858 */	NdrFcShort( 0x36 ),	/* 54 */
/* 1860 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1864 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1866 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1868 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1870 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1872 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1874 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1876 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecBarCode */

/* 1878 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1880 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1882 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1884 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1886 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1888 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecBitmap */

/* 1890 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1892 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1896 */	NdrFcShort( 0x37 ),	/* 55 */
/* 1898 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1900 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1902 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1904 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1906 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1908 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1910 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1912 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1914 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecBitmap */

/* 1916 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1918 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1920 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1922 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1924 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1926 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecBold */

/* 1928 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1930 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1934 */	NdrFcShort( 0x38 ),	/* 56 */
/* 1936 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1938 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1940 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1942 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1944 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1946 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1948 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1950 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1952 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecBold */

/* 1954 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1956 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1958 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1960 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 1962 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 1964 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecDhigh */

/* 1966 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 1968 */	NdrFcLong( 0x0 ),	/* 0 */
/* 1972 */	NdrFcShort( 0x39 ),	/* 57 */
/* 1974 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 1976 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1978 */	NdrFcShort( 0x22 ),	/* 34 */
/* 1980 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 1982 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 1984 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1986 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1988 */	NdrFcShort( 0x0 ),	/* 0 */
/* 1990 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecDhigh */

/* 1992 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 1994 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 1996 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 1998 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2000 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2002 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecDwide */

/* 2004 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2006 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2010 */	NdrFcShort( 0x3a ),	/* 58 */
/* 2012 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2016 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2018 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2020 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2022 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2024 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2026 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2028 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecDwide */

/* 2030 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2032 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2034 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2036 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2038 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2040 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecDwideDhigh */

/* 2042 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2044 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2048 */	NdrFcShort( 0x3b ),	/* 59 */
/* 2050 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2054 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2056 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2058 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2060 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2062 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2064 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2066 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecDwideDhigh */

/* 2068 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2070 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2072 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2074 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2076 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2078 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecEmptySensor */

/* 2080 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2082 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2086 */	NdrFcShort( 0x3c ),	/* 60 */
/* 2088 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2092 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2094 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2096 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2098 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2100 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2102 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2104 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecEmptySensor */

/* 2106 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2108 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2110 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2112 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2114 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2116 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecItalic */

/* 2118 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2120 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2124 */	NdrFcShort( 0x3d ),	/* 61 */
/* 2126 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2130 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2132 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2134 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2136 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2138 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2140 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2142 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecItalic */

/* 2144 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2146 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2148 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2150 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2152 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2154 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecLeft90 */

/* 2156 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2158 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2162 */	NdrFcShort( 0x3e ),	/* 62 */
/* 2164 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2166 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2168 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2170 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2172 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2174 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2176 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2178 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2180 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecLeft90 */

/* 2182 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2184 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2186 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2188 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2190 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2192 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecNearEndSensor */

/* 2194 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2196 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2200 */	NdrFcShort( 0x3f ),	/* 63 */
/* 2202 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2204 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2206 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2208 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2210 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2212 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2214 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2216 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2218 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecNearEndSensor */

/* 2220 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2222 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2224 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2226 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2228 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2230 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecPapercut */

/* 2232 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2234 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2238 */	NdrFcShort( 0x40 ),	/* 64 */
/* 2240 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2242 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2244 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2246 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2248 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2250 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2252 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2254 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2256 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecPapercut */

/* 2258 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2260 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2262 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2264 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2266 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2268 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecPresent */

/* 2270 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2272 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2276 */	NdrFcShort( 0x41 ),	/* 65 */
/* 2278 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2280 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2282 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2284 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2286 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2288 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2290 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2292 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2294 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecPresent */

/* 2296 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2298 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2300 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2302 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2304 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2306 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecRight90 */

/* 2308 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2310 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2314 */	NdrFcShort( 0x42 ),	/* 66 */
/* 2316 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2318 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2320 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2322 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2324 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2326 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2328 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2332 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecRight90 */

/* 2334 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2336 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2338 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2340 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2342 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2344 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecRotate180 */

/* 2346 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2348 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2352 */	NdrFcShort( 0x43 ),	/* 67 */
/* 2354 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2356 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2358 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2360 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2362 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2364 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2366 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2368 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2370 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecRotate180 */

/* 2372 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2374 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2376 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2378 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2380 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2382 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecStamp */

/* 2384 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2386 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2390 */	NdrFcShort( 0x44 ),	/* 68 */
/* 2392 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2394 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2396 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2398 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2400 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2402 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2404 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2406 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2408 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecStamp */

/* 2410 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2412 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2414 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2416 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2418 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2420 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecUnderline */

/* 2422 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2424 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2428 */	NdrFcShort( 0x45 ),	/* 69 */
/* 2430 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2434 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2436 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2438 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2440 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2442 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2444 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2446 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecUnderline */

/* 2448 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2450 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2452 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2454 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2456 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2458 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlp2Color */

/* 2460 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2462 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2466 */	NdrFcShort( 0x46 ),	/* 70 */
/* 2468 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2470 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2472 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2474 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2476 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2478 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2480 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2484 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlp2Color */

/* 2486 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2488 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2490 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2492 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2494 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2496 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpBarCode */

/* 2498 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2500 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2504 */	NdrFcShort( 0x47 ),	/* 71 */
/* 2506 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2508 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2510 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2512 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2514 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2516 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2518 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2522 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpBarCode */

/* 2524 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2526 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2528 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2530 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2532 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2534 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpBitmap */

/* 2536 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2538 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2542 */	NdrFcShort( 0x48 ),	/* 72 */
/* 2544 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2546 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2548 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2550 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2552 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2554 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2556 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2558 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2560 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpBitmap */

/* 2562 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2564 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2566 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2568 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2570 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2572 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpBold */

/* 2574 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2576 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2580 */	NdrFcShort( 0x49 ),	/* 73 */
/* 2582 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2584 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2586 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2588 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2590 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2592 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2594 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2596 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2598 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpBold */

/* 2600 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2602 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2604 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2606 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2608 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2610 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpDhigh */

/* 2612 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2614 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2618 */	NdrFcShort( 0x4a ),	/* 74 */
/* 2620 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2622 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2624 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2626 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2628 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2630 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2632 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2634 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2636 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpDhigh */

/* 2638 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2640 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2642 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2644 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2646 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2648 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpDwide */

/* 2650 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2652 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2656 */	NdrFcShort( 0x4b ),	/* 75 */
/* 2658 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2660 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2662 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2664 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2666 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2668 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2670 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2672 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2674 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpDwide */

/* 2676 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2678 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2680 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2682 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2684 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2686 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpDwideDhigh */

/* 2688 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2690 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2694 */	NdrFcShort( 0x4c ),	/* 76 */
/* 2696 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2700 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2702 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2704 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2706 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2708 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2710 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2712 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpDwideDhigh */

/* 2714 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2716 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2718 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2720 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2722 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2724 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpEmptySensor */

/* 2726 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2728 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2732 */	NdrFcShort( 0x4d ),	/* 77 */
/* 2734 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2738 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2740 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2742 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2744 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2746 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2748 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2750 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpEmptySensor */

/* 2752 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2754 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2756 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2758 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2760 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2762 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpFullslip */

/* 2764 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2766 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2770 */	NdrFcShort( 0x4e ),	/* 78 */
/* 2772 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2774 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2776 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2778 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2780 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2782 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2784 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2786 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2788 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpFullslip */

/* 2790 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2792 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2794 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2796 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2798 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2800 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpItalic */

/* 2802 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2804 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2808 */	NdrFcShort( 0x4f ),	/* 79 */
/* 2810 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2812 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2814 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2816 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2818 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2820 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2822 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2824 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2826 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpItalic */

/* 2828 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2830 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2832 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2834 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2836 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2838 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpLeft90 */

/* 2840 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2842 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2846 */	NdrFcShort( 0x50 ),	/* 80 */
/* 2848 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2850 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2852 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2854 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2856 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2858 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2860 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2864 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpLeft90 */

/* 2866 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2868 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2870 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2872 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2874 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2876 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpNearEndSensor */

/* 2878 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2880 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2884 */	NdrFcShort( 0x51 ),	/* 81 */
/* 2886 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2888 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2890 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2892 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2894 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2896 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2898 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2900 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2902 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpNearEndSensor */

/* 2904 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2906 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2908 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2910 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2912 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2914 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpPresent */

/* 2916 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2918 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2922 */	NdrFcShort( 0x52 ),	/* 82 */
/* 2924 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2926 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2928 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2930 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2932 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2934 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2936 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2938 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2940 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpPresent */

/* 2942 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2944 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2946 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2948 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2950 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2952 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpRight90 */

/* 2954 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2956 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2960 */	NdrFcShort( 0x53 ),	/* 83 */
/* 2962 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 2964 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2966 */	NdrFcShort( 0x22 ),	/* 34 */
/* 2968 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 2970 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 2972 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2974 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2976 */	NdrFcShort( 0x0 ),	/* 0 */
/* 2978 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpRight90 */

/* 2980 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 2982 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 2984 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 2986 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 2988 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 2990 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpRotate180 */

/* 2992 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 2994 */	NdrFcLong( 0x0 ),	/* 0 */
/* 2998 */	NdrFcShort( 0x54 ),	/* 84 */
/* 3000 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3004 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3006 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3008 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3010 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3012 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3016 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpRotate180 */

/* 3018 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3020 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3022 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3024 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3026 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3028 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpUnderline */

/* 3030 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3032 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3036 */	NdrFcShort( 0x55 ),	/* 85 */
/* 3038 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3040 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3042 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3044 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3046 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3048 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3050 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3054 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpUnderline */

/* 3056 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3058 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3060 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3062 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3064 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3066 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CharacterSet */

/* 3068 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3070 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3074 */	NdrFcShort( 0x56 ),	/* 86 */
/* 3076 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3080 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3082 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3084 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3086 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3088 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3092 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCharacterSet */

/* 3094 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3096 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3098 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3100 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3102 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3104 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_CharacterSet */

/* 3106 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3108 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3112 */	NdrFcShort( 0x57 ),	/* 87 */
/* 3114 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3116 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3118 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3120 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3122 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3124 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3126 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3130 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter CharacterSet */

/* 3132 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3134 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3136 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3138 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3140 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CharacterSetList */

/* 3144 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3146 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3150 */	NdrFcShort( 0x58 ),	/* 88 */
/* 3152 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3154 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3156 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3158 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 3160 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 3162 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3164 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3166 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3168 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCharacterSetList */

/* 3170 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 3172 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3174 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 3176 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3178 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3180 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CoverOpen */

/* 3182 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3184 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3188 */	NdrFcShort( 0x59 ),	/* 89 */
/* 3190 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3192 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3194 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3196 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3198 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3200 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3202 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3204 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3206 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCoverOpen */

/* 3208 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3210 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3212 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3214 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3216 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3218 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ErrorStation */

/* 3220 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3222 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3226 */	NdrFcShort( 0x5a ),	/* 90 */
/* 3228 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3230 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3232 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3234 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3236 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3238 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3240 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3242 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3244 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pErrorStation */

/* 3246 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3248 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3250 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3252 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3254 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3256 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_FlagWhenIdle */

/* 3258 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3260 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3264 */	NdrFcShort( 0x5b ),	/* 91 */
/* 3266 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3268 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3270 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3272 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3274 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3276 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3278 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3280 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3282 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pFlagWhenIdle */

/* 3284 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3286 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3288 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3290 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3292 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_FlagWhenIdle */

/* 3296 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3298 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3302 */	NdrFcShort( 0x5c ),	/* 92 */
/* 3304 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3306 */	NdrFcShort( 0x6 ),	/* 6 */
/* 3308 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3310 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3312 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3314 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3316 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3318 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3320 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FlagWhenIdle */

/* 3322 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3324 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3326 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3328 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3330 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3332 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnEmpty */

/* 3334 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3336 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3340 */	NdrFcShort( 0x5d ),	/* 93 */
/* 3342 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3344 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3346 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3348 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3350 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3352 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3354 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3356 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3358 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnEmpty */

/* 3360 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3362 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3364 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3366 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3368 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3370 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLetterQuality */

/* 3372 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3374 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3378 */	NdrFcShort( 0x5e ),	/* 94 */
/* 3380 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3382 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3384 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3386 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3388 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3390 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3392 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3394 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3396 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLetterQuality */

/* 3398 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3400 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3402 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3404 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3406 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3408 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_JrnLetterQuality */

/* 3410 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3412 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3416 */	NdrFcShort( 0x5f ),	/* 95 */
/* 3418 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3420 */	NdrFcShort( 0x6 ),	/* 6 */
/* 3422 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3424 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3426 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3428 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3434 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter JrnLetterQuality */

/* 3436 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3438 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3440 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3442 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3444 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3446 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLineChars */

/* 3448 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3450 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3454 */	NdrFcShort( 0x60 ),	/* 96 */
/* 3456 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3458 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3460 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3462 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3464 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3466 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3468 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3470 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3472 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLineChars */

/* 3474 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3476 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3478 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3480 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3482 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3484 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_JrnLineChars */

/* 3486 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3488 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3492 */	NdrFcShort( 0x61 ),	/* 97 */
/* 3494 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3496 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3498 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3500 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3502 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3504 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3506 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3508 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3510 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter JrnLineChars */

/* 3512 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3514 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3516 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3518 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3520 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3522 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLineCharsList */

/* 3524 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3526 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3530 */	NdrFcShort( 0x62 ),	/* 98 */
/* 3532 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3534 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3536 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3538 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 3540 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 3542 */	NdrFcShort( 0x1 ),	/* 1 */
/* 3544 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3546 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3548 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLineCharsList */

/* 3550 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 3552 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3554 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 3556 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3558 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLineHeight */

/* 3562 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3564 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3568 */	NdrFcShort( 0x63 ),	/* 99 */
/* 3570 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3574 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3576 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3578 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3580 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3582 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3584 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3586 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLineHeight */

/* 3588 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3590 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3596 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_JrnLineHeight */

/* 3600 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3602 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3606 */	NdrFcShort( 0x64 ),	/* 100 */
/* 3608 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3610 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3612 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3614 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3616 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3618 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3620 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3622 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3624 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter JrnLineHeight */

/* 3626 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3632 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3636 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLineSpacing */

/* 3638 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3640 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3644 */	NdrFcShort( 0x65 ),	/* 101 */
/* 3646 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3650 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3652 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3654 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3656 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3658 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3660 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3662 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLineSpacing */

/* 3664 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3666 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3668 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3670 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3672 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3674 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_JrnLineSpacing */

/* 3676 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3678 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3682 */	NdrFcShort( 0x66 ),	/* 102 */
/* 3684 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3686 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3688 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3690 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3692 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3694 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3696 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3698 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3700 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter JrnLineSpacing */

/* 3702 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3704 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3706 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3708 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3710 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3712 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnLineWidth */

/* 3714 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3716 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3720 */	NdrFcShort( 0x67 ),	/* 103 */
/* 3722 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3724 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3726 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3728 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3730 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3732 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3734 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3738 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnLineWidth */

/* 3740 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3742 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3744 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3746 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3748 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3750 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnNearEnd */

/* 3752 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3754 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3758 */	NdrFcShort( 0x68 ),	/* 104 */
/* 3760 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3764 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3766 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3768 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3770 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3772 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3774 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3776 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnNearEnd */

/* 3778 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3780 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3782 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3784 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3786 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3788 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_MapMode */

/* 3790 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3792 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3796 */	NdrFcShort( 0x69 ),	/* 105 */
/* 3798 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3802 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3804 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3806 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3808 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3810 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3812 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3814 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pMapMode */

/* 3816 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3818 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3820 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3822 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3824 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3826 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_MapMode */

/* 3828 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3830 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3834 */	NdrFcShort( 0x6a ),	/* 106 */
/* 3836 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3838 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3840 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3842 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3844 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3846 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3848 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3850 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3852 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter MapMode */

/* 3854 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3856 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3858 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 3860 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3862 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3864 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecEmpty */

/* 3866 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3868 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3872 */	NdrFcShort( 0x6b ),	/* 107 */
/* 3874 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3876 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3878 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3880 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3882 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3884 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3886 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3888 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3890 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecEmpty */

/* 3892 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3894 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3896 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3898 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3900 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3902 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLetterQuality */

/* 3904 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3906 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3910 */	NdrFcShort( 0x6c ),	/* 108 */
/* 3912 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3914 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3916 */	NdrFcShort( 0x22 ),	/* 34 */
/* 3918 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3920 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3922 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3924 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3926 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3928 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLetterQuality */

/* 3930 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 3932 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3934 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3936 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3938 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3940 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RecLetterQuality */

/* 3942 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3944 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3948 */	NdrFcShort( 0x6d ),	/* 109 */
/* 3950 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3952 */	NdrFcShort( 0x6 ),	/* 6 */
/* 3954 */	NdrFcShort( 0x8 ),	/* 8 */
/* 3956 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3958 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3960 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3962 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3964 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3966 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RecLetterQuality */

/* 3968 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 3970 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 3972 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 3974 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 3976 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 3978 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLineChars */

/* 3980 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 3982 */	NdrFcLong( 0x0 ),	/* 0 */
/* 3986 */	NdrFcShort( 0x6e ),	/* 110 */
/* 3988 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 3990 */	NdrFcShort( 0x0 ),	/* 0 */
/* 3992 */	NdrFcShort( 0x24 ),	/* 36 */
/* 3994 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 3996 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 3998 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4000 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4004 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLineChars */

/* 4006 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4008 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4010 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4012 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4014 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4016 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RecLineChars */

/* 4018 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4020 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4024 */	NdrFcShort( 0x6f ),	/* 111 */
/* 4026 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4028 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4030 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4032 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4034 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4036 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4038 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4040 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4042 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RecLineChars */

/* 4044 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4046 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4048 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4050 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4052 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4054 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLineCharsList */

/* 4056 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4058 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4062 */	NdrFcShort( 0x70 ),	/* 112 */
/* 4064 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4066 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4068 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4070 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 4072 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 4074 */	NdrFcShort( 0x1 ),	/* 1 */
/* 4076 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4080 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLineCharsList */

/* 4082 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 4084 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4086 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 4088 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4090 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4092 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLineHeight */

/* 4094 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4096 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4100 */	NdrFcShort( 0x71 ),	/* 113 */
/* 4102 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4104 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4106 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4108 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4110 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4112 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4114 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4116 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4118 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLineHeight */

/* 4120 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4122 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4124 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4126 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4128 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RecLineHeight */

/* 4132 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4134 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4138 */	NdrFcShort( 0x72 ),	/* 114 */
/* 4140 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4142 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4144 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4146 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4148 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4150 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4152 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4154 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4156 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RecLineHeight */

/* 4158 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4160 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4162 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4164 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4166 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4168 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLineSpacing */

/* 4170 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4172 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4176 */	NdrFcShort( 0x73 ),	/* 115 */
/* 4178 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4180 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4182 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4184 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4186 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4188 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4190 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4192 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4194 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLineSpacing */

/* 4196 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4198 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4200 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4202 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4204 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4206 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RecLineSpacing */

/* 4208 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4210 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4214 */	NdrFcShort( 0x74 ),	/* 116 */
/* 4216 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4218 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4220 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4222 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4224 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4226 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4228 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4230 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4232 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RecLineSpacing */

/* 4234 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4236 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4238 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4240 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4242 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4244 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLinesToPaperCut */

/* 4246 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4248 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4252 */	NdrFcShort( 0x75 ),	/* 117 */
/* 4254 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4256 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4258 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4260 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4262 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4264 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4266 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4268 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4270 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLinesToPaperCut */

/* 4272 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4274 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4276 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4278 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4280 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4282 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecLineWidth */

/* 4284 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4286 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4290 */	NdrFcShort( 0x76 ),	/* 118 */
/* 4292 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4294 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4296 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4298 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4300 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4302 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4304 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4306 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4308 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecLineWidth */

/* 4310 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4312 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4314 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4316 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4318 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4320 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecNearEnd */

/* 4322 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4324 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4328 */	NdrFcShort( 0x77 ),	/* 119 */
/* 4330 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4332 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4334 */	NdrFcShort( 0x22 ),	/* 34 */
/* 4336 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4338 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4340 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4342 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4344 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4346 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecNearEnd */

/* 4348 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4350 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4352 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 4354 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4356 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4358 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecSidewaysMaxChars */

/* 4360 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4362 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4366 */	NdrFcShort( 0x78 ),	/* 120 */
/* 4368 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4370 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4372 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4374 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4376 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4378 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4380 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4382 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4384 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecSidewaysMaxChars */

/* 4386 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4388 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4390 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4392 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4394 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4396 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecSidewaysMaxLines */

/* 4398 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4400 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4404 */	NdrFcShort( 0x79 ),	/* 121 */
/* 4406 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4408 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4410 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4412 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4414 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4416 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4418 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4420 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4422 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecSidewaysMaxLines */

/* 4424 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4426 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4428 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4430 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4432 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4434 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpEmpty */

/* 4436 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4438 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4442 */	NdrFcShort( 0x7a ),	/* 122 */
/* 4444 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4446 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4448 */	NdrFcShort( 0x22 ),	/* 34 */
/* 4450 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4452 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4454 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4456 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4458 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4460 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpEmpty */

/* 4462 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4464 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4466 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 4468 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4470 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4472 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLetterQuality */

/* 4474 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4476 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4480 */	NdrFcShort( 0x7b ),	/* 123 */
/* 4482 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4484 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4486 */	NdrFcShort( 0x22 ),	/* 34 */
/* 4488 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4490 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4492 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4494 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4496 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4498 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLetterQuality */

/* 4500 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4502 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4504 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 4506 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4508 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4510 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_SlpLetterQuality */

/* 4512 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4514 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4518 */	NdrFcShort( 0x7c ),	/* 124 */
/* 4520 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4522 */	NdrFcShort( 0x6 ),	/* 6 */
/* 4524 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4526 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4528 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4530 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4532 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4534 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4536 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter SlpLetterQuality */

/* 4538 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4540 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4542 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 4544 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4546 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4548 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLineChars */

/* 4550 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4552 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4556 */	NdrFcShort( 0x7d ),	/* 125 */
/* 4558 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4560 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4562 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4564 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4566 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4570 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4574 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLineChars */

/* 4576 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4578 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4580 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4582 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4584 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_SlpLineChars */

/* 4588 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4590 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4594 */	NdrFcShort( 0x7e ),	/* 126 */
/* 4596 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4598 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4600 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4602 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4604 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4606 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4610 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4612 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter SlpLineChars */

/* 4614 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4616 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4618 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4620 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4622 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4624 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLineCharsList */

/* 4626 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4628 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4632 */	NdrFcShort( 0x7f ),	/* 127 */
/* 4634 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4636 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4638 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4640 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 4642 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 4644 */	NdrFcShort( 0x1 ),	/* 1 */
/* 4646 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4648 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4650 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLineCharsList */

/* 4652 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 4654 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4656 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 4658 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4660 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4662 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLineHeight */

/* 4664 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4666 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4670 */	NdrFcShort( 0x80 ),	/* 128 */
/* 4672 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4674 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4676 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4678 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4680 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4682 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4684 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4686 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4688 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLineHeight */

/* 4690 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4692 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4694 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4696 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4698 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4700 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_SlpLineHeight */

/* 4702 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4704 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4708 */	NdrFcShort( 0x81 ),	/* 129 */
/* 4710 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4712 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4714 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4716 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4718 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4720 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4722 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4724 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4726 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter SlpLineHeight */

/* 4728 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4730 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4732 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4734 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4736 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4738 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLinesNearEndToEnd */

/* 4740 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4742 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4746 */	NdrFcShort( 0x82 ),	/* 130 */
/* 4748 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4750 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4752 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4754 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4756 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4758 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4760 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4762 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4764 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLinesNearEndToEnd */

/* 4766 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4768 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4770 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4772 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4774 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4776 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLineSpacing */

/* 4778 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4780 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4784 */	NdrFcShort( 0x83 ),	/* 131 */
/* 4786 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4788 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4790 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4792 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4794 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4796 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4798 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4800 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4802 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLineSpacing */

/* 4804 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4806 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4808 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4810 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4812 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4814 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_SlpLineSpacing */

/* 4816 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4818 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4822 */	NdrFcShort( 0x84 ),	/* 132 */
/* 4824 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4826 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4828 */	NdrFcShort( 0x8 ),	/* 8 */
/* 4830 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4832 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4834 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4836 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4838 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4840 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter SlpLineSpacing */

/* 4842 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 4844 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4846 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4848 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4850 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4852 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpLineWidth */

/* 4854 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4856 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4860 */	NdrFcShort( 0x85 ),	/* 133 */
/* 4862 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4864 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4866 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4868 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4870 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4872 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4874 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4876 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4878 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpLineWidth */

/* 4880 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4882 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4884 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4886 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4888 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4890 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpMaxLines */

/* 4892 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4894 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4898 */	NdrFcShort( 0x86 ),	/* 134 */
/* 4900 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4902 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4904 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4906 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4908 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4910 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4912 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4914 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4916 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpMaxLines */

/* 4918 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4920 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4922 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 4924 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4926 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4928 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpNearEnd */

/* 4930 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4932 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4936 */	NdrFcShort( 0x87 ),	/* 135 */
/* 4938 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4940 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4942 */	NdrFcShort( 0x22 ),	/* 34 */
/* 4944 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4946 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4948 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4950 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4952 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4954 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpNearEnd */

/* 4956 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4958 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4960 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 4962 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 4964 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 4966 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpSidewaysMaxChars */

/* 4968 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 4970 */	NdrFcLong( 0x0 ),	/* 0 */
/* 4974 */	NdrFcShort( 0x88 ),	/* 136 */
/* 4976 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 4978 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4980 */	NdrFcShort( 0x24 ),	/* 36 */
/* 4982 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 4984 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 4986 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4988 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4990 */	NdrFcShort( 0x0 ),	/* 0 */
/* 4992 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpSidewaysMaxChars */

/* 4994 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 4996 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 4998 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5000 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5002 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5004 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpSidewaysMaxLines */

/* 5006 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5008 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5012 */	NdrFcShort( 0x89 ),	/* 137 */
/* 5014 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5016 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5018 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5020 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5022 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5024 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5026 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5028 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5030 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpSidewaysMaxLines */

/* 5032 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5034 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5036 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5038 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5040 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5042 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure BeginInsertion */

/* 5044 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5046 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5050 */	NdrFcShort( 0x8a ),	/* 138 */
/* 5052 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5054 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5056 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5058 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5060 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5062 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5064 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5066 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5068 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Timeout */

/* 5070 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5072 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5074 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5076 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5078 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5080 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5082 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5084 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5086 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure BeginRemoval */

/* 5088 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5090 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5094 */	NdrFcShort( 0x8b ),	/* 139 */
/* 5096 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5098 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5100 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5102 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5104 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5106 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5108 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5110 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5112 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Timeout */

/* 5114 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5116 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5118 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5120 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5122 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5124 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5126 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5128 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5130 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CutPaper */

/* 5132 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5134 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5138 */	NdrFcShort( 0x8c ),	/* 140 */
/* 5140 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5142 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5144 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5146 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 5148 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5150 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5152 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5154 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5156 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Percentage */

/* 5158 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5160 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5162 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5164 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5166 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5168 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5170 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5172 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5174 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure EndInsertion */

/* 5176 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5178 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5182 */	NdrFcShort( 0x8d ),	/* 141 */
/* 5184 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5186 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5188 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5190 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5192 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5194 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5196 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5198 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5200 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 5202 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5204 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5206 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5208 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5210 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5212 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure EndRemoval */

/* 5214 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5216 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5220 */	NdrFcShort( 0x8e ),	/* 142 */
/* 5222 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5224 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5226 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5228 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5230 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5232 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5234 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5236 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5238 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 5240 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5242 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5244 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5246 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5248 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5250 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintBarCode */

/* 5252 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5254 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5258 */	NdrFcShort( 0x8f ),	/* 143 */
/* 5260 */	NdrFcShort( 0x50 ),	/* X64 Stack size/offset = 80 */
/* 5262 */	NdrFcShort( 0x30 ),	/* 48 */
/* 5264 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5266 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x9,		/* 9 */
/* 5268 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5270 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5272 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5274 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5276 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 5278 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5280 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5282 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 5284 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5286 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5288 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter Symbology */

/* 5290 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5292 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5294 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Height */

/* 5296 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5298 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5300 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Width */

/* 5302 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5304 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5306 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Alignment */

/* 5308 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5310 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 5312 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter TextPosition */

/* 5314 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5316 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 5318 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5320 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5322 */	NdrFcShort( 0x40 ),	/* X64 Stack size/offset = 64 */
/* 5324 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5326 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5328 */	NdrFcShort( 0x48 ),	/* X64 Stack size/offset = 72 */
/* 5330 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintBitmap */

/* 5332 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5334 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5338 */	NdrFcShort( 0x90 ),	/* 144 */
/* 5340 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 5342 */	NdrFcShort( 0x18 ),	/* 24 */
/* 5344 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5346 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x6,		/* 6 */
/* 5348 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5350 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5352 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5354 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5356 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 5358 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5360 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5362 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter FileName */

/* 5364 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5366 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5368 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter Width */

/* 5370 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5372 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5374 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Alignment */

/* 5376 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5378 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5380 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5382 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5384 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5386 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5388 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5390 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 5392 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintImmediate */

/* 5394 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5396 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5400 */	NdrFcShort( 0x91 ),	/* 145 */
/* 5402 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5404 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5406 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5408 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 5410 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5412 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5414 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5416 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5418 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 5420 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5422 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5424 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 5426 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5428 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5430 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 5432 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5434 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5436 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5438 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5440 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5442 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintNormal */

/* 5444 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5446 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5450 */	NdrFcShort( 0x92 ),	/* 146 */
/* 5452 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5454 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5456 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5458 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 5460 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5462 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5464 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5466 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5468 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 5470 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5472 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5474 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 5476 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5478 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5480 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 5482 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5484 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5486 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5488 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5490 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5492 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintTwoNormal */

/* 5494 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5496 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5500 */	NdrFcShort( 0x93 ),	/* 147 */
/* 5502 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 5504 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5506 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5508 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x5,		/* 5 */
/* 5510 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5512 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5514 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5516 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5518 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Stations */

/* 5520 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5522 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5524 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data1 */

/* 5526 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5528 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5530 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter Data2 */

/* 5532 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5534 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5536 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 5538 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5540 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5542 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5544 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5546 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5548 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure RotatePrint */

/* 5550 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5552 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5556 */	NdrFcShort( 0x94 ),	/* 148 */
/* 5558 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5560 */	NdrFcShort( 0x10 ),	/* 16 */
/* 5562 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5564 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 5566 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5570 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5574 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 5576 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5578 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5580 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Rotation */

/* 5582 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5584 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5586 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5588 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5590 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5596 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SetBitmap */

/* 5600 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5602 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5606 */	NdrFcShort( 0x95 ),	/* 149 */
/* 5608 */	NdrFcShort( 0x40 ),	/* X64 Stack size/offset = 64 */
/* 5610 */	NdrFcShort( 0x20 ),	/* 32 */
/* 5612 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5614 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x7,		/* 7 */
/* 5616 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5618 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5620 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5622 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5624 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter BitmapNumber */

/* 5626 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Station */

/* 5632 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5636 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter FileName */

/* 5638 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5640 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5642 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter Width */

/* 5644 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5646 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5648 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Alignment */

/* 5650 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5652 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5654 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 5656 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5658 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 5660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5662 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5664 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 5666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure SetLogo */

/* 5668 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5670 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5674 */	NdrFcShort( 0x96 ),	/* 150 */
/* 5676 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 5678 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5680 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5682 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 5684 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 5686 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5688 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5690 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5692 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Location */

/* 5694 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 5696 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5698 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 5700 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 5702 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5704 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 5706 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5708 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5710 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5712 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5714 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 5716 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapCharacterSet */

/* 5718 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5720 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5724 */	NdrFcShort( 0x97 ),	/* 151 */
/* 5726 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5728 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5730 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5732 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5734 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5736 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5738 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5740 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5742 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapCharacterSet */

/* 5744 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5746 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5748 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5750 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5752 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5754 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapTransaction */

/* 5756 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5758 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5762 */	NdrFcShort( 0x98 ),	/* 152 */
/* 5764 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5766 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5768 */	NdrFcShort( 0x22 ),	/* 34 */
/* 5770 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5772 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5774 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5776 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5778 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5780 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapTransaction */

/* 5782 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5784 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5786 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 5788 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5790 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5792 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ErrorLevel */

/* 5794 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5796 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5800 */	NdrFcShort( 0x99 ),	/* 153 */
/* 5802 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5804 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5806 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5808 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5810 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5812 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5814 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5816 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5818 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pErrorLevel */

/* 5820 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5822 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5824 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5826 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5828 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5830 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_ErrorString */

/* 5832 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5834 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5838 */	NdrFcShort( 0x9a ),	/* 154 */
/* 5840 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5842 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5844 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5846 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 5848 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 5850 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5852 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5854 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5856 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pErrorString */

/* 5858 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 5860 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5862 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 5864 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5866 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5868 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_FontTypefaceList */

/* 5870 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5872 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5876 */	NdrFcShort( 0x9b ),	/* 155 */
/* 5878 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5880 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5882 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5884 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 5886 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 5888 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5890 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5892 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5894 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pFontTypefaceList */

/* 5896 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 5898 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5900 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 5902 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5904 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5906 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecBarCodeRotationList */

/* 5908 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5910 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5914 */	NdrFcShort( 0x9c ),	/* 156 */
/* 5916 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5918 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5920 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5922 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 5924 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 5926 */	NdrFcShort( 0x1 ),	/* 1 */
/* 5928 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5930 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5932 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecBarCodeRotationList */

/* 5934 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 5936 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5938 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 5940 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5942 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5944 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RotateSpecial */

/* 5946 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5948 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5952 */	NdrFcShort( 0x9d ),	/* 157 */
/* 5954 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5956 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5958 */	NdrFcShort( 0x24 ),	/* 36 */
/* 5960 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 5962 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 5964 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5966 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5968 */	NdrFcShort( 0x0 ),	/* 0 */
/* 5970 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRotateSpecial */

/* 5972 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 5974 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 5976 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 5978 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 5980 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 5982 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RotateSpecial */

/* 5984 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 5986 */	NdrFcLong( 0x0 ),	/* 0 */
/* 5990 */	NdrFcShort( 0x9e ),	/* 158 */
/* 5992 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 5994 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5996 */	NdrFcShort( 0x8 ),	/* 8 */
/* 5998 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6000 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6002 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6004 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6006 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6008 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RotateSpecial */

/* 6010 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6012 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6014 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6016 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6018 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6020 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpBarCodeRotationList */

/* 6022 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6024 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6028 */	NdrFcShort( 0x9f ),	/* 159 */
/* 6030 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6032 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6034 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6036 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 6038 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 6040 */	NdrFcShort( 0x1 ),	/* 1 */
/* 6042 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6044 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6046 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpBarCodeRotationList */

/* 6048 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 6050 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6052 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 6054 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6056 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6058 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure TransactionPrint */

/* 6060 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6062 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6066 */	NdrFcShort( 0xa0 ),	/* 160 */
/* 6068 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 6070 */	NdrFcShort( 0x10 ),	/* 16 */
/* 6072 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6074 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x4,		/* 4 */
/* 6076 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6078 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6080 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6082 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6084 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 6086 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6088 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6090 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Control */

/* 6092 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6094 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6096 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 6098 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6100 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6102 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6104 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6106 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 6108 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ValidateData */

/* 6110 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6112 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6116 */	NdrFcShort( 0xa1 ),	/* 161 */
/* 6118 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 6120 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6122 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6124 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 6126 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 6128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6130 */	NdrFcShort( 0x1 ),	/* 1 */
/* 6132 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6134 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 6136 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6138 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 6142 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 6144 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6146 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 6148 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6150 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6152 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6154 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6156 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 6158 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_BinaryConversion */

/* 6160 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6162 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6166 */	NdrFcShort( 0xa2 ),	/* 162 */
/* 6168 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6170 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6172 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6174 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6176 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6178 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6180 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6182 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6184 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pBinaryConversion */

/* 6186 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6188 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6190 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6192 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6194 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6196 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_BinaryConversion */

/* 6198 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6200 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6204 */	NdrFcShort( 0xa3 ),	/* 163 */
/* 6206 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6208 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6210 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6212 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6214 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6216 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6218 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6220 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6222 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter BinaryConversion */

/* 6224 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6226 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6228 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6230 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6232 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6234 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapPowerReporting */

/* 6236 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6238 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6242 */	NdrFcShort( 0xa4 ),	/* 164 */
/* 6244 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6246 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6248 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6250 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6252 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6254 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6256 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6260 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapPowerReporting */

/* 6262 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6264 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6266 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6268 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6270 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6272 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerNotify */

/* 6274 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6276 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6280 */	NdrFcShort( 0xa5 ),	/* 165 */
/* 6282 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6284 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6286 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6288 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6290 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6292 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6294 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6296 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6298 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerNotify */

/* 6300 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6302 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6304 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6306 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6308 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6310 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PowerNotify */

/* 6312 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6314 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6318 */	NdrFcShort( 0xa6 ),	/* 166 */
/* 6320 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6322 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6324 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6326 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6328 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6332 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6334 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6336 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PowerNotify */

/* 6338 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6340 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6342 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6344 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6346 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6348 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PowerState */

/* 6350 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6352 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6356 */	NdrFcShort( 0xa7 ),	/* 167 */
/* 6358 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6360 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6362 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6364 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6366 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6368 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6370 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6372 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6374 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPowerState */

/* 6376 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6378 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6380 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6382 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6384 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6386 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnCartridgeSensor */

/* 6388 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6390 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6394 */	NdrFcShort( 0xa8 ),	/* 168 */
/* 6396 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6398 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6400 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6402 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6404 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6406 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6408 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6410 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6412 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnCartridgeSensor */

/* 6414 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6416 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6418 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6420 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6422 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6424 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapJrnColor */

/* 6426 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6428 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6432 */	NdrFcShort( 0xa9 ),	/* 169 */
/* 6434 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6436 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6438 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6440 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6442 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6444 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6446 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6448 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6450 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapJrnColor */

/* 6452 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6454 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6456 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6458 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6460 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6462 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecCartridgeSensor */

/* 6464 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6466 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6470 */	NdrFcShort( 0xaa ),	/* 170 */
/* 6472 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6474 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6476 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6478 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6480 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6484 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6486 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6488 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecCartridgeSensor */

/* 6490 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6492 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6494 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6496 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6498 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6500 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecColor */

/* 6502 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6504 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6508 */	NdrFcShort( 0xab ),	/* 171 */
/* 6510 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6512 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6514 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6516 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6518 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6522 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6524 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6526 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecColor */

/* 6528 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6530 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6532 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6534 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6536 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6538 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecMarkFeed */

/* 6540 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6542 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6546 */	NdrFcShort( 0xac ),	/* 172 */
/* 6548 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6550 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6552 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6554 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6556 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6558 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6560 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6562 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6564 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecMarkFeed */

/* 6566 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6568 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6570 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6572 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6574 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6576 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpBothSidesPrint */

/* 6578 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6580 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6584 */	NdrFcShort( 0xad ),	/* 173 */
/* 6586 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6588 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6590 */	NdrFcShort( 0x22 ),	/* 34 */
/* 6592 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6594 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6596 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6598 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6600 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6602 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpBothSidesPrint */

/* 6604 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6606 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6608 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 6610 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6612 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6614 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpCartridgeSensor */

/* 6616 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6618 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6622 */	NdrFcShort( 0xae ),	/* 174 */
/* 6624 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6626 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6628 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6630 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6632 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6634 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6636 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6638 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6640 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpCartridgeSensor */

/* 6642 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6644 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6646 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6648 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6650 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6652 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpColor */

/* 6654 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6656 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6660 */	NdrFcShort( 0xaf ),	/* 175 */
/* 6662 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6664 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6666 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6668 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6670 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6672 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6674 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6676 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6678 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpColor */

/* 6680 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6682 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6684 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6686 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6688 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6690 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CartridgeNotify */

/* 6692 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6694 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6698 */	NdrFcShort( 0xb0 ),	/* 176 */
/* 6700 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6702 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6704 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6706 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6708 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6710 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6712 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6714 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6716 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCartridgeNotify */

/* 6718 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6720 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6722 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6724 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6726 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6728 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_CartridgeNotify */

/* 6730 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6732 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6736 */	NdrFcShort( 0xb1 ),	/* 177 */
/* 6738 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6740 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6742 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6744 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6746 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6748 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6750 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6752 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6754 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter CartridgeNotify */

/* 6756 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6758 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6760 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6762 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6764 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6766 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnCartridgeState */

/* 6768 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6770 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6774 */	NdrFcShort( 0xb2 ),	/* 178 */
/* 6776 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6778 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6780 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6782 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6784 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6786 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6788 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6790 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6792 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnCartridgeState */

/* 6794 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6796 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6798 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6800 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6802 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6804 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_JrnCurrentCartridge */

/* 6806 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6808 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6812 */	NdrFcShort( 0xb3 ),	/* 179 */
/* 6814 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6816 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6818 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6820 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6822 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6824 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6826 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6828 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6830 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pJrnCurrentCartridge */

/* 6832 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6834 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6836 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6838 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6840 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6842 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_JrnCurrentCartridge */

/* 6844 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6846 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6850 */	NdrFcShort( 0xb4 ),	/* 180 */
/* 6852 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6854 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6856 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6858 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6860 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6864 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6866 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6868 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter JrnCurrentCartridge */

/* 6870 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6872 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6874 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6876 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6878 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6880 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecCartridgeState */

/* 6882 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6884 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6888 */	NdrFcShort( 0xb5 ),	/* 181 */
/* 6890 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6892 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6894 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6896 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6898 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6900 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6902 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6904 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6906 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecCartridgeState */

/* 6908 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6910 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6912 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6914 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6916 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6918 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecCurrentCartridge */

/* 6920 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6922 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6926 */	NdrFcShort( 0xb6 ),	/* 182 */
/* 6928 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6930 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6932 */	NdrFcShort( 0x24 ),	/* 36 */
/* 6934 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6936 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6938 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6940 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6942 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6944 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecCurrentCartridge */

/* 6946 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 6948 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6950 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6952 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6954 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6956 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_RecCurrentCartridge */

/* 6958 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6960 */	NdrFcLong( 0x0 ),	/* 0 */
/* 6964 */	NdrFcShort( 0xb7 ),	/* 183 */
/* 6966 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 6968 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6970 */	NdrFcShort( 0x8 ),	/* 8 */
/* 6972 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 6974 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 6976 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6978 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6980 */	NdrFcShort( 0x0 ),	/* 0 */
/* 6982 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter RecCurrentCartridge */

/* 6984 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 6986 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 6988 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 6990 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 6992 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 6994 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpCartridgeState */

/* 6996 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 6998 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7002 */	NdrFcShort( 0xb8 ),	/* 184 */
/* 7004 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7006 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7008 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7010 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7012 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7016 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7018 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7020 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpCartridgeState */

/* 7022 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7024 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7026 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7028 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7030 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7032 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpCurrentCartridge */

/* 7034 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7036 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7040 */	NdrFcShort( 0xb9 ),	/* 185 */
/* 7042 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7044 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7046 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7048 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7050 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7054 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7056 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7058 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpCurrentCartridge */

/* 7060 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7062 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7064 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7066 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7068 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7070 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_SlpCurrentCartridge */

/* 7072 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7074 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7078 */	NdrFcShort( 0xba ),	/* 186 */
/* 7080 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7082 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7084 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7086 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7088 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7092 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7094 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7096 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter SlpCurrentCartridge */

/* 7098 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 7100 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7102 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7104 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7106 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7108 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpPrintSide */

/* 7110 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7112 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7116 */	NdrFcShort( 0xbb ),	/* 187 */
/* 7118 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7120 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7122 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7124 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7126 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7128 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7130 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7132 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7134 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpPrintSide */

/* 7136 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7138 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7140 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7142 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7144 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7146 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ChangePrintSide */

/* 7148 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7150 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7154 */	NdrFcShort( 0xbc ),	/* 188 */
/* 7156 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7158 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7160 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7162 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 7164 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7166 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7168 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7170 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7172 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Side */

/* 7174 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 7176 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7178 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 7180 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7182 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7184 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7186 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7188 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7190 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure MarkFeed */

/* 7192 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7194 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7198 */	NdrFcShort( 0xbd ),	/* 189 */
/* 7200 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7202 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7204 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7206 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 7208 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7210 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7212 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7214 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7216 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Type */

/* 7218 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 7220 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7222 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 7224 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7226 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7228 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7230 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7232 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7234 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapMapCharacterSet */

/* 7236 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7238 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7242 */	NdrFcShort( 0xbe ),	/* 190 */
/* 7244 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7246 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7248 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7250 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7252 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7254 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7256 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7258 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7260 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapMapCharacterSet */

/* 7262 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7264 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7266 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7268 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7270 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7272 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_MapCharacterSet */

/* 7274 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7276 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7280 */	NdrFcShort( 0xbf ),	/* 191 */
/* 7282 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7284 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7286 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7288 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7290 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7292 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7294 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7296 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7298 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pMapCharacterSet */

/* 7300 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7302 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7304 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7306 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7308 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7310 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_MapCharacterSet */

/* 7312 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7314 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7318 */	NdrFcShort( 0xc0 ),	/* 192 */
/* 7320 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7322 */	NdrFcShort( 0x6 ),	/* 6 */
/* 7324 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7326 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7328 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7330 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7332 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7334 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7336 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter MapCharacterSet */

/* 7338 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 7340 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7342 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7344 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7346 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7348 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_RecBitmapRotationList */

/* 7350 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7352 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7356 */	NdrFcShort( 0xc1 ),	/* 193 */
/* 7358 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7360 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7362 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7364 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 7366 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 7368 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7370 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7372 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7374 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRecBitmapRotationList */

/* 7376 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 7378 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7380 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 7382 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7384 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7386 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_SlpBitmapRotationList */

/* 7388 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7390 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7394 */	NdrFcShort( 0xc2 ),	/* 194 */
/* 7396 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7398 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7400 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7402 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 7404 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 7406 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7408 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7410 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7412 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pSlpBitmapRotationList */

/* 7414 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 7416 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7418 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 7420 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7422 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7424 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapStatisticsReporting */

/* 7426 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7428 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7432 */	NdrFcShort( 0xc3 ),	/* 195 */
/* 7434 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7436 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7438 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7440 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7442 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7444 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7446 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7448 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7450 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapStatisticsReporting */

/* 7452 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7454 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7456 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7458 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7460 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7462 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateStatistics */

/* 7464 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7466 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7470 */	NdrFcShort( 0xc4 ),	/* 196 */
/* 7472 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7474 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7476 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7478 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7480 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7482 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7484 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7486 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7488 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateStatistics */

/* 7490 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7492 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7494 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7496 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7498 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7500 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ResetStatistics */

/* 7502 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7504 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7508 */	NdrFcShort( 0xc5 ),	/* 197 */
/* 7510 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7512 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7514 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7516 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 7518 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 7520 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7522 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7524 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7526 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 7528 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 7530 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7532 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 7534 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7536 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7538 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7540 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7542 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7544 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure RetrieveStatistics */

/* 7546 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7548 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7552 */	NdrFcShort( 0xc6 ),	/* 198 */
/* 7554 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7556 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7558 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7560 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 7562 */	0xa,		/* 10 */
			0x47,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, has range on conformance */
/* 7564 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7566 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7568 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7570 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pStatisticsBuffer */

/* 7572 */	NdrFcShort( 0x11b ),	/* Flags:  must size, must free, in, out, simple ref, */
/* 7574 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7576 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Parameter pRC */

/* 7578 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7580 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7582 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7584 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7586 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7588 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateStatistics */

/* 7590 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7592 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7596 */	NdrFcShort( 0xc7 ),	/* 199 */
/* 7598 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7600 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7602 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7604 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 7606 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 7608 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7610 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7612 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7614 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter StatisticsBuffer */

/* 7616 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 7618 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7620 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 7622 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7624 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7626 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7628 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7630 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7632 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapCompareFirmwareVersion */

/* 7634 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7636 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7640 */	NdrFcShort( 0xc8 ),	/* 200 */
/* 7642 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7644 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7646 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7648 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7650 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7652 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7654 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7656 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7658 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapCompareFirmwareVersion */

/* 7660 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7662 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7664 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7666 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7668 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7670 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapUpdateFirmware */

/* 7672 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7674 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7678 */	NdrFcShort( 0xc9 ),	/* 201 */
/* 7680 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7682 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7684 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7686 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7688 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7690 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7692 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7694 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7696 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapUpdateFirmware */

/* 7698 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7700 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7702 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7704 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7706 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7708 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CompareFirmwareVersion */

/* 7710 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7712 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7716 */	NdrFcShort( 0xca ),	/* 202 */
/* 7718 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 7720 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7722 */	NdrFcShort( 0x40 ),	/* 64 */
/* 7724 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x4,		/* 4 */
/* 7726 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 7728 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7730 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7732 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7734 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 7736 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 7738 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7740 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pResult */

/* 7742 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7744 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7746 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 7748 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7750 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7752 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7754 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7756 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7758 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure UpdateFirmware */

/* 7760 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7762 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7766 */	NdrFcShort( 0xcb ),	/* 203 */
/* 7768 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 7770 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7772 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7774 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x3,		/* 3 */
/* 7776 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 7778 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7780 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7782 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7784 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter FirmwareFileName */

/* 7786 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 7788 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7790 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter pRC */

/* 7792 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7794 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7796 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7798 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7800 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7802 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapConcurrentPageMode */

/* 7804 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7806 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7810 */	NdrFcShort( 0xcc ),	/* 204 */
/* 7812 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7814 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7816 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7818 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7820 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7822 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7824 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7826 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7828 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapConcurrentPageMode */

/* 7830 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7832 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7834 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7836 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7838 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7840 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecPageMode */

/* 7842 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7844 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7848 */	NdrFcShort( 0xcd ),	/* 205 */
/* 7850 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7852 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7854 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7856 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7858 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7860 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7862 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7864 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7866 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecPageMode */

/* 7868 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7870 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7872 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7874 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7876 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7878 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpPageMode */

/* 7880 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7882 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7886 */	NdrFcShort( 0xce ),	/* 206 */
/* 7888 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7890 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7892 */	NdrFcShort( 0x22 ),	/* 34 */
/* 7894 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7896 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7898 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7900 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7902 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7904 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpPageMode */

/* 7906 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7908 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7910 */	0x6,		/* FC_SHORT */
			0x0,		/* 0 */

	/* Return value */

/* 7912 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7914 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7916 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModeArea */

/* 7918 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7920 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7924 */	NdrFcShort( 0xcf ),	/* 207 */
/* 7926 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7928 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7930 */	NdrFcShort( 0x8 ),	/* 8 */
/* 7932 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 7934 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 7936 */	NdrFcShort( 0x1 ),	/* 1 */
/* 7938 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7940 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7942 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModeArea */

/* 7944 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 7946 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7948 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 7950 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7952 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7954 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModeDescriptor */

/* 7956 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7958 */	NdrFcLong( 0x0 ),	/* 0 */
/* 7962 */	NdrFcShort( 0xd0 ),	/* 208 */
/* 7964 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 7966 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7968 */	NdrFcShort( 0x24 ),	/* 36 */
/* 7970 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 7972 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 7974 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7976 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7978 */	NdrFcShort( 0x0 ),	/* 0 */
/* 7980 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModeDescriptor */

/* 7982 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 7984 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 7986 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 7988 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 7990 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 7992 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModeHorizontalPosition */

/* 7994 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 7996 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8000 */	NdrFcShort( 0xd1 ),	/* 209 */
/* 8002 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8004 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8006 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8008 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8010 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8012 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8014 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8016 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8018 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModeHorizontalPosition */

/* 8020 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8022 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8024 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8026 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8028 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8030 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PageModeHorizontalPosition */

/* 8032 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8034 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8038 */	NdrFcShort( 0xd2 ),	/* 210 */
/* 8040 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8042 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8044 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8046 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8048 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8050 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8052 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8054 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8056 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PageModeHorizontalPosition */

/* 8058 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8060 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8062 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8064 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8066 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8068 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModePrintArea */

/* 8070 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8072 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8076 */	NdrFcShort( 0xd3 ),	/* 211 */
/* 8078 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8080 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8082 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8084 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x2,		/* 2 */
/* 8086 */	0xa,		/* 10 */
			0x43,		/* Ext Flags:  new corr desc, clt corr check, has range on conformance */
/* 8088 */	NdrFcShort( 0x1 ),	/* 1 */
/* 8090 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8092 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8094 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModePrintArea */

/* 8096 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 8098 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8100 */	NdrFcShort( 0x2e ),	/* Type Offset=46 */

	/* Return value */

/* 8102 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8104 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8106 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PageModePrintArea */

/* 8108 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8110 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8114 */	NdrFcShort( 0xd4 ),	/* 212 */
/* 8116 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8118 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8120 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8122 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x2,		/* 2 */
/* 8124 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 8126 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8128 */	NdrFcShort( 0x1 ),	/* 1 */
/* 8130 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8132 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PageModePrintArea */

/* 8134 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 8136 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8138 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Return value */

/* 8140 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8142 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8144 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModePrintDirection */

/* 8146 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8148 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8152 */	NdrFcShort( 0xd5 ),	/* 213 */
/* 8154 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8156 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8158 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8160 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8162 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8164 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8166 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8168 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8170 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModePrintDirection */

/* 8172 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8174 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8176 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8178 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8180 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8182 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PageModePrintDirection */

/* 8184 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8186 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8190 */	NdrFcShort( 0xd6 ),	/* 214 */
/* 8192 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8194 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8196 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8198 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8200 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8202 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8204 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8206 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8208 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PageModePrintDirection */

/* 8210 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8212 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8214 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8216 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8218 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8220 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModeStation */

/* 8222 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8224 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8228 */	NdrFcShort( 0xd7 ),	/* 215 */
/* 8230 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8232 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8234 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8236 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8238 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8240 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8242 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8244 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8246 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModeStation */

/* 8248 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8250 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8252 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8254 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8256 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8258 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PageModeStation */

/* 8260 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8262 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8266 */	NdrFcShort( 0xd8 ),	/* 216 */
/* 8268 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8270 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8272 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8274 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8276 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8278 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8280 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8282 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8284 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PageModeStation */

/* 8286 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8288 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8290 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8292 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8294 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8296 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_PageModeVerticalPosition */

/* 8298 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8300 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8304 */	NdrFcShort( 0xd9 ),	/* 217 */
/* 8306 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8308 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8310 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8312 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8314 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8316 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8318 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8320 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8322 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pPageModeVerticalPosition */

/* 8324 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8326 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8328 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8330 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8332 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8334 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure put_PageModeVerticalPosition */

/* 8336 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8338 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8342 */	NdrFcShort( 0xda ),	/* 218 */
/* 8344 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8346 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8348 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8350 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8352 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8354 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8356 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8358 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8360 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter PageModeVerticalPosition */

/* 8362 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8364 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8366 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8368 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8370 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8372 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure ClearPrintArea */

/* 8374 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8376 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8380 */	NdrFcShort( 0xdb ),	/* 219 */
/* 8382 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8384 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8386 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8388 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8390 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8392 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8394 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8396 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8398 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pRC */

/* 8400 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8402 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8404 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8406 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8408 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8410 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PageModePrint */

/* 8412 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8414 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8418 */	NdrFcShort( 0xdc ),	/* 220 */
/* 8420 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 8422 */	NdrFcShort( 0x8 ),	/* 8 */
/* 8424 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8426 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 8428 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8430 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8432 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8434 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8436 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Control */

/* 8438 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8440 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8442 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 8444 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8446 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8448 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8450 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8452 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8454 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure PrintMemoryBitmap */

/* 8456 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8458 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8462 */	NdrFcShort( 0xdd ),	/* 221 */
/* 8464 */	NdrFcShort( 0x40 ),	/* X64 Stack size/offset = 64 */
/* 8466 */	NdrFcShort( 0x20 ),	/* 32 */
/* 8468 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8470 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x7,		/* 7 */
/* 8472 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 8474 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8476 */	NdrFcShort( 0x1 ),	/* 1 */
/* 8478 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8480 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 8482 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8484 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8486 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Data */

/* 8488 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 8490 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8492 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter Type */

/* 8494 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8496 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8498 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Width */

/* 8500 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8502 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 8504 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter Alignment */

/* 8506 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8508 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 8510 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 8512 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8514 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 8516 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8518 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8520 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 8522 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapRecRuledLine */

/* 8524 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8526 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8530 */	NdrFcShort( 0xde ),	/* 222 */
/* 8532 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8534 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8536 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8538 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8540 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8542 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8544 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8546 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8548 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapRecRuledLine */

/* 8550 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8552 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8554 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8556 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8558 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8560 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure get_CapSlpRuledLine */

/* 8562 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8564 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8568 */	NdrFcShort( 0xdf ),	/* 223 */
/* 8570 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8572 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8574 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8576 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x2,		/* 2 */
/* 8578 */	0xa,		/* 10 */
			0x41,		/* Ext Flags:  new corr desc, has range on conformance */
/* 8580 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8582 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8584 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8586 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter pCapSlpRuledLine */

/* 8588 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8590 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8592 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8594 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8596 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8598 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure DrawRuledLine */

/* 8600 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 8602 */	NdrFcLong( 0x0 ),	/* 0 */
/* 8606 */	NdrFcShort( 0xe0 ),	/* 224 */
/* 8608 */	NdrFcShort( 0x48 ),	/* X64 Stack size/offset = 72 */
/* 8610 */	NdrFcShort( 0x28 ),	/* 40 */
/* 8612 */	NdrFcShort( 0x24 ),	/* 36 */
/* 8614 */	0x46,		/* Oi2 Flags:  clt must size, has return, has ext, */
			0x8,		/* 8 */
/* 8616 */	0xa,		/* 10 */
			0x45,		/* Ext Flags:  new corr desc, srv corr check, has range on conformance */
/* 8618 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8620 */	NdrFcShort( 0x1 ),	/* 1 */
/* 8622 */	NdrFcShort( 0x0 ),	/* 0 */
/* 8624 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter Station */

/* 8626 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8628 */	NdrFcShort( 0x8 ),	/* X64 Stack size/offset = 8 */
/* 8630 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter PositionList */

/* 8632 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 8634 */	NdrFcShort( 0x10 ),	/* X64 Stack size/offset = 16 */
/* 8636 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter LineDirection */

/* 8638 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8640 */	NdrFcShort( 0x18 ),	/* X64 Stack size/offset = 24 */
/* 8642 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter LineWidth */

/* 8644 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8646 */	NdrFcShort( 0x20 ),	/* X64 Stack size/offset = 32 */
/* 8648 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter LineStyle */

/* 8650 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8652 */	NdrFcShort( 0x28 ),	/* X64 Stack size/offset = 40 */
/* 8654 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter LineColor */

/* 8656 */	NdrFcShort( 0x48 ),	/* Flags:  in, base type, */
/* 8658 */	NdrFcShort( 0x30 ),	/* X64 Stack size/offset = 48 */
/* 8660 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Parameter pRC */

/* 8662 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 8664 */	NdrFcShort( 0x38 ),	/* X64 Stack size/offset = 56 */
/* 8666 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 8668 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 8670 */	NdrFcShort( 0x40 ),	/* X64 Stack size/offset = 64 */
/* 8672 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const POSPrinter_MIDL_TYPE_FORMAT_STRING POSPrinter__MIDL_TypeFormatString =
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


/* Object interface: IOPOSPOSPrinter_1_5, ver. 0.0,
   GUID={0xCCB91151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_5_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192
    };



/* Object interface: IOPOSPOSPrinter_1_7, ver. 0.0,
   GUID={0xCCB92151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_7_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388
    };



/* Object interface: IOPOSPOSPrinter_1_8, ver. 0.0,
   GUID={0xCCB93151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_8_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590
    };



/* Object interface: IOPOSPOSPrinter_1_9, ver. 0.0,
   GUID={0xCCB94151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_9_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590,
    7634,
    7672,
    7710,
    7760,
    7804,
    7842,
    7880,
    7918,
    7956,
    7994,
    8032,
    8070,
    8108,
    8146,
    8184,
    8222,
    8260,
    8298,
    8336,
    8374,
    8412
    };



/* Object interface: IOPOSPOSPrinter_1_10, ver. 0.0,
   GUID={0xCCB95151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_10_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590,
    7634,
    7672,
    7710,
    7760,
    7804,
    7842,
    7880,
    7918,
    7956,
    7994,
    8032,
    8070,
    8108,
    8146,
    8184,
    8222,
    8260,
    8298,
    8336,
    8374,
    8412,
    8456
    };



/* Object interface: IOPOSPOSPrinter_1_10_zz, ver. 0.0,
   GUID={0xCCB96151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_10_zz_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590,
    7634,
    7672,
    7710,
    7760,
    7804,
    7842,
    7880,
    7918,
    7956,
    7994,
    8032,
    8070,
    8108,
    8146,
    8184,
    8222,
    8260,
    8298,
    8336,
    8374,
    8412,
    8456,
    0
    };



/* Object interface: IOPOSPOSPrinter_1_13, ver. 0.0,
   GUID={0xCCB97151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_1_13_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590,
    7634,
    7672,
    7710,
    7760,
    7804,
    7842,
    7880,
    7918,
    7956,
    7994,
    8032,
    8070,
    8108,
    8146,
    8184,
    8222,
    8260,
    8298,
    8336,
    8374,
    8412,
    8456,
    8524,
    8562,
    8600
    };



/* Object interface: IOPOSPOSPrinter, ver. 0.0,
   GUID={0xCCB98151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const unsigned short IOPOSPOSPrinter_FormatStringOffsetTable[] =
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
    948,
    992,
    1030,
    1068,
    1124,
    1168,
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
    1890,
    1928,
    1966,
    2004,
    2042,
    2080,
    2118,
    2156,
    2194,
    2232,
    2270,
    2308,
    2346,
    2384,
    2422,
    2460,
    2498,
    2536,
    2574,
    2612,
    2650,
    2688,
    2726,
    2764,
    2802,
    2840,
    2878,
    2916,
    2954,
    2992,
    3030,
    3068,
    3106,
    3144,
    3182,
    3220,
    3258,
    3296,
    3334,
    3372,
    3410,
    3448,
    3486,
    3524,
    3562,
    3600,
    3638,
    3676,
    3714,
    3752,
    3790,
    3828,
    3866,
    3904,
    3942,
    3980,
    4018,
    4056,
    4094,
    4132,
    4170,
    4208,
    4246,
    4284,
    4322,
    4360,
    4398,
    4436,
    4474,
    4512,
    4550,
    4588,
    4626,
    4664,
    4702,
    4740,
    4778,
    4816,
    4854,
    4892,
    4930,
    4968,
    5006,
    5044,
    5088,
    5132,
    5176,
    5214,
    5252,
    5332,
    5394,
    5444,
    5494,
    5550,
    5600,
    5668,
    5718,
    5756,
    5794,
    5832,
    5870,
    5908,
    5946,
    5984,
    6022,
    6060,
    6110,
    6160,
    6198,
    6236,
    6274,
    6312,
    6350,
    6388,
    6426,
    6464,
    6502,
    6540,
    6578,
    6616,
    6654,
    6692,
    6730,
    6768,
    6806,
    6844,
    6882,
    6920,
    6958,
    6996,
    7034,
    7072,
    7110,
    7148,
    7192,
    7236,
    7274,
    7312,
    7350,
    7388,
    7426,
    7464,
    7502,
    7546,
    7590,
    7634,
    7672,
    7710,
    7760,
    7804,
    7842,
    7880,
    7918,
    7956,
    7994,
    8032,
    8070,
    8108,
    8146,
    8184,
    8222,
    8260,
    8298,
    8336,
    8374,
    8412,
    8456,
    8524,
    8562,
    8600,
    0
    };



#endif /* defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the proxy stub code */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for POSPrinter.idl:
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
__midl_frag950_t;
extern const __midl_frag950_t __midl_frag950;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag948_t;
extern const __midl_frag948_t __midl_frag948;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag943_t;
extern const __midl_frag943_t __midl_frag943;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag942_t;
extern const __midl_frag942_t __midl_frag942;

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
    struct _NDR64_PARAM_FORMAT frag8;
    struct _NDR64_PARAM_FORMAT frag9;
}
__midl_frag940_t;
extern const __midl_frag940_t __midl_frag940;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag936_t;
extern const __midl_frag936_t __midl_frag936;

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
    struct _NDR64_PARAM_FORMAT frag8;
}
__midl_frag922_t;
extern const __midl_frag922_t __midl_frag922;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag917_t;
extern const __midl_frag917_t __midl_frag917;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag910_t;
extern const __midl_frag910_t __midl_frag910;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag907_t;
extern const __midl_frag907_t __midl_frag907;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag888_t;
extern const __midl_frag888_t __midl_frag888;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag886_t;
extern const __midl_frag886_t __midl_frag886;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag885_t;
extern const __midl_frag885_t __midl_frag885;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag884_t;
extern const __midl_frag884_t __midl_frag884;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag883_t;
extern const __midl_frag883_t __midl_frag883;

typedef 
NDR64_FORMAT_CHAR
__midl_frag865_t;
extern const __midl_frag865_t __midl_frag865;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag864_t;
extern const __midl_frag864_t __midl_frag864;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag863_t;
extern const __midl_frag863_t __midl_frag863;

typedef 
NDR64_FORMAT_CHAR
__midl_frag862_t;
extern const __midl_frag862_t __midl_frag862;

typedef 
NDR64_FORMAT_CHAR
__midl_frag861_t;
extern const __midl_frag861_t __midl_frag861;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag860_t;
extern const __midl_frag860_t __midl_frag860;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag859_t;
extern const __midl_frag859_t __midl_frag859;

typedef 
NDR64_FORMAT_CHAR
__midl_frag858_t;
extern const __midl_frag858_t __midl_frag858;

typedef 
NDR64_FORMAT_CHAR
__midl_frag857_t;
extern const __midl_frag857_t __midl_frag857;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag856_t;
extern const __midl_frag856_t __midl_frag856;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag855_t;
extern const __midl_frag855_t __midl_frag855;

typedef 
NDR64_FORMAT_CHAR
__midl_frag854_t;
extern const __midl_frag854_t __midl_frag854;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag852_t;
extern const __midl_frag852_t __midl_frag852;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag851_t;
extern const __midl_frag851_t __midl_frag851;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag850_t;
extern const __midl_frag850_t __midl_frag850;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag849_t;
extern const __midl_frag849_t __midl_frag849;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag841_t;
extern const __midl_frag841_t __midl_frag841;

typedef 
NDR64_FORMAT_CHAR
__midl_frag839_t;
extern const __midl_frag839_t __midl_frag839;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag838_t;
extern const __midl_frag838_t __midl_frag838;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag837_t;
extern const __midl_frag837_t __midl_frag837;

typedef 
NDR64_FORMAT_CHAR
__midl_frag836_t;
extern const __midl_frag836_t __midl_frag836;

typedef 
NDR64_FORMAT_CHAR
__midl_frag835_t;
extern const __midl_frag835_t __midl_frag835;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag834_t;
extern const __midl_frag834_t __midl_frag834;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag833_t;
extern const __midl_frag833_t __midl_frag833;

typedef 
NDR64_FORMAT_CHAR
__midl_frag832_t;
extern const __midl_frag832_t __midl_frag832;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag830_t;
extern const __midl_frag830_t __midl_frag830;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag829_t;
extern const __midl_frag829_t __midl_frag829;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag828_t;
extern const __midl_frag828_t __midl_frag828;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag827_t;
extern const __midl_frag827_t __midl_frag827;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag823_t;
extern const __midl_frag823_t __midl_frag823;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag822_t;
extern const __midl_frag822_t __midl_frag822;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag821_t;
extern const __midl_frag821_t __midl_frag821;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag820_t;
extern const __midl_frag820_t __midl_frag820;

typedef 
NDR64_FORMAT_CHAR
__midl_frag812_t;
extern const __midl_frag812_t __midl_frag812;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag811_t;
extern const __midl_frag811_t __midl_frag811;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag810_t;
extern const __midl_frag810_t __midl_frag810;

typedef 
NDR64_FORMAT_CHAR
__midl_frag809_t;
extern const __midl_frag809_t __midl_frag809;

typedef 
NDR64_FORMAT_CHAR
__midl_frag808_t;
extern const __midl_frag808_t __midl_frag808;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag807_t;
extern const __midl_frag807_t __midl_frag807;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag806_t;
extern const __midl_frag806_t __midl_frag806;

typedef 
NDR64_FORMAT_CHAR
__midl_frag805_t;
extern const __midl_frag805_t __midl_frag805;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag804_t;
extern const __midl_frag804_t __midl_frag804;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag803_t;
extern const __midl_frag803_t __midl_frag803;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag802_t;
extern const __midl_frag802_t __midl_frag802;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag801_t;
extern const __midl_frag801_t __midl_frag801;

typedef 
NDR64_FORMAT_CHAR
__midl_frag800_t;
extern const __midl_frag800_t __midl_frag800;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag799_t;
extern const __midl_frag799_t __midl_frag799;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag798_t;
extern const __midl_frag798_t __midl_frag798;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag797_t;
extern const __midl_frag797_t __midl_frag797;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag796_t;
extern const __midl_frag796_t __midl_frag796;

typedef 
NDR64_FORMAT_CHAR
__midl_frag795_t;
extern const __midl_frag795_t __midl_frag795;

typedef 
NDR64_FORMAT_CHAR
__midl_frag794_t;
extern const __midl_frag794_t __midl_frag794;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag793_t;
extern const __midl_frag793_t __midl_frag793;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag790_t;
extern const __midl_frag790_t __midl_frag790;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag789_t;
extern const __midl_frag789_t __midl_frag789;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag782_t;
extern const __midl_frag782_t __midl_frag782;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag780_t;
extern const __midl_frag780_t __midl_frag780;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag771_t;
extern const __midl_frag771_t __midl_frag771;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag768_t;
extern const __midl_frag768_t __midl_frag768;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag673_t;
extern const __midl_frag673_t __midl_frag673;

typedef 
struct _NDR64_USER_MARSHAL_FORMAT
__midl_frag672_t;
extern const __midl_frag672_t __midl_frag672;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag670_t;
extern const __midl_frag670_t __midl_frag670;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
    struct _NDR64_PARAM_FORMAT frag5;
}
__midl_frag664_t;
extern const __midl_frag664_t __midl_frag664;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag659_t;
extern const __midl_frag659_t __midl_frag659;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag630_t;
extern const __midl_frag630_t __midl_frag630;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag629_t;
extern const __midl_frag629_t __midl_frag629;

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
    struct _NDR64_PARAM_FORMAT frag8;
}
__midl_frag608_t;
extern const __midl_frag608_t __midl_frag608;

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
__midl_frag593_t;
extern const __midl_frag593_t __midl_frag593;

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
__midl_frag570_t;
extern const __midl_frag570_t __midl_frag570;

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
    struct _NDR64_PARAM_FORMAT frag8;
    struct _NDR64_PARAM_FORMAT frag9;
    struct _NDR64_PARAM_FORMAT frag10;
}
__midl_frag558_t;
extern const __midl_frag558_t __midl_frag558;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag545_t;
extern const __midl_frag545_t __midl_frag545;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag492_t;
extern const __midl_frag492_t __midl_frag492;

typedef 
NDR64_FORMAT_CHAR
__midl_frag483_t;
extern const __midl_frag483_t __midl_frag483;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag482_t;
extern const __midl_frag482_t __midl_frag482;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag479_t;
extern const __midl_frag479_t __midl_frag479;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag478_t;
extern const __midl_frag478_t __midl_frag478;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag310_t;
extern const __midl_frag310_t __midl_frag310;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
    struct _NDR64_PARAM_FORMAT frag4;
}
__midl_frag133_t;
extern const __midl_frag133_t __midl_frag133;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag127_t;
extern const __midl_frag127_t __midl_frag127;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag125_t;
extern const __midl_frag125_t __midl_frag125;

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
__midl_frag123_t;
extern const __midl_frag123_t __midl_frag123;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag95_t;
extern const __midl_frag95_t __midl_frag95;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag92_t;
extern const __midl_frag92_t __midl_frag92;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag91_t;
extern const __midl_frag91_t __midl_frag91;

typedef 
struct _NDR64_POINTER_FORMAT
__midl_frag70_t;
extern const __midl_frag70_t __midl_frag70;

typedef 
struct 
{
    struct _NDR64_PROC_FORMAT frag1;
    struct _NDR64_PARAM_FORMAT frag2;
    struct _NDR64_PARAM_FORMAT frag3;
}
__midl_frag69_t;
extern const __midl_frag69_t __midl_frag69;

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

static const __midl_frag950_t __midl_frag950 =
0x5    /* FC64_INT32 */;

static const __midl_frag948_t __midl_frag948 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag950
};

static const __midl_frag943_t __midl_frag943 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag942_t __midl_frag942 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag943
};

static const __midl_frag940_t __midl_frag940 =
{ 
/* DrawRuledLine */
    { 
    /* DrawRuledLine */      /* procedure DrawRuledLine */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 72 /* 0x48 */ ,  /* Stack size */
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag950,
        { 
        /* Station */
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
    /* PositionList */      /* parameter PositionList */
        &__midl_frag942,
        { 
        /* PositionList */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* LineDirection */      /* parameter LineDirection */
        &__midl_frag950,
        { 
        /* LineDirection */
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
    /* LineWidth */      /* parameter LineWidth */
        &__midl_frag950,
        { 
        /* LineWidth */
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
    /* LineStyle */      /* parameter LineStyle */
        &__midl_frag950,
        { 
        /* LineStyle */
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
        40 /* 0x28 */,   /* Stack offset */
    },
    { 
    /* LineColor */      /* parameter LineColor */
        &__midl_frag950,
        { 
        /* LineColor */
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
        48 /* 0x30 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag950,
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
        56 /* 0x38 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag950,
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
        64 /* 0x40 */,   /* Stack offset */
    }
};

static const __midl_frag936_t __midl_frag936 =
{ 
/* get_CapSlpRuledLine */
    { 
    /* get_CapSlpRuledLine */      /* procedure get_CapSlpRuledLine */
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
    /* pCapSlpRuledLine */      /* parameter pCapSlpRuledLine */
        &__midl_frag950,
        { 
        /* pCapSlpRuledLine */
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
        &__midl_frag950,
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

static const __midl_frag922_t __midl_frag922 =
{ 
/* PrintMemoryBitmap */
    { 
    /* PrintMemoryBitmap */      /* procedure PrintMemoryBitmap */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 64 /* 0x40 */ ,  /* Stack size */
        (NDR64_UINT32) 32 /* 0x20 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 7 /* 0x7 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag950,
        { 
        /* Station */
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
    /* Data */      /* parameter Data */
        &__midl_frag942,
        { 
        /* Data */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* Type */      /* parameter Type */
        &__midl_frag950,
        { 
        /* Type */
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
    /* Width */      /* parameter Width */
        &__midl_frag950,
        { 
        /* Width */
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
    /* Alignment */      /* parameter Alignment */
        &__midl_frag950,
        { 
        /* Alignment */
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
        40 /* 0x28 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag950,
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
        48 /* 0x30 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag950,
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
        56 /* 0x38 */,   /* Stack offset */
    }
};

static const __midl_frag917_t __midl_frag917 =
{ 
/* PageModePrint */
    { 
    /* PageModePrint */      /* procedure PageModePrint */
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
    /* Control */      /* parameter Control */
        &__midl_frag950,
        { 
        /* Control */
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
        &__midl_frag950,
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
        &__midl_frag950,
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

static const __midl_frag910_t __midl_frag910 =
{ 
/* put_PageModeVerticalPosition */
    { 
    /* put_PageModeVerticalPosition */      /* procedure put_PageModeVerticalPosition */
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
    /* PageModeVerticalPosition */      /* parameter PageModeVerticalPosition */
        &__midl_frag950,
        { 
        /* PageModeVerticalPosition */
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
        &__midl_frag950,
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

static const __midl_frag907_t __midl_frag907 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag950
};

static const __midl_frag888_t __midl_frag888 =
{ 
/* put_PageModePrintArea */
    { 
    /* put_PageModePrintArea */      /* procedure put_PageModePrintArea */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 24 /* 0x18 */ ,  /* Stack size */
        (NDR64_UINT32) 0 /* 0x0 */,
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 2 /* 0x2 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* PageModePrintArea */      /* parameter PageModePrintArea */
        &__midl_frag942,
        { 
        /* PageModePrintArea */
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
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag950,
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

static const __midl_frag886_t __midl_frag886 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag885_t __midl_frag885 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag886
};

static const __midl_frag884_t __midl_frag884 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 4 /* 0x4 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag885
};

static const __midl_frag883_t __midl_frag883 =
{ 
/* get_PageModePrintArea */
    { 
    /* get_PageModePrintArea */      /* procedure get_PageModePrintArea */
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
    /* pPageModePrintArea */      /* parameter pPageModePrintArea */
        &__midl_frag885,
        { 
        /* pPageModePrintArea */
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
        &__midl_frag950,
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

static const __midl_frag865_t __midl_frag865 =
0x4    /* FC64_INT16 */;

static const __midl_frag864_t __midl_frag864 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag865
};

static const __midl_frag863_t __midl_frag863 =
{ 
/* get_CapSlpPageMode */
    { 
    /* get_CapSlpPageMode */      /* procedure get_CapSlpPageMode */
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
    /* pCapSlpPageMode */      /* parameter pCapSlpPageMode */
        &__midl_frag865,
        { 
        /* pCapSlpPageMode */
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
        &__midl_frag950,
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

static const __midl_frag862_t __midl_frag862 =
0x5    /* FC64_INT32 */;

static const __midl_frag861_t __midl_frag861 =
0x4    /* FC64_INT16 */;

static const __midl_frag860_t __midl_frag860 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag861
};

static const __midl_frag859_t __midl_frag859 =
{ 
/* get_CapRecPageMode */
    { 
    /* get_CapRecPageMode */      /* procedure get_CapRecPageMode */
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
    /* pCapRecPageMode */      /* parameter pCapRecPageMode */
        &__midl_frag861,
        { 
        /* pCapRecPageMode */
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
        &__midl_frag862,
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

static const __midl_frag858_t __midl_frag858 =
0x5    /* FC64_INT32 */;

static const __midl_frag857_t __midl_frag857 =
0x4    /* FC64_INT16 */;

static const __midl_frag856_t __midl_frag856 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag857
};

static const __midl_frag855_t __midl_frag855 =
{ 
/* get_CapConcurrentPageMode */
    { 
    /* get_CapConcurrentPageMode */      /* procedure get_CapConcurrentPageMode */
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
    /* pCapConcurrentPageMode */      /* parameter pCapConcurrentPageMode */
        &__midl_frag857,
        { 
        /* pCapConcurrentPageMode */
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
        &__midl_frag858,
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

static const __midl_frag854_t __midl_frag854 =
0x5    /* FC64_INT32 */;

static const __midl_frag852_t __midl_frag852 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag854
};

static const __midl_frag851_t __midl_frag851 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag850_t __midl_frag850 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag851
};

static const __midl_frag849_t __midl_frag849 =
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
        &__midl_frag850,
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
        &__midl_frag854,
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
        &__midl_frag854,
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

static const __midl_frag841_t __midl_frag841 =
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
        &__midl_frag850,
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
        &__midl_frag854,
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
        &__midl_frag854,
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
        &__midl_frag854,
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

static const __midl_frag839_t __midl_frag839 =
0x4    /* FC64_INT16 */;

static const __midl_frag838_t __midl_frag838 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag839
};

static const __midl_frag837_t __midl_frag837 =
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
        &__midl_frag839,
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
        &__midl_frag854,
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

static const __midl_frag836_t __midl_frag836 =
0x5    /* FC64_INT32 */;

static const __midl_frag835_t __midl_frag835 =
0x4    /* FC64_INT16 */;

static const __midl_frag834_t __midl_frag834 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag835
};

static const __midl_frag833_t __midl_frag833 =
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
        &__midl_frag835,
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
        &__midl_frag836,
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

static const __midl_frag832_t __midl_frag832 =
0x5    /* FC64_INT32 */;

static const __midl_frag830_t __midl_frag830 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag832
};

static const __midl_frag829_t __midl_frag829 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag828_t __midl_frag828 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag829
};

static const __midl_frag827_t __midl_frag827 =
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
        &__midl_frag828,
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
        &__midl_frag832,
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
        &__midl_frag832,
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

static const __midl_frag823_t __midl_frag823 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag822_t __midl_frag822 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag823
};

static const __midl_frag821_t __midl_frag821 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag822
};

static const __midl_frag820_t __midl_frag820 =
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
        &__midl_frag822,
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
        &__midl_frag832,
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
        &__midl_frag832,
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

static const __midl_frag812_t __midl_frag812 =
0x4    /* FC64_INT16 */;

static const __midl_frag811_t __midl_frag811 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag812
};

static const __midl_frag810_t __midl_frag810 =
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
        &__midl_frag812,
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
        &__midl_frag832,
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

static const __midl_frag809_t __midl_frag809 =
0x5    /* FC64_INT32 */;

static const __midl_frag808_t __midl_frag808 =
0x4    /* FC64_INT16 */;

static const __midl_frag807_t __midl_frag807 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag808
};

static const __midl_frag806_t __midl_frag806 =
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
        &__midl_frag808,
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
        &__midl_frag809,
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

static const __midl_frag805_t __midl_frag805 =
0x5    /* FC64_INT32 */;

static const __midl_frag804_t __midl_frag804 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag803_t __midl_frag803 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag804
};

static const __midl_frag802_t __midl_frag802 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 4 /* 0x4 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag803
};

static const __midl_frag801_t __midl_frag801 =
{ 
/* get_SlpBitmapRotationList */
    { 
    /* get_SlpBitmapRotationList */      /* procedure get_SlpBitmapRotationList */
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
    /* pSlpBitmapRotationList */      /* parameter pSlpBitmapRotationList */
        &__midl_frag803,
        { 
        /* pSlpBitmapRotationList */
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
        &__midl_frag805,
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

static const __midl_frag800_t __midl_frag800 =
0x5    /* FC64_INT32 */;

static const __midl_frag799_t __midl_frag799 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x22,    /* FC64_OP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag798_t __midl_frag798 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag799
};

static const __midl_frag797_t __midl_frag797 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 4 /* 0x4 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag798
};

static const __midl_frag796_t __midl_frag796 =
{ 
/* get_RecBitmapRotationList */
    { 
    /* get_RecBitmapRotationList */      /* procedure get_RecBitmapRotationList */
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
    /* pRecBitmapRotationList */      /* parameter pRecBitmapRotationList */
        &__midl_frag798,
        { 
        /* pRecBitmapRotationList */
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
        &__midl_frag800,
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

static const __midl_frag795_t __midl_frag795 =
0x5    /* FC64_INT32 */;

static const __midl_frag794_t __midl_frag794 =
0x4    /* FC64_INT16 */;

static const __midl_frag793_t __midl_frag793 =
{ 
/* put_MapCharacterSet */
    { 
    /* put_MapCharacterSet */      /* procedure put_MapCharacterSet */
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
    /* MapCharacterSet */      /* parameter MapCharacterSet */
        &__midl_frag794,
        { 
        /* MapCharacterSet */
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
        &__midl_frag795,
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

static const __midl_frag790_t __midl_frag790 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag794
};

static const __midl_frag789_t __midl_frag789 =
{ 
/* get_MapCharacterSet */
    { 
    /* get_MapCharacterSet */      /* procedure get_MapCharacterSet */
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
    /* pMapCharacterSet */      /* parameter pMapCharacterSet */
        &__midl_frag794,
        { 
        /* pMapCharacterSet */
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
        &__midl_frag795,
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

static const __midl_frag782_t __midl_frag782 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag795
};

static const __midl_frag780_t __midl_frag780 =
{ 
/* MarkFeed */
    { 
    /* MarkFeed */      /* procedure MarkFeed */
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
    /* Type */      /* parameter Type */
        &__midl_frag795,
        { 
        /* Type */
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
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag771_t __midl_frag771 =
{ 
/* get_SlpPrintSide */
    { 
    /* get_SlpPrintSide */      /* procedure get_SlpPrintSide */
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
    /* pSlpPrintSide */      /* parameter pSlpPrintSide */
        &__midl_frag795,
        { 
        /* pSlpPrintSide */
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
        &__midl_frag795,
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

static const __midl_frag768_t __midl_frag768 =
{ 
/* put_SlpCurrentCartridge */
    { 
    /* put_SlpCurrentCartridge */      /* procedure put_SlpCurrentCartridge */
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
    /* SlpCurrentCartridge */      /* parameter SlpCurrentCartridge */
        &__midl_frag795,
        { 
        /* SlpCurrentCartridge */
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
        &__midl_frag795,
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

static const __midl_frag673_t __midl_frag673 =
{ 
/* *FLAGGED_WORD_BLOB */
    0x21,    /* FC64_UP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag12
};

static const __midl_frag672_t __midl_frag672 =
{ 
/* wireBSTR */
    0xa2,    /* FC64_USER_MARSHAL */
    (NDR64_UINT8) 128 /* 0x80 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    (NDR64_UINT16) 7 /* 0x7 */,
    (NDR64_UINT16) 8 /* 0x8 */,
    (NDR64_UINT32) 8 /* 0x8 */,
    (NDR64_UINT32) 0 /* 0x0 */,
    &__midl_frag673
};

static const __midl_frag670_t __midl_frag670 =
{ 
/* ValidateData */
    { 
    /* ValidateData */      /* procedure ValidateData */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 40 /* 0x28 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 4 /* 0x4 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag795,
        { 
        /* Station */
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
    /* Data */      /* parameter Data */
        &__midl_frag672,
        { 
        /* Data */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag664_t __midl_frag664 =
{ 
/* TransactionPrint */
    { 
    /* TransactionPrint */      /* procedure TransactionPrint */
        (NDR64_UINT32) 524611 /* 0x80143 */,    /* auto handle */ /* IsIntrepreted, [object], HasReturn */
        (NDR64_UINT32) 40 /* 0x28 */ ,  /* Stack size */
        (NDR64_UINT32) 16 /* 0x10 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 4 /* 0x4 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag795,
        { 
        /* Station */
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
    /* Control */      /* parameter Control */
        &__midl_frag795,
        { 
        /* Control */
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
    /* pRC */      /* parameter pRC */
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag659_t __midl_frag659 =
{ 
/* get_SlpBarCodeRotationList */
    { 
    /* get_SlpBarCodeRotationList */      /* procedure get_SlpBarCodeRotationList */
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
    /* pSlpBarCodeRotationList */      /* parameter pSlpBarCodeRotationList */
        &__midl_frag798,
        { 
        /* pSlpBarCodeRotationList */
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
        &__midl_frag795,
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

static const __midl_frag630_t __midl_frag630 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag794
};

static const __midl_frag629_t __midl_frag629 =
{ 
/* get_CapTransaction */
    { 
    /* get_CapTransaction */      /* procedure get_CapTransaction */
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
    /* pCapTransaction */      /* parameter pCapTransaction */
        &__midl_frag794,
        { 
        /* pCapTransaction */
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
        &__midl_frag795,
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

static const __midl_frag608_t __midl_frag608 =
{ 
/* SetBitmap */
    { 
    /* SetBitmap */      /* procedure SetBitmap */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 64 /* 0x40 */ ,  /* Stack size */
        (NDR64_UINT32) 32 /* 0x20 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 7 /* 0x7 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* BitmapNumber */      /* parameter BitmapNumber */
        &__midl_frag795,
        { 
        /* BitmapNumber */
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
    /* Station */      /* parameter Station */
        &__midl_frag795,
        { 
        /* Station */
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
    /* FileName */      /* parameter FileName */
        &__midl_frag672,
        { 
        /* FileName */
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
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* Width */      /* parameter Width */
        &__midl_frag795,
        { 
        /* Width */
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
    /* Alignment */      /* parameter Alignment */
        &__midl_frag795,
        { 
        /* Alignment */
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
        40 /* 0x28 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag795,
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
        48 /* 0x30 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag795,
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
        56 /* 0x38 */,   /* Stack offset */
    }
};

static const __midl_frag593_t __midl_frag593 =
{ 
/* PrintTwoNormal */
    { 
    /* PrintTwoNormal */      /* procedure PrintTwoNormal */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 48 /* 0x30 */ ,  /* Stack size */
        (NDR64_UINT32) 8 /* 0x8 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 5 /* 0x5 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Stations */      /* parameter Stations */
        &__midl_frag795,
        { 
        /* Stations */
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
    /* Data1 */      /* parameter Data1 */
        &__midl_frag672,
        { 
        /* Data1 */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* Data2 */      /* parameter Data2 */
        &__midl_frag672,
        { 
        /* Data2 */
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
        24 /* 0x18 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag570_t __midl_frag570 =
{ 
/* PrintBitmap */
    { 
    /* PrintBitmap */      /* procedure PrintBitmap */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 56 /* 0x38 */ ,  /* Stack size */
        (NDR64_UINT32) 24 /* 0x18 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 6 /* 0x6 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag795,
        { 
        /* Station */
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
    /* FileName */      /* parameter FileName */
        &__midl_frag672,
        { 
        /* FileName */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* Width */      /* parameter Width */
        &__midl_frag795,
        { 
        /* Width */
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
    /* Alignment */      /* parameter Alignment */
        &__midl_frag795,
        { 
        /* Alignment */
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
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag558_t __midl_frag558 =
{ 
/* PrintBarCode */
    { 
    /* PrintBarCode */      /* procedure PrintBarCode */
        (NDR64_UINT32) 2883907 /* 0x2c0143 */,    /* auto handle */ /* IsIntrepreted, [object], ClientMustSize, HasReturn, ServerCorrelation */
        (NDR64_UINT32) 80 /* 0x50 */ ,  /* Stack size */
        (NDR64_UINT32) 48 /* 0x30 */,
        (NDR64_UINT32) 40 /* 0x28 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 0 /* 0x0 */,
        (NDR64_UINT16) 9 /* 0x9 */,
        (NDR64_UINT16) 0 /* 0x0 */
    },
    { 
    /* Station */      /* parameter Station */
        &__midl_frag795,
        { 
        /* Station */
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
    /* Data */      /* parameter Data */
        &__midl_frag672,
        { 
        /* Data */
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
        16 /* 0x10 */,   /* Stack offset */
    },
    { 
    /* Symbology */      /* parameter Symbology */
        &__midl_frag795,
        { 
        /* Symbology */
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
    /* Height */      /* parameter Height */
        &__midl_frag795,
        { 
        /* Height */
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
    /* Width */      /* parameter Width */
        &__midl_frag795,
        { 
        /* Width */
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
        40 /* 0x28 */,   /* Stack offset */
    },
    { 
    /* Alignment */      /* parameter Alignment */
        &__midl_frag795,
        { 
        /* Alignment */
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
        48 /* 0x30 */,   /* Stack offset */
    },
    { 
    /* TextPosition */      /* parameter TextPosition */
        &__midl_frag795,
        { 
        /* TextPosition */
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
        56 /* 0x38 */,   /* Stack offset */
    },
    { 
    /* pRC */      /* parameter pRC */
        &__midl_frag795,
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
        64 /* 0x40 */,   /* Stack offset */
    },
    { 
    /* HRESULT */      /* parameter HRESULT */
        &__midl_frag795,
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
        72 /* 0x48 */,   /* Stack offset */
    }
};

static const __midl_frag545_t __midl_frag545 =
{ 
/* CutPaper */
    { 
    /* CutPaper */      /* procedure CutPaper */
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
    /* Percentage */      /* parameter Percentage */
        &__midl_frag795,
        { 
        /* Percentage */
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
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag492_t __midl_frag492 =
{ 
/* get_SlpLineCharsList */
    { 
    /* get_SlpLineCharsList */      /* procedure get_SlpLineCharsList */
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
    /* pSlpLineCharsList */      /* parameter pSlpLineCharsList */
        &__midl_frag803,
        { 
        /* pSlpLineCharsList */
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
        &__midl_frag795,
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

static const __midl_frag483_t __midl_frag483 =
0x4    /* FC64_INT16 */;

static const __midl_frag482_t __midl_frag482 =
{ 
/* put_SlpLetterQuality */
    { 
    /* put_SlpLetterQuality */      /* procedure put_SlpLetterQuality */
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
    /* SlpLetterQuality */      /* parameter SlpLetterQuality */
        &__midl_frag483,
        { 
        /* SlpLetterQuality */
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
        &__midl_frag795,
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

static const __midl_frag479_t __midl_frag479 =
{ 
/* *VARIANT_BOOL */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag483
};

static const __midl_frag478_t __midl_frag478 =
{ 
/* get_SlpLetterQuality */
    { 
    /* get_SlpLetterQuality */      /* procedure get_SlpLetterQuality */
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
    /* pSlpLetterQuality */      /* parameter pSlpLetterQuality */
        &__midl_frag483,
        { 
        /* pSlpLetterQuality */
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
        &__midl_frag795,
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

static const __midl_frag310_t __midl_frag310 =
{ 
/* get_CapSlpItalic */
    { 
    /* get_CapSlpItalic */      /* procedure get_CapSlpItalic */
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
    /* pCapSlpItalic */      /* parameter pCapSlpItalic */
        &__midl_frag483,
        { 
        /* pCapSlpItalic */
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
        &__midl_frag800,
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

static const __midl_frag133_t __midl_frag133 =
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
        &__midl_frag672,
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
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag127_t __midl_frag127 =
{ 
/* *wireBSTR */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 0 /* 0x0 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag803
};

static const __midl_frag125_t __midl_frag125 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 8 /* 0x8 */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag795
};

static const __midl_frag123_t __midl_frag123 =
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag803,
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
        &__midl_frag795,
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
        &__midl_frag795,
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

static const __midl_frag95_t __midl_frag95 =
{ 
/* get_DeviceDescription */
    { 
    /* get_DeviceDescription */      /* procedure get_DeviceDescription */
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
    /* pDeviceDescription */      /* parameter pDeviceDescription */
        &__midl_frag803,
        { 
        /* pDeviceDescription */
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
        &__midl_frag800,
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

static const __midl_frag92_t __midl_frag92 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag795
};

static const __midl_frag91_t __midl_frag91 =
{ 
/* get_ServiceObjectVersion */
    { 
    /* get_ServiceObjectVersion */      /* procedure get_ServiceObjectVersion */
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
    /* pServiceObjectVersion */      /* parameter pServiceObjectVersion */
        &__midl_frag795,
        { 
        /* pServiceObjectVersion */
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
        &__midl_frag795,
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

static const __midl_frag70_t __midl_frag70 =
{ 
/* *long */
    0x20,    /* FC64_RP */
    (NDR64_UINT8) 12 /* 0xc */,
    (NDR64_UINT16) 0 /* 0x0 */,
    &__midl_frag800
};

static const __midl_frag69_t __midl_frag69 =
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
        &__midl_frag800,
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
        &__midl_frag800,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag794
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag803,
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
        &__midl_frag795,
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
        &__midl_frag795,
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
        &__midl_frag795,
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


/* Object interface: IOPOSPOSPrinter_1_5, ver. 0.0,
   GUID={0xCCB91151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_5_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_5_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_5_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_5_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_5_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_5_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_5_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_5_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_5_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_5_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(190) _IOPOSPOSPrinter_1_5ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_5_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_5,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_5_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_5StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_5,
    &IOPOSPOSPrinter_1_5_ServerInfo,
    190,
    &IOPOSPOSPrinter_1_5_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_7, ver. 0.0,
   GUID={0xCCB92151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_7_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_7_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_7_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_7_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_7_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_7_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_7_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_7_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_7_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_7_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(195) _IOPOSPOSPrinter_1_7ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_7_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_7,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_7_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_7StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_7,
    &IOPOSPOSPrinter_1_7_ServerInfo,
    195,
    &IOPOSPOSPrinter_1_7_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_8, ver. 0.0,
   GUID={0xCCB93151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_8_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_8_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_8_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_8_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_8_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_8_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_8_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_8_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_8_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_8_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(200) _IOPOSPOSPrinter_1_8ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_8_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_8,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_8_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_8StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_8,
    &IOPOSPOSPrinter_1_8_ServerInfo,
    200,
    &IOPOSPOSPrinter_1_8_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_9, ver. 0.0,
   GUID={0xCCB94151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_9_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827,
    &__midl_frag833,
    &__midl_frag837,
    &__midl_frag841,
    &__midl_frag849,
    &__midl_frag855,
    &__midl_frag859,
    &__midl_frag863,
    &__midl_frag883,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag883,
    &__midl_frag888,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag917
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_9_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_9_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_9_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_9_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_9_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_9_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_9_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_9_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_9_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(221) _IOPOSPOSPrinter_1_9ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_9_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_9,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_PageModePrint_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_9_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_9StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_9,
    &IOPOSPOSPrinter_1_9_ServerInfo,
    221,
    &IOPOSPOSPrinter_1_9_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_10, ver. 0.0,
   GUID={0xCCB95151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_10_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827,
    &__midl_frag833,
    &__midl_frag837,
    &__midl_frag841,
    &__midl_frag849,
    &__midl_frag855,
    &__midl_frag859,
    &__midl_frag863,
    &__midl_frag883,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag883,
    &__midl_frag888,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag917,
    &__midl_frag922
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_10_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_10_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_10_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_10_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_10_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_10_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_10_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_10_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_10_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(222) _IOPOSPOSPrinter_1_10ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_10_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_10,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_PageModePrint_Proxy ,
    IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_10_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_10StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_10,
    &IOPOSPOSPrinter_1_10_ServerInfo,
    222,
    &IOPOSPOSPrinter_1_10_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_10_zz, ver. 0.0,
   GUID={0xCCB96151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_10_zz_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827,
    &__midl_frag833,
    &__midl_frag837,
    &__midl_frag841,
    &__midl_frag849,
    &__midl_frag855,
    &__midl_frag859,
    &__midl_frag863,
    &__midl_frag883,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag883,
    &__midl_frag888,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag917,
    &__midl_frag922,
    0
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_10_zz_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_10_zz_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_10_zz_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_10_zz_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_10_zz_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_10_zz_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_10_zz_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_10_zz_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_10_zz_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(222) _IOPOSPOSPrinter_1_10_zzProxyVtbl = 
{
    0,
    &IID_IOPOSPOSPrinter_1_10_zz,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SODataDummy */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SODirectIO */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOError */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOProcessID */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_Claimed */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_OutputID */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_State */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::CheckHealth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ClearOutput */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::Close */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::DirectIO */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::Open */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_MapMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_MapMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_PageModePrint_Proxy ,
    IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_10_zz_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_10_zzStubVtbl =
{
    &IID_IOPOSPOSPrinter_1_10_zz,
    &IOPOSPOSPrinter_1_10_zz_ServerInfo,
    222,
    &IOPOSPOSPrinter_1_10_zz_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter_1_13, ver. 0.0,
   GUID={0xCCB97151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_1_13_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827,
    &__midl_frag833,
    &__midl_frag837,
    &__midl_frag841,
    &__midl_frag849,
    &__midl_frag855,
    &__midl_frag859,
    &__midl_frag863,
    &__midl_frag883,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag883,
    &__midl_frag888,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag917,
    &__midl_frag922,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag940
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_1_13_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_13_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_1_13_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_1_13_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_1_13_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_13_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_1_13_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_1_13_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_1_13_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(225) _IOPOSPOSPrinter_1_13ProxyVtbl = 
{
    &IOPOSPOSPrinter_1_13_ProxyInfo,
    &IID_IOPOSPOSPrinter_1_13,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODataDummy */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SODirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOError */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::SOProcessID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_Claimed */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_OutputID */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_State */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::CheckHealth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ClearOutput */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Close */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::DirectIO */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::Open */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_MapMode */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    (void *) (INT_PTR) -1 /* IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_PageModePrint_Proxy ,
    IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy ,
    IOPOSPOSPrinter_1_13_get_CapRecRuledLine_Proxy ,
    IOPOSPOSPrinter_1_13_get_CapSlpRuledLine_Proxy ,
    IOPOSPOSPrinter_1_13_DrawRuledLine_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_1_13_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinter_1_13StubVtbl =
{
    &IID_IOPOSPOSPrinter_1_13,
    &IOPOSPOSPrinter_1_13_ServerInfo,
    225,
    &IOPOSPOSPrinter_1_13_table[-3],
    CStdStubBuffer_DELEGATING_METHODS
};


/* Object interface: IOPOSPOSPrinter, ver. 0.0,
   GUID={0xCCB98151,0xB81E,0x11D2,{0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19}} */

#pragma code_seg(".orpc")
static const FormatInfoRef IOPOSPOSPrinter_Ndr64ProcTable[] =
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
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag492,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag69,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag91,
    &__midl_frag95,
    &__midl_frag492,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag123,
    &__midl_frag133,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag629,
    &__midl_frag310,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag478,
    &__midl_frag478,
    &__midl_frag482,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag492,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag545,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag558,
    &__midl_frag570,
    &__midl_frag670,
    &__midl_frag670,
    &__midl_frag593,
    &__midl_frag664,
    &__midl_frag608,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag629,
    &__midl_frag771,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag659,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag659,
    &__midl_frag664,
    &__midl_frag670,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag789,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag771,
    &__midl_frag768,
    &__midl_frag771,
    &__midl_frag780,
    &__midl_frag780,
    &__midl_frag789,
    &__midl_frag789,
    &__midl_frag793,
    &__midl_frag796,
    &__midl_frag801,
    &__midl_frag806,
    &__midl_frag810,
    &__midl_frag827,
    &__midl_frag820,
    &__midl_frag827,
    &__midl_frag833,
    &__midl_frag837,
    &__midl_frag841,
    &__midl_frag849,
    &__midl_frag855,
    &__midl_frag859,
    &__midl_frag863,
    &__midl_frag883,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag883,
    &__midl_frag888,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag910,
    &__midl_frag936,
    &__midl_frag917,
    &__midl_frag922,
    &__midl_frag936,
    &__midl_frag936,
    &__midl_frag940,
    0
    };


static const MIDL_SYNTAX_INFO IOPOSPOSPrinter_SyntaxInfo [  2 ] = 
    {
    {
    {{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}},
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_FormatStringOffsetTable[-3],
    POSPrinter__MIDL_TypeFormatString.Format,
    UserMarshalRoutines,
    0,
    0
    }
    ,{
    {{0x71710533,0xbeba,0x4937,{0x83,0x19,0xb5,0xdb,0xef,0x9c,0xcc,0x36}},{1,0}},
    0,
    0 ,
    (unsigned short *) &IOPOSPOSPrinter_Ndr64ProcTable[-3],
    0,
    NDR64_UserMarshalRoutines,
    0,
    0
    }
    };

static const MIDL_STUBLESS_PROXY_INFO IOPOSPOSPrinter_ProxyInfo =
    {
    &Object_StubDesc,
    POSPrinter__MIDL_ProcFormatString.Format,
    &IOPOSPOSPrinter_FormatStringOffsetTable[-3],
    (RPC_SYNTAX_IDENTIFIER*)&_RpcTransferSyntax_2_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_SyntaxInfo
    
    };


static const MIDL_SERVER_INFO IOPOSPOSPrinter_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    POSPrinter__MIDL_ProcFormatString.Format,
    (unsigned short *) &IOPOSPOSPrinter_FormatStringOffsetTable[-3],
    0,
    (RPC_SYNTAX_IDENTIFIER*)&_NDR64_RpcTransferSyntax_1_0,
    2,
    (MIDL_SYNTAX_INFO*)IOPOSPOSPrinter_SyntaxInfo
    };
CINTERFACE_PROXY_VTABLE(225) _IOPOSPOSPrinterProxyVtbl = 
{
    0,
    &IID_IOPOSPOSPrinter,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    0 /* IDispatch::GetTypeInfoCount */ ,
    0 /* IDispatch::GetTypeInfo */ ,
    0 /* IDispatch::GetIDsOfNames */ ,
    0 /* IDispatch_Invoke_Proxy */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SODataDummy */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SODirectIO */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOError */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOOutputComplete */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOStatusUpdate */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::SOProcessID */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_OpenResult */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CheckHealthText */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_Claimed */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_DeviceEnabled */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_FreezeEvents */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_OutputID */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ResultCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ResultCodeExtended */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_State */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ControlObjectDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ControlObjectVersion */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ServiceObjectDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ServiceObjectVersion */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceDescription */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_DeviceName */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::CheckHealth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ClaimDevice */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ClearOutput */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::Close */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::DirectIO */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::Open */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::ReleaseDevice */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_AsyncMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_AsyncMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentJrnRec */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentJrnSlp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapConcurrentRecSlp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapCoverSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrn2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapJrnUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRec2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBarCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBitmap */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecLeft90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecPapercut */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecRight90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecRotate180 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecStamp */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapRecUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlp2Color */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBarCode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBitmap */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpBold */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDwide */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpDwideDhigh */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpEmptySensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpFullslip */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpItalic */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpLeft90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpNearEndSensor */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpPresent */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpRight90 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpRotate180 */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CapSlpUnderline */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CharacterSet */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_CharacterSet */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CharacterSetList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_CoverOpen */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_ErrorStation */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_FlagWhenIdle */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_FlagWhenIdle */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineCharsList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_JrnLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnLineWidth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_JrnNearEnd */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_MapMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_MapMode */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineCharsList */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineHeight */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_RecLineSpacing */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLinesToPaperCut */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecLineWidth */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecNearEnd */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecSidewaysMaxChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_RecSidewaysMaxLines */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpEmpty */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_SlpLetterQuality */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::put_SlpLineChars */ ,
    0 /* forced delegation IOPOSPOSPrinter_1_5::get_SlpLineCharsList */ ,
    IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy ,
    IOPOSPOSPrinter_1_5_BeginInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_BeginRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_CutPaper_Proxy ,
    IOPOSPOSPrinter_1_5_EndInsertion_Proxy ,
    IOPOSPOSPrinter_1_5_EndRemoval_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBarCode_Proxy ,
    IOPOSPOSPrinter_1_5_PrintBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_PrintImmediate_Proxy ,
    IOPOSPOSPrinter_1_5_PrintNormal_Proxy ,
    IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy ,
    IOPOSPOSPrinter_1_5_RotatePrint_Proxy ,
    IOPOSPOSPrinter_1_5_SetBitmap_Proxy ,
    IOPOSPOSPrinter_1_5_SetLogo_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy ,
    IOPOSPOSPrinter_1_5_get_ErrorString_Proxy ,
    IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy ,
    IOPOSPOSPrinter_1_5_TransactionPrint_Proxy ,
    IOPOSPOSPrinter_1_5_ValidateData_Proxy ,
    IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_PowerState_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy ,
    IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy ,
    IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy ,
    IOPOSPOSPrinter_1_5_MarkFeed_Proxy ,
    IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy ,
    IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy ,
    IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_ResetStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy ,
    IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy ,
    IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy ,
    IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy ,
    IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy ,
    IOPOSPOSPrinter_1_9_PageModePrint_Proxy ,
    IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy ,
    IOPOSPOSPrinter_1_13_get_CapRecRuledLine_Proxy ,
    IOPOSPOSPrinter_1_13_get_CapSlpRuledLine_Proxy ,
    IOPOSPOSPrinter_1_13_DrawRuledLine_Proxy
};


EXTERN_C DECLSPEC_SELECTANY const PRPC_STUB_FUNCTION IOPOSPOSPrinter_table[] =
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
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
    NdrStubCall3,
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

CInterfaceStubVtbl _IOPOSPOSPrinterStubVtbl =
{
    &IID_IOPOSPOSPrinter,
    &IOPOSPOSPrinter_ServerInfo,
    225,
    &IOPOSPOSPrinter_table[-3],
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
    POSPrinter__MIDL_TypeFormatString.Format,
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

const CInterfaceProxyVtbl * const _POSPrinter_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_5ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_7ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_8ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_9ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_10ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_10_zzProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinter_1_13ProxyVtbl,
    ( CInterfaceProxyVtbl *) &_IOPOSPOSPrinterProxyVtbl,
    0
};

const CInterfaceStubVtbl * const _POSPrinter_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_5StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_7StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_8StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_9StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_10StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_10_zzStubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinter_1_13StubVtbl,
    ( CInterfaceStubVtbl *) &_IOPOSPOSPrinterStubVtbl,
    0
};

PCInterfaceName const _POSPrinter_InterfaceNamesList[] = 
{
    "IOPOSPOSPrinter_1_5",
    "IOPOSPOSPrinter_1_7",
    "IOPOSPOSPrinter_1_8",
    "IOPOSPOSPrinter_1_9",
    "IOPOSPOSPrinter_1_10",
    "IOPOSPOSPrinter_1_10_zz",
    "IOPOSPOSPrinter_1_13",
    "IOPOSPOSPrinter",
    0
};

const IID *  const _POSPrinter_BaseIIDList[] = 
{
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    &IID_IDispatch,
    0
};


#define _POSPrinter_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _POSPrinter, pIID, n)

int __stdcall _POSPrinter_IID_Lookup( const IID * pIID, int * pIndex )
{
    IID_BS_LOOKUP_SETUP

    IID_BS_LOOKUP_INITIAL_TEST( _POSPrinter, 8, 4 )
    IID_BS_LOOKUP_NEXT_TEST( _POSPrinter, 2 )
    IID_BS_LOOKUP_NEXT_TEST( _POSPrinter, 1 )
    IID_BS_LOOKUP_RETURN_RESULT( _POSPrinter, 8, *pIndex )
    
}

EXTERN_C const ExtendedProxyFileInfo POSPrinter_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _POSPrinter_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _POSPrinter_StubVtblList,
    (const PCInterfaceName * ) & _POSPrinter_InterfaceNamesList,
    (const IID ** ) & _POSPrinter_BaseIIDList,
    & _POSPrinter_IID_Lookup, 
    8,
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

