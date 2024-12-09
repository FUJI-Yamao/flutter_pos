#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSPOSPrinter.h"
#include "PrinterAct.h"
#include "RpcManager.h"
#include "../Opos/OposPtr.h"
#include "../COpos/COposPtr.h"
#include "../OposSystem/OposDefs.h"

// Width=X*((D+2)*(11+2))
// X：細エレメント幅　2≦X≦6
// D：文字列サイズ + 1(NULL終端文字)　ex) "{C123" -> 出力結果：123\0
#define X 4
#define BC_WIDTH(D) (X * ((D + 2) * (11 + 2)))

static CCoPtr& g_ptr = Singleton<CCoPtr>::GetInstance();
static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();
static PTR_DATA_RCV g_pDataRcv;

static INT g_stateCover = STAT_DISCONNECTED;	// プリンタカバー開閉状態　0:開, 1:閉, -1:非接続状態
static INT g_statePaper = STAT_DISCONNECTED;	// レシート用紙有無状態　0:無, 1:有, -1:非接続状態
static BOOL g_bCoverSensor = TRUE;				// プリンタカバーセンサー点灯状態　FALSE:非点灯, TRUE:点灯

static const long cmbItem[] = { 0x0a, 0x0b, 0x14, 0x15, 0x3c, 0x46 };

COPOSPOSPrinter::COPOSPOSPrinter(CWnd* pParent /*=NULL*/) :
	CDialog(COPOSPOSPrinter::IDD, pParent)
{
	
}

BOOL COPOSPOSPrinter::OnInitDialog()
{
	cout << ">>> OnInit" << endl;

	CDialog::OnInitDialog();

	BOOL bError = FALSE;
	while (1)
	{
		LONG rc = -1;

		m_ptr.Open(POSPRINTER_NAME);
		rc = m_ptr.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "Open() : " << rc << endl;
			bError = TRUE;
			break;
		}

		m_ptr.ClaimDevice(1000);
		rc = m_ptr.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "ClaimDevice() : " << rc << endl;
			bError = TRUE;
			break;
		}

		m_ptr.SetDeviceEnabled(TRUE);
		rc = m_ptr.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "SetDeviceEnabled() : " << rc << endl;
			bError = TRUE;
			break;
		}

		m_ptr.SetMapMode(PTR_MM_METRIC);
		m_ptr.SetRecLetterQuality(TRUE);

		// 90度横印字が可能かチェック
		if (FALSE == m_ptr.GetCapRecLeft90())
		{
			// 横印字無効
		}

		// スリップ機能のチェック
		if ((FALSE == m_ptr.GetCapSlpPresent()) || (FALSE == m_ptr.GetCapSlpFullslip()))
		{
			// スリップ無効
		}

		// 登録済ビットマップ印刷機能をチェック
		if (FALSE == m_ptr.GetCapRecBitmap())
		{
			// 登録済ビットマップ無効
			// OnOutputReceipt > 無効
		}

		g_stateCover = STAT_DISCONNECTED;
		g_statePaper = STAT_DISCONNECTED;
		g_bCoverSensor = m_ptr.GetCapCoverSensor();

		break;
	}

	if (bError)
	{
		// エラー処理
		// ...
		g_bCoverSensor = FALSE;
	}
	
	return TRUE;
}

void COPOSPOSPrinter::DoDataExchange(CDataExchange* pDX)
{
	cout << ">>> DoDataExchange" << endl;
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_POSPRINTER, m_ptr);
}

void COPOSPOSPrinter::OnDestroy()
{
	m_ptr.SetDeviceEnabled(FALSE);
	m_ptr.ReleaseDevice();
	m_ptr.Close();
	SingletonFinalizer::Finalize();
	g_rpc.OnDestroy();
	CDialog::OnClose();
}

