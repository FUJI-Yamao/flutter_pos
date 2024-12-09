#pragma once

#include <windows.h>
#include <tchar.h>
#include <iostream>
#include "../Opos/Opos.h"

#ifdef DLL_EXPORTS
#define WINDOWS_API extern "C" __declspec(dllexport)
#else
#define WINDOWS_API extern "C" __declspec(dllimport)
#endif

#define BUFFER_WCHAR_SIZE(str) ((wcslen(str) + 1) * sizeof(wchar_t))	// +1‚ÍNULLI’[•¶Žš—p
#define SIZE_OF_ARRAY(arr) (sizeof(arr)/sizeof(arr[0]))
#define SAFE_RELEASE(x) if(x) x->Release();

using namespace std;