#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSPOSPrinter.h"
#include "PrinterAct.h"
#include "RpcManager.h"
#include "../Opos/OposPtr.h"
#include "../COpos/COposPtr.h"
#include "../OposSystem/OposDefs.h"

// Width=X*((D+2)*(11+2))
// X�F�׃G�������g���@2��X��6
// D�F������T�C�Y + 1(NULL�I�[����)�@ex) "{C123" -> �o�͌��ʁF123\0
#define X 4
#define BC_WIDTH(D) (X * ((D + 2) * (11 + 2)))

static CCoPtr& g_ptr = Singleton<CCoPtr>::GetInstance();
static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();
static PTR_DATA_RCV g_pDataRcv;

static INT g_stateCover = STAT_DISCONNECTED;	// �v�����^�J�o�[�J��ԁ@0:�J, 1:��, -1:��ڑ����
static INT g_statePaper = STAT_DISCONNECTED;	// ���V�[�g�p���L����ԁ@0:��, 1:�L, -1:��ڑ����
static BOOL g_bCoverSensor = TRUE;				// �v�����^�J�o�[�Z���T�[�_����ԁ@FALSE:��_��, TRUE:�_��

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

		// 90�x���󎚂��\���`�F�b�N
		if (FALSE == m_ptr.GetCapRecLeft90())
		{
			// ���󎚖���
		}

		// �X���b�v�@�\�̃`�F�b�N
		if ((FALSE == m_ptr.GetCapSlpPresent()) || (FALSE == m_ptr.GetCapSlpFullslip()))
		{
			// �X���b�v����
		}

		// �o�^�σr�b�g�}�b�v����@�\���`�F�b�N
		if (FALSE == m_ptr.GetCapRecBitmap())
		{
			// �o�^�σr�b�g�}�b�v����
			// OnOutputReceipt > ����
		}

		g_stateCover = STAT_DISCONNECTED;
		g_statePaper = STAT_DISCONNECTED;
		g_bCoverSensor = m_ptr.GetCapCoverSensor();

		break;
	}

	if (bError)
	{
		// �G���[����
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

BEGIN_EVENTSINK_MAP(COPOSPOSPrinter, CDialog)	// �v���Z�X�_�~�[�x�[�X
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 3 /* ErrorEvent */, OnErrorEventPrinter, VTS_I4 VTS_I4 VTS_I4 VTS_PI4)
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 4 /* OutputCompleteEvent */, OnOutputCompleteEventPrinter, VTS_I4)
	ON_EVENT(COPOSPOSPrinter, IDC_POSPRINTER, 5 /* StatusUpdateEvent */, OnStatusUpdateEventPrinter, VTS_I4)
END_EVENTSINK_MAP()

// POS�v�����^�G���[�C�x���g
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

// �o�͊����C�x���g
void COPOSPOSPrinter::OnOutputCompleteEventPrinter(long OutputID)
{
	// ���񓯊��̏ꍇ�ł��ʒm
	cout << ">>> OnOutputCompleteEventPosprinter" << endl;
}

