#pragma once

#include <tlhelp32.h>
#include "Singleton.h"

// ÉvÉçÉZÉXIDÇ»Çµ
#define NO_PROCESS -1

class TaskManager
{
public:
	TaskManager();
	virtual ~TaskManager();

	DWORD GetProcessIdByName();
	HRESULT StartTask();
	HRESULT EndTask();
	PROCESS_INFORMATION GetProcessInfo();

	BOOL _m_bExecuted;
	LPCSTR _m_filePath;
	string _m_exeName;

private:
	STARTUPINFO m_startupInfo;
	PROCESS_INFORMATION m_processInfo;
};

inline PROCESS_INFORMATION TaskManager::GetProcessInfo()
{
	return m_processInfo;
}