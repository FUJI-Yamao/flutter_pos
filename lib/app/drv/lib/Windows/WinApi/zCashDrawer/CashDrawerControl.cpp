#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposDrw.h"
#include "CashDrawerControl.h"

CashDrawerControl::CashDrawerControl() :
    m_cRef(0),
    _m_drwStat(0)
{
    m_rpc.reset(new RpcManager());
    m_taskDrawer.reset(new TaskManager());
    m_taskDIOPort.reset(new TaskManager());
    m_dDataSnd = {};
}

CashDrawerControl::~CashDrawerControl()
{

}

HRESULT CashDrawerControl::OnInit(const string& filePath)
{
    HRESULT hr;
    
    // RPC初期化・開始
    Sleep(2000);  // スレッド取得インターバル（強制終了後即再起動対策）
    hr = m_rpc->OnInit();
    //if (FAILED(hr)) return hr;

    // プロセス実行
    string exeName = filePath.substr(filePath.rfind("\\") + 1, filePath.length());
    m_taskDrawer->_m_filePath = filePath.c_str();
    m_taskDrawer->_m_exeName = exeName;
    hr = m_taskDrawer->StartTask();
    if (FAILED(hr)) return hr;

    return S_OK;
}

HRESULT CashDrawerControl::OnDestroy()
{
    HRESULT hr;

    hr = m_taskDrawer->EndTask();
    if (FAILED(hr)) return hr;

    //hr = m_rpc->OnDestroy();
    //if (FAILED(hr)) return hr;

    return S_OK;
}

HRESULT CashDrawerControl::OpenPortDrawer(const string& filePath)
{
    HRESULT hr;

    // プロセス実行
    string exeName = filePath.substr(filePath.rfind("\\") + 1, filePath.length());
    m_taskDIOPort->_m_filePath = filePath.c_str();
    m_taskDIOPort->_m_exeName = exeName;
    hr = m_taskDIOPort->StartTask();
    if (FAILED(hr)) return hr;

    return S_OK;
}

HRESULT CashDrawerControl::ClosePortDrawer()
{
    // プロセス終了
    return m_taskDIOPort->EndTask();
}

HRESULT CashDrawerControl::DrawerOpen()
{
    HRESULT hr;

    m_dDataSnd.drwCmd = DRW_CMD_OPEN;   // ドロアオープン
    hr = m_rpc->OnSend(&m_dDataSnd);
    
    return hr;
}

HRESULT CashDrawerControl::InquireDrawerOpened()
{
    HRESULT hr;
    
    m_dDataSnd.drwCmd = DRW_CMD_GET_OPENED; // ドロア開閉状態問合せ
    hr = m_rpc->OnSend(&m_dDataSnd);

    return hr;
}

VOID CashDrawerControl::DrawerDebugLog()
{
    SetResCodeStrings();
    
    cout << ">>> CashDrawer" << endl;

    list<DebugInfo>::iterator ite = m_debugInfoList.begin();
    for (; ite != m_debugInfoList.end(); ++ite)
    {
        cout << ite->m_label << " : " << ite->m_resCodeString << endl;
    }
}