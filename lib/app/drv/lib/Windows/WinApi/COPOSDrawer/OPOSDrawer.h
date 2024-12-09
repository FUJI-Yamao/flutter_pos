#pragma once

#include "../OposSystem/Singleton.h"
#include "resource.h"
#include "CoDrw.h"

class COPOSDrawer : public CDialog		// プロセスダミーベース
{
public:
	COPOSDrawer(CWnd* pParent = NULL);

	enum { IDD = IDD_DRAWER_FOUNDATION };
	CCoDrw& m_drw = Singleton<CCoDrw>::GetInstance();

protected:
	virtual BOOL OnInitDialog();
	virtual void DoDataExchange(CDataExchange* pDX);
	afx_msg void OnDestroy();
	afx_msg void OnStatusUpdateEventDrawer(long Data);
	DECLARE_EVENTSINK_MAP()
};