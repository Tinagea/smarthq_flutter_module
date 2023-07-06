
/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class WallOvenNavigatePage extends StatefulWidget {
  @override
  _WallOvenNavigatePage createState() => _WallOvenNavigatePage();
}

class _WallOvenNavigatePage extends State<WallOvenNavigatePage> {
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