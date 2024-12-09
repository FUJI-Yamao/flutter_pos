#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../OposSystem/OposDebug.h"
#include "ScannerAPI.h"

void ExecuteScannerTest();

int main()
{
    // OPOS制御結果
    LONG pRC = -1;

    cout << "------- Test Start -------" << endl;
    ExecuteScannerTest();
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
    SingletonFinalizer::Finalize();
}

void ExecuteScannerTest()
{
    INT ret = -1;
    ret = OpenScn(VS_RELEASE_GENERATE_PATH SCAN_RCV);
    printf("OpenScan() : %d\n", ret);

    printf("Incomming...\n");

    // MEMO: デバイスによるミリ秒単位の連続したイベント受付によるメッセージキューの処理は持たない。
    //		 ループ受付中に最後に受け付けたデータのみを受け取る。
    UINT i = 0;
    while (1)
    {
        if (0 < GetScanCntRef())
        {
            printf("Data : %s,%s,%s\n",
                GetScanData(),
                GetScanType(),
                GetScanLabel());
            ReleaseScan();
            i++;
            if (5 == i)     // 5回受信後終了
            {
                break;
            }
        }
    }

    ret = CloseScn();
    printf("\nCloseScan() : %d\n", ret);
}