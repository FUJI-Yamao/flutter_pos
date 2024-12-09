/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pos/app/fb/fb_lib.dart';
import 'package:flutter_pos/app/inc/apl/compflag.dart';
import 'package:flutter_pos/app/inc/apl/rxmem_define.dart';

import '../common/cmn_sysfunc.dart';
import '../inc/sys/tpr_log.dart';
import '../lib/apllib/cmd_func.dart';


/// 関連tprxソース:fb_machin.c
class FbMachin {

  static List<FbTimer> fbTimer = List<FbTimer>.generate(FbLibDef.TIMER_MAX, (index) => FbTimer());
  static bool  timerActive = false;

  static int anotherToMypid = 0;
  static int fbEventNowRoopFlg = 0;
  static int fbEventRoopFlg = 0;
  static int lockPidFlg = 0;
  static int fbSubinit = 0;

  static const int FALSE = 0;
  static const int TRUE = 1;

/*----------------------------------------------------------------------*
 * Event Program
 *----------------------------------------------------------------------*/
  static int posted = 0;
  static	int	sys_fd = -1;

//   extern
//   int Input_Add(int fd, int condition, void *func, void *data)
//   {
//   #ifdef NODSP
//   return 0;
//   #else
//   if(sys_fd != -1) {
//   printf("system file descripter is already exist !!\n");
//   return -1;
//   }
//   sys_fd = fd;
//
//   memset(&fbInput, 0x0, sizeof(FB_Input));
//   fbInput.condition = condition;
//   fbInput.func = func;
//   fbInput.data = data;
//   return 0;
//   #endif
//   }
//
//   #if 0
//   extern
//   void keyboard_Close(void)
//   {
//   if(keyboard_fd < 0)
//   return;
//   ioctl(keyboard_fd, KDSETMODE, KD_TEXT);
//   ioctl(keyboard_fd, KDSKBMODE, okbd_mode);
//   tcsetattr(keyboard_fd, TCSANOW, &ots);
//   okbd_mode = -1;
//   if(saved_vt > 0) {
//   ioctl(keyboard_fd, VT_ACTIVATE, saved_vt);
//   }
//   if(keyboard_fd > 0)
//   close(keyboard_fd);
//   keyboard_fd = -1;
//   }
//
//   static int keyboard_getfd(const char * const nm)
//   {
//   int	fd;
//   if(nm) {
//   fd = open(nm, O_RDWR, 0);
//   if(fd >= 0) {
//   printf("%s open\n", nm);
//   }
//   }
//   else {
//   fd = open("/dev/tty4", O_RDWR, 0);
//   if(fd >= 0) {
//   printf("tty4 open\n");
//   return fd;
//   }
//   fd = open("/dev/tty", O_RDWR, 0);
//   if(fd >= 0) {
//   printf("tty open\n");
//   return fd;
//   }
//   fd = open("/dev/tty0", O_RDWR, 0);
//   if(fd >= 0) {
//   printf("tty0 open\n");
//   return fd;
//   }
//   fd = open("/dev/console", O_RDWR, 0);
//   if(fd >= 0) {
//   printf("console open\n");
//   return fd;
//   }
//   }
//   return fd;
//   }
//
//   extern
//   int keyboard_Open(void)
//   {
// //	int		dummy;
//   struct vt_stat	vtstate;
//
//   keyboard_fd = keyboard_getfd(NULL);
//   if(keyboard_fd < 0) {
//   printf("not open keyboard !!\n");
//   TprLibLogWrite(0, 0, 0, "not open keyboard");
//   return -1;
//   }
//   #if 0
//   if(ioctl(keyboard_fd, KDGKBMODE, &dummy) < 0) {
//   printf("ioctl error keyboard !!\n");
//   close(keyboard_fd);
//   keyboard_fd = -1;
//   return -1;
//   }
//   #endif
//   if(current_vt > 0) {
//   if(ioctl(keyboard_fd, VT_GETSTATE, &vtstate) == 0)
//   saved_vt = vtstate.v_active;
//   if(ioctl(keyboard_fd, VT_ACTIVATE, current_vt) == 0)
//   ioctl(keyboard_fd, VT_WAITACTIVE, current_vt);
//   }
//   if(tcgetattr(keyboard_fd, &ts) < 0) {
//   printf("tcgetattr error keyboard !!\n");
//   if(keyboard_fd > 0)
//   close(keyboard_fd);
//   keyboard_fd = -1;
//   return -1;
//   }
//   if( ioctl(keyboard_fd, KDGKBMODE, &okbd_mode) < 0) {
//   printf("ioctl KDGKBM error keyboard !!\n");
//   if(keyboard_fd > 0)
//   close(keyboard_fd);
//   keyboard_fd = -1;
//   return -1;
//   }
//
//   ots = ts;
//   ts.c_lflag &= ~(ICANON | ECHO | ISIG);
//   ts.c_iflag &= ~(ISTRIP | IGNCR | ICRNL | INLCR | IXOFF | IXON);
//   ts.c_cc[VMIN] = 0;
//   ts.c_cc[VTIME] = 0;
//
//   if(tcsetattr(keyboard_fd, TCSAFLUSH, &ts) < 0) {
//   printf("tcsetattr error keyboard !!\n");
//   keyboard_Close();
//   return -1;
//   }
//   if(ioctl(keyboard_fd, KDSKBMODE, K_MEDIUMRAW) < 0) {
//   printf("ioctl KDSKBM error keyboard !!\n");
//   keyboard_Close();
//   return -1;
//   }
//   if(ioctl(keyboard_fd, KDSETMODE, KD_GRAPHICS) < 0) {
//   printf("ioctl KDSETM error keyboard !!\n");
//   keyboard_Close();
//   return -1;
//   }
//   return keyboard_fd;
//   }
//
//   static	char	keyboard_ctrl = 0;
//   static	char	keyboard_alt = 0;
//   static	char	keyboard_f = 0;
//
//   static void keyboard_event(void)
//   {
//   Uchar	keybuf[BUFSIZ];
//   int	i, nread;
//   int	scancode;
//   struct	tms	tp;
//
//   memset(keybuf, 0x0, sizeof(keybuf));
//
//   nread = read(keyboard_fd, keybuf, BUFSIZ);
//   for(i = 0; i < nread; ++i) {
//   scancode = keybuf[i] & 0x7F;
//   if(keybuf[i] & 0x80) {
//   printf("key release [%x][%d]\n", keybuf[i], scancode);
//   if(scancode == 0x1d)
//   keyboard_ctrl = 0;
//   else if(scancode == 0x38)
//   keyboard_alt = 0;
//   else if((scancode == 0x3b) ||
//   (scancode == 0x3c) ||
//   (scancode == 0x3d) ||
//   (scancode == 0x3e) )
//   keyboard_f = 0;
//   continue;
//   }
//   else {
//   printf("key press [%x][%d]\n", keybuf[i], scancode);
//   events.type = FB_KEYDOWN;
//   events.code = scancode;
//   if(scancode == 0x1d)
//   keyboard_ctrl = 1;
//   else if(scancode == 0x38)
//   keyboard_alt = 1;
//   else if(scancode == 0x3b)
//   keyboard_f = 1;
//   else if(scancode == 0x3c)
//   keyboard_f = 2;
//   else if(scancode == 0x3d)
//   keyboard_f = 3;
//   else {
//   keyboard_ctrl = 0;
//   keyboard_alt = 0;
//   keyboard_f = 0;
//   }
//   if((keyboard_ctrl == 1) &&
//   (keyboard_alt == 1) &&
//   (keyboard_f >= 1) ) {
//   keyboard_Close();
//   fb_kb_stop = times(&tp);
//   keyboard_ctrl = 0;
//   keyboard_alt = 0;
//   keyboard_f = 0;
//   }
// //			posted = 0;
//   break;
//   }
//   }
//   }
//   #endif

