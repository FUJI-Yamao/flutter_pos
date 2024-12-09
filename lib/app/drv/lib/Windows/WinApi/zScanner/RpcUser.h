#pragma once

#include "../COPOSScannerIdl/RpcIdl.h"

void* __RPC_USER midl_user_allocate(size_t size);
void __RPC_USER midl_user_free(void* p);

CONTEXT_HANDLE Open(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ SCAN_DATA* psData);
void ScanData(
    /* [in] */ CONTEXT_HANDLE hContext);
void Close(
    /* [out][in] */ CONTEXT_HANDLE* phContext);

void __RPC_USER CONTEXT_HANDLE_rundown(CONTEXT_HANDLE hContext);