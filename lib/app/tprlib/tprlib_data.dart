/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import '../inc/sys/tpr_tib.dart';

/// プロジェクト全体で使用する一つしか存在しないデータ.
/// シングルトン.
///  関連tprxソース:TprLibData.c
class TprLibData {
  int tprxErrNo = 0;
  TprTib sysTib = TprTib();

  static final TprLibData _instance = TprLibData._internal();
  factory TprLibData() {
    return _instance;
  }
  TprLibData._internal();

  TprTct getTct(int i) => sysTib.tct[i];

  /// 関連tprxソース:TprLibDrv.c TprLibMakeDrvInit
  int tprLibMakeDrvInit() {
    // TODO:10019 パイプ通信  DartFFIに置き換える.

    // ファイルディスクリプタを取得.
    // fd = open( "/var/tmp/.tibdat.dat", O_RDONLY, 0666 );
    // if( fd == -1 ){
    //   tprxErrNo = TprErrNo.TPRESYSCALL;
    //   return( -1 );
    // }
    // // fdを読みだして、SysTibにデータを格納する.
    // read( fd, &sysTib, sizeof( SysTib ));
    // close( fd );
    //
    // // データの初期化.
    // sysTib.sysPi = -1;
    // for( int i = 0; i < TprDef.TPRMAXTCT; i++ ){
    //   sysTib.tct[i].fds = -1;
    // }
    //
    // //  open:TPRPIPE_SYSファイルパス、O_RDWR読み込み書き込みのフラグ
    // /* open systask receive pipe */
    // // 	TPRPIPE_SYS	"/var/tmp/tprPipeSys" _O_RDWR        0x0002  // open for reading and writing
    //
    // if ((sysTib.sysPi = open(TprPipe.TPRPIPE_SYS, 0x0002)) < 0) {
    //   tprxErrNo = TprErrNo.TPRESYSCALL;
    //   return (-2);
    // }
    //
    // // MEMO:元ソースが１から始まっている.
    // for (int i = 1; i < TprDef.TPRMAXTCT; i++) {
    //   TprTct data = getTct(i);
    //   if (data.tid == 0) {
    //     continue;
    //   }
    //
    //   // それぞれのドライバのパイプを開く.
    //   /* make drivers section */
    //   int processNo = data.tid >> 12;
    //   String fileName =
    //       TprPipe.TPRPIPE_DRV + processNo.toString().padLeft(2, '0');
    //
    //   data.fds = open(fileName, 0x0002);
    // }

    return 0;
  }
}