BEGIN_EVENTSINK_MAP(COPOSPOSPrinter, CDialog)	// プロセスダミーベース
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 3 /* ErrorEvent */, OnErrorEventPrinter, VTS_I4 VTS_I4 VTS_I4 VTS_PI4)
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 4 /* OutputCompleteEvent */, OnOutputCompleteEventPrinter, VTS_I4)
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 5 /* StatusUpdateEvent */, OnStatusUpdateEventPrinter, VTS_I4)
END_EVENTSINK_MAP()

// POSプリンタエラーイベント
void COPOSPOSPrinter::OnErrorEventPrinter(long ResultCode, long ResultCodeExtended, long ErrorLocus, long FAR* pErrorResponse)
{
	cout << ">>> OnErrorEventPosprinter" << endl;

	CString sRC;
	CString sRCE;

	sRC.Format("ResultCode = %ld\n", ResultCode);
	sRCE.Format("ResultCodeExtended = %ld\n", ResultCodeExtended);
	cout << "ErrorEvent: Printer Error.\n\n" + sRC + sRCE << endl;
	
	*pErrorResponse = OPOS_ER_CLEAR;
}

// 出力完了イベント
void COPOSPOSPrinter::OnOutputCompleteEventPrinter(long OutputID)
{
	// ※非同期の場合でも通知
	cout << ">>> OnOutputCompleteEventPosprinter" << endl;
}

// ステータス更新イベント（プリンターのステータスが変化するとイベントが発生）
void COPOSPOSPrinter::OnStatusUpdateEventPrinter(long Data)
{
	cout << ">>> OnStatusUpdateEventPosprinter" << endl;

	BOOL bRecEnb = TRUE;
	CString cString;
	BSTR pString;

	// 各イベント情報のメッセージを作成
	switch (Data)
	{
	case PTR_SUE_COVER_OPEN:        // プリンタカバー開
		cout << "プリンタカバーが開いています。" << endl;
		g_stateCover = STAT_COVER_OPEN;
		break;
	case PTR_SUE_REC_EMPTY:			// レシート用紙無し
		cout << "レシート用紙がありません。" << endl;
		g_statePaper = STAT_PAPER_EMPTY;
		break;
	case PTR_SUE_COVER_OK:			// プリンタカバー閉
		cout << "プリンタカバー閉じてます。" << endl;
		g_stateCover = STAT_COVER_CLOSE;
		break;
	case PTR_SUE_REC_PAPEROK:		// レシート用紙有り
	case PTR_SUE_REC_NEAREMPTY:		// レシート用紙有り(Near Empty)
		cout << "レシート用紙有りです。" << endl;
		g_statePaper = STAT_PAPER_EXIST;
		break;
	}

	if (STAT_PAPER_EXIST == g_statePaper && (STAT_COVER_CLOSE == g_stateCover || !g_bCoverSensor))
	{
		bRecEnb = TRUE;
	}
	else
	{
		bRecEnb = FALSE;
	}

	// OnOutputReceipt > TRUE:有効, FALSE:無効
	// OnPrintBitmapDirect > TRUE:有効, FALSE:無効

	// 90度横印字が可能かチェック
	if (FALSE == m_ptr.GetCapRecLeft90())
	{
		// 横印字無効
	}

	// スリップ機能のチェック
	if ((FALSE == m_ptr.GetCapSlpPresent()) || (FALSE == m_ptr.GetCapSlpFullslip()))
	{
		// スリップ無効
	}
	
	// 登録済ビットマップ印刷機能をチェック
	if (FALSE == m_ptr.GetCapRecBitmap())
	{
		// 登録済ビットマップ無効
		// OnOutputReceipt > 無効
	}
}

