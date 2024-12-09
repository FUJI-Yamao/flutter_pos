#pragma once

#define STAT_COVER_OPEN 0
#define STAT_COVER_CLOSE 1
#define STAT_PAPER_EMPTY 0
#define STAT_PAPER_EXIST 1
#define STAT_DISCONNECTED -1

VOID OnRegisterLogo(const string& filePath);
VOID OnOutputReceipt(const string& textData, const string& bcData, BOOL bAsync=FALSE);
VOID OnPrintBitmapDirect(const string& filePath);
VOID OnGetStatCover();
VOID OnGetStatPaper();