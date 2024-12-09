#include "stdafx.h"
#include "RemoteProc.h"

// �P���ȃZ�L�����e�B�R�[���o�b�N
RPC_STATUS CALLBACK SecurityCallback(RPC_IF_HANDLE /*hInterface*/, void* /*pBindingHandle*/)
{
    return RPC_S_OK;    // ��ɒN�ł�����
}

// ���MRPC�R�[���ɉ�������X���b�h
DWORD WINAPI RpcServerListenThreadProc(LPVOID /*pParam*/)
{
    // �o�^����Ă���S�ẴC���^�[�t�F�[�X��RPC�̉������J�n
    return RpcServerListen(1, RPC_C_LISTEN_MAX_CALLS_DEFAULT, FALSE);
}

RemoteProc::RemoteProc(RpcStat_t status) :
    _m_status(status)
{

}

HRESULT RemoteProc::InitClient(RPC_IF_HANDLE hRpcIf, handle_t* hBinding, CHAR* portNum)
{
    unsigned char* szStringBinding = NULL;

    // �o�C���f�B���O�n���h�����쐬
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

    // ���؁E�o�C���f�B���O�n���h���ɕϊ�
    _m_status = RpcBindingFromStringBinding(szStringBinding, hBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcBindingFromStringBinding", _m_status);
        return E_FAIL;
    }

    // ���蓖�ă����������
    _m_status = RpcStringFree(&szStringBinding);
    if (_m_status)
    {
        _m_status = HandleError("RpcStringFree", _m_status);
        return E_FAIL;
    }

    // ���S�Ƀo�C���h���ꂽ�T�[�o�[�o�C���f�B���O�n���h���ŉ���
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
    // ��M�p�̃G���h�|�C���g�Ƒg�ݍ��킹���v���g�R�����g�p
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

    // �C���^�[�t�F�[�X��o�^
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

    // �X���b�h�n���h�����쐬
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
    // ���\�[�X����E�T�[�o�[����ؒf
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
    // RPC��M�T�[�r�X���~
    _m_status = RpcMgmtStopServerListening(NULL);
    if (_m_status)
    {
        _m_status = HandleError("RpcMgmtStopServerListening", _m_status);
        return E_FAIL;
    }

    // �X���b�h���I������܂őҋ@
    while (WaitForSingleObject(hThread, 1000) == WAIT_TIMEOUT)
        cout << '.';
    cout << endl;
    cout << "Listen thread finished." << endl;;

    // �X���b�h�n���h�����N���[�Y
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