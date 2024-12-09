#include "mfcafx.h"
#include "RpcUser.h"
#include "PrinterAct.h"
#include "../COpos/COposPtr.h"

void* __RPC_USER midl_user_allocate(size_t size)
{
    return malloc(size);
}

void __RPC_USER midl_user_free(void* p)
{
    free(p);
}

CONTEXT_HANDLE_SND OpenSnd(
    /* [in] */ handle_t hBinding,
    /* [full][in] */ PTR_DATA_SND* pdData)
{
    CONTEXT_HANDLE_SND hContext = pdData;
    //cout << "-------------------------" << endl;
    //cout << "C++ OpenSnd : Binding(" << hBinding << ")" << endl;
    //cout << "C++ OpenSnd : Context(" << hContext << ")" << endl;
    return hContext;
}

void PtrDataSnd(
    /* [in] */ CONTEXT_HANDLE_SND hContext)
{
    //cout << "C++ PtrDataSnd : Context(" << hContext << ")" << endl;
    PTR_DATA_SND* pContext = static_cast<PTR_DATA_SND*>(hContext);
    string* pTextData = new string(pContext->textData);
    string* pBcData = new string(pContext->bcData);
    string* pLogoPath = new string(pContext->logoPath);

    //cout << "C++ Cmd : " << pContext->ptrCmd << endl;
    switch (pContext->ptrCmd)
    {
    case PTR_CMD_REC_OUTPUT:        // ���V�[�g�o��
        OnOutputReceipt(*pTextData, *pBcData);
        break;
    case PTR_CMD_LOGO_REG:          // ���V�[�g���S�o�^
        OnRegisterLogo(*pLogoPath);
        break;
    case PTR_CMD_GET_STAT_COVER:    // �v�����^�J�o�[�J��ԑ��M
        OnGetStatCover();
        break;
    case PTR_CMD_GET_STAT_PAPER:    // ���V�[�g�p���L����ԑ��M
        OnGetStatPaper();
        break;
    default:
        //cout << "Cmd invalid." << endl;
        break;
    }
}

void CloseSnd(
    /* [out][in] */ CONTEXT_HANDLE_SND* phContext)
{
    //cout << "C++ CloseSnd : Context(" << *phContext << ")" << endl;
    *phContext = NULL;
}

// �N���C�A���g�ւ̐ڑ�������ꂽ�ꍇ�ARPC�����^�C���͂��̊֐����R�[��
void __RPC_USER CONTEXT_HANDLE_SND_rundown(CONTEXT_HANDLE_SND hContext)
{
    cout << "C++ CONTEXT_HANDLE_SND_rundown : Context(" << hContext << ")";
    CloseSnd(&hContext);
}