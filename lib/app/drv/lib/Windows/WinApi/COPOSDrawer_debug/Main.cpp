#include "../OposSystem/stdafx.h"
#include "OPOSDrawer.h"
#include "RpcManager.h"
#include "../COpos/COposDrw.h"

#define SIZE_OF_ARRAY(array) (sizeof(array)/sizeof(array[0]))

static unique_ptr<RpcManager> g_rpc;
static BOOL isOpened = FALSE;
static UINT g_cnt = 0;

// ドロア情報
struct DrwInfo
{
	unsigned long drwStat;
	unsigned long drwError;
};

// 送信情報
const DrwInfo dInfoList[] =
{
	{ DRW_STAT_CLOSE, DRW_EPTR_NO_ERROR },
	{ DRW_STAT_OPEN, DRW_EPTR_NO_ERROR },
};

int main()
{
	g_rpc.reset(new RpcManager());

    // 初期化
    cout << "DrwRcv.exe start." << endl;
	g_rpc->OnInit();

	// プロセス終了待機
	while (1);

    // 解放
    //g_rpc->OnDestroy();
}

VOID OnDrawerOpen()
{
	cout << ">>> Drawer open." << endl;
	isOpened = TRUE;
}

VOID OnGetDrawerOpened()
{
	cout << ">>> Get drawer opened." << endl;

	DRW_DATA_RCV dDataRcv;

	// データインプット
	if (!isOpened)
	{
		srand((unsigned)time(NULL));
		USHORT v = rand() % SIZE_OF_ARRAY(dInfoList);	// 0～size
		dDataRcv.drwStat = dInfoList[v].drwStat;
		dDataRcv.drwError = dInfoList[v].drwError;
	}
	else
	{
		dDataRcv.drwStat = DRW_STAT_OPEN;
		dDataRcv.drwError = DRW_EPTR_NO_ERROR;
	}

	// データ送信
	cout << ">>> "
		<< ++g_cnt << " : "
		<< "Status " << dDataRcv.drwStat << " , "
		<< "Error " << dDataRcv.drwError
		<< endl;
	g_rpc->OnSend(&dDataRcv);
}