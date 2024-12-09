#include "mfcafx.h"
#include "RpcUser.h"
#include "DrawerAct.h"
#include "../COpos/COposDrw.h"

void* __RPC_USER midl_user_allocate(size_t size)
{
    return malloc(size);
}

void __RPC_USER midl_user_free(void* p)
{
    free(p);
}

CONTEXT_HANDLE_SND OpenSnd(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ DRW_DATA_SND* pdData)
{
    CONTEXT_HANDLE_SND hContext = pdData;
    //cout << "-------------------------" << endl;
    //cout << "C++ OpenSnd : Binding(" << hBinding << ")" << endl;
    //cout << "C++ OpenSnd : Context(" << hContext << ")" << endl;;
    return hContext;
}

void DrwDataSnd(
    /* [in] */ CONTEXT_HANDLE_SND hContext)
{
    //cout << "C++ DrwDataSnd : Context(" << hContext << ")" << endl;
    DRW_DATA_SND* pContext = static_cast<DRW_DATA_SND*>(hContext);

    //cout << "C++ Cmd : " << pContext->drwCmd << endl;
    switch (pContext->drwCmd)
    {
    case DRW_CMD_OPEN:          // ドロアオープン
        OnDrawerOpen();
        break;
    case DRW_CMD_GET_OPENED:    // ドロア開閉状態送信
        OnGetDrawerOpened();
        break;
    default:
        //cout << "Cmd invalid." << endl;
        break;
    }
}

void CloseSnd(
    /* [out][in] */ CONTEXT_HANDLE_SND* phContext)
{
    //cout << "C++ CloseSnd : Context(" << *phContext << ")" << endl;
    *phContext = NULL;
}

// クライアントへの接続が失われた場合、RPCランタイムはこの関数をコール
void __RPC_USER CONTEXT_HANDLE_SND_rundown(CONTEXT_HANDLE_SND hContext)
{
    cout << "C++ CONTEXT_HANDLE_SND_rundown : Context(" << hContext << ")";
    CloseSnd(&hContext);
}