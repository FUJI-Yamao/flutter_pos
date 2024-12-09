

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


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

#ifndef __POSPrinter_h__
#define __POSPrinter_h__

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

#ifndef __IOPOSPOSPrinter_1_5_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_5_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_5 IOPOSPOSPrinter_1_5;

#endif 	/* __IOPOSPOSPrinter_1_5_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_7_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_7_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_7 IOPOSPOSPrinter_1_7;

#endif 	/* __IOPOSPOSPrinter_1_7_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_8_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_8_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_8 IOPOSPOSPrinter_1_8;

#endif 	/* __IOPOSPOSPrinter_1_8_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_9_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_9_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_9 IOPOSPOSPrinter_1_9;

#endif 	/* __IOPOSPOSPrinter_1_9_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_10_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_10_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_10 IOPOSPOSPrinter_1_10;

#endif 	/* __IOPOSPOSPrinter_1_10_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_10_zz_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_10_zz_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_10_zz IOPOSPOSPrinter_1_10_zz;

#endif 	/* __IOPOSPOSPrinter_1_10_zz_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_13_FWD_DEFINED__
#define __IOPOSPOSPrinter_1_13_FWD_DEFINED__
typedef interface IOPOSPOSPrinter_1_13 IOPOSPOSPrinter_1_13;

#endif 	/* __IOPOSPOSPrinter_1_13_FWD_DEFINED__ */


#ifndef __IOPOSPOSPrinter_FWD_DEFINED__
#define __IOPOSPOSPrinter_FWD_DEFINED__
typedef interface IOPOSPOSPrinter IOPOSPOSPrinter;

#endif 	/* __IOPOSPOSPrinter_FWD_DEFINED__ */


#ifndef ___IOPOSPOSPrinterEvents_FWD_DEFINED__
#define ___IOPOSPOSPrinterEvents_FWD_DEFINED__
typedef interface _IOPOSPOSPrinterEvents _IOPOSPOSPrinterEvents;

#endif 	/* ___IOPOSPOSPrinterEvents_FWD_DEFINED__ */


#ifndef __OPOSPOSPrinter_FWD_DEFINED__
#define __OPOSPOSPrinter_FWD_DEFINED__

#ifdef __cplusplus
typedef class OPOSPOSPrinter OPOSPOSPrinter;
#else
typedef struct OPOSPOSPrinter OPOSPOSPrinter;
#endif /* __cplusplus */

