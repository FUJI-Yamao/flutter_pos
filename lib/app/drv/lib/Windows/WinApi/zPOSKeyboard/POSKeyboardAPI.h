#pragma once

#include "../OposSystem/stdafx.h"
#include "POSKeyboardControl.h"

WINDOWS_API void OpenMkey();
WINDOWS_API void CloseMkey();
WINDOWS_API const char* GetKey();
WINDOWS_API int GetStrokeStat();
void KbdDebugLog();