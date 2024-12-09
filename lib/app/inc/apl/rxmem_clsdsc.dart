/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

///関連tprxソース:rxmemclsdsc.h - struct RXMEMCLSDSC
class RxMemClsDsc {
  int dsc = 0;               /* class dsc             */
  int pdsc = 0;              /* class %dsc            */
  int prc = 0;               /* class price           */
  int mbrDsc = 0;           /* member class dsc      */
  int mbrPdsc = 0;          /* member class %dsc     */
  int mbrPrc = 0;           /* member price          */
  String mbrClsPlanCd = "";
  int mbrClsTyp = 0;       /* member class dsc type */
  int rcDsc = 0;            /* RC class dsc          */
  int rcPdsc = 0;           /* RC class %dsc         */
  int rcPrc = 0;            /* RC price              */
  String rcClsPlanCd = "";
  int rcClsTyp = 0;        /* RC class dsc type     */
  int staffDsc = 0;         /* staff class dsc       */
  int staffPdsc = 0;        /* staff class %dsc      */
  int staffPrc = 0;         /* staff price           */
  String staffClsPlanCd = "";
  int staffClsTyp = 0;     /* staff class dsc type  */
}