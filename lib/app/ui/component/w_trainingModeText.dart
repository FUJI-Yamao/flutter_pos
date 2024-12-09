/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter/cupertino.dart';
import '../../common/cmn_sysfunc.dart';
import '../../inc/apl/rxmem_define.dart';
import '../../regs/checker/rxregstr.dart';
import '../colorfont/c_basecolor.dart';

///訓練モードの時表示する半透明テキスト
///テキストはこれから　c_appl_grp_mst　の　appl_nameを利用する
class TrainingModeText extends StatelessWidget {
  TrainingModeText({Key? key});

  @override
  Widget build(BuildContext context) {
    final RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    RxCommonBuf cBuf = xRet.object;
    final int confOpeMode = cBuf.iniMacInfo.internal_flg.mode;
    if (confOpeMode == Rxregstr.ConfOpeMode_TR) {
      return const Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        child: IgnorePointer(
          ignoring: true,
          child: Center(
            child: Opacity(
              opacity: 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '訓',
                    style: TextStyle(
                      fontSize: 180,
                      color: BaseColor.attentionColor,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    '練',
                    style: TextStyle(
                      fontSize: 180,
                      color: BaseColor.attentionColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
