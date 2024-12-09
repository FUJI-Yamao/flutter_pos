#include "../OposSystem/stdafx.h"
#include "OPOSPOSPrinter.h"
#include "RpcManager.h"
#include "../COpos/COposPtr.h"

#define SIZE_OF_ARRAY(array) (sizeof(array)/sizeof(array[0]))

static PTR_DATA_RCV g_pDataRcv;
static unique_ptr<RpcManager> g_rpc;
static UINT g_cnt = 0;

// �v�����^�J�o�[���
struct PtrCoverInfo
{
	unsigned long statCover;
	unsigned long error;
};

// ���V�[�g���
struct PtrPaperInfo
{
	unsigned long statPaper;
	unsigned long error;
};

/////////////////////////////////////////////
// ���M���
// 
// X�̊m����Y��]�������̓���m��
// 1-((1-X)^Y)

// �� �m��1/3 : 5��]��86.8%
const PtrCoverInfo pCoverInfoList[] =
{
	{ PTR_STAT_NONE, PTR_EPTR_NO_ERROR },			// ��ڑ����
	{ PTR_STAT_COVER_CLOSE, PTR_EPTR_NO_ERROR },	// ����
	{ PTR_STAT_COVER_OPEN, PTR_EPTR_NO_ERROR },
};

// �� �m��1/2 : 5��]��96.9%
const PtrPaperInfo pPaperInfoList[] =
{
	{ PTR_STAT_NONE, PTR_EPTR_NO_ERROR },				// ��ڑ����
	{ PTR_STAT_PAPER_EXIST, PTR_EPTR_NO_ERROR },		// ����
	{ PTR_STAT_PAPER_NEAREMPTY, PTR_EPTR_NO_ERROR },	// ����
	{ PTR_STAT_PAPER_EMPTY, PTR_EPTR_NO_ERROR },
};

int main()
{
	g_rpc.reset(new RpcManager());

    // ������
    cout << "PtrRcv.exe start." << endl;
	g_rpc->OnInit();

	// �v���Z�X�I���ҋ@
	while (1);

    // ���
    //g_rpc->OnDestroy();
}

// ���V�[�g���S�o�^
VOID OnRegisterLogo(const string& filePath)
{
	cout << ">>> Logo register." << endl;
	cout << "Path: " << filePath << endl;
}

// ���V�[�g�o��
VOID OnOutputReceipt(const string& textData, const string& bcData)
{
	cout << ">>> Receipt output." << endl;
	cout << textData << endl;
	cout << "Barcode: " << bcData << endl;
}

// �v�����^�J�o�[�J��ԑ��M
VOID OnGetStatCover()
{
	cout << ">>> Get status cover." << endl;

	// �f�[�^�C���v�b�g
	srand((unsigned)time(NULL));
	USHORT v = rand() % SIZE_OF_ARRAY(pCoverInfoList);	// 0�`size
	g_pDataRcv.statCover = pCoverInfoList[v].statCover;
	g_pDataRcv.error = pCoverInfoList[v].error;

	// �f�[�^���M
	cout << ">>> "
		<< ++g_cnt << " : "
		<< "StatusCover " << g_pDataRcv.statCover << " , "
		<< "Error " << g_pDataRcv.error
		<< endl;
	g_rpc->OnSend(&g_pDataRcv);
}

// ���V�[�g�p���L����ԑ��M
VOID OnGetStatPaper()
{
	cout << ">>> Get status paper." << endl;

	// �f�[�^�C���v�b�g
	srand((unsigned)time(NULL));
	USHORT v = rand() % SIZE_OF_ARRAY(pPaperInfoList);	// 0�`size
	g_pDataRcv.statPaper = pPaperInfoList[v].statPaper;
	g_pDataRcv.error = pPaperInfoList[v].error;

	// �f�[�^���M
	cout << ">>> "
		<< ++g_cnt << " : "
		<< "StatusPaper " << g_pDataRcv.statPaper << " , "
		<< "Error " << g_pDataRcv.error
		<< endl;
	g_rpc->OnSend(&g_pDataRcv);
}