#pragma once

#include "../COPOSPOSPrinterIdl/RpcIdlRcv.h"
#include "../COPOSPOSPrinterIdl/RpcIdlSnd.h"

void* __RPC_USER midl_user_allocate(size_t size);
void __RPC_USER midl_user_free(void* p);

CONTEXT_HANDLE_RCV OpenRcv(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ PTR_DATA_RCV* pdData);
void PtrDataRcv(
    /* [in] */ CONTEXT_HANDLE_RCV hContext);
void CloseRcv(
    /* [out][in] */ CONTEXT_HANDLE_RCV* phContext);

void __RPC_USER CONTEXT_HANDLE_RCV_rundown(CONTEXT_HANDLE_RCV hContext);