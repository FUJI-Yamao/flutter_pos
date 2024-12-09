// OPOS制御メモ
/**************************************************
// WindowsOPOSのアーキテクチャ指定
EXE：x86
OCX：x86
SO：x86

// 64ビットで動作するために実装
EXE：x64
OCX：x64
SO：x64

※注意
WindowsPOS内のCPUアーキテクチャは64bitだが、
SOが32bitであるためEXEとOCXも32bitで統一する必要がある。
⇒Flutterアプリが64ビットであるため32ビットで確認後、64ビットに変更する

// IDispatchオーバーライド
IDispatch::GetTypeInfoCount
IDispatch::GetTypeInfo
IDispatch::GetIDsOfNames
IDispatch::Invoke
IUnknown::QueryInterface(const IID &riid, void **ppvObject)
IUnknown::AddRef
IUnknown::Release

// レジストリサブキー（regedit）
HKEY_LOCAL_MACHINE
SOFTWARE\\OLEforRetail\\ServiceOPOS\\CashDrawer
SOFTWARE\\OLEforRetail\\ServiceOPOS\\Scanner
SOFTWARE\\OLEforRetail\\ServiceOPOS\\POSPrinter
SOFTWARE\\OLEforRetail\\ServiceOPOS\\POSKeyboard

// デバイス名
Web3800Drawer
TeraokaScanner
CAP06-347
Web2400Keyboard

// サービスオブジェクト
Web3800Drawer
    > Service - C:\\OPOS\\Teraoka\\bin\\Web3800Drawer.dll
TeraokaScanner
    > Service - C:\\OPOS\\Teraoka\\bin\\TeraokaScannerSO.dll
CAP06-347
    > CoreSODLLPath - C:\Program Files (x86)\SII\OPOS\POSPrinterCoreSO.dll
    > SubSODLLPath - C:\Program Files (x86)\SII\OPOS\CAP06POSPrinterSubSO.dll
Web2400Keyboard
    > Service - C:\\OPOS\\Teraoka\\bin\\Web2400Keyboard.dll

// レジストリ編集
regsvr32 /s [OcxPath and ServicePath]   // 登録
regsvr32 /u [OcxPath and ServicePath]   // 解除

// ドロアDIO-RWプログラム（遅くてもコマンド送信のOpenDrawer前にプロセス稼働必須）
trk03_gpio_rw.exe
⇒DIOポートオープン

tasklist                    // プロセス確認
taskkill /pid [ProcessID]   // プロセス強制終了
**************************************************/

#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../OposSystem/OposDebug.h"
#include "Test.h"

#ifndef TEST_MAIN
void ExecuteCashDrawer();
void ExecuteScanner();
void ExecutePOSPrinter();
void ExecutePOSKeyboard();

int main()
{
    // OPOS制御結果
    LONG pRC = -1;

    cout << "------- Test Start -------" << endl;
    //ExecuteCashDrawer();
    //ExecuteScanner();
    //ExecutePOSPrinter();
    //ExecutePOSKeyboard();
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
}

void ExecuteCashDrawer()
{
    
}

void ExecuteScanner()
{
    
}

void ExecutePOSPrinter()
{
    
}

void ExecutePOSKeyboard()
{
    
}
#endif