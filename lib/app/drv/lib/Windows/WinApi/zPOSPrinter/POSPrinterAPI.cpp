#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposPtr.h"
#include "POSPrinterAPI.h"

static POSPrinterControl& g_printer = Singleton<POSPrinterControl>::GetInstance();

// 排他制御ミューテックス
static mutex mtxCntRef;

int OpenPtrEvent(const char* filePath)
{
	HRESULT hr = g_printer.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0：成功, -1：失敗
}

int ClosePtrEvent()
{
	HRESULT hr = g_printer.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int OutRec(const wchar_t* textData, const wchar_t* bcData)
{
	HRESULT hr = g_printer.OutputReceipt(textData, bcData);
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int RegLogo(const char* filePath)
{
	HRESULT hr = g_printer.RegisterLogo(filePath);
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int InqStatCover()
{
	HRESULT hr = g_printer.InquireStatusCover();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int InqStatPaper()
{
	HRESULT hr = g_printer.InquireStatusPaper();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int GetStatCover()
{
	INT ret = -1;
	switch (g_printer._m_statCover)
	{
	case PTR_STAT_COVER_CLOSE:
		ret = 1;
		break;
	case PTR_STAT_COVER_OPEN:
		ret = 0;
		break;
	case PTR_STAT_NONE:
	default:
		break;
	}
	return ret;		// 0：カバー開, 1：カバー閉, else -1：ステータスエラー（非接続状態）
}

int GetStatPaper()
{
	INT ret = -1;
	switch (g_printer._m_statPaper)
	{
	case PTR_STAT_PAPER_EXIST:
	case PTR_STAT_PAPER_NEAREMPTY:
		ret = 1;
		break;
	case PTR_STAT_PAPER_EMPTY:
		ret = 0;
		break;
	case PTR_STAT_NONE:
	default:
		break;
	}
	return ret;		// 0：レシート用紙無し, 1：レシート用紙有り, else -1：ステータスエラー（非接続状態）
}

int GetPtrCntRef()
{
	lock_guard<mutex> lock(mtxCntRef);
	return g_printer.m_cRef;
}

void ReleasePtr()
{
	lock_guard<mutex> lock(mtxCntRef);
	g_printer.Release();
}

void PtrDebugLog()
{
	g_printer.PrinterDebugLog();
}