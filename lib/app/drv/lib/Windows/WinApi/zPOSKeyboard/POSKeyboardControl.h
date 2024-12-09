#pragma once

#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDebug.h"
#include "../OposSystem/Singleton.h"

//#ifdef _WIN64
//#include "../OposIf64/POSKeyboard.h"
//#else
//#include "../OposIf32/POSKeyboard.h"
//#endif

LRESULT CALLBACK LowLevelKbdProc(INT nCode, WPARAM wParam, LPARAM lParam);

class POSKeyboardControl final :
	public Singleton<POSKeyboardControl>,
	public OposDebug
{
public:
	struct KeyInfo
	{
		INT m_strokeStat;
		LPCSTR m_key;
		DWORD m_scanCode;
		DWORD m_vkCode;
	};

	VOID OpenPOSKeyboard();
	VOID ClosePOSKeyboard();
	VOID KeyboardDebugLog();

	KeyInfo keyInfo;

private:
	friend class Singleton<POSKeyboardControl>;
	POSKeyboardControl();
	~POSKeyboardControl();

	HHOOK m_hhKbd;
};