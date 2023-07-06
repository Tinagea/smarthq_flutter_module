
/*
  * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
  */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class BeverageCenterNavigatePage extends StatefulWidget {
  @override
  _BeverageCenterNavigatePage createState() => _BeverageCenterNavigatePage();
}

class _BeverageCenterNavigatePage extends State<BeverageCenterNavigatePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (globals.subRouteName != '') {
        final pageName = globals.subRouteName;
        globals.subRouteName = '';
        Navigator.of(context).popAndPushNamed(pageName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
