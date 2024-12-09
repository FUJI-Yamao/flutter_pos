

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


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

#ifndef __CashDrawer_h__
#define __CashDrawer_h__

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

#ifndef __IOPOSCashDrawer_1_5_FWD_DEFINED__
#define __IOPOSCashDrawer_1_5_FWD_DEFINED__
typedef interface IOPOSCashDrawer_1_5 IOPOSCashDrawer_1_5;

#endif 	/* __IOPOSCashDrawer_1_5_FWD_DEFINED__ */


#ifndef __IOPOSCashDrawer_1_8_FWD_DEFINED__
#define __IOPOSCashDrawer_1_8_FWD_DEFINED__
typedef interface IOPOSCashDrawer_1_8 IOPOSCashDrawer_1_8;

#endif 	/* __IOPOSCashDrawer_1_8_FWD_DEFINED__ */


#ifndef __IOPOSCashDrawer_1_9_FWD_DEFINED__
#define __IOPOSCashDrawer_1_9_FWD_DEFINED__
typedef interface IOPOSCashDrawer_1_9 IOPOSCashDrawer_1_9;

#endif 	/* __IOPOSCashDrawer_1_9_FWD_DEFINED__ */


#ifndef __IOPOSCashDrawer_FWD_DEFINED__
#define __IOPOSCashDrawer_FWD_DEFINED__
typedef interface IOPOSCashDrawer IOPOSCashDrawer;

#endif 	/* __IOPOSCashDrawer_FWD_DEFINED__ */


#ifndef ___IOPOSCashDrawerEvents_FWD_DEFINED__
#define ___IOPOSCashDrawerEvents_FWD_DEFINED__
typedef interface _IOPOSCashDrawerEvents _IOPOSCashDrawerEvents;

#endif 	/* ___IOPOSCashDrawerEvents_FWD_DEFINED__ */


#ifndef __OPOSCashDrawer_FWD_DEFINED__
#define __OPOSCashDrawer_FWD_DEFINED__

#ifdef __cplusplus
typedef class OPOSCashDrawer OPOSCashDrawer;
#else
typedef struct OPOSCashDrawer OPOSCashDrawer;
#endif /* __cplusplus */

#endif 	/* __OPOSCashDrawer_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IOPOSCashDrawer_1_5_INTERFACE_DEFINED__
#define __IOPOSCashDrawer_1_5_INTERFACE_DEFINED__

