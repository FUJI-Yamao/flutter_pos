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

// ドロア開閉状態
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

        // CapPowerReporting をサポートする場合は、Power Reporting Requirements を有効にする
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

        // ドロワーの開閉状態の監視が有効かどうかを確認
        if (m_drw.GetCapStatus())
		{
            // 監視を無効にする(ドロア開閉状態と電源ステータスの取得操作を有効にしない)
			cout << "Disable monitoring." << endl;
        }

		break;
	}

	if (bError)
	{
		// エラー処理
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

// イベント受付
BEGIN_EVENTSINK_MAP(COPOSDrawer, CDialog)	// プロセスダミーベース
	ON_EVENT(COPOSDrawer, IDC_CASHDRAWER, 5 /* StatusUpdateEvent */, OnStatusUpdateEventDrawer, VTS_I8)
END_EVENTSINK_MAP()

void COPOSDrawer::OnStatusUpdateEventDrawer(long Data) 
{
	cout << ">>> OnStatusUpdateEventDrawer" << endl;

	DRW_DATA_RCV dDataRcv;

	switch (Data)
	{
	// ドロア開閉状態：ドロア開の場合エラー出力
	case CASH_SUE_DRAWERCLOSED:		// ドロア閉
		dDataRcv.drwStat = DRW_STAT_CLOSE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		g_isOpened = FALSE;	// Enable Open Drawer
		break;
	case CASH_SUE_DRAWEROPEN:		// ドロア開
		g_isOpened = TRUE;	// Disable Open Drawer
		dDataRcv.drwStat = DRW_STAT_OPEN;

		// エラー種別
		//switch (m_drw.GetResultCodeExtended())
		//{
		//default:
		//	if (OPOS_SUCCESS != m_drw.GetResultCode())
		//	{
		//		cout << "error：原因不明" << endl;
		//		dDataRcv.drwError = DRW_EPTR_FAIL;
		//	}
		//}
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;

		g_rpc.OnSend(&dDataRcv);
		break;
    
	// 電源ステータス：Power Reporting Requirements は、デバイスの電源ステータスが変更されたときにイベントを発生させる
	case OPOS_SUE_POWER_ONLINE:			// デバイスの電源がオンになっています。
		cout << "Power ready." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_ONLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFF:			// デバイスの電源がオフになっているか、接続されていません。
		cout << "Power off." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFF;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFFLINE:		// デバイスの電源は入っていますが、操作を無効にしています。
		cout << "Power not ready." << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFFLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	case OPOS_SUE_POWER_OFF_OFFLINE:	// デバイスの電源がオフまたはオフラインです。
		cout << "Power offline" << endl;
		dDataRcv.drwStat = DRW_SUE_POWER_OFF_OFFLINE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		break;
	}
}

// ドロアオープン
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

// ドロア開閉状態送信
VOID OnGetDrawerOpened()
{
	//cout << ">>> OnGetDrawerOpened" << endl;

	DRW_DATA_RCV dDataRcv;

	// ドロア開閉状態：ドロア開の場合エラー出力
	if (TRUE == g_drw.GetDrawerOpened())	// ドロア開
	{
		g_isOpened = TRUE;	// Disable Open Drawer
		dDataRcv.drwStat = DRW_STAT_OPEN;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
	}
	else									// ドロア閉
	{
		dDataRcv.drwStat = DRW_STAT_CLOSE;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
		g_rpc.OnSend(&dDataRcv);
		g_isOpened = FALSE;	// Enable Open Drawer
	}
}