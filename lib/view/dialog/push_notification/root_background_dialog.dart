import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/dialog/dialog_cubit.dart';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_model.dart';
import 'package:smarthq_flutter_module/models/dialog/dialog_type.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter_body.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/dialog_home.dart';

/// The transparent background that serves as the root route of a dialog.
/// - This widget observes navigation push and pop
/// - This widget exits the flutter app when it is at the top of the navigation stack
///   (i.e. There are no other navigation routes stacked on top of it
/// - The behavior to exit the flutter app when returning to this widget
///   is to support multiple dialogs to stack on top of each other, and
///   return to the host runtime when all dialogs have been dismissed
class RootBackgroundDialog extends StatefulWidget {
  RootBackgroundDialog({Key? key}) : super(key: key);

  _RootBackgroundDialog createState() => _RootBackgroundDialog();
}

class _RootBackgroundDialog extends State<RootBackgroundDialog>
    with RouteAware {
  static const String tag = "_RootBackgroundDialog:";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dialogRouteObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    dialogRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {}

  @override
  void didPopNext() {
    final isFirst = ModalRoute.of(context)?.isFirst ?? false;
    if (isFirst) SystemNavigator.pop();
  }

  @override
  void initState() {
    geaLog.debug("$tag is called");
    super.initState();
    BuildEnvironment.channelManager?.readyToService();
    Future.delayed(Duration.zero, () {
      BlocProvider.of<DialogCubit>(context).getTokens();
    });
  }

  @override
  Widget build(BuildContext context) {
    geaLog.debug("${tag}build");
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          /// Just for testing
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.arrow_forward),
          //   onPressed: () {
          //     BlocProvider.of<DialogCubit>(context).testDialog();
          //   },
          // ),
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final isFirst = ModalRoute.of(context)?.isFirst ?? false;
              if (isFirst) SystemNavigator.pop();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: setBlocListeners(),
              ),
            ),
          )),
    );
  }

  List<Widget> setBlocListeners() {
    return [
      BlocListener<DialogCubit, DialogState>(
        listenWhen: (previous, current) {
          return current is DialogShow;
        },
        listener: (context, state) {
          geaLog.debug("${tag}listener");
          final dialogState = state as DialogShow;
          switch (dialogState.dialogType) {
            case DialogType.initial:
              /// initial is a default value.
              /// So the app should not show the popup or dialog.
              break;
            case DialogType.pushNotification:
              final dialogParameter = dialogState.dialogParameter;
              final kind = dialogParameter?.kind;
              final body = dialogParameter?.body;
              if (kind == DialogParameterKind.pushNotification &&
                  body is DialogParameterBodyPushNotification) {
                Navigator.of(context).pushNamed(Routes.DIALOG_PUSH_NOTIFICATION,
                    arguments: body);
              }
              break;
          }
        },
        child: Container(),
      ),
    ];
  }
}
