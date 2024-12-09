#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../OposSystem/OposDebug.h"
#include "POSKeyboardAPI.h"

void ExecutePOSKeyboardTest();

int main()
{
    // OPOS制御結果
    LONG pRC = -1;

    cout << "------- Test Start -------" << endl;
    ExecutePOSKeyboardTest();
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
    SingletonFinalizer::Finalize();
}

VOID StartKeyHook()
{
    OpenMkey();
}

void ExecutePOSKeyboardTest()
{
    // キーフック開始
    thread thKeyHook(StartKeyHook);
    thKeyHook.detach();
    cout << "OpenMkey()" << endl;

    // 監視ループ
    BOOL bStroke = TRUE;
    while (1)
    {
        if (GetStrokeStat() && bStroke)
        {
            LPCSTR key = GetKey();
            if ("0xFF" == key)
            {
                break;
            }
            else
            {
                cout << key << endl;
            }
            bStroke = FALSE;
        }
        else if (!GetStrokeStat())
        {
            bStroke = TRUE;
        }
    }

    // キーフック終了
    CloseMkey();
    cout << "CloseMkey()" << endl;

    cin.get();      // フック解除確認
}