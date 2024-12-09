#pragma once

#include "../COPOSScannerIdl/RpcIdl.h"

void* __RPC_USER midl_user_allocate(size_t size);
void __RPC_USER midl_user_free(void* p);

DWORD HandleError(const char* szFunction, DWORD dwError);