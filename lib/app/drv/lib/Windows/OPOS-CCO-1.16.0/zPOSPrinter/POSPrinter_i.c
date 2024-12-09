

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


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



#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        EXTERN_C __declspec(selectany) const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif // !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_5,0xCCB91151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_7,0xCCB92151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_8,0xCCB93151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_9,0xCCB94151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_10,0xCCB95151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_10_zz,0xCCB96151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter_1_13,0xCCB97151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, IID_IOPOSPOSPrinter,0xCCB98151,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, LIBID_OposPOSPrinter_CCO,0xCCB90150,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(IID, DIID__IOPOSPOSPrinterEvents,0xCCB90153,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);


MIDL_DEFINE_GUID(CLSID, CLSID_OPOSPOSPrinter,0xCCB90152,0xB81E,0x11D2,0xAB,0x74,0x00,0x40,0x05,0x4C,0x37,0x19);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



