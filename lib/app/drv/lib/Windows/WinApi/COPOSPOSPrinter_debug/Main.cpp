#include "../OposSystem/stdafx.h"
#include "OPOSPOSPrinter.h"
#include "RpcManager.h"
#include "../COpos/COposPtr.h"

#define SIZE_OF_ARRAY(array) (sizeof(array)/sizeof(array[0]))

static PTR_DATA_RCV g_pDataRcv;
static unique_ptr<RpcManager> g_rpc;
static UINT g_cnt = 0;

// プリンタカバー情報
struct PtrCoverInfo
{
	unsigned long statCover;
	unsigned long error;
};

// レシート情報
struct PtrPaperInfo
{
	unsigned long statPaper;
	unsigned long error;
};

/////////////////////////////////////////////
// 送信情報
// 
// Xの確率をY回転した時の当る確率
// 1-((1-X)^Y)

// ⇒ 確率1/3 : 5回転で86.8%
const PtrCoverInfo pCoverInfoList[] =
{
	{ PTR_STAT_NONE, PTR_EPTR_NO_ERROR },			// 非接続状態
	{ PTR_STAT_COVER_CLOSE, PTR_EPTR_NO_ERROR },	// 正常
	{ PTR_STAT_COVER_OPEN, PTR_EPTR_NO_ERROR },
};

// ⇒ 確率1/2 : 5回転で96.9%
const PtrPaperInfo pPaperInfoList[] =
{
	{ PTR_STAT_NONE, PTR_EPTR_NO_ERROR },				// 非接続状態
	{ PTR_STAT_PAPER_EXIST, PTR_EPTR_NO_ERROR },		// 正常
	{ PTR_STAT_PAPER_NEAREMPTY, PTR_EPTR_NO_ERROR },	// 正常
	{ PTR_STAT_PAPER_EMPTY, PTR_EPTR_NO_ERROR },
};

int main()
{
	g_rpc.reset(new RpcManager());

    // 初期化
    cout << "PtrRcv.exe start." << endl;
	g_rpc->OnInit();

	// プロセス終了待機
	while (1);

    // 解放
    //g_rpc->OnDestroy();
}

// レシートロゴ登録
VOID OnRegisterLogo(const string& filePath)
{
	cout << ">>> Logo register." << endl;
	cout << "Path: " << filePath << endl;
}

// レシート出力
VOID OnOutputReceipt(const string& textData, const string& bcData)
{
	cout << ">>> Receipt output." << endl;
	cout << textData << endl;
	cout << "Barcode: " << bcData << endl;
}

// プリンタカバー開閉状態送信
VOID OnGetStatCover()
{
	cout << ">>> Get status cover." << endl;

	// データインプット
	srand((unsigned)time(NULL));
	USHORT v = rand() % SIZE_OF_ARRAY(pCoverInfoList);	// 0～size
	g_pDataRcv.statCover = pCoverInfoList[v].statCover;
	g_pDataRcv.error = pCoverInfoList[v].error;

	// データ送信
	cout << ">>> "
		<< ++g_cnt << " : "
		<< "StatusCover " << g_pDataRcv.statCover << " , "
		<< "Error " << g_pDataRcv.error
		<< endl;
	g_rpc->OnSend(&g_pDataRcv);
}

// レシート用紙有無状態送信
VOID OnGetStatPaper()
{
	cout << ">>> Get status paper." << endl;

	// データインプット
	srand((unsigned)time(NULL));
	USHORT v = rand() % SIZE_OF_ARRAY(pPaperInfoList);	// 0～size
	g_pDataRcv.statPaper = pPaperInfoList[v].statPaper;
	g_pDataRcv.error = pPaperInfoList[v].error;

	// データ送信
	cout << ">>> "
		<< ++g_cnt << " : "
		<< "StatusPaper " << g_pDataRcv.statPaper << " , "
		<< "Error " << g_pDataRcv.error
		<< endl;
	g_rpc->OnSend(&g_pDataRcv);
}