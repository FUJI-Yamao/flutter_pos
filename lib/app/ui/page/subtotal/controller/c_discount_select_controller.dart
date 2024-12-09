/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:get/get.dart';
import '../../../../common/cmn_sysfunc.dart';
import '../../../../inc/apl/rxmem_define.dart';
import '../../../../regs/checker/rcstllcd.dart';
import '../../../../regs/checker/regs.dart';
import '../../../../regs/common/rxkoptcmncom.dart';
import '../../../enum/e_presetcd.dart';



///小計値引一覧コントローラー
class DiscountSelectController extends GetxController {
  ///プロモーションリスト
  final discounts = <PresetInfo>[].obs;

  ///初期化処理
  @override
  void onInit() {
    super.onInit();
    loadDiscounts();
  }

  ///プリセット値引きデータ読み込み
  void loadDiscounts() async {
    List<PresetInfo> allPresets = await RegistInitData.presetReadDB();
    var presetTitles = allPresets
        .where((item) => item.presetCd == PresetCd.discountList.value && item.kyCd != 0)
        .toList();
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);

    if (xRet.isInvalid()) {
      // 取得できなかったとき
      discounts.value = [];
      return;
    }
    RxCommonBuf cBuf = xRet.object;
    for (var preset in presetTitles) {
      if(Rxkoptcmncom.rxChkKeyKindPdsc(cBuf, preset.kyCd)){
        if(Rxkoptcmncom.rxChkKoptPdscStlPdsc(cBuf, preset.kyCd) == 0){
          if(!(Rxkoptcmncom.rxChkKoptPdscEntry(cBuf, preset.kyCd) == 1 &&
              Rxkoptcmncom.rxChkKoptPdscPdscPer(cBuf, preset.kyCd) == 0)) {
            discounts.add(preset);
          }
        }
      }
      if(Rxkoptcmncom.rxChkKeyKindDsc(cBuf, preset.kyCd)){
        if(Rxkoptcmncom.rxChkKoptDscStlDsc(cBuf, preset.kyCd) == 0){
          if(!(Rxkoptcmncom.rxChkKoptDscEntry(cBuf, preset.kyCd) == 1 &&
              Rxkoptcmncom.rxChkKoptDscDscAmt(cBuf, preset.kyCd) == 0)) {
            discounts.add(preset);
          }
        }
      }
    }
  }
}
