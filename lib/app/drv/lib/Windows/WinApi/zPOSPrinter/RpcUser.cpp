#include "../OposSystem/stdafx.h"
#include "RpcUser.h"
#include "POSPrinterAPI.h"

static POSPrinterControl& g_printer = Singleton<POSPrinterControl>::GetInstance();

void* __RPC_USER midl_user_allocate(size_t size)
{
    return malloc(size);
}

void __RPC_USER midl_user_free(void* p)
{
    free(p);
}

CONTEXT_HANDLE_RCV OpenRcv(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ PTR_DATA_RCV* pdData)
{
    CONTEXT_HANDLE_RCV hContext = pdData;
    //cout << "-------------------------" << endl;
    cout << "C++ OpenRcv : Binding(" << hBinding << ")" << endl;
    cout << "C++ OpenRcv : Context(" << hContext << ")" << endl;;
    return hContext;
}

void PtrDataRcv(
    /* [in] */ CONTEXT_HANDLE_RCV hContext)
{
    cout << "C++ PtrDataRcv : Context(" << hContext << ")" << endl;
    PTR_DATA_RCV* pContext = static_cast<PTR_DATA_RCV*>(hContext);
    cout << "C++ Data : "
        << "StatusCover " << pContext->statCover << " , "
        << "StatusPaper " << pContext->statPaper << " , "
        << "Error " << pContext->error
        << endl;
    g_printer.SetStatusCover(pContext->statCover);
    g_printer.SetStatusPaper(pContext->statPaper);
    g_printer.AddRef();    // 必ずインクリは後
}

void CloseRcv(
    /* [out][in] */ CONTEXT_HANDLE_RCV* phContext)
{
    cout << "C++ CloseRcv : Context(" << *phContext << ")" << endl;
    *phContext = NULL;
}

// クライアントへの接続が失われた場合、RPCランタイムはこの関数をコール
void __RPC_USER CONTEXT_HANDLE_RCV_rundown(CONTEXT_HANDLE_RCV hContext)
{
    cout << "C++ CONTEXT_HANDLE_RCV_rundown : Context(" << hContext << ")";
    CloseRcv(&hContext);
}