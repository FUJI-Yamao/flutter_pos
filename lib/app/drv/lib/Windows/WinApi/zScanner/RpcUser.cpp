#include "../OposSystem/stdafx.h"
#include "RpcUser.h"
#include "ScannerAPI.h"

static ScannerControl& g_scanner = Singleton<ScannerControl>::GetInstance();

void* __RPC_USER midl_user_allocate(size_t size)
{
    return malloc(size);
}

void __RPC_USER midl_user_free(void* p)
{
    free(p);
}

CONTEXT_HANDLE Open(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ SCAN_DATA* psData)
{
    CONTEXT_HANDLE hContext = psData;
    //cout << "-------------------------" << endl;
    cout << "C++ Open : Binding(" << hBinding << ")" << endl;
    cout << "C++ Open : Context(" << hContext << ")" << endl;;
    return hContext;
}

void ScanData(
    /* [in] */ CONTEXT_HANDLE hContext)
{
    cout << "C++ ScanData : Context(" << hContext << ")" << endl;
    SCAN_DATA* pContext = static_cast<SCAN_DATA*>(hContext);
    string* pScanData = new string(pContext->scanData);
    string* pScanType = new string(pContext->scanType);
    string* pScanLabel = new string(pContext->scanLabel);
    cout << "C++ Data : " << *pScanData << "," << *pScanType << "," << *pScanLabel << endl;
    g_scanner.SetScanData(*pScanData);
    g_scanner.SetScanType(*pScanType);
    g_scanner.SetScanLabel(*pScanLabel);
    g_scanner.AddRef();    // 必ずインクリは後
}

void Close(
    /* [out][in] */ CONTEXT_HANDLE* phContext)
{
    cout << "C++ Close : Context(" << *phContext << ")" << endl;
    *phContext = NULL;
}

// クライアントへの接続が失われた場合、RPCランタイムはこの関数をコール
void __RPC_USER CONTEXT_HANDLE_rundown(CONTEXT_HANDLE hContext)
{
    cout << "C++ CONTEXT_HANDLE_rundown : Context(" << hContext << ")";
    Close(&hContext);
}