#include "stdafx.h"
#include "TaskManager.h"

TaskManager::TaskManager() :
    _m_bExecuted(FALSE),
    _m_filePath(""),
    _m_exeName("")
{
    m_startupInfo = { 0 };
    m_processInfo = { 0 };
}

TaskManager::~TaskManager()
{
    // ハンドル解放
    CloseHandle(m_processInfo.hThread);
    CloseHandle(m_processInfo.hProcess);
}

DWORD TaskManager::GetProcessIdByName()
{
    auto entry = PROCESSENTRY32{ sizeof(PROCESSENTRY32) };

    auto hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

    if (Process32First(hSnapshot, &entry))
    {
        do {
            BOOL isEqual = _m_exeName == entry.szExeFile;
            if (isEqual)
            {
                CloseHandle(hSnapshot);
                return entry.th32ProcessID;
            }
        } while (Process32Next(hSnapshot, &entry));
    }

    CloseHandle(hSnapshot);
    return NO_PROCESS;
}

HRESULT TaskManager::StartTask()
{
    // プロセス実行中である場合KILL
    auto processId = GetProcessIdByName();
    if (NO_PROCESS != processId)
    {
        // プロセス情報初期化
        //m_startupInfo = { 0 };
        //m_processInfo = { 0 };

        //const auto explorer = OpenProcess(PROCESS_TERMINATE, false, processId);
        //TerminateProcess(explorer, 1);
        //CloseHandle(explorer);

        // プロセス実行中のままスルー
        _m_bExecuted = TRUE;
        return S_OK;
    }

    // プロセス生成・実行
    _m_bExecuted = CreateProcess(
        _m_filePath,
        NULL,
        NULL,
        NULL,
        FALSE,
        0,
        NULL,
        NULL,
        &m_startupInfo,
        &m_processInfo
    );

    return _m_bExecuted ? S_OK : E_FAIL;
}

HRESULT TaskManager::EndTask()
{
    BOOL bResult = FALSE;

    if (TRUE == _m_bExecuted)
    {
        // プロセス終了要求（プロセスID既取得の場合）
        //bResult = TerminateProcess(m_processInfo.hProcess, 0);

        // プロセス終了要求（プロセスID検索の場合）
        auto processId = GetProcessIdByName();
        const auto explorer = OpenProcess(PROCESS_TERMINATE, false, processId);
        TerminateProcess(explorer, 1);
        CloseHandle(explorer);

        _m_bExecuted = bResult ? FALSE : TRUE;
    }

    return bResult ? S_OK : _m_bExecuted ? E_FAIL : S_FALSE;
}