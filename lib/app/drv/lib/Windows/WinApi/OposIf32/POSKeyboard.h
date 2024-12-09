

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 8.01.0628 */
/* at Tue Jan 19 12:14:07 2038
 */
/* Compiler settings for POSKeyboard.idl:
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

#ifndef __POSKeyboard_h__
#define __POSKeyboard_h__

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

#ifndef __IOPOSPOSKeyboard_1_5_FWD_DEFINED__
#define __IOPOSPOSKeyboard_1_5_FWD_DEFINED__
typedef interface IOPOSPOSKeyboard_1_5 IOPOSPOSKeyboard_1_5;

#endif 	/* __IOPOSPOSKeyboard_1_5_FWD_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_1_8_FWD_DEFINED__
#define __IOPOSPOSKeyboard_1_8_FWD_DEFINED__
typedef interface IOPOSPOSKeyboard_1_8 IOPOSPOSKeyboard_1_8;

#endif 	/* __IOPOSPOSKeyboard_1_8_FWD_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_1_9_FWD_DEFINED__
#define __IOPOSPOSKeyboard_1_9_FWD_DEFINED__
typedef interface IOPOSPOSKeyboard_1_9 IOPOSPOSKeyboard_1_9;

#endif 	/* __IOPOSPOSKeyboard_1_9_FWD_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_FWD_DEFINED__
#define __IOPOSPOSKeyboard_FWD_DEFINED__
typedef interface IOPOSPOSKeyboard IOPOSPOSKeyboard;

#endif 	/* __IOPOSPOSKeyboard_FWD_DEFINED__ */


#ifndef ___IOPOSPOSKeyboardEvents_FWD_DEFINED__
#define ___IOPOSPOSKeyboardEvents_FWD_DEFINED__
typedef interface _IOPOSPOSKeyboardEvents _IOPOSPOSKeyboardEvents;

#endif 	/* ___IOPOSPOSKeyboardEvents_FWD_DEFINED__ */


#ifndef __OPOSPOSKeyboard_FWD_DEFINED__
#define __OPOSPOSKeyboard_FWD_DEFINED__

#ifdef __cplusplus
typedef class OPOSPOSKeyboard OPOSPOSKeyboard;
#else
typedef struct OPOSPOSKeyboard OPOSPOSKeyboard;
#endif /* __cplusplus */

#endif 	/* __OPOSPOSKeyboard_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IOPOSPOSKeyboard_1_5_INTERFACE_DEFINED__
#define __IOPOSPOSKeyboard_1_5_INTERFACE_DEFINED__

