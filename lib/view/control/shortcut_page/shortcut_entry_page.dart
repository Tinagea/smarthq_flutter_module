// file: shortcut_entry_page.dart
// date: Oct/21/2022
// brief: Shortcut create page
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_entry_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_entry_model.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/api_client_entity/appliance_list_response.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/common_alert_dialog.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutEntryPage extends StatefulWidget {
  ShortcutEntryPage({Key? key}) : super(key: key);

  @override
  _ShortcutEntryPage createState() => _ShortcutEntryPage();
}

class _ShortcutEntryPage extends State<ShortcutEntryPage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, (){
      BlocProvider.of<ShortcutEntryCubit>(context).getAvailableApplianceList();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutEntryPage:deactivate');
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return FocusDetector(
      onFocusGained: (){
        BlocProvider.of<ShortcutEntryCubit>(context).getAvailableApplianceList();
      },
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: ShortcutAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.NEW_SHORTCUT),
              isLeftButtonShown: false
            ).setNavigationAppBar(context: context),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<ShortcutEntryCubit, ShortcutEntryState>(
                        builder: (context, state) {
                          if (state is ShortcutEntryLoading) {
                            return Center(
                                child: CircularProgressIndicator(color: Colors.purple,));
                          } else if (state is ShortcutEntryAppliancesLoaded) {
                            final items = this._filterAvailableAppliance(state.applianceList);
                            return ShortcutComponent.componentScrollView(
                                widgets:[
                                  ShortcutComponent.componentSelectSectionTitle(
                                      LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE_FOR_CREATING_SHORTCUT)!),
                                  GridView.count(
                                      padding: ShortcutComponent.componentDefaultPadding(),
                                      scrollDirection: Axis.vertical,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 10.h,
                                      children: new List<Widget>.generate(
                                          (items?.length ?? 0), (index) {
                                        return ShortcutComponent.componentGridListTile(context: context,
                                            title: items?[index].nickname,
                                            imagePath: _getImagePath(items?[index].type),
                                            isOffline: _isOffline(items?[index].online),
                                            onClickedFunction: (isOffline){
                                              if (isOffline){
                                                // show popup
                                                var baseDialog = CommonBaseAlertDialog(
                                                    context: context,
                                                    title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_OFFLINE_ALERT_TITLE),
                                                    content: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_OFFLINE_ALERT_DESCRIPTION),
                                                    yesOnPressed: () {},
                                                    yesString: LocaleUtil.getString(context, LocaleUtil.DIALOG_ACTION_BUTTON_DISMISS)
                                                );
                                                showDialog(context: context, builder: (context) => baseDialog);
                                              } else {
                                                _navigateRouteByApplianceType(context, items?[index]);
                                              }
                                            });
                                      })
                                  ),
                                  ShortcutComponent.componentInfoWithContent(
                                      context: context,
                                      title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCES_NEW_SHORTCUT_EXPLAIN)!)
                                ]
                            );
                          } else {
                            return Container();
                          }
                        }
                    ),
                  ),
                  Column(
                      children: _setBlocListeners()
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  List<Widget> _setBlocListeners() {
    return [
      BlocListener<ShortcutEntryCubit, ShortcutEntryState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEntryOvenTypeLoaded);
          },
          listener: (context, state){
            final currentState = state as ShortcutEntryOvenTypeLoaded;
            BlocProvider.of<ShortcutEntryCubit>(context).saveSelectedOvenType(currentState.ovenType);
            BlocProvider.of<ShortcutEntryCubit>(context).fetchOvenRackTypeScreen(currentState.ovenType);
          },
          child: Container()),
      BlocListener<ShortcutEntryCubit, ShortcutEntryState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEntryOvenSingleOvenSelected);
          },
          listener: (context, state){
            final currentState = state as ShortcutEntryOvenSingleOvenSelected;
            BlocProvider.of<ShortcutEntryCubit>(context).saveSelectedOvenRackType(currentState.ovenRackType);
            Navigator.of(context).pushNamed(Routes.SHORTCUT_SELECT_TYPE_PAGE);
          },
          child: Container()),
      BlocListener<ShortcutEntryCubit, ShortcutEntryState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEntryOvenDoubleOvenSelected);
          },
          listener: (context, state){
            Navigator.of(context).pushNamed(Routes.SHORTCUT_SELECT_OVEN_TYPE_PAGE);
          },
          child: Container()),
    ];
  }

  List<ApplianceListItem>? _filterAvailableAppliance(List<ApplianceListItem>? originalItems) {
    if (originalItems == null) {
      return null;
    }

    List<ApplianceListItem> filteredItems = [];

    for(var item in originalItems) {
      if(item.type == ApplianceTypes.airConditioner) {
          /// TODO: enable ovens for in Phase 2
          // || item.type == ApplianceTypes.oven) {
        filteredItems.add(item);
      }
    }

    return filteredItems;
  }

  bool _isOffline(String? presence) {
    if(presence == "ONLINE") {
      return false;
    } else {
      return true;
    }
  }

  String? _getImagePath(String? type) {
    if (type == null) {
      return null;
    }
    switch (type) {
      case ApplianceTypes.airConditioner:
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_AC;
      case ApplianceTypes.oven:
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_OVEN;
      default:
        return null;
    }
  }

  void _navigateRouteByApplianceType(BuildContext context, ApplianceListItem? appliance) {
    BlocProvider.of<ShortcutEntryCubit>(context).saveSelectedAppliance(appliance);

    switch (appliance?.type) {
      case ApplianceTypes.airConditioner:
        Navigator.of(context).pushNamed(Routes.SHORTCUT_SELECT_TYPE_PAGE);
        break;

      case ApplianceTypes.oven:
        BlocProvider.of<ShortcutEntryCubit>(context).fetchOvenType(appliance?.jid);
        break;

      default:
        break;
    }
  }
}