#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposPtr.h"
#include "POSPrinterAPI.h"

static POSPrinterControl& g_printer = Singleton<POSPrinterControl>::GetInstance();

// �r������~���[�e�b�N�X
static mutex mtxCntRef;

int OpenPtrEvent(const char* filePath)
{
	HRESULT hr = g_printer.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0�F����, -1�F���s
}

int ClosePtrEvent()
{
	HRESULT hr = g_printer.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int OutRec(const wchar_t* textData, const wchar_t* bcData)
{
	HRESULT hr = g_printer.OutputReceipt(textData, bcData);
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int RegLogo(const char* filePath)
{
	HRESULT hr = g_printer.RegisterLogo(filePath);
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int InqStatCover()
{
	HRESULT hr = g_printer.InquireStatusCover();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int InqStatPaper()
{
	HRESULT hr = g_printer.InquireStatusPaper();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
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
	return ret;		// 0�F�J�o�[�J, 1�F�J�o�[��, else -1�F�X�e�[�^�X�G���[�i��ڑ���ԁj
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
	return ret;		// 0�F���V�[�g�p������, 1�F���V�[�g�p���L��, else -1�F�X�e�[�^�X�G���[�i��ڑ���ԁj
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