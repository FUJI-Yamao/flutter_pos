#include "mfcafx.h"
#include "CoPtr.h"

IMPLEMENT_DYNCREATE(CCoPtr, CWnd)

long CCoPtr::GetOpenResult()
{
	long result;
	InvokeHelper(0x31, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetCheckHealthText()
{
	CString result;
	InvokeHelper(0xd, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetClaimed()
{
	BOOL result;
	InvokeHelper(0xe, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetDeviceEnabled()
{
	BOOL result;
	InvokeHelper(0x11, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetDeviceEnabled(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x11, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoPtr::GetFreezeEvents()
{
	BOOL result;
	InvokeHelper(0x12, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetFreezeEvents(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x12, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoPtr::GetOutputID()
{
	long result;
	InvokeHelper(0x13, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetResultCode()
{
	long result;
	InvokeHelper(0x16, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetResultCodeExtended()
{
	long result;
	InvokeHelper(0x17, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetState()
{
	long result;
	InvokeHelper(0x18, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetControlObjectDescription()
{
	CString result;
	InvokeHelper(0x19, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetControlObjectVersion()
{
	long result;
	InvokeHelper(0x1a, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetServiceObjectDescription()
{
	CString result;
	InvokeHelper(0x1b, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetServiceObjectVersion()
{
	long result;
	InvokeHelper(0x1c, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetDeviceDescription()
{
	CString result;
	InvokeHelper(0x1d, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetDeviceName()
{
	CString result;
	InvokeHelper(0x1e, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::CheckHealth(long Level)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x1f, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Level);
	return result;
}

long CCoPtr::ClaimDevice(long Timeout)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x20, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Timeout);
	return result;
}

long CCoPtr::ClearOutput()
{
	long result;
	InvokeHelper(0x22, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::Close()
{
	long result;
	InvokeHelper(0x23, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::DirectIO(long Command, long* pData, BSTR* pString)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_PI4 VTS_PBSTR;
	InvokeHelper(0x24, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Command, pData, pString);
	return result;
}

long CCoPtr::Open(LPCTSTR DeviceName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x25, DISPATCH_METHOD, VT_I4, (void*)&result, parms, DeviceName);
	return result;
}

long CCoPtr::ReleaseDevice()
{
	long result;
	InvokeHelper(0x26, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetAsyncMode()
{
	BOOL result;
	InvokeHelper(0x32, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetAsyncMode(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x32, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoPtr::GetCapConcurrentJrnRec()
{
	BOOL result;
	InvokeHelper(0x34, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapConcurrentJrnSlp()
{
	BOOL result;
	InvokeHelper(0x35, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapConcurrentRecSlp()
{
	BOOL result;
	InvokeHelper(0x36, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapCoverSensor()
{
	BOOL result;
	InvokeHelper(0x37, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrn2Color()
{
	BOOL result;
	InvokeHelper(0x38, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnBold()
{
	BOOL result;
	InvokeHelper(0x39, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnDhigh()
{
	BOOL result;
	InvokeHelper(0x3a, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnDwide()
{
	BOOL result;
	InvokeHelper(0x3b, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnDwideDhigh()
{
	BOOL result;
	InvokeHelper(0x3c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnEmptySensor()
{
	BOOL result;
	InvokeHelper(0x3d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnItalic()
{
	BOOL result;
	InvokeHelper(0x3e, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnNearEndSensor()
{
	BOOL result;
	InvokeHelper(0x3f, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnPresent()
{
	BOOL result;
	InvokeHelper(0x40, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapJrnUnderline()
{
	BOOL result;
	InvokeHelper(0x41, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRec2Color()
{
	BOOL result;
	InvokeHelper(0x42, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecBarCode()
{
	BOOL result;
	InvokeHelper(0x43, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecBitmap()
{
	BOOL result;
	InvokeHelper(0x44, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecBold()
{
	BOOL result;
	InvokeHelper(0x45, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecDhigh()
{
	BOOL result;
	InvokeHelper(0x46, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecDwide()
{
	BOOL result;
	InvokeHelper(0x47, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecDwideDhigh()
{
	BOOL result;
	InvokeHelper(0x48, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecEmptySensor()
{
	BOOL result;
	InvokeHelper(0x49, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecItalic()
{
	BOOL result;
	InvokeHelper(0x4a, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecLeft90()
{
	BOOL result;
	InvokeHelper(0x4b, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecNearEndSensor()
{
	BOOL result;
	InvokeHelper(0x4c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecPapercut()
{
	BOOL result;
	InvokeHelper(0x4d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecPresent()
{
	BOOL result;
	InvokeHelper(0x4e, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecRight90()
{
	BOOL result;
	InvokeHelper(0x4f, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecRotate180()
{
	BOOL result;
	InvokeHelper(0x50, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecStamp()
{
	BOOL result;
	InvokeHelper(0x51, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecUnderline()
{
	BOOL result;
	InvokeHelper(0x52, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlp2Color()
{
	BOOL result;
	InvokeHelper(0x53, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpBarCode()
{
	BOOL result;
	InvokeHelper(0x54, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpBitmap()
{
	BOOL result;
	InvokeHelper(0x55, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpBold()
{
	BOOL result;
	InvokeHelper(0x56, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpDhigh()
{
	BOOL result;
	InvokeHelper(0x57, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpDwide()
{
	BOOL result;
	InvokeHelper(0x58, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpDwideDhigh()
{
	BOOL result;
	InvokeHelper(0x59, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpEmptySensor()
{
	BOOL result;
	InvokeHelper(0x5a, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpFullslip()
{
	BOOL result;
	InvokeHelper(0x5b, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpItalic()
{
	BOOL result;
	InvokeHelper(0x5c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpLeft90()
{
	BOOL result;
	InvokeHelper(0x5d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpNearEndSensor()
{
	BOOL result;
	InvokeHelper(0x5e, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpPresent()
{
	BOOL result;
	InvokeHelper(0x5f, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpRight90()
{
	BOOL result;
	InvokeHelper(0x60, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpRotate180()
{
	BOOL result;
	InvokeHelper(0x61, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpUnderline()
{
	BOOL result;
	InvokeHelper(0x62, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCharacterSet()
{
	long result;
	InvokeHelper(0x64, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetCharacterSet(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x64, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetCharacterSetList()
{
	CString result;
	InvokeHelper(0x65, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCoverOpen()
{
	BOOL result;
	InvokeHelper(0x66, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetErrorStation()
{
	long result;
	InvokeHelper(0x68, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetFlagWhenIdle()
{
	BOOL result;
	InvokeHelper(0x6a, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetFlagWhenIdle(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x6a, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

BOOL CCoPtr::GetJrnEmpty()
{
	BOOL result;
	InvokeHelper(0x6c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetJrnLetterQuality()
{
	BOOL result;
	InvokeHelper(0x6d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetJrnLetterQuality(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x6d, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoPtr::GetJrnLineChars()
{
	long result;
	InvokeHelper(0x6e, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetJrnLineChars(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x6e, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetJrnLineCharsList()
{
	CString result;
	InvokeHelper(0x6f, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetJrnLineHeight()
{
	long result;
	InvokeHelper(0x70, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetJrnLineHeight(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x70, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetJrnLineSpacing()
{
	long result;
	InvokeHelper(0x71, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetJrnLineSpacing(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x71, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetJrnLineWidth()
{
	long result;
	InvokeHelper(0x72, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetJrnNearEnd()
{
	BOOL result;
	InvokeHelper(0x73, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetMapMode()
{
	long result;
	InvokeHelper(0x74, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetMapMode(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x74, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

BOOL CCoPtr::GetRecEmpty()
{
	BOOL result;
	InvokeHelper(0x76, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetRecLetterQuality()
{
	BOOL result;
	InvokeHelper(0x77, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRecLetterQuality(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x77, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoPtr::GetRecLineChars()
{
	long result;
	InvokeHelper(0x78, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRecLineChars(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x78, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetRecLineCharsList()
{
	CString result;
	InvokeHelper(0x79, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRecLineHeight()
{
	long result;
	InvokeHelper(0x7a, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRecLineHeight(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x7a, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetRecLineSpacing()
{
	long result;
	InvokeHelper(0x7b, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRecLineSpacing(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x7b, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetRecLinesToPaperCut()
{
	long result;
	InvokeHelper(0x7c, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRecLineWidth()
{
	long result;
	InvokeHelper(0x7d, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetRecNearEnd()
{
	BOOL result;
	InvokeHelper(0x7e, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRecSidewaysMaxChars()
{
	long result;
	InvokeHelper(0x7f, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRecSidewaysMaxLines()
{
	long result;
	InvokeHelper(0x80, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetSlpEmpty()
{
	BOOL result;
	InvokeHelper(0x83, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetSlpLetterQuality()
{
	BOOL result;
	InvokeHelper(0x84, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetSlpLetterQuality(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0x84, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

long CCoPtr::GetSlpLineChars()
{
	long result;
	InvokeHelper(0x85, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetSlpLineChars(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x85, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetSlpLineCharsList()
{
	CString result;
	InvokeHelper(0x86, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpLineHeight()
{
	long result;
	InvokeHelper(0x87, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetSlpLineHeight(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x87, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetSlpLinesNearEndToEnd()
{
	long result;
	InvokeHelper(0x88, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpLineSpacing()
{
	long result;
	InvokeHelper(0x89, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetSlpLineSpacing(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x89, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetSlpLineWidth()
{
	long result;
	InvokeHelper(0x8a, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpMaxLines()
{
	long result;
	InvokeHelper(0x8b, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetSlpNearEnd()
{
	BOOL result;
	InvokeHelper(0x8c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpSidewaysMaxChars()
{
	long result;
	InvokeHelper(0x8d, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpSidewaysMaxLines()
{
	long result;
	InvokeHelper(0x8e, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::BeginInsertion(long Timeout)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xa0, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Timeout);
	return result;
}

long CCoPtr::BeginRemoval(long Timeout)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xa1, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Timeout);
	return result;
}

long CCoPtr::CutPaper(long Percentage)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xa2, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Percentage);
	return result;
}

long CCoPtr::EndInsertion()
{
	long result;
	InvokeHelper(0xa3, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::EndRemoval()
{
	long result;
	InvokeHelper(0xa4, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::PrintBarCode(long Station, LPCTSTR Data, long Symbology, long Height, long Width, long Alignment, long TextPosition)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR VTS_I4 VTS_I4 VTS_I4 VTS_I4 VTS_I4;
	InvokeHelper(0xa5, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Data, Symbology, Height, Width, Alignment, TextPosition);
	return result;
}

long CCoPtr::PrintBitmap(long Station, LPCTSTR FileName, long Width, long Alignment)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR VTS_I4 VTS_I4;
	InvokeHelper(0xa6, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, FileName, Width, Alignment);
	return result;
}

long CCoPtr::PrintImmediate(long Station, LPCTSTR Data)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR;
	InvokeHelper(0xa7, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Data);
	return result;
}

long CCoPtr::PrintNormal(long Station, LPCTSTR Data)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR;
	InvokeHelper(0xa8, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Data);
	return result;
}

long CCoPtr::PrintTwoNormal(long Stations, LPCTSTR Data1, LPCTSTR Data2)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR VTS_BSTR;
	InvokeHelper(0xa9, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Stations, Data1, Data2);
	return result;
}

long CCoPtr::RotatePrint(long Station, long Rotation)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_I4;
	InvokeHelper(0xaa, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Rotation);
	return result;
}

long CCoPtr::SetBitmap(long BitmapNumber, long Station, LPCTSTR FileName, long Width, long Alignment)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_I4 VTS_BSTR VTS_I4 VTS_I4;
	InvokeHelper(0xab, DISPATCH_METHOD, VT_I4, (void*)&result, parms, BitmapNumber, Station, FileName, Width, Alignment);
	return result;
}

long CCoPtr::SetLogo(long Location, LPCTSTR Data)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR;
	InvokeHelper(0xac, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Location, Data);
	return result;
}

long CCoPtr::GetCapCharacterSet()
{
	long result;
	InvokeHelper(0x33, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapTransaction()
{
	BOOL result;
	InvokeHelper(0x63, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetErrorLevel()
{
	long result;
	InvokeHelper(0x67, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetErrorString()
{
	CString result;
	InvokeHelper(0x69, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetFontTypefaceList()
{
	CString result;
	InvokeHelper(0x6b, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetRecBarCodeRotationList()
{
	CString result;
	InvokeHelper(0x75, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRotateSpecial()
{
	long result;
	InvokeHelper(0x81, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRotateSpecial(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x81, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetSlpBarCodeRotationList()
{
	CString result;
	InvokeHelper(0x82, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::TransactionPrint(long Station, long Control)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_I4;
	InvokeHelper(0xad, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Control);
	return result;
}

long CCoPtr::ValidateData(long Station, LPCTSTR Data)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR;
	InvokeHelper(0xae, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Data);
	return result;
}

long CCoPtr::GetBinaryConversion()
{
	long result;
	InvokeHelper(0xb, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetBinaryConversion(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xb, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetCapPowerReporting()
{
	long result;
	InvokeHelper(0xc, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetPowerNotify()
{
	long result;
	InvokeHelper(0x14, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPowerNotify(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x14, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetPowerState()
{
	long result;
	InvokeHelper(0x15, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapJrnCartridgeSensor()
{
	long result;
	InvokeHelper(0x8f, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapJrnColor()
{
	long result;
	InvokeHelper(0x90, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapRecCartridgeSensor()
{
	long result;
	InvokeHelper(0x91, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapRecColor()
{
	long result;
	InvokeHelper(0x92, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapRecMarkFeed()
{
	long result;
	InvokeHelper(0x93, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpBothSidesPrint()
{
	BOOL result;
	InvokeHelper(0x94, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapSlpCartridgeSensor()
{
	long result;
	InvokeHelper(0x95, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCapSlpColor()
{
	long result;
	InvokeHelper(0x96, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetCartridgeNotify()
{
	long result;
	InvokeHelper(0x97, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetCartridgeNotify(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x97, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetJrnCartridgeState()
{
	long result;
	InvokeHelper(0x98, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetJrnCurrentCartridge()
{
	long result;
	InvokeHelper(0x99, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetJrnCurrentCartridge(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x99, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetRecCartridgeState()
{
	long result;
	InvokeHelper(0x9a, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetRecCurrentCartridge()
{
	long result;
	InvokeHelper(0x9b, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetRecCurrentCartridge(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x9b, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetSlpCartridgeState()
{
	long result;
	InvokeHelper(0x9c, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetSlpCurrentCartridge()
{
	long result;
	InvokeHelper(0x9d, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetSlpCurrentCartridge(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0x9d, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetSlpPrintSide()
{
	long result;
	InvokeHelper(0x9e, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::ChangePrintSide(long Side)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xaf, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Side);
	return result;
}

long CCoPtr::MarkFeed(long Type)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xb0, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Type);
	return result;
}

BOOL CCoPtr::GetCapMapCharacterSet()
{
	BOOL result;
	InvokeHelper(0xbe, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetMapCharacterSet()
{
	BOOL result;
	InvokeHelper(0xbf, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetMapCharacterSet(BOOL bNewValue)
{
	static BYTE parms[] = VTS_BOOL;
	InvokeHelper(0xbf, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, bNewValue);
}

CString CCoPtr::GetRecBitmapRotationList()
{
	CString result;
	InvokeHelper(0xc0, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetSlpBitmapRotationList()
{
	CString result;
	InvokeHelper(0xc1, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapStatisticsReporting()
{
	BOOL result;
	InvokeHelper(0x27, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapUpdateStatistics()
{
	BOOL result;
	InvokeHelper(0x28, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::ResetStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x29, DISPATCH_METHOD, VT_I4, (void*)&result, parms, StatisticsBuffer);
	return result;
}

long CCoPtr::RetrieveStatistics(BSTR* pStatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_PBSTR;
	InvokeHelper(0x2a, DISPATCH_METHOD, VT_I4, (void*)&result, parms, pStatisticsBuffer);
	return result;
}

long CCoPtr::UpdateStatistics(LPCTSTR StatisticsBuffer)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2b, DISPATCH_METHOD, VT_I4, (void*)&result, parms, StatisticsBuffer);
	return result;
}

BOOL CCoPtr::GetCapCompareFirmwareVersion()
{
	BOOL result;
	InvokeHelper(0x2c, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapUpdateFirmware()
{
	BOOL result;
	InvokeHelper(0x2d, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

long CCoPtr::CompareFirmwareVersion(LPCTSTR FirmwareFileName, long* pResult)
{
	long result;
	static BYTE parms[] = VTS_BSTR VTS_PI4;
	InvokeHelper(0x2e, DISPATCH_METHOD, VT_I4, (void*)&result, parms, FirmwareFileName, pResult);
	return result;
}

long CCoPtr::UpdateFirmware(LPCTSTR FirmwareFileName)
{
	long result;
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0x2f, DISPATCH_METHOD, VT_I4, (void*)&result, parms, FirmwareFileName);
	return result;
}

BOOL CCoPtr::GetCapConcurrentPageMode()
{
	BOOL result;
	InvokeHelper(0xc2, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapRecPageMode()
{
	BOOL result;
	InvokeHelper(0xc3, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

BOOL CCoPtr::GetCapSlpPageMode()
{
	BOOL result;
	InvokeHelper(0xc4, DISPATCH_PROPERTYGET, VT_BOOL, (void*)&result, NULL);
	return result;
}

CString CCoPtr::GetPageModeArea()
{
	CString result;
	InvokeHelper(0xc5, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetPageModeDescriptor()
{
	long result;
	InvokeHelper(0xc6, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::GetPageModeHorizontalPosition()
{
	long result;
	InvokeHelper(0xc7, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPageModeHorizontalPosition(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xc7, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

CString CCoPtr::GetPageModePrintArea()
{
	CString result;
	InvokeHelper(0xc8, DISPATCH_PROPERTYGET, VT_BSTR, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPageModePrintArea(LPCTSTR lpszNewValue)
{
	static BYTE parms[] = VTS_BSTR;
	InvokeHelper(0xc8, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, lpszNewValue);
}

long CCoPtr::GetPageModePrintDirection()
{
	long result;
	InvokeHelper(0xc9, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPageModePrintDirection(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xc9, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetPageModeStation()
{
	long result;
	InvokeHelper(0xca, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPageModeStation(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xca, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::GetPageModeVerticalPosition()
{
	long result;
	InvokeHelper(0xcb, DISPATCH_PROPERTYGET, VT_I4, (void*)&result, NULL);
	return result;
}

void CCoPtr::SetPageModeVerticalPosition(long nNewValue)
{
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xcb, DISPATCH_PROPERTYPUT, VT_EMPTY, NULL, parms, nNewValue);
}

long CCoPtr::ClearPrintArea()
{
	long result;
	InvokeHelper(0xb1, DISPATCH_METHOD, VT_I4, (void*)&result, NULL);
	return result;
}

long CCoPtr::PageModePrint(long Control)
{
	long result;
	static BYTE parms[] = VTS_I4;
	InvokeHelper(0xb2, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Control);
	return result;
}

long CCoPtr::PrintMemoryBitmap(long Station, LPCTSTR Data, long Type, long Width, long Alignment)
{
	long result;
	static BYTE parms[] = VTS_I4 VTS_BSTR VTS_I4 VTS_I4 VTS_I4;
	InvokeHelper(0xb3, DISPATCH_METHOD, VT_I4, (void*)&result, parms, Station, Data, Type, Width, Alignment);
	return result;
}