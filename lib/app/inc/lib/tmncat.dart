/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース: cat.h
/** =================================================================== **/
/**                                                                     **/
/**  共通メソッドの定義                                                 **/
/**                                                                     **/
/** =================================================================== **/
///////////////////////////////////////////////////////////////////////////
//OPOS ResultCode定数
///////////////////////////////////////////////////////////////////////////
class tmncat {
static const int OPOS_SUCCESS             =   0;
static const int OPOS_E_CLOSED            = 101;
static const int OPOS_E_CLAIMED           = 102;
static const int OPOS_E_NOTCLAIMED        = 103;
static const int OPOS_E_NOSERVICE         = 104;
static const int OPOS_E_DISABLED          = 105;
static const int OPOS_E_ILLEGAL           = 106;
static const int OPOS_E_NOHARDWARE        = 107;
static const int OPOS_E_OFFLINE           = 108;
static const int OPOS_E_NOEXIST           = 109;
static const int OPOS_E_EXISTS            = 110;
static const int OPOS_E_FAILURE           = 111;
static const int OPOS_E_TIMEOUT           = 112;
static const int OPOS_E_BUSY              = 113;
static const int OPOS_E_EXTENDED          = 114;
static const int OPOS_E_DEPRECATED        = 115; // (added in 1.11)
static const int OPOS_E_FFIINVALID        = 120; // FFI invalid error
static const int OPOS_E_INTERNAL          = 121; // internal error

static const int OPOSERR                  = 100; // Base for ResultCode errors.
static const int OPOSERREXT               = 200; // Base for ResultCodeExtendedErrors.


///////////////////////////////////////////////////////////////////////////
// OPOS "ResultCodeExtended" Property Constants
///////////////////////////////////////////////////////////////////////////

// The following applies to ResetStatistics and UpdateStatistics.
static const int OPOS_ESTATS_ERROR        = 280; // (added in 1.8
static const int OPOS_ESTATS_DEPENDENCY   = 282; // (added in 1.10)

// The following applies to CompareFirmwareVersion and UpdateFirmware.
static const int OPOS_EFIRMWARE_BAD_FILE  = 281; // (added in 1.9)

///////////////////////////////////////////////////////////////////////////
// OPOS OposCheckHealth
///////////////////////////////////////////////////////////////////////////
static const int OPOS_CH_INTERNAL                = 1;
static const int OPOS_CH_EXTERNAL                = 2;

///////////////////////////////////////////////////////////////////////////
// OPOS "CapPowerReporting", "PowerState", "PowerNotify" Property
//   Constants (added in 1.3)
///////////////////////////////////////////////////////////////////////////
static const int OPOS_PS_UNKNOWN                    = 2000;
static const int OPOS_PS_ONLINE                     = 2001;
static const int OPOS_PS_OFF                        = 2002;
static const int OPOS_PS_OFFLINE                    = 2003;
static const int OPOS_PS_OFF_OFFLINE                = 2004;

///////////////////////////////////////////////////////////////////////////
// OPOS OposClearOutput
///////////////////////////////////////////////////////////////////////////


/** =================================================================== **/
/**                                                                     **/
/**  ブランドの定義                                                       **/
/**                                                                     **/
/** =================================================================== **/
///////////////////////////////////////////////////////////////////////////
// "CapDailyLog" Property and "AccessDailyLog" Type Parameter Constants
///////////////////////////////////////////////////////////////////////////
static const int CAT_DL_NONE                      = 0;
static const int CAT_DL_REPORTING                 = 1;
static const int CAT_DL_SETTLEMENT                = 2;
static const int CAT_DL_REPORTING_SETTLEMENT      = 3;

///////////////////////////////////////////////////////////////////////////
// メソッド引数の閾値
///////////////////////////////////////////////////////////////////////////
static const int G_MAX_SEQUENCENO                    = 2147483647; // シーケンス番号最大値
static const int G_MIN_SEQUENCENO                    = 1;        // シーケンス番号最小値
static const int G_MAX_AMOUNT                        = 99999999;    // 指定金額最大値
static const int G_MIN_AMOUNT                        = 1;        // 指定金額最小値
static const int G_MAX_TIMEOUT                       = 99999999;    // 指定タイムアウト最大値
static const int G_MIN_TIMEOUT                       = 3000;        // 指定タイムアウト最小値

///////////////////////////////////////////////////////////////////////////
// General Constants
///////////////////////////////////////////////////////////////////////////
static const int OPOS_FOREVER                    = -1;        // Timeoutの範囲


/** =================================================================== **/
/**                                                                     **/
/**   DirectIOメソッド用定数                                            **/
/**                                                                     **/
/** =================================================================== **/
/* 共通 */
static const int G_DIO_COMMON_GETSERVICELIST       =     1;     // サービス一覧取得
static const int G_DIO_COMMON_GETLEDINFO           =     2;     // LED輝度取得
static const int G_DIO_COMMON_SETLEDINFO           =     3;     // LED輝度設定
static const int G_DIO_COMMON_GETLCDINFO           =     4;     // LCD輝度取得
static const int G_DIO_COMMON_SETLCDINFO           =     5;     // LCD輝度設定
static const int G_DIO_COMMON_GETUTVOLUMEINFO      =     6;        // UT音量取得
static const int G_DIO_COMMON_SETUTVOLUMEINFO      =     7;        // UT音量設定
static const int G_DIO_COMMON_GETUTPARAMETERINFO   =     8;        // UTパラメータ取得
static const int G_DIO_COMMON_SETUTPARAMETERINFO   =     9;        // UTパラメータ設定
static const int G_DIO_COMMON_GETUTDATA            =    10;     // UTパラメータ取得

static const int G_DIO_COMMON_200                   =    200;    // 端末パラメータ取得
static const int G_DIO_COMMON_201                   =    201;    // 端末パラメータ設定
static const int G_DIO_COMMON_202                   =    202;    // ブランド別接続情報取得
static const int G_DIO_COMMON_203                   =    203;    // ブランド別接続情報設定
static const int G_DIO_COMMON_204                   =    204;    // ブランド別端末識別番号取得
static const int G_DIO_COMMON_205                   =    205;    // ブランド別端末識別番号設定
static const int G_DIO_COMMON_206                   =    206;    // 指定ブロック読出し

static const int G_DIO_COMMON_291                   =    291;    // TMNモジュールバージョンの取得
static const int G_DIO_COMMON_300                   =    300;    // 設定TID時設定取得
static const int G_DIO_COMMON_301                   =    301;    // UT音源データの更新
static const int G_DIO_COMMON_302                   =    302;    // UT音源データの設定
static const int G_DIO_COMMON_303                   =    303;    // 端末設定ファイルのアップロード
static const int G_DIO_COMMON_304                   =    304;    // 端末設定ファイルのダウンロード

/* QUICPay */
static const int G_DIOE_QP_GETHISTORY               =   1101;    // QUICPayカード履歴取得
static const int G_DIOE_QP_GETTERMINFO              =   1001;    // 端末設定情報取得
static const int G_DIOE_QP_SETTERMINFO              =   1002;    // 端末設定情報設定
static const int G_DIOE_QP_GETSERVICETIME           =   1003;    // サービスタイマ取得
static const int G_DIOE_QP_SETSERVICETIME           =   1004;    // サービスタイマ設定
static const int G_DIOE_QP_TSTONLINE                =   1005;    // オンラインテスト
static const int G_DIOE_QP_GETVOLUMEINFO            =   1006;    // 音量取得 
static const int G_DIOE_QP_SETVOLUMEINFO            =   1007;    // 音量設定
static const int G_DIOE_QP_GETDAYALARM              =   1008;    // 日計アラーム通知取得
static const int G_DIOE_QP_SETDAYALARM              =   1009;    // 日計アラーム通知設定
static const int G_DIOE_QP_GETSEQNO                 =   1010;    // シーケンス番号取引照会
static const int G_DIOE_QP_SETSEQNO                 =   1011;    // シーケンス番号集計情報照会
static const int G_DIOE_QP_GETSEQNOINQUIRLY         =   1012;    // QUICPayカード内容問い合わせ
static const int G_DIOE_QP_UNKNOWNCOMISOK           =   1013;    // 不明取引センタ成立
static const int G_DIOE_QP_UNKNOWNCOMISNG           =   1014;    // 不明取引センタ不成立

/* iD */
static const int G_DIOE_ID_GETTERMINFO           =   2001;    // 端末設定情報取得
static const int G_DIOE_ID_SETTERMINFO           =   2002;    // 端末設定情報設定
static const int G_DIOE_ID_GETSERVICETIME        =   2003;    // サービスタイマ取得
static const int G_DIOE_ID_SETSERVICETIME        =   2004;    // サービスタイマ設定
static const int G_DIOE_ID_TSTONLINE             =   2005;    // オンラインテスト
static const int G_DIOE_ID_GETVOLUMEINFO         =   2006;    // 音量取得
static const int G_DIOE_ID_SETVOLUMEINFO         =   2007;    // 音量設定
static const int G_DIOE_ID_GETDAYALARM           =   2008;    // 日計アラーム通知取得
static const int G_DIOE_ID_SETDAYALARM           =   2009;    // 日計アラーム通知設定
static const int G_DIOE_ID_GETSEQNO              =   2010;    // シーケンス番号取引照会
static const int G_DIOE_ID_SETSEQNO              =   2011;    // シーケンス番号集計情報照会
static const int G_DIOE_ID_GETSEQNOINQUIRLY      =   2012;    // iDカード内容問い合わせ
static const int G_DIOE_ID_UNKNOWNCOMISOK        =   2013;    // 不明取引センタ成立
static const int G_DIOE_ID_UNKNOWNCOMISNG        =   2014;    // 不明取引センタ不成立

/* Suica */
static const int G_DIOE_SUICA_GETTERMINFO          =   3001;    // 交通系IC 端末設定情報取得
static const int G_DIOE_SUICA_SETTERMINFO          =   3002;    // 交通系IC 端末設定情報設定
static const int G_DIOE_SUICA_GETSERVICETIME       =   3003;    // 交通系IC サービスタイマ取得
static const int G_DIOE_SUICA_SETSERVICETIME       =   3004;    // 交通系IC サービスタイマ設定
static const int G_DIOE_SUICA_TSTONLINE            =   3005;    // 交通系IC オンラインテスト
static const int G_DIOE_SUICA_GETVOLUMEINFO        =   3006;    // 交通系IC 音量取得
static const int G_DIOE_SUICA_SETVOLUMEINFO        =   3007;    // 交通系IC 音量設定
static const int G_DIOE_SUICA_SETSEQNO             =   3011;    // 交通系IC シーケンス番号集計情報照会
static const int G_DIOE_SUICA_GETSEQNOINQUIRLY     =   3013;    // 交通系IC カード内容問い合わせ
static const int G_DIOE_SUICA_UNKNOWNCOMISOK       =   3014;    // 交通系IC 不明取引センタ成立
static const int G_DIOE_SUICA_UNKNOWNCOMISNG       =   3110;    // 交通系IC 不明取引センタ不成立

///////////////////////////////////////////////////////////////////////////
//DirectIOEventイベント用定数
///////////////////////////////////////////////////////////////////////////
/* QUICPay */
static const int G_DIOE_QP_CONNECTCENTER           =   1001;    // センタコネクト開始
static const int G_DIOE_QP_AUTHORIZECOMPLETE       =   1002;    // オーソリが完了
static const int G_DIOE_QP_RETOUCH                 =   1003;    // カード書き込み失敗。再タッチ要求
static const int G_DIOE_QP_OTHERCARD               =   1004;    // 再タッチ中の、別カードタッチ
static const int G_DIOE_QP_WRITESTART              =   1005;    // カード書き込み開始
static const int G_DIOE_QP_DAILYLOGALARM           =   1006;    // 日計アラーム発生

/* iD */
static const int G_DIOE_ID_INPUTPIN                =   2001;    // PIN入力開始
static const int G_DIOE_ID_PINRETRY                =   2002;    // PIN入力リトライ
static const int G_DIOE_ID_CONNECTCENTER           =   2003;    // センタコネクト開始
static const int G_DIOE_ID_RETOUCH                 =   2004;    // カード書き込み失敗。再タッチ要求
static const int G_DIOE_ID_OTHERCARD               =   2005;    // 再タッチ中の、別カードタッチ
static const int G_DIOE_ID_WRITESTART              =   2006;    // カード書き込み開始
static const int G_DIOE_ID_DAILYLOGALARM           =   2007;    // 日計アラーム発生

/* SUICA */
static const int G_DIOE_SUICA_RETOUCH              =   3003;    // カード書き込み失敗。再タッチ要求
static const int G_DIOE_SUICA_OTHERCARD            =   3004;    // 再タッチ中の、別カードタッチ
static const int G_DIOE_SUICA_WRITESTART           =   3005;    // カード書き込み開始
static const int G_DIOE_SUICA_ONLINENEGA           =   3006;    // オンラインネガチェック開始
static const int G_DIOE_SUICA_OTHERID              =   3007;    // 指定されたカードIDと異なるカード


/** =================================================================== **/
/**                                                                     **/
/**  イベント関数の定義                                                 **/
/**                                                                     **/
/** =================================================================== **/
///////////////////////////////////////////////////////////////////////////
// "ErrorEvent" Event: "ErrorLocus" Parameter Constants
///////////////////////////////////////////////////////////////////////////
static const int OPOS_EL_OUTPUT         = 1;
static const int OPOS_EL_INPUT          = 2;
static const int OPOS_EL_INPUT_DATA     = 3;

///////////////////////////////////////////////////////////////////////////
// "ErrorEvent" Event: "ErrorResponse" Constants
///////////////////////////////////////////////////////////////////////////
static const int OPOS_ER_RETRY          = 11;
static const int OPOS_ER_CLEAR          = 12;
static const int OPOS_ER_CONTINUEINPUT  = 13;


/** =================================================================== **/
/**                                                                     **/
/**  Cif関数の定義                                                      **/
/**                                                                     **/
/** =================================================================== **/
///////////////////////////////////////////////////////////////////////////
// CifGetProperty, CifSetProperty プロパティ
///////////////////////////////////////////////////////////////////////////
/* Properlty */
static const int ACCOUNTNUMBER                 = 1000;
static const int ADDITIONALSECURITYINFORMATION = 1001;
static const int ASYNCMODE                     = 1002;
static const int BALANCE                       = 1003;
static const int CARDCOMPANYID                 = 1004;
static const int CENTERRESULTCODE              = 1005;
static const int CHECKHEALTHTEXT               = 1006;
static const int CLAIMED                       = 1007;
static const int DEVICEENABLED                 = 1008;
static const int OUTPUTID                      = 1009;
static const int PAYMENTMEDIA                  = 1010;
static const int RESULTCODE                    = 1011;
static const int RESULTCODEEXTENDED            = 1012;
static const int SEQUENCENUMBER                = 1013;
static const int SETTLEDAMOUNT                 = 1014;
static const int SLIPNUMBER                    = 1015;
static const int TRAININGMODE                  = 1016;
static const int TRANSACTIONNUMBER             = 1017;
static const int TRAMSACTIONTYPE               = 1018;

///////////////////////////////////////////////////////////////////////////
//PaymentMedia値
///////////////////////////////////////////////////////////////////////////
static const int CAT_MEDIA_COMMON             =    -1;        // 共通
static const int CAT_MEDIA_QUICPAY            =   100;        // QP
static const int CAT_MEDIA_ID                 =   200;        // iD
static const int CAT_MEDIA_SUICA              =   300;        // Suica
static const int CAT_MEDIA_MANACA             =   400;        // MANACA

///////////////////////////////////////////////////////////////////////////
// CifGetEvent
///////////////////////////////////////////////////////////////////////////
static const int CIF_EVT_NONE                 =  8000;        //ResultCodeと競合しないように変更(20121108)
static const int CIF_EVT_OUTPUTCOMPLETE       =  8001;        //ResultCodeと競合しないように変更(20121108)
static const int CIF_EVT_ERROR                =  8002;        //ResultCodeと競合しないように変更(20121108)
static const int CIF_EVT_DIRECTIO             =  8003;        //ResultCodeと競合しないように変更(20121108)

}

