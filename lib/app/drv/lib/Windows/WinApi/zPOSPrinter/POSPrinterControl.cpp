#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposPtr.h"
#include "POSPrinterControl.h"

POSPrinterControl::POSPrinterControl() :
    m_cRef(0),
    _m_statCover(PTR_STAT_NONE),
    _m_statPaper(PTR_STAT_NONE)
{
    m_rpc.reset(new RpcManager());
    m_taskPrinter.reset(new TaskManager());
    m_pDataSnd = {};
    m_pDataSnd.textData = "";
    m_pDataSnd.bcData = "";
    m_pDataSnd.logoPath = "";
}

POSPrinterControl::~POSPrinterControl()
{

}

HRESULT POSPrinterControl::OnInit(const string& filePath)
{
    HRESULT hr;

    // RPC�������E�J�n
    Sleep(2000);  // �X���b�h�擾�C���^�[�o���i�����I���㑦�ċN���΍�j
    hr = m_rpc->OnInit();
    //if (FAILED(hr)) return hr;

    // �v���Z�X���s
    string exeName = filePath.substr(filePath.rfind("\\") + 1, filePath.length());
    m_taskPrinter->_m_filePath = filePath.c_str();
    m_taskPrinter->_m_exeName = exeName;
    hr = m_taskPrinter->StartTask();
    if (FAILED(hr)) return hr;

    return S_OK;
}

HRESULT POSPrinterControl::OnDestroy()
{
    HRESULT hr;

    hr = m_taskPrinter->EndTask();
    if (FAILED(hr)) return hr;

    //hr = m_rpc->OnDestroy();
    //if (FAILED(hr)) return hr;

    return S_OK;
}

HRESULT POSPrinterControl::OutputReceipt(LPCWSTR& textData, LPCWSTR& bcData)
{
    HRESULT hr;
    size_t size;
    char* pCharBody;
    char* pCharBarcode;

    m_pDataSnd.ptrCmd = PTR_CMD_REC_OUTPUT;     // ���V�[�g�o��

    // �V�X�e���K��̃��P�[���ɐݒ�
    setlocale(LC_ALL, "");

    pCharBody = (char*)malloc(BUFFER_WCHAR_SIZE(textData));
    wcstombs_s(&size, pCharBody, (size_t)BUFFER_WCHAR_SIZE(textData), textData, (size_t)BUFFER_WCHAR_SIZE(textData) - 1);
    m_pDataSnd.textData = pCharBody;            // �󎚓��e
    
    pCharBarcode = (char*)malloc(BUFFER_WCHAR_SIZE(bcData));
    wcstombs_s(&size, pCharBarcode, (size_t)BUFFER_WCHAR_SIZE(bcData), bcData, (size_t)BUFFER_WCHAR_SIZE(bcData) - 1);
    m_pDataSnd.bcData = pCharBarcode;           // �o�[�R�[�h

    hr = m_rpc->OnSend(&m_pDataSnd);

    if (pCharBody) free(pCharBody);
    if (pCharBarcode) free(pCharBarcode);

    return hr;
}

HRESULT POSPrinterControl::RegisterLogo(LPCSTR& filePath)
{
    HRESULT hr;

    m_pDataSnd.ptrCmd = PTR_CMD_LOGO_REG;       // ���V�[�g���S�o�^
    m_pDataSnd.logoPath = filePath;
    hr = m_rpc->OnSend(&m_pDataSnd);

    return hr;
}

HRESULT POSPrinterControl::InquireStatusCover()
{
    HRESULT hr;

    m_pDataSnd.ptrCmd = PTR_CMD_GET_STAT_COVER;     // �v�����^�J�o�[�J��Ԗ⍇��
    hr = m_rpc->OnSend(&m_pDataSnd);

    return hr;
}

HRESULT POSPrinterControl::InquireStatusPaper()
{
    HRESULT hr;

    m_pDataSnd.ptrCmd = PTR_CMD_GET_STAT_PAPER;     // ���V�[�g�L����Ԗ⍇��
    hr = m_rpc->OnSend(&m_pDataSnd);

    return hr;
}

VOID POSPrinterControl::PrinterDebugLog()
{
    SetResCodeStrings();

    cout << ">>> POSPrinter" << endl;

    list<DebugInfo>::iterator ite = m_debugInfoList.begin();
    for (; ite != m_debugInfoList.end(); ++ite)
    {
        cout << ite->m_label << " : " << ite->m_resCodeString << endl;
    }
}