/* interface IOPOSCashDrawer_1_5 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSCashDrawer_1_5;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB91041-B81E-11D2-AB74-0040054C3719")
    IOPOSCashDrawer_1_5 : public IDispatch
    {
    public:
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SODataDummy( 
            /* [in] */ long Status) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SODirectIO( 
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString) = 0;
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOErrorDummy( 
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapStatus( 
            /* [retval][out] */ VARIANT_BOOL *pCapStatus) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_DrawerOpened( 
            /* [retval][out] */ VARIANT_BOOL *pDrawerOpened) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE OpenDrawer( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE WaitForDrawerClose( 
            /* [in] */ long BeepTimeout,
            /* [in] */ long BeepFrequency,
            /* [in] */ long BeepDuration,
            /* [in] */ long BeepDelay,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_BinaryConversion( 
            /* [retval][out] */ long *pBinaryConversion) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_BinaryConversion( 
            /* [in] */ long BinaryConversion) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapPowerReporting( 
            /* [retval][out] */ long *pCapPowerReporting) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PowerNotify( 
            /* [retval][out] */ long *pPowerNotify) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PowerNotify( 
            /* [in] */ long PowerNotify) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PowerState( 
            /* [retval][out] */ long *pPowerState) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapStatusMultiDrawerDetect( 
            /* [retval][out] */ VARIANT_BOOL *pCapStatusMultiDrawerDetect) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSCashDrawer_1_5Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSCashDrawer_1_5 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSCashDrawer_1_5 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSCashDrawer_1_5 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSCashDrawer_1_5 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOErrorDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOErrorDummy )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatus)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatus )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatus);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DrawerOpened)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DrawerOpened )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDrawerOpened);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, OpenDrawer)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *OpenDrawer )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, WaitForDrawerClose)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *WaitForDrawerClose )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long BeepTimeout,
            /* [in] */ long BeepFrequency,
            /* [in] */ long BeepDuration,
            /* [in] */ long BeepDelay,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSCashDrawer_1_5 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatusMultiDrawerDetect)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatusMultiDrawerDetect )( 
            IOPOSCashDrawer_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatusMultiDrawerDetect);
        
        END_INTERFACE
    } IOPOSCashDrawer_1_5Vtbl;

    interface IOPOSCashDrawer_1_5
    {
        CONST_VTBL struct IOPOSCashDrawer_1_5Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSCashDrawer_1_5_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSCashDrawer_1_5_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSCashDrawer_1_5_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSCashDrawer_1_5_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSCashDrawer_1_5_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSCashDrawer_1_5_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSCashDrawer_1_5_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSCashDrawer_1_5_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSCashDrawer_1_5_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSCashDrawer_1_5_SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSCashDrawer_1_5_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSCashDrawer_1_5_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSCashDrawer_1_5_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSCashDrawer_1_5_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSCashDrawer_1_5_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSCashDrawer_1_5_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSCashDrawer_1_5_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSCashDrawer_1_5_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSCashDrawer_1_5_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSCashDrawer_1_5_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSCashDrawer_1_5_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSCashDrawer_1_5_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSCashDrawer_1_5_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSCashDrawer_1_5_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSCashDrawer_1_5_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSCashDrawer_1_5_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSCashDrawer_1_5_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSCashDrawer_1_5_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSCashDrawer_1_5_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSCashDrawer_1_5_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSCashDrawer_1_5_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSCashDrawer_1_5_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSCashDrawer_1_5_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSCashDrawer_1_5_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSCashDrawer_1_5_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSCashDrawer_1_5_get_CapStatus(This,pCapStatus)	\
    ( (This)->lpVtbl -> get_CapStatus(This,pCapStatus) ) 

#define IOPOSCashDrawer_1_5_get_DrawerOpened(This,pDrawerOpened)	\
    ( (This)->lpVtbl -> get_DrawerOpened(This,pDrawerOpened) ) 

#define IOPOSCashDrawer_1_5_OpenDrawer(This,pRC)	\
    ( (This)->lpVtbl -> OpenDrawer(This,pRC) ) 

#define IOPOSCashDrawer_1_5_WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC)	\
    ( (This)->lpVtbl -> WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC) ) 

