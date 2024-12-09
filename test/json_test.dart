/*
 * (C)2023 TERAOKA SEIKO Co., Ltd./株式会社寺岡精工
 * CONFIDENTIAL/社外秘
 * 無断開示・無断複製禁止
 */
 
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../lib/app/common/cls_conf/counterJsonFile.dart';
import '../lib/app/common/cls_conf/mac_infoJsonFile.dart';
import '../lib/app/common/cls_conf/recogkey_dataJsonFile.dart';
import '../lib/app/common/cls_conf/tprtim_counterJsonFile.dart';
import '../lib/app/common/cls_conf/sysJsonFile.dart';

late Tprtim_counterJsonFile tprtim_counter;
late CounterJsonFile counter;
late Recogkey_dataJsonFile recogkey_data;
late Mac_infoJsonFile mac_info;
late SysJsonFile sys;

void main() {
  String os = Platform.operatingSystem;

  tprtim_counter = Tprtim_counterJsonFile();
  counter = CounterJsonFile();
  recogkey_data = Recogkey_dataJsonFile();
  mac_info = Mac_infoJsonFile();
  sys = SysJsonFile();

  if (os == "linux") {
    runApp(const Center(
      child: Text(
        "Hello, Linux world",
        textDirection: TextDirection.ltr,
      ),
    ));
  } else {
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
//            child: Counter_tprtim_counter(),
//            child: Counter_counter(),
//            child: Counter_recogkey_data(),
//            child: Counter_mac_info(),
          child: Counter_sys(),
        ),
      ),
    ));
  }
}

class Counter_sys extends StatefulWidget {
  const Counter_sys({super.key});
  @override
  State<Counter_sys> createState() => _CounterStateCounter_Counter_sys();
}

class _CounterStateCounter_Counter_sys extends State<Counter_sys> {
  String comment = "";
  String version = "";
  String temp1 = "";
  String entry = "";
  int priority = 0;
  String inifile = "";
  String temp2 = "";

  void _load() {
    setState(() {
      sys.load();
    });
  }

  void _set() {
    setState(() {
      comment = sys.info.comment;
      version = sys.info.version;
      temp1 = "";
      entry = sys.scalerm.entry;
      priority = sys.scalerm.priority;
      inifile = sys.scalerm.inifile;
      temp2 = "";
    });
  }

  void _decrement() {
    setState(() {
      temp1 = version;
      version = comment;
      comment = temp1;
      temp2 = inifile;
      inifile = entry;
      entry = temp2;
      priority--;
    });
  }

  void _increment() {
    setState(() {
      temp1 = comment;
      comment = version;
      version = temp1;
      temp2 = entry;
      entry = inifile;
      inifile = temp2;
      priority++;
    });
  }

  void _reset() {
    setState(() {
      temp1 = "";
      comment = "";
      version = "";
      temp2 = "";
      entry = "";
      inifile = "";
      priority = 0;
    });
  }

  void _save() {
    sys.info.version = version;
    sys.info.comment = comment;
    sys.scalerm.entry = entry;
    sys.scalerm.priority = priority;
    sys.scalerm.inifile = inifile;
    sys.save();
  }

  void _setDefault() {
    setState(() {
      sys.setDefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _load,
            child: const Text('Load'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _set,
            child: const Text('Set'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _decrement,
            child: const Text('Decrement'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _setDefault,
            child: const Text('Default Set'),
          ),
        ]),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('version   :' + version),
            Text('comment   :' + comment),
            Text('temp1      :' + temp1),
            Text(''),
            Text('entry      :' + entry),
            Text('priority   :' + priority.toString()),
            Text('inifile    :' + inifile),
            Text('temp2      :' + temp2),
          ],
        ),
      ],
    );
  }
}

class Counter_mac_info extends StatefulWidget {
  const Counter_mac_info({super.key});
  @override
  State<Counter_mac_info> createState() =>
      _CounterStateCounter_Counter_mac_info();
}

class _CounterStateCounter_Counter_mac_info extends State<Counter_mac_info> {
  int wakeup_delay = 0;
  int kill_port = 0;
  int drugrev_timeout = 0;

