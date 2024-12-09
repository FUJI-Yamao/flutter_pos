/*
 * (C)2024 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

class CmMul {
  /// 関連tprxソース: cm_mul.c - cm_l_mul
  static List<int> cmLMul(int l1, int l2) {
    List<int> uLdata = [2, 0];
    List<int> ret = [0, 0];

    int uL1 = l1.abs();
    int uL2 = l2.abs();

    uLdata[0] = ((uL1>>16)&0xffff) * ((uL2>>16)&0xffff);
    uLdata[1] = (uL1&0xffff) * (uL2&0xffff);

    int ulwk1 = ((uL1>>16)&0xffff) * (uL2&0xffff);
    int ulwk2 = (uL1&0xffff) * ((uL2>>16)&0xffff);
    int ulwk3 = ((uLdata[1]>>16)&0xffff) + (ulwk1&0xffff) + (ulwk2&0xffff);

    uLdata[1] = (ulwk3<<16) + (uLdata[1]&0xffff);
    uLdata[0] = uLdata[0]
        + ((ulwk1>>16)&0xffff)
        + ((ulwk2>>16)&0xffff)
        + ((ulwk3>>16)&0xffff);

    if ((0 > l1) ^ (0 > l2)) {
      if (uLdata[0] == 0) {
        ret[0] = 0xffffffff;
      } else {
        ret[0] = (0 - (uLdata[0] + 1));
      }
      ret[1] = (0 - uLdata[1]);
    } else {
      ret[1] = uLdata[1];
      ret[0] = uLdata[0];
    }
    return ret;
  }
}