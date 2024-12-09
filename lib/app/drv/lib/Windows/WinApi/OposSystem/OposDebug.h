#pragma once

#include <map>
#include <list>

#define RESULT_CODE_MAX 18	// Opos.h > OPOS "ResultCode" Property Constants

// OposIfアクセス用返り値照合リスト
const map<LONG, LPCSTR> resCodeMap =
{
	{ OPOS_SUCCESS, "OPOS_SUCCESS" },
	{ OPOS_E_CLOSED, "OPOS_E_CLOSED" },
	{ OPOS_E_CLAIMED, "OPOS_E_CLAIMED" },
	{ OPOS_E_NOTCLAIMED, "OPOS_E_NOTCLAIMED" },
	{ OPOS_E_NOSERVICE, "OPOS_E_NOSERVICE" },
	{ OPOS_E_DISABLED, "OPOS_E_DISABLED" },
	{ OPOS_E_ILLEGAL, "OPOS_E_ILLEGAL" },
	{ OPOS_E_NOHARDWARE, "OPOS_E_NOHARDWARE" },
	{ OPOS_E_OFFLINE, "OPOS_E_OFFLINE" },
	{ OPOS_E_NOEXIST, "OPOS_E_NOEXIST" },
	{ OPOS_E_EXISTS, "OPOS_E_EXISTS" },
	{ OPOS_E_FAILURE, "OPOS_E_FAILURE" },
	{ OPOS_E_TIMEOUT, "OPOS_E_TIMEOUT" },
	{ OPOS_E_BUSY, "OPOS_E_BUSY" },
	{ OPOS_E_EXTENDED, "OPOS_E_EXTENDED" },
	{ OPOS_E_DEPRECATED, "OPOS_E_DEPRECATED" },
	{ OPOSERR, "OPOSERR" },
	{ OPOSERREXT, "OPOSERREXT" },
};

class OposDebug
{
public:
	struct DebugInfo
	{
		LPCSTR m_label;
		LONG m_resCode;
		LPCSTR m_resCodeString;
	};

	OposDebug();
	virtual ~OposDebug();

	VOID SetDebugInfo(LPCSTR label, LONG resCode);
	VOID SetResCodeStrings();
	
	list<OposDebug::DebugInfo> GetResCodes() const;

protected:
	list<DebugInfo> m_debugInfoList;
};

inline VOID OposDebug::SetDebugInfo(LPCSTR label, LONG resCode)
{
	DebugInfo debugInfo;
	debugInfo.m_label = label;
	debugInfo.m_resCode = resCode;
	m_debugInfoList.push_back(debugInfo);
}

inline list<OposDebug::DebugInfo> OposDebug::GetResCodes() const
{
	return m_debugInfoList;
}