  void _load() {
    setState(() {
      mac_info.load();
    });
  }

  void _set() {
    setState(() {
      wakeup_delay = mac_info.system.wakeup_delay;
      kill_port = mac_info.system.kill_port;
      drugrev_timeout = mac_info.system.drugrev_timeout;
    });
  }

  void _decrement() {
    setState(() {
      wakeup_delay--;
      kill_port--;
      drugrev_timeout--;
    });
  }

  void _increment() {
    setState(() {
      wakeup_delay++;
      kill_port++;
      drugrev_timeout++;
    });
  }

  void _reset() {
    setState(() {
      wakeup_delay = 0;
      kill_port = 0;
      drugrev_timeout = 0;
    });
  }

  void _save() {
    mac_info.system.wakeup_delay = wakeup_delay;
    mac_info.system.kill_port = kill_port;
    mac_info.system.drugrev_timeout = drugrev_timeout;
    mac_info.save();
  }

  void _setDefault() {
    setState(() {
      mac_info.setDefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _load,
            child: const Text('Load'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _set,
            child: const Text('Set'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _decrement,
            child: const Text('Decrement'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _setDefault,
            child: const Text('Default Set'),
          ),
        ]),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('wakeup_delay   :' + wakeup_delay.toString()),
            Text('kill_port      :' + kill_port.toString()),
            Text('drugrev_timeout:' + drugrev_timeout.toString()),
          ],
        ),
      ],
    );
  }
}

class Counter_recogkey_data extends StatefulWidget {
  const Counter_recogkey_data({super.key});
  @override
  State<Counter_recogkey_data> createState() =>
      _CounterStateCounter_recogkey_data();
}

class _CounterStateCounter_recogkey_data extends State<Counter_recogkey_data> {
  String page1_password = "";
  String page1_fcode = "";
  String page1_qcjc_type = "";
  String page5_password = "";
  String page5_fcode = "";
  String page5_qcjc_type = "";

  void _load() {
    setState(() {
      recogkey_data.load();
    });
  }

  void _set() {
    setState(() {
      page1_password = recogkey_data.page1.password;
      page1_fcode = recogkey_data.page1.fcode;
      page1_qcjc_type = recogkey_data.page1.qcjc_type;
      page5_password = recogkey_data.page5.password;
      page5_fcode = recogkey_data.page5.fcode;
      page5_qcjc_type = recogkey_data.page5.qcjc_type;
    });
  }

  void _decrement() {
    setState(() {
      String temp = page5_qcjc_type;
      page5_qcjc_type = page5_fcode;
      page5_fcode = page5_password;
      page5_password = page1_qcjc_type;
      page1_qcjc_type = page1_fcode;
      page1_fcode = page1_password;
      page1_password = temp;
    });
  }

  void _increment() {
    setState(() {
      String temp = page1_password;
      page1_password = page1_fcode;
      page1_fcode = page1_qcjc_type;
      page1_qcjc_type = page5_password;
      page5_password = page5_fcode;
      page5_fcode = page5_qcjc_type;
      page5_qcjc_type = temp;
    });
  }

  void _reset() {
    setState(() {
      page1_password = "";
      page1_fcode = "";
      page1_qcjc_type = "";
      page5_password = "";
      page5_fcode = "";
      page5_qcjc_type = "";
    });
  }

  void _save() {
    recogkey_data.page1.password = page1_password;
    recogkey_data.page1.fcode = page1_fcode;
    recogkey_data.page1.qcjc_type = page1_qcjc_type;
    recogkey_data.page5.password = page5_password;
    recogkey_data.page5.fcode = page5_fcode;
    recogkey_data.page5.qcjc_type = page5_qcjc_type;
    recogkey_data.save();
  }

