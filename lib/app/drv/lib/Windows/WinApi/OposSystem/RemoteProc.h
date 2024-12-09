#pragma once

#include "OposDefs.h"
#include "IRpc.h"

RPC_STATUS CALLBACK SecurityCallback(RPC_IF_HANDLE /*hInterface*/, void* /*pBindingHandle*/);
DWORD WINAPI RpcServerListenThreadProc(LPVOID /*pParam*/);

class RemoteProc :
	public IRpc
{
public:
	explicit RemoteProc(RpcStat_t status);

	virtual HRESULT InitClient(RPC_IF_HANDLE hRpcIf, handle_t* hBinding, CHAR* portNum=DEFAULT_PORT_1);
	virtual HRESULT InitServer(RPC_IF_HANDLE hRpcIf, HANDLE hThread, CHAR* portNum=DEFAULT_PORT_2);
	virtual HRESULT DestroyClient(handle_t* hBinding);
	virtual HRESULT DestroyServer(HANDLE hThread);
	virtual DWORD HandleError(LPCSTR szFunction, DWORD dwError);

private:
	RpcStat_t _m_status;
};

