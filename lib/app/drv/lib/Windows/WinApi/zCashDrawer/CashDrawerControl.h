#pragma once

#include "../OposSystem/TaskManager.h"
#include "../OposSystem/OposDebug.h"
#include "RpcManager.h"

//#ifdef _WIN64
//#include "../OposIf64/CashDrawer.h"
//#else
//#include "../OposIf32/CashDrawer.h"
//#endif

class CashDrawerControl final :
	public Singleton<CashDrawerControl>,
	public OposDebug
{
public:
	HRESULT OnInit(const string& filePath);
	HRESULT OnDestroy();
	HRESULT OpenPortDrawer(const string& filePath);
	HRESULT ClosePortDrawer();
    HRESULT DrawerOpen();
	HRESULT InquireDrawerOpened();
	ULONG AddRef();
	ULONG Release();
	VOID SetDrwStat(DWORD drwStat);
	VOID DrawerDebugLog();

	DWORD GetCreateDIOPortProcessId();
	DWORD GetRealDIOPortProcessId();

	ULONG m_cRef;
	DWORD _m_drwStat;

	unique_ptr<RpcManager> m_rpc;

private:
	friend class Singleton<CashDrawerControl>;
	CashDrawerControl();
	~CashDrawerControl();

	unique_ptr<TaskManager> m_taskDrawer;
	unique_ptr<TaskManager> m_taskDIOPort;

	DRW_DATA_SND m_dDataSnd;
};

inline DWORD CashDrawerControl::GetCreateDIOPortProcessId()
{
	if (TRUE == m_taskDIOPort->_m_bExecuted)
	{
		return m_taskDIOPort->GetProcessInfo().dwProcessId;
	}

	return NO_PROCESS;
}

inline DWORD CashDrawerControl::GetRealDIOPortProcessId()
{
	if (TRUE == m_taskDIOPort->_m_bExecuted)
	{
		return m_taskDIOPort->GetProcessIdByName();
	}

	return NO_PROCESS;
}

inline ULONG CashDrawerControl::AddRef()
{
	InterlockedIncrement(&m_cRef);
	return m_cRef;
}

inline ULONG CashDrawerControl::Release()
{
	m_cRef = 0;
	return m_cRef;
}

inline VOID CashDrawerControl::SetDrwStat(DWORD drwStat)
{
	_m_drwStat = drwStat;
}