  // TODO:実装中（ただし未使用）
  /// 関連tprxソース:fb_machin.c - Timeout_Init
  static void timeoutInit() {
    fbTimer = List<FbTimer>.generate(FbLibDef.TIMER_MAX, (index) => FbTimer());

    // #ifdef FB_MEMO
    // FBMemo_Init();
    // #endif

    Timer.periodic(Duration(milliseconds: 1), (timer) => {_onTimer(timer)});
  }


  /// 関連tprxソース:fb_machin.c - Timeout_Remove
  static void timeoutRemove(int tag) {
    if ((tag >= 1) && (tag <= FbLibDef.TIMER_MAX)) {
      //String name = fbTimer[tag - 1].func.toString();
      fbTimer[tag - 1].timer = 0;
      fbTimer[tag - 1].func = null;
      fbTimer[tag - 1].data = null;
      fbTimer[tag - 1].flag = TimerControl.FB_TIME_STOP;
      fbTimer[tag - 1].first = 0;
      fbTimer[tag - 1].ct1 = null;
      //debugPrint("timeoutRemove  fbTimer[${tag - 1}].first:${fbTimer[tag - 1].first} function:${name}");
    } else {
      if ((tag != -1) && (tag != 0)) {
        debugPrint("Timeout_Remove ERROR!![${tag}]");
      }
    }
    return;
  }

  /// 関連tprxソース:fb_machin.c - Timeout_Add
  static int timeoutAdd(int timer, Function func, Object data) {
    int tag = -1;

    // TODO:既存ではタイマーを使っていないので初期化もやっていない。暫定で初回動作時にタイマーを起動させる。
    // TODO:最終的な実装方法は別途検討する。
    if (timerActive == false) {
      Timer.periodic(Duration(milliseconds: 1), (timer) => {_onTimer(timer)});
      timerActive = true;
    }
    for (int i = 0; i < FbLibDef.TIMER_MAX; i++) {
      if(fbTimer[i].timer == 0) {
        tag = i;
        fbTimer[i].func = func;
        fbTimer[i].data = data;
        fbTimer[i].flag = TimerControl.FB_TIME_START;
        fbTimer[i].first = 1;
        fbTimer[i].ct1  = DateTime.now();
        fbTimer[i].timer = (timer > 0) ? timer : 1;
        //debugPrint("timeoutAdd  fbTimer[${tag}].first:${fbTimer[tag].first} function:" + func.toString());
        break;
      }
    }
    if (tag == -1) {
      debugPrint("Timeout_Add ERROR!!");
    }
    return (tag + 1);
  }

