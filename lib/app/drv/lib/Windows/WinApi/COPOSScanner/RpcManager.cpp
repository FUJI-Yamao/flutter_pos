#include "../OposSystem/OposDefs.h"
#include "mfcafx.h"
#include "RpcManager.h"

RpcManager::RpcManager() :
    m_hBinding(NULL)
{
    m_status = (RPC_STATUS)nullptr;
    m_rpcall.reset(new RemoteProc(m_status));
}

RpcManager::~RpcManager()
{

}

HRESULT RpcManager::OnSend(SCAN_DATA* pData)
{
    RpcTryExcept
    {
        CONTEXT_HANDLE hContext = Open(m_hBinding, pData);
        ScanData(hContext);
        Close(&hContext);
    }
        RpcExcept(1)
    {
        m_status = m_rpcall->HandleError("Remote Procedure Call", RpcExceptionCode());
        return E_FAIL;
    }
    RpcEndExcept

        return S_OK;
}