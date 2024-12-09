#pragma once

#include "../OposSystem/stdafx.h"
#include "ScannerControl.h"

WINDOWS_API int OpenScn(const char* filePath);
WINDOWS_API int CloseScn();
WINDOWS_API const char* GetScanData();
WINDOWS_API const char* GetScanType();
WINDOWS_API const char* GetScanLabel();
WINDOWS_API int GetScanCntRef();
WINDOWS_API void ReleaseScan();
void ScanDebugLog();