// �X�e�[�^�X�X�V�C�x���g�i�v�����^�[�̃X�e�[�^�X���ω�����ƃC�x���g�������j
void COPOSPOSPrinter::OnStatusUpdateEventPrinter(long Data)
{
	cout << ">>> OnStatusUpdateEventPosprinter" << endl;

	BOOL bRecEnb = TRUE;
	CString cString;
	BSTR pString;

	// �e�C�x���g���̃��b�Z�[�W���쐬
	switch (Data)
	{
	case PTR_SUE_COVER_OPEN:        // �v�����^�J�o�[�J
		cout << "�v�����^�J�o�[���J���Ă��܂��B" << endl;
		g_stateCover = STAT_COVER_OPEN;
		break;
	case PTR_SUE_REC_EMPTY:			// ���V�[�g�p������
		cout << "���V�[�g�p��������܂���B" << endl;
		g_statePaper = STAT_PAPER_EMPTY;
		break;
	case PTR_SUE_COVER_OK:			// �v�����^�J�o�[��
		cout << "�v�����^�J�o�[���Ă܂��B" << endl;
		g_stateCover = STAT_COVER_CLOSE;
		break;
	case PTR_SUE_REC_PAPEROK:		// ���V�[�g�p���L��
	case PTR_SUE_REC_NEAREMPTY:		// ���V�[�g�p���L��(Near Empty)
		cout << "���V�[�g�p���L��ł��B" << endl;
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

	// OnOutputReceipt > TRUE:�L��, FALSE:����
	// OnPrintBitmapDirect > TRUE:�L��, FALSE:����

	// 90�x���󎚂��\���`�F�b�N
	if (FALSE == m_ptr.GetCapRecLeft90())
	{
		// ���󎚖���
	}

	// �X���b�v�@�\�̃`�F�b�N
	if ((FALSE == m_ptr.GetCapSlpPresent()) || (FALSE == m_ptr.GetCapSlpFullslip()))
	{
		// �X���b�v����
	}
	
	// �o�^�σr�b�g�}�b�v����@�\���`�F�b�N
	if (FALSE == m_ptr.GetCapRecBitmap())
	{
		// �o�^�σr�b�g�}�b�v����
		// OnOutputReceipt > ����
	}
}

// ���V�[�g���S�o�^
VOID OnRegisterLogo(const string& filePath)
{
	cout << ">>> OnRegisterLogo" << endl;
	
	LONG rc = -1;
	LONG lRetryCount = 0;
	if (TRUE == g_ptr.GetCapRecBitmap())
	{
		lRetryCount = 0;

		do {
			// �r�b�g�}�b�v�̓o�^
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

// ���V�[�g�o��
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
		cout << "���̃v�����^�[�ɂ̓��V�[�g�X�e�[�V����������܂���B" << endl;
		return;
	}

	if (bAsync) g_ptr.SetAsyncMode(TRUE);

	g_ptr.TransactionPrint(PTR_S_RECEIPT, PTR_TP_TRANSACTION);
	if (OPOS_SUCCESS != g_ptr.GetResultCode())
	{
		cout << "POS�v�����^�[���g�p�ł��܂���B" << endl;
		return;
	}

	while (1)
	{
		/////////////////////////////////////////////////
		// Header��

		if (g_ptr.GetCapRecBitmap())
		{
			// �r�b�g�}�b�v��
			g_ptr.PrintNormal(PTR_S_RECEIPT, esc + "|1B");
		}

		/////////////////////////////////////////////////
		// Body��
		
		// �e�L�X�g��
		g_ptr.PrintNormal(PTR_S_RECEIPT, textData.c_str());

		/////////////////////////////////////////////////
		// Footer��
		
		if (g_ptr.GetCapRecBarCode())
		{
			// �o�[�R�[�h�󎚁i�o�[�R�[�h�����񍞂݁j
			string barcode = "{C" + bcData;		// CODE-C�^�C�v
			g_ptr.PrintBarCode(PTR_S_RECEIPT, barcode.c_str(), PTR_BCS_Code128_Parsed, 700, BC_WIDTH(bcData.length() + 1), PTR_BC_CENTER, PTR_BC_TEXT_BELOW);
			//cout << "RecLineWidth: " << g_ptr.GetRecLineWidth() << endl;	// 5406
			if (OPOS_SUCCESS != g_ptr.GetResultCode())
			{
				cout << "�o�[�R�[�h�󎚂ł��܂���B" << endl;
			}
		}

		// �]��
		g_ptr.PrintNormal(PTR_S_RECEIPT, esc + "|200uF");

		/////////////////////////////////////////////////

		// ���V�[�g�J�b�g
		sBuf.Format("|%dlF", g_ptr.GetRecLinesToPaperCut());
		g_ptr.PrintNormal(PTR_S_RECEIPT, esc + sBuf);
		if (g_ptr.GetCapRecPapercut()) g_ptr.CutPaper(98);	// 100:�t���J�b�g, 1�`99:�o�[�V�����J�b�g, 0:�J�b�g�Ȃ�
		if (OPOS_SUCCESS == g_ptr.GetResultCode()) break;

		// �G���[����
		cout << "Fails to output to a printer." << endl;
		//g_ptr.ClearOutput();	// ���g���C�̏ꍇ
		//bExit = TRUE; break;	// �L�����Z���̏ꍇ
		break;
	}

	// �L�����Z���łȂ��ꍇ
	if (!bExit)
	{
		if (!bAsync)
		{
			// �f�o�C�X���uOPOS_S_IDLE�v�ɂȂ�܂őҋ@
			while (OPOS_S_IDLE != g_ptr.GetState());
		}

		g_ptr.TransactionPrint(PTR_S_RECEIPT, PTR_TP_NORMAL);
		if (OPOS_SUCCESS != g_ptr.GetResultCode())
		{
			sRC.Format("%ld", g_ptr.GetResultCode());
			sRCE.Format("%ld", g_ptr.GetResultCodeExtended());
			cout << "Cannot use a POS Printer\nResultCode = " + sRC + "\nResultCodeExtended = " + sRCE << endl;

			// ������ɃG���[�����������ꍇ�A�o�b�t�@�ɂ͈���f�[�^���ێ�����邽�߁A�o�b�t�@�����O���ꂽ�f�[�^���N���A����
			g_ptr.ClearOutput();
		}
	}

	if (bAsync) g_ptr.SetAsyncMode(FALSE);
}

// �r�b�g�}�b�v�̃_�C���N�g���
VOID OnPrintBitmapDirect(const string& filePath)
{
	cout << ">>> OnPrintBitmapDirect" << endl;

	CFile		bitmapFile;
	CString		strBitmapData;
	BYTE		byBuffer;
	CString 	sRC;
	CString 	sRCE;

	// �r�b�g�}�b�v�t�@�C���ǂݍ���
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

	// �r�b�g�}�b�v���o��
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

// �v�����^�J�o�[�J��ԑ��M
VOID OnGetStatCover()
{
	//cout << ">>> Get status cover." << endl;

	// �v�����^�J�o�[�J���
	BOOL bSend = FALSE;
	switch (g_stateCover)
	{
	case STAT_COVER_CLOSE:	// �J�o�[��
		g_pDataRcv.statCover = PTR_STAT_COVER_CLOSE;
		bSend = TRUE;
		break;
	case STAT_COVER_OPEN:	// �J�o�[�J
		g_pDataRcv.statCover = PTR_STAT_COVER_OPEN;
		bSend = TRUE;
		break;
	case STAT_DISCONNECTED:	// ��ڑ����
	default:
		break;
	}

	// �A�v�����֑��M
	if (bSend)
	{
		g_pDataRcv.error = PTR_EPTR_NO_ERROR;
		g_rpc.OnSend(&g_pDataRcv);
	}
}

// ���V�[�g�p���L����ԑ��M
VOID OnGetStatPaper()
{
	//cout << ">>> Get status paper." << endl;

	// ���V�[�g�p���L�����
	BOOL bSend = FALSE;
	switch (g_statePaper)
	{
	case STAT_PAPER_EXIST:	// ���V�[�g�p���L��
		g_pDataRcv.statPaper = PTR_STAT_PAPER_EXIST;
		bSend = TRUE;
		break;
	case STAT_PAPER_EMPTY:	// ���V�[�g�p������
		g_pDataRcv.statPaper = PTR_STAT_PAPER_EMPTY;
		bSend = TRUE;
		break;
	case STAT_DISCONNECTED:
	default:
		break;
	}
	
	// �A�v�����֑��M
	if (bSend)
	{
		g_pDataRcv.error = PTR_EPTR_NO_ERROR;
		g_rpc.OnSend(&g_pDataRcv);
	}
}