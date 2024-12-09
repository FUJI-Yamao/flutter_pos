/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:sprintf/sprintf.dart';

import '../../../inc/sys/tpr_log.dart';
import '../../../lib/cm_sys/cm_cksys.dart';
import 'sio_def.dart';
import 'sio01.dart';

/// SIO接続機器一覧画面
/// 関連tprxソース:sio02.c
class Sio02 {
  /// To Front Param
  var btnStat = Sio02BtnStat();

  /// Button Label (SIO接続機器名)
  late List<String> sio02BtnLbl;

  /// Title
  String titleLbl = '';

  /// Output Page (単一ページであるため、0固定)
  int currentPage = 0;

  /// SIO設定画面のデータ.
  final Sio01 _baseSetting;

  /// SIO02クラスのインスタンス
  Sio02(this._baseSetting);

  int getBaud(int sioNo) {
    return _baseSetting.sioDevTblNew[sioNo].baud;
  }

  int getStopB(int sioNo) {
    return _baseSetting.sioDevTblNew[sioNo].stopB;
  }

  int getDataB(int sioNo) {
    return _baseSetting.sioDevTblNew[sioNo].dataB;
  }

  int getParity(int sioNo) {
    return _baseSetting.sioDevTblNew[sioNo].parity;
  }

  bool getSlvOutput(int sioNo) {
    return _baseSetting.btnStat[sioNo].slvOutput;
  }

