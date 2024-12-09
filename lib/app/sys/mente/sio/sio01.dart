/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:io';

import '../../../../../../postgres_library/src/db_manipulation_ps.dart';
import '../../../../postgres_library/src/pos_basic_table_access.dart';
import '../../../common/cls_conf/configJsonFile.dart';
import '../../../common/cls_conf/sysJsonFile.dart';
import '../../../common/cls_conf/absv31JsonFile.dart';
import '../../../common/cls_conf/acb20JsonFile.dart';
import '../../../common/cls_conf/acb50JsonFile.dart';
import '../../../common/cls_conf/acbJsonFile.dart';
import '../../../common/cls_conf/acrJsonFile.dart';
import '../../../common/cls_conf/aivJsonFile.dart';
import '../../../common/cls_conf/ar_stts_01JsonFile.dart';
import '../../../common/cls_conf/ccrJsonFile.dart';
import '../../../common/cls_conf/cctJsonFile.dart';
import '../../../common/cls_conf/dishJsonFile.dart';
import '../../../common/cls_conf/dishtJsonFile.dart';
import '../../../common/cls_conf/fal2JsonFile.dart';
import '../../../common/cls_conf/fclJsonFile.dart';
import '../../../common/cls_conf/gcat_cnctJsonFile.dart';
import '../../../common/cls_conf/gpJsonFile.dart';
import '../../../common/cls_conf/ht2980JsonFile.dart';
import '../../../common/cls_conf/jmupsJsonFile.dart';
import '../../../common/cls_conf/jrw_multiJsonFile.dart';
import '../../../common/cls_conf/masrJsonFile.dart';
import '../../../common/cls_conf/mcp200JsonFile.dart';
import '../../../common/cls_conf/mstJsonFile.dart';
import '../../../common/cls_conf/orcJsonFile.dart';
import '../../../common/cls_conf/pana_gcatJsonFile.dart';
import '../../../common/cls_conf/panaJsonFile.dart';
import '../../../common/cls_conf/pctJsonFile.dart';
import '../../../common/cls_conf/psp60JsonFile.dart';
import '../../../common/cls_conf/psp70JsonFile.dart';
import '../../../common/cls_conf/pw410JsonFile.dart';
import '../../../common/cls_conf/pwrctrlJsonFile.dart';
import '../../../common/cls_conf/rewrite_cardJsonFile.dart';
import '../../../common/cls_conf/rfidJsonFile.dart';
import '../../../common/cls_conf/s2prJsonFile.dart';
import '../../../common/cls_conf/scale_sksJsonFile.dart';
import '../../../common/cls_conf/scaleJsonFile.dart';
import '../../../common/cls_conf/scan_2800ip_2JsonFile.dart';
import '../../../common/cls_conf/scan_plus_1JsonFile.dart';
import '../../../common/cls_conf/scan_plus_2JsonFile.dart';
import '../../../common/cls_conf/sioJsonFile.dart';
import '../../../common/cls_conf/sip60JsonFile.dart';
import '../../../common/cls_conf/sm_scale1JsonFile.dart';
import '../../../common/cls_conf/sm_scale2JsonFile.dart';
import '../../../common/cls_conf/sm_scalescJsonFile.dart';
import '../../../common/cls_conf/smtplusJsonFile.dart';
import '../../../common/cls_conf/stprJsonFile.dart';
import '../../../common/cls_conf/suicaJsonFile.dart';
import '../../../common/cls_conf/vega3000JsonFile.dart';
import '../../../common/cls_conf/vismacJsonFile.dart';
import '../../../common/cls_conf/yamatoJsonFile.dart';
import '../../../common/cls_conf/yomocaJsonFile.dart';
import '../../../common/cmn_sysfunc.dart';
import '../../../common/environment.dart';
import '../../../inc/apl/compflag.dart';
import '../../../inc/apl/rxmem_define.dart';
import '../../../inc/lib/cm_sys.dart';
import '../../../inc/lib/mm_reptlib_def.dart';
import '../../../inc/sys/tpr_aid.dart';
import '../../../inc/sys/tpr_def.dart';
import '../../../inc/sys/tpr_log.dart';
import '../../../lib/apllib/cnct.dart';
import '../../../lib/apllib/mm_reptlib.dart';
import '../../../lib/apllib/recog.dart';
import '../../../lib/apllib/sio_db.dart';
import '../../../lib/cm_ary/cm_ary.dart';
import '../../../lib/cm_ej/cm_ejlib.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import 'sio_def.dart';
import 'sio02.dart';

/// SIO画面
/// 関連tprxソース:sio01.c
class Sio01 {
  /// Button Parameter
  var btnStat = List<Sio01BtnStat>.generate(SioDef.SIONUM_MAX, (index) => Sio01BtnStat());
  /// Tool Table
  late List<List<SioToolTbl>> sioCnctTbl;
  /// Token Table
  var sioDevTblOld = List<SioTokTbl>.generate(SioDef.SIONUM_MAX, (index) => SioTokTbl(SioDef.NOT_USE));
  var sioDevTblNew = List<SioTokTbl>.generate(SioDef.SIONUM_MAX, (index) => SioTokTbl(''));
  /// Section Table
  var sioSectTitleTbl = List<SioSectTbl>.generate(
      SioDef.PAGE_MAX * SioDef.TOOL_MAX, (index) => SioSectTbl());
  /// QCJC Type Table    /* QCJC -1:No QCJC  0:QCashierJ  1:WebSpeezaC */
  List<List<int>> sioQcjcTyp = [
    [ 0, 0, 0, 0 ],
    [ 0, 0, 0, 0 ],
  ];
  /// Rx Common Buf
  late RxCommonBuf pCom;
  /// Json Files
  late ConfigJsonFile jsonFile;
  /// SIO接続機器一覧画面の表示項目数
  int toolTblLen = 0;
  /// 選択したSIO No
  int sioStatus = 0;
  /// WEB機種タイプ（各種iniファイルより取得）
  int webType = 0;
  /// WEB2800の機種タイプ
  int web28Type = 0;
  /// WEBの機種タイプ（sys.jsonより取得）
  String bootType = '';
  /// タワー機種フラグ
  bool towerFlg = false;

  /// SIO画面描画時の処理【フロント連携】
  /// （メンテナンスメニューから、SIOボタンを押下した時の処理）
  /// 引数: なし
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - sio01_clicked()
  Future<bool> sio01Init() async {
    // RxMem
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if (xRet.isInvalid()) {
      return false;
    }
    pCom = xRet.object;

    int dspBit = await _dispGet();

    // DBチェック
    await SioDB.sioRegcnctDbCheck(SioDef.SIOLOG);

    // sio button setting
    for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
      if ( ((i == 0) && ((dspBit & 0x01) == 1)) ||
           ((i == 1) && ((dspBit & 0x02) == 2)) ||
           ((i == 2) && ((dspBit & 0x04) == 4)) ||
           ((i == 3) && ((dspBit & 0x08) == 8)) ) {
        btnStat[i].sioOutput = true;
      }
    }

    // status initialize
    sioStatus = 0;

