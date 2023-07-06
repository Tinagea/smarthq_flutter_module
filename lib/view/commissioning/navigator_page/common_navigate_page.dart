
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;

class CommonNavigatePage extends StatefulWidget {
  @override
  _CommonNavigatePage createState() => _CommonNavigatePage();
}

class _CommonNavigatePage extends State<CommonNavigatePage> {
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