  void _setDefault() {
    setState(() {
      recogkey_data.setDefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _load,
            child: const Text('Load'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _set,
            child: const Text('Set'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _decrement,
            child: const Text('Decrement'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _setDefault,
            child: const Text('Default Set'),
          ),
        ]),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('password :' + page1_password.toString()),
            Text('fcode    :' + page1_fcode.toString()),
            Text('qcjc_type:' + page1_qcjc_type.toString()),
            Text('password :' + page5_password.toString()),
            Text('fcode    :' + page5_fcode.toString()),
            Text('qcjc_type:' + page5_qcjc_type.toString()),
          ],
        ),
      ],
    );
  }
}

class Counter_counter extends StatefulWidget {
  const Counter_counter({super.key});
  @override
  State<Counter_counter> createState() => _CounterState_counter();
}

class _CounterState_counter extends State<Counter_counter> {
  int onetime_no = 0;
  int cardcash_no = 0;
  int nocardcash_no = 0;

  void _load() {
    setState(() {
      counter.load();
    });
  }

  void _set() {
    setState(() {
      onetime_no = counter.tran.onetime_no;
      cardcash_no = counter.tran.cardcash_no;
      nocardcash_no = counter.tran.nocardcash_no;
    });
  }

  void _decrement() {
    setState(() {
      onetime_no--;
      cardcash_no--;
      nocardcash_no--;
    });
  }

  void _increment() {
    setState(() {
      onetime_no++;
      cardcash_no++;
      nocardcash_no++;
    });
  }

  void _reset() {
    setState(() {
      onetime_no = 0;
      cardcash_no = 0;
      nocardcash_no = 0;
    });
  }

  void _save() {
    counter.tran.onetime_no = onetime_no;
    counter.tran.cardcash_no = cardcash_no;
    counter.tran.nocardcash_no = nocardcash_no;
    counter.save();
  }

  void _setDefault() {
    setState(() {
      counter.setDefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _load,
            child: const Text('Load'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _set,
            child: const Text('Set'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _decrement,
            child: const Text('Decrement'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _setDefault,
            child: const Text('Default Set'),
          ),
        ]),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('onetime_no: ' + onetime_no.toString()),
            Text('cardcash_no: ' + cardcash_no.toString()),
            Text('nocardcash_no: ' + nocardcash_no.toString()),
          ],
        ),
      ],
    );
  }
}

class Counter_tprtim_counter extends StatefulWidget {
  const Counter_tprtim_counter({super.key});
  @override
  State<Counter_tprtim_counter> createState() =>
      _CounterState_Counter_tprtim_counter();
}

class _CounterState_Counter_tprtim_counter
    extends State<Counter_tprtim_counter> {
  int base = 0;
  int curr = 0;
  int fail = 0;

  void _load() {
    setState(() {
      tprtim_counter.load();
    });
  }

  void _set() {
    setState(() {
      base = tprtim_counter.tran.nearend_base;
      curr = tprtim_counter.tran.nearend_curr;
      fail = tprtim_counter.tran.nearend_check_fail;
    });
  }

  void _decrement() {
    setState(() {
      base--;
      curr--;
      fail--;
    });
  }

  void _increment() {
    setState(() {
      base++;
      curr++;
      fail++;
    });
  }

  void _reset() {
    setState(() {
      base = 0;
      curr = 0;
      fail = 0;
    });
  }

  void _save() {
    tprtim_counter.tran.nearend_base = base;
    tprtim_counter.tran.nearend_curr = curr;
    tprtim_counter.tran.nearend_check_fail = fail;
    tprtim_counter.save();
  }

  void _setDefault() {
    setState(() {
      tprtim_counter.setDefault();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ElevatedButton(
            onPressed: _load,
            child: const Text('Load'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _set,
            child: const Text('Set'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _increment,
            child: const Text('Increment'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _decrement,
            child: const Text('Decrement'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _reset,
            child: const Text('Reset'),
          ),
          Text(''),
          ElevatedButton(
            onPressed: _setDefault,
            child: const Text('Default Set'),
          ),
        ]),
        const SizedBox(width: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('base: ' + base.toString()),
            Text('curr: ' + curr.toString()),
            Text('fail: ' + fail.toString()),
          ],
        ),
      ],
    );
  }
}
