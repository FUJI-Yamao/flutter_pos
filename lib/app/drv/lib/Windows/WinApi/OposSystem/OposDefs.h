#pragma once

// デバイス名
#define CASHDRAWER_NAME "Web3800Drawer"
#define SCANNER_NAME "TeraokaScanner"
#define POSPRINTER_NAME "CAP06-347"
#define POSKEYBOARD_NAME "Web2400Keyboard"

// サービスオブジェクト等
#define TERAOKA_PROCESS_PATH "..\\..\\dist\\Teraoka\\"			// プロセス用パス
#define TERAOKA_SERVICE_PATH "C:\\OPOS\\Teraoka\\bin\\"			// OPOSサービスオブジェクトパス
#define TRK03_GPIO_RW "trk03_gpio_rw.exe"						// ドロアDIO-RWプログラム

// OPOS交信プログラム
#define VS_DEBUG_GENERATE_PATH "..\\..\\dist\\x64\\Debug\\"		// Debug用DLL,EXE生成パス
#define VS_RELEASE_GENERATE_PATH "..\\..\\dist\\x64\\Release\\"	// Release用DLL,EXE生成パス
#define VS_X86_DEBUG_GENERATE_PATH "..\\..\\dist\\Win32\\Debug\\"		// x86Debug用DLL,EXE生成パス
#define VS_X86_RELEASE_GENERATE_PATH "..\\..\\dist\\Win32\\Release\\"	// x86Release用DLL,EXE生成パス
#define SCAN_RCV "ScanRcv.exe"	// スキャナ
#define DRW_RCV "DrwRcv.exe"	// ドロア
#define PTR_RCV "PtrRcv.exe"	// プリンタ

// 通信プロトコル
#define TCP_IP_PROTOCOL "ncacn_ip_tcp"

// ネットワークアドレス
#define LOCAL_HOST "localhost"

// TCP/IPポート番号 ex) https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
#define DEFAULT_PORT_1 "4747"		// テスト用ポート1
#define DEFAULT_PORT_2 "4748"		// テスト用ポート2
#define DRAWER_RCV_PORT "1029"		// ドロア受信用ポート
#define DRAWER_SND_PORT	"1030"		// ドロア送信用ポート
#define SCANNER_RCV_PORT "1031"		// スキャナ受信用ポート
#define SCANNER_SND_PORT "1032"		// スキャナ送信用ポート
#define PRINTER_RCV_PORT "1033"		// プリンタ受信用ポート
#define PRINTER_SND_PORT "1034"		// プリンタ送信用ポート