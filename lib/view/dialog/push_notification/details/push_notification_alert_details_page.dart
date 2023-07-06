import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/details/list_item_model_mapper.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog.dart';

class PushNotificationAlertDetailsPage extends StatefulWidget {
  PushNotificationAlertDetailsPage({
    Key? key,
    required this.arguments})
      : super(key: key);

  final PushNotificationAlertDetailsArgs arguments;

  _PushNotificationAlertDetailsPage createState() => _PushNotificationAlertDetailsPage();
}

class _PushNotificationAlertDetailsPage
    extends State<PushNotificationAlertDetailsPage> {
  static const String tag = "_PushNotificationAlertDetailsPage";

  @override
  void initState() {
    geaLog.debug('$tag:initState');
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CommonAppBar(
          title: widget.arguments.title,
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).setNavigationAppBar(
          context: context,
          actionRequired: false,
        ),
        backgroundColor: Colors.black,
        body: ListView(
          padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          children: PushDetailWidgetMapper.mapContentItemsToWidgets(
            context,
            widget.arguments.contentItems,
          ),
        )
      ),
    );
  }
}
