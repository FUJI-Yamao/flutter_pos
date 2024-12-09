#include "../OposSystem/stdafx.h"
#include "RpcUser.h"
#include "CashDrawerAPI.h"

static CashDrawerControl& g_drawer = Singleton<CashDrawerControl>::GetInstance();

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
    /* [full][in] */ DRW_DATA_RCV* pdData)
{
    CONTEXT_HANDLE_RCV hContext = pdData;
    //cout << "-------------------------" << endl;
    cout << "C++ OpenRcv : Binding(" << hBinding << ")" << endl;
    cout << "C++ OpenRcv : Context(" << hContext << ")" << endl;;
    return hContext;
}

void DrwDataRcv(
    /* [in] */ CONTEXT_HANDLE_RCV hContext)
{
    cout << "C++ DrwDataRcv : Context(" << hContext << ")" << endl;
    DRW_DATA_RCV* pContext = static_cast<DRW_DATA_RCV*>(hContext);
    cout << "C++ Data : "
        << "Status " << pContext->drwStat << " , "
        << "Error " << pContext->drwError
        << endl;
    g_drawer.SetDrwStat(pContext->drwStat);
    g_drawer.AddRef();    // �K���C���N���͌�
}

void CloseRcv(
    /* [out][in] */ CONTEXT_HANDLE_RCV* phContext)
{
    cout << "C++ CloseRcv : Context(" << *phContext << ")" << endl;
    *phContext = NULL;
}

// �N���C�A���g�ւ̐ڑ�������ꂽ�ꍇ�ARPC�����^�C���͂��̊֐����R�[��
void __RPC_USER CONTEXT_HANDLE_RCV_rundown(CONTEXT_HANDLE_RCV hContext)
{
    cout << "C++ CONTEXT_HANDLE_RCV_rundown : Context(" << hContext << ")";
    CloseRcv(&hContext);
}