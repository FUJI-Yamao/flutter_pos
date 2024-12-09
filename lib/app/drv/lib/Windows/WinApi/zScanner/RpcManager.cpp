#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "RpcManager.h"

RpcManager::RpcManager() :
    hThread(NULL)
{
    m_status = (RPC_STATUS)nullptr;
    m_rpcall.reset(new RemoteProc(m_status));
}

RpcManager::~RpcManager()
{

}