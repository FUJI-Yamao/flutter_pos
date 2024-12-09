#include "stdafx.h"
#include "OposDebug.h"

#define CHAR_SIZE 256

OposDebug::OposDebug()
{

}

OposDebug::~OposDebug()
{

}

VOID OposDebug::SetResCodeStrings()
{
	list<DebugInfo>::iterator ite = m_debugInfoList.begin();
	for (; ite != m_debugInfoList.end(); ++ite)
	{
		BOOL bExist = FALSE;
		
		for (pair<LONG, LPCSTR> mp : resCodeMap)
		{
			if (mp.first == ite->m_resCode)
			{
				ite->m_resCodeString = mp.second;
				bExist = TRUE;
				break;
			}
		}
		
		// Æ‡‚µ‚È‚¢ê‡
		if (!bExist)
		{
			char strResCode[CHAR_SIZE];
			sprintf_s(strResCode, "OTHER RESULT CODE: %d", ite->m_resCode);
			ite->m_resCodeString = strResCode;
		}
	}
}