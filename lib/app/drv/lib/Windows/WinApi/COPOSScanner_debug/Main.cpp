#include "../OposSystem/stdafx.h"
#include "RpcManager.h"

// スキャン情報
struct ScanInfo
{
	const char* scanData;
	const char* scanType;
	const char* scanLabel;
};

int main()
{
    unique_ptr<RpcManager> rpc;
    rpc.reset(new RpcManager());

    // 初期化
    cout << "ScanRcv.exe start." << endl;
    rpc->OnInit();

	// 送信テスト
	////////////////////////////////////////////
	const ScanInfo sInfoList[] =
	{
		{ "F4902102130356", "JAN13", "4902102130356" },	// 綾鷹
		{ "F4901085176146", "JAN13", "4901085176146" },	// ほうじ茶
		{ "F4902888256233", "JAN13", "4902888256233" },	// ダース
	};

	cout << "5 times send." << endl;
	SCAN_DATA sData;
	for (UINT i = 1; i <= 5; i++)	// 5回送信
	{
		srand((unsigned)time(NULL));
		USHORT v = rand() % 3;	// 0～2

		// データインプット
		sData.scanData = sInfoList[v].scanData;
		sData.scanType = sInfoList[v].scanType;
		sData.scanLabel = sInfoList[v].scanLabel;

		// データ送信
		Sleep(2000);
		cout << "-------------------------" << endl;
		cout << ">>> " << i << " : " << sData.scanData << "," << sData.scanType << "," << sData.scanLabel << endl;
		rpc->OnSend(&sData);
	}
	////////////////////////////////////////////

	// プロセス終了待機
	while (1);

    // 解放
    //rpc->OnDestroy();
}