#include "../OposSystem/stdafx.h"
#include "ScannerControl.h"

ScannerControl::ScannerControl() :
    m_cRef(0)
{
    m_rpc.reset(new RpcManager());
    m_scanData = {};
    m_scanType = {};
    m_scanLabel = {};
}

ScannerControl::~ScannerControl()
{
   
}

HRESULT ScannerControl::OnInit(const string& filePath)
{
    HRESULT hr;

    // RPC初期化・開始
    Sleep(2000);  // スレッド取得インターバル（強制終了後即再起動対策）
    hr = m_rpc->OnInit();
    //if (FAILED(hr)) return hr;

    // プロセス実行
    string exeName = filePath.substr(filePath.rfind("\\") + 1, filePath.length());
    _m_filePath = filePath.c_str();
    _m_exeName = exeName.c_str();
    hr = StartTask();
    if (FAILED(hr)) return hr;
    
    return S_OK;
}

HRESULT ScannerControl::OnDestroy()
{
    HRESULT hr;

    hr = EndTask();
    if (FAILED(hr)) return hr;

    //hr = m_rpc->OnDestroy();
    //if (FAILED(hr)) return hr;

    return S_OK;
}

VOID ScannerControl::ScannerDebugLog()
{
    SetResCodeStrings();

    cout << ">>> Scanner" << endl;

    list<DebugInfo>::iterator ite = m_debugInfoList.begin();
    for (; ite != m_debugInfoList.end(); ++ite)
    {
        cout << ite->m_label << " : " << ite->m_resCodeString << endl;
    }
}