/* interface IOPOSPOSKeyboard_1_5 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSKeyboard_1_5;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB91141-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSKeyboard_1_5 : public IDispatch
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_POSKeyData( 
            /* [retval][out] */ long *pPOSKeyData) = 0;
        
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapKeyUp( 
            /* [retval][out] */ VARIANT_BOOL *pCapKeyUp) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_EventTypes( 
            /* [retval][out] */ long *pEventTypes) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_EventTypes( 
            /* [in] */ long EventTypes) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_POSKeyEventType( 
            /* [retval][out] */ long *pPOSKeyEventType) = 0;
        
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

    typedef struct IOPOSPOSKeyboard_1_5Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSKeyboard_1_5 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSKeyboard_1_5 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSKeyboard_1_5 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyData )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pPOSKeyData);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapKeyUp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapKeyUp )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapKeyUp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_EventTypes)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_EventTypes )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pEventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_EventTypes)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_EventTypes )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long EventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyEventType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyEventType )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pPOSKeyEventType);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSKeyboard_1_5 * This,
            /* [retval][out] */ long *pPowerState);
        
        END_INTERFACE
    } IOPOSPOSKeyboard_1_5Vtbl;

    interface IOPOSPOSKeyboard_1_5
    {
        CONST_VTBL struct IOPOSPOSKeyboard_1_5Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSKeyboard_1_5_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSKeyboard_1_5_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSKeyboard_1_5_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSKeyboard_1_5_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSKeyboard_1_5_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSKeyboard_1_5_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSKeyboard_1_5_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSKeyboard_1_5_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSPOSKeyboard_1_5_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSKeyboard_1_5_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSKeyboard_1_5_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSPOSKeyboard_1_5_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSKeyboard_1_5_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSKeyboard_1_5_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSKeyboard_1_5_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSKeyboard_1_5_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSKeyboard_1_5_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_5_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_5_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_5_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_5_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSKeyboard_1_5_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSKeyboard_1_5_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSKeyboard_1_5_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSKeyboard_1_5_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSKeyboard_1_5_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSKeyboard_1_5_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSKeyboard_1_5_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSKeyboard_1_5_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSKeyboard_1_5_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSKeyboard_1_5_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSKeyboard_1_5_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSKeyboard_1_5_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSKeyboard_1_5_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSPOSKeyboard_1_5_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSKeyboard_1_5_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSKeyboard_1_5_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSKeyboard_1_5_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSKeyboard_1_5_get_POSKeyData(This,pPOSKeyData)	\
    ( (This)->lpVtbl -> get_POSKeyData(This,pPOSKeyData) ) 

#define IOPOSPOSKeyboard_1_5_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSPOSKeyboard_1_5_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSPOSKeyboard_1_5_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSKeyboard_1_5_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSKeyboard_1_5_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSPOSKeyboard_1_5_get_CapKeyUp(This,pCapKeyUp)	\
    ( (This)->lpVtbl -> get_CapKeyUp(This,pCapKeyUp) ) 

#define IOPOSPOSKeyboard_1_5_get_EventTypes(This,pEventTypes)	\
    ( (This)->lpVtbl -> get_EventTypes(This,pEventTypes) ) 

#define IOPOSPOSKeyboard_1_5_put_EventTypes(This,EventTypes)	\
    ( (This)->lpVtbl -> put_EventTypes(This,EventTypes) ) 

#define IOPOSPOSKeyboard_1_5_get_POSKeyEventType(This,pPOSKeyEventType)	\
    ( (This)->lpVtbl -> get_POSKeyEventType(This,pPOSKeyEventType) ) 

#define IOPOSPOSKeyboard_1_5_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSKeyboard_1_5_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSKeyboard_1_5_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSKeyboard_1_5_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSKeyboard_1_5_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_1_8_INTERFACE_DEFINED__
#define __IOPOSPOSKeyboard_1_8_INTERFACE_DEFINED__

/* interface IOPOSPOSKeyboard_1_8 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSKeyboard_1_8;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB92141-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSKeyboard_1_8 : public IOPOSPOSKeyboard_1_5
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

    typedef struct IOPOSPOSKeyboard_1_8Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSKeyboard_1_8 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSKeyboard_1_8 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSKeyboard_1_8 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyData )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pPOSKeyData);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapKeyUp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapKeyUp )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapKeyUp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_EventTypes)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_EventTypes )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pEventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_EventTypes)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_EventTypes )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long EventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyEventType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyEventType )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pPOSKeyEventType);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSKeyboard_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSKeyboard_1_8Vtbl;

    interface IOPOSPOSKeyboard_1_8
    {
        CONST_VTBL struct IOPOSPOSKeyboard_1_8Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSKeyboard_1_8_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSKeyboard_1_8_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSKeyboard_1_8_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSKeyboard_1_8_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSKeyboard_1_8_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSKeyboard_1_8_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSKeyboard_1_8_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSKeyboard_1_8_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSPOSKeyboard_1_8_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSKeyboard_1_8_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSKeyboard_1_8_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSPOSKeyboard_1_8_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSKeyboard_1_8_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSKeyboard_1_8_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSKeyboard_1_8_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSKeyboard_1_8_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSKeyboard_1_8_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_8_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_8_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_8_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_8_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSKeyboard_1_8_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSKeyboard_1_8_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSKeyboard_1_8_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSKeyboard_1_8_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSKeyboard_1_8_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSKeyboard_1_8_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSKeyboard_1_8_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSKeyboard_1_8_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSKeyboard_1_8_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSKeyboard_1_8_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSKeyboard_1_8_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSKeyboard_1_8_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSKeyboard_1_8_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSPOSKeyboard_1_8_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSKeyboard_1_8_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSKeyboard_1_8_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSKeyboard_1_8_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSKeyboard_1_8_get_POSKeyData(This,pPOSKeyData)	\
    ( (This)->lpVtbl -> get_POSKeyData(This,pPOSKeyData) ) 

#define IOPOSPOSKeyboard_1_8_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSPOSKeyboard_1_8_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSPOSKeyboard_1_8_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSKeyboard_1_8_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSKeyboard_1_8_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSPOSKeyboard_1_8_get_CapKeyUp(This,pCapKeyUp)	\
    ( (This)->lpVtbl -> get_CapKeyUp(This,pCapKeyUp) ) 

#define IOPOSPOSKeyboard_1_8_get_EventTypes(This,pEventTypes)	\
    ( (This)->lpVtbl -> get_EventTypes(This,pEventTypes) ) 

#define IOPOSPOSKeyboard_1_8_put_EventTypes(This,EventTypes)	\
    ( (This)->lpVtbl -> put_EventTypes(This,EventTypes) ) 

#define IOPOSPOSKeyboard_1_8_get_POSKeyEventType(This,pPOSKeyEventType)	\
    ( (This)->lpVtbl -> get_POSKeyEventType(This,pPOSKeyEventType) ) 

#define IOPOSPOSKeyboard_1_8_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSKeyboard_1_8_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSKeyboard_1_8_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSKeyboard_1_8_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSPOSKeyboard_1_8_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSKeyboard_1_8_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSKeyboard_1_8_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_1_8_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_1_8_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSKeyboard_1_8_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_1_9_INTERFACE_DEFINED__
#define __IOPOSPOSKeyboard_1_9_INTERFACE_DEFINED__

/* interface IOPOSPOSKeyboard_1_9 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSKeyboard_1_9;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB93141-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSKeyboard_1_9 : public IOPOSPOSKeyboard_1_8
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

    typedef struct IOPOSPOSKeyboard_1_9Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSKeyboard_1_9 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSKeyboard_1_9 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSKeyboard_1_9 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyData )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pPOSKeyData);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapKeyUp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapKeyUp )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapKeyUp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_EventTypes)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_EventTypes )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pEventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_EventTypes)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_EventTypes )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long EventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyEventType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyEventType )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pPOSKeyEventType);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSKeyboard_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSKeyboard_1_9Vtbl;

    interface IOPOSPOSKeyboard_1_9
    {
        CONST_VTBL struct IOPOSPOSKeyboard_1_9Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSKeyboard_1_9_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSKeyboard_1_9_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSKeyboard_1_9_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSKeyboard_1_9_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSKeyboard_1_9_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSKeyboard_1_9_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSKeyboard_1_9_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSKeyboard_1_9_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSPOSKeyboard_1_9_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSKeyboard_1_9_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSKeyboard_1_9_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSPOSKeyboard_1_9_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSKeyboard_1_9_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSKeyboard_1_9_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSKeyboard_1_9_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSKeyboard_1_9_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSKeyboard_1_9_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_9_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSPOSKeyboard_1_9_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_9_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSKeyboard_1_9_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSKeyboard_1_9_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSKeyboard_1_9_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSKeyboard_1_9_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSKeyboard_1_9_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSKeyboard_1_9_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSKeyboard_1_9_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSKeyboard_1_9_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSKeyboard_1_9_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSKeyboard_1_9_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSKeyboard_1_9_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSKeyboard_1_9_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSKeyboard_1_9_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSKeyboard_1_9_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSPOSKeyboard_1_9_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSKeyboard_1_9_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSKeyboard_1_9_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSKeyboard_1_9_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSKeyboard_1_9_get_POSKeyData(This,pPOSKeyData)	\
    ( (This)->lpVtbl -> get_POSKeyData(This,pPOSKeyData) ) 

#define IOPOSPOSKeyboard_1_9_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSPOSKeyboard_1_9_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSPOSKeyboard_1_9_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSKeyboard_1_9_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSKeyboard_1_9_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSPOSKeyboard_1_9_get_CapKeyUp(This,pCapKeyUp)	\
    ( (This)->lpVtbl -> get_CapKeyUp(This,pCapKeyUp) ) 

#define IOPOSPOSKeyboard_1_9_get_EventTypes(This,pEventTypes)	\
    ( (This)->lpVtbl -> get_EventTypes(This,pEventTypes) ) 

#define IOPOSPOSKeyboard_1_9_put_EventTypes(This,EventTypes)	\
    ( (This)->lpVtbl -> put_EventTypes(This,EventTypes) ) 

#define IOPOSPOSKeyboard_1_9_get_POSKeyEventType(This,pPOSKeyEventType)	\
    ( (This)->lpVtbl -> get_POSKeyEventType(This,pPOSKeyEventType) ) 

#define IOPOSPOSKeyboard_1_9_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSKeyboard_1_9_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSKeyboard_1_9_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSKeyboard_1_9_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSPOSKeyboard_1_9_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSKeyboard_1_9_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSKeyboard_1_9_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_1_9_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_1_9_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSKeyboard_1_9_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSKeyboard_1_9_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSKeyboard_1_9_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSKeyboard_1_9_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSKeyboard_1_9_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSKeyboard_INTERFACE_DEFINED__
#define __IOPOSPOSKeyboard_INTERFACE_DEFINED__

/* interface IOPOSPOSKeyboard */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSKeyboard;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB94141-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSKeyboard : public IOPOSPOSKeyboard_1_9
    {
    public:
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSKeyboardVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSKeyboard * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSKeyboard * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSKeyboard * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSKeyboard * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOData)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOData )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataEventEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataEventEnabled )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pDataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DataEventEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DataEventEnabled )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ VARIANT_BOOL DataEventEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ClearInput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearInput )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyData)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyData )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pPOSKeyData);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_AutoDisable)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AutoDisable )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pAutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_AutoDisable)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AutoDisable )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ VARIANT_BOOL AutoDisable);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_DataCount)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DataCount )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pDataCount);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapKeyUp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapKeyUp )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pCapKeyUp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_EventTypes)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_EventTypes )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pEventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_EventTypes)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_EventTypes )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long EventTypes);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_POSKeyEventType)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_POSKeyEventType )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pPOSKeyEventType);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSKeyboard * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSKeyboard * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSKeyboard_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSKeyboard * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSKeyboardVtbl;

    interface IOPOSPOSKeyboard
    {
        CONST_VTBL struct IOPOSPOSKeyboardVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSKeyboard_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSKeyboard_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSKeyboard_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSKeyboard_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSKeyboard_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSKeyboard_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSKeyboard_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSKeyboard_SOData(This,Status)	\
    ( (This)->lpVtbl -> SOData(This,Status) ) 

#define IOPOSPOSKeyboard_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSKeyboard_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSKeyboard_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSPOSKeyboard_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSKeyboard_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSKeyboard_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSKeyboard_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSKeyboard_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSKeyboard_get_DataEventEnabled(This,pDataEventEnabled)	\
    ( (This)->lpVtbl -> get_DataEventEnabled(This,pDataEventEnabled) ) 

#define IOPOSPOSKeyboard_put_DataEventEnabled(This,DataEventEnabled)	\
    ( (This)->lpVtbl -> put_DataEventEnabled(This,DataEventEnabled) ) 

#define IOPOSPOSKeyboard_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSKeyboard_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSKeyboard_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSKeyboard_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSKeyboard_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSKeyboard_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSKeyboard_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSKeyboard_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSKeyboard_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSKeyboard_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSKeyboard_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSKeyboard_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSKeyboard_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSKeyboard_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSKeyboard_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSKeyboard_ClearInput(This,pRC)	\
    ( (This)->lpVtbl -> ClearInput(This,pRC) ) 

#define IOPOSPOSKeyboard_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSKeyboard_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSKeyboard_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSKeyboard_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSKeyboard_get_POSKeyData(This,pPOSKeyData)	\
    ( (This)->lpVtbl -> get_POSKeyData(This,pPOSKeyData) ) 

#define IOPOSPOSKeyboard_get_AutoDisable(This,pAutoDisable)	\
    ( (This)->lpVtbl -> get_AutoDisable(This,pAutoDisable) ) 

#define IOPOSPOSKeyboard_put_AutoDisable(This,AutoDisable)	\
    ( (This)->lpVtbl -> put_AutoDisable(This,AutoDisable) ) 

#define IOPOSPOSKeyboard_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSKeyboard_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSKeyboard_get_DataCount(This,pDataCount)	\
    ( (This)->lpVtbl -> get_DataCount(This,pDataCount) ) 

#define IOPOSPOSKeyboard_get_CapKeyUp(This,pCapKeyUp)	\
    ( (This)->lpVtbl -> get_CapKeyUp(This,pCapKeyUp) ) 

#define IOPOSPOSKeyboard_get_EventTypes(This,pEventTypes)	\
    ( (This)->lpVtbl -> get_EventTypes(This,pEventTypes) ) 

#define IOPOSPOSKeyboard_put_EventTypes(This,EventTypes)	\
    ( (This)->lpVtbl -> put_EventTypes(This,EventTypes) ) 

#define IOPOSPOSKeyboard_get_POSKeyEventType(This,pPOSKeyEventType)	\
    ( (This)->lpVtbl -> get_POSKeyEventType(This,pPOSKeyEventType) ) 

#define IOPOSPOSKeyboard_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSKeyboard_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSKeyboard_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSKeyboard_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 


#define IOPOSPOSKeyboard_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSKeyboard_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSKeyboard_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSKeyboard_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSKeyboard_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSKeyboard_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSKeyboard_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSKeyboard_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSKeyboard_INTERFACE_DEFINED__ */



#ifndef __OposPOSKeyboard_CCO_LIBRARY_DEFINED__
#define __OposPOSKeyboard_CCO_LIBRARY_DEFINED__

/* library OposPOSKeyboard_CCO */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_OposPOSKeyboard_CCO;

#ifndef ___IOPOSPOSKeyboardEvents_DISPINTERFACE_DEFINED__
#define ___IOPOSPOSKeyboardEvents_DISPINTERFACE_DEFINED__

/* dispinterface _IOPOSPOSKeyboardEvents */
/* [helpstring][uuid] */ 


EXTERN_C const IID DIID__IOPOSPOSKeyboardEvents;

#if defined(__cplusplus) && !defined(CINTERFACE)

    MIDL_INTERFACE("CCB90143-B81E-11D2-AB74-0040054C3719")
    _IOPOSPOSKeyboardEvents : public IDispatch
    {
    };
    
#else 	/* C style interface */

    typedef struct _IOPOSPOSKeyboardEventsVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            _IOPOSPOSKeyboardEvents * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            _IOPOSPOSKeyboardEvents * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            _IOPOSPOSKeyboardEvents * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            _IOPOSPOSKeyboardEvents * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            _IOPOSPOSKeyboardEvents * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            _IOPOSPOSKeyboardEvents * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            _IOPOSPOSKeyboardEvents * This,
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
    } _IOPOSPOSKeyboardEventsVtbl;

    interface _IOPOSPOSKeyboardEvents
    {
        CONST_VTBL struct _IOPOSPOSKeyboardEventsVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _IOPOSPOSKeyboardEvents_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define _IOPOSPOSKeyboardEvents_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define _IOPOSPOSKeyboardEvents_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define _IOPOSPOSKeyboardEvents_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define _IOPOSPOSKeyboardEvents_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define _IOPOSPOSKeyboardEvents_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define _IOPOSPOSKeyboardEvents_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */


#endif 	/* ___IOPOSPOSKeyboardEvents_DISPINTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_OPOSPOSKeyboard;

#ifdef __cplusplus

class DECLSPEC_UUID("CCB90142-B81E-11D2-AB74-0040054C3719")
OPOSPOSKeyboard;
#endif
#endif /* __OposPOSKeyboard_CCO_LIBRARY_DEFINED__ */

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


