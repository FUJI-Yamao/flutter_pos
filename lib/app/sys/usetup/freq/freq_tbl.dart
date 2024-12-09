/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'package:flutter_pos/app/sys/usetup/freq/freq.dart';

/// 関連tprxソース: freq_tbl.h - t_data_tbl
class TDataTbl{
  String tableName = "";	/* table name */
  String eName = "";	/* parameter for execute DB library */
  int	result = 0;		/* result */
  String status = "";	/* status縲*/
  bool	selFlg = false;	/* flag for selected/unselected */
  int	setTblTyp = 0;
  int	freqOpeMode = 0;
  int	offlineChkFlg = 0;
  String	seqName = "";
  int	freqCsrvCnctSkip = 0;
  int	freqCsrcCustRealSkip = 0;
  String	freqCsrvCnctKey = "";
  int	freqCsrvDelOthStre = 0;
  int	svrDiv = 0;
  String	defaultFileName = "";
  int	execFlg = 0;
}
typedef tblData = TDataTbl;

/// 関連tprxソース: freq_tbl.h - bt_data_tbl
class BtDataTbl{
  int no = 0;             	/* item number */
  bool aFlg = false;          	/* active flag, false:unactive, true:active */
  int	totalTbl = 0;		/* total table */
  String labelName = "";	/* label name */
/*  	char		item_name[MAXCHAR];*/	/* item name */
  String mmDefault = "";	/* default data path name */
  var	data = List<tblData>.generate(Freq.mItemNum, (index) => tblData()); /* text data struct */
}
typedef btData = BtDataTbl;

/// 関連tprxソース: freq_tbl.h - LIST_DATA
class ListData{
  int	pageNo = 0;
  String tblName = "";
}

/// 関連tprxソース: freq_tbl.h - ERR_RESTLIST_DSP
class ErrRestlistDsp{
  // GtkWidget	*BKWindow;
  // GtkWidget	*Window;
  // GtkWidget	*Title;
  // GtkWidget	*ItemLabel[PAGE_ITEM_MAX];
  ListData dspData = ListData();
  int nowPage = 0;
  int pageMax = 0;
  int	ttlCnt = 0;
  String titleStr = "";
}

