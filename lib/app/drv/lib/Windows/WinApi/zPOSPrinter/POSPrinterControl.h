#pragma once

#include "../OposSystem/TaskManager.h"
#include "../OposSystem/OposDebug.h"
#include "RpcManager.h"

//#ifdef _WIN64
//#include "../OposIf64/POSPrinter.h"
//#else
//#include "../OposIf32/POSPrinter.h"
//#endif

class POSPrinterControl final :
	public Singleton<POSPrinterControl>,
	public OposDebug
{
public:
	HRESULT OnInit(const string& filePath);
	HRESULT OnDestroy();
    HRESULT OutputReceipt(LPCWSTR& textData, LPCWSTR& bcData);
	HRESULT RegisterLogo(LPCSTR& filePath);
	HRESULT InquireStatusCover();
	HRESULT InquireStatusPaper();
	ULONG AddRef();
	ULONG Release();
	VOID SetStatusCover(DWORD statCover);
	VOID SetStatusPaper(DWORD statPaper);
	VOID PrinterDebugLog();

	ULONG m_cRef;
	DWORD _m_statCover;
	DWORD _m_statPaper;

	unique_ptr<RpcManager> m_rpc;

private:
	friend class Singleton<POSPrinterControl>;
	POSPrinterControl();
	~POSPrinterControl();

	unique_ptr<TaskManager> m_taskPrinter;

	PTR_DATA_SND m_pDataSnd;
};

inline ULONG POSPrinterControl::AddRef()
{
	InterlockedIncrement(&m_cRef);
	return m_cRef;
}

inline ULONG POSPrinterControl::Release()
{
	m_cRef = 0;
	return m_cRef;
}

inline VOID POSPrinterControl::SetStatusCover(DWORD statCover)
{
	_m_statCover = statCover;
}

inline VOID POSPrinterControl::SetStatusPaper(DWORD statPaper)
{
	_m_statPaper = statPaper;
}