#define IOPOSCashDrawer_1_5_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSCashDrawer_1_5_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSCashDrawer_1_5_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSCashDrawer_1_5_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSCashDrawer_1_5_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSCashDrawer_1_5_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSCashDrawer_1_5_get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect)	\
    ( (This)->lpVtbl -> get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSCashDrawer_1_5_INTERFACE_DEFINED__ */


#ifndef __IOPOSCashDrawer_1_8_INTERFACE_DEFINED__
#define __IOPOSCashDrawer_1_8_INTERFACE_DEFINED__

/* interface IOPOSCashDrawer_1_8 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSCashDrawer_1_8;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB92041-B81E-11D2-AB74-0040054C3719")
    IOPOSCashDrawer_1_8 : public IOPOSCashDrawer_1_5
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

    typedef struct IOPOSCashDrawer_1_8Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSCashDrawer_1_8 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSCashDrawer_1_8 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSCashDrawer_1_8 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSCashDrawer_1_8 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOErrorDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOErrorDummy )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatus)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatus )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatus);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DrawerOpened)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DrawerOpened )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDrawerOpened);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, OpenDrawer)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *OpenDrawer )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, WaitForDrawerClose)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *WaitForDrawerClose )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long BeepTimeout,
            /* [in] */ long BeepFrequency,
            /* [in] */ long BeepDuration,
            /* [in] */ long BeepDelay,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatusMultiDrawerDetect)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatusMultiDrawerDetect )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatusMultiDrawerDetect);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSCashDrawer_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSCashDrawer_1_8 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSCashDrawer_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSCashDrawer_1_8Vtbl;

    interface IOPOSCashDrawer_1_8
    {
        CONST_VTBL struct IOPOSCashDrawer_1_8Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSCashDrawer_1_8_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSCashDrawer_1_8_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSCashDrawer_1_8_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSCashDrawer_1_8_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSCashDrawer_1_8_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSCashDrawer_1_8_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSCashDrawer_1_8_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSCashDrawer_1_8_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSCashDrawer_1_8_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSCashDrawer_1_8_SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSCashDrawer_1_8_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSCashDrawer_1_8_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSCashDrawer_1_8_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSCashDrawer_1_8_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSCashDrawer_1_8_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSCashDrawer_1_8_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSCashDrawer_1_8_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSCashDrawer_1_8_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSCashDrawer_1_8_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSCashDrawer_1_8_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSCashDrawer_1_8_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSCashDrawer_1_8_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSCashDrawer_1_8_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSCashDrawer_1_8_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSCashDrawer_1_8_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSCashDrawer_1_8_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSCashDrawer_1_8_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSCashDrawer_1_8_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSCashDrawer_1_8_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSCashDrawer_1_8_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSCashDrawer_1_8_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSCashDrawer_1_8_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSCashDrawer_1_8_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSCashDrawer_1_8_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSCashDrawer_1_8_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSCashDrawer_1_8_get_CapStatus(This,pCapStatus)	\
    ( (This)->lpVtbl -> get_CapStatus(This,pCapStatus) ) 

#define IOPOSCashDrawer_1_8_get_DrawerOpened(This,pDrawerOpened)	\
    ( (This)->lpVtbl -> get_DrawerOpened(This,pDrawerOpened) ) 

#define IOPOSCashDrawer_1_8_OpenDrawer(This,pRC)	\
    ( (This)->lpVtbl -> OpenDrawer(This,pRC) ) 

#define IOPOSCashDrawer_1_8_WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC)	\
    ( (This)->lpVtbl -> WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC) ) 

#define IOPOSCashDrawer_1_8_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSCashDrawer_1_8_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSCashDrawer_1_8_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSCashDrawer_1_8_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSCashDrawer_1_8_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSCashDrawer_1_8_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSCashDrawer_1_8_get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect)	\
    ( (This)->lpVtbl -> get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect) ) 


#define IOPOSCashDrawer_1_8_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSCashDrawer_1_8_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSCashDrawer_1_8_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_1_8_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_1_8_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSCashDrawer_1_8_INTERFACE_DEFINED__ */


#ifndef __IOPOSCashDrawer_1_9_INTERFACE_DEFINED__
#define __IOPOSCashDrawer_1_9_INTERFACE_DEFINED__

/* interface IOPOSCashDrawer_1_9 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSCashDrawer_1_9;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB93041-B81E-11D2-AB74-0040054C3719")
    IOPOSCashDrawer_1_9 : public IOPOSCashDrawer_1_8
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

    typedef struct IOPOSCashDrawer_1_9Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSCashDrawer_1_9 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSCashDrawer_1_9 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSCashDrawer_1_9 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSCashDrawer_1_9 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOErrorDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOErrorDummy )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatus)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatus )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatus);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DrawerOpened)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DrawerOpened )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDrawerOpened);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, OpenDrawer)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *OpenDrawer )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, WaitForDrawerClose)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *WaitForDrawerClose )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long BeepTimeout,
            /* [in] */ long BeepFrequency,
            /* [in] */ long BeepDuration,
            /* [in] */ long BeepDelay,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatusMultiDrawerDetect)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatusMultiDrawerDetect )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatusMultiDrawerDetect);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSCashDrawer_1_9 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSCashDrawer_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSCashDrawer_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSCashDrawer_1_9Vtbl;

    interface IOPOSCashDrawer_1_9
    {
        CONST_VTBL struct IOPOSCashDrawer_1_9Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSCashDrawer_1_9_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSCashDrawer_1_9_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSCashDrawer_1_9_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSCashDrawer_1_9_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSCashDrawer_1_9_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSCashDrawer_1_9_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSCashDrawer_1_9_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSCashDrawer_1_9_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSCashDrawer_1_9_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSCashDrawer_1_9_SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSCashDrawer_1_9_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSCashDrawer_1_9_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSCashDrawer_1_9_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSCashDrawer_1_9_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSCashDrawer_1_9_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSCashDrawer_1_9_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSCashDrawer_1_9_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSCashDrawer_1_9_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSCashDrawer_1_9_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSCashDrawer_1_9_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSCashDrawer_1_9_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSCashDrawer_1_9_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSCashDrawer_1_9_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSCashDrawer_1_9_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSCashDrawer_1_9_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSCashDrawer_1_9_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSCashDrawer_1_9_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSCashDrawer_1_9_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSCashDrawer_1_9_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSCashDrawer_1_9_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSCashDrawer_1_9_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSCashDrawer_1_9_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSCashDrawer_1_9_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSCashDrawer_1_9_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSCashDrawer_1_9_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSCashDrawer_1_9_get_CapStatus(This,pCapStatus)	\
    ( (This)->lpVtbl -> get_CapStatus(This,pCapStatus) ) 

#define IOPOSCashDrawer_1_9_get_DrawerOpened(This,pDrawerOpened)	\
    ( (This)->lpVtbl -> get_DrawerOpened(This,pDrawerOpened) ) 

#define IOPOSCashDrawer_1_9_OpenDrawer(This,pRC)	\
    ( (This)->lpVtbl -> OpenDrawer(This,pRC) ) 

#define IOPOSCashDrawer_1_9_WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC)	\
    ( (This)->lpVtbl -> WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC) ) 

