#include "../OposSystem/stdafx.h"
#include "POSKeyboardControl.h"

POSKeyboardControl::POSKeyboardControl() :
    m_hhKbd(NULL)
{
    keyInfo = {};   // ゼロ初期化
}

POSKeyboardControl::~POSKeyboardControl()
{
    
}

VOID POSKeyboardControl::OpenPOSKeyboard()
{
    // フック取得
    m_hhKbd = SetWindowsHookEx(WH_KEYBOARD_LL, LowLevelKbdProc, 0, 0);

    // シグナル受信状態
    MSG msg;
    if (!GetMessage(&msg, NULL, NULL, NULL))
    {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
}

VOID POSKeyboardControl::ClosePOSKeyboard()
{
    PostQuitMessage(0);
    UnhookWindowsHookEx(m_hhKbd);
}

VOID POSKeyboardControl::KeyboardDebugLog()
{
    SetResCodeStrings();

    cout << ">>> POSKeyboard" << endl;

    list<DebugInfo>::iterator ite = m_debugInfoList.begin();
    for (; ite != m_debugInfoList.end(); ++ite)
    {
        cout << ite->m_label << " : " << ite->m_resCodeString << endl;
    }
}