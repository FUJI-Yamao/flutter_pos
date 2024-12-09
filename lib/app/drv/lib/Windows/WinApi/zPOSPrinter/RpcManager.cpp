#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "RpcManager.h"

RpcManager::RpcManager() :
    m_hBinding(NULL),
    hThread(NULL)
{
    m_status = (RPC_STATUS)nullptr;
    m_rpcall.reset(new RemoteProc(m_status));
}

RpcManager::~RpcManager()
{

}

HRESULT RpcManager::OnSend(PTR_DATA_SND* pData)
{
    RpcTryExcept
    {
        CONTEXT_HANDLE_SND hContext = OpenSnd(m_hBinding, pData);
        PtrDataSnd(hContext);
        CloseSnd(&hContext);
    }
        RpcExcept(1)
    {
        m_status = m_rpcall->HandleError("Remote Procedure Call", RpcExceptionCode());
        return E_FAIL;
    }
    RpcEndExcept

        return S_OK;
}