#define IOPOSCashDrawer_1_9_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSCashDrawer_1_9_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSCashDrawer_1_9_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSCashDrawer_1_9_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSCashDrawer_1_9_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSCashDrawer_1_9_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSCashDrawer_1_9_get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect)	\
    ( (This)->lpVtbl -> get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect) ) 


#define IOPOSCashDrawer_1_9_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSCashDrawer_1_9_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSCashDrawer_1_9_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_1_9_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_1_9_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSCashDrawer_1_9_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSCashDrawer_1_9_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSCashDrawer_1_9_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSCashDrawer_1_9_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSCashDrawer_1_9_INTERFACE_DEFINED__ */


#ifndef __IOPOSCashDrawer_INTERFACE_DEFINED__
#define __IOPOSCashDrawer_INTERFACE_DEFINED__

/* interface IOPOSCashDrawer */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSCashDrawer;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB94041-B81E-11D2-AB74-0040054C3719")
    IOPOSCashDrawer : public IOPOSCashDrawer_1_9
    {
    public:
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSCashDrawerVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSCashDrawer * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSCashDrawer * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSCashDrawer * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSCashDrawer * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSCashDrawer * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSCashDrawer * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSCashDrawer * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSCashDrawer * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSCashDrawer * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOErrorDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOErrorDummy )( 
            IOPOSCashDrawer * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOOutputCompleteDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputCompleteDummy )( 
            IOPOSCashDrawer * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSCashDrawer * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSCashDrawer * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSCashDrawer * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSCashDrawer * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSCashDrawer * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSCashDrawer * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSCashDrawer * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatus)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatus )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatus);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_DrawerOpened)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DrawerOpened )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pDrawerOpened);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, OpenDrawer)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *OpenDrawer )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, WaitForDrawerClose)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *WaitForDrawerClose )( 
            IOPOSCashDrawer * This,
            /* [in] */ long BeepTimeout,
            /* [in] */ long BeepFrequency,
            /* [in] */ long BeepDuration,
            /* [in] */ long BeepDelay,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSCashDrawer * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSCashDrawer * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_5, get_CapStatusMultiDrawerDetect)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatusMultiDrawerDetect )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatusMultiDrawerDetect);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSCashDrawer * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSCashDrawer * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSCashDrawer * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSCashDrawer * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSCashDrawer * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSCashDrawer_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSCashDrawer * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSCashDrawerVtbl;

    interface IOPOSCashDrawer
    {
        CONST_VTBL struct IOPOSCashDrawerVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSCashDrawer_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSCashDrawer_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSCashDrawer_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSCashDrawer_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSCashDrawer_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSCashDrawer_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSCashDrawer_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSCashDrawer_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSCashDrawer_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSCashDrawer_SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOErrorDummy(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSCashDrawer_SOOutputCompleteDummy(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputCompleteDummy(This,OutputID) ) 

#define IOPOSCashDrawer_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSCashDrawer_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSCashDrawer_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSCashDrawer_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSCashDrawer_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSCashDrawer_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSCashDrawer_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSCashDrawer_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSCashDrawer_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSCashDrawer_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSCashDrawer_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSCashDrawer_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSCashDrawer_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSCashDrawer_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSCashDrawer_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSCashDrawer_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSCashDrawer_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSCashDrawer_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSCashDrawer_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSCashDrawer_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSCashDrawer_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSCashDrawer_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSCashDrawer_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSCashDrawer_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSCashDrawer_get_CapStatus(This,pCapStatus)	\
    ( (This)->lpVtbl -> get_CapStatus(This,pCapStatus) ) 

#define IOPOSCashDrawer_get_DrawerOpened(This,pDrawerOpened)	\
    ( (This)->lpVtbl -> get_DrawerOpened(This,pDrawerOpened) ) 

#define IOPOSCashDrawer_OpenDrawer(This,pRC)	\
    ( (This)->lpVtbl -> OpenDrawer(This,pRC) ) 

#define IOPOSCashDrawer_WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC)	\
    ( (This)->lpVtbl -> WaitForDrawerClose(This,BeepTimeout,BeepFrequency,BeepDuration,BeepDelay,pRC) ) 

#define IOPOSCashDrawer_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSCashDrawer_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSCashDrawer_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSCashDrawer_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSCashDrawer_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSCashDrawer_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSCashDrawer_get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect)	\
    ( (This)->lpVtbl -> get_CapStatusMultiDrawerDetect(This,pCapStatusMultiDrawerDetect) ) 


#define IOPOSCashDrawer_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSCashDrawer_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSCashDrawer_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSCashDrawer_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSCashDrawer_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSCashDrawer_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSCashDrawer_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSCashDrawer_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSCashDrawer_INTERFACE_DEFINED__ */



#ifndef __OposCashDrawer_CCO_LIBRARY_DEFINED__
#define __OposCashDrawer_CCO_LIBRARY_DEFINED__

/* library OposCashDrawer_CCO */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_OposCashDrawer_CCO;

#ifndef ___IOPOSCashDrawerEvents_DISPINTERFACE_DEFINED__
#define ___IOPOSCashDrawerEvents_DISPINTERFACE_DEFINED__

/* dispinterface _IOPOSCashDrawerEvents */
/* [helpstring][uuid] */ 


EXTERN_C const IID DIID__IOPOSCashDrawerEvents;

#if defined(__cplusplus) && !defined(CINTERFACE)

    MIDL_INTERFACE("CCB90043-B81E-11D2-AB74-0040054C3719")
    _IOPOSCashDrawerEvents : public IDispatch
    {
    };
    
#else 	/* C style interface */

    typedef struct _IOPOSCashDrawerEventsVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            _IOPOSCashDrawerEvents * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            _IOPOSCashDrawerEvents * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            _IOPOSCashDrawerEvents * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            _IOPOSCashDrawerEvents * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            _IOPOSCashDrawerEvents * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            _IOPOSCashDrawerEvents * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            _IOPOSCashDrawerEvents * This,
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
    } _IOPOSCashDrawerEventsVtbl;

    interface _IOPOSCashDrawerEvents
    {
        CONST_VTBL struct _IOPOSCashDrawerEventsVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _IOPOSCashDrawerEvents_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define _IOPOSCashDrawerEvents_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define _IOPOSCashDrawerEvents_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define _IOPOSCashDrawerEvents_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define _IOPOSCashDrawerEvents_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define _IOPOSCashDrawerEvents_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define _IOPOSCashDrawerEvents_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */


#endif 	/* ___IOPOSCashDrawerEvents_DISPINTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_OPOSCashDrawer;

#ifdef __cplusplus

class DECLSPEC_UUID("CCB90042-B81E-11D2-AB74-0040054C3719")
OPOSCashDrawer;
#endif
#endif /* __OposCashDrawer_CCO_LIBRARY_DEFINED__ */

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


