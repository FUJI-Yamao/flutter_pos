#pragma once

#include "../OposSystem/stdafx.h"
#include "../OposSystem/TaskManager.h"
#include "../OposSystem/OposDebug.h"
#include "RpcManager.h"

//#ifdef _WIN64
//#include "../OposIf64/Scanner.h"
//#else
//#include "../OposIf32/Scanner.h"
//#endif

class ScannerControl final :
	public Singleton<ScannerControl>,
	public OposDebug,
	private TaskManager
{
public:
	HRESULT OnInit(const string& filePath);
	HRESULT OnDestroy();
	ULONG AddRef();
	ULONG Release();
	VOID SetScanData(string scanData);
	VOID SetScanType(string scanType);
	VOID SetScanLabel(string scanLabel);
	VOID ScannerDebugLog();

	ULONG m_cRef;
	string m_scanData;
	string m_scanType;
	string m_scanLabel;

private:
	friend class Singleton<ScannerControl>;
	ScannerControl();
	~ScannerControl();

	unique_ptr<RpcManager> m_rpc;
};

inline ULONG ScannerControl::AddRef()
{
	InterlockedIncrement(&m_cRef);
	return m_cRef;
}

inline ULONG ScannerControl::Release()
{
	m_cRef = 0;
	return m_cRef;
}

inline VOID ScannerControl::SetScanData(string scanData)
{
	m_scanData = scanData;
}

inline VOID ScannerControl::SetScanType(string scanType)
{
	m_scanType = scanType;
}

inline VOID ScannerControl::SetScanLabel(string scanLabel)
{
	m_scanLabel = scanLabel;
}