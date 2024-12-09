#pragma once

// �f�o�C�X��
#define CASHDRAWER_NAME "Web3800Drawer"
#define SCANNER_NAME "TeraokaScanner"
#define POSPRINTER_NAME "CAP06-347"
#define POSKEYBOARD_NAME "Web2400Keyboard"

// �T�[�r�X�I�u�W�F�N�g��
#define TERAOKA_PROCESS_PATH "..\\..\\dist\\Teraoka\\"			// �v���Z�X�p�p�X
#define TERAOKA_SERVICE_PATH "C:\\OPOS\\Teraoka\\bin\\"			// OPOS�T�[�r�X�I�u�W�F�N�g�p�X
#define TRK03_GPIO_RW "trk03_gpio_rw.exe"						// �h���ADIO-RW�v���O����

// OPOS��M�v���O����
#define VS_DEBUG_GENERATE_PATH "..\\..\\dist\\x64\\Debug\\"		// Debug�pDLL,EXE�����p�X
#define VS_RELEASE_GENERATE_PATH "..\\..\\dist\\x64\\Release\\"	// Release�pDLL,EXE�����p�X
#define VS_X86_DEBUG_GENERATE_PATH "..\\..\\dist\\Win32\\Debug\\"		// x86Debug�pDLL,EXE�����p�X
#define VS_X86_RELEASE_GENERATE_PATH "..\\..\\dist\\Win32\\Release\\"	// x86Release�pDLL,EXE�����p�X
#define SCAN_RCV "ScanRcv.exe"	// �X�L���i
#define DRW_RCV "DrwRcv.exe"	// �h���A
#define PTR_RCV "PtrRcv.exe"	// �v�����^

// �ʐM�v���g�R��
#define TCP_IP_PROTOCOL "ncacn_ip_tcp"

// �l�b�g���[�N�A�h���X
#define LOCAL_HOST "localhost"

// TCP/IP�|�[�g�ԍ� ex) https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers
#define DEFAULT_PORT_1 "4747"		// �e�X�g�p�|�[�g1
#define DEFAULT_PORT_2 "4748"		// �e�X�g�p�|�[�g2
#define DRAWER_RCV_PORT "1029"		// �h���A��M�p�|�[�g
#define DRAWER_SND_PORT	"1030"		// �h���A���M�p�|�[�g
#define SCANNER_RCV_PORT "1031"		// �X�L���i��M�p�|�[�g
#define SCANNER_SND_PORT "1032"		// �X�L���i���M�p�|�[�g
#define PRINTER_RCV_PORT "1033"		// �v�����^��M�p�|�[�g
#define PRINTER_SND_PORT "1034"		// �v�����^���M�p�|�[�g