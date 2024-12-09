#include "../OposSystem/stdafx.h"
#include "../OposSystem/OposDefs.h"
#include "../OposSystem/OposDebug.h"
#include "../COpos/COposDrw.h"
#include "POSPrinterAPI.h"

// レシートロゴ
static const char* g_logoPath = "receipt.bmp";

// レシートレイアウト
static const wchar_t* g_textData = L"\
\x1b|400uF\
\x1b|N  店No.000000001      ﾚｼﾞNo:000001\n\
\x1b|N  2023年 1月12日(木曜日)  14時32分\n\
\x1b|N  000999999寺岡        ﾚｼｰﾄNo:0001\n\
\x1b|400uF\
\x1b|N   綾鷹                       \\131\n\
\x1b|N   ほうじ茶                   \\128\n\
\x1b|N  --------------------------------\n\
\x1b|N   小計                       \\259\n\
\x1b|N   お買上点数                  2点\n\
\x1b|N  --------------------------------\n\
\x1b|N\x1b|bC\x1b|2C 合計        \\259\n\
\x1b|N\x1b|bC  現計                        \\259\n\
\x1b|N  お預り                      \\300\n\
\x1b|N  お釣り                       \\41\n\
\x1b|600uF\
";

// MEMO: 参照既存ソース
// rp_print.c > rp_Print_BarLine
// ⇒ 26桁のバーコードを作成
// jan_inf.h > Code128_inf > Org_Code
// ⇒ ASC EAN26をセット（Original 2 barcode = ASC EAN13 * 2）
// 固定でCODE128(CODE-Cタイプ)出力（仮）
static const wchar_t* g_bcData = L"12220113000100000000100017";

static void ExecutePOSPrinterTest();

int main()
{
    // OPOS制御結果
    LONG pRC = -1;

    cout << "------- Test Start -------" << endl;
    ExecutePOSPrinterTest();
    cout << "------- Test Finish -------" << endl;

    system("PAUSE");
    SingletonFinalizer::Finalize();
}

void ExecutePOSPrinterTest()
{
    INT ret = -1;

    ret = OpenPtrEvent(VS_X86_RELEASE_GENERATE_PATH PTR_RCV);
    printf("OpenPtrEvent() : %d\n", ret);

    printf("Incomming...\n");

    // MEMO: デバイスによるミリ秒単位の連続したイベント受付によるメッセージキューの処理は持たない。
    //		 ループ受付中に最後に受け付けたデータのみを受け取る。
    BOOL isCoverOpen = FALSE;
    BOOL isPaperEmpty = FALSE;
    while (1)
    {
        InqStatCover();     // プリンタカバー開閉状態問合せ
        InqStatPaper();     // レシート用紙有無状態問合せ
        if (0 < GetPtrCntRef())
        {
            INT statCover = GetStatCover();
            INT statPaper = GetStatPaper();
            printf("Status Cover : %d\n", statCover);
            printf("Status Paper : %d\n", statPaper);
            switch (statCover)
            {
            case 1:     // カバー閉の場合
                isCoverOpen = FALSE;
                break;
            case 0:     // カバー開の場合
            default:    // -1
                isCoverOpen = TRUE;
                break;
            }
            switch (statPaper)
            {
            case 1:     // レシート用紙有りの場合
                isPaperEmpty = FALSE;
                break;
            case 0:     // レシート用紙無しの場合
            default:    // -1
                isPaperEmpty = TRUE;
                break;
            }
            ReleasePtr();
            
            // カバー閉・レシート有りの場合（デバッグ用: 5回転59.8%の確率でbreak）⇒ ソケット通信でラグがあるのでもっと低い。C++なので3%くらい？
            if (!isCoverOpen && !isPaperEmpty) break;
        }
    }

    // レシートロゴ登録
    ret = RegLogo(g_logoPath);
    printf("\nRegLogo() : %d\n", ret);

    // レシート出力
    ret = OutRec(g_textData, g_bcData);
    printf("\nOutRec() : %d\n", ret);

    ret = ClosePtrEvent();
    printf("\nClosePtrEvent() : %d\n", ret);
}