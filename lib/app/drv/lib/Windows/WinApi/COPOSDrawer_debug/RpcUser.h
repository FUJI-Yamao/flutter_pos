#pragma once

#include "../COPOSDrawerIdl/RpcIdlRcv.h"
#include "../COPOSDrawerIdl/RpcIdlSnd.h"

void* __RPC_USER midl_user_allocate(size_t size);
void __RPC_USER midl_user_free(void* p);

CONTEXT_HANDLE_SND OpenSnd(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ DRW_DATA_SND* pdData);
void DrwDataSnd(
    /* [in] */ CONTEXT_HANDLE_SND hContext);
void CloseSnd(
    /* [out][in] */ CONTEXT_HANDLE_SND* phContext);

void __RPC_USER CONTEXT_HANDLE_SND_rundown(CONTEXT_HANDLE_SND hContext);