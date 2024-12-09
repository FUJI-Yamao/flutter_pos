#pragma once

#include "POSPrinterControl.h"

WINDOWS_API int OpenPtrEvent(const char* filePath);
WINDOWS_API int ClosePtrEvent();
WINDOWS_API int OutRec(const wchar_t* textData, const wchar_t* bcData);
WINDOWS_API int RegLogo(const char* filePath);
WINDOWS_API int InqStatCover();
WINDOWS_API int InqStatPaper();
WINDOWS_API int GetStatCover();
WINDOWS_API int GetStatPaper();
WINDOWS_API int GetPtrCntRef();
WINDOWS_API void ReleasePtr();
void PtrDebugLog();