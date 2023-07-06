
/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class RangeNavigatePage extends StatefulWidget {
  @override
  _RangeNavigatePage createState() => _RangeNavigatePage();
}

class _RangeNavigatePage extends State<RangeNavigatePage> {
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