#include "mfcafx.h"
#include "CoDrw.h"

IMPLEMENT_DYNCREATE(CCoDrw, CWnd)

long CCoDrw::GetOpenResult()
{
	long result;
	InvokeHelper(0x31, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoDrw::GetCheckHealthText()
{
	CString result;
	InvokeHelper(0xd, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetClaimed()
{
	BOOL result;
	InvokeHelper(0xe, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetDeviceEnabled()
{
	BOOL result;
	InvokeHelper(0x11, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoDrw::SetDeviceEnabled(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x11, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoDrw::GetFreezeEvents()
{
	BOOL result;
	InvokeHelper(0x12, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoDrw::SetFreezeEvents(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x12, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoDrw::GetResultCode()
{
	long result;
	InvokeHelper(0x16, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoDrw::GetResultCodeExtended()
{
	long result;
	InvokeHelper(0x17, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoDrw::GetState()
{
	long result;
	InvokeHelper(0x18, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoDrw::GetControlObjectDescription()
{
	CString result;
	InvokeHelper(0x19, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoDrw::GetControlObjectVersion()
{
	long result;
	InvokeHelper(0x1a, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoDrw::GetServiceObjectDescription()
{
	CString result;
	InvokeHelper(0x1b, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoDrw::GetServiceObjectVersion()
{
	long result;
	InvokeHelper(0x1c, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoDrw::GetDeviceDescription()
{
	CString result;
	InvokeHelper(0x1d, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoDrw::GetDeviceName()
{
	CString result;
	InvokeHelper(0x1e, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoDrw::CheckHealth(long Level)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x1f, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Level);
	return result;
}

long CCoDrw::ClaimDevice(long Timeout)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x20, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Timeout);
	return result;
}

long CCoDrw::Close()
{
	long result;
	InvokeHelper(0x23, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoDrw::DirectIO(long Command, long* pData, BSTR* pString)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_PI4 VTS_PBSTR;
	InvokeHelper(0x24, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Command, pData, pString);
	return result;
}

long CCoDrw::Open(LPCTSTR DeviceName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x25, DISPATCH_METHOD, VT_I8, (void*)&result, parms, DeviceName);
	return result;
}

long CCoDrw::ReleaseDevice()
{
	long result;
	InvokeHelper(0x26, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetCapStatus()
{
	BOOL result;
	InvokeHelper(0x32, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetDrawerOpened()
{
	BOOL result;
	InvokeHelper(0x33, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoDrw::OpenDrawer()
{
	long result;
	InvokeHelper(0x3c, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoDrw::WaitForDrawerClose(long BeepTimeout, long BeepFrequency, long BeepDuration, long BeepDelay)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_I4 VTS_I4 VTS_I4;
	InvokeHelper(0x3d, DISPATCH_METHOD, VT_I8, (void*)&result, parms, BeepTimeout, BeepFrequency, BeepDuration, BeepDelay);
	return result;
}

long CCoDrw::GetBinaryConversion()
{
	long result;
	InvokeHelper(0xb, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

void CCoDrw::SetBinaryConversion(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xb, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoDrw::GetCapPowerReporting()
{
	long result;
	InvokeHelper(0xc, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoDrw::GetPowerNotify()
{
	long result;
	InvokeHelper(0x14, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

void CCoDrw::SetPowerNotify(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x14, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoDrw::GetPowerState()
{
	long result;
	InvokeHelper(0x15, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetCapStatusMultiDrawerDetect()
{
	BOOL result;
	InvokeHelper(0x34, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetCapStatisticsReporting()
{
	BOOL result;
	InvokeHelper(0x27, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetCapUpdateStatistics()
{
	BOOL result;
	InvokeHelper(0x28, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoDrw::ResetStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x29, DISPATCH_METHOD, VT_I8, (void*)&result, parms, StatisticsBuffer);
	return result;
}

long CCoDrw::RetrieveStatistics(BSTR* pStatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_PBSTR;
	InvokeHelper(0x2a, DISPATCH_METHOD, VT_I8, (void*)&result, parms, pStatisticsBuffer);
	return result;
}

long CCoDrw::UpdateStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2b, DISPATCH_METHOD, VT_I8, (void*)&result, parms, StatisticsBuffer);
	return result;
}

BOOL CCoDrw::GetCapCompareFirmwareVersion()
{
	BOOL result;
	InvokeHelper(0x2c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoDrw::GetCapUpdateFirmware()
{
	BOOL result;
	InvokeHelper(0x2d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoDrw::CompareFirmwareVersion(LPCTSTR FirmwareFileName, long* pResult)
{
	long result;
	static BYTE parms[] = VTS_BSTR VTS_PI4;
	InvokeHelper(0x2e, DISPATCH_METHOD, VT_I8, (void*)&result, parms, FirmwareFileName, pResult);
	return result;
}

long CCoDrw::UpdateFirmware(LPCTSTR FirmwareFileName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2f, DISPATCH_METHOD, VT_I8, (void*)&result, parms, FirmwareFileName);
	return result;
}