/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class CmDiv {
  /// 関連tprxソース: cm_divl.c - cm_l_div
  static List<int> cmLDiv(List<int> lData, int l1) {
    List<int> ret = lData;
    List<int> ulData = [];

    if (0 > lData[0]) {
      if (lData[0] == 0xffffffff) {
        ulData[0] = 0;
      } else {
        ulData[0] = (0 - (lData[0] + 1));
        ulData[1] = (0 - lData[1]);
      }
    } else {
      ulData[0] = lData[0];
      ulData[1] = lData[1];
    }
    if ((ulData[0] | ulData[1]) == 0) {
      return ret;
    }

    int uL1 = l1.abs();
    if (uL1 == 0) {
      ret[0] = lData[1] = 0;
      return ret;
    }
    if ((ulData[0] == 0) && (ulData[1] < uL1)) {
      return ret;
    }

    int i,j;
    int ulwk1 = uL1;
    for (i=16; i>0; i--) {
      if ((ulData[0] & 0xf0000000) != 0) {
        break;
      }
      ulData[0] = (ulData[0]<<4) | ((ulData[1]>>28) & 0x0f);
      ulData[1] = ulData[1] << 4;
    }
    for (j=8; j>0; j--) {
      if ((ulwk1 & 0xf0000000) != 0) {
        break;
      }
      ulwk1 = ulwk1 << 4;
    }

    int ulwk = 0;
    while (ulData[0] >= ulwk1) {
      ulwk++;
      ulData[0] -= ulwk1;
    }
    ulwk1 = (ulwk1>>4) & 0x0fffffff;
    for (i=i-j; i>0; i--) {
      ulwk = ulwk << 4;
      while (ulData[0] >= ulwk1) {
        ulwk++;
        ulData[0] -= ulwk1;
      }
      if (i > 1) {
        ulData[0] = (ulData[0]<<4) | ((ulData[1]>>28) & 0x0f);
        ulData[1] = ulData[1] << 4;
      } else {
        j++;
      }
    }
    ulData[1] = ulData[0];
    ulData[0] = ulwk;
    for (; j < 8; j++) {
      ulData[1] = (ulData[1] >> 4) & 0x0fffffff;
    }

    if ((0 > lData[0]) ^ (0 > l1)) {
      if (ulData[0] == 0) {
        ret[0] = 0xffffffff;
      } else {
        ret[0] = (0 - ulData[0]);
      }
    } else {
      ret[0] = ulData[0];
    }
    ret[1] = ulData[1];

    return ret;
  }
}