// レシートロゴ登録
VOID OnRegisterLogo(const string& filePath)
{
	cout << ">>> OnRegisterLogo" << endl;
	
	LONG rc = -1;
	LONG lRetryCount = 0;
	if (TRUE == g_ptr.GetCapRecBitmap())
	{
		lRetryCount = 0;

		do {
			// ビットマップの登録
			g_ptr.SetBitmap(1, PTR_S_RECEIPT, filePath.c_str(), round(g_ptr.GetRecLineWidth() * 9 / 10), PTR_BM_CENTER);
			if ((OPOS_E_ILLEGAL == g_ptr.GetResultCode()) && (OPOS_EX_DEVBUSY == g_ptr.GetResultCodeExtended()))
			{
				lRetryCount = lRetryCount + 1;
				Sleep(1000);
			}
			else
			{
				break;
			}
		} while (lRetryCount < 5);

		rc = g_ptr.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "SetBitmap() : " << rc << endl;
		}
	}
}

// レシート出力
VOID OnOutputReceipt(const string& textData, const string& bcData, BOOL bAsync)
{
	cout << ">>> OnOutputReceipt" << endl;

	BOOL bExit = FALSE;
	CString	esc = "\x1b";
	CString sBuf;
	CString sRC;
	CString sRCE;

	if (FALSE == g_ptr.GetCapRecPresent())
	{
		cout << "このプリンターにはレシートステーションがありません。" << endl;
		return;
	}

	if (bAsync) g_ptr.SetAsyncMode(TRUE);

	g_ptr.TransactionPrint(PTR_S_RECEIPT, PTR_TP_TRANSACTION);
	if (OPOS_SUCCESS != g_ptr.GetResultCode())
	{
		cout << "POSプリンターを使用できません。" << endl;
		return;
	}

	while (1)
	{
		/////////////////////////////////////////////////
		// Header部

		if (g_ptr.GetCapRecBitmap())
		{
			// ビットマップ印字
			g_ptr.PrintNormal(PTR_S_RECEIPT, esc + "|1B");
		}

		/////////////////////////////////////////////////
		// Body部
		
		// テキスト印字
		g_ptr.PrintNormal(PTR_S_RECEIPT, textData.c_str());

		/////////////////////////////////////////////////
		// Footer部
		
		if (g_ptr.GetCapRecBarCode())
		{
			// バーコード印字（バーコード文字列込み）
			string barcode = "{C" + bcData;		// CODE-Cタイプ
			g_ptr.PrintBarCode(PTR_S_RECEIPT, barcode.c_str(), PTR_BCS_Code128_Parsed, 700, BC_WIDTH(bcData.length() + 1), PTR_BC_CENTER, PTR_BC_TEXT_BELOW);
			//cout << "RecLineWidth: " << g_ptr.GetRecLineWidth() << endl;	// 5406
			if (OPOS_SUCCESS != g_ptr.GetResultCode())
			{
				cout << "バーコード印字できません。" << endl;
			}
		}

		// 余白
		g_ptr.PrintNormal(PTR_S_RECEIPT, esc + "|200uF");

		/////////////////////////////////////////////////

		// レシートカット
		sBuf.Format("|%dlF", g_ptr.GetRecLinesToPaperCut());
		g_ptr.PrintNormal(PTR_S_RECEIPT, esc + sBuf);
		if (g_ptr.GetCapRecPapercut()) g_ptr.CutPaper(98);	// 100:フルカット, 1～99:バーシャルカット, 0:カットなし
		if (OPOS_SUCCESS == g_ptr.GetResultCode()) break;

		// エラー発生
		cout << "Fails to output to a printer." << endl;
		//g_ptr.ClearOutput();	// リトライの場合
		//bExit = TRUE; break;	// キャンセルの場合
		break;
	}

	// キャンセルでない場合
	if (!bExit)
	{
		if (!bAsync)
		{
			// デバイスが「OPOS_S_IDLE」になるまで待機
			while (OPOS_S_IDLE != g_ptr.GetState());
		}

		g_ptr.TransactionPrint(PTR_S_RECEIPT, PTR_TP_NORMAL);
		if (OPOS_SUCCESS != g_ptr.GetResultCode())
		{
			sRC.Format("%ld", g_ptr.GetResultCode());
			sRCE.Format("%ld", g_ptr.GetResultCodeExtended());
			cout << "Cannot use a POS Printer\nResultCode = " + sRC + "\nResultCodeExtended = " + sRCE << endl;

			// 印刷中にエラーが発生した場合、バッファには印刷データが保持されるため、バッファリングされたデータをクリアする
			g_ptr.ClearOutput();
		}
	}

	if (bAsync) g_ptr.SetAsyncMode(FALSE);
}

