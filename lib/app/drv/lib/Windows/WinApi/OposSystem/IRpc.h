#pragma once

class IRpc
{
public:
	typedef RPC_STATUS RpcStat_t;

	virtual ~IRpc() {}

	virtual HRESULT InitClient(RPC_IF_HANDLE hRpcIf, handle_t* hBinding, CHAR* portNum=DEFAULT_PORT_1) = 0;
	virtual HRESULT InitServer(RPC_IF_HANDLE hRpcIf, HANDLE hThread, CHAR* portNum=DEFAULT_PORT_2) = 0;
	virtual HRESULT DestroyClient(handle_t* hBinding) = 0;
	virtual HRESULT DestroyServer(HANDLE hThread) = 0;
	virtual DWORD HandleError(LPCSTR szFunction, DWORD dwError) = 0;
};