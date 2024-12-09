#pragma once

class CCoScan : public CWnd
{
protected:
	DECLARE_DYNCREATE(CCoScan)

public:
	CLSID const& GetClsid()
	{
		// 参照：OPOS-CCO-1.16.0 > Scanner.idl > uuid(CCB90182-B81E-11D2-AB74-0040054C3719)
		static CLSID const clsid = { 0xccb90182, 0xb81e, 0x11d2, { 0xab, 0x74, 0x0, 0x40, 0x5, 0x4c, 0x37, 0x19 } };
		return clsid;
	}

	virtual BOOL Create(
		LPCTSTR lpszClassName,
		LPCTSTR lpszWindowName, 
		DWORD dwStyle,
		const RECT& rect,
		CWnd* pParentWnd, 
		UINT nID,
		CCreateContext* pContext = NULL)
	{
		return CreateControl(GetClsid(), lpszWindowName, dwStyle, rect, pParentWnd, nID);
	}

    BOOL Create(
		LPCTSTR lpszWindowName,
		DWORD dwStyle,
		const RECT& rect,
		CWnd* pParentWnd,
		UINT nID,
		CFile* pPersist = NULL,
		BOOL bStorage = FALSE,
		BSTR bstrLicKey = NULL)
	{
		return CreateControl(GetClsid(), lpszWindowName, dwStyle, rect, pParentWnd, nID, pPersist, bStorage, bstrLicKey);
	}

	// OPOSアクセス制御関数（スケルトンコード呼出しのラッパー関数）
	// 参照：OPOS-CCO-1.16.0 > Scanner.idl > [propget, id(??), helpstring("property ???")]
	long GetOpenResult();
	CString GetCheckHealthText();
	BOOL GetClaimed();
	BOOL GetDataEventEnabled();
	void SetDataEventEnabled(BOOL bNewValue);
	BOOL GetDeviceEnabled();
	void SetDeviceEnabled(BOOL bNewValue);
	BOOL GetFreezeEvents();
	void SetFreezeEvents(BOOL bNewValue);
	long GetResultCode();
	long GetResultCodeExtended();
	long GetState();
	CString GetControlObjectDescription();
	long GetControlObjectVersion();
	CString GetServiceObjectDescription();
	long GetServiceObjectVersion();
	CString GetDeviceDescription();
	CString GetDeviceName();
	long CheckHealth(long Level);
	long ClaimDevice(long Timeout);
	long ClearInput();
	long Close();
	long DirectIO(long Command, long* pData, BSTR* pString);
	long Open(LPCTSTR DeviceName);
	long ReleaseDevice();
	CString GetScanData();
	BOOL GetAutoDisable();
	void SetAutoDisable(BOOL bNewValue);
	long GetBinaryConversion();
	void SetBinaryConversion(long nNewValue);
	long GetDataCount();
	BOOL GetDecodeData();
	void SetDecodeData(BOOL bNewValue);
	CString GetScanDataLabel();
	long GetScanDataType();
	long GetCapPowerReporting();
	long GetPowerNotify();
	void SetPowerNotify(long nNewValue);
	long GetPowerState();
	BOOL GetCapStatisticsReporting();
	BOOL GetCapUpdateStatistics();
	long ResetStatistics(LPCTSTR StatisticsBuffer);
	long RetrieveStatistics(BSTR* pStatisticsBuffer);
	long UpdateStatistics(LPCTSTR StatisticsBuffer);
	BOOL GetCapCompareFirmwareVersion();
	BOOL GetCapUpdateFirmware();
	long CompareFirmwareVersion(LPCTSTR FirmwareFileName, long* pResult);
	long UpdateFirmware(LPCTSTR FirmwareFileName);
	long ClearInputProperties();
};