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
    case PTR_CMD_REC_OUTPUT:        // レシート出力
        OnOutputReceipt(*pTextData, *pBcData);
        break;
    case PTR_CMD_LOGO_REG:          // レシートロゴ登録
        OnRegisterLogo(*pLogoPath);
        break;
    case PTR_CMD_GET_STAT_COVER:    // プリンタカバー開閉状態送信
        OnGetStatCover();
        break;
    case PTR_CMD_GET_STAT_PAPER:    // レシート用紙有無状態送信
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

// クライアントへの接続が失われた場合、RPCランタイムはこの関数をコール
void __RPC_USER CONTEXT_HANDLE_SND_rundown(CONTEXT_HANDLE_SND hContext)
{
    cout << "C++ CONTEXT_HANDLE_SND_rundown : Context(" << hContext << ")";
    CloseSnd(&hContext);
}