    // window status initialize
    if (!(await _setToolTableInit())) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio tool table init err!!', errId: -1);
      return false;
    }

    // read sio-param from Database (c_regcnct_sio_mst)
    if ((sioDevTblOld[0].device == SioDef.NOT_USE) &&
        (sioDevTblOld[1].device == SioDef.NOT_USE) &&
        (sioDevTblOld[2].device == SioDef.NOT_USE) &&
        (sioDevTblOld[3].device == SioDef.NOT_USE)) {
      if (!(await setDevTableInit())) {
        return false;
      }
    }

    // create label & show label
    sio01SetLabel(sioDevTblOld);

    // table copy
    for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
      sioDevTblNew[i].device = sioDevTblOld[i].device;
      sioDevTblNew[i].baud = sioDevTblOld[i].baud;
      sioDevTblNew[i].stopB = sioDevTblOld[i].stopB;
      sioDevTblNew[i].dataB = sioDevTblOld[i].dataB;
      sioDevTblNew[i].parity = sioDevTblOld[i].parity;
    }

    return true;
  }

  /// Web機種タイプから、構成されるSIOを取得する
  /// 引数: なし
  /// 戻り値: SIOの構成を示すデータビット
  /// 関連tprxソース: sio01.c - Sio01_disp_get()
  Future<int> _dispGet() async {
    // sys.json からデータを取得
    SysJsonFile sysJson = pCom.iniSys;

    webType = await CmCksys.cmWebType();
    web28Type = CmCksys.cmWeb2800Type(sysJson);
    bootType = CmCksys.cmWebTypeGet(sysJson);
    towerFlg = bootType.contains('tower');

    int ret = 0x00;
    if (CmCksys.cmRm5900System() != 0) {
      ret = 0x05;
    } else {
      switch (webType) {
        case CmSys.WEBTYPE_WEB2300:
        case CmSys.WEBTYPE_WEB2500:
        case CmSys.WEBTYPE_WEB2350:
        case CmSys.WEBTYPE_WEB2800:
        case CmSys.WEBTYPE_WEBPLUS2:
          if (web28Type == CmSys.WEB28TYPE_IP) {
            ret = 0x07;
          } else {
            ret = 0x0f;
          }
          break;
        case CmSys.WEBTYPE_WEBPLUS:
          ret = 0x0d;
          break;
        default:
          ret = 0x0e;
          break;
      }
    }

    return ret;
  }

  /// JSONファイル、DBからデータを取得し、ツールテーブルへ格納する
  /// 引数: なし
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - Sio_Init()
  Future<bool> _setToolTableInit() async {
    // セクション日本語名テーブルを作成
    if (!(await createSectTitleTable())) {
      return false;
    }

    String keyword = '';
    JsonRet jsonRet;
    String secBuf = '';
    String title = '';
    String sql = '';
    int tmpToolLen = 0;
    Result dataList;
    var tmpTbl = List<List<SioToolTbl>>.generate(SioDef.PAGE_MAX,
            (index) => List.generate(SioDef.TOOL_MAX, (index) => SioToolTbl()));
    try {
      // DBサーバーへの接続
      RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
      if(xRet.isInvalid()){
        TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
            'sio Get Json Err - SystemFunc.rxMemRead[RXMEM_COMMON]', errId: -1);
        return false;
      }
      RxCommonBuf pCom = xRet.object;
      var db = DbManipulationPs();
      // All Tool Get
      var sioJson = SioJsonFile();
      var sysJson = pCom.iniSys;
      await sioJson.load();
      for (int page = 0; page < SioDef.PAGE_MAX; page++) {
        for (int tool = 0; tool < SioDef.TOOL_MAX; tool++) {
          keyword = 'button${((page*SioDef.TOOL_MAX)+tool+1).toString().padLeft(2, '0')}';
          jsonRet = await sioJson.getValueWithName(keyword, 'title');
          if (!jsonRet.result) {
            TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                'sio Get Json Err - title: ${jsonRet.cause.name}', errId: -1);
            return false;
          }
          if (jsonRet.value != SioDef.NONE_CH) {
            if (jsonRet.value != SioDef.NOT_USE) {
              // kind（機器グループ）取得
              jsonRet = await sioJson.getValueWithName(keyword, 'kind');
              if (!jsonRet.result) {
                TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                    'sio Get Json Err - kind: ${jsonRet.cause.name}', errId: -1);
                return false;
              }
              tmpTbl[page][tmpToolLen].kind = jsonRet.value;
              // section（ドライバ セクション名）取得
              jsonRet = await sioJson.getValueWithName(keyword, 'section');
              if (!jsonRet.result) {
                TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                    'sio Get Json Err - section: ${jsonRet.cause.name}', errId: -1);
                return false;
              }
              tmpTbl[page][tmpToolLen].section = jsonRet.value;
              // セクションタイトル名テーブルからセクション日本語タイトルを取得
              secBuf = jsonRet.value.toString();
              title = '';
              for (int i = 0; i < SioDef.PAGE_MAX * SioDef.TOOL_MAX; i++) {
                if (secBuf == sioSectTitleTbl[i].sectionName) {
                  title = sioSectTitleTbl[i].titleName;
                  break;
                }
              }
              if ((title.isEmpty) ||
                  (!(await _sectLabelOutputCheck(secBuf)))) {
                continue;
              } else {
                tmpTbl[page][tmpToolLen].label = title;
              }
              // ドライバセクション名が、sys.jsonで定義されるinifileに設定されているか
              jsonRet = await sysJson.getValueWithName(tmpTbl[page][tmpToolLen].section, 'inifile');
              if (!jsonRet.result) {
                TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                    'sio Get sysJson Err - inifile: ${jsonRet.cause.name}', errId: -1);
                return false;
              }
              tmpTbl[page][tmpToolLen].fName = jsonRet.value;
              // kindとsectionをキーに、DBに登録されているかチェック
              sql = SioDef.SIO_SQL_GET_SIO_DEFAULT_DATA ;
              Map<String, dynamic>? subValues = {
                "cnct_grp"     : tmpTbl[page][tmpToolLen].kind,
                "drv_sec_name" : tmpTbl[page][tmpToolLen].section
              };

              dataList = await db.dbCon.execute(Sql.named(sql),parameters: subValues);
              if (dataList.isEmpty) {
                TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                    '_setToolTableInit(): DB error '
                    '(SIO_SQL_GET_SIO_DEFAULT_DATA selected rec count = 0) - '
                    'kind=${tmpTbl[page][tmpToolLen].kind}  '
                    'section=${tmpTbl[page][tmpToolLen].section}', errId: -1);
                continue;
              } else {
                // 取得データを tmpTbl に格納
                Map<String,dynamic> data = dataList.first.toColumnMap();
                tmpTbl[page][tmpToolLen].baud = data['sio_rate'];
                tmpTbl[page][tmpToolLen].stopB = data['sio_stop'];
                tmpTbl[page][tmpToolLen].dataB = data['sio_record'];
                tmpTbl[page][tmpToolLen].parity = data['sio_parity'];
                tmpToolLen++;
              }
            } else {
              // 接続機器「使用せず」のパラメタ
              tmpTbl[page][tmpToolLen].label = jsonRet.value;
              tmpTbl[page][tmpToolLen].baud = -1;
              tmpTbl[page][tmpToolLen].stopB = -1;
              tmpTbl[page][tmpToolLen].dataB = -1;
              tmpTbl[page][tmpToolLen].parity = -1;
              tmpToolLen++;
            }
          }
        }
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_setToolTableInit() : $e $s )");
      return false;
    }
    // tmpTblの値をsioToolTblに格納
    if (tmpToolLen.isOdd) {
      tmpToolLen++;
    }
    toolTblLen = tmpToolLen ~/ SioDef.PAGE_MAX;
    sioCnctTbl = List<List<SioToolTbl>>.generate(SioDef.PAGE_MAX,
            (index) => List.generate(toolTblLen, (index) => SioToolTbl()));
    for (int i=0; i<SioDef.PAGE_MAX; i++) {
      sioCnctTbl[i] = tmpTbl[i].sublist(toolTblLen*i, toolTblLen*(i+1));
    }

    return true;
  }

  /// セクションタイトル名テーブルを作成する
  /// 引数: なし
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - create_section_title_table()
  Future<bool> createSectTitleTable() async {
    try {
      // DBサーバーへの接続
      var db = DbManipulationPs();
      // SQL文を作成し、実行
      String sql = SioDef.SIO_SQL_GET_SECTIONTITLE;
      Map<String, dynamic>? subValues = {
        "comp" : pCom.iniMacInfoCrpNoNo,
        "stre" : pCom.iniMacInfoShopNo
      };

      Result dataList = await db.dbCon.execute(Sql.named(sql),parameters: subValues);
      if (dataList.isEmpty) {
        TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
            'createSectTitleTable(): DB error (Get sio section title tables)', errId: -1);
        return false;
      }
      // 上限設定
      int ntuples = 0;
      if (dataList.length > SioDef.PAGE_MAX * SioDef.TOOL_MAX) {
        ntuples = SioDef.PAGE_MAX * SioDef.TOOL_MAX;
      } else {
        ntuples = dataList.length;
      }
      // 取得データを sioSectTitleTbl に格納
      for (int i = 0; i < ntuples; i++) {
        Map<String,dynamic> data = dataList[i].toColumnMap();
        sioSectTitleTbl[i].sectionName = data['drv_sec_name'];
        sioSectTitleTbl[i].titleName = data['img_data'];
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "createSectTitleTable() : $e $s )");
      return false;
    }

    return true;
  }

  /// ドライバセクションとコンパイルフラグから、ツールラベルの表示/非表示をチェックする
  /// 引数:[section] ドライバセクション名
  /// 戻り値: true=ラベル表示  false=ラベル非表示
  /// 関連tprxソース: sio01.c - Sio_Init()
  Future<bool> _sectLabelOutputCheck(String section) async {
    if ( ( ( (section == SioDef.SIO_SEC_ACR) ||
             (section == SioDef.SIO_SEC_ACB) ||
             (section == SioDef.SIO_SEC_ACB20) ||
             (section == SioDef.SIO_SEC_FAL2)
           ) &&
           (!CompileFlag.AUTO_COIN)
         ) ||
         ( (section == SioDef.SIO_SEC_VMC) &&
           (!CompileFlag.VISMAC)
         ) ||
         ( (section == SioDef.SIO_SEC_ORC) &&
           (!CompileFlag.IWAI)
         ) ||
         ( (section == SioDef.SIO_SEC_REWRIT) &&
           (!CompileFlag.REWRITE_CARD)
         ) ||
         ( (section == SioDef.SIO_SEC_GCAT) &&
           (!CompileFlag.DEBIT_CREDIT)
         ) ||
         ( ( (section == SioDef.SIO_SEC_SG1) ||
             (section == SioDef.SIO_SEC_SG2)
           ) &&
           (!CompileFlag.SELF_GATE)
         ) ||
         ( ( (section == SioDef.SIO_SEC_SM1) ||
             (section == SioDef.SIO_SEC_SM2) ||
             (section == SioDef.SIO_SEC_SC)
           ) &&
           ( (!CompileFlag.SELF_GATE) ||
             (webType == CmSys.WEBTYPE_WEB2300) ||
             (webType == CmSys.WEBTYPE_WEBPLUS) ||
             (webType == CmSys.WEBTYPE_WEB2350) ||
             (webType == CmSys.WEBTYPE_WEB2500) ||
             (webType == CmSys.WEBTYPE_WEBPLUS2)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_SCALE) &&
           (!CompileFlag.SCALE_SYSTEM)
         ) ||
         ( (section == SioDef.SIO_SEC_SIP60) &&
           (await CmCksys.cmEdySystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_PSP60) &&
           (!CompileFlag.POINT_CARD)
         ) ||
         ( (section == SioDef.SIO_SEC_STPR) &&
           (!CompileFlag.STATION_PRINTER)
         ) ||
         ( (section == SioDef.SIO_SEC_PANA) &&
           ( ( (!CompileFlag.MC_SYSTEM) ||
               (await CmCksys.cmMcSystem() == 0)
             ) &&
             (!CompileFlag.SAPPORO)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_GP) &&
           ( (!CompileFlag.TAG_PRINT) ||
             ((await Recog().recogGet(
                 SioDef.SIOLOG,
                 RecogLists.RECOG_TAG_PRINT,
                 RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_S2PR) &&
           (!CompileFlag.TW_2S_PRINTER)
         ) ||
         ( (section == SioDef.SIO_SEC_ACB50) &&
           (!CompileFlag.ACB_50)
         ) ||
         ( (section == SioDef.SIO_SEC_PW410) &&
           (!CompileFlag.PW410_SYSTEM)
         ) ||
         ( (section == SioDef.SIO_SEC_CCR) &&
           (!CompileFlag.CN_NSC)
         ) ||
         ( (section == SioDef.SIO_SEC_PSP70) &&
           ( (!CompileFlag.PSP_70) ||
             (await CmCksys.cmPspSystem() == 0)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_DISH) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_DISHCALCSYSTEM,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_AIV) &&
           (!CompileFlag.SSPS_SOUND)
         ) ||
         ( (section == SioDef.SIO_SEC_SCAN_PLUS_1) &&
           ( (webType != CmSys.WEBTYPE_WEBPLUS) &&
             (webType != CmSys.WEBTYPE_WEBPLUS2) &&
             (webType != CmSys.WEBTYPE_WEB2800) &&
             (webType != CmSys.WEB28TYPE_PR3)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_SCAN_PLUS_2) &&
           ( (webType != CmSys.WEBTYPE_WEBPLUS) &&
             (webType != CmSys.WEBTYPE_WEBPLUS2)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_YOMOCA) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_YOMOCASYSTEM,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_SMTPLUS) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_SMARTPLUSSYSTEM,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_SUICA) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_ICCARDSYSTEM,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_RFID) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_TAGRDWT,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_MCP) &&
           ((await Recog().recogGet(
               SioDef.SIOLOG,
               RecogLists.RECOG_MCP200SYSTEM,
               RecogTypes.RECOG_GETMEM)).result == RecogValue.RECOG_NO)
         ) ||
         ( (section == SioDef.SIO_SEC_FCL) &&
           (!(await _sio01MultiCnctCheck()))
         ) ||
         ( (section == SioDef.SIO_SEC_JRW_MULTI) &&
           (await CmCksys.cmJremMultiSystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_HT2980) &&
           (await CmCksys.cmHitachiBluechipSystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_ABSV31) &&
           (await CmCksys.cmAbsV31RwtSystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_SCAN_2800_2) &&
           ( ( (webType == CmSys.WEBTYPE_WEB2800) &&
               (towerFlg)
             ) ||
             (webType != CmSys.WEBTYPE_WEB2800)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_YAMATO) &&
           (await CmCksys.cmYamatoSystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_CCT) &&
           (CmCksys.cmCctCnctCkeck() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_MASR) &&
           (CmCksys.cmMasrSystem() == 0)
         ) ||
         ( (section == SioDef.SIO_SEC_JMUPS) &&
           ( (await CmCksys.cmJmupsSystem() == 0) &&
             (await CmCksys.cmVescaSystem() == 0)
           )
         ) ||
         ( (section == SioDef.SIO_SEC_MST) &&
           (await CmCksys.cmZHQSystem() == 0)
         ) ||
         ( ( (section == SioDef.SIO_SEC_GCAT) ||
             (section == 'gcat_cnct')
           ) &&
           (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 12)
         ) ||
         ( (section == SioDef.SIO_SEC_PCT) &&
           (Cnct.cnctMemGet(Tpraid.TPRAID_SYSTEM, CnctLists.CNCT_GCAT_CNCT) == 23)
         )
      ) {
      return false;
    }

    return true;
  }

  /// MAC_INFO.JSONのデータ「マルチ端末機接続（FeliCa非接触IC）」が規定値かチェックする
  /// 引数: なし
  /// 戻り値: true=規定値  false=規定値でない or JSONファイル読取失敗
  /// 関連tprxソース: sio01.c - Fcls_cont_typ()
  Future<bool> _sio01MultiCnctCheck() async {
    var (bool ret, int typ) = await Cnct.cnctSysGet(SioDef.SIOLOG, CnctLists.CNCT_MULTI_CNCT);

    if (!ret) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio Get mac_info Json Err - CNCT_MULTI_CNCT', errId: -1);
      return false;
    } else {
      if ((typ != 1) && (typ != 2)) {
        return false;
      }
    }

    return true;
  }

  /// DBからデータを取得し、デバイステーブル(old)に格納する
  /// 引数: なし
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - Sio01_Get_Ini_All()
  Future<bool> setDevTableInit() async {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        'sio boot_type = $bootType');

    try {
      // DBサーバーへの接続
      var db = DbManipulationPs();
      // SQL文を作成し、実行
      String sql = SioDef.SIO_SQL_GET_REGCNCT_SIO_DATA;
      Map<String, dynamic>? subValues = {
        "comp" : pCom.iniMacInfoCrpNoNo,
        "stre" : pCom.iniMacInfoShopNo,
        "mac"  : pCom.iniMacInfoMacNo
      };

      Result dataList = await db.dbCon.execute(Sql.named(sql),parameters: subValues);
      if (dataList.isEmpty) {
        // 空データを sioDevTblOld に格納（ポート数分ループ）
        TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
            'setDevTableInit(): DB No Data (c_regcnct_sio_mst)');
        return true;
      }
      // 取得データを sioDevTblOld に格納（ポート数分ループ）
      int pGetValue = 0;
      int nRec = 0;
      for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
        Map<String ,dynamic> data  =dataList[nRec].toColumnMap();
        pGetValue = data['com_port_no'];
        if (i == pGetValue - 1) {
          sioDevTblOld[i].device = data['img_data'];
          sioDevTblOld[i].baud = data['sio_rate'] as int;
          sioDevTblOld[i].stopB = data['sio_stop'] as int;
          sioDevTblOld[i].dataB = data['sio_record'] as int;
          sioDevTblOld[i].parity = data['sio_parity'] as int;
          nRec++;
        }
        if (nRec >= dataList.length) {
          break;
        }
      }
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "setDevTableInit() : $e $s )");
      return false;
    }

    return true;
  }

  /// デバイステーブルと各種チャンネルテーブルからボタンラベルを生成する
  /// 引数:[devTbl] デバイステーブル
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - Sio01_Set_Label()
  void sio01SetLabel(List<SioTokTbl> devTbl) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        'sio01SetLabel() : called');

    int k = 0;
    String buf = '';
    for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
      // label set: SIO Button
      btnStat[i].sio = devTbl[i].device;

      if (!btnStat[i].sioOutput) {
        continue;
      }
      if ((devTbl[i].device != SioDef.NOT_USE) &&
          (devTbl[i].device != SioDef.PWRCTRL)) {
        // label set: Slave Buttons (baudrate, stopbit, databit, parity)
        btnStat[i].baud = '${SioDef.BAUD}\n${SioDef.sioBaudTbl[devTbl[i].baud].kyword}';
        btnStat[i].stopB = '${SioDef.STOPB}\n${SioDef.sioStopbTbl[devTbl[i].stopB].kyword}';
        btnStat[i].dataB = '${SioDef.DATAB}\n${SioDef.sioDatabTbl[devTbl[i].dataB].kyword}';
        k = 0;
        while (true) {
          if (SioDef.sioPariTbl[k].token == null) {
            break;
          }
          if (devTbl[i].parity == SioDef.sioPariTbl[k].num) {
            buf = SioDef.sioPariTbl[k].kyword;
            if (buf!.isEmpty) {
              buf = '';
            }
            break;
          }
          k++;
        }
        btnStat[i].parity = '${SioDef.PARI}\n$buf';
        // button show
        btnStat[i].slvOutput = true;
      } else {
        // button hide
        btnStat[i].slvOutput = false;
      }
    }
  }


  /// SIO#1~4ボタン押下時（SIO接続機器一覧画面へ移行する）
  /// 引数:[num] SIO No (0:Sio#1 ~ 3:Sio#4)
  /// 戻り値: Sio02 一覧画面操作処理クラス.
  /// 関連tprxソース: sio01.c - sio01_bt_clicked()
  Future<Sio02> sio01BtClicked(int num) async {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01BtClicked(): Sio #${num+1}');
    // set status
    sioStatus = num;
    // window 2 call
    var sioJson = SioJsonFile();
    await sioJson.load();
    JsonRet jsonRet = await sioJson.getValueWithName('global', 'title');
    if (!jsonRet.result) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio Get Json Err - [global] title: ${jsonRet.cause.name}', errId: -1);
      jsonRet.value = '';
    }
    Sio02 sio02 = Sio02(this);
    await sio02.sio02Init(jsonRet.value);
    return sio02;
  }


  /// 保存ボタン押下時【フロント連携】
  /// 引数: なし
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - sio01_05_clicked()
  Future<bool> sio01ConfirmClicked() async {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01ConfirmClicked()');

    // update jsonfiles to sio_dev_new_table value
    if (!(await _sio01SetJson(sioDevTblNew))) {
      return false;
    }

    _sio01EjSet(sioDevTblNew);

    for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
      sioDevTblOld[i].device = sioDevTblNew[i].device;
      sioDevTblOld[i].baud = sioDevTblNew[i].baud;
      sioDevTblOld[i].stopB = sioDevTblNew[i].stopB;
      sioDevTblOld[i].dataB = sioDevTblNew[i].dataB;
      sioDevTblOld[i].parity = sioDevTblNew[i].parity;
    }

    return true;
  }

  /// SYS・QCJC・ツールテーブルが指し示すJSONファイルに、SIOテーブルの値を書き込む
  /// 引数:[devTbl] デバイステーブル
  /// 戻り値: true=正常終了  false=異常終了
  /// 関連tprxソース: sio01.c - Sio01_Set_Ini()
  Future<bool> _sio01SetJson(List<SioTokTbl> devTbl) async {
    bool ret = true;
    bool update = false;

    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        'sio01SetJson() : called');

    // sys.json からデータを取得
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);
    if(xRet.isInvalid()){
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          '_sio01SetJson(): SystemFunc.rxMemRead[RXMEM_COMMON]', errId: -1);
      return false;
    }
    RxCommonBuf pCom = xRet.object;
    SysJsonFile sysJson = pCom.iniSys;

    try {
      // DBサーバーへの接続
      var db = DbManipulationPs();
      JsonRet jsonRet;
      String drv;
      String fName;
      String fileTmpP;
      int comPortNo;
      int delPortNo;
      int baud;
      int stopB;
      int dataB;
      int parity;
      String setValue = '';
      Result deleteResult;
      Result updateResult;
      Result insertResult;
      // トランザクション処理
      await db.dbCon.runTx((txn) async {
        // SIO#別に処理
        for (int sioNo = 0; sioNo < SioDef.SIONUM_MAX; sioNo++) {
          drv = 'drivers${TprDef.TPRSIO_DNUM1 + sioNo}';
          fName = '';
          fileTmpP = '';
          comPortNo = 0;
          delPortNo = 0;
          baud = -1;
          stopB = -1;
          dataB = -1;
          parity = -1;
          setValue = '';
          if (devTbl[sioNo].device == SioDef.NOT_USE) {
            // drivers**
            jsonRet = await sysJson.setValueWithName(bootType, drv, "    ");
            if (!jsonRet.result) {
              TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                  'sio sys.json Err: ${jsonRet.cause.name}', errId: -1);
              ret = false;
              db.rollback(txn);
            } else {
              update = true;
            }
            // port num set, record Delete
            switch (sioNo) {
              case 0:
                comPortNo = 1;
                if (CmCksys.cmWebplus2System() == 0) {
                  // ポート番号 = 5 のレコードがいたら不要なので消す
                  delPortNo = 5;
                } else {
                  // ポート番号 = 3 のレコードがいたら不要なので消す
                  delPortNo = 3;
                }
                // Delete record
                Map<String, dynamic>? subValues = {
                  "comp": pCom.iniMacInfoCrpNoNo,
                  "stre": pCom.iniMacInfoShopNo,
                  "mac": pCom.iniMacInfoMacNo,
                  "cp_no": delPortNo
                };
                await txn.execute(Sql.named(SioDef.SIO_SQL_DEL_REGCNCT_SIO_DATA),
                    parameters: subValues);
                // record check (Delete)
                 deleteResult = await txn.execute(
                     Sql.named(SioDef.SIO_SQL_CHK_REGCNCT_SIO_DATA),
                    parameters: subValues);
                if (deleteResult.isNotEmpty) {
                  TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                      '_sio01SetJson(): DB error (DELETE FROM c_regcnct_sio_mst)',
                      errId: -1);
                  ret = false;
                  db.rollback(txn);
                }
                break;
              case 1:
                comPortNo = 2;
                break;
              case 2:
                if (CmCksys.cmWebplus2System() == 0) {
                  comPortNo = 3;
                } else {
                  comPortNo = 4;
                }
                break;
              case 3:
                if (CmCksys.cmWebplus2System() == 0) {
                  comPortNo = 4;
                } else {
                  comPortNo = 5;
                }
                break;
              default:
                break;
            }
            // Update Record
            Map<String, dynamic>? subValues = {
              "cnct_kind": 0,
              "cnct_grp": 0,
              "sio_rate": -1,
              "sio_stop": -1,
              "sio_record": -1,
              "sio_parity": -1,
              "qcjc_flg": sioQcjcTyp[0][sioNo],
              "upd_user": SioDef.LOGIN_STAFF_CD,
              "comp": pCom.iniMacInfoCrpNoNo,
              "stre": pCom.iniMacInfoShopNo,
              "mac": pCom.iniMacInfoMacNo,
              "cp_no": comPortNo
            };
            await txn.execute(Sql.named(SioDef.SIO_SQL_UPD_REGCNCT_SIO_DATA),
                parameters: subValues);
            // record check (Update)
            updateResult = await txn.execute(
                Sql.named(SioDef.SIO_SQL_CHK_INSUPD_REGCNCT_SIO_DATA),
                parameters: subValues);
            if (updateResult.isEmpty) {
              // Insert record (NOT_USE default)
              Map<String, dynamic>? subValues = {
                "comp": pCom.iniMacInfoCrpNoNo,
                "stre": pCom.iniMacInfoShopNo,
                "mac": pCom.iniMacInfoMacNo,
                "cp_no": comPortNo,
                "cnct_kind": 0,
                "cnct_grp": 0,
                "sio_rate": -1,
                "sio_stop": -1,
                "sio_record": -1,
                "sio_parity": -1,
                "qcjc_flg": sioQcjcTyp[0][sioNo],
                "upd_user": SioDef.LOGIN_STAFF_CD
              };
              await txn.execute(Sql.named(SioDef.SIO_SQL_INS_REGCNCT_SIO_DATA),
                  parameters: subValues);
              // record check (Insert)
              insertResult = await txn.execute(
                  Sql.named(SioDef.SIO_SQL_CHK_INSUPD_REGCNCT_SIO_DATA),
                  parameters: subValues);
              if (insertResult.isEmpty) {
                TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                    '_sio01SetJson(): DB error (INSERT INTO c_regcnct_sio_mst)',
                    errId: -1);
                ret = false;
                db.rollback(txn);
              }
            }
          } else {
            // SIO接続機器一覧画面
            for (int page = 0; page < SioDef.PAGE_MAX; page++) {
              for (int tool = 0; tool < toolTblLen; tool++) {
                // search section
                if (devTbl[sioNo].device == sioCnctTbl[page][tool].label) {
                  // json file exist?
                  fName = sioCnctTbl[page][tool].fName.substring(5);
                  TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
                      'sio# = ${sioNo + 1}  filename = $fName');
                  if (!_sio01SelectJson(fName)) {
                    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                        'sio make file Err', errId: -1);
                    ret = false;
                    db.rollback(txn);
                  }
                  await jsonFile.load();
                  // set data
                  if (fName != 'pwrctrl.json') {
                    // set data (baudrate)
                    setValue = SioDef.sioBaudTbl[devTbl[sioNo].baud].token;
                    jsonRet = await jsonFile.setValueWithName(
                        'settings', 'baudrate', int.parse(setValue));
                    if (!jsonRet.result) {
                      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                          'sio SetJson Err baudrate: ${jsonRet.cause.name}',
                          errId: -1);
                      ret = false;
                      db.rollback(txn);
                    }
                    baud = devTbl[sioNo].baud;
                    // set data (stop bit)
                    setValue = SioDef.sioStopbTbl[devTbl[sioNo].stopB].token;
                    jsonRet = await jsonFile.setValueWithName(
                        'settings', 'stopbit', int.parse(setValue));
                    if (!jsonRet.result) {
                      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                          'sio SetJson Err stopbit: ${jsonRet.cause.name}',
                          errId: -1);
                      ret = false;
                      db.rollback(txn);
                    }
                    stopB = devTbl[sioNo].stopB;
                    // set data (data bit)
                    setValue = SioDef.sioDatabTbl[devTbl[sioNo].dataB].token;
                    jsonRet = await jsonFile.setValueWithName(
                        'settings', 'databit', int.parse(setValue));
                    if (!jsonRet.result) {
                      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                          'sio SetJson Err databit: ${jsonRet.cause.name}',
                          errId: -1);
                      ret = false;
                      db.rollback(txn);
                    }
                    dataB = devTbl[sioNo].dataB;
                    // set data (parity)
                    setValue = SioDef.sioPariTbl[devTbl[sioNo].parity].token;
                    jsonRet = await jsonFile.setValueWithName(
                        'settings', 'parity', setValue);
                    if (!jsonRet.result) {
                      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                          'sio SetJson Err parity: ${jsonRet.cause.name}',
                          errId: -1);
                      ret = false;
                      db.rollback(txn);
                    }
                    parity = devTbl[sioNo].parity;
                    // set data (conf/iccon/cfg/Common.json)
                    if (fName == 'jrw_multi.json') {
                      fileTmpP = '${EnvironmentData()
                          .sysHomeDir}/conf/iccon/cfg/Common.json';
                      setValue = '$sioNo,19200,n,8,1,n';
                      jsonRet =
                      await setJsonValue(fileTmpP, 'RW', 'Protocol', setValue);
                      if (!jsonRet.result) {
                        TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                            'sio SetJson Err protocol: ${jsonRet.cause.name}',
                            errId: -1);
                        ret = false;
                        db.rollback(txn);
                      }
                    }
                  } else {
                    baud = -1;
                    stopB = -1;
                    dataB = -1;
                    parity = -1;
                  }
                  // port num set & json Update, record Delete
                  if (CompileFlag.CENTOS_G3) {
                    switch (sioNo) {
                      case 0:
                        if (CmCksys.cmTRK05System() != 0 ||
                            CmCksys.cmTRK04System() != 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM1);
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM5);
                        }
                        comPortNo = 1;
                        // ポート番号 = 5 のレコードがいたら不要なので消す
                        delPortNo = 5;
                        // Delete record
                        Map<String, dynamic>? subValues = {
                          "comp": pCom.iniMacInfoCrpNoNo,
                          "stre": pCom.iniMacInfoShopNo,
                          "mac": pCom.iniMacInfoMacNo,
                          "cp_no": delPortNo
                        };
                        await txn.execute(
                            Sql.named(SioDef.SIO_SQL_DEL_REGCNCT_SIO_DATA),
                            parameters: subValues);
                        // record check (Delete)
                        deleteResult = await txn.execute(
                            Sql.named(SioDef.SIO_SQL_CHK_REGCNCT_SIO_DATA),
                            parameters: subValues);
                        if (deleteResult.isNotEmpty) {
                          TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                              '_sio01SetJson(): DB error (DELETE FROM c_regcnct_sio_mst)',
                              errId: -1);
                          ret = false;
                          db.rollback(txn);
                        }
                        break;
                      case 1:
                        if (CmCksys.cmTRK05System() != 0 ||
                            CmCksys.cmTRK04System() != 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM2);
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM6);
                        }
                        comPortNo = 2;
                        break;
                      case 2:
                        if (CmCksys.cmTRK05System() != 0 ||
                            CmCksys.cmTRK04System() != 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM3);
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM7);
                        }
                        comPortNo = 3;
                        break;
                      case 3:
                        if (CmCksys.cmTRK05System() != 0 ||
                            CmCksys.cmTRK04System() != 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM4);
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM8);
                        }
                        comPortNo = 4;
                        break;
                      default:
                        break;
                    }
                  } else {
                    switch (sioNo) {
                      case 0:
                        jsonRet = await jsonFile.setValueWithName(
                            'settings', 'port', SioDef.SIO_COM1);
                        comPortNo = 1;
                        if (CmCksys.cmWebplus2System() == 0) {
                          // ポート番号 = 5 のレコードがいたら不要なので消す
                          delPortNo = 5;
                        } else {
                          // ポート番号 = 3 のレコードがいたら不要なので消す
                          delPortNo = 3;
                        }
                        // Delete record
                        Map<String, dynamic>? subValues = {
                          "comp": pCom.iniMacInfoCrpNoNo,
                          "stre": pCom.iniMacInfoShopNo,
                          "mac": pCom.iniMacInfoMacNo,
                          "cp_no": delPortNo
                        };
                        await txn.execute(Sql.named(SioDef.SIO_SQL_DEL_REGCNCT_SIO_DATA),
                            parameters: subValues);
                        // record check (Delete)
                        deleteResult = await txn.execute(
                            Sql.named(SioDef.SIO_SQL_CHK_REGCNCT_SIO_DATA),
                            parameters: subValues);
                        if (deleteResult.isNotEmpty) {
                          TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                              '_sio01SetJson(): DB error (DELETE FROM c_regcnct_sio_mst)',
                              errId: -1);
                          ret = false;
                          db.rollback(txn);
                        }
                        break;
                      case 1:
                        jsonRet = await jsonFile.setValueWithName(
                            'settings', 'port', SioDef.SIO_COM2);
                        comPortNo = 2;
                        break;
                      case 2:
                        if (CmCksys.cmWebplus2System() == 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM3);
                          comPortNo = 3;
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM4);
                          comPortNo = 4;
                        }
                        break;
                      case 3:
                        if (CmCksys.cmWebplus2System() == 0) {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM4);
                          comPortNo = 4;
                        } else {
                          jsonRet = await jsonFile.setValueWithName(
                              'settings', 'port', SioDef.SIO_COM5);
                          comPortNo = 5;
                        }
                        break;
                      default:
                        break;
                    }
                  }
                  // set drivers** =
                  jsonRet = await sysJson.setValueWithName(
                      bootType, drv, sioCnctTbl[page][tool].section);
                  if (!jsonRet.result) {
                    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                        'sio sys.json set Err: ${jsonRet.cause.name}',
                        errId: -1);
                    ret = false;
                    db.rollback(txn);
                  } else {
                    update = true;
                  }
                  // VEGA3000電子マネー仕様は無効で固定されているため、処理無効化
                  if (await CmCksys.cmMultiVegaRecog() != 0) {
                    if (fName == 'vega3000.json') {
                      fileTmpP = '${EnvironmentData()
                          .sysHomeDir}/conf/multi_tmn/TccUts.json';
                      switch (sioNo) {
                        case 2:
                        case 3:
                          if (CmCksys.cmWebplus2System() == 0) {
                            jsonRet = await setJsonValue(
                                fileTmpP, 'SYSTEM', 'UTPort', "COM${sioNo +
                                1}");
                          } else {
                            jsonRet = await setJsonValue(
                                fileTmpP, 'SYSTEM', 'UTPort', "COM${sioNo +
                                2}");
                          }
                          break;
                        default:
                          jsonRet = await setJsonValue(
                              fileTmpP, 'SYSTEM', 'UTPort', "COM${sioNo + 1}");
                          break;
                      }
                    }
                  }
                  // Update record
                  Map<String, dynamic>? subValues = {
                    "cnct_grp": sioCnctTbl[page][tool].kind,
                    "drv_sec_name": sioCnctTbl[page][tool].section
                  };
                  Result dbSioResult1 = await txn.execute(
                      Sql.named(SioDef.SIO_SQL_CHK_SIO_DATA),
                      parameters: subValues);
                  Map<String,dynamic> data = dbSioResult1.first.toColumnMap();
                  Map<String, dynamic>? updateSubValues = {
                    "cnct_kind": data["cnct_kind"],
                    "cnct_grp": sioCnctTbl[page][tool].kind,
                    "sio_rate": baud,
                    "sio_stop": stopB,
                    "sio_record": dataB,
                    "sio_parity": parity,
                    "qcjc_flg": sioQcjcTyp[0][sioNo],
                    "upd_user": SioDef.LOGIN_STAFF_CD,
                    "comp": pCom.iniMacInfoCrpNoNo,
                    "stre": pCom.iniMacInfoShopNo,
                    "mac": pCom.iniMacInfoMacNo,
                    "cp_no": comPortNo
                  };
                  await txn.execute(
                      Sql.named(SioDef.SIO_SQL_UPD_REGCNCT_SIO_DATA),
                      parameters: updateSubValues);
                  // record check (Update)
                  updateResult = await txn.execute(
                      Sql.named(SioDef.SIO_SQL_CHK_INSUPD_REGCNCT_SIO_DATA),
                      parameters: updateSubValues);
                  if (updateResult.isEmpty) {
                    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                        '_sio01SetJson(): DB error (UPDATE c_regcnct_sio_mst)',
                        errId: -1);
                    ret = false;
                    db.rollback(txn);
                  }
                  Map<String, dynamic>? selectSubValues = {
                    "comp": pCom.iniMacInfoCrpNoNo,
                    "stre": pCom.iniMacInfoShopNo,
                    "mac": pCom.iniMacInfoMacNo,
                    "cp_no": comPortNo
                  };

                  Result dbRegResult = await txn.execute(
                      Sql.named(SioDef.SIO_SQL_CHK_REGCNCT_SIO_DATA),
                      parameters: selectSubValues);
                  Result dbSioResult2 = await txn.execute(
                      Sql.named(SioDef.SIO_SQL_CHK_SIO_DATA),
                      parameters: subValues);
                  if (dbRegResult.isEmpty && dbSioResult2.isNotEmpty) {
                    Map<String,dynamic> data = dbSioResult2.first.toColumnMap();
                    // Insert record
                    Map<String, dynamic>? insertSubValues = {
                      "comp": pCom.iniMacInfoCrpNoNo,
                      "stre": pCom.iniMacInfoShopNo,
                      "mac": pCom.iniMacInfoMacNo,
                      "cp_no": comPortNo,
                      "cnct_kind": data["cnct_kind"],
                      "cnct_grp": sioCnctTbl[page][tool].kind,
                      "sio_rate": baud,
                      "sio_stop": stopB,
                      "sio_record": dataB,
                      "sio_parity": parity,
                      "qcjc_flg": sioQcjcTyp[0][sioNo],
                      "upd_user": SioDef.LOGIN_STAFF_CD,
                    };
                    await txn.execute(
                        Sql.named(SioDef.SIO_SQL_INS_REGCNCT_SIO_DATA),
                        parameters: insertSubValues);
                    // record check (Insert)
                    insertResult = await txn.execute(
                        Sql.named(SioDef.SIO_SQL_CHK_INSUPD_REGCNCT_SIO_DATA),
                        parameters: insertSubValues);
                    if (insertResult.isEmpty) {
                      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
                          '_sio01SetJson(): DB error (INSERT INTO c_regcnct_sio_mst)',
                          errId: -1);
                      ret = false;
                      db.rollback(txn);
                    }
                  }
                  break;
                }
              }
            }
          }
        }
      });
    } catch (e, s) {
      TprLog().logAdd(Tpraid.TPRAID_SYST, LogLevelDefine.error,
          "_sio01SetJson() : $e $s )");
      return false;
    }
    if (update) {
      await sysJson.load();
    }
    SystemFunc.rxMemWrite(null, RxMemIndex.RXMEM_COMMON, pCom, RxMemAttn.MAIN_TASK);

    return ret;
  }

  /// ファイル名から、指定のJsonファイルクラスを設定する
  /// 引数:[fileName] Jsonファイル名
  /// 戻り値: true=正常終了  false=異常終了
  bool _sio01SelectJson(String fileName) {
    switch (fileName) {
      case 'absv31.json':  //（非表示）ABS-V31
        jsonFile = Absv31JsonFile();
        break;
      case 'acb.json':  //釣銭釣札機
        jsonFile = AcbJsonFile();
        break;
      case 'acb20.json':  //ACR-40+RAD-S1 or ACB-20
        jsonFile = Acb20JsonFile();
        break;
      case 'acb50.json':  //釣銭釣札機(ACB-50)
        jsonFile = Acb50JsonFile();
        break;
      case 'acr.json':  //自動釣銭機
        jsonFile = AcrJsonFile();
        break;
      case 'aiv.json':  //音声合成装置(HD AIVoice)
        jsonFile = AivJsonFile();
        break;
      case 'ar_stts_01.json':  //声合成装置(AR-STTS-01)
        jsonFile = Ar_stts_01JsonFile();
        break;
      case 'ccr.json':  //（非表示）CCR
        jsonFile = CcrJsonFile();
        break;
      case 'cct.json':  //CASTLE、（非表示）CCT決済端末
        jsonFile = CctJsonFile();
        break;
      case 'dish.json':  //（非表示）皿勘定(DENSO)
        jsonFile = DishJsonFile();
        break;
      case 'disht.json':  //皿勘定(ﾀｶﾔ)
        jsonFile = DishtJsonFile();
        break;
      case 'fal2.json':  //釣銭釣札機(FAL2)
        jsonFile = Fal2JsonFile();
        break;
      case 'fcl.json':  //（非表示）FCLｼﾘｰｽﾞ
        jsonFile = FclJsonFile();
        break;
      case 'gcat_cnct.json':  //カード決済機
        jsonFile = Gcat_cnctJsonFile();
        break;
      case 'gp.json':  //（非表示）GP-460RC
        jsonFile = GpJsonFile();
        break;
      case 'ht2980.json':  //（非表示）日立ブルーチップ
        jsonFile = Ht2980JsonFile();
        break;
      case 'jmups.json':  //（非表示）J-Mups決済端末
        jsonFile = JmupsJsonFile();
        break;
      case 'jrw_multi.json':  //（非表示）JREM(NCRｼﾘｰｽﾞ)
        jsonFile = Jrw_multiJsonFile();
        break;
      case 'masr.json':  //（非表示）自走式磁気カードリーダー
        jsonFile = MasrJsonFile();
        break;
      case 'mcp200.json':  //（非表示）MCP200
        jsonFile = Mcp200JsonFile();
        break;
      case 'mst.json':  //（非表示）MST決済端末
        jsonFile = MstJsonFile();
        break;
      case 'orc.json':  //沖製ﾘﾗｲﾄｶｰﾄﾞ
        jsonFile = OrcJsonFile();
        break;
      case 'pana.json':  //ﾊﾟﾅｺｰﾄﾞ R/W
        jsonFile = PanaJsonFile();
        break;
      case 'pana_gcat.json':  //ﾊﾟﾅｿﾆｯｸG-CAT
        jsonFile = Pana_gcatJsonFile();
        break;
      case 'pct.json':  //PCT決済端末
        jsonFile = PctJsonFile();
        break;
      case 'psp60.json':  //ｸﾞﾛｰﾘｰPSP-60P
        jsonFile = Psp60JsonFile();
        break;
      case 'psp70.json':  //（非表示）ｸﾞﾛｰﾘｰPSP-70C
        jsonFile = Psp70JsonFile();
        break;
      case 'pw410.json':  //ＰＷ４１０
        jsonFile = Pw410JsonFile();
        break;
      case 'pwrctrl.json':  //無線LAN再起動
        jsonFile = PwrctrlJsonFile();
        break;
      case 'rewrite_card.json':  //ﾘﾗｲﾄｶｰﾄﾞ R/W
        jsonFile = Rewrite_cardJsonFile();
        break;
      case 'rfid.json':  //RFIDﾀｸﾞﾘｰﾀﾞﾗｲﾀ
        jsonFile = RfidJsonFile();
        break;
      case 's2pr.json':  //2ｽﾃｰｼｮﾝﾌﾟﾘﾝﾀ
        jsonFile = S2prJsonFile();
        break;
      case 'scale.json':  //秤
        jsonFile = ScaleJsonFile();
        break;
      case 'scale_sks.json':  //重量センサー
        jsonFile = Scale_sksJsonFile();
        break;
      case 'scan_2800ip_2.json':  //スキャナ2（cnct_kind=42）
        jsonFile = Scan_2800ip_2JsonFile();
        break;
      case 'scan_plus_1.json':  //スキャナ
        jsonFile = Scan_plus_1JsonFile();
        break;
      case 'scan_plus_2.json':  //（未使用）スキャナ2（cnct_kind=41）
        jsonFile = Scan_plus_2JsonFile();
        break;
      case 'sip60.json':  //（非表示）Edy(SIPｼﾘｰｽﾞ)
        jsonFile = Sip60JsonFile();
        break;
      case 'sm_scale1.json':  //ｾﾙﾌｼｽﾃﾑ秤1
        jsonFile = Sm_scale1JsonFile();
        break;
      case 'sm_scale2.json':  //ｾﾙﾌｼｽﾃﾑ秤2
        jsonFile = Sm_scale2JsonFile();
        break;
      case 'sm_scalesc.json':  //ｾﾙﾌｼｽﾃﾑ秤
        jsonFile = Sm_scalescJsonFile();
        break;
      case 'smtplus.json':  //（非表示）Smartplus
        jsonFile = SmtplusJsonFile();
        break;
      case 'stpr.json':  //（非表示）伝票プリンタ(TM-U210B)
        jsonFile = StprJsonFile();
        break;
      case 'suica.json':  //（非表示）Suica
        jsonFile = SuicaJsonFile();
        break;
      case 'vega3000.json':  //VEGA
        jsonFile = Vega3000JsonFile();
        break;
      case 'vismac.json':  //ﾋﾞｽﾏｯｸ
        jsonFile = VismacJsonFile();
        break;
      case 'yamato.json':  //（非表示）ﾔﾏﾄ電子ﾏﾈｰ端末
        jsonFile = YamatoJsonFile();
        break;
      case 'yomoca.json':  //（非表示）Yomoca
        jsonFile = YomocaJsonFile();
        break;
      default:
        return false;
    }

    return true;
  }

  /// デバイステーブルの値をメンテナンスファイルに出力する
  /// 引数:[devTbl] デバイステーブル
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - Sio01_ej_set()
  Future<void> _sio01EjSet(List<SioTokTbl> devTbl) async {
    // EJ-HEAD Write 5 = メンテナンス
    await MmReptlib().headprintEj(5, ReptNumber.MMREPT156.index);

    // EJ Data Write
    String ejBuf = '';
    final ejFp = File('${EnvironmentData().sysHomeDir}/${CmEj.EJ_WORK_DIR}${CmEj.EJ_WORK_FILE}');
    for (int i = 0; i < 4; i++) {
      // Pause line
      ejBuf = ''.padLeft( CmEj.EJ_LINE_SIZE,'-');
      EjLib().cmEjWriteString(ejFp, writePosi.EJ_LEFT.index, ejBuf);
      // SIO #
      ejBuf = 'SIO #${i+1}';
      EjLib().cmEjWriteString(ejFp, writePosi.EJ_CENTER.index, ejBuf);
      // 接続機器
      EjLib().cmEjWriteStringLr(ejFp, SioDef.DEVICENAME, devTbl[i].device);
      if (devTbl[i].device == SioDef.NOT_USE) {
        // 使用せず
        continue;
      } else if (devTbl[i].device != SioDef.PWRCTRL) {
        // 無線LAN再起動
        EjLib().cmEjWriteStringLr(ejFp, SioDef.BAUD, "*****");
        EjLib().cmEjWriteStringLr(ejFp, SioDef.STOPB, "*****");
        EjLib().cmEjWriteStringLr(ejFp, SioDef.DATAB, "*****");
        EjLib().cmEjWriteStringLr(ejFp, SioDef.PARI, "*****");
      } else {
        EjLib().cmEjWriteStringLr(ejFp, SioDef.BAUD, devTbl[i].baud.toString());
        EjLib().cmEjWriteStringLr(ejFp, SioDef.STOPB, devTbl[i].stopB.toString());
        EjLib().cmEjWriteStringLr(ejFp, SioDef.DATAB, devTbl[i].dataB.toString());
        switch (devTbl[i].parity) {
          case 0:
            EjLib().cmEjWriteStringLr(ejFp, SioDef.PARI, SioDef.NONE);
            break;
          case 1:
            EjLib().cmEjWriteStringLr(ejFp, SioDef.PARI, SioDef.ODD);
            break;
          case 2:
            EjLib().cmEjWriteStringLr(ejFp, SioDef.PARI, SioDef.EVEN);
            break;
          default:
            break;
        }
      }
    }
    ejBuf = ''.padLeft( CmEj.EJ_LINE_SIZE,'-');
    EjLib().cmEjWriteString(ejFp, writePosi.EJ_LEFT.index, ejBuf);
    EjLib().cmEjWriteString(ejFp, writePosi.EJ_LEFT.index, '');

    await EjLib().cmEjOther();

    await MmReptlib.countUp();
  }


  /// ボーレート選択画面_決定ボタン押下時【フロント連携】
  /// 引数:[sioNum] SIO# (0~3)
  /// 引数:[tblNum] 選択項目のNo（sioBaudTbl.num に対応）
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - sio01_baud_clicked()
  void sio01BaudClicked(int sioNum, int tblNum) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01BaudClicked(): ');

    // [フロントエンド] label set
    if (tblNum > SioDef.sioBaudTbl.length - 2) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio01BaudClicked(): error (Table Number Over)', errId: -1);
      int tblEndNum = SioDef.sioBaudTbl.length - 1;
      sioDevTblNew[sioNum].baud = SioDef.sioBaudTbl[tblEndNum].num;
      btnStat[sioNum].baud = '${SioDef.BAUD}\n';
    } else {
      sioDevTblNew[sioNum].baud = SioDef.sioBaudTbl[tblNum].num;
      btnStat[sioNum].baud = '${SioDef.BAUD}\n${SioDef.sioBaudTbl[sioDevTblNew[sioNum].baud].kyword}';
    }
  }

  /// ストップビット選択画面_決定ボタン押下時【フロント連携】
  /// 引数:[sioNum] SIO# (0~3)
  /// 引数:[tblNum] 選択項目のNo（sioStopbTbl.num に対応）
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - sio01_stopb_clicked()
  void sio01StopbitClicked(int sioNum, int tblNum) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01StopbitClicked(): ');

    // [フロントエンド] label set
    if (tblNum > SioDef.sioStopbTbl.length - 2) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio01StopbitClicked(): error (Table Number Over)', errId: -1);
      int tblEndNum = SioDef.sioStopbTbl.length - 1;
      sioDevTblNew[sioNum].stopB = SioDef.sioStopbTbl[tblEndNum].num;
      btnStat[sioNum].stopB = '${SioDef.STOPB}\n';
    } else {
      sioDevTblNew[sioNum].stopB = SioDef.sioStopbTbl[tblNum].num;
      btnStat[sioNum].stopB = '${SioDef.STOPB}\n${SioDef.sioStopbTbl[sioDevTblNew[sioNum].stopB].kyword}';
    }
  }

  /// レコード長選択画面_決定ボタン押下時【フロント連携】
  /// 引数:[sioNum] SIO# (0~3)
  /// 引数:[tblNum] 選択項目のNo（sioDatabTbl.num に対応）
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - sio01_datab_clicked()
  void sio01DatabitClicked(int sioNum, int tblNum) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01DatabitClicked(): ');

    // [フロントエンド] label set
    if (tblNum > SioDef.sioDatabTbl.length - 2) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio01DatabitClicked(): error (Table Number Over)', errId: -1);
      int tblEndNum = SioDef.sioDatabTbl.length - 1;
      sioDevTblNew[sioNum].dataB = SioDef.sioDatabTbl[tblEndNum].num;
      btnStat[sioNum].dataB = '${SioDef.DATAB}\n';
    } else {
      sioDevTblNew[sioNum].dataB = SioDef.sioDatabTbl[tblNum].num;
      btnStat[sioNum].dataB = '${SioDef.DATAB}\n${SioDef.sioDatabTbl[sioDevTblNew[sioNum].dataB].kyword}';
    }
  }

  /// パリティ選択画面_決定ボタン押下時【フロント連携】
  /// 引数:[sioNum] SIO# (0~3)
  /// 引数:[tblNum] 選択項目のNo（sioPariTbl.num に対応）
  /// 戻り値: なし
  /// 関連tprxソース: sio01.c - sio01_parity_clicked()
  void sio01ParityClicked(int sioNum, int tblNum) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.fCall,
        'sio01ParityClicked(): ');

    // [フロントエンド] label set
    if (tblNum > SioDef.sioPariTbl.length - 2) {
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.error,
          'sio01ParityClicked(): error (Table Number Over)', errId: -1);
      int tblEndNum = SioDef.sioPariTbl.length - 1;
      sioDevTblNew[sioNum].parity = SioDef.sioPariTbl[tblEndNum].num;
      btnStat[sioNum].parity = '${SioDef.PARI}\n';
    } else {
      sioDevTblNew[sioNum].parity = SioDef.sioPariTbl[tblNum].num;
      btnStat[sioNum].parity = '${SioDef.PARI}\n${SioDef.sioPariTbl[sioDevTblNew[sioNum].parity].kyword}';
    }
  }

  /// 新旧デバイステーブルの値を比較する【フロント連携】
  /// 引数: なし
  /// 戻り値: true=同じ  false=異なる
  /// 関連tprxソース: sio01.c - Sio01_Cmp_Table()
  bool sio01CompareTable() {
    for (int i = 0; i < SioDef.SIONUM_MAX; i++) {
      if (sioDevTblOld[i].device != sioDevTblNew[i].device) {
        return false;
      } else {
        if (sioDevTblOld[i].device != SioDef.PWRCTRL) {
          if ((sioDevTblOld[i].baud != sioDevTblNew[i].baud) ||
              (sioDevTblOld[i].stopB != sioDevTblNew[i].stopB) ||
              (sioDevTblOld[i].dataB != sioDevTblNew[i].dataB) ||
              (sioDevTblOld[i].parity != sioDevTblNew[i].parity)) {
            return false;
          }
        }
      }
    }

    return true;
  }
}
