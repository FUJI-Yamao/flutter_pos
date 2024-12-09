

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for Scanner.idl:
    Oicf, W1, Zp8, env=Win32 (32b run), target_arch=X86 8.01.0628 
    protocol : dce , ms_ext, c_ext, robust
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

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __Scanner_h__
#define __Scanner_h__

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

#ifndef __IOPOSScanner_1_5_FWD_DEFINED__
#define __IOPOSScanner_1_5_FWD_DEFINED__
typedef interface IOPOSScanner_1_5 IOPOSScanner_1_5;

#endif 	/* __IOPOSScanner_1_5_FWD_DEFINED__ */


#ifndef __IOPOSScanner_1_8_FWD_DEFINED__
#define __IOPOSScanner_1_8_FWD_DEFINED__
typedef interface IOPOSScanner_1_8 IOPOSScanner_1_8;

#endif 	/* __IOPOSScanner_1_8_FWD_DEFINED__ */


#ifndef __IOPOSScanner_1_9_FWD_DEFINED__
#define __IOPOSScanner_1_9_FWD_DEFINED__
typedef interface IOPOSScanner_1_9 IOPOSScanner_1_9;

#endif 	/* __IOPOSScanner_1_9_FWD_DEFINED__ */


#ifndef __IOPOSScanner_1_10_FWD_DEFINED__
#define __IOPOSScanner_1_10_FWD_DEFINED__
typedef interface IOPOSScanner_1_10 IOPOSScanner_1_10;

#endif 	/* __IOPOSScanner_1_10_FWD_DEFINED__ */


#ifndef __IOPOSScanner_FWD_DEFINED__
#define __IOPOSScanner_FWD_DEFINED__
typedef interface IOPOSScanner IOPOSScanner;

#endif 	/* __IOPOSScanner_FWD_DEFINED__ */


#ifndef ___IOPOSScannerEvents_FWD_DEFINED__
#define ___IOPOSScannerEvents_FWD_DEFINED__
typedef interface _IOPOSScannerEvents _IOPOSScannerEvents;

#endif 	/* ___IOPOSScannerEvents_FWD_DEFINED__ */


#ifndef __OPOSScanner_FWD_DEFINED__
#define __OPOSScanner_FWD_DEFINED__

#ifdef __cplusplus
typedef class OPOSScanner OPOSScanner;
#else
typedef struct OPOSScanner OPOSScanner;
#endif /* __cplusplus */

#endif 	/* __OPOSScanner_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IOPOSScanner_1_5_INTERFACE_DEFINED__
#define __IOPOSScanner_1_5_INTERFACE_DEFINED__

