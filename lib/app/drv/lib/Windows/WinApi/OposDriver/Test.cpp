#include "../OposSystem/stdafx.h"
#include "Test.h"
#include "DebugControl.h"

#ifdef _WIN64
#include "../OposIf64/CashDrawer.h"
#include "../OposIf64/Scanner.h"
#include "../OposIf64/POSPrinter.h"
#include "../OposIf64/POSKeyboard.h"
#else
#include "../OposIf32/CashDrawer.h"
#include "../OposIf32/Scanner.h"
#include "../OposIf32/POSPrinter.h"
#include "../OposIf32/POSKeyboard.h"
#endif

// デバイス名
#define CASHDRAWER_NAME "Web3800Drawer"
#define SCANNER_NAME "TeraokaScanner"
#define POSPRINTER_NAME "CAP06-347"
#define POSKEYBOARD_NAME "Web2400Keyboard"

#define SAFE_RELEASE(x) if(x) x->Release();

using namespace std;

void CashDrawerTest(LONG* pRC);
void ScannerTest(LONG* pRC);
void POSPrinterTest(LONG* pRC);
void POSKeyboardTest(LONG* pRC);

#ifdef TEST_MAIN
int main()
{
    LONG ret = 0;
    LONG* pRC = &ret;

    cout << "------- Test Start -------" << endl;
    CashDrawerTest(pRC);
    ScannerTest(pRC);
    POSPrinterTest(pRC);
    POSKeyboardTest(pRC);
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
}
#endif

void CashDrawerTest(LONG* pRC)
{
    DebugControl debugCtrl;

    HRESULT hr;
    cout << ">>> " << "CashDrawer - " CASHDRAWER_NAME << endl;

    hr = ::CoInitialize(NULL);

    if (FAILED(hr))
    {
        cout << "CoInitialize Failed." << endl;
        return;
    }

    IOPOSCashDrawer* pICashDrawer = NULL;

    hr = CoCreateInstance(
        __uuidof(OPOSCashDrawer),
        NULL,
        CLSCTX_ALL,
        __uuidof(IOPOSCashDrawer),
        (void**)&pICashDrawer);

    if (SUCCEEDED(hr))
    {
        hr = pICashDrawer->Open((BSTR)_T(CASHDRAWER_NAME), pRC);
        debugCtrl.SetDebugInfo("Open()", *pRC);
        SAFE_RELEASE(pICashDrawer);
    }
    else
    {
        cout << "CCI Failed. " << hr << endl;
    }

    ::CoUninitialize();

    debugCtrl.DebugLog(CASHDRAWER_NAME " : ACCESS LOG");
}

void ScannerTest(LONG* pRC)
{
    DebugControl debugCtrl;

    HRESULT hr;
    cout << ">>> " << "Scanner - " SCANNER_NAME << endl;

    hr = ::CoInitialize(NULL);

    if (FAILED(hr))
    {
        cout << "CoInitialize Failed." << endl;
        return;
    }

    IOPOSScanner* pIScanner = NULL;

    hr = CoCreateInstance(
        __uuidof(OPOSScanner),
        NULL,
        CLSCTX_ALL,
        __uuidof(IOPOSScanner),
        (void**)&pIScanner);

    if (SUCCEEDED(hr))
    {
        hr = pIScanner->Open((BSTR)_T(SCANNER_NAME), pRC);
        debugCtrl.SetDebugInfo("Open()", *pRC);
        SAFE_RELEASE(pIScanner);
    }
    else
    {
        cout << "CCI Failed. " << hr << endl;
    }

    ::CoUninitialize();

    debugCtrl.DebugLog(SCANNER_NAME " : ACCESS LOG");
}

void POSPrinterTest(LONG* pRC)
{
    DebugControl debugCtrl;

    HRESULT hr;
    cout << ">>> " << "POSPrinter - " POSPRINTER_NAME << endl;

    hr = ::CoInitialize(NULL);

    if (FAILED(hr))
    {
        cout << "CoInitialize Failed." << endl;
        return;
    }

    IOPOSPOSPrinter* pIPOSPrinter = NULL;

    hr = CoCreateInstance(
        __uuidof(OPOSPOSPrinter),
        NULL,
        CLSCTX_ALL,
        __uuidof(IOPOSPOSPrinter),
        (void**)&pIPOSPrinter);

    if (SUCCEEDED(hr))
    {
        hr = pIPOSPrinter->Open((BSTR)_T(POSPRINTER_NAME), pRC);
        debugCtrl.SetDebugInfo("Open()", *pRC);
        SAFE_RELEASE(pIPOSPrinter);
    }
    else
    {
        cout << "CCI Failed. " << hr << endl;
    }

    ::CoUninitialize();

    debugCtrl.DebugLog(POSPRINTER_NAME " : ACCESS LOG");
}

void POSKeyboardTest(LONG* pRC)
{
    DebugControl debugCtrl;

    HRESULT hr;
    cout << ">>> " << "POSKeyboard - " POSKEYBOARD_NAME << endl;

    hr = ::CoInitialize(NULL);

    if (FAILED(hr))
    {
        cout << "CoInitialize Failed." << endl;
        return;
    }

    IOPOSPOSKeyboard* pIPOSKeyboard = NULL;

    hr = CoCreateInstance(
        __uuidof(OPOSPOSKeyboard),
        NULL,
        CLSCTX_ALL,
        __uuidof(IOPOSPOSKeyboard),
        (void**)&pIPOSKeyboard);

    if (SUCCEEDED(hr))
    {
        hr = pIPOSKeyboard->Open((BSTR)_T(POSKEYBOARD_NAME), pRC);
        debugCtrl.SetDebugInfo("Open()", *pRC);
        SAFE_RELEASE(pIPOSKeyboard);
    }
    else
    {
        cout << "CCI Failed. " << hr << endl;
    }

    ::CoUninitialize();

    debugCtrl.DebugLog(POSKEYBOARD_NAME " : ACCESS LOG");
}