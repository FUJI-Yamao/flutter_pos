#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSDrawer.h"
#include "DrawerAct.h"
#include "RpcManager.h"
#include "../Opos/OposCash.h"
#include "../COpos/COposDrw.h"
#include "../OposSystem/OposDefs.h"

static CCoDrw& g_drw = Singleton<CCoDrw>::GetInstance();
static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();

// �h���A�J���
static BOOL g_isOpened = FALSE;

COPOSDrawer::COPOSDrawer(CWnd* pParent /*=NULL*/) : 
	CDialog(COPOSDrawer::IDD, pParent)
{
	
}

BOOL COPOSDrawer::OnInitDialog()
{
	cout << ">>> OnInit" << endl;
	
	CDialog::OnInitDialog();

	BOOL bError = FALSE;
    while(1)
	{
		LONG rc = -1;

		m_drw.Open(CASHDRAWER_NAME);
		rc = m_drw.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "Open() : " << rc << endl;
			bError = TRUE;
			break;
		}
		
		m_drw.ClaimDevice(1000);
		rc = m_drw.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "ClaimDevice() : " << rc << endl;
			bError = TRUE;
			break;
        }

        // CapPowerReporting ���T�|�[�g����ꍇ�́APower Reporting Requirements ��L���ɂ���
		if (OPOS_PR_NONE != m_drw.GetCapPowerReporting())
		{
			m_drw.SetPowerNotify(OPOS_PN_ENABLED);
		}

		m_drw.SetDeviceEnabled(TRUE);
		rc = m_drw.GetResultCode();
		if (OPOS_SUCCESS != rc)
		{
			cout << "SetDeviceEnabled() : " << rc << endl;
			bError = TRUE;
			break;
		}

        // �h�����[�̊J��Ԃ̊Ď����L�����ǂ������m�F
        if (m_drw.GetCapStatus())
		{
            // �Ď��𖳌��ɂ���(�h���A�J��ԂƓd���X�e�[�^�X�̎擾�����L���ɂ��Ȃ�)
			cout << "Disable monitoring." << endl;
        }

		break;
	}

	if (bError)
	{
		// �G���[����
	}
	
	return TRUE;
}

void COPOSDrawer::DoDataExchange(CDataExchange* pDX)
{
	cout << ">>> DoDataExchange" << endl;
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_CASHDRAWER, m_drw);
}

void COPOSDrawer::OnDestroy() 
{
	m_drw.SetDeviceEnabled(FALSE);
	m_drw.ReleaseDevice();
	m_drw.Close();
	SingletonFinalizer::Finalize();
	g_rpc.OnDestroy();
	CDialog::OnClose();
}

// �C�x���g��t
BEGIN_EVENTSINK_MAP(COPOSDrawer, CDialog)	// �v���Z�X�_�~�[�x�[�X
	ON_EVENT(COPOSDrawer, IDC_CASHDRAWER, 5 /* StatusUpdateEvent */, OnStatusUpdateEventDrawer, VTS_I8)
END_EVENTSINK_MAP()

void COPOSDrawer::OnStatusUpdateEventDrawer(long Data) 
{
	cout << ">>> OnStatusUpdateEventDrawer" << endl;

	DRW_DATA_RCV dDataRcv;

	switch (Data)
	{
	// �h���A�J��ԁF�h���A�J�̏ꍇ�G���[�o��
	case CASH_SUE_DRAWERCLOSED:		// �h���A��
		dDataRcv.drwStat = DRW_STAT_CLOSE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		g_isOpened = FALSE;	// Enable Open Drawer
		break;
	case CASH_SUE_DRAWEROPEN:		// �h���A�J
		g_isOpened = TRUE;	// Disable Open Drawer
		dDataRcv.drwStat = DRW_STAT_OPEN;

		// �G���[���
		//switch (m_drw.GetResultCodeExtended())
		//{
		//default:
		//	if (OPOS_SUCCESS != m_drw.GetResultCode())
		//	{
		//		cout << "error�F�����s��" << endl;
		//		dDataRcv.drwError = DRW_EPTR_FAIL;
		//	}
		//}
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;

		g_rpc.OnSend(&dDataRcv);
		break;
    
	// �d���X�e�[�^�X�FPower Reporting Requirements �́A�f�o�C�X�̓d���X�e�[�^�X���ύX���ꂽ�Ƃ��ɃC�x���g�𔭐�������
	case OPOS_SUE_POWER_ONLINE:			// �f�o�C�X�̓d�����I���ɂȂ��Ă��܂��B
		cout << "Power ready." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_ONLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFF:			// �f�o�C�X�̓d�����I�t�ɂȂ��Ă��邩�A�ڑ�����Ă��܂���B
		cout << "Power off." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFF;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFFLINE:		// �f�o�C�X�̓d���͓����Ă��܂����A����𖳌��ɂ��Ă��܂��B
		cout << "Power not ready." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFFLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFF_OFFLINE:	// �f�o�C�X�̓d�����I�t�܂��̓I�t���C���ł��B
		cout << "Power offline" << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFF_OFFLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	}
}

// �h���A�I�[�v��
VOID OnDrawerOpen()
{
	cout << ">>> OnDrawerOpen" << endl;
	if (!g_isOpened)
	{
		cout << ">>> Drawer open." << endl;
		g_drw.OpenDrawer();
	}
	else
	{
		cout << ">>> Drawer is already open." << endl;
	}
}

// �h���A�J��ԑ��M
VOID OnGetDrawerOpened()
{
	//cout << ">>> OnGetDrawerOpened" << endl;

	DRW_DATA_RCV dDataRcv;

	// �h���A�J��ԁF�h���A�J�̏ꍇ�G���[�o��
	if (TRUE == g_drw.GetDrawerOpened())	// �h���A�J
	{
		g_isOpened = TRUE;	// Disable Open Drawer
		dDataRcv.drwStat = DRW_STAT_OPEN;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
	}
	else									// �h���A��
	{
		dDataRcv.drwStat = DRW_STAT_CLOSE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		g_isOpened = FALSE;	// Enable Open Drawer
	}
}