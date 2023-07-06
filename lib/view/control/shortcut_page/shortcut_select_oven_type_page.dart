// file: shortcut_select_type_page.dart
// date: Oct/21/2022
// brief: Shortcut select type page
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_select_type_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutSelectOvenTypePage extends StatefulWidget {
  @override
  _ShortcutSelectOvenTypePage createState() => _ShortcutSelectOvenTypePage();
}

class _ShortcutSelectOvenTypePage extends State<ShortcutSelectOvenTypePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutSelectOvenTypePage:deactivate');
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
                future: BlocProvider.of<ShortcutSelectTypeCubit>(context).getSavedSelectedOvenType(),
                builder: (context, snapshot) {
                  final ovenType = snapshot.data;
                  ShortcutListModel? items;
                  if (ovenType == OvenType.doubleOven.name) {
                    items = ShortcutListModel(
                        title: LocaleUtil.getString(context, LocaleUtil.WHICH_OVEN_SHORTCUT_DO_YOU_WANT_CREATE),
                        items: [
                          ShortcutListItemModel(
                              imagePath: ImagePath.SHORTCUT_APPLIANCE_TYPE_UPPER_OVEN,
                              title: LocaleUtil.getString(context, LocaleUtil.UPPER_OVEN),
                              option: OvenRackType.upperOven.name
                          ),
                          ShortcutListItemModel(
                              imagePath: ImagePath.SHORTCUT_APPLIANCE_TYPE_LOWER_OVEN,
                              title: LocaleUtil.getString(context, LocaleUtil.LOWER_OVEN),
                              option: OvenRackType.lowerOven.name
                          )
                        ]
                    );
                  } else if (ovenType == OvenType.sideBySide.name) {
                    items = ShortcutListModel(
                        title: LocaleUtil.getString(context, LocaleUtil.WHICH_OVEN_SHORTCUT_DO_YOU_WANT_CREATE),
                        items: [
                          ShortcutListItemModel(
                              imagePath: ImagePath.SHORTCUT_APPLIANCE_TYPE_LEFT_OVEN,
                              title: LocaleUtil.getString(context, LocaleUtil.LEFT_SIDE_OVEN),
                              option: OvenRackType.leftOven.name
                          ),
                          ShortcutListItemModel(
                              imagePath: ImagePath.SHORTCUT_APPLIANCE_TYPE_RIGHT_OVEN,
                              title: LocaleUtil.getString(context, LocaleUtil.RIGHT_SIDE_OVEN),
                              option: OvenRackType.rightOven.name
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
                                BlocProvider.of<ShortcutSelectTypeCubit>(context).saveSelectedOvenRackType(items?.items?[0]?.option);
                                Navigator.of(context).pushNamed(Routes.SHORTCUT_SELECT_TYPE_PAGE);
                              }),
                          ShortcutComponent.componentListTile(
                              context: context,
                              imagePath: items.items?[1]?.imagePath,
                              title: items.items?[1]?.title,
                              clickedFunction: (){
                                BlocProvider.of<ShortcutSelectTypeCubit>(context).saveSelectedOvenRackType(items?.items?[1]?.option);
                                Navigator.of(context).pushNamed(Routes.SHORTCUT_SELECT_TYPE_PAGE);
                              })]
                    );
                  } else {
                    return Container();
                  }
                })));
  }
}