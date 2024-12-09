#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../OposSystem/OposDebug.h"
#include "../COpos/COposDrw.h"
#include "CashDrawerAPI.h"

static void ExecuteCashDrawerTest();

int main()
{
    // OPOS制御結果
    LONG pRC = -1;

    cout << "------- Test Start -------" << endl;
    ExecuteCashDrawerTest();
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
    SingletonFinalizer::Finalize();
}

void ExecuteCashDrawerTest()
{
    INT ret = -1;

    // Flutterアプリ初期化時
    ret = OpenDrwDIOPort(TERAOKA_PROCESS_PATH TRK03_GPIO_RW);
    printf("OpenDrwDIOPort() : %d\n", ret);
    Sleep(3000);

    cout << "DIOProcessID(Create) : " << GetCreDIOPortProcId() << endl;
    cout << "DIOProcessID(Real) : " << GetRealDIOPortProcId() << endl;
    ret = OpenDrwEvent(VS_RELEASE_GENERATE_PATH DRW_RCV);
    printf("OpenDrwEvent() : %d\n", ret);

    printf("Incomming...\n");

    // MEMO: デバイスによるミリ秒単位の連続したイベント受付によるメッセージキューの処理は持たない。
    //		 ループ受付中に最後に受け付けたデータのみを受け取る。
    BOOL isOpened = FALSE;
    while (1)
    {
        InqDrwOpened(); // ドロア開閉状態問合せ
        if (0 < GetDrwCntRef())
        {
            INT drwStat = GetDrwStat();
            printf("Data : %d\n", drwStat);
            switch (drwStat)
            {
            case 0:     // ドロア開の場合
                cout << "Drawer is opened." << endl;
                isOpened = TRUE;
                break;
            case 1:     // ドロア閉の場合
                ret = OpenDrw();
                printf("OpenDrw() : %d\n", ret);
                break;
            default:
                break;
            }
            ReleaseDrw();
            
            // ドロア開の場合break
            if (isOpened) break;
        }
    }

    ret = CloseDrwEvent();
    printf("\nCloseDrwEvent() : %d\n", ret);
    ret = CloseDrwDIOPort();
    printf("\nCloseDrwDIOPort() : %d\n", ret);
    
    cout << "DIOProcessID(Create) : " << GetCreDIOPortProcId() << endl;
    cout << "DIOProcessID(Real) : " << GetRealDIOPortProcId() << endl;
}