  /// SIO接続機器一覧画面描画時の処理【フロント連携】
  /// （メンテナンスメニューから、SIOボタンを押下した時の処理）
  /// 引数: [title] sio.jsonより取得した当画面のタイトルラベル
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_clicked()
  Future<void> sio02Init(String title) async {
    // get title
    titleLbl = title;

    // get buttons label
    sio02BtnLbl = List.generate(_baseSetting.toolTblLen, (index) => '');
    currentPage = 0;
    await _sio02SetLabel();

    // to front params
    btnStat.toPageOutput = _sio02PagesCheck();
    if (btnStat.toPageOutput) {
      btnStat.titleLbl = '$title 1/${SioDef.PAGE_MAX}';
    } else {
      btnStat.titleLbl = title;
    }
    btnStat.pageLbl = currentPage + 1;

    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        sprintf("st=%x\n", [_baseSetting.sioStatus]));
  }

  /// SIOツールテーブルのラベル（２ページ目以降）が設定されているかチェックする
  /// 引数: なし
  /// 戻り値: true=2ページ以降あり  false=1ページのみ
  /// 関連tprxソース: sio02.c - sio02_page_check(), sio02_label_check()
  bool _sio02PagesCheck() {
    for (int page = 1; page < SioDef.PAGE_MAX; page++) {
      for (int tool = 0; tool < _baseSetting.toolTblLen; tool++) {
        if (_baseSetting.sioCnctTbl[page][tool].label != SioDef.NONE_CH) {
          return true;
        }
      }
    }
    return false;
  }

  /// 決定ボタン押下時【フロント連携】
  /// 引数:[num] SIO接続機器 (選択した項目No)
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_bt_clicked()
  void sio02BtClicked(int num) {
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        'sio02BtClicked(): sio02BtnLbl[$num] = ${sio02BtnLbl[num]}');

    _sio02SetDevTable(sio02BtnLbl[num]);
    _baseSetting.sioStatus = 0;
    _baseSetting.sio01SetLabel(_baseSetting.sioDevTblNew);
  }

  /// 押下したボタンに相当するSIOデバイステーブルの値を更新、または初期化する
  /// 引数:[btnLbl] SIO接続機器一覧画面のボタンラベル
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_select_label(), Sio02_Set_Table()
  void _sio02SetDevTable(String btnLbl) {
    TprLog().logAdd(
        SioDef.SIOLOG, LogLevelDefine.normal, '_sio02SetDevTable(): called');

    // 接続機器：NOT_USE（使用せず） ?
    int toolNum = 0;
    bool toolFlg = false;
    if (btnLbl != SioDef.NOT_USE) {
      for (int i = 0; i < _baseSetting.toolTblLen; i++) {
        if ((btnLbl == _baseSetting.sioCnctTbl[currentPage][i].label) &&
            (btnLbl.isNotEmpty)) {
          toolNum = i;
          toolFlg = true;
          break;
        }
      }
    }

    // sio button number
    int sioNo = _baseSetting.sioStatus;

    _baseSetting.sioDevTblNew[sioNo].device = btnLbl;
    TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
        '_sio02SetDevTable():selected device = [$btnLbl]');

    if (toolFlg) {
      _baseSetting.sioDevTblNew[sioNo].baud =
          _baseSetting.sioCnctTbl[currentPage][toolNum].baud;
      _baseSetting.sioDevTblNew[sioNo].stopB =
          _baseSetting.sioCnctTbl[currentPage][toolNum].stopB;
      _baseSetting.sioDevTblNew[sioNo].dataB =
          _baseSetting.sioCnctTbl[currentPage][toolNum].dataB;
      _baseSetting.sioDevTblNew[sioNo].parity =
          _baseSetting.sioCnctTbl[currentPage][toolNum].parity;
      _baseSetting.btnStat[sioNo].slvOutput = true;
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): selected button = ${toolNum + 2} / page = ${currentPage + 1}');
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): baud = ${_baseSetting.sioDevTblNew[sioNo].baud}');
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): stopb = ${_baseSetting.sioDevTblNew[sioNo].stopB}');
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): datab = ${_baseSetting.sioDevTblNew[sioNo].dataB}');
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): parity = ${_baseSetting.sioDevTblNew[sioNo].parity}');
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetTable(): to Port = ${sioNo + 1}');
    } else {
      // 接続機器：NOT_USE（使用せず）
      _baseSetting.sioDevTblNew[sioNo].baud = -1;
      _baseSetting.sioDevTblNew[sioNo].stopB = -1;
      _baseSetting.sioDevTblNew[sioNo].dataB = -1;
      _baseSetting.sioDevTblNew[sioNo].parity = -1;
      _baseSetting.btnStat[sioNo].slvOutput = false;
      TprLog().logAdd(SioDef.SIOLOG, LogLevelDefine.normal,
          '_sio02SetDevTable():clear (baud,stopb,datab,parity)');
    }
  }

  /// 次頁ボタン押下時（複数ページ設定時）【フロント連携】
  /// 引数: なし
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_next_clicked()
  Future<void> sio02NextClicked() async {
    if (currentPage + 1 >= SioDef.PAGE_MAX) {
      currentPage = 0;
    } else {
      currentPage++;
    }
    btnStat.pageLbl = currentPage + 1;
    btnStat.titleLbl = '$titleLbl ${btnStat.pageLbl}/${SioDef.PAGE_MAX}';
    await _sio02SetLabel();
  }

  /// 前頁ボタン押下時（複数ページ設定時）【フロント連携】
  /// 引数: なし
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_prev_clicked()
  Future<void> sio02PrevClicked() async {
    if (currentPage - 1 < 0) {
      currentPage = SioDef.PAGE_MAX - 1;
    } else {
      currentPage--;
    }
    btnStat.pageLbl = currentPage + 1;
    btnStat.titleLbl = '$titleLbl ${btnStat.pageLbl}/${SioDef.PAGE_MAX}';
    await _sio02SetLabel();
  }

  /// SIO接続機器一覧画面のボタンラベルをセットする
  /// 引数: なし
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_make_label(), sio02_label_draw()
  Future<void> _sio02SetLabel() async {
    for (int i = 0; i < _baseSetting.toolTblLen; i++) {
      sio02BtnLbl[i] = _baseSetting.sioCnctTbl[currentPage][i].label;
    }

    String sio1 = _baseSetting.sioDevTblNew[0].device;
    String sio2 = _baseSetting.sioDevTblNew[1].device;
    String sio3 = _baseSetting.sioDevTblNew[2].device;
    String sio4 = _baseSetting.sioDevTblNew[3].device;

    await _hideLabelCheck(sio1);
    await _hideLabelCheck(sio2);
    await _hideLabelCheck(sio3);
    await _hideLabelCheck(sio4);

    btnStat.btnLbl = sio02BtnLbl;
  }

  /// SIOツールテーブルの機器グループ・ドライバセクションより、ボタンラベルを空にする
  /// 引数:[inDev] SIOデバイステーブル_デバイス名（SIO No別）
  /// 戻り値: なし
  /// 関連tprxソース: sio02.c - sio02_label_set()
  Future<void> _hideLabelCheck(String inDev) async {
    // press NOT_USE?
    if (inDev == SioDef.NOT_USE) {
      return;
    }

    int page = 0;
    int i = 0;
    int kind = 0;

    // search kind
    for (page = 0; page < SioDef.PAGE_MAX; page++) {
      for (i = 0; i < _baseSetting.toolTblLen; i++) {
        if (inDev == _baseSetting.sioCnctTbl[page][i].label) {
          kind = _baseSetting.sioCnctTbl[page][i].kind;
          break;
        }
      }
      if (kind != 0) {
        break;
      }
    }

    bool hideFlg = true;
    if ((page < SioDef.PAGE_MAX) && (i < _baseSetting.toolTblLen)) {
      // same kind hide
      if (await CmCksys.cmCatJmupsTwinConnection() != 0) {
        for (int j = 0; j < _baseSetting.toolTblLen; j++) {
          if (kind == _baseSetting.sioCnctTbl[currentPage][j].kind) {
            hideFlg = true;
            if (((_baseSetting.sioCnctTbl[currentPage][i].section ==
                        SioDef.SIO_SEC_PANA) &&
                    (_baseSetting.sioCnctTbl[currentPage][j].section ==
                        SioDef.SIO_SEC_PSP60)) ||
                ((_baseSetting.sioCnctTbl[currentPage][i].section ==
                        SioDef.SIO_SEC_PSP60) &&
                    (_baseSetting.sioCnctTbl[currentPage][j].section ==
                        SioDef.SIO_SEC_PANA))) {
              hideFlg = false;
            } else {
              if (_baseSetting.sioCnctTbl[1][i].section ==
                  SioDef.SIO_SEC_JMUPS) {
                if ((_baseSetting.sioCnctTbl[0][j].section ==
                        SioDef.SIO_SEC_GCAT) ||
                    (_baseSetting.sioCnctTbl[0][j].section == 'gcat_cnct') ||
                    (_baseSetting.sioCnctTbl[1][j].section == 'smtplus') ||
                    (_baseSetting.sioCnctTbl[1][j].section ==
                        SioDef.SIO_SEC_CCT)) {
                  hideFlg = false;
                } else if ((_baseSetting.sioCnctTbl[0][i].section ==
                        SioDef.SIO_SEC_GCAT) ||
                    (_baseSetting.sioCnctTbl[0][i].section == 'gcat_cnct') ||
                    (_baseSetting.sioCnctTbl[1][i].section == 'smtplus') ||
                    (_baseSetting.sioCnctTbl[1][i].section ==
                        SioDef.SIO_SEC_CCT)) {
                  if (_baseSetting.sioCnctTbl[1][j].section ==
                      SioDef.SIO_SEC_JMUPS) {
                    hideFlg = false;
                  }
                }
              }
            }
            if (hideFlg) {
              sio02BtnLbl[j] = SioDef.NONE_CH;
            }
          }
        }
      } else {
        for (int j = 0; j < _baseSetting.toolTblLen; j++) {
          if (kind == _baseSetting.sioCnctTbl[currentPage][j].kind) {
            if (((_baseSetting.sioCnctTbl[currentPage][i].section ==
                        SioDef.SIO_SEC_PANA) &&
                    (_baseSetting.sioCnctTbl[currentPage][j].section ==
                        SioDef.SIO_SEC_PSP60)) ||
                ((_baseSetting.sioCnctTbl[currentPage][i].section ==
                        SioDef.SIO_SEC_PSP60) &&
                    (_baseSetting.sioCnctTbl[currentPage][j].section ==
                        SioDef.SIO_SEC_PANA))) {
              sio02BtnLbl[j] = SioDef.NONE_CH;
            }
          }
        }
      }
      if (_baseSetting.sioCnctTbl[currentPage][i].section ==
          SioDef.SIO_SEC_SC) {
        for (int j = 0; j < _baseSetting.toolTblLen; j++) {
          if ((_baseSetting.sioCnctTbl[currentPage][j].section ==
                  SioDef.SIO_SEC_SM1) ||
              (_baseSetting.sioCnctTbl[currentPage][j].section ==
                  SioDef.SIO_SEC_SM2)) {
            sio02BtnLbl[j] = SioDef.NONE_CH;
          }
        }
      }
      if ((_baseSetting.sioCnctTbl[currentPage][i].section ==
              SioDef.SIO_SEC_SM1) ||
          (_baseSetting.sioCnctTbl[currentPage][i].section ==
              SioDef.SIO_SEC_SM2)) {
        for (int j = 0; j < _baseSetting.toolTblLen; j++) {
          if (_baseSetting.sioCnctTbl[currentPage][j].section ==
              SioDef.SIO_SEC_SC) {
            sio02BtnLbl[j] = SioDef.NONE_CH;
          }
        }
      }
    }
  }
}
