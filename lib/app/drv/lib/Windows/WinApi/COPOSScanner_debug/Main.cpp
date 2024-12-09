#include "../OposSystem/stdafx.h"
#include "RpcManager.h"

// �X�L�������
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

    // ������
    cout << "ScanRcv.exe start." << endl;
    rpc->OnInit();

	// ���M�e�X�g
	////////////////////////////////////////////
	const ScanInfo sInfoList[] =
	{
		{ "F4902102130356", "JAN13", "4902102130356" },	// ����
		{ "F4901085176146", "JAN13", "4901085176146" },	// �ق�����
		{ "F4902888256233", "JAN13", "4902888256233" },	// �_�[�X
	};

	cout << "5 times send." << endl;
	SCAN_DATA sData;
	for (UINT i = 1; i <= 5; i++)	// 5�񑗐M
	{
		srand((unsigned)time(NULL));
		USHORT v = rand() % 3;	// 0�`2

		// �f�[�^�C���v�b�g
		sData.scanData = sInfoList[v].scanData;
		sData.scanType = sInfoList[v].scanType;
		sData.scanLabel = sInfoList[v].scanLabel;

		// �f�[�^���M
		Sleep(2000);
		cout << "-------------------------" << endl;
		cout << ">>> " << i << " : " << sData.scanData << "," << sData.scanType << "," << sData.scanLabel << endl;
		rpc->OnSend(&sData);
	}
	////////////////////////////////////////////

	// �v���Z�X�I���ҋ@
	while (1);

    // ���
    //rpc->OnDestroy();
}