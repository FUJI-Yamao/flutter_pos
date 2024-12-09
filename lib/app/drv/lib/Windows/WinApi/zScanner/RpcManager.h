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

private:
    RPC_STATUS m_status;
    HANDLE hThread;

    unique_ptr<IRpc> m_rpcall;
    function<HRESULT(IRpc*)> InitCallback = [=](IRpc* callback)
    {
        return callback->InitServer(RpcIdl_v1_0_s_ifspec, hThread, SCANNER_RCV_PORT);
    };
    function<HRESULT(IRpc*)> DestroyCallback = [=](IRpc* callback)
    {
        return callback->DestroyServer(hThread);
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