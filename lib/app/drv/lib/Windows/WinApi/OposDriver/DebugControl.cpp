#include "../OposSystem/stdafx.h"
#include "DebugControl.h"

DebugControl::DebugControl()
{

}

DebugControl::~DebugControl()
{

}

VOID DebugControl::DebugLog(LPCSTR logName)
{
    SetResCodeStrings();

    cout << ">>> " << logName << endl;

    list<DebugInfo>::iterator ite = m_debugInfoList.begin();
    for (; ite != m_debugInfoList.end(); ++ite)
    {
        cout << ite->m_label << " : " << ite->m_resCodeString << endl;
    }
}