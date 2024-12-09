#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "POSKeyboardAPI.h"

static POSKeyboardControl& g_keyboard = Singleton<POSKeyboardControl>::GetInstance();

// 排他制御ミューテックス
static mutex mtxKeystroke;
static mutex mtxKey;

static BOOL bOpenedMkey = FALSE;

void OpenMkey()
{
    g_keyboard.keyInfo.m_key = "";

	if (!bOpenedMkey)
	{
        bOpenedMkey = TRUE;
        g_keyboard.OpenPOSKeyboard();
	}
}

void CloseMkey()
{
	g_keyboard.ClosePOSKeyboard();
	bOpenedMkey = FALSE;
    g_keyboard.keyInfo.m_key = "";
}

const char* GetKey()
{
    // ミューテックス取得
    lock_guard<mutex> lock(mtxKey);

    return g_keyboard.keyInfo.m_key;
}

int GetStrokeStat()
{
    // ミューテックス取得
    lock_guard<mutex> lock(mtxKeystroke);

    return g_keyboard.keyInfo.m_strokeStat;     // 1：押す, 0：離す
}

void KbdDebugLog()
{
	g_keyboard.KeyboardDebugLog();
}

LRESULT CALLBACK LowLevelKbdProc(INT nCode, WPARAM wParam, LPARAM lParam)
{
    BOOL fEatKeystroke = FALSE;

    if (nCode == HC_ACTION)
    {
        PKBDLLHOOKSTRUCT p = (PKBDLLHOOKSTRUCT)lParam;

        switch (wParam)
        {
        case WM_KEYDOWN:
        case WM_SYSKEYDOWN:
            // m_strokeStat 1:押す 2:離す
            // fEatKeystroke：コメントアウト ← アプリ画面アクティブ以外のキー受付対応
            // flags：コメントアウト ← splashtopでのリモートキー受付対応
            if (/*fEatKeystroke = */(VK_ESCAPE == p->vkCode))
            {
                // フック終了(デバッグ用) [PC:Esc]
                g_keyboard.keyInfo.m_key = "0xFF";
                g_keyboard.keyInfo.m_strokeStat = 1;
                g_keyboard.ClosePOSKeyboard();
            }
            else if (/*fEatKeystroke = */(0x0B == p->scanCode && 0x30 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 0 [PC:0]
                g_keyboard.keyInfo.m_key = "0x00";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x02 == p->scanCode && 0x31 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 1 [PC:1]
                g_keyboard.keyInfo.m_key = "0x01";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x03 == p->scanCode && 0x32 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 2 [PC:2]
                g_keyboard.keyInfo.m_key = "0x02";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x04 == p->scanCode && 0x33 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 3 [PC:3]
                g_keyboard.keyInfo.m_key = "0x03";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x05 == p->scanCode && 0x34 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 4 [PC:4]
                g_keyboard.keyInfo.m_key = "0x04";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x06 == p->scanCode && 0x35 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 5 [PC:5]
                g_keyboard.keyInfo.m_key = "0x05";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x07 == p->scanCode && 0x36 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 6 [PC:6]
                g_keyboard.keyInfo.m_key = "0x06";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x08 == p->scanCode && 0x37 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 7 [PC:7]
                g_keyboard.keyInfo.m_key = "0x07";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x09 == p->scanCode && 0x38 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 8 [PC:8]
                g_keyboard.keyInfo.m_key = "0x08";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x0A == p->scanCode && 0x39 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 9 [PC:9]
                g_keyboard.keyInfo.m_key = "0x09";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x34 == p->scanCode && 0xBE == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 00 [PC:Dot]
                g_keyboard.keyInfo.m_key = "0x0A";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x1D == p->scanCode && 0xA3 == p->vkCode /*&& 0x01 == p->flags*/))
            {
                // 小計 [PC:RCtrl]
                g_keyboard.keyInfo.m_key = "0x0B";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x1C == p->scanCode && 0x0D == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // 現計 [PC:Enter]
                g_keyboard.keyInfo.m_key = "0x0C";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x6B == p->scanCode && 0x83 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // CLEAR [PC:F20]
                g_keyboard.keyInfo.m_key = "0x0D";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x16 == p->scanCode && 0x55 == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // × [PC:U]
                g_keyboard.keyInfo.m_key = "0x0E";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else if (/*fEatKeystroke = */(0x24 == p->scanCode && 0x4A == p->vkCode /*&& 0x00 == p->flags*/))
            {
                // PLU [PC:J]
                g_keyboard.keyInfo.m_key = "0x0F";
                g_keyboard.keyInfo.m_strokeStat = 1;
            }
            else
            {
                // 上記以外のキーは無効
                //fEatKeystroke = TRUE;
            }
            break;
        case WM_KEYUP:
        case WM_SYSKEYUP:
            g_keyboard.keyInfo.m_strokeStat = 0;
            break;
        }
    }

    return fEatKeystroke ? 1 : CallNextHookEx(NULL, nCode, wParam, lParam);
}