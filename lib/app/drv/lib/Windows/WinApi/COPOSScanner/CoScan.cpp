#include "mfcafx.h"
#include "CoScan.h"

IMPLEMENT_DYNCREATE(CCoScan, CWnd)

long CCoScan::GetOpenResult()
{
	long result;
	InvokeHelper(0x31, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetCheckHealthText()
{
	CString result;
	InvokeHelper(0xd, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetClaimed()
{
	BOOL result;
	InvokeHelper(0xe, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetDataEventEnabled()
{
	BOOL result;
	InvokeHelper(0x10, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoScan::SetDataEventEnabled(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x10, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoScan::GetDeviceEnabled()
{
	BOOL result;
	InvokeHelper(0x11, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoScan::SetDeviceEnabled(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x11, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoScan::GetFreezeEvents()
{
	BOOL result;
	InvokeHelper(0x12, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoScan::SetFreezeEvents(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x12, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoScan::GetResultCode()
{
	long result;
	InvokeHelper(0x16, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::GetResultCodeExtended()
{
	long result;
	InvokeHelper(0x17, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::GetState()
{
	long result;
	InvokeHelper(0x18, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetControlObjectDescription()
{
	CString result;
	InvokeHelper(0x19, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoScan::GetControlObjectVersion()
{
	long result;
	InvokeHelper(0x1a, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetServiceObjectDescription()
{
	CString result;
	InvokeHelper(0x1b, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoScan::GetServiceObjectVersion()
{
	long result;
	InvokeHelper(0x1c, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetDeviceDescription()
{
	CString result;
	InvokeHelper(0x1d, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetDeviceName()
{
	CString result;
	InvokeHelper(0x1e, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoScan::CheckHealth(long Level)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x1f, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Level);
	return result;
}

long CCoScan::ClaimDevice(long Timeout)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x20, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Timeout);
	return result;
}

long CCoScan::ClearInput()
{
	long result;
	InvokeHelper(0x21, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::Close()
{
	long result;
	InvokeHelper(0x23, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::DirectIO(long Command, long* pData, BSTR* pString)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_PI4 VTS_PBSTR;
	InvokeHelper(0x24, DISPATCH_METHOD, VT_I8, (void*)&result, parms, Command, pData, pString);
	return result;
}

long CCoScan::Open(LPCTSTR DeviceName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x25, DISPATCH_METHOD, VT_I8, (void*)&result, parms, DeviceName);
	return result;
}

long CCoScan::ReleaseDevice()
{
	long result;
	InvokeHelper(0x26, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}

CString CCoScan::GetScanData()
{
	CString result;
	InvokeHelper(0x33, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetAutoDisable()
{
	BOOL result;
	InvokeHelper(0xa, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoScan::SetAutoDisable(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0xa, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoScan::GetBinaryConversion()
{
	long result;
	InvokeHelper(0xb, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

void CCoScan::SetBinaryConversion(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xb, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoScan::GetDataCount()
{
	long result;
	InvokeHelper(0xf, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetDecodeData()
{
	BOOL result;
	InvokeHelper(0x32, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoScan::SetDecodeData(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x32, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

CString CCoScan::GetScanDataLabel()
{
	CString result;
	InvokeHelper(0x34, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoScan::GetScanDataType()
{
	long result;
	InvokeHelper(0x35, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::GetCapPowerReporting()
{
	long result;
	InvokeHelper(0xc, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

long CCoScan::GetPowerNotify()
{
	long result;
	InvokeHelper(0x14, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

void CCoScan::SetPowerNotify(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x14, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoScan::GetPowerState()
{
	long result;
	InvokeHelper(0x15, DISPATCH_PROPERTYGET, VT_I8, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetCapStatisticsReporting()
{
	BOOL result;
	InvokeHelper(0x27, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetCapUpdateStatistics()
{
	BOOL result;
	InvokeHelper(0x28, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoScan::ResetStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x29, DISPATCH_METHOD, VT_I8, (void*)&result, parms, StatisticsBuffer);
	return result;
}

long CCoScan::RetrieveStatistics(BSTR* pStatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_PBSTR;
	InvokeHelper(0x2a, DISPATCH_METHOD, VT_I8, (void*)&result, parms, pStatisticsBuffer);
	return result;
}

long CCoScan::UpdateStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2b, DISPATCH_METHOD, VT_I8, (void*)&result, parms, StatisticsBuffer);
	return result;
}

BOOL CCoScan::GetCapCompareFirmwareVersion()
{
	BOOL result;
	InvokeHelper(0x2c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoScan::GetCapUpdateFirmware()
{
	BOOL result;
	InvokeHelper(0x2d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoScan::CompareFirmwareVersion(LPCTSTR FirmwareFileName, long* pResult)
{
	long result;
	static BYTE parms[] = VTS_BSTR VTS_PI4;
	InvokeHelper(0x2e, DISPATCH_METHOD, VT_I8, (void*)&result, parms, FirmwareFileName, pResult);
	return result;
}

long CCoScan::UpdateFirmware(LPCTSTR FirmwareFileName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2f, DISPATCH_METHOD, VT_I8, (void*)&result, parms, FirmwareFileName);
	return result;
}

long CCoScan::ClearInputProperties()
{
	long result;
	InvokeHelper(0x30, DISPATCH_METHOD, VT_I8, (void*)&result, NULL);
	return result;
}