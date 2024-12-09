#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../COpos/COposDrw.h"
#include "CashDrawerAPI.h"

static CashDrawerControl& g_drawer = Singleton<CashDrawerControl>::GetInstance();

// �r������~���[�e�b�N�X
static mutex mtxCntRef;

int OpenDrwEvent(const char* filePath)
{
	HRESULT hr = g_drawer.OnInit(filePath);
	return S_OK == hr ? 0 : -1;							// 0�F����, -1�F���s
}

int CloseDrwEvent()
{
	HRESULT hr = g_drawer.OnDestroy();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int OpenDrwDIOPort(const char* filePath)
{
	// �h���ADIO-RW�v���O����
	HRESULT hr = g_drawer.OpenPortDrawer(filePath);
	return S_OK == hr ? 0 : -1;							// 0�F����, -1�F���s
}

int CloseDrwDIOPort()
{
	HRESULT hr = g_drawer.ClosePortDrawer();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int OpenDrw()
{
	HRESULT hr = g_drawer.DrawerOpen();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
}

int InqDrwOpened()
{
	HRESULT hr = g_drawer.InquireDrawerOpened();
	return S_OK == hr ? 0 : S_FALSE == hr ? -1 : -2;	// 0�F����I��, -1�F�ُ�I��, else -2�F�s���ȃG���[
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
	return ret;		// 0�F�J, 1�F��, else -1�F�X�e�[�^�X�G���[�i��ڑ���ԁj
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