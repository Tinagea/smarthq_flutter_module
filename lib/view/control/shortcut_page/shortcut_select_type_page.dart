// file: shortcut_select_type_page.dart
// date: Oct/21/2022
// brief: Shortcut select type page
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_select_type_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutSelectTypePage extends StatefulWidget {
  @override
  _ShortcutSelectTypePage createState() => _ShortcutSelectTypePage();
}

class _ShortcutSelectTypePage extends State<ShortcutSelectTypePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutSelectTypePage:deactivate');
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
            appBar: ShortcutAppBar(
                title: LocaleUtil.getString(context, LocaleUtil.NEW_SHORTCUT)
            ).setNavigationAppBar(context: context),
          body: FutureBuilder<String?>(
            future: BlocProvider.of<ShortcutSelectTypeCubit>(context).getSavedSelectedApplianceType(),
            builder: (context, snapshot) {
              final applianceType = snapshot.data;
              ShortcutListModel? items;
              if (applianceType == ApplianceTypes.airConditioner) {
                items = ShortcutListModel(
                  title: LocaleUtil.getString(context, LocaleUtil.CHOOSE_SHORTCUT_TYPE_FOR_WINDOW_AC),
                  items: [
                    ShortcutListItemModel(
                        imagePath: ImagePath.SHORTCUT_APPLIANCE_SET_ICON,
                        title: LocaleUtil.getString(context, LocaleUtil.SET_WINDOW_AC),
                        routePath: Routes.SHORTCUT_CREATE_PAGE
                    ),
                    ShortcutListItemModel(
                        imagePath: ImagePath.SHORTCUT_APPLIANCE_POWER_ICON,
                        title: LocaleUtil.getString(context, LocaleUtil.TURN_OFF_WINDOW_AC),
                        routePath: Routes.SHORTCUT_TURN_OFF_PAGE
                    )
                  ]
                );
              } else if (applianceType == ApplianceTypes.oven) {
                items = ShortcutListModel(
                    title: LocaleUtil.getString(context, LocaleUtil.CHOOSE_SHORTCUT_TYPE_FOR_OVEN),
                    items: [
                      ShortcutListItemModel(
                          imagePath: ImagePath.SHORTCUT_APPLIANCE_SET_ICON,
                          title: LocaleUtil.getString(context, LocaleUtil.SET_OVEN),
                          routePath: Routes.SHORTCUT_CREATE_PAGE
                      ),
                      ShortcutListItemModel(
                          imagePath: ImagePath.SHORTCUT_APPLIANCE_POWER_ICON,
                          title: LocaleUtil.getString(context, LocaleUtil.TURN_OFF_OVEN),
                          routePath: Routes.SHORTCUT_TURN_OFF_PAGE
                      )
                    ]
                );
              }

              if (items != null) {
                return ShortcutComponent.componentScrollView(
                    widgets: [
                      ShortcutComponent.componentSelectSectionTitle(items.title),
                      ShortcutComponent.componentListTile(
                          context: context,
                          imagePath: items.items?[0]?.imagePath,
                          title: items.items?[0]?.title,
                          clickedFunction: (){
                            final routePath = items?.items?[0]?.routePath;
                            if (routePath != null) {
                              Navigator.of(context).pushNamed(routePath);
                            }
                          }
                      ),
                      ShortcutComponent.componentListTile(
                          context: context,
                          imagePath: items.items?[1]?.imagePath,
                          title: items.items?[1]?.title,
                          clickedFunction: (){
                            final routePath = items?.items?[1]?.routePath;
                            if (routePath != null) {
                              Navigator.of(context).pushNamed(routePath);
                            }
                          }
                      )]
                );
              } else {
                return Container();
              }
            }
          )
        )
    );
  }
}