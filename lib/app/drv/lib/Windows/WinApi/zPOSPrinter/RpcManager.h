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
    HRESULT OnSend(PTR_DATA_SND* pData);

private:
    RPC_STATUS m_status;
    handle_t m_hBinding;
    HANDLE hThread;

    unique_ptr<IRpc> m_rpcall;
    function<HRESULT(IRpc*)> InitCallback = [=](IRpc* callback)
    {
        HRESULT hrServer;
        HRESULT hrClient;

        hrServer = callback->InitServer(RpcIdlRcv_v1_0_s_ifspec, hThread, PRINTER_RCV_PORT);
        hrClient = callback->InitClient(RpcIdlSnd_v1_0_c_ifspec, &m_hBinding, PRINTER_SND_PORT);
        if (S_OK != hrServer) return hrServer;
        if (S_OK != hrClient) return hrClient;

        return S_OK;
    };
    function<HRESULT(IRpc*)> DestroyCallback = [=](IRpc* callback)
    {
        HRESULT hrClient;
        HRESULT hrServer;

        hrClient = callback->DestroyClient(&m_hBinding);
        hrServer = callback->DestroyServer(hThread);
        if (S_OK != hrClient) return hrClient;
        if (S_OK != hrServer) return hrServer;

        return S_OK;
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