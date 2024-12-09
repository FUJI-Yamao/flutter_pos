import 'package:flutter/cupertino.dart';
import 'package:flutter_pos/app/lib/cm_sys/cm_cksys.dart';

import '../common/cmn_sysfunc.dart';
import 'fb_lib.dart';

/// 関連tprxソース:fb_init.c - Frame Buffer Library(initialize)
///
class FbInit {

  static int fbSubinit = 2;
  static int fbVtclFhdSetFlg = 0;	/* fbMemへのセットができたかを判別 */
  static int fbVtclRm5900SetFlg = 0;
  static int fbVtclFhdFselfSetFlg = 0;	/* fbMemへのセットができたかを判別(15.6対面用) */

  static int FB_dPer = 0;		/* display new percent */
  static int FB_dPer_Save = 0;		/* display original percent(save) */
  static int FB_dPer_Chg = 0;		/* display new percent(save) */
  static int FB_dChg = 0;		/* display Change flag */
  static int FB_dP14NFPls = 0;
  static int FB_dP16NFPls = 0;
  static int FB_dP24NFPls = 0;	/* display new font plus byte */
  static int FB_dP14Pls = 0;
  static int FB_dP16Pls = 0;
  static int FB_dP24Pls = 0;	/* display old font but plus byte */
  static int FB_dP14Pls_HL = 0;
  static int FB_dP14Pls_HR = 0;
  static int FB_dP16Pls_HL = 0;
  static int FB_dP16Pls_HR = 0;
  static int FB_dP24Pls_HL = 0;
  static int FB_dP24Pls_HR = 0;		/* display old font but plus byte(Hankaku L/R) */
  static int FB_dP14Pls_L = 0;
  static int FB_dP14Pls_R = 0;
  static int FB_dP16Pls_L = 0;
  static int FB_dP16Pls_R = 0;
  static int FB_dP24Pls_L = 0;
  static int FB_dP24Pls_R = 0;		/* display old font but plus byte(L/R) */

  ///  関連tprxソース:fb_init.c - fb_direct_shutdown()
  static void fbDirectShutdown() {
    // TODO:10074 FlameBuffer

    // #ifdef NODSP
    // return;
    // #else
    // if(kbd_pid > 0) {
    // kill(kbd_pid, SIGUSR1);
    // waitpid(kbd_pid, (int *)0, 0);
    // }
    // kbd_pid = -1;
    // fb_shutdown_wait();
    // #endif
  }

  ///  関連tprxソース:fb_init.c - OptWindowTypeGet()
  static void optWindowTypeGet() {
    // TODO:10074 FlameBuffer
  }

  ///  関連tprxソース:fb_init.c - subinit_Main_single_Special_Chk
  static bool subinitMainSingleSpecialChk(){
    return (fbSubinit == 6);
  }

  ///  関連tprxソース:fb_init.c - fb_dualcshr_chk
  static bool fbDualCshrChk(){
    return (fbSubinit == 1);
  }

  /// 関数名：fbVerticalFhdSet
  ///
  /// 機能：縦型21.5インチであれば判別フラグをセットする
  ///
  /// 引数：なし
  ///
  /// 戻値：なし
  ///
  ///  関連tprxソース:fb_init.c - fb_vertical_fhd_set
  static void fbVerticalFhdSet() {
    FbMem fbMem = SystemFunc.readFbMem(null);
    int fbVtclFhd = 0;

    fbVtclFhdSetFlg = 0;
    fbVtclFhd = 0;
    if (CmCksys.cmChkVerticalFHDSystemMain(true) != 0) {	/* 縦型21.5インチ */
      fbVtclFhd = 1;
    }
    if (fbMem != null) {	/* fbMemに書けるか */
      fbMem.vtcl_fhd_flg = fbVtclFhd;
      fbVtclFhdSetFlg = 1;
    }
  }

