#pragma once

#include "../OposSystem/Singleton.h"
#include "resource.h"
#include "CoPtr.h"

class COPOSPOSPrinter : public CDialog		// プロセスダミーベース
{
public:
	COPOSPOSPrinter(CWnd* pParent = NULL);

	enum { IDD = IDD_PRINTER_FOUNDATION };
	CCoPtr& m_ptr = Singleton<CCoPtr>::GetInstance();

protected:
	virtual BOOL OnInitDialog();
	virtual void DoDataExchange(CDataExchange* pDX);
	afx_msg void OnDestroy();
	afx_msg void OnErrorEventPrinter(long ResultCode, long ResultCodeExtended, long ErrorLocus, long FAR* pErrorResponse);
	afx_msg void OnOutputCompleteEventPrinter(long OutputID);
	afx_msg void OnStatusUpdateEventPrinter(long Data);
	DECLARE_EVENTSINK_MAP()
};