#pragma once

#include "CashDrawerControl.h"

WINDOWS_API int OpenDrwEvent(const char* filePath);
WINDOWS_API int CloseDrwEvent();
WINDOWS_API int OpenDrwDIOPort(const char* filePath);
WINDOWS_API int CloseDrwDIOPort();
WINDOWS_API int OpenDrw();
WINDOWS_API int InqDrwOpened();
WINDOWS_API int GetDrwStat();
WINDOWS_API int GetDrwCntRef();
WINDOWS_API void ReleaseDrw();
unsigned long GetCreDIOPortProcId();
unsigned long GetRealDIOPortProcId();
void DrwDebugLog();