  /// 関連tprxソース:fb_machin.c - Timeout_Remove_All
  static void timeoutRemoveAll() {
    for (int i = 1; i <= FbLibDef.TIMER_MAX; i++) {
      if(fbTimer[i - 1].timer > 0) {
        String erlog = "TimeoutRemoveAll[${pid}][${i-1}][${fbTimer[i-1].timer}][${fbTimer[i-1].func}]";
        TprLog().logAdd(0, LogLevelDefine.warning, erlog);
      }
      timeoutRemove(i);
    }
  }

  // TODO:実装中(672～771行目のみ実装）さらに関係無さそうところはコメントアウトする。
  /// 関連tprxソース:fb_machin.c - event_roop() のうち
  /// do-whileループ内の処理、かつQuickPayに関する処理のみ切り出す。
  static Future<void> _onTimer(Timer timer) async {
    DateTime ct2;// = DateTime.now();
    int tim_ret = 0;
    CmdFunc cmdFunc = CmdFunc();
    FbMem fbMem = SystemFunc.readFbMem(null);
    int showEventCheck = 0;

    //fd_set	fdset;
    int	max_fd;
    String buf = "";  //[10];
    String posi = ""; //[5];
//	Widget_Parts	*sub;
    int show_event_check = 0;
    String log = "";   // [128];
    int ret = 0, testflg = 0, counter = 0, counter2 = 0, counter3 = 0;
    int continue_chk = 0;
    int recog_chk1 = 0, recog_chk2 = 0;
//	RX_TASKSTAT_BUF *TS_BUF;
    int flg = 0;
    RxMemRet xRet = SystemFunc.rxMemRead(RxMemIndex.RXMEM_COMMON);

    if((fbMem.now_pid == cmdFunc.getPid()) && (anotherToMypid == 1) && (fbSubinit == 2)) {
      anotherToMypid = 0;
      ct2 = DateTime.now();
      if(fbMem.kbd_stop == 2) {
        fbMem.kbd_stop = 0;
      }
      // fb_painted_event = 1;
      // fb_sub_painted_event = 1;
      // fb_opt_painted_event = 1;
      // Parts_Show_Event(1);
    } else {
      ct2 = DateTime.now();
      if(fbMem.kbd_stop == 2) {
        fbMem.kbd_stop = 0;
        // fb_painted_event = 1;
        // fb_sub_painted_event = 1;
        // fb_opt_painted_event = 1;
        // Parts_Show_Event(1);
      }
      if ((lockPidFlg != 0) && (fbMem.lock_pid == 0)) {
        lockPidFlg = 0;
        // fb_painted_event = 1;
        // fb_sub_painted_event = 1;
        // fb_opt_painted_event = 1;
        // Parts_Show_Event(1);
      }
      if ((fbMem.now_pid == cmdFunc.getPid()) &&
         ((fbMem.lock_pid != cmdFunc.getPid()) && (fbMem.lock_pid != 0))) {
        lockPidFlg = 1;
      }
    }

    showEventCheck = 0;
    for (int i = 0; i < FbLibDef.TIMER_MAX; i++) {
      if (fbTimer[i].timer > 0) {
        switch (fbTimer[i].flag) {
          case TimerControl.FB_TIME_START:

            //debugPrint(ct2.difference(fbTimer[i].ct1!).inMilliseconds.toString() + " >= " + fbTimer[i].timer.toString());
            if (ct2.difference(fbTimer[i].ct1!).inMilliseconds >= fbTimer[i].timer) {
              fbTimer[i].ct1 = ct2;
              if (fbTimer[i].func != null) {
                fbTimer[i].first = 0;
                if (fbTimer[i].data == 0) {
                  var tim_ret0 = await fbTimer[i].func!();
                  if (tim_ret0 != null) {
                    tim_ret = tim_ret0;
                  }
                } else {
                  tim_ret = await fbTimer[i].func!(fbTimer[i].data);
                }
                if ((tim_ret == FALSE) && (fbTimer[i].first == 0)) {
                  //debugPrint("timeoutRemove実行");
                  timeoutRemove(i + 1);
                }
                showEventCheck = 1;
              }
            }
            break;
          default:
            break;
        }
      }
      if (fbEventNowRoopFlg > fbEventRoopFlg) {
        if (showEventCheck != 0) {
          //Parts_Show_Event(0);
        }
        fbEventNowRoopFlg--;
        return;
      }
    }
    if (((fbMem.now_pid != cmdFunc.getPid()) && (fbSubinit == 2)) ||
       ((fbMem.sub_now_pid != cmdFunc.getPid()) && (fbSubinit == 12))) {
      return;
    }

    if (showEventCheck != 0) {
      if (continue_chk == 2) {
        //Parts_Show_Event(3);
      } else {
        //Parts_Show_Event(0);
      }
    }
  }
}