#endif 	/* __OPOSPOSPrinter_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"
#include "ocidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IOPOSPOSPrinter_1_5_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_5_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_5 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_5;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB91151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_5 : public IDispatch
    {
    public:
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SODataDummy( 
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
        
        virtual /* [helpstring][hidden][id] */ HRESULT STDMETHODCALLTYPE SOOutputComplete( 
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_OutputID( 
            /* [retval][out] */ long *pOutputID) = 0;
        
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
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ClearOutput( 
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_AsyncMode( 
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_AsyncMode( 
            /* [in] */ VARIANT_BOOL AsyncMode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapConcurrentJrnRec( 
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapConcurrentJrnSlp( 
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapConcurrentRecSlp( 
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapCoverSensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrn2Color( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnBold( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnDwide( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnDwideDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnEmptySensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnItalic( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnNearEndSensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnPresent( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnUnderline( 
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRec2Color( 
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecBarCode( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecBitmap( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecBold( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecDwide( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecDwideDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecEmptySensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecItalic( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecLeft90( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecNearEndSensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecPapercut( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecPresent( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecRight90( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecRotate180( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecStamp( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecUnderline( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlp2Color( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpBarCode( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpBitmap( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpBold( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpDwide( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpDwideDhigh( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpEmptySensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpFullslip( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpItalic( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpLeft90( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpNearEndSensor( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpPresent( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpRight90( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpRotate180( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpUnderline( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CharacterSet( 
            /* [retval][out] */ long *pCharacterSet) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_CharacterSet( 
            /* [in] */ long CharacterSet) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CharacterSetList( 
            /* [retval][out] */ BSTR *pCharacterSetList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CoverOpen( 
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ErrorStation( 
            /* [retval][out] */ long *pErrorStation) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_FlagWhenIdle( 
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_FlagWhenIdle( 
            /* [in] */ VARIANT_BOOL FlagWhenIdle) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnEmpty( 
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLetterQuality( 
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_JrnLetterQuality( 
            /* [in] */ VARIANT_BOOL JrnLetterQuality) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLineChars( 
            /* [retval][out] */ long *pJrnLineChars) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_JrnLineChars( 
            /* [in] */ long JrnLineChars) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLineCharsList( 
            /* [retval][out] */ BSTR *pJrnLineCharsList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLineHeight( 
            /* [retval][out] */ long *pJrnLineHeight) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_JrnLineHeight( 
            /* [in] */ long JrnLineHeight) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLineSpacing( 
            /* [retval][out] */ long *pJrnLineSpacing) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_JrnLineSpacing( 
            /* [in] */ long JrnLineSpacing) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnLineWidth( 
            /* [retval][out] */ long *pJrnLineWidth) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnNearEnd( 
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_MapMode( 
            /* [retval][out] */ long *pMapMode) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_MapMode( 
            /* [in] */ long MapMode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecEmpty( 
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLetterQuality( 
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RecLetterQuality( 
            /* [in] */ VARIANT_BOOL RecLetterQuality) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLineChars( 
            /* [retval][out] */ long *pRecLineChars) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RecLineChars( 
            /* [in] */ long RecLineChars) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLineCharsList( 
            /* [retval][out] */ BSTR *pRecLineCharsList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLineHeight( 
            /* [retval][out] */ long *pRecLineHeight) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RecLineHeight( 
            /* [in] */ long RecLineHeight) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLineSpacing( 
            /* [retval][out] */ long *pRecLineSpacing) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RecLineSpacing( 
            /* [in] */ long RecLineSpacing) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLinesToPaperCut( 
            /* [retval][out] */ long *pRecLinesToPaperCut) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecLineWidth( 
            /* [retval][out] */ long *pRecLineWidth) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecNearEnd( 
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecSidewaysMaxChars( 
            /* [retval][out] */ long *pRecSidewaysMaxChars) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecSidewaysMaxLines( 
            /* [retval][out] */ long *pRecSidewaysMaxLines) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpEmpty( 
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLetterQuality( 
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_SlpLetterQuality( 
            /* [in] */ VARIANT_BOOL SlpLetterQuality) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLineChars( 
            /* [retval][out] */ long *pSlpLineChars) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_SlpLineChars( 
            /* [in] */ long SlpLineChars) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLineCharsList( 
            /* [retval][out] */ BSTR *pSlpLineCharsList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLineHeight( 
            /* [retval][out] */ long *pSlpLineHeight) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_SlpLineHeight( 
            /* [in] */ long SlpLineHeight) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLinesNearEndToEnd( 
            /* [retval][out] */ long *pSlpLinesNearEndToEnd) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLineSpacing( 
            /* [retval][out] */ long *pSlpLineSpacing) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_SlpLineSpacing( 
            /* [in] */ long SlpLineSpacing) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpLineWidth( 
            /* [retval][out] */ long *pSlpLineWidth) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpMaxLines( 
            /* [retval][out] */ long *pSlpMaxLines) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpNearEnd( 
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpSidewaysMaxChars( 
            /* [retval][out] */ long *pSlpSidewaysMaxChars) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpSidewaysMaxLines( 
            /* [retval][out] */ long *pSlpSidewaysMaxLines) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE BeginInsertion( 
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE BeginRemoval( 
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE CutPaper( 
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE EndInsertion( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE EndRemoval( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintBarCode( 
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintBitmap( 
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintImmediate( 
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintNormal( 
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintTwoNormal( 
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE RotatePrint( 
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE SetBitmap( 
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE SetLogo( 
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapCharacterSet( 
            /* [retval][out] */ long *pCapCharacterSet) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapTransaction( 
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ErrorLevel( 
            /* [retval][out] */ long *pErrorLevel) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_ErrorString( 
            /* [retval][out] */ BSTR *pErrorString) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_FontTypefaceList( 
            /* [retval][out] */ BSTR *pFontTypefaceList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecBarCodeRotationList( 
            /* [retval][out] */ BSTR *pRecBarCodeRotationList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RotateSpecial( 
            /* [retval][out] */ long *pRotateSpecial) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RotateSpecial( 
            /* [in] */ long RotateSpecial) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpBarCodeRotationList( 
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE TransactionPrint( 
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ValidateData( 
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnCartridgeSensor( 
            /* [retval][out] */ long *pCapJrnCartridgeSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapJrnColor( 
            /* [retval][out] */ long *pCapJrnColor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecCartridgeSensor( 
            /* [retval][out] */ long *pCapRecCartridgeSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecColor( 
            /* [retval][out] */ long *pCapRecColor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecMarkFeed( 
            /* [retval][out] */ long *pCapRecMarkFeed) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpBothSidesPrint( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpCartridgeSensor( 
            /* [retval][out] */ long *pCapSlpCartridgeSensor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpColor( 
            /* [retval][out] */ long *pCapSlpColor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CartridgeNotify( 
            /* [retval][out] */ long *pCartridgeNotify) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_CartridgeNotify( 
            /* [in] */ long CartridgeNotify) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnCartridgeState( 
            /* [retval][out] */ long *pJrnCartridgeState) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_JrnCurrentCartridge( 
            /* [retval][out] */ long *pJrnCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_JrnCurrentCartridge( 
            /* [in] */ long JrnCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecCartridgeState( 
            /* [retval][out] */ long *pRecCartridgeState) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecCurrentCartridge( 
            /* [retval][out] */ long *pRecCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_RecCurrentCartridge( 
            /* [in] */ long RecCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpCartridgeState( 
            /* [retval][out] */ long *pSlpCartridgeState) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpCurrentCartridge( 
            /* [retval][out] */ long *pSlpCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_SlpCurrentCartridge( 
            /* [in] */ long SlpCurrentCartridge) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpPrintSide( 
            /* [retval][out] */ long *pSlpPrintSide) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ChangePrintSide( 
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE MarkFeed( 
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_5Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_5 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_5 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_5 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_5 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_5Vtbl;

    interface IOPOSPOSPrinter_1_5
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_5Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_5_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_5_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_5_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_5_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_5_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_5_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_5_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_5_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_5_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_5_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_5_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_5_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_5_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_5_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_5_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_5_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_5_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_5_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_5_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_5_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_5_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_5_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_5_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_5_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_5_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_5_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_5_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_5_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_5_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_5_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_5_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_5_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_5_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_5_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_5_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_5_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_5_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_5_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_5_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_5_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_5_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_5_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_5_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_5_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_5_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_5_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_5_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_5_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_5_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_5_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_5_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_5_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_5_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_5_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_5_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_5_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_5_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_5_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_5_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_5_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_5_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_5_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_5_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_5_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_5_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_5_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_5_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_5_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_5_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_5_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_5_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_5_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_5_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_5_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_5_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_5_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_5_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_5_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_5_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_5_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_5_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_5_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_5_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_5_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_5_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_5_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_5_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_5_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_5_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_5_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_5_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_5_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_5_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_5_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_5_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_5_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_5_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_5_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_5_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_5_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_5_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_5_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_5_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_5_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_5_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_5_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_5_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_5_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_5_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_5_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_5_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineHeight_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineHeight);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpLineHeight_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpLineHeight_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpLineHeight);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_SlpLineHeight_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLinesNearEndToEnd);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpLinesNearEndToEnd_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineSpacing);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpLineSpacing_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpLineSpacing);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_SlpLineSpacing_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpLineWidth_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpLineWidth);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpLineWidth_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpMaxLines_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpMaxLines);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpMaxLines_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpNearEnd_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpNearEnd_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpSidewaysMaxChars);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxChars_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpSidewaysMaxLines);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpSidewaysMaxLines_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_BeginInsertion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Timeout,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_BeginInsertion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_BeginRemoval_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Timeout,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_BeginRemoval_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_CutPaper_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Percentage,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_CutPaper_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_EndInsertion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_EndInsertion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_EndRemoval_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_EndRemoval_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintBarCode_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [in] */ long Symbology,
    /* [in] */ long Height,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [in] */ long TextPosition,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_PrintBarCode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintBitmap_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR FileName,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_PrintBitmap_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintImmediate_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_PrintImmediate_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintNormal_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_PrintNormal_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_PrintTwoNormal_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Stations,
    /* [in] */ BSTR Data1,
    /* [in] */ BSTR Data2,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_PrintTwoNormal_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_RotatePrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ long Rotation,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_RotatePrint_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_SetBitmap_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long BitmapNumber,
    /* [in] */ long Station,
    /* [in] */ BSTR FileName,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_SetBitmap_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_SetLogo_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Location,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_SetLogo_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapCharacterSet);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapCharacterSet_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapTransaction_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapTransaction);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapTransaction_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_ErrorLevel_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pErrorLevel);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_ErrorLevel_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_ErrorString_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pErrorString);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_ErrorString_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_FontTypefaceList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pFontTypefaceList);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_FontTypefaceList_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pRecBarCodeRotationList);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_RecBarCodeRotationList_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RotateSpecial_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRotateSpecial);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_RotateSpecial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_RotateSpecial_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long RotateSpecial);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_RotateSpecial_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ BSTR *pSlpBarCodeRotationList);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpBarCodeRotationList_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_TransactionPrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ long Control,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_TransactionPrint_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_ValidateData_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_ValidateData_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_BinaryConversion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pBinaryConversion);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_BinaryConversion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_BinaryConversion_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long BinaryConversion);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_BinaryConversion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapPowerReporting_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapPowerReporting);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapPowerReporting_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_PowerNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pPowerNotify);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_PowerNotify_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_PowerNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long PowerNotify);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_PowerNotify_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_PowerState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pPowerState);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_PowerState_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapJrnCartridgeSensor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapJrnCartridgeSensor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapJrnColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapJrnColor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapJrnColor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecCartridgeSensor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapRecCartridgeSensor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecColor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapRecColor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapRecMarkFeed);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapRecMarkFeed_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapSlpBothSidesPrint_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapSlpCartridgeSensor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapSlpCartridgeSensor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CapSlpColor_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCapSlpColor);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CapSlpColor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_CartridgeNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pCartridgeNotify);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_CartridgeNotify_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_CartridgeNotify_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long CartridgeNotify);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_CartridgeNotify_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pJrnCartridgeState);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_JrnCartridgeState_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pJrnCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_JrnCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long JrnCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_JrnCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRecCartridgeState);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_RecCartridgeState_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pRecCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_RecCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long RecCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_RecCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpCartridgeState);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpCartridgeState_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long SlpCurrentCartridge);


void __RPC_STUB IOPOSPOSPrinter_1_5_put_SlpCurrentCartridge_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_get_SlpPrintSide_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [retval][out] */ long *pSlpPrintSide);


void __RPC_STUB IOPOSPOSPrinter_1_5_get_SlpPrintSide_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_ChangePrintSide_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Side,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_ChangePrintSide_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_5_MarkFeed_Proxy( 
    IOPOSPOSPrinter_1_5 * This,
    /* [in] */ long Type,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_5_MarkFeed_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_5_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_7_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_7_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_7 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_7;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB92151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_7 : public IOPOSPOSPrinter_1_5
    {
    public:
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapMapCharacterSet( 
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_MapCharacterSet( 
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_MapCharacterSet( 
            /* [in] */ VARIANT_BOOL MapCharacterSet) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_RecBitmapRotationList( 
            /* [retval][out] */ BSTR *pRecBitmapRotationList) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_SlpBitmapRotationList( 
            /* [retval][out] */ BSTR *pSlpBitmapRotationList) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_7Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_7 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_7 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_7 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_7 * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_7Vtbl;

    interface IOPOSPOSPrinter_1_7
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_7Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_7_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_7_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_7_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_7_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_7_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_7_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_7_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_7_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_7_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_7_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_7_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_7_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_7_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_7_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_7_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_7_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_7_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_7_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_7_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_7_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_7_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_7_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_7_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_7_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_7_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_7_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_7_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_7_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_7_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_7_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_7_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_7_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_7_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_7_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_7_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_7_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_7_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_7_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_7_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_7_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_7_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_7_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_7_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_7_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_7_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_7_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_7_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_7_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_7_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_7_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_7_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_7_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_7_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_7_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_7_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_7_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_7_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_7_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_7_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_7_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_7_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_7_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_7_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_7_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_7_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_7_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_7_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_7_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_7_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_7_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_7_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_7_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_7_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_7_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_7_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_7_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_7_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_7_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_7_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_7_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_7_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_7_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_7_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_7_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_7_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_7_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_7_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_7_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_7_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_7_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_7_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_7_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_7_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_7_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_7_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_7_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_7_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_7_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_7_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_7_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_7_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_7_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_7_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_7_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_7_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_7_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_7_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_7_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_7_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_7_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_7_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_7_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_7_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_7_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_7_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_7_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_7_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_7_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_7_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_7_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_7_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);


void __RPC_STUB IOPOSPOSPrinter_1_7_get_CapMapCharacterSet_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_MapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);


void __RPC_STUB IOPOSPOSPrinter_1_7_get_MapCharacterSet_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_put_MapCharacterSet_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [in] */ VARIANT_BOOL MapCharacterSet);


void __RPC_STUB IOPOSPOSPrinter_1_7_put_MapCharacterSet_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ BSTR *pRecBitmapRotationList);


void __RPC_STUB IOPOSPOSPrinter_1_7_get_RecBitmapRotationList_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Proxy( 
    IOPOSPOSPrinter_1_7 * This,
    /* [retval][out] */ BSTR *pSlpBitmapRotationList);


void __RPC_STUB IOPOSPOSPrinter_1_7_get_SlpBitmapRotationList_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_7_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_8_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_8_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_8 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_8;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB93151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_8 : public IOPOSPOSPrinter_1_7
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

    typedef struct IOPOSPOSPrinter_1_8Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_8 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_8 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_8 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter_1_8 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_8Vtbl;

    interface IOPOSPOSPrinter_1_8
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_8Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_8_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_8_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_8_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_8_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_8_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_8_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_8_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_8_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_8_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_8_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_8_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_8_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_8_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_8_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_8_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_8_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_8_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_8_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_8_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_8_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_8_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_8_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_8_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_8_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_8_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_8_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_8_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_8_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_8_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_8_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_8_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_8_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_8_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_8_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_8_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_8_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_8_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_8_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_8_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_8_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_8_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_8_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_8_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_8_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_8_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_8_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_8_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_8_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_8_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_8_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_8_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_8_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_8_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_8_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_8_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_8_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_8_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_8_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_8_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_8_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_8_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_8_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_8_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_8_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_8_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_8_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_8_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_8_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_8_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_8_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_8_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_8_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_8_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_8_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_8_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_8_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_8_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_8_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_8_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_8_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_8_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_8_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_8_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_8_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_8_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_8_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_8_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_8_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_8_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_8_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_8_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_8_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_8_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_8_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_8_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_8_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_8_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_8_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_8_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_8_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_8_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_8_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_8_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_8_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_8_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_8_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_8_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_8_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_8_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_8_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_8_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_8_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_8_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_8_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_8_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_8_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_8_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_8_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_8_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_8_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_8_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_8_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_1_8_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_1_8_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_1_8_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_8_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_8_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);


void __RPC_STUB IOPOSPOSPrinter_1_8_get_CapStatisticsReporting_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);


void __RPC_STUB IOPOSPOSPrinter_1_8_get_CapUpdateStatistics_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_ResetStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [in] */ BSTR StatisticsBuffer,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_8_ResetStatistics_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_RetrieveStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [out][in] */ BSTR *pStatisticsBuffer,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_8_RetrieveStatistics_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_8_UpdateStatistics_Proxy( 
    IOPOSPOSPrinter_1_8 * This,
    /* [in] */ BSTR StatisticsBuffer,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_8_UpdateStatistics_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_8_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_9_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_9_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_9 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_9;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB94151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_9 : public IOPOSPOSPrinter_1_8
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
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapConcurrentPageMode( 
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecPageMode( 
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpPageMode( 
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModeArea( 
            /* [retval][out] */ BSTR *pPageModeArea) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModeDescriptor( 
            /* [retval][out] */ long *pPageModeDescriptor) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModeHorizontalPosition( 
            /* [retval][out] */ long *pPageModeHorizontalPosition) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PageModeHorizontalPosition( 
            /* [in] */ long PageModeHorizontalPosition) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModePrintArea( 
            /* [retval][out] */ BSTR *pPageModePrintArea) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PageModePrintArea( 
            /* [in] */ BSTR PageModePrintArea) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModePrintDirection( 
            /* [retval][out] */ long *pPageModePrintDirection) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PageModePrintDirection( 
            /* [in] */ long PageModePrintDirection) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModeStation( 
            /* [retval][out] */ long *pPageModeStation) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PageModeStation( 
            /* [in] */ long PageModeStation) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_PageModeVerticalPosition( 
            /* [retval][out] */ long *pPageModeVerticalPosition) = 0;
        
        virtual /* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE put_PageModeVerticalPosition( 
            /* [in] */ long PageModeVerticalPosition) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE ClearPrintArea( 
            /* [retval][out] */ long *pRC) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PageModePrint( 
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_9Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_9 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_9 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_9 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapConcurrentPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentPageMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapRecPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPageMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapSlpPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPageMode )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeArea )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pPageModeArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeDescriptor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeDescriptor )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPageModeDescriptor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeHorizontalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeHorizontalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long PageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintArea )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ BSTR *pPageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintArea)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintArea )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ BSTR PageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintDirection)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintDirection)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long PageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeStation )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeStation)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeStation )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long PageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeVerticalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pPageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeVerticalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long PageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, ClearPrintArea)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearPrintArea )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, PageModePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PageModePrint )( 
            IOPOSPOSPrinter_1_9 * This,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_9Vtbl;

    interface IOPOSPOSPrinter_1_9
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_9Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_9_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_9_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_9_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_9_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_9_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_9_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_9_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_9_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_9_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_9_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_9_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_9_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_9_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_9_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_9_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_9_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_9_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_9_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_9_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_9_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_9_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_9_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_9_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_9_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_9_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_9_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_9_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_9_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_9_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_9_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_9_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_9_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_9_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_9_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_9_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_9_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_9_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_9_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_9_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_9_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_9_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_9_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_9_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_9_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_9_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_9_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_9_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_9_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_9_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_9_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_9_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_9_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_9_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_9_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_9_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_9_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_9_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_9_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_9_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_9_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_9_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_9_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_9_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_9_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_9_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_9_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_9_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_9_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_9_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_9_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_9_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_9_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_9_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_9_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_9_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_9_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_9_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_9_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_9_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_9_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_9_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_9_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_9_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_9_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_9_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_9_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_9_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_9_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_9_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_9_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_9_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_9_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_9_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_9_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_9_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_9_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_9_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_9_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_9_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_9_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_9_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_9_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_9_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_9_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_9_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_9_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_9_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_9_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_9_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_9_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_9_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_9_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_9_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_9_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_9_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_1_9_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_1_9_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_1_9_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_9_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_9_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSPrinter_1_9_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSPrinter_1_9_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSPrinter_1_9_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#define IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode(This,pCapConcurrentPageMode)	\
    ( (This)->lpVtbl -> get_CapConcurrentPageMode(This,pCapConcurrentPageMode) ) 

#define IOPOSPOSPrinter_1_9_get_CapRecPageMode(This,pCapRecPageMode)	\
    ( (This)->lpVtbl -> get_CapRecPageMode(This,pCapRecPageMode) ) 

#define IOPOSPOSPrinter_1_9_get_CapSlpPageMode(This,pCapSlpPageMode)	\
    ( (This)->lpVtbl -> get_CapSlpPageMode(This,pCapSlpPageMode) ) 

#define IOPOSPOSPrinter_1_9_get_PageModeArea(This,pPageModeArea)	\
    ( (This)->lpVtbl -> get_PageModeArea(This,pPageModeArea) ) 

#define IOPOSPOSPrinter_1_9_get_PageModeDescriptor(This,pPageModeDescriptor)	\
    ( (This)->lpVtbl -> get_PageModeDescriptor(This,pPageModeDescriptor) ) 

#define IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition(This,PageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> put_PageModeHorizontalPosition(This,PageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_9_get_PageModePrintArea(This,pPageModePrintArea)	\
    ( (This)->lpVtbl -> get_PageModePrintArea(This,pPageModePrintArea) ) 

#define IOPOSPOSPrinter_1_9_put_PageModePrintArea(This,PageModePrintArea)	\
    ( (This)->lpVtbl -> put_PageModePrintArea(This,PageModePrintArea) ) 

#define IOPOSPOSPrinter_1_9_get_PageModePrintDirection(This,pPageModePrintDirection)	\
    ( (This)->lpVtbl -> get_PageModePrintDirection(This,pPageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_9_put_PageModePrintDirection(This,PageModePrintDirection)	\
    ( (This)->lpVtbl -> put_PageModePrintDirection(This,PageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_9_get_PageModeStation(This,pPageModeStation)	\
    ( (This)->lpVtbl -> get_PageModeStation(This,pPageModeStation) ) 

#define IOPOSPOSPrinter_1_9_put_PageModeStation(This,PageModeStation)	\
    ( (This)->lpVtbl -> put_PageModeStation(This,PageModeStation) ) 

#define IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition(This,pPageModeVerticalPosition)	\
    ( (This)->lpVtbl -> get_PageModeVerticalPosition(This,pPageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition(This,PageModeVerticalPosition)	\
    ( (This)->lpVtbl -> put_PageModeVerticalPosition(This,PageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_9_ClearPrintArea(This,pRC)	\
    ( (This)->lpVtbl -> ClearPrintArea(This,pRC) ) 

#define IOPOSPOSPrinter_1_9_PageModePrint(This,Control,pRC)	\
    ( (This)->lpVtbl -> PageModePrint(This,Control,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_CapCompareFirmwareVersion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_CapUpdateFirmware_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR FirmwareFileName,
    /* [out] */ long *pResult,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_9_CompareFirmwareVersion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_UpdateFirmware_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR FirmwareFileName,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_9_UpdateFirmware_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_CapConcurrentPageMode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapRecPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_CapRecPageMode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_CapSlpPageMode_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ BSTR *pPageModeArea);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModeArea_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeDescriptor);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModeDescriptor_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeHorizontalPosition);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModeHorizontalPosition_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeHorizontalPosition);


void __RPC_STUB IOPOSPOSPrinter_1_9_put_PageModeHorizontalPosition_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModePrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ BSTR *pPageModePrintArea);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModePrintArea_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModePrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ BSTR PageModePrintArea);


void __RPC_STUB IOPOSPOSPrinter_1_9_put_PageModePrintArea_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModePrintDirection);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModePrintDirection_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModePrintDirection);


void __RPC_STUB IOPOSPOSPrinter_1_9_put_PageModePrintDirection_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeStation_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeStation);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModeStation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeStation_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeStation);


void __RPC_STUB IOPOSPOSPrinter_1_9_put_PageModeStation_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pPageModeVerticalPosition);


void __RPC_STUB IOPOSPOSPrinter_1_9_get_PageModeVerticalPosition_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propput] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long PageModeVerticalPosition);


void __RPC_STUB IOPOSPOSPrinter_1_9_put_PageModeVerticalPosition_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_ClearPrintArea_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_9_ClearPrintArea_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_9_PageModePrint_Proxy( 
    IOPOSPOSPrinter_1_9 * This,
    /* [in] */ long Control,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_9_PageModePrint_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_9_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_10_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_10_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_10 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_10;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB95151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_10 : public IOPOSPOSPrinter_1_9
    {
    public:
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE PrintMemoryBitmap( 
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Type,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_10Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_10 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_10 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_10 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapConcurrentPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentPageMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapRecPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPageMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapSlpPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPageMode )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeArea )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pPageModeArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeDescriptor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeDescriptor )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPageModeDescriptor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeHorizontalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeHorizontalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long PageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintArea )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ BSTR *pPageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintArea)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintArea )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ BSTR PageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintDirection)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintDirection)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long PageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeStation )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeStation)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeStation )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long PageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeVerticalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pPageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeVerticalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long PageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, ClearPrintArea)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearPrintArea )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, PageModePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PageModePrint )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_10, PrintMemoryBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintMemoryBitmap )( 
            IOPOSPOSPrinter_1_10 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Type,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_10Vtbl;

    interface IOPOSPOSPrinter_1_10
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_10Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_10_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_10_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_10_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_10_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_10_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_10_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_10_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_10_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_10_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_10_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_10_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_10_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_10_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_10_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_10_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_10_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_10_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_10_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_10_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_10_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_10_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_10_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_10_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_10_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_10_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_10_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_10_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_10_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_10_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_10_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_10_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_10_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_10_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_10_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_10_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_10_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_10_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_10_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_10_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_10_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_10_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_10_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_10_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_10_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_10_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_10_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_10_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_10_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_10_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_10_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_10_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_10_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_10_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_10_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_10_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_10_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_10_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_10_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_10_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_10_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_10_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_10_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_10_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_10_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_10_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_10_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_10_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_10_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_10_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_10_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_10_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_10_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_10_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_10_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_10_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_10_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_10_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_10_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_10_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_10_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_10_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_10_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_10_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_10_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_10_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_10_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_10_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_10_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_10_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_10_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_10_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_10_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_10_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_10_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_10_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_10_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_10_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_1_10_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_1_10_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_1_10_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_10_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_10_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSPrinter_1_10_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSPrinter_1_10_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSPrinter_1_10_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSPrinter_1_10_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#define IOPOSPOSPrinter_1_10_get_CapConcurrentPageMode(This,pCapConcurrentPageMode)	\
    ( (This)->lpVtbl -> get_CapConcurrentPageMode(This,pCapConcurrentPageMode) ) 

#define IOPOSPOSPrinter_1_10_get_CapRecPageMode(This,pCapRecPageMode)	\
    ( (This)->lpVtbl -> get_CapRecPageMode(This,pCapRecPageMode) ) 

#define IOPOSPOSPrinter_1_10_get_CapSlpPageMode(This,pCapSlpPageMode)	\
    ( (This)->lpVtbl -> get_CapSlpPageMode(This,pCapSlpPageMode) ) 

#define IOPOSPOSPrinter_1_10_get_PageModeArea(This,pPageModeArea)	\
    ( (This)->lpVtbl -> get_PageModeArea(This,pPageModeArea) ) 

#define IOPOSPOSPrinter_1_10_get_PageModeDescriptor(This,pPageModeDescriptor)	\
    ( (This)->lpVtbl -> get_PageModeDescriptor(This,pPageModeDescriptor) ) 

#define IOPOSPOSPrinter_1_10_get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_10_put_PageModeHorizontalPosition(This,PageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> put_PageModeHorizontalPosition(This,PageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_10_get_PageModePrintArea(This,pPageModePrintArea)	\
    ( (This)->lpVtbl -> get_PageModePrintArea(This,pPageModePrintArea) ) 

#define IOPOSPOSPrinter_1_10_put_PageModePrintArea(This,PageModePrintArea)	\
    ( (This)->lpVtbl -> put_PageModePrintArea(This,PageModePrintArea) ) 

#define IOPOSPOSPrinter_1_10_get_PageModePrintDirection(This,pPageModePrintDirection)	\
    ( (This)->lpVtbl -> get_PageModePrintDirection(This,pPageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_10_put_PageModePrintDirection(This,PageModePrintDirection)	\
    ( (This)->lpVtbl -> put_PageModePrintDirection(This,PageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_10_get_PageModeStation(This,pPageModeStation)	\
    ( (This)->lpVtbl -> get_PageModeStation(This,pPageModeStation) ) 

#define IOPOSPOSPrinter_1_10_put_PageModeStation(This,PageModeStation)	\
    ( (This)->lpVtbl -> put_PageModeStation(This,PageModeStation) ) 

#define IOPOSPOSPrinter_1_10_get_PageModeVerticalPosition(This,pPageModeVerticalPosition)	\
    ( (This)->lpVtbl -> get_PageModeVerticalPosition(This,pPageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_10_put_PageModeVerticalPosition(This,PageModeVerticalPosition)	\
    ( (This)->lpVtbl -> put_PageModeVerticalPosition(This,PageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_10_ClearPrintArea(This,pRC)	\
    ( (This)->lpVtbl -> ClearPrintArea(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_PageModePrint(This,Control,pRC)	\
    ( (This)->lpVtbl -> PageModePrint(This,Control,pRC) ) 


#define IOPOSPOSPrinter_1_10_PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Proxy( 
    IOPOSPOSPrinter_1_10 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR Data,
    /* [in] */ long Type,
    /* [in] */ long Width,
    /* [in] */ long Alignment,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_10_PrintMemoryBitmap_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_10_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_10_zz_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_10_zz_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_10_zz */
/* [hidden][unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_10_zz;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB96151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_10_zz : public IOPOSPOSPrinter_1_10
    {
    public:
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_10_zzVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_10_zz * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_10_zz * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_10_zz * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapConcurrentPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentPageMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapRecPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPageMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapSlpPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPageMode )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeArea )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pPageModeArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeDescriptor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeDescriptor )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPageModeDescriptor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeHorizontalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeHorizontalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long PageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintArea )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ BSTR *pPageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintArea)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintArea )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ BSTR PageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintDirection)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintDirection)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long PageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeStation )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeStation)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeStation )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long PageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeVerticalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pPageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeVerticalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long PageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, ClearPrintArea)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearPrintArea )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, PageModePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PageModePrint )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_10, PrintMemoryBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintMemoryBitmap )( 
            IOPOSPOSPrinter_1_10_zz * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Type,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_10_zzVtbl;

    interface IOPOSPOSPrinter_1_10_zz
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_10_zzVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_10_zz_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_10_zz_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_10_zz_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_10_zz_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_10_zz_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_10_zz_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_10_zz_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_10_zz_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_10_zz_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_10_zz_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_10_zz_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_10_zz_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_10_zz_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_10_zz_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_10_zz_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_10_zz_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_10_zz_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_10_zz_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_10_zz_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_10_zz_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_10_zz_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_10_zz_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_10_zz_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_10_zz_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_10_zz_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_10_zz_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_10_zz_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_10_zz_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_10_zz_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_10_zz_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_10_zz_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_10_zz_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_10_zz_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_10_zz_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_10_zz_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_zz_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_10_zz_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_10_zz_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_10_zz_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_10_zz_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_1_10_zz_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_1_10_zz_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSPrinter_1_10_zz_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSPrinter_1_10_zz_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapConcurrentPageMode(This,pCapConcurrentPageMode)	\
    ( (This)->lpVtbl -> get_CapConcurrentPageMode(This,pCapConcurrentPageMode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapRecPageMode(This,pCapRecPageMode)	\
    ( (This)->lpVtbl -> get_CapRecPageMode(This,pCapRecPageMode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_CapSlpPageMode(This,pCapSlpPageMode)	\
    ( (This)->lpVtbl -> get_CapSlpPageMode(This,pCapSlpPageMode) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModeArea(This,pPageModeArea)	\
    ( (This)->lpVtbl -> get_PageModeArea(This,pPageModeArea) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModeDescriptor(This,pPageModeDescriptor)	\
    ( (This)->lpVtbl -> get_PageModeDescriptor(This,pPageModeDescriptor) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PageModeHorizontalPosition(This,PageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> put_PageModeHorizontalPosition(This,PageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModePrintArea(This,pPageModePrintArea)	\
    ( (This)->lpVtbl -> get_PageModePrintArea(This,pPageModePrintArea) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PageModePrintArea(This,PageModePrintArea)	\
    ( (This)->lpVtbl -> put_PageModePrintArea(This,PageModePrintArea) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModePrintDirection(This,pPageModePrintDirection)	\
    ( (This)->lpVtbl -> get_PageModePrintDirection(This,pPageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PageModePrintDirection(This,PageModePrintDirection)	\
    ( (This)->lpVtbl -> put_PageModePrintDirection(This,PageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModeStation(This,pPageModeStation)	\
    ( (This)->lpVtbl -> get_PageModeStation(This,pPageModeStation) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PageModeStation(This,PageModeStation)	\
    ( (This)->lpVtbl -> put_PageModeStation(This,PageModeStation) ) 

#define IOPOSPOSPrinter_1_10_zz_get_PageModeVerticalPosition(This,pPageModeVerticalPosition)	\
    ( (This)->lpVtbl -> get_PageModeVerticalPosition(This,pPageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_10_zz_put_PageModeVerticalPosition(This,PageModeVerticalPosition)	\
    ( (This)->lpVtbl -> put_PageModeVerticalPosition(This,PageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_10_zz_ClearPrintArea(This,pRC)	\
    ( (This)->lpVtbl -> ClearPrintArea(This,pRC) ) 

#define IOPOSPOSPrinter_1_10_zz_PageModePrint(This,Control,pRC)	\
    ( (This)->lpVtbl -> PageModePrint(This,Control,pRC) ) 


#define IOPOSPOSPrinter_1_10_zz_PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSPrinter_1_10_zz_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_1_13_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_1_13_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter_1_13 */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter_1_13;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB97151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter_1_13 : public IOPOSPOSPrinter_1_10
    {
    public:
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapRecRuledLine( 
            /* [retval][out] */ long *pCapRecRuledLine) = 0;
        
        virtual /* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE get_CapSlpRuledLine( 
            /* [retval][out] */ long *pCapSlpRuledLine) = 0;
        
        virtual /* [helpstring][id] */ HRESULT STDMETHODCALLTYPE DrawRuledLine( 
            /* [in] */ long Station,
            /* [in] */ BSTR PositionList,
            /* [in] */ long LineDirection,
            /* [in] */ long LineWidth,
            /* [in] */ long LineStyle,
            /* [in] */ long LineColor,
            /* [retval][out] */ long *pRC) = 0;
        
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinter_1_13Vtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter_1_13 * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter_1_13 * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter_1_13 * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapConcurrentPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentPageMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapRecPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPageMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapSlpPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPageMode )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeArea )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pPageModeArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeDescriptor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeDescriptor )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPageModeDescriptor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeHorizontalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeHorizontalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long PageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintArea )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ BSTR *pPageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintArea)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintArea )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ BSTR PageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintDirection)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintDirection)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintDirection )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long PageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeStation )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeStation)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeStation )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long PageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeVerticalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pPageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeVerticalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeVerticalPosition )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long PageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, ClearPrintArea)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearPrintArea )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, PageModePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PageModePrint )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_10, PrintMemoryBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintMemoryBitmap )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Type,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, get_CapRecRuledLine)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRuledLine )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapRecRuledLine);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, get_CapSlpRuledLine)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRuledLine )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [retval][out] */ long *pCapSlpRuledLine);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, DrawRuledLine)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DrawRuledLine )( 
            IOPOSPOSPrinter_1_13 * This,
            /* [in] */ long Station,
            /* [in] */ BSTR PositionList,
            /* [in] */ long LineDirection,
            /* [in] */ long LineWidth,
            /* [in] */ long LineStyle,
            /* [in] */ long LineColor,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinter_1_13Vtbl;

    interface IOPOSPOSPrinter_1_13
    {
        CONST_VTBL struct IOPOSPOSPrinter_1_13Vtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_1_13_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_1_13_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_1_13_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_1_13_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_1_13_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_1_13_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_1_13_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_1_13_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_1_13_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_1_13_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_1_13_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_1_13_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_1_13_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_1_13_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_1_13_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_1_13_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_1_13_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_1_13_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_1_13_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_1_13_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_1_13_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_1_13_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_1_13_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_1_13_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_1_13_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_1_13_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_1_13_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_1_13_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_1_13_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_1_13_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_1_13_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_1_13_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_13_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_1_13_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_1_13_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_1_13_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_1_13_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_1_13_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_1_13_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_1_13_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_1_13_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_1_13_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_1_13_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_1_13_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_1_13_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_1_13_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_1_13_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_13_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_1_13_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_1_13_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_1_13_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_1_13_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_1_13_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_1_13_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_1_13_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_1_13_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_1_13_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_1_13_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_1_13_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_1_13_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_1_13_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_1_13_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_1_13_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_1_13_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_13_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_13_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_1_13_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_1_13_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_1_13_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_1_13_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_1_13_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_1_13_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_1_13_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_1_13_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_13_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_1_13_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_1_13_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_1_13_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_13_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_13_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_13_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_1_13_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_1_13_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_1_13_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_1_13_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_1_13_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_1_13_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_1_13_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_1_13_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_1_13_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_13_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_1_13_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_1_13_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_1_13_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_1_13_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_1_13_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_1_13_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_1_13_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_1_13_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_1_13_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_1_13_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_1_13_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_1_13_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_1_13_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_1_13_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_1_13_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_1_13_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_1_13_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_1_13_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_1_13_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_1_13_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_13_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_1_13_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_1_13_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_1_13_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_1_13_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_1_13_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_1_13_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_13_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_1_13_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSPrinter_1_13_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSPrinter_1_13_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSPrinter_1_13_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSPrinter_1_13_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#define IOPOSPOSPrinter_1_13_get_CapConcurrentPageMode(This,pCapConcurrentPageMode)	\
    ( (This)->lpVtbl -> get_CapConcurrentPageMode(This,pCapConcurrentPageMode) ) 

#define IOPOSPOSPrinter_1_13_get_CapRecPageMode(This,pCapRecPageMode)	\
    ( (This)->lpVtbl -> get_CapRecPageMode(This,pCapRecPageMode) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpPageMode(This,pCapSlpPageMode)	\
    ( (This)->lpVtbl -> get_CapSlpPageMode(This,pCapSlpPageMode) ) 

#define IOPOSPOSPrinter_1_13_get_PageModeArea(This,pPageModeArea)	\
    ( (This)->lpVtbl -> get_PageModeArea(This,pPageModeArea) ) 

#define IOPOSPOSPrinter_1_13_get_PageModeDescriptor(This,pPageModeDescriptor)	\
    ( (This)->lpVtbl -> get_PageModeDescriptor(This,pPageModeDescriptor) ) 

#define IOPOSPOSPrinter_1_13_get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_13_put_PageModeHorizontalPosition(This,PageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> put_PageModeHorizontalPosition(This,PageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_1_13_get_PageModePrintArea(This,pPageModePrintArea)	\
    ( (This)->lpVtbl -> get_PageModePrintArea(This,pPageModePrintArea) ) 

#define IOPOSPOSPrinter_1_13_put_PageModePrintArea(This,PageModePrintArea)	\
    ( (This)->lpVtbl -> put_PageModePrintArea(This,PageModePrintArea) ) 

#define IOPOSPOSPrinter_1_13_get_PageModePrintDirection(This,pPageModePrintDirection)	\
    ( (This)->lpVtbl -> get_PageModePrintDirection(This,pPageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_13_put_PageModePrintDirection(This,PageModePrintDirection)	\
    ( (This)->lpVtbl -> put_PageModePrintDirection(This,PageModePrintDirection) ) 

#define IOPOSPOSPrinter_1_13_get_PageModeStation(This,pPageModeStation)	\
    ( (This)->lpVtbl -> get_PageModeStation(This,pPageModeStation) ) 

#define IOPOSPOSPrinter_1_13_put_PageModeStation(This,PageModeStation)	\
    ( (This)->lpVtbl -> put_PageModeStation(This,PageModeStation) ) 

#define IOPOSPOSPrinter_1_13_get_PageModeVerticalPosition(This,pPageModeVerticalPosition)	\
    ( (This)->lpVtbl -> get_PageModeVerticalPosition(This,pPageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_13_put_PageModeVerticalPosition(This,PageModeVerticalPosition)	\
    ( (This)->lpVtbl -> put_PageModeVerticalPosition(This,PageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_1_13_ClearPrintArea(This,pRC)	\
    ( (This)->lpVtbl -> ClearPrintArea(This,pRC) ) 

#define IOPOSPOSPrinter_1_13_PageModePrint(This,Control,pRC)	\
    ( (This)->lpVtbl -> PageModePrint(This,Control,pRC) ) 


#define IOPOSPOSPrinter_1_13_PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC) ) 


#define IOPOSPOSPrinter_1_13_get_CapRecRuledLine(This,pCapRecRuledLine)	\
    ( (This)->lpVtbl -> get_CapRecRuledLine(This,pCapRecRuledLine) ) 

#define IOPOSPOSPrinter_1_13_get_CapSlpRuledLine(This,pCapSlpRuledLine)	\
    ( (This)->lpVtbl -> get_CapSlpRuledLine(This,pCapSlpRuledLine) ) 

#define IOPOSPOSPrinter_1_13_DrawRuledLine(This,Station,PositionList,LineDirection,LineWidth,LineStyle,LineColor,pRC)	\
    ( (This)->lpVtbl -> DrawRuledLine(This,Station,PositionList,LineDirection,LineWidth,LineStyle,LineColor,pRC) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_get_CapRecRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [retval][out] */ long *pCapRecRuledLine);


void __RPC_STUB IOPOSPOSPrinter_1_13_get_CapRecRuledLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id][propget] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_get_CapSlpRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [retval][out] */ long *pCapSlpRuledLine);


void __RPC_STUB IOPOSPOSPrinter_1_13_get_CapSlpRuledLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [helpstring][id] */ HRESULT STDMETHODCALLTYPE IOPOSPOSPrinter_1_13_DrawRuledLine_Proxy( 
    IOPOSPOSPrinter_1_13 * This,
    /* [in] */ long Station,
    /* [in] */ BSTR PositionList,
    /* [in] */ long LineDirection,
    /* [in] */ long LineWidth,
    /* [in] */ long LineStyle,
    /* [in] */ long LineColor,
    /* [retval][out] */ long *pRC);


void __RPC_STUB IOPOSPOSPrinter_1_13_DrawRuledLine_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IOPOSPOSPrinter_1_13_INTERFACE_DEFINED__ */


#ifndef __IOPOSPOSPrinter_INTERFACE_DEFINED__
#define __IOPOSPOSPrinter_INTERFACE_DEFINED__

/* interface IOPOSPOSPrinter */
/* [unique][helpstring][dual][uuid][object] */ 


EXTERN_C const IID IID_IOPOSPOSPrinter;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("CCB98151-B81E-11D2-AB74-0040054C3719")
    IOPOSPOSPrinter : public IOPOSPOSPrinter_1_13
    {
    public:
    };
    
    
#else 	/* C style interface */

    typedef struct IOPOSPOSPrinterVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IOPOSPOSPrinter * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IOPOSPOSPrinter * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IOPOSPOSPrinter * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IOPOSPOSPrinter * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IOPOSPOSPrinter * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IOPOSPOSPrinter * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IOPOSPOSPrinter * This,
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
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODataDummy)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODataDummy )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Status);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SODirectIO)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SODirectIO )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long EventNumber,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOError)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOError )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long ResultCode,
            /* [in] */ long ResultCodeExtended,
            /* [in] */ long ErrorLocus,
            /* [out][in] */ long *pErrorResponse);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOOutputComplete)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOOutputComplete )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long OutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOStatusUpdate)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOStatusUpdate )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Data);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SOProcessID)
        /* [helpstring][hidden][id] */ HRESULT ( STDMETHODCALLTYPE *SOProcessID )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pProcessID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OpenResult)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OpenResult )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pOpenResult);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CheckHealthText)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CheckHealthText )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pCheckHealthText);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_Claimed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_Claimed )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pClaimed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceEnabled)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceEnabled )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pDeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_DeviceEnabled)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DeviceEnabled )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL DeviceEnabled);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FreezeEvents)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FreezeEvents )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pFreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FreezeEvents)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FreezeEvents )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL FreezeEvents);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_OutputID)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_OutputID )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pOutputID);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pResultCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ResultCodeExtended)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ResultCodeExtended )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pResultCodeExtended);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_State)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_State )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectDescription )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pControlObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ControlObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ControlObjectVersion )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pControlObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectDescription )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pServiceObjectDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ServiceObjectVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ServiceObjectVersion )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pServiceObjectVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceDescription)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceDescription )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pDeviceDescription);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_DeviceName)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_DeviceName )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pDeviceName);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CheckHealth)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CheckHealth )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Level,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClaimDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClaimDevice )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ClearOutput)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearOutput )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Close)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Close )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, DirectIO)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DirectIO )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Command,
            /* [out][in] */ long *pData,
            /* [out][in] */ BSTR *pString,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, Open)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *Open )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR DeviceName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ReleaseDevice)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ReleaseDevice )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_AsyncMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_AsyncMode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pAsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_AsyncMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AsyncMode )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL AsyncMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnRec)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnRec )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnRec);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentJrnSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentJrnSlp )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentJrnSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapConcurrentRecSlp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentRecSlp )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentRecSlp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCoverSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCoverSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCoverSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrn2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrn2Color )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrn2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnBold )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwide )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnDwideDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnEmptySensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnItalic )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnNearEndSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnPresent )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnUnderline )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapJrnUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRec2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRec2Color )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRec2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBarCode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBitmap )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecBold )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwide )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecDwideDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecEmptySensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecItalic )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecLeft90 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecNearEndSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPapercut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPapercut )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPapercut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPresent )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRight90 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRotate180 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecStamp)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecStamp )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecStamp);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecUnderline )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlp2Color)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlp2Color )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlp2Color);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBarCode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBarCode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBarCode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBitmap)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBitmap )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBitmap);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBold)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBold )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBold);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwide )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpDwideDhigh)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpDwideDhigh )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpDwideDhigh);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpEmptySensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpEmptySensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpEmptySensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpFullslip)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpFullslip )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpFullslip);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpItalic)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpItalic )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpItalic);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpLeft90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpLeft90 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpLeft90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpNearEndSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpNearEndSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpNearEndSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpPresent)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPresent )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPresent);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRight90)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRight90 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRight90);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpRotate180)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRotate180 )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpRotate180);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpUnderline)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpUnderline )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpUnderline);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long CharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CharacterSetList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CharacterSetList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pCharacterSetList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CoverOpen)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CoverOpen )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCoverOpen);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorStation )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pErrorStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FlagWhenIdle)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FlagWhenIdle )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pFlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_FlagWhenIdle)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FlagWhenIdle )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL FlagWhenIdle);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnEmpty )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL JrnLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineChars )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineChars )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long JrnLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineCharsList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pJrnLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long JrnLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long JrnLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnLineWidth )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnNearEnd )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pJrnNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_MapMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapMode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pMapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_MapMode)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapMode )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long MapMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecEmpty )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pRecEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pRecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL RecLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineChars )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineChars )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long RecLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineCharsList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pRecLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long RecLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long RecLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLinesToPaperCut)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLinesToPaperCut )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecLinesToPaperCut);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecLineWidth )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecNearEnd )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pRecNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxChars )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecSidewaysMaxLines )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpEmpty)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpEmpty )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpEmpty);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLetterQuality)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLetterQuality)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLetterQuality )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL SlpLetterQuality);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineChars )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineChars)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineChars )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long SlpLineChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineCharsList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineCharsList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pSlpLineCharsList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineHeight)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineHeight)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineHeight )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long SlpLineHeight);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLinesNearEndToEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLinesNearEndToEnd )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpLinesNearEndToEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineSpacing)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpLineSpacing)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpLineSpacing )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long SlpLineSpacing);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpLineWidth)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpLineWidth )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpLineWidth);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpMaxLines )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpNearEnd)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpNearEnd )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pSlpNearEnd);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxChars)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxChars )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpSidewaysMaxChars);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpSidewaysMaxLines)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpSidewaysMaxLines )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpSidewaysMaxLines);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginInsertion )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, BeginRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *BeginRemoval )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Timeout,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, CutPaper)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CutPaper )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Percentage,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndInsertion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndInsertion )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, EndRemoval)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *EndRemoval )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBarCode)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBarCode )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Symbology,
            /* [in] */ long Height,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [in] */ long TextPosition,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintBitmap )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintImmediate)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintImmediate )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintNormal )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, PrintTwoNormal)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintTwoNormal )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Stations,
            /* [in] */ BSTR Data1,
            /* [in] */ BSTR Data2,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, RotatePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RotatePrint )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ long Rotation,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetBitmap )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long BitmapNumber,
            /* [in] */ long Station,
            /* [in] */ BSTR FileName,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, SetLogo)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *SetLogo )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Location,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapTransaction)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapTransaction )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapTransaction);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorLevel)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorLevel )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pErrorLevel);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_ErrorString)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_ErrorString )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pErrorString);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_FontTypefaceList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_FontTypefaceList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pFontTypefaceList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBarCodeRotationList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pRecBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RotateSpecial)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RotateSpecial )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RotateSpecial)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RotateSpecial )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long RotateSpecial);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpBarCodeRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBarCodeRotationList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pSlpBarCodeRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, TransactionPrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *TransactionPrint )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ValidateData)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ValidateData )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_BinaryConversion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_BinaryConversion )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pBinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_BinaryConversion)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BinaryConversion )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long BinaryConversion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapPowerReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapPowerReporting )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapPowerReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerNotify )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_PowerNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PowerNotify )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long PowerNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_PowerState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PowerState )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPowerState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnCartridgeSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapJrnCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapJrnColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapJrnColor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapJrnColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecCartridgeSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapRecCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecColor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapRecColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapRecMarkFeed)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecMarkFeed )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapRecMarkFeed);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpBothSidesPrint)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpBothSidesPrint )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpBothSidesPrint);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpCartridgeSensor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpCartridgeSensor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapSlpCartridgeSensor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CapSlpColor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpColor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapSlpColor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_CartridgeNotify)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CartridgeNotify )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_CartridgeNotify)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CartridgeNotify )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long CartridgeNotify);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCartridgeState )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_JrnCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_JrnCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pJrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_JrnCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_JrnCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long JrnCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCartridgeState )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_RecCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_RecCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_RecCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long RecCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCartridgeState)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCartridgeState )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpCartridgeState);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpCurrentCartridge)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, put_SlpCurrentCartridge)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SlpCurrentCartridge )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long SlpCurrentCartridge);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, get_SlpPrintSide)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpPrintSide )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pSlpPrintSide);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, ChangePrintSide)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ChangePrintSide )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Side,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_5, MarkFeed)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *MarkFeed )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Type,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_CapMapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapMapCharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_MapCharacterSet)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_MapCharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pMapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, put_MapCharacterSet)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_MapCharacterSet )( 
            IOPOSPOSPrinter * This,
            /* [in] */ VARIANT_BOOL MapCharacterSet);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_RecBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_RecBitmapRotationList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pRecBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_7, get_SlpBitmapRotationList)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_SlpBitmapRotationList )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pSlpBitmapRotationList);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapStatisticsReporting)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapStatisticsReporting )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapStatisticsReporting);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, get_CapUpdateStatistics)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateStatistics )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateStatistics);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, ResetStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ResetStatistics )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, RetrieveStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *RetrieveStatistics )( 
            IOPOSPOSPrinter * This,
            /* [out][in] */ BSTR *pStatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_8, UpdateStatistics)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateStatistics )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR StatisticsBuffer,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapCompareFirmwareVersion)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapCompareFirmwareVersion )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapCompareFirmwareVersion);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapUpdateFirmware)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapUpdateFirmware )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapUpdateFirmware);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, CompareFirmwareVersion)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *CompareFirmwareVersion )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [out] */ long *pResult,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, UpdateFirmware)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *UpdateFirmware )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR FirmwareFileName,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapConcurrentPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapConcurrentPageMode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapConcurrentPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapRecPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecPageMode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapRecPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_CapSlpPageMode)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpPageMode )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ VARIANT_BOOL *pCapSlpPageMode);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeArea )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pPageModeArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeDescriptor)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeDescriptor )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPageModeDescriptor);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeHorizontalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeHorizontalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeHorizontalPosition )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long PageModeHorizontalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintArea)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintArea )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ BSTR *pPageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintArea)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintArea )( 
            IOPOSPOSPrinter * This,
            /* [in] */ BSTR PageModePrintArea);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModePrintDirection)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModePrintDirection )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModePrintDirection)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModePrintDirection )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long PageModePrintDirection);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeStation)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeStation )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeStation)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeStation )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long PageModeStation);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, get_PageModeVerticalPosition)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_PageModeVerticalPosition )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pPageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, put_PageModeVerticalPosition)
        /* [helpstring][id][propput] */ HRESULT ( STDMETHODCALLTYPE *put_PageModeVerticalPosition )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long PageModeVerticalPosition);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, ClearPrintArea)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *ClearPrintArea )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_9, PageModePrint)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PageModePrint )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Control,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_10, PrintMemoryBitmap)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *PrintMemoryBitmap )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR Data,
            /* [in] */ long Type,
            /* [in] */ long Width,
            /* [in] */ long Alignment,
            /* [retval][out] */ long *pRC);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, get_CapRecRuledLine)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapRecRuledLine )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapRecRuledLine);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, get_CapSlpRuledLine)
        /* [helpstring][id][propget] */ HRESULT ( STDMETHODCALLTYPE *get_CapSlpRuledLine )( 
            IOPOSPOSPrinter * This,
            /* [retval][out] */ long *pCapSlpRuledLine);
        
        DECLSPEC_XFGVIRT(IOPOSPOSPrinter_1_13, DrawRuledLine)
        /* [helpstring][id] */ HRESULT ( STDMETHODCALLTYPE *DrawRuledLine )( 
            IOPOSPOSPrinter * This,
            /* [in] */ long Station,
            /* [in] */ BSTR PositionList,
            /* [in] */ long LineDirection,
            /* [in] */ long LineWidth,
            /* [in] */ long LineStyle,
            /* [in] */ long LineColor,
            /* [retval][out] */ long *pRC);
        
        END_INTERFACE
    } IOPOSPOSPrinterVtbl;

    interface IOPOSPOSPrinter
    {
        CONST_VTBL struct IOPOSPOSPrinterVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IOPOSPOSPrinter_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IOPOSPOSPrinter_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IOPOSPOSPrinter_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IOPOSPOSPrinter_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IOPOSPOSPrinter_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IOPOSPOSPrinter_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IOPOSPOSPrinter_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IOPOSPOSPrinter_SODataDummy(This,Status)	\
    ( (This)->lpVtbl -> SODataDummy(This,Status) ) 

#define IOPOSPOSPrinter_SODirectIO(This,EventNumber,pData,pString)	\
    ( (This)->lpVtbl -> SODirectIO(This,EventNumber,pData,pString) ) 

#define IOPOSPOSPrinter_SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse)	\
    ( (This)->lpVtbl -> SOError(This,ResultCode,ResultCodeExtended,ErrorLocus,pErrorResponse) ) 

#define IOPOSPOSPrinter_SOOutputComplete(This,OutputID)	\
    ( (This)->lpVtbl -> SOOutputComplete(This,OutputID) ) 

#define IOPOSPOSPrinter_SOStatusUpdate(This,Data)	\
    ( (This)->lpVtbl -> SOStatusUpdate(This,Data) ) 

#define IOPOSPOSPrinter_SOProcessID(This,pProcessID)	\
    ( (This)->lpVtbl -> SOProcessID(This,pProcessID) ) 

#define IOPOSPOSPrinter_get_OpenResult(This,pOpenResult)	\
    ( (This)->lpVtbl -> get_OpenResult(This,pOpenResult) ) 

#define IOPOSPOSPrinter_get_CheckHealthText(This,pCheckHealthText)	\
    ( (This)->lpVtbl -> get_CheckHealthText(This,pCheckHealthText) ) 

#define IOPOSPOSPrinter_get_Claimed(This,pClaimed)	\
    ( (This)->lpVtbl -> get_Claimed(This,pClaimed) ) 

#define IOPOSPOSPrinter_get_DeviceEnabled(This,pDeviceEnabled)	\
    ( (This)->lpVtbl -> get_DeviceEnabled(This,pDeviceEnabled) ) 

#define IOPOSPOSPrinter_put_DeviceEnabled(This,DeviceEnabled)	\
    ( (This)->lpVtbl -> put_DeviceEnabled(This,DeviceEnabled) ) 

#define IOPOSPOSPrinter_get_FreezeEvents(This,pFreezeEvents)	\
    ( (This)->lpVtbl -> get_FreezeEvents(This,pFreezeEvents) ) 

#define IOPOSPOSPrinter_put_FreezeEvents(This,FreezeEvents)	\
    ( (This)->lpVtbl -> put_FreezeEvents(This,FreezeEvents) ) 

#define IOPOSPOSPrinter_get_OutputID(This,pOutputID)	\
    ( (This)->lpVtbl -> get_OutputID(This,pOutputID) ) 

#define IOPOSPOSPrinter_get_ResultCode(This,pResultCode)	\
    ( (This)->lpVtbl -> get_ResultCode(This,pResultCode) ) 

#define IOPOSPOSPrinter_get_ResultCodeExtended(This,pResultCodeExtended)	\
    ( (This)->lpVtbl -> get_ResultCodeExtended(This,pResultCodeExtended) ) 

#define IOPOSPOSPrinter_get_State(This,pState)	\
    ( (This)->lpVtbl -> get_State(This,pState) ) 

#define IOPOSPOSPrinter_get_ControlObjectDescription(This,pControlObjectDescription)	\
    ( (This)->lpVtbl -> get_ControlObjectDescription(This,pControlObjectDescription) ) 

#define IOPOSPOSPrinter_get_ControlObjectVersion(This,pControlObjectVersion)	\
    ( (This)->lpVtbl -> get_ControlObjectVersion(This,pControlObjectVersion) ) 

#define IOPOSPOSPrinter_get_ServiceObjectDescription(This,pServiceObjectDescription)	\
    ( (This)->lpVtbl -> get_ServiceObjectDescription(This,pServiceObjectDescription) ) 

#define IOPOSPOSPrinter_get_ServiceObjectVersion(This,pServiceObjectVersion)	\
    ( (This)->lpVtbl -> get_ServiceObjectVersion(This,pServiceObjectVersion) ) 

#define IOPOSPOSPrinter_get_DeviceDescription(This,pDeviceDescription)	\
    ( (This)->lpVtbl -> get_DeviceDescription(This,pDeviceDescription) ) 

#define IOPOSPOSPrinter_get_DeviceName(This,pDeviceName)	\
    ( (This)->lpVtbl -> get_DeviceName(This,pDeviceName) ) 

#define IOPOSPOSPrinter_CheckHealth(This,Level,pRC)	\
    ( (This)->lpVtbl -> CheckHealth(This,Level,pRC) ) 

#define IOPOSPOSPrinter_ClaimDevice(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> ClaimDevice(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_ClearOutput(This,pRC)	\
    ( (This)->lpVtbl -> ClearOutput(This,pRC) ) 

#define IOPOSPOSPrinter_Close(This,pRC)	\
    ( (This)->lpVtbl -> Close(This,pRC) ) 

#define IOPOSPOSPrinter_DirectIO(This,Command,pData,pString,pRC)	\
    ( (This)->lpVtbl -> DirectIO(This,Command,pData,pString,pRC) ) 

#define IOPOSPOSPrinter_Open(This,DeviceName,pRC)	\
    ( (This)->lpVtbl -> Open(This,DeviceName,pRC) ) 

#define IOPOSPOSPrinter_ReleaseDevice(This,pRC)	\
    ( (This)->lpVtbl -> ReleaseDevice(This,pRC) ) 

#define IOPOSPOSPrinter_get_AsyncMode(This,pAsyncMode)	\
    ( (This)->lpVtbl -> get_AsyncMode(This,pAsyncMode) ) 

#define IOPOSPOSPrinter_put_AsyncMode(This,AsyncMode)	\
    ( (This)->lpVtbl -> put_AsyncMode(This,AsyncMode) ) 

#define IOPOSPOSPrinter_get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnRec(This,pCapConcurrentJrnRec) ) 

#define IOPOSPOSPrinter_get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentJrnSlp(This,pCapConcurrentJrnSlp) ) 

#define IOPOSPOSPrinter_get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp)	\
    ( (This)->lpVtbl -> get_CapConcurrentRecSlp(This,pCapConcurrentRecSlp) ) 

#define IOPOSPOSPrinter_get_CapCoverSensor(This,pCapCoverSensor)	\
    ( (This)->lpVtbl -> get_CapCoverSensor(This,pCapCoverSensor) ) 

#define IOPOSPOSPrinter_get_CapJrn2Color(This,pCapJrn2Color)	\
    ( (This)->lpVtbl -> get_CapJrn2Color(This,pCapJrn2Color) ) 

#define IOPOSPOSPrinter_get_CapJrnBold(This,pCapJrnBold)	\
    ( (This)->lpVtbl -> get_CapJrnBold(This,pCapJrnBold) ) 

#define IOPOSPOSPrinter_get_CapJrnDhigh(This,pCapJrnDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDhigh(This,pCapJrnDhigh) ) 

#define IOPOSPOSPrinter_get_CapJrnDwide(This,pCapJrnDwide)	\
    ( (This)->lpVtbl -> get_CapJrnDwide(This,pCapJrnDwide) ) 

#define IOPOSPOSPrinter_get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapJrnDwideDhigh(This,pCapJrnDwideDhigh) ) 

#define IOPOSPOSPrinter_get_CapJrnEmptySensor(This,pCapJrnEmptySensor)	\
    ( (This)->lpVtbl -> get_CapJrnEmptySensor(This,pCapJrnEmptySensor) ) 

#define IOPOSPOSPrinter_get_CapJrnItalic(This,pCapJrnItalic)	\
    ( (This)->lpVtbl -> get_CapJrnItalic(This,pCapJrnItalic) ) 

#define IOPOSPOSPrinter_get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapJrnNearEndSensor(This,pCapJrnNearEndSensor) ) 

#define IOPOSPOSPrinter_get_CapJrnPresent(This,pCapJrnPresent)	\
    ( (This)->lpVtbl -> get_CapJrnPresent(This,pCapJrnPresent) ) 

#define IOPOSPOSPrinter_get_CapJrnUnderline(This,pCapJrnUnderline)	\
    ( (This)->lpVtbl -> get_CapJrnUnderline(This,pCapJrnUnderline) ) 

#define IOPOSPOSPrinter_get_CapRec2Color(This,pCapRec2Color)	\
    ( (This)->lpVtbl -> get_CapRec2Color(This,pCapRec2Color) ) 

#define IOPOSPOSPrinter_get_CapRecBarCode(This,pCapRecBarCode)	\
    ( (This)->lpVtbl -> get_CapRecBarCode(This,pCapRecBarCode) ) 

#define IOPOSPOSPrinter_get_CapRecBitmap(This,pCapRecBitmap)	\
    ( (This)->lpVtbl -> get_CapRecBitmap(This,pCapRecBitmap) ) 

#define IOPOSPOSPrinter_get_CapRecBold(This,pCapRecBold)	\
    ( (This)->lpVtbl -> get_CapRecBold(This,pCapRecBold) ) 

#define IOPOSPOSPrinter_get_CapRecDhigh(This,pCapRecDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDhigh(This,pCapRecDhigh) ) 

#define IOPOSPOSPrinter_get_CapRecDwide(This,pCapRecDwide)	\
    ( (This)->lpVtbl -> get_CapRecDwide(This,pCapRecDwide) ) 

#define IOPOSPOSPrinter_get_CapRecDwideDhigh(This,pCapRecDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapRecDwideDhigh(This,pCapRecDwideDhigh) ) 

#define IOPOSPOSPrinter_get_CapRecEmptySensor(This,pCapRecEmptySensor)	\
    ( (This)->lpVtbl -> get_CapRecEmptySensor(This,pCapRecEmptySensor) ) 

#define IOPOSPOSPrinter_get_CapRecItalic(This,pCapRecItalic)	\
    ( (This)->lpVtbl -> get_CapRecItalic(This,pCapRecItalic) ) 

#define IOPOSPOSPrinter_get_CapRecLeft90(This,pCapRecLeft90)	\
    ( (This)->lpVtbl -> get_CapRecLeft90(This,pCapRecLeft90) ) 

#define IOPOSPOSPrinter_get_CapRecNearEndSensor(This,pCapRecNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapRecNearEndSensor(This,pCapRecNearEndSensor) ) 

#define IOPOSPOSPrinter_get_CapRecPapercut(This,pCapRecPapercut)	\
    ( (This)->lpVtbl -> get_CapRecPapercut(This,pCapRecPapercut) ) 

#define IOPOSPOSPrinter_get_CapRecPresent(This,pCapRecPresent)	\
    ( (This)->lpVtbl -> get_CapRecPresent(This,pCapRecPresent) ) 

#define IOPOSPOSPrinter_get_CapRecRight90(This,pCapRecRight90)	\
    ( (This)->lpVtbl -> get_CapRecRight90(This,pCapRecRight90) ) 

#define IOPOSPOSPrinter_get_CapRecRotate180(This,pCapRecRotate180)	\
    ( (This)->lpVtbl -> get_CapRecRotate180(This,pCapRecRotate180) ) 

#define IOPOSPOSPrinter_get_CapRecStamp(This,pCapRecStamp)	\
    ( (This)->lpVtbl -> get_CapRecStamp(This,pCapRecStamp) ) 

#define IOPOSPOSPrinter_get_CapRecUnderline(This,pCapRecUnderline)	\
    ( (This)->lpVtbl -> get_CapRecUnderline(This,pCapRecUnderline) ) 

#define IOPOSPOSPrinter_get_CapSlp2Color(This,pCapSlp2Color)	\
    ( (This)->lpVtbl -> get_CapSlp2Color(This,pCapSlp2Color) ) 

#define IOPOSPOSPrinter_get_CapSlpBarCode(This,pCapSlpBarCode)	\
    ( (This)->lpVtbl -> get_CapSlpBarCode(This,pCapSlpBarCode) ) 

#define IOPOSPOSPrinter_get_CapSlpBitmap(This,pCapSlpBitmap)	\
    ( (This)->lpVtbl -> get_CapSlpBitmap(This,pCapSlpBitmap) ) 

#define IOPOSPOSPrinter_get_CapSlpBold(This,pCapSlpBold)	\
    ( (This)->lpVtbl -> get_CapSlpBold(This,pCapSlpBold) ) 

#define IOPOSPOSPrinter_get_CapSlpDhigh(This,pCapSlpDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDhigh(This,pCapSlpDhigh) ) 

#define IOPOSPOSPrinter_get_CapSlpDwide(This,pCapSlpDwide)	\
    ( (This)->lpVtbl -> get_CapSlpDwide(This,pCapSlpDwide) ) 

#define IOPOSPOSPrinter_get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh)	\
    ( (This)->lpVtbl -> get_CapSlpDwideDhigh(This,pCapSlpDwideDhigh) ) 

#define IOPOSPOSPrinter_get_CapSlpEmptySensor(This,pCapSlpEmptySensor)	\
    ( (This)->lpVtbl -> get_CapSlpEmptySensor(This,pCapSlpEmptySensor) ) 

#define IOPOSPOSPrinter_get_CapSlpFullslip(This,pCapSlpFullslip)	\
    ( (This)->lpVtbl -> get_CapSlpFullslip(This,pCapSlpFullslip) ) 

#define IOPOSPOSPrinter_get_CapSlpItalic(This,pCapSlpItalic)	\
    ( (This)->lpVtbl -> get_CapSlpItalic(This,pCapSlpItalic) ) 

#define IOPOSPOSPrinter_get_CapSlpLeft90(This,pCapSlpLeft90)	\
    ( (This)->lpVtbl -> get_CapSlpLeft90(This,pCapSlpLeft90) ) 

#define IOPOSPOSPrinter_get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor)	\
    ( (This)->lpVtbl -> get_CapSlpNearEndSensor(This,pCapSlpNearEndSensor) ) 

#define IOPOSPOSPrinter_get_CapSlpPresent(This,pCapSlpPresent)	\
    ( (This)->lpVtbl -> get_CapSlpPresent(This,pCapSlpPresent) ) 

#define IOPOSPOSPrinter_get_CapSlpRight90(This,pCapSlpRight90)	\
    ( (This)->lpVtbl -> get_CapSlpRight90(This,pCapSlpRight90) ) 

#define IOPOSPOSPrinter_get_CapSlpRotate180(This,pCapSlpRotate180)	\
    ( (This)->lpVtbl -> get_CapSlpRotate180(This,pCapSlpRotate180) ) 

#define IOPOSPOSPrinter_get_CapSlpUnderline(This,pCapSlpUnderline)	\
    ( (This)->lpVtbl -> get_CapSlpUnderline(This,pCapSlpUnderline) ) 

#define IOPOSPOSPrinter_get_CharacterSet(This,pCharacterSet)	\
    ( (This)->lpVtbl -> get_CharacterSet(This,pCharacterSet) ) 

#define IOPOSPOSPrinter_put_CharacterSet(This,CharacterSet)	\
    ( (This)->lpVtbl -> put_CharacterSet(This,CharacterSet) ) 

#define IOPOSPOSPrinter_get_CharacterSetList(This,pCharacterSetList)	\
    ( (This)->lpVtbl -> get_CharacterSetList(This,pCharacterSetList) ) 

#define IOPOSPOSPrinter_get_CoverOpen(This,pCoverOpen)	\
    ( (This)->lpVtbl -> get_CoverOpen(This,pCoverOpen) ) 

#define IOPOSPOSPrinter_get_ErrorStation(This,pErrorStation)	\
    ( (This)->lpVtbl -> get_ErrorStation(This,pErrorStation) ) 

#define IOPOSPOSPrinter_get_FlagWhenIdle(This,pFlagWhenIdle)	\
    ( (This)->lpVtbl -> get_FlagWhenIdle(This,pFlagWhenIdle) ) 

#define IOPOSPOSPrinter_put_FlagWhenIdle(This,FlagWhenIdle)	\
    ( (This)->lpVtbl -> put_FlagWhenIdle(This,FlagWhenIdle) ) 

#define IOPOSPOSPrinter_get_JrnEmpty(This,pJrnEmpty)	\
    ( (This)->lpVtbl -> get_JrnEmpty(This,pJrnEmpty) ) 

#define IOPOSPOSPrinter_get_JrnLetterQuality(This,pJrnLetterQuality)	\
    ( (This)->lpVtbl -> get_JrnLetterQuality(This,pJrnLetterQuality) ) 

#define IOPOSPOSPrinter_put_JrnLetterQuality(This,JrnLetterQuality)	\
    ( (This)->lpVtbl -> put_JrnLetterQuality(This,JrnLetterQuality) ) 

#define IOPOSPOSPrinter_get_JrnLineChars(This,pJrnLineChars)	\
    ( (This)->lpVtbl -> get_JrnLineChars(This,pJrnLineChars) ) 

#define IOPOSPOSPrinter_put_JrnLineChars(This,JrnLineChars)	\
    ( (This)->lpVtbl -> put_JrnLineChars(This,JrnLineChars) ) 

#define IOPOSPOSPrinter_get_JrnLineCharsList(This,pJrnLineCharsList)	\
    ( (This)->lpVtbl -> get_JrnLineCharsList(This,pJrnLineCharsList) ) 

#define IOPOSPOSPrinter_get_JrnLineHeight(This,pJrnLineHeight)	\
    ( (This)->lpVtbl -> get_JrnLineHeight(This,pJrnLineHeight) ) 

#define IOPOSPOSPrinter_put_JrnLineHeight(This,JrnLineHeight)	\
    ( (This)->lpVtbl -> put_JrnLineHeight(This,JrnLineHeight) ) 

#define IOPOSPOSPrinter_get_JrnLineSpacing(This,pJrnLineSpacing)	\
    ( (This)->lpVtbl -> get_JrnLineSpacing(This,pJrnLineSpacing) ) 

#define IOPOSPOSPrinter_put_JrnLineSpacing(This,JrnLineSpacing)	\
    ( (This)->lpVtbl -> put_JrnLineSpacing(This,JrnLineSpacing) ) 

#define IOPOSPOSPrinter_get_JrnLineWidth(This,pJrnLineWidth)	\
    ( (This)->lpVtbl -> get_JrnLineWidth(This,pJrnLineWidth) ) 

#define IOPOSPOSPrinter_get_JrnNearEnd(This,pJrnNearEnd)	\
    ( (This)->lpVtbl -> get_JrnNearEnd(This,pJrnNearEnd) ) 

#define IOPOSPOSPrinter_get_MapMode(This,pMapMode)	\
    ( (This)->lpVtbl -> get_MapMode(This,pMapMode) ) 

#define IOPOSPOSPrinter_put_MapMode(This,MapMode)	\
    ( (This)->lpVtbl -> put_MapMode(This,MapMode) ) 

#define IOPOSPOSPrinter_get_RecEmpty(This,pRecEmpty)	\
    ( (This)->lpVtbl -> get_RecEmpty(This,pRecEmpty) ) 

#define IOPOSPOSPrinter_get_RecLetterQuality(This,pRecLetterQuality)	\
    ( (This)->lpVtbl -> get_RecLetterQuality(This,pRecLetterQuality) ) 

#define IOPOSPOSPrinter_put_RecLetterQuality(This,RecLetterQuality)	\
    ( (This)->lpVtbl -> put_RecLetterQuality(This,RecLetterQuality) ) 

#define IOPOSPOSPrinter_get_RecLineChars(This,pRecLineChars)	\
    ( (This)->lpVtbl -> get_RecLineChars(This,pRecLineChars) ) 

#define IOPOSPOSPrinter_put_RecLineChars(This,RecLineChars)	\
    ( (This)->lpVtbl -> put_RecLineChars(This,RecLineChars) ) 

#define IOPOSPOSPrinter_get_RecLineCharsList(This,pRecLineCharsList)	\
    ( (This)->lpVtbl -> get_RecLineCharsList(This,pRecLineCharsList) ) 

#define IOPOSPOSPrinter_get_RecLineHeight(This,pRecLineHeight)	\
    ( (This)->lpVtbl -> get_RecLineHeight(This,pRecLineHeight) ) 

#define IOPOSPOSPrinter_put_RecLineHeight(This,RecLineHeight)	\
    ( (This)->lpVtbl -> put_RecLineHeight(This,RecLineHeight) ) 

#define IOPOSPOSPrinter_get_RecLineSpacing(This,pRecLineSpacing)	\
    ( (This)->lpVtbl -> get_RecLineSpacing(This,pRecLineSpacing) ) 

#define IOPOSPOSPrinter_put_RecLineSpacing(This,RecLineSpacing)	\
    ( (This)->lpVtbl -> put_RecLineSpacing(This,RecLineSpacing) ) 

#define IOPOSPOSPrinter_get_RecLinesToPaperCut(This,pRecLinesToPaperCut)	\
    ( (This)->lpVtbl -> get_RecLinesToPaperCut(This,pRecLinesToPaperCut) ) 

#define IOPOSPOSPrinter_get_RecLineWidth(This,pRecLineWidth)	\
    ( (This)->lpVtbl -> get_RecLineWidth(This,pRecLineWidth) ) 

#define IOPOSPOSPrinter_get_RecNearEnd(This,pRecNearEnd)	\
    ( (This)->lpVtbl -> get_RecNearEnd(This,pRecNearEnd) ) 

#define IOPOSPOSPrinter_get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxChars(This,pRecSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_RecSidewaysMaxLines(This,pRecSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_get_SlpEmpty(This,pSlpEmpty)	\
    ( (This)->lpVtbl -> get_SlpEmpty(This,pSlpEmpty) ) 

#define IOPOSPOSPrinter_get_SlpLetterQuality(This,pSlpLetterQuality)	\
    ( (This)->lpVtbl -> get_SlpLetterQuality(This,pSlpLetterQuality) ) 

#define IOPOSPOSPrinter_put_SlpLetterQuality(This,SlpLetterQuality)	\
    ( (This)->lpVtbl -> put_SlpLetterQuality(This,SlpLetterQuality) ) 

#define IOPOSPOSPrinter_get_SlpLineChars(This,pSlpLineChars)	\
    ( (This)->lpVtbl -> get_SlpLineChars(This,pSlpLineChars) ) 

#define IOPOSPOSPrinter_put_SlpLineChars(This,SlpLineChars)	\
    ( (This)->lpVtbl -> put_SlpLineChars(This,SlpLineChars) ) 

#define IOPOSPOSPrinter_get_SlpLineCharsList(This,pSlpLineCharsList)	\
    ( (This)->lpVtbl -> get_SlpLineCharsList(This,pSlpLineCharsList) ) 

#define IOPOSPOSPrinter_get_SlpLineHeight(This,pSlpLineHeight)	\
    ( (This)->lpVtbl -> get_SlpLineHeight(This,pSlpLineHeight) ) 

#define IOPOSPOSPrinter_put_SlpLineHeight(This,SlpLineHeight)	\
    ( (This)->lpVtbl -> put_SlpLineHeight(This,SlpLineHeight) ) 

#define IOPOSPOSPrinter_get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd)	\
    ( (This)->lpVtbl -> get_SlpLinesNearEndToEnd(This,pSlpLinesNearEndToEnd) ) 

#define IOPOSPOSPrinter_get_SlpLineSpacing(This,pSlpLineSpacing)	\
    ( (This)->lpVtbl -> get_SlpLineSpacing(This,pSlpLineSpacing) ) 

#define IOPOSPOSPrinter_put_SlpLineSpacing(This,SlpLineSpacing)	\
    ( (This)->lpVtbl -> put_SlpLineSpacing(This,SlpLineSpacing) ) 

#define IOPOSPOSPrinter_get_SlpLineWidth(This,pSlpLineWidth)	\
    ( (This)->lpVtbl -> get_SlpLineWidth(This,pSlpLineWidth) ) 

#define IOPOSPOSPrinter_get_SlpMaxLines(This,pSlpMaxLines)	\
    ( (This)->lpVtbl -> get_SlpMaxLines(This,pSlpMaxLines) ) 

#define IOPOSPOSPrinter_get_SlpNearEnd(This,pSlpNearEnd)	\
    ( (This)->lpVtbl -> get_SlpNearEnd(This,pSlpNearEnd) ) 

#define IOPOSPOSPrinter_get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxChars(This,pSlpSidewaysMaxChars) ) 

#define IOPOSPOSPrinter_get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines)	\
    ( (This)->lpVtbl -> get_SlpSidewaysMaxLines(This,pSlpSidewaysMaxLines) ) 

#define IOPOSPOSPrinter_BeginInsertion(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginInsertion(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_BeginRemoval(This,Timeout,pRC)	\
    ( (This)->lpVtbl -> BeginRemoval(This,Timeout,pRC) ) 

#define IOPOSPOSPrinter_CutPaper(This,Percentage,pRC)	\
    ( (This)->lpVtbl -> CutPaper(This,Percentage,pRC) ) 

#define IOPOSPOSPrinter_EndInsertion(This,pRC)	\
    ( (This)->lpVtbl -> EndInsertion(This,pRC) ) 

#define IOPOSPOSPrinter_EndRemoval(This,pRC)	\
    ( (This)->lpVtbl -> EndRemoval(This,pRC) ) 

#define IOPOSPOSPrinter_PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC)	\
    ( (This)->lpVtbl -> PrintBarCode(This,Station,Data,Symbology,Height,Width,Alignment,TextPosition,pRC) ) 

#define IOPOSPOSPrinter_PrintBitmap(This,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintBitmap(This,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_PrintImmediate(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintImmediate(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_PrintNormal(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> PrintNormal(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_PrintTwoNormal(This,Stations,Data1,Data2,pRC)	\
    ( (This)->lpVtbl -> PrintTwoNormal(This,Stations,Data1,Data2,pRC) ) 

#define IOPOSPOSPrinter_RotatePrint(This,Station,Rotation,pRC)	\
    ( (This)->lpVtbl -> RotatePrint(This,Station,Rotation,pRC) ) 

#define IOPOSPOSPrinter_SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> SetBitmap(This,BitmapNumber,Station,FileName,Width,Alignment,pRC) ) 

#define IOPOSPOSPrinter_SetLogo(This,Location,Data,pRC)	\
    ( (This)->lpVtbl -> SetLogo(This,Location,Data,pRC) ) 

#define IOPOSPOSPrinter_get_CapCharacterSet(This,pCapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapCharacterSet(This,pCapCharacterSet) ) 

#define IOPOSPOSPrinter_get_CapTransaction(This,pCapTransaction)	\
    ( (This)->lpVtbl -> get_CapTransaction(This,pCapTransaction) ) 

#define IOPOSPOSPrinter_get_ErrorLevel(This,pErrorLevel)	\
    ( (This)->lpVtbl -> get_ErrorLevel(This,pErrorLevel) ) 

#define IOPOSPOSPrinter_get_ErrorString(This,pErrorString)	\
    ( (This)->lpVtbl -> get_ErrorString(This,pErrorString) ) 

#define IOPOSPOSPrinter_get_FontTypefaceList(This,pFontTypefaceList)	\
    ( (This)->lpVtbl -> get_FontTypefaceList(This,pFontTypefaceList) ) 

#define IOPOSPOSPrinter_get_RecBarCodeRotationList(This,pRecBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_RecBarCodeRotationList(This,pRecBarCodeRotationList) ) 

#define IOPOSPOSPrinter_get_RotateSpecial(This,pRotateSpecial)	\
    ( (This)->lpVtbl -> get_RotateSpecial(This,pRotateSpecial) ) 

#define IOPOSPOSPrinter_put_RotateSpecial(This,RotateSpecial)	\
    ( (This)->lpVtbl -> put_RotateSpecial(This,RotateSpecial) ) 

#define IOPOSPOSPrinter_get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList)	\
    ( (This)->lpVtbl -> get_SlpBarCodeRotationList(This,pSlpBarCodeRotationList) ) 

#define IOPOSPOSPrinter_TransactionPrint(This,Station,Control,pRC)	\
    ( (This)->lpVtbl -> TransactionPrint(This,Station,Control,pRC) ) 

#define IOPOSPOSPrinter_ValidateData(This,Station,Data,pRC)	\
    ( (This)->lpVtbl -> ValidateData(This,Station,Data,pRC) ) 

#define IOPOSPOSPrinter_get_BinaryConversion(This,pBinaryConversion)	\
    ( (This)->lpVtbl -> get_BinaryConversion(This,pBinaryConversion) ) 

#define IOPOSPOSPrinter_put_BinaryConversion(This,BinaryConversion)	\
    ( (This)->lpVtbl -> put_BinaryConversion(This,BinaryConversion) ) 

#define IOPOSPOSPrinter_get_CapPowerReporting(This,pCapPowerReporting)	\
    ( (This)->lpVtbl -> get_CapPowerReporting(This,pCapPowerReporting) ) 

#define IOPOSPOSPrinter_get_PowerNotify(This,pPowerNotify)	\
    ( (This)->lpVtbl -> get_PowerNotify(This,pPowerNotify) ) 

#define IOPOSPOSPrinter_put_PowerNotify(This,PowerNotify)	\
    ( (This)->lpVtbl -> put_PowerNotify(This,PowerNotify) ) 

#define IOPOSPOSPrinter_get_PowerState(This,pPowerState)	\
    ( (This)->lpVtbl -> get_PowerState(This,pPowerState) ) 

#define IOPOSPOSPrinter_get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapJrnCartridgeSensor(This,pCapJrnCartridgeSensor) ) 

#define IOPOSPOSPrinter_get_CapJrnColor(This,pCapJrnColor)	\
    ( (This)->lpVtbl -> get_CapJrnColor(This,pCapJrnColor) ) 

#define IOPOSPOSPrinter_get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapRecCartridgeSensor(This,pCapRecCartridgeSensor) ) 

#define IOPOSPOSPrinter_get_CapRecColor(This,pCapRecColor)	\
    ( (This)->lpVtbl -> get_CapRecColor(This,pCapRecColor) ) 

#define IOPOSPOSPrinter_get_CapRecMarkFeed(This,pCapRecMarkFeed)	\
    ( (This)->lpVtbl -> get_CapRecMarkFeed(This,pCapRecMarkFeed) ) 

#define IOPOSPOSPrinter_get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint)	\
    ( (This)->lpVtbl -> get_CapSlpBothSidesPrint(This,pCapSlpBothSidesPrint) ) 

#define IOPOSPOSPrinter_get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor)	\
    ( (This)->lpVtbl -> get_CapSlpCartridgeSensor(This,pCapSlpCartridgeSensor) ) 

#define IOPOSPOSPrinter_get_CapSlpColor(This,pCapSlpColor)	\
    ( (This)->lpVtbl -> get_CapSlpColor(This,pCapSlpColor) ) 

#define IOPOSPOSPrinter_get_CartridgeNotify(This,pCartridgeNotify)	\
    ( (This)->lpVtbl -> get_CartridgeNotify(This,pCartridgeNotify) ) 

#define IOPOSPOSPrinter_put_CartridgeNotify(This,CartridgeNotify)	\
    ( (This)->lpVtbl -> put_CartridgeNotify(This,CartridgeNotify) ) 

#define IOPOSPOSPrinter_get_JrnCartridgeState(This,pJrnCartridgeState)	\
    ( (This)->lpVtbl -> get_JrnCartridgeState(This,pJrnCartridgeState) ) 

#define IOPOSPOSPrinter_get_JrnCurrentCartridge(This,pJrnCurrentCartridge)	\
    ( (This)->lpVtbl -> get_JrnCurrentCartridge(This,pJrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_put_JrnCurrentCartridge(This,JrnCurrentCartridge)	\
    ( (This)->lpVtbl -> put_JrnCurrentCartridge(This,JrnCurrentCartridge) ) 

#define IOPOSPOSPrinter_get_RecCartridgeState(This,pRecCartridgeState)	\
    ( (This)->lpVtbl -> get_RecCartridgeState(This,pRecCartridgeState) ) 

#define IOPOSPOSPrinter_get_RecCurrentCartridge(This,pRecCurrentCartridge)	\
    ( (This)->lpVtbl -> get_RecCurrentCartridge(This,pRecCurrentCartridge) ) 

#define IOPOSPOSPrinter_put_RecCurrentCartridge(This,RecCurrentCartridge)	\
    ( (This)->lpVtbl -> put_RecCurrentCartridge(This,RecCurrentCartridge) ) 

#define IOPOSPOSPrinter_get_SlpCartridgeState(This,pSlpCartridgeState)	\
    ( (This)->lpVtbl -> get_SlpCartridgeState(This,pSlpCartridgeState) ) 

#define IOPOSPOSPrinter_get_SlpCurrentCartridge(This,pSlpCurrentCartridge)	\
    ( (This)->lpVtbl -> get_SlpCurrentCartridge(This,pSlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_put_SlpCurrentCartridge(This,SlpCurrentCartridge)	\
    ( (This)->lpVtbl -> put_SlpCurrentCartridge(This,SlpCurrentCartridge) ) 

#define IOPOSPOSPrinter_get_SlpPrintSide(This,pSlpPrintSide)	\
    ( (This)->lpVtbl -> get_SlpPrintSide(This,pSlpPrintSide) ) 

#define IOPOSPOSPrinter_ChangePrintSide(This,Side,pRC)	\
    ( (This)->lpVtbl -> ChangePrintSide(This,Side,pRC) ) 

#define IOPOSPOSPrinter_MarkFeed(This,Type,pRC)	\
    ( (This)->lpVtbl -> MarkFeed(This,Type,pRC) ) 


#define IOPOSPOSPrinter_get_CapMapCharacterSet(This,pCapMapCharacterSet)	\
    ( (This)->lpVtbl -> get_CapMapCharacterSet(This,pCapMapCharacterSet) ) 

#define IOPOSPOSPrinter_get_MapCharacterSet(This,pMapCharacterSet)	\
    ( (This)->lpVtbl -> get_MapCharacterSet(This,pMapCharacterSet) ) 

#define IOPOSPOSPrinter_put_MapCharacterSet(This,MapCharacterSet)	\
    ( (This)->lpVtbl -> put_MapCharacterSet(This,MapCharacterSet) ) 

#define IOPOSPOSPrinter_get_RecBitmapRotationList(This,pRecBitmapRotationList)	\
    ( (This)->lpVtbl -> get_RecBitmapRotationList(This,pRecBitmapRotationList) ) 

#define IOPOSPOSPrinter_get_SlpBitmapRotationList(This,pSlpBitmapRotationList)	\
    ( (This)->lpVtbl -> get_SlpBitmapRotationList(This,pSlpBitmapRotationList) ) 


#define IOPOSPOSPrinter_get_CapStatisticsReporting(This,pCapStatisticsReporting)	\
    ( (This)->lpVtbl -> get_CapStatisticsReporting(This,pCapStatisticsReporting) ) 

#define IOPOSPOSPrinter_get_CapUpdateStatistics(This,pCapUpdateStatistics)	\
    ( (This)->lpVtbl -> get_CapUpdateStatistics(This,pCapUpdateStatistics) ) 

#define IOPOSPOSPrinter_ResetStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> ResetStatistics(This,StatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_RetrieveStatistics(This,pStatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> RetrieveStatistics(This,pStatisticsBuffer,pRC) ) 

#define IOPOSPOSPrinter_UpdateStatistics(This,StatisticsBuffer,pRC)	\
    ( (This)->lpVtbl -> UpdateStatistics(This,StatisticsBuffer,pRC) ) 


#define IOPOSPOSPrinter_get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion)	\
    ( (This)->lpVtbl -> get_CapCompareFirmwareVersion(This,pCapCompareFirmwareVersion) ) 

#define IOPOSPOSPrinter_get_CapUpdateFirmware(This,pCapUpdateFirmware)	\
    ( (This)->lpVtbl -> get_CapUpdateFirmware(This,pCapUpdateFirmware) ) 

#define IOPOSPOSPrinter_CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC)	\
    ( (This)->lpVtbl -> CompareFirmwareVersion(This,FirmwareFileName,pResult,pRC) ) 

#define IOPOSPOSPrinter_UpdateFirmware(This,FirmwareFileName,pRC)	\
    ( (This)->lpVtbl -> UpdateFirmware(This,FirmwareFileName,pRC) ) 

#define IOPOSPOSPrinter_get_CapConcurrentPageMode(This,pCapConcurrentPageMode)	\
    ( (This)->lpVtbl -> get_CapConcurrentPageMode(This,pCapConcurrentPageMode) ) 

#define IOPOSPOSPrinter_get_CapRecPageMode(This,pCapRecPageMode)	\
    ( (This)->lpVtbl -> get_CapRecPageMode(This,pCapRecPageMode) ) 

#define IOPOSPOSPrinter_get_CapSlpPageMode(This,pCapSlpPageMode)	\
    ( (This)->lpVtbl -> get_CapSlpPageMode(This,pCapSlpPageMode) ) 

#define IOPOSPOSPrinter_get_PageModeArea(This,pPageModeArea)	\
    ( (This)->lpVtbl -> get_PageModeArea(This,pPageModeArea) ) 

#define IOPOSPOSPrinter_get_PageModeDescriptor(This,pPageModeDescriptor)	\
    ( (This)->lpVtbl -> get_PageModeDescriptor(This,pPageModeDescriptor) ) 

#define IOPOSPOSPrinter_get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> get_PageModeHorizontalPosition(This,pPageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_put_PageModeHorizontalPosition(This,PageModeHorizontalPosition)	\
    ( (This)->lpVtbl -> put_PageModeHorizontalPosition(This,PageModeHorizontalPosition) ) 

#define IOPOSPOSPrinter_get_PageModePrintArea(This,pPageModePrintArea)	\
    ( (This)->lpVtbl -> get_PageModePrintArea(This,pPageModePrintArea) ) 

#define IOPOSPOSPrinter_put_PageModePrintArea(This,PageModePrintArea)	\
    ( (This)->lpVtbl -> put_PageModePrintArea(This,PageModePrintArea) ) 

#define IOPOSPOSPrinter_get_PageModePrintDirection(This,pPageModePrintDirection)	\
    ( (This)->lpVtbl -> get_PageModePrintDirection(This,pPageModePrintDirection) ) 

#define IOPOSPOSPrinter_put_PageModePrintDirection(This,PageModePrintDirection)	\
    ( (This)->lpVtbl -> put_PageModePrintDirection(This,PageModePrintDirection) ) 

#define IOPOSPOSPrinter_get_PageModeStation(This,pPageModeStation)	\
    ( (This)->lpVtbl -> get_PageModeStation(This,pPageModeStation) ) 

#define IOPOSPOSPrinter_put_PageModeStation(This,PageModeStation)	\
    ( (This)->lpVtbl -> put_PageModeStation(This,PageModeStation) ) 

#define IOPOSPOSPrinter_get_PageModeVerticalPosition(This,pPageModeVerticalPosition)	\
    ( (This)->lpVtbl -> get_PageModeVerticalPosition(This,pPageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_put_PageModeVerticalPosition(This,PageModeVerticalPosition)	\
    ( (This)->lpVtbl -> put_PageModeVerticalPosition(This,PageModeVerticalPosition) ) 

#define IOPOSPOSPrinter_ClearPrintArea(This,pRC)	\
    ( (This)->lpVtbl -> ClearPrintArea(This,pRC) ) 

#define IOPOSPOSPrinter_PageModePrint(This,Control,pRC)	\
    ( (This)->lpVtbl -> PageModePrint(This,Control,pRC) ) 


#define IOPOSPOSPrinter_PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC)	\
    ( (This)->lpVtbl -> PrintMemoryBitmap(This,Station,Data,Type,Width,Alignment,pRC) ) 


#define IOPOSPOSPrinter_get_CapRecRuledLine(This,pCapRecRuledLine)	\
    ( (This)->lpVtbl -> get_CapRecRuledLine(This,pCapRecRuledLine) ) 

#define IOPOSPOSPrinter_get_CapSlpRuledLine(This,pCapSlpRuledLine)	\
    ( (This)->lpVtbl -> get_CapSlpRuledLine(This,pCapSlpRuledLine) ) 

#define IOPOSPOSPrinter_DrawRuledLine(This,Station,PositionList,LineDirection,LineWidth,LineStyle,LineColor,pRC)	\
    ( (This)->lpVtbl -> DrawRuledLine(This,Station,PositionList,LineDirection,LineWidth,LineStyle,LineColor,pRC) ) 


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IOPOSPOSPrinter_INTERFACE_DEFINED__ */



#ifndef __OposPOSPrinter_CCO_LIBRARY_DEFINED__
#define __OposPOSPrinter_CCO_LIBRARY_DEFINED__

/* library OposPOSPrinter_CCO */
/* [helpstring][version][uuid] */ 


EXTERN_C const IID LIBID_OposPOSPrinter_CCO;

#ifndef ___IOPOSPOSPrinterEvents_DISPINTERFACE_DEFINED__
#define ___IOPOSPOSPrinterEvents_DISPINTERFACE_DEFINED__

/* dispinterface _IOPOSPOSPrinterEvents */
/* [helpstring][uuid] */ 


EXTERN_C const IID DIID__IOPOSPOSPrinterEvents;

#if defined(__cplusplus) && !defined(CINTERFACE)

    MIDL_INTERFACE("CCB90153-B81E-11D2-AB74-0040054C3719")
    _IOPOSPOSPrinterEvents : public IDispatch
    {
    };
    
#else 	/* C style interface */

    typedef struct _IOPOSPOSPrinterEventsVtbl
    {
        BEGIN_INTERFACE
        
        DECLSPEC_XFGVIRT(IUnknown, QueryInterface)
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            _IOPOSPOSPrinterEvents * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            _COM_Outptr_  void **ppvObject);
        
        DECLSPEC_XFGVIRT(IUnknown, AddRef)
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            _IOPOSPOSPrinterEvents * This);
        
        DECLSPEC_XFGVIRT(IUnknown, Release)
        ULONG ( STDMETHODCALLTYPE *Release )( 
            _IOPOSPOSPrinterEvents * This);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfoCount)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            _IOPOSPOSPrinterEvents * This,
            /* [out] */ UINT *pctinfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetTypeInfo)
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            _IOPOSPOSPrinterEvents * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        DECLSPEC_XFGVIRT(IDispatch, GetIDsOfNames)
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            _IOPOSPOSPrinterEvents * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        DECLSPEC_XFGVIRT(IDispatch, Invoke)
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            _IOPOSPOSPrinterEvents * This,
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
    } _IOPOSPOSPrinterEventsVtbl;

    interface _IOPOSPOSPrinterEvents
    {
        CONST_VTBL struct _IOPOSPOSPrinterEventsVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _IOPOSPOSPrinterEvents_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define _IOPOSPOSPrinterEvents_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define _IOPOSPOSPrinterEvents_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define _IOPOSPOSPrinterEvents_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define _IOPOSPOSPrinterEvents_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define _IOPOSPOSPrinterEvents_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define _IOPOSPOSPrinterEvents_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */


#endif 	/* ___IOPOSPOSPrinterEvents_DISPINTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_OPOSPOSPrinter;

#ifdef __cplusplus

class DECLSPEC_UUID("CCB90152-B81E-11D2-AB74-0040054C3719")
OPOSPOSPrinter;
#endif
#endif /* __OposPOSPrinter_CCO_LIBRARY_DEFINED__ */

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


