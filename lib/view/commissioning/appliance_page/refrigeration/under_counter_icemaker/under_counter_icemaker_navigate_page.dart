
/*
  * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
  */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class UnderCounterIcemakerNavigatePage extends StatefulWidget {
  @override
  _UnderCounterIcemakerNavigatePage createState() => _UnderCounterIcemakerNavigatePage();
}

class _UnderCounterIcemakerNavigatePage extends State<UnderCounterIcemakerNavigatePage> {
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
