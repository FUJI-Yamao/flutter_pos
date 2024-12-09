#include "stdafx.h"
#include "RemoteProc.h"

// 単純なセキュリティコールバック
RPC_STATUS CALLBACK SecurityCallback(RPC_IF_HANDLE /*hInterface*/, void* /*pBindingHandle*/)
{
    return RPC_S_OK;    // 常に誰でも許可
}

// 着信RPCコールに応答するスレッド
DWORD WINAPI RpcServerListenThreadProc(LPVOID /*pParam*/)
{
    // 登録されている全てのインターフェースのRPCの応答を開始
    return RpcServerListen(1, RPC_C_LISTEN_MAX_CALLS_DEFAULT, FALSE);
}

RemoteProc::RemoteProc(RpcStat_t status) :
    _m_status(status)
{

}

HRESULT RemoteProc::InitClient(RPC_IF_HANDLE hRpcIf, handle_t* hBinding, CHAR* portNum)
{
    unsigned char* szStringBinding = NULL;

    // バインディングハンドルを作成
    _m_status = RpcStringBindingCompose(
        NULL,
        reinterpret_cast<unsigned char*>(TCP_IP_PROTOCOL),
        reinterpret_cast<unsigned char*>(LOCAL_HOST),
        reinterpret_cast<unsigned char*>(portNum),
        NULL,
        &szStringBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcStringBindingCompose", _m_status);
        return E_FAIL;
    }

    // 検証・バインディングハンドルに変換
    _m_status = RpcBindingFromStringBinding(szStringBinding, hBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcBindingFromStringBinding", _m_status);
        return E_FAIL;
    }

    // 割り当てメモリを解放
    _m_status = RpcStringFree(&szStringBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcStringFree", _m_status);
        return E_FAIL;
    }

    // 完全にバインドされたサーバーバインディングハンドルで解決
    _m_status = RpcEpResolveBinding(*hBinding, hRpcIf);
    if (_m_status)
    {
        _m_status = HandleError("RpcEpResolveBinding", _m_status);
        return E_FAIL;
    }

    return S_OK;
}

HRESULT RemoteProc::InitServer(RPC_IF_HANDLE hRpcIf, HANDLE hThread, CHAR* portNum)
{
    // 受信用のエンドポイントと組み合わせたプロトコルを使用
    _m_status = RpcServerUseProtseqEp(
        reinterpret_cast<unsigned char*>(TCP_IP_PROTOCOL),
        RPC_C_PROTSEQ_MAX_REQS_DEFAULT,
        reinterpret_cast<unsigned char*>(portNum),
        NULL);
    if (_m_status)
    {
        _m_status = HandleError("RpcServerUseProtseqEp", _m_status);
        return E_FAIL;
    }

    // インターフェースを登録
    _m_status = RpcServerRegisterIf2(
        hRpcIf,
        NULL,
        NULL,
        RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH,
        RPC_C_LISTEN_MAX_CALLS_DEFAULT,
        (unsigned)-1,
        SecurityCallback);
    if (_m_status)
    {
        _m_status = HandleError("RpcServerRegisterIf", _m_status);
        return E_FAIL;
    }

    // スレッドハンドルを作成
    hThread = CreateThread(
        NULL,
        0,
        RpcServerListenThreadProc,
        NULL,
        0,
        NULL);
    if (!hThread)
    {
        _m_status = HandleError("CreateThread", GetLastError());
        return E_FAIL;
    }

    return S_OK;
}

HRESULT RemoteProc::DestroyClient(handle_t* hBinding)
{
    // リソース解放・サーバーから切断
    _m_status = RpcBindingFree(hBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcBindingFree", _m_status);
        return E_FAIL;
    }

    return S_OK;
}

HRESULT RemoteProc::DestroyServer(HANDLE hThread)
{
    // RPC受信サービスを停止
    _m_status = RpcMgmtStopServerListening(NULL);
    if (_m_status)
    {
        _m_status = HandleError("RpcMgmtStopServerListening", _m_status);
        return E_FAIL;
    }

    // スレッドが終了するまで待機
    while (WaitForSingleObject(hThread, 1000) == WAIT_TIMEOUT)
        cout << '.';
    cout << endl;
    cout << "Listen thread finished." << endl;;

    // スレッドハンドルをクローズ
    DWORD dwExitCodeThread = 0;
    GetExitCodeThread(hThread, &dwExitCodeThread);
    CloseHandle(hThread);
    if (dwExitCodeThread)
    {
        _m_status = HandleError("Rpc Server Listen", dwExitCodeThread);
        return E_FAIL;
    }

    return S_OK;
}

DWORD RemoteProc::HandleError(LPCSTR szFunction, DWORD dwError)
{
    void* pBuffer = NULL;
    FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM |
        FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_MAX_WIDTH_MASK,
        NULL,
        dwError,
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
        LPSTR(&pBuffer),
        0,
        NULL);

    cout << szFunction << " failed. "
        << (pBuffer ? LPCSTR(pBuffer) : "Unknown error. ")
        << "(" << dwError << ")" << endl;

    LocalFree(pBuffer);

    return dwError;
}