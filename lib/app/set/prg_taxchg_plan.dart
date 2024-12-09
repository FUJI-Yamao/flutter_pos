/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../common/cmn_sysfunc.dart';
import '../common/environment.dart';
import '../inc/apl/rxmem_define.dart';
import '../inc/lib/taxchg_plan.dart';
import '../inc/sys/tpr_type.dart';
import '../lib/apllib/apllib_std_add.dart';
import '../regs/inc/rc_mem.dart';

///  関連tprxソース: plg_taxchg_plan.c
class PlgTaxchgPlan{
  // 開設(OPEN)での印字に使用.  印字用ファイルに対する操作関数
  ///  関連tprxソース: plg_taxchg_plan.c - prgPlanUpdateResultLogProc
  static int prgPlanUpdateResultLogProc(TprMID tid, TaxchgPlanLogType type){
    String path = '';
    String prnPath = '';
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_STAT);
    if (xRet.isInvalid()) {
      return 0;
    }

    path = sprintf("%s/log/%s", [EnvironmentData().sysHomeDir, TacchgPlan.PLAN_RESULT_LOG_NAME]);
    prnPath = sprintf("%s/log/%s", [EnvironmentData().sysHomeDir, TacchgPlan.PLAN_PRINT_LOG_NAME]);
    // TODO:10082 ディレクトリからファイル検索&操作
    if(type == TaxchgPlanLogType.TAXCHG_PLAN_LOG_CHECK){		// 印字するファイルがあるか
      if(TprxPlatform.getFile(path).existsSync()){
        return	0;
      }
    }else if(type == TaxchgPlanLogType.TAXCHG_PLAN_LOG_RENAME){	// 印字対象ファイルに変更
      if(AplLibStdAdd.aplLibRename(tid, path, prnPath) == false){
        return	0;
      }
    }else if(type == TaxchgPlanLogType.TAXCHG_PLAN_LOG_PRINT_CHECK){	// 印字対象ファイルがあるか
      // TODO:10082 ディレクトリからファイル検索&操作
      if(TprxPlatform.getFile(prnPath).existsSync()){
        return	0;
      }
    }else if(type == TaxchgPlanLogType.TAXCHG_PLAN_LOG_REMOVE){	// すべて削除
      AplLibStdAdd.aplLibRemove(tid, path);
      AplLibStdAdd.aplLibRemove(tid, prnPath);
      return	0;
    }
    return	-1;
  }
}