/* interface IOPOSScanner_1_5 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSScanner_1_5;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB91181-B81E-11D2-AB74-0040054C3719")
    IOPOSScanner_1_5 : public IDispatch
    {
    public:
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOData( 
            /* [in] */ long Status) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SODirectIO( 
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOError( 
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOOutputCompleteDummy( 
            /* [in] */ long OutputID) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOStatusUpdate( 
            /* [in] */ long Data) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOProcessID( 
            /* [retval][out] */ long *pProcessID) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_OpenResult( 
            /* [retval][out] */ long *pOpenResult) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CheckHealthText( 
            /* [retval][out] */ BSTR *pCheckHealthText) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_Claimed( 
            /* [retval][out] */ VARIANT_BOOL *pClaimed) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DataEventEnabled( 
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_DataEventEnabled( 
            /* [in] */ VARIANT_BOOL DataEventEnabled) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DeviceEnabled( 
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_DeviceEnabled( 
            /* [in] */ VARIANT_BOOL DeviceEnabled) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_FreezeEvents( 
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_FreezeEvents( 
            /* [in] */ VARIANT_BOOL FreezeEvents) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ResultCode( 
            /* [retval][out] */ long *pResultCode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ResultCodeExtended( 
            /* [retval][out] */ long *pResultCodeExtended) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_State( 
            /* [retval][out] */ long *pState) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ControlObjectDescription( 
            /* [retval][out] */ BSTR *pControlObjectDescription) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ControlObjectVersion( 
            /* [retval][out] */ long *pControlObjectVersion) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ServiceObjectDescription( 
            /* [retval][out] */ BSTR *pServiceObjectDescription) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ServiceObjectVersion( 
            /* [retval][out] */ long *pServiceObjectVersion) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DeviceDescription( 
            /* [retval][out] */ BSTR *pDeviceDescription) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DeviceName( 
            /* [retval][out] */ BSTR *pDeviceName) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE CheckHealth( 
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ClaimDevice( 
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ClearInput( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Close( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE DirectIO( 
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE Open( 
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ReleaseDevice( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScanData( 
            /* [retval][out] */ BSTR *pScanData) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_AutoDisable( 
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_AutoDisable( 
            /* [in] */ VARIANT_BOOL AutoDisable) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_BinaryConversion( 
            /* [retval][out] */ long *pBinaryConversion) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_BinaryConversion( 
            /* [in] */ long BinaryConversion) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DataCount( 
            /* [retval][out] */ long *pDataCount) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DecodeData( 
            /* [retval][out] */ VARIANT_BOOL *pDecodeData) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_DecodeData( 
            /* [in] */ VARIANT_BOOL DecodeData) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScanDataLabel( 
            /* [retval][out] */ BSTR *pScanDataLabel) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ScanDataType( 
            /* [retval][out] */ long *pScanDataType) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapPowerReporting( 
            /* [retval][out] */ long *pCapPowerReporting) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PowerNotify( 
            /* [retval][out] */ long *pPowerNotify) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PowerNotify( 
            /* [in] */ long PowerNotify) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PowerState( 
            /* [retval][out] */ long *pPowerState) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSScanner_1_5Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSScanner_1_5 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSScanner_1_5 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSScanner_1_5 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSScanner_1_5 * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanData )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pScanData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DecodeData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DecodeData )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DecodeData)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DecodeData )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ VARIANT_BOOL DecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataLabel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataLabel )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ BSTR *pScanDataLabel);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataType )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pScanDataType);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSScanner_1_5 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSScanner_1_5 * This,
            /* [retval][out] */ long *pPowerState);
        
        END_INTERFACE
    } IOPOSScanner_1_5Vtbl;

    interface IOPOSScanner_1_5
    {
        CONST_VTBL struct IOPOSScanner_1_5Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSScanner_1_5_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSScanner_1_5_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSScanner_1_5_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSScanner_1_5_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSScanner_1_5_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSScanner_1_5_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSScanner_1_5_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSScanner_1_5_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSScanner_1_5_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSScanner_1_5_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSScanner_1_5_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSScanner_1_5_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSScanner_1_5_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSScanner_1_5_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSScanner_1_5_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSScanner_1_5_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSScanner_1_5_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSScanner_1_5_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSScanner_1_5_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSScanner_1_5_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSScanner_1_5_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSScanner_1_5_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSScanner_1_5_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSScanner_1_5_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSScanner_1_5_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSScanner_1_5_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSScanner_1_5_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSScanner_1_5_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSScanner_1_5_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSScanner_1_5_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSScanner_1_5_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSScanner_1_5_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSScanner_1_5_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSScanner_1_5_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSScanner_1_5_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSScanner_1_5_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSScanner_1_5_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSScanner_1_5_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSScanner_1_5_get_ScanData(This,pScanData)	\
    ( (This)->lpVtbl -> get_ScanData(This,pScanData) ) 

#define IOPOSScanner_1_5_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSScanner_1_5_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSScanner_1_5_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSScanner_1_5_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSScanner_1_5_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSScanner_1_5_get_DecodeData(This,pDecodeData)	\
    ( (This)->lpVtbl -> get_DecodeData(This,pDecodeData) ) 

#define IOPOSScanner_1_5_put_DecodeData(This,DecodeData)	\
    ( (This)->lpVtbl -> put_DecodeData(This,DecodeData) ) 

#define IOPOSScanner_1_5_get_ScanDataLabel(This,pScanDataLabel)	\
    ( (This)->lpVtbl -> get_ScanDataLabel(This,pScanDataLabel) ) 

#define IOPOSScanner_1_5_get_ScanDataType(This,pScanDataType)	\
    ( (This)->lpVtbl -> get_ScanDataType(This,pScanDataType) ) 

#define IOPOSScanner_1_5_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSScanner_1_5_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSScanner_1_5_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSScanner_1_5_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSScanner_1_5_INTERFACE_DEFINED__ */


#ifndef __IOPOSScanner_1_8_INTERFACE_DEFINED__
#define __IOPOSScanner_1_8_INTERFACE_DEFINED__

/* interface IOPOSScanner_1_8 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSScanner_1_8;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB92181-B81E-11D2-AB74-0040054C3719")
    IOPOSScanner_1_8 : public IOPOSScanner_1_5
    {
    public:
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapStatisticsReporting( 
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapUpdateStatistics( 
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ResetStatistics( 
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RetrieveStatistics( 
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE UpdateStatistics( 
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSScanner_1_8Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSScanner_1_8 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSScanner_1_8 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSScanner_1_8 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSScanner_1_8 * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanData )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pScanData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DecodeData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DecodeData )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DecodeData)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DecodeData )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ VARIANT_BOOL DecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataLabel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataLabel )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ BSTR *pScanDataLabel);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataType )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pScanDataType);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSScanner_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSScanner_1_8 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSScanner_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSScanner_1_8Vtbl;

    interface IOPOSScanner_1_8
    {
        CONST_VTBL struct IOPOSScanner_1_8Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSScanner_1_8_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSScanner_1_8_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSScanner_1_8_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSScanner_1_8_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSScanner_1_8_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSScanner_1_8_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSScanner_1_8_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSScanner_1_8_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSScanner_1_8_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSScanner_1_8_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSScanner_1_8_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSScanner_1_8_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSScanner_1_8_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSScanner_1_8_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSScanner_1_8_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSScanner_1_8_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSScanner_1_8_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSScanner_1_8_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSScanner_1_8_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSScanner_1_8_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSScanner_1_8_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSScanner_1_8_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSScanner_1_8_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSScanner_1_8_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSScanner_1_8_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSScanner_1_8_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSScanner_1_8_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSScanner_1_8_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSScanner_1_8_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSScanner_1_8_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSScanner_1_8_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSScanner_1_8_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSScanner_1_8_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSScanner_1_8_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSScanner_1_8_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSScanner_1_8_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSScanner_1_8_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSScanner_1_8_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSScanner_1_8_get_ScanData(This,pScanData)	\
    ( (This)->lpVtbl -> get_ScanData(This,pScanData) ) 

#define IOPOSScanner_1_8_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSScanner_1_8_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSScanner_1_8_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSScanner_1_8_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSScanner_1_8_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSScanner_1_8_get_DecodeData(This,pDecodeData)	\
    ( (This)->lpVtbl -> get_DecodeData(This,pDecodeData) ) 

#define IOPOSScanner_1_8_put_DecodeData(This,DecodeData)	\
    ( (This)->lpVtbl -> put_DecodeData(This,DecodeData) ) 

#define IOPOSScanner_1_8_get_ScanDataLabel(This,pScanDataLabel)	\
    ( (This)->lpVtbl -> get_ScanDataLabel(This,pScanDataLabel) ) 

#define IOPOSScanner_1_8_get_ScanDataType(This,pScanDataType)	\
    ( (This)->lpVtbl -> get_ScanDataType(This,pScanDataType) ) 

#define IOPOSScanner_1_8_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSScanner_1_8_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSScanner_1_8_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSScanner_1_8_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSScanner_1_8_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSScanner_1_8_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSScanner_1_8_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_8_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_8_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSScanner_1_8_INTERFACE_DEFINED__ */


#ifndef __IOPOSScanner_1_9_INTERFACE_DEFINED__
#define __IOPOSScanner_1_9_INTERFACE_DEFINED__

/* interface IOPOSScanner_1_9 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSScanner_1_9;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB93181-B81E-11D2-AB74-0040054C3719")
    IOPOSScanner_1_9 : public IOPOSScanner_1_8
    {
    public:
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapCompareFirmwareVersion( 
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapUpdateFirmware( 
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE CompareFirmwareVersion( 
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE UpdateFirmware( 
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSScanner_1_9Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSScanner_1_9 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSScanner_1_9 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSScanner_1_9 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSScanner_1_9 * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanData )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pScanData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DecodeData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DecodeData )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DecodeData)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DecodeData )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ VARIANT_BOOL DecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataLabel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataLabel )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ BSTR *pScanDataLabel);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataType )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pScanDataType);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSScanner_1_9 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSScanner_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSScanner_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSScanner_1_9Vtbl;

    interface IOPOSScanner_1_9
    {
        CONST_VTBL struct IOPOSScanner_1_9Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSScanner_1_9_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSScanner_1_9_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSScanner_1_9_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSScanner_1_9_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSScanner_1_9_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSScanner_1_9_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSScanner_1_9_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSScanner_1_9_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSScanner_1_9_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSScanner_1_9_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSScanner_1_9_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSScanner_1_9_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSScanner_1_9_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSScanner_1_9_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSScanner_1_9_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSScanner_1_9_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSScanner_1_9_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSScanner_1_9_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSScanner_1_9_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSScanner_1_9_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSScanner_1_9_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSScanner_1_9_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSScanner_1_9_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSScanner_1_9_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSScanner_1_9_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSScanner_1_9_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSScanner_1_9_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSScanner_1_9_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSScanner_1_9_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSScanner_1_9_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSScanner_1_9_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSScanner_1_9_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSScanner_1_9_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSScanner_1_9_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSScanner_1_9_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSScanner_1_9_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSScanner_1_9_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSScanner_1_9_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSScanner_1_9_get_ScanData(This,pScanData)	\
    ( (This)->lpVtbl -> get_ScanData(This,pScanData) ) 

#define IOPOSScanner_1_9_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSScanner_1_9_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSScanner_1_9_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSScanner_1_9_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSScanner_1_9_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSScanner_1_9_get_DecodeData(This,pDecodeData)	\
    ( (This)->lpVtbl -> get_DecodeData(This,pDecodeData) ) 

#define IOPOSScanner_1_9_put_DecodeData(This,DecodeData)	\
    ( (This)->lpVtbl -> put_DecodeData(This,DecodeData) ) 

#define IOPOSScanner_1_9_get_ScanDataLabel(This,pScanDataLabel)	\
    ( (This)->lpVtbl -> get_ScanDataLabel(This,pScanDataLabel) ) 

#define IOPOSScanner_1_9_get_ScanDataType(This,pScanDataType)	\
    ( (This)->lpVtbl -> get_ScanDataType(This,pScanDataType) ) 

#define IOPOSScanner_1_9_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSScanner_1_9_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSScanner_1_9_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSScanner_1_9_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSScanner_1_9_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSScanner_1_9_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSScanner_1_9_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_9_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_9_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSScanner_1_9_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSScanner_1_9_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSScanner_1_9_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSScanner_1_9_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSScanner_1_9_INTERFACE_DEFINED__ */


#ifndef __IOPOSScanner_1_10_INTERFACE_DEFINED__
#define __IOPOSScanner_1_10_INTERFACE_DEFINED__

/* interface IOPOSScanner_1_10 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSScanner_1_10;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB94181-B81E-11D2-AB74-0040054C3719")
    IOPOSScanner_1_10 : public IOPOSScanner_1_9
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ClearInputProperties( 
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSScanner_1_10Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSScanner_1_10 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSScanner_1_10 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSScanner_1_10 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSScanner_1_10 * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanData )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pScanData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DecodeData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DecodeData )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pDecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DecodeData)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DecodeData )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ VARIANT_BOOL DecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataLabel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataLabel )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ BSTR *pScanDataLabel);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataType )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pScanDataType);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSScanner_1_10 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSScanner_1_10 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_10, ClearInputProperties)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInputProperties )( 
            IOPOSScanner_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSScanner_1_10Vtbl;

    interface IOPOSScanner_1_10
    {
        CONST_VTBL struct IOPOSScanner_1_10Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSScanner_1_10_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSScanner_1_10_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSScanner_1_10_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSScanner_1_10_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSScanner_1_10_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSScanner_1_10_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSScanner_1_10_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSScanner_1_10_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSScanner_1_10_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSScanner_1_10_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSScanner_1_10_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSScanner_1_10_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSScanner_1_10_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSScanner_1_10_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSScanner_1_10_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSScanner_1_10_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSScanner_1_10_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSScanner_1_10_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSScanner_1_10_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSScanner_1_10_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSScanner_1_10_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSScanner_1_10_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSScanner_1_10_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSScanner_1_10_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSScanner_1_10_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSScanner_1_10_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSScanner_1_10_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSScanner_1_10_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSScanner_1_10_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSScanner_1_10_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSScanner_1_10_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSScanner_1_10_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSScanner_1_10_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSScanner_1_10_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSScanner_1_10_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSScanner_1_10_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSScanner_1_10_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSScanner_1_10_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSScanner_1_10_get_ScanData(This,pScanData)	\
    ( (This)->lpVtbl -> get_ScanData(This,pScanData) ) 

#define IOPOSScanner_1_10_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSScanner_1_10_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSScanner_1_10_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSScanner_1_10_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSScanner_1_10_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSScanner_1_10_get_DecodeData(This,pDecodeData)	\
    ( (This)->lpVtbl -> get_DecodeData(This,pDecodeData) ) 

#define IOPOSScanner_1_10_put_DecodeData(This,DecodeData)	\
    ( (This)->lpVtbl -> put_DecodeData(This,DecodeData) ) 

#define IOPOSScanner_1_10_get_ScanDataLabel(This,pScanDataLabel)	\
    ( (This)->lpVtbl -> get_ScanDataLabel(This,pScanDataLabel) ) 

#define IOPOSScanner_1_10_get_ScanDataType(This,pScanDataType)	\
    ( (This)->lpVtbl -> get_ScanDataType(This,pScanDataType) ) 

#define IOPOSScanner_1_10_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSScanner_1_10_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSScanner_1_10_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSScanner_1_10_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSScanner_1_10_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSScanner_1_10_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSScanner_1_10_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_10_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSScanner_1_10_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSScanner_1_10_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSScanner_1_10_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSScanner_1_10_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSScanner_1_10_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 


#define IOPOSScanner_1_10_ClearInputProperties(This,pRC)	\
    ( (This)->lpVtbl -> ClearInputProperties(This,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSScanner_1_10_INTERFACE_DEFINED__ */


#ifndef __IOPOSScanner_INTERFACE_DEFINED__
#define __IOPOSScanner_INTERFACE_DEFINED__

/* interface IOPOSScanner */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSScanner;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB95181-B81E-11D2-AB74-0040054C3719")
    IOPOSScanner : public IOPOSScanner_1_10
    {
    public:
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSScannerVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSScanner * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSScanner * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSScanner * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSScanner * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSScanner * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSScanner * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSScanner * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSScanner * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSScanner * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSScanner * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSScanner * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSScanner * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSScanner * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSScanner * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSScanner * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSScanner * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSScanner * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSScanner * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSScanner * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanData )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pScanData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSScanner * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSScanner * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_DecodeData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DecodeData )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pDecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_DecodeData)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DecodeData )( 
            IOPOSScanner * This,
            /* [in] */ VARIANT_BOOL DecodeData);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataLabel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataLabel )( 
            IOPOSScanner * This,
            /* [retval][out] */ BSTR *pScanDataLabel);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_ScanDataType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ScanDataType )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pScanDataType);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSScanner * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSScanner * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSScanner * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSScanner * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSScanner * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSScanner * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSScanner * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSScanner_1_10, ClearInputProperties)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInputProperties )( 
            IOPOSScanner * This,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSScannerVtbl;

    interface IOPOSScanner
    {
        CONST_VTBL struct IOPOSScannerVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSScanner_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSScanner_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSScanner_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSScanner_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSScanner_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSScanner_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSScanner_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSScanner_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSScanner_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSScanner_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSScanner_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSScanner_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSScanner_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSScanner_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSScanner_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSScanner_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSScanner_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSScanner_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSScanner_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSScanner_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSScanner_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSScanner_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSScanner_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSScanner_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSScanner_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSScanner_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSScanner_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSScanner_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSScanner_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSScanner_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSScanner_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSScanner_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSScanner_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSScanner_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSScanner_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSScanner_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSScanner_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSScanner_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSScanner_get_ScanData(This,pScanData)	\
    ( (This)->lpVtbl -> get_ScanData(This,pScanData) ) 

#define IOPOSScanner_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSScanner_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSScanner_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSScanner_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSScanner_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSScanner_get_DecodeData(This,pDecodeData)	\
    ( (This)->lpVtbl -> get_DecodeData(This,pDecodeData) ) 

#define IOPOSScanner_put_DecodeData(This,DecodeData)	\
    ( (This)->lpVtbl -> put_DecodeData(This,DecodeData) ) 

#define IOPOSScanner_get_ScanDataLabel(This,pScanDataLabel)	\
    ( (This)->lpVtbl -> get_ScanDataLabel(This,pScanDataLabel) ) 

#define IOPOSScanner_get_ScanDataType(This,pScanDataType)	\
    ( (This)->lpVtbl -> get_ScanDataType(This,pScanDataType) ) 

#define IOPOSScanner_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSScanner_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSScanner_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSScanner_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSScanner_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSScanner_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSScanner_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSScanner_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSScanner_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSScanner_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSScanner_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSScanner_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSScanner_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 


#define IOPOSScanner_ClearInputProperties(This,pRC)	\
    ( (This)->lpVtbl -> ClearInputProperties(This,pRC) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSScanner_INTERFACE_DEFINED__ */



#ifndef __OposScanner_CCO_LIBRARY_DEFINED__
#define __OposScanner_CCO_LIBRARY_DEFINED__

/* library OposScanner_CCO */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_OposScanner_CCO;

#ifndef ___IOPOSScannerEvents_DISPINTERFACE_DEFINED__
#define ___IOPOSScannerEvents_DISPINTERFACE_DEFINED__

/* dispinterface _IOPOSScannerEvents */
/* [helpstring][uuid] */ 


EXTERN_C const IID DIID__IOPOSScannerEvents;

#if defined(__cplusplus) && !defined(CINTERFACE)

    MIDL_INTERFACE("CCB90183-B81E-11D2-AB74-0040054C3719")
    _IOPOSScannerEvents : public IDispatch
    {
    };
    
#else 	/* C style interface */

    typedef struct _IOPOSScannerEventsVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            _IOPOSScannerEvents * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            _IOPOSScannerEvents * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            _IOPOSScannerEvents * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            _IOPOSScannerEvents * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            _IOPOSScannerEvents * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            _IOPOSScannerEvents * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            _IOPOSScannerEvents * This,
            /* [annotation][in] */ 
            _In_  DISPID dispIdMember,
            /* [annotation][in] */ 
            _In_  REFIID riid,
            /* [annotation][in] */ 
            _In_  LCID lcid,
            /* [annotation][in] */ 
            _In_  WORD wFlags,
            /* [annotation][out][in] */ 
            _In_  DISPPARAMS *pDispParams,
            /* [annotation][out] */ 
            _Out_opt_  VARIANT *pVarResult,
            /* [annotation][out] */ 
            _Out_opt_  EXCEPINFO *pExcepInfo,
            /* [annotation][out] */ 
            _Out_opt_  UINT *puArgErr);
        
        END_INTERFACE
    } _IOPOSScannerEventsVtbl;

    interface _IOPOSScannerEvents
    {
        CONST_VTBL struct _IOPOSScannerEventsVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _IOPOSScannerEvents_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define _IOPOSScannerEvents_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define _IOPOSScannerEvents_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define _IOPOSScannerEvents_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define _IOPOSScannerEvents_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define _IOPOSScannerEvents_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define _IOPOSScannerEvents_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */


#endif 	/* ___IOPOSScannerEvents_DISPINTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_OPOSScanner;

#ifdef __cplusplus

class DECLSPEC_UUID("CCB90182-B81E-11D2-AB74-0040054C3719")
OPOSScanner;
#endif
#endif /* __OposScanner_CCO_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

unsigned long             __RPC_USER  BSTR_UserSize64(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal64(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal64(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree64(     unsigned long *, BSTR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


