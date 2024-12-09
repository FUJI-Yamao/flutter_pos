#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposDrw.h"
#include "CashDrawerAPI.h"

static CashDrawerControl& g_drawer = Singleton<CashDrawerControl>::GetInstance();

// 排他制御ミューテックス
static mutex mtxCntRef;

int OpenDrwEvent(const char* filePath)
{
	HRESULT hr = g_drawer.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0：成功, -1：失敗
}

int CloseDrwEvent()
{
	HRESULT hr = g_drawer.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int OpenDrwDIOPort(const char* filePath)
{
	// ドロアDIO-RWプログラム
	HRESULT hr = g_drawer.OpenPortDrawer(filePath);
	return S_OK == hr ? 0 : -1;							// 0：成功, -1：失敗
}

int CloseDrwDIOPort()
{
	HRESULT hr = g_drawer.ClosePortDrawer();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int OpenDrw()
{
	HRESULT hr = g_drawer.DrawerOpen();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int InqDrwOpened()
{
	HRESULT hr = g_drawer.InquireDrawerOpened();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0：正常終了, -1：異常終了, else -2：不明なエラー
}

int GetDrwStat()
{
	INT ret = -1;
	switch (g_drawer._m_drwStat)
	{
	case DRW_STAT_CLOSE:
		ret = 1;
		break;
	case DRW_STAT_OPEN:
		ret = 0;
		break;
	case DRW_SUE_POWER_ONLINE:
	case DRW_SUE_POWER_OFF:
	case DRW_SUE_POWER_OFFLINE:
	case DRW_SUE_POWER_OFF_OFFLINE:
	default:
		break;
	}
	return ret;		// 0：開, 1：閉, else -1：ステータスエラー（非接続状態）
}

int GetDrwCntRef()
{
	lock_guard<mutex> lock(mtxCntRef);
	return g_drawer.m_cRef;
}

void ReleaseDrw()
{
	lock_guard<mutex> lock(mtxCntRef);
	g_drawer.Release();
}

unsigned long GetCreDIOPortProcId()
{
	return g_drawer.GetCreateDIOPortProcessId();
}

unsigned long GetRealDIOPortProcId()
{
	return g_drawer.GetRealDIOPortProcessId();
}

void DrwDebugLog()
{
	g_drawer.DrawerDebugLog();
}