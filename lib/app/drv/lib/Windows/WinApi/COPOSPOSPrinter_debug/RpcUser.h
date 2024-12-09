#pragma once

#include "../COPOSPOSPrinterIdl/RpcIdlRcv.h"
#include "../COPOSPOSPrinterIdl/RpcIdlSnd.h"

void* __RPC_USER midl_user_allocate(size_t size);
void __RPC_USER midl_user_free(void* p);

CONTEXT_HANDLE_SND OpenSnd(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ PTR_DATA_SND* pdData);
void PtrDataSnd(
    /* [in] */ CONTEXT_HANDLE_SND hContext);
void CloseSnd(
    /* [out][in] */ CONTEXT_HANDLE_SND* phContext);

void __RPC_USER CONTEXT_HANDLE_SND_rundown(CONTEXT_HANDLE_SND hContext);