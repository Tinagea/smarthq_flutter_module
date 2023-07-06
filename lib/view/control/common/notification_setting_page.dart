import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/notification_setting_cubit.dart';
import 'package:smarthq_flutter_module/models/common/notification/notification_setting_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

class NotificationSettingPage extends StatefulWidget {
  NotificationSettingPage({Key? key}) : super(key: key);

  @override
  _NotificationSettingPage createState() => _NotificationSettingPage();
}

class _NotificationSettingPage extends State<NotificationSettingPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, (){
      BlocProvider.of<NotificationSettingCubit>(context).getNotificationInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<NotificationSettingCubit, NotificationSettingState>(
                    bloc: BlocProvider.of<NotificationSettingCubit>(context),
                    builder: (context, state) {
                      if (state.loadingStatus == LoadingStatus.loading) {
                        return Center(
                            child: CircularProgressIndicator(color: Colors.purple,));
                      } else if (state.loadingStatus == LoadingStatus.updated){
                        return ListView.builder(
                          itemCount: state.notificationSettingList?.length ?? 0,
                          itemBuilder: (context, index) {
                            final title = state.notificationSettingList?[index].title ?? "";
                            final description = state.notificationSettingList?[index].description ?? "";
                            final enable = state.notificationSettingList?[index].ruleEnabled ?? false;
                            return Component.componentNotificationSettingItem(
                                context, title, description, enable,
                                future: () async {
                                  return await BlocProvider.of<NotificationSettingCubit>(context).postNotificationRule(index);
                                },
                                onChange: (value) {
                                  geaLog.debug('onChange:$value');
                                },
                                onTap: (value) {
                                  geaLog.debug('onTap:$value');
                                }
                            );
                          });
                      } else {
                        return Container();
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}