  /// 関数名：fbVtclFhdFselfSet
  ///
  /// 機能：縦型15.6インチ対面であれば判別フラグをセットする
  ///
  /// 引数：なし
  ///
  /// 戻値：なし
  ///
  ///  関連tprxソース:fb_init.c - fb_vtcl_fhd_fself_set
  static void fbVtclFhdFselfSet() {
    FbMem fbMem = SystemFunc.readFbMem(null);
    int fbVtclFhdFself = 0;

    fbVtclFhdFselfSetFlg = 0;
    if (CmCksys.cmChkVtclFHDFselfSystemMain(true) != 0) {	/* 縦型15.6インチ対面 */
      fbVtclFhdFself = 1;
    }
    if (fbMem != null) {	/* fbMemに書けるか */
      fbMem.vtcl_fhd_fself_flg= fbVtclFhdFself;
      fbVtclFhdFselfSetFlg = 1;
    }
  }


  /// 関数名：fbVerticalRm5900Set
  ///
  /// 機能：
  ///
  /// 引数：なし
  ///
  /// 戻値：なし
  ///
  ///  関連tprxソース:fb_init.c - fb_vertical_rm5900_set
  static void fbVerticalRm5900Set() {
    FbMem fbMem = SystemFunc.readFbMem(null);
    int fbVtclRm5900 = 0;

    fbVtclRm5900SetFlg = 0;
    if(CmCksys.cmChkVerticalRm5900SystemMain(true) != 0) {
      fbVtclRm5900 = 1;
      debugPrint("cm_chk_vertical_rm5900_system_main(1) return 1");
    }
    if(fbMem != null) {
      debugPrint("fbMem OK");
      fbMem.vtcl_rm5900_flg = fbVtclRm5900;
      fbVtclRm5900SetFlg = 1;
    } else {
      debugPrint("fbMem NG");
    }
  }

  /// 関連tprxソース:fb_init.c - FB_XGAdispControl
  static void fbXgaDispControl(int flg) {
//	if(FB_dPer_Save != XGA_MAG)
//		return;

  // TODO:00013 三浦 実装必要？
  //   if(flg == 0) {	/* Change Percent */
  //   FB_dPer = FB_dPer_Chg;
  //   } else {		/* Change default(Max) */
  //   FB_dPer = FB_dPer_Save;
  //   }
  //
  //   FB_dP14Pls = FB_FontPls(FB_dPer, FONT14);
  //   FB_dP16Pls = FB_FontPls(FB_dPer, FONT16);
  //   FB_dP24Pls = FB_FontPls(FB_dPer, FONT24);
  //   // #if FB_DPER_NF
  //   FB_dP14NFPls = FB_FontNFPls(FB_dPer, FONT14);
  //   FB_dP16NFPls = FB_FontNFPls(FB_dPer, FONT16);
  //   FB_dP24NFPls = FB_FontNFPls(FB_dPer, FONT24);
  //   // #endif
  //   FB_dP14Pls_HL = FB_FontPls_HL(FB_dPer, FONT14);
  // FB_dP16Pls_HL = FB_FontPls_HL(FB_dPer, FONT16);
  // FB_dP24Pls_HL = FB_FontPls_HL(FB_dPer, FONT24);
  // FB_dP14Pls_HR = FB_FontPls_HR(FB_dPer, FONT14);
  // FB_dP16Pls_HR = FB_FontPls_HR(FB_dPer, FONT16);
  // FB_dP24Pls_HR = FB_FontPls_HR(FB_dPer, FONT24);
  // FB_dP14Pls_L = FB_FontPls_L(FB_dPer, FONT14);
  // FB_dP16Pls_L = FB_FontPls_L(FB_dPer, FONT16);
  // FB_dP24Pls_L = FB_FontPls_L(FB_dPer, FONT24);
  // FB_dP14Pls_R = FB_FontPls_R(FB_dPer, FONT14);
  // FB_dP16Pls_R = FB_FontPls_R(FB_dPer, FONT16);
  // FB_dP24Pls_R = FB_FontPls_R(FB_dPer, FONT24);
  }
}
