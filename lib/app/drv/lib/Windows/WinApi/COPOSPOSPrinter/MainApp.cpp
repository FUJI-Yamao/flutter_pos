#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSPOSPrinter.h"
#include "RpcManager.h"
#include "../OposSystem/Console.h"

static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();

MainApp::MainApp()
{
#ifdef _DEBUG
	// デバッグ用コンソール生成
	Console con;
#endif
}

MainApp theApp;

BOOL MainApp::InitInstance()
{
	AfxEnableControlContainer();

	if (S_OK != g_rpc.OnInit())
	{
		cout << "RPCの初期化に失敗しました。終了します..." << endl;
		Sleep(2000);
		exit(0);
	}

	// メインウィンドウプロセスに登録
	COPOSPOSPrinter printer;
	m_pMainWnd = &printer;
	int nResponse = printer.DoModal();

	// リリース用コンソール生成
	//Console con;
	cout << "POSPrinter >>> OCXが有効ではありません。確認してください..." << endl;

	// プロセスキル待機（OCXが有効でない場合に「Remote Procedure Call failed.」を回避する）
	while (1);

	return FALSE;
}