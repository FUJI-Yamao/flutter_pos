/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/common/cls_conf/mac_infoJsonFile.dart';
import 'package:flutter_pos/app/common/cmn_sysfunc.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';
import 'package:flutter_pos/app/inc/sys/tpr_log.dart';
import 'package:flutter_pos/app/inc/sys/tpr_type.dart';
import 'package:flutter_pos/postgres_library/src/db_manipulation_ps.dart';

import '../../ui/model/m_dialog_info.dart';

/// ダイアログメッセージDB操作クラス.
class DialogDB {
  /// ダイアログメッセージIDのデータを取得する.
  static const DIALOG_SQL_SELCT_MESSAGES =
      'SELECT message1, message2, message3, message4, message5, title_img_cd, title_col FROM c_dialog_mst '
      'WHERE comp_cd = @comp AND stre_cd = @stre AND dialog_cd = @dialogCd';

  ///DbManipulationPsを使用し、指定されたdialogCdに基づいてmessageを取得する
  static Future<DialogInfo> getMessageByDialogCd(TprTID tid, int dialogCd) async {
    DbManipulationPs db = DbManipulationPs();
    DialogInfo dialogInfo = DialogInfo();

    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      return dialogInfo;
    }
    RxCommonBuf pCom = xRet.object;
    Mac_infoJsonFile macJson = pCom.iniMacInfo;

    ///必要なパラメータをマッピングする
    ///会社コード、店舗コード、ダイアログIDをパラメータとして設定
    try {
      Map<String, dynamic> params = {
        "comp": macJson.system.crpno,
        "stre": macJson.system.shpno,
        "dialogCd": dialogCd,
      };

      ///DbManipulationPsを使用してSQLクリエ実行し、resultsを取得する
      ///ResultRowから列名と値のマップを取得
      ///message1からmessage5まで各メッセージをマップに格納（nullの場合は ''で置き換え
      var results = await db.dbCon
          .execute(Sql.named(DIALOG_SQL_SELCT_MESSAGES), parameters: params);

      if (results.isNotEmpty) {
        ResultRow row = results.first;
        Map<String, dynamic> columnMap = row.toColumnMap();

        String formattedMessages = ' ';
        for (int i = 1; i <= 5; i++) {
          String key = 'message$i';
          String message = columnMap[key] as String? ?? '';
          if (message.isNotEmpty) {
            if (formattedMessages.isNotEmpty) {
              formattedMessages += '\n';
            }
            formattedMessages += message;
          }
        }
        dialogInfo.result = true;
        dialogInfo.messages = formattedMessages;
        /// title_img_cdはlong型のため、環境によりString型として取得される場合がある
        String titleImgCdStr = columnMap["title_img_cd"] as String;
        int? convTitleImgCd = int.tryParse(titleImgCdStr);
        dialogInfo.titleImgCd = convTitleImgCd!;
        /// title_colはshort型のためint型として取得できる
        dialogInfo.titleColorCd = columnMap["title_col"];

        return dialogInfo;
      }
    } catch (e, s) {
      TprLog().logAdd(tid, LogLevelDefine.error,
          "getMessageByDialogCd(): dbC_PQexec() c_dialog_mst read error $e, $s",
          errId: -1);
    }
    dialogInfo.messages = dialogCd.toString();
    return dialogInfo;
  }
}
