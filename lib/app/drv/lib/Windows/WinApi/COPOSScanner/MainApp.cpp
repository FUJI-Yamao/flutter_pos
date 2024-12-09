#include "mfcafx.h"
#include "MainApp.h"
#include "OPOSScanner.h"
#include "RpcManager.h"
#include "../OposSystem/Console.h"

static RpcManager& g_rpc = Singleton<RpcManager>::GetInstance();

MainApp::MainApp()
{
#ifdef _DEBUG
	// �f�o�b�O�p�R���\�[������
	Console con;
#endif
}

MainApp theApp;

BOOL MainApp::InitInstance()
{
	AfxEnableControlContainer();

	if (S_OK != g_rpc.OnInit())
	{
		cout << "RPC�̏������Ɏ��s���܂����B�I�����܂�..." << endl;
		Sleep(2000);
		exit(0);
	}

	// ���C���E�B���h�E�v���Z�X�ɓo�^
	COPOSScanner scanner;
	m_pMainWnd = &scanner;
	int nResponse = scanner.DoModal();

	// �����[�X�p�R���\�[������
	//Console con;
	cout << "Scanner >>> OCX���L���ł͂���܂���B�m�F���Ă�������..." << endl;

	// �v���Z�X�L���ҋ@�iOCX���L���łȂ��ꍇ�ɁuRemote Procedure Call failed.�v���������j
	while (1);

	return FALSE;
}