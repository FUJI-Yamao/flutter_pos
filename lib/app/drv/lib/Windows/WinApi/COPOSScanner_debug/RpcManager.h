#pragma once

#include "../OposSystem/RemoteProc.h"
#include "RpcUser.h"
#include <functional>

class RpcManager final
{
public:
    RpcManager();
    ~RpcManager();

    HRESULT OnInit();
    HRESULT OnDestroy();
    HRESULT OnSend(SCAN_DATA* pData);

private:
    RPC_STATUS m_status;
    handle_t m_hBinding;

    unique_ptr<IRpc> m_rpcall;
    function<HRESULT(IRpc*)> InitCallback = [=](IRpc* callback)
    {
        return callback->InitClient(RpcIdl_v1_0_c_ifspec, &m_hBinding, SCANNER_RCV_PORT);
    };
    function<HRESULT(IRpc*)> DestroyCallback = [=](IRpc* callback)
    {
        return callback->DestroyClient(&m_hBinding);
    };
};

inline HRESULT RpcManager::OnInit()
{
    return InitCallback(m_rpcall.get());
}

inline HRESULT RpcManager::OnDestroy()
{
    return DestroyCallback(m_rpcall.get());
}