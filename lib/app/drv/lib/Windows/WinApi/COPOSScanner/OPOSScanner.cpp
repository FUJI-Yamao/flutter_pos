#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSScanner.h"
#include "RpcManager.h"
#include "../Opos/OposScan.h"
#include "../OposSystem/OposDefs.h"

static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();

COPOSScanner::COPOSScanner(CWnd* pParent /*=NULL*/) : 
	CDialog(COPOSScanner::IDD, pParent)
{
	
}

BOOL COPOSScanner::OnInitDialog()
{
	cout << ">>> OnInit" << endl;

	CDialog::OnInitDialog();

	BOOL bError = FALSE;
	while(1)
	{
		LONG rc = -1;

		m_scan.Open(SCANNER_NAME);
		rc = m_scan.GetResultCode();
		if(OPOS_SUCCESS != rc)
		{
			cout << "Open() : " << rc << endl;
			bError = TRUE;
			break;
		}

		m_scan.ClaimDevice(1000);
		rc = m_scan.GetResultCode();
        if(OPOS_SUCCESS != rc)
		{
			cout << "ClaimDevice() : " << rc << endl;
			bError = TRUE;
			break;
        }

		m_scan.SetDeviceEnabled(TRUE);
		rc = m_scan.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "SetDeviceEnabled() : " << rc << endl;
			bError = TRUE;
			break;
		}

        m_scan.SetDataEventEnabled(TRUE);
		m_scan.SetDecodeData(TRUE);

		break;
	}

	if (bError)
	{
		// エラー処理
	}

	return TRUE;
}

void COPOSScanner::DoDataExchange(CDataExchange* pDX)
{
	cout << ">>> DoDataExchange" << endl;
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_SCANNER, m_scan);
}

void COPOSScanner::OnDestroy()
{
	m_scan.SetDeviceEnabled(FALSE);
	m_scan.ReleaseDevice();
	m_scan.Close();
	SingletonFinalizer::Finalize();
	g_rpc.OnDestroy();
	CDialog::OnClose();
}

// イベント受付
BEGIN_EVENTSINK_MAP(COPOSScanner, CDialog)	// プロセスダミーベース
	ON_EVENT(COPOSScanner, IDC_SCANNER, 1 /* DataEvent */, OnDataEvent, VTS_I8)
	ON_EVENT(COPOSScanner, IDC_SCANNER, 3 /* ErrorEvent */, OnErrorEvent, VTS_I8 VTS_I8 VTS_I8 VTS_PI8)
END_EVENTSINK_MAP()

void COPOSScanner::OnDataEvent(long Status)
{
	cout << ">>> OnDataEvent" << endl;
	
	SCAN_DATA sData;
	CString sType;

	CString scanData = m_scan.GetScanData();
	cout << "ScanData : " << scanData << endl;
	sData.scanData = scanData;

	switch (m_scan.GetScanDataType())
	{
	case SCAN_SDT_UPCA:     sType = "UPCA";			break;
	case SCAN_SDT_UPCE:     sType = "UPCE";			break;
	case SCAN_SDT_JAN8:     sType = "JAN8";			break;
//	case SCAN_SDT_EAN8:     sType = "EAN8";			break;
	case SCAN_SDT_JAN13:    sType = "JAN13";		break;
//	case SCAN_SDT_EAN13:    sType = "EAN13";		break;
	case SCAN_SDT_TF:       sType = "TF";			break;
	case SCAN_SDT_ITF:      sType = "ITF";			break;
	case SCAN_SDT_Codabar:  sType = "Codabar";		break;
	case SCAN_SDT_Code39:   sType = "Code39";		break;
	case SCAN_SDT_Code93:   sType = "Code93";		break;
	case SCAN_SDT_Code128:  sType = "Code128";		break;
	case SCAN_SDT_UPCA_S:   sType = "UPCA_S";		break;
	case SCAN_SDT_UPCE_S:   sType = "UPCE_S";		break;
	case SCAN_SDT_UPCD1:    sType = "UPCD1";		break;
	case SCAN_SDT_UPCD2:    sType = "UPCD2";		break;
	case SCAN_SDT_UPCD3:    sType = "UPCD3";		break;
	case SCAN_SDT_UPCD4:    sType = "UPCD4";		break;
	case SCAN_SDT_UPCD5:    sType = "UPCD5";		break;
	case SCAN_SDT_EAN8_S:   sType = "EAN8_S";		break;
	case SCAN_SDT_EAN13_S:  sType = "EAN13_S";		break;
	case SCAN_SDT_EAN128:   sType = "EAN128";		break;
	case SCAN_SDT_OCRA:     sType = "OCRA";			break;
	case SCAN_SDT_OCRB:     sType = "OCRB";			break;
	case SCAN_SDT_PDF417:   sType = "PDF417";		break;
	case SCAN_SDT_MAXICODE: sType = "MAXICODE";		break;
	case SCAN_SDT_OTHER:    sType = "OTHER";		break;
	case SCAN_SDT_UNKNOWN:  sType = "UNKNOWN";		break;
	default:				sType = "";
	}

	cout << "ScanDataType : " << sType << endl;
	sData.scanType = sType;

	CString scanLabel = m_scan.GetScanDataLabel();
	cout << "ScanDataLabel : " << scanLabel << endl;
	sData.scanLabel = scanLabel;

	// スキャンデータを送信
	g_rpc.OnSend(&sData);

	m_scan.SetDataEventEnabled(TRUE);
}

void COPOSScanner::OnErrorEvent(long ResultCode, long ResultCodeExtended, long ErrorLocus, long FAR* pErrorResponse)
{
	cout << ">>> OnErrorEventScanner" << endl;

	CString sRC;
	CString sRCE;

	sRC.Format("ResultCode = %ld\n", ResultCode);
	sRCE.Format("ResultCodeExtended = %ld\n", ResultCodeExtended);
	cout << "Scanner Error.\n" + sRC + sRCE << endl;
}