// ビットマップのダイレクト印刷
VOID OnPrintBitmapDirect(const string& filePath)
{
	cout << ">>> OnPrintBitmapDirect" << endl;

	CFile		bitmapFile;
	CString		strBitmapData;
	BYTE		byBuffer;
	CString 	sRC;
	CString 	sRCE;

	// ビットマップファイル読み込み
	if (FALSE == bitmapFile.Open(filePath.c_str(), CFile::modeRead))
	{
		cout << "Cannot open bitmap file." << endl;
		return;
	}

	strBitmapData.Empty();
	while (bitmapFile.Read(&byBuffer, sizeof(BYTE)) == sizeof(BYTE))
	{
		strBitmapData += TCHAR(0x30 + ((byBuffer >> 4) & 0x0F));
		strBitmapData += TCHAR(0x30 + (byBuffer & 0x0F));
	}

	bitmapFile.Close();

	// ビットマップを出力
	g_ptr.SetBinaryConversion(OPOS_BC_NIBBLE);
	g_ptr.PrintMemoryBitmap(PTR_S_RECEIPT, strBitmapData, PTR_BMT_BMP, g_ptr.GetRecLineWidth() / 2, PTR_BM_CENTER);
	if (OPOS_SUCCESS != g_ptr.GetResultCode())
	{
		sRC.Format("%ld", g_ptr.GetResultCode());
		sRCE.Format("%ld", g_ptr.GetResultCodeExtended());
		cout << "Cannot use a POS Printer\nResultCode = " + sRC + "\nResultCodeExtended = " + sRCE << endl;
	}
	g_ptr.SetBinaryConversion(OPOS_BC_NONE);
}

// プリンタカバー開閉状態送信
VOID OnGetStatCover()
{
	//cout << ">>> Get status cover." << endl;

	// プリンタカバー開閉状態
	BOOL bSend = FALSE;
	switch (g_stateCover)
	{
	case STAT_COVER_CLOSE:	// カバー閉
		g_pDataRcv.statCover = PTR_STAT_COVER_CLOSE;
		bSend = TRUE;
		break;
	case STAT_COVER_OPEN:	// カバー開
		g_pDataRcv.statCover = PTR_STAT_COVER_OPEN;
		bSend = TRUE;
		break;
	case STAT_DISCONNECTED:	// 非接続状態
	default:
		break;
	}

	// アプリ側へ送信
	if (bSend)
	{
		g_pDataRcv.error = PTR_EPTR_NO_ERROR;
		g_rpc.OnSend(&g_pDataRcv);
	}
}

// レシート用紙有無状態送信
VOID OnGetStatPaper()
{
	//cout << ">>> Get status paper." << endl;

	// レシート用紙有無状態
	BOOL bSend = FALSE;
	switch (g_statePaper)
	{
	case STAT_PAPER_EXIST:	// レシート用紙有り
		g_pDataRcv.statPaper = PTR_STAT_PAPER_EXIST;
		bSend = TRUE;
		break;
	case STAT_PAPER_EMPTY:	// レシート用紙無し
		g_pDataRcv.statPaper = PTR_STAT_PAPER_EMPTY;
		bSend = TRUE;
		break;
	case STAT_DISCONNECTED:
	default:
		break;
	}
	
	// アプリ側へ送信
	if (bSend)
	{
		g_pDataRcv.error = PTR_EPTR_NO_ERROR;
		g_rpc.OnSend(&g_pDataRcv);
	}
}