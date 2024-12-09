#include "../OposSystem/stdafx.h"
#include "POSKeyboardControl.h"

POSKeyboardControl::POSKeyboardControl() :
    m_hhKbd(NULL)
{
    keyInfo = {};   // �[��������
}

POSKeyboardControl::~POSKeyboardControl()
{
    
}

VOID POSKeyboardControl::OpenPOSKeyboard()
{
    // �t�b�N�擾
    m_hhKbd = SetWindowsHookEx(WH_KEYBOARD_LL, LowLevelKbdProc, 0, 0);

    // �V�O�i����M���
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