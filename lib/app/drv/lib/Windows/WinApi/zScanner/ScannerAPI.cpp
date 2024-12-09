#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "ScannerAPI.h"

static ScannerControl& g_scanner = Singleton<ScannerControl>::GetInstance();

// �r������~���[�e�b�N�X
static mutex mtxCntRef;

int OpenScn(const char* filePath)
{
	HRESULT hr = g_scanner.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0�F����I��, -1�F�ُ�I��
}

int CloseScn()
{
	HRESULT hr = g_scanner.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
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