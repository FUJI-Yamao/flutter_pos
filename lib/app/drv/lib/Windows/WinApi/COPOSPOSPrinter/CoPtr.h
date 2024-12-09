#pragma once

class CCoPtr : public CWnd
{
protected:
	DECLARE_DYNCREATE(CCoPtr)

public:
	CLSID const& GetClsid()
	{
		// �Q�ƁFOPOS-CCO-1.16.0 > POSPrinter.idl > uuid(CCB90152-B81E-11D2-AB74-0040054C3719)
		static CLSID const clsid = { 0xccb90152, 0xb81e, 0x11d2, { 0xab, 0x74, 0x0, 0x40, 0x5, 0x4c, 0x37, 0x19 } };
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

	// OPOS�A�N�Z�X����֐��i�X�P���g���R�[�h�ďo���̃��b�p�[�֐��j
	// �Q�ƁFOPOS-CCO-1.16.0 > POSPrinter.idl > [propget, id(??), helpstring("property ???")]
	long GetOpenResult();
	CString GetCheckHealthText();
	BOOL GetClaimed();
	BOOL GetDeviceEnabled();
	void SetDeviceEnabled(BOOL bNewValue);
	BOOL GetFreezeEvents();
	void SetFreezeEvents(BOOL bNewValue);
	long GetOutputID();
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
	long ClearOutput();
	long Close();
	long DirectIO(long Command, long* pData, BSTR* pString);
	long Open(LPCTSTR DeviceName);
	long ReleaseDevice();
	BOOL GetAsyncMode();
	void SetAsyncMode(BOOL bNewValue);
	BOOL GetCapConcurrentJrnRec();
	BOOL GetCapConcurrentJrnSlp();
	BOOL GetCapConcurrentRecSlp();
	BOOL GetCapCoverSensor();
	BOOL GetCapJrn2Color();
	BOOL GetCapJrnBold();
	BOOL GetCapJrnDhigh();
	BOOL GetCapJrnDwide();
	BOOL GetCapJrnDwideDhigh();
	BOOL GetCapJrnEmptySensor();
	BOOL GetCapJrnItalic();
	BOOL GetCapJrnNearEndSensor();
	BOOL GetCapJrnPresent();
	BOOL GetCapJrnUnderline();
	BOOL GetCapRec2Color();
	BOOL GetCapRecBarCode();
	BOOL GetCapRecBitmap();
	BOOL GetCapRecBold();
	BOOL GetCapRecDhigh();
	BOOL GetCapRecDwide();
	BOOL GetCapRecDwideDhigh();
	BOOL GetCapRecEmptySensor();
	BOOL GetCapRecItalic();
	BOOL GetCapRecLeft90();
	BOOL GetCapRecNearEndSensor();
	BOOL GetCapRecPapercut();
	BOOL GetCapRecPresent();
	BOOL GetCapRecRight90();
	BOOL GetCapRecRotate180();
	BOOL GetCapRecStamp();
	BOOL GetCapRecUnderline();
	BOOL GetCapSlp2Color();
	BOOL GetCapSlpBarCode();
	BOOL GetCapSlpBitmap();
	BOOL GetCapSlpBold();
	BOOL GetCapSlpDhigh();
	BOOL GetCapSlpDwide();
	BOOL GetCapSlpDwideDhigh();
	BOOL GetCapSlpEmptySensor();
	BOOL GetCapSlpFullslip();
	BOOL GetCapSlpItalic();
	BOOL GetCapSlpLeft90();
	BOOL GetCapSlpNearEndSensor();
	BOOL GetCapSlpPresent();
	BOOL GetCapSlpRight90();
	BOOL GetCapSlpRotate180();
	BOOL GetCapSlpUnderline();
	long GetCharacterSet();
	void SetCharacterSet(long nNewValue);
	CString GetCharacterSetList();
	BOOL GetCoverOpen();
	long GetErrorStation();
	BOOL GetFlagWhenIdle();
	void SetFlagWhenIdle(BOOL bNewValue);
	BOOL GetJrnEmpty();
	BOOL GetJrnLetterQuality();
	void SetJrnLetterQuality(BOOL bNewValue);
	long GetJrnLineChars();
	void SetJrnLineChars(long nNewValue);
	CString GetJrnLineCharsList();
	long GetJrnLineHeight();
	void SetJrnLineHeight(long nNewValue);
	long GetJrnLineSpacing();
	void SetJrnLineSpacing(long nNewValue);
	long GetJrnLineWidth();
	BOOL GetJrnNearEnd();
	long GetMapMode();
	void SetMapMode(long nNewValue);
	BOOL GetRecEmpty();
	BOOL GetRecLetterQuality();
	void SetRecLetterQuality(BOOL bNewValue);
	long GetRecLineChars();
	void SetRecLineChars(long nNewValue);
	CString GetRecLineCharsList();
	long GetRecLineHeight();
	void SetRecLineHeight(long nNewValue);
	long GetRecLineSpacing();
	void SetRecLineSpacing(long nNewValue);
	long GetRecLinesToPaperCut();
	long GetRecLineWidth();
	BOOL GetRecNearEnd();
	long GetRecSidewaysMaxChars();
	long GetRecSidewaysMaxLines();
	BOOL GetSlpEmpty();
	BOOL GetSlpLetterQuality();
	void SetSlpLetterQuality(BOOL bNewValue);
	long GetSlpLineChars();
	void SetSlpLineChars(long nNewValue);
	CString GetSlpLineCharsList();
	long GetSlpLineHeight();
	void SetSlpLineHeight(long nNewValue);
	long GetSlpLinesNearEndToEnd();
	long GetSlpLineSpacing();
	void SetSlpLineSpacing(long nNewValue);
	long GetSlpLineWidth();
	long GetSlpMaxLines();
	BOOL GetSlpNearEnd();
	long GetSlpSidewaysMaxChars();
	long GetSlpSidewaysMaxLines();
	long BeginInsertion(long Timeout);
	long BeginRemoval(long Timeout);
	long CutPaper(long Percentage);
	long EndInsertion();
	long EndRemoval();
	long PrintBarCode(long Station, LPCTSTR Data, long Symbology, long Height, long Width, long Alignment, long TextPosition);
	long PrintBitmap(long Station, LPCTSTR FileName, long Width, long Alignment);
	long PrintImmediate(long Station, LPCTSTR Data);
	long PrintNormal(long Station, LPCTSTR Data);
	long PrintTwoNormal(long Stations, LPCTSTR Data1, LPCTSTR Data2);
	long RotatePrint(long Station, long Rotation);
	long SetBitmap(long BitmapNumber, long Station, LPCTSTR FileName, long Width, long Alignment);
	long SetLogo(long Location, LPCTSTR Data);
	long GetCapCharacterSet();
	BOOL GetCapTransaction();
	long GetErrorLevel();
	CString GetErrorString();
	CString GetFontTypefaceList();
	CString GetRecBarCodeRotationList();
	long GetRotateSpecial();
	void SetRotateSpecial(long nNewValue);
	CString GetSlpBarCodeRotationList();
	long TransactionPrint(long Station, long Control);
	long ValidateData(long Station, LPCTSTR Data);
	long GetBinaryConversion();
	void SetBinaryConversion(long nNewValue);
	long GetCapPowerReporting();
	long GetPowerNotify();
	void SetPowerNotify(long nNewValue);
	long GetPowerState();
	long GetCapJrnCartridgeSensor();
	long GetCapJrnColor();
	long GetCapRecCartridgeSensor();
	long GetCapRecColor();
	long GetCapRecMarkFeed();
	BOOL GetCapSlpBothSidesPrint();
	long GetCapSlpCartridgeSensor();
	long GetCapSlpColor();
	long GetCartridgeNotify();
	void SetCartridgeNotify(long nNewValue);
	long GetJrnCartridgeState();
	long GetJrnCurrentCartridge();
	void SetJrnCurrentCartridge(long nNewValue);
	long GetRecCartridgeState();
	long GetRecCurrentCartridge();
	void SetRecCurrentCartridge(long nNewValue);
	long GetSlpCartridgeState();
	long GetSlpCurrentCartridge();
	void SetSlpCurrentCartridge(long nNewValue);
	long GetSlpPrintSide();
	long ChangePrintSide(long Side);
	long MarkFeed(long Type);
	BOOL GetCapMapCharacterSet();
	BOOL GetMapCharacterSet();
	void SetMapCharacterSet(BOOL bNewValue);
	CString GetRecBitmapRotationList();
	CString GetSlpBitmapRotationList();
	BOOL GetCapStatisticsReporting();
	BOOL GetCapUpdateStatistics();
	long ResetStatistics(LPCTSTR StatisticsBuffer);
	long RetrieveStatistics(BSTR* pStatisticsBuffer);
	long UpdateStatistics(LPCTSTR StatisticsBuffer);
	BOOL GetCapCompareFirmwareVersion();
	BOOL GetCapUpdateFirmware();
	long CompareFirmwareVersion(LPCTSTR FirmwareFileName, long* pResult);
	long UpdateFirmware(LPCTSTR FirmwareFileName);
	BOOL GetCapConcurrentPageMode();
	BOOL GetCapRecPageMode();
	BOOL GetCapSlpPageMode();
	CString GetPageModeArea();
	long GetPageModeDescriptor();
	long GetPageModeHorizontalPosition();
	void SetPageModeHorizontalPosition(long nNewValue);
	CString GetPageModePrintArea();
	void SetPageModePrintArea(LPCTSTR lpszNewValue);
	long GetPageModePrintDirection();
	void SetPageModePrintDirection(long nNewValue);
	long GetPageModeStation();
	void SetPageModeStation(long nNewValue);
	long GetPageModeVerticalPosition();
	void SetPageModeVerticalPosition(long nNewValue);
	long ClearPrintArea();
	long PageModePrint(long Control);
	long PrintMemoryBitmap(long Station, LPCTSTR Data, long Type, long Width, long Alignment);
	// TODO: ver1.16.0�p�ɒǉ��\��
	long GetCapRecRuledLine();
	long GetCapSlpRuledLine();
	//...
};