#pragma once

#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDebug.h"

class DebugControl final :
	public OposDebug
{
public:
	DebugControl();
	~DebugControl();

	VOID DebugLog(LPCSTR logName);
};