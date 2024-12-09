#pragma once

#include "../OposSystem/Singleton.h"
#include "resource.h"
#include "CoScan.h"

class COPOSScanner : public CDialog		// プロセスダミーベース
{
public:
	COPOSScanner(CWnd* pParent = NULL);

	enum { IDD = IDD_SCANNER_FOUNDATION };
	CCoScan	m_scan;

protected:
	virtual BOOL OnInitDialog();
	virtual void DoDataExchange(CDataExchange* pDX);
	afx_msg void OnDestroy();
	afx_msg void OnDataEvent(long Status);
	afx_msg void OnErrorEvent(long ResultCode, long ResultCodeExtended, long ErrorLocus, long FAR* pErrorResponse);
	DECLARE_EVENTSINK_MAP()		// イベント受付
};