#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "ScannerAPI.h"

static ScannerControl& g_scanner = Singleton<ScannerControl>::GetInstance();

// 排他制御ミューテックス
static mutex mtxCntRef;

int OpenScn(const char* filePath)
{
	HRESULT hr = g_scanner.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0：正常終了, -1：異常終了
}

int CloseScn()
{
	HRESULT hr = g_scanner.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

const char* GetScanData()
{
	return g_scanner.m_scanData.c_str();
}

const char* GetScanType()
{
	return g_scanner.m_scanType.c_str();
}

const char* GetScanLabel()
{
	return g_scanner.m_scanLabel.c_str();
}

int GetScanCntRef()
{
	lock_guard<mutex> lock(mtxCntRef);
	return g_scanner.m_cRef;
}

void ReleaseScan()
{
	lock_guard<mutex> lock(mtxCntRef);
	g_scanner.Release();
}

void ScanDebugLog()
{
	g_scanner.ScannerDebugLog();
}