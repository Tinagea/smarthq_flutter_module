import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_review_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_review_model.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutReviewPage extends StatefulWidget {
  @override
  _ShortcutReviewPage createState() => _ShortcutReviewPage();
}

class _ShortcutReviewPage extends State<ShortcutReviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutReviewPage:deactivate');
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
            body: Column(
                children:[
                  BlocListener<ShortcutReviewCubit, ShortcutReviewState>(
                      listenWhen: (previous, current){
                        return (current is ShortcutReviewShortcutSavingSucceeded);
                      },
                      listener: (context, state){
                        SystemNavigator.pop(animated:true);
                      },
                      child: Container()
                  ),
                  Expanded(
                      child: ShortcutComponent.componentScrollView(
                          widgets:[
                            ShortcutComponent.componentSelectSectionTitle(
                                LocaleUtil.getString(context, LocaleUtil.REVIEW)),
                            FutureBuilder<ShortcutSetItemModel?>(
                                future: BlocProvider.of<ShortcutReviewCubit>(context).getSavedSelectedShortcut(),
                                builder: (context, state) {
                                  return ShortcutComponent.componentShortDetails(
                                      context: context,
                                      title: state.data?.nickname,
                                      subTitle: _getSubTitleString(context, state.data),
                                      iconPath: _getApplianceIconPath(state.data),
                                      setText: _getMajorSetValueString(state.data),
                                      nickname: state.data?.shortcutName,
                                      items: _getSettingsItems(context, state.data)
                                  );
                            })
                          ])
                  ),
                  ShortcutComponent.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.SAVE),
                      clickedFunction: () {
                        geaLog.debug("ShortcutReviewPage: onSave");
                        BlocProvider.of<ShortcutReviewCubit>(context).saveCurrentShortcut();
                      }
                  )
                ]
            )
        )
    );
  }

  String? _getApplianceIconPath(ShortcutSetItemModel? model) {
    if(model?.applianceType == ApplianceTypes.airConditioner) {
      return ImagePath.SHORTCUT_APPLIANCE_TYPE_AC_SMALL;
    } else if (model?.applianceType == ApplianceTypes.oven) {
      if(model?.ovenRackType == OvenRackType.upperOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_UPPER_OVEN_SMALL;
      } else if (model?.ovenRackType == OvenRackType.lowerOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_LOWER_OVEN_SMALL;
      } else if (model?.ovenRackType == OvenRackType.leftOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_LEFT_OVEN_SMALL;
      } else if (model?.ovenRackType == OvenRackType.rightOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_RIGHT_OVEN_SMALL;
      }
    }

    return null;
  }

  String? _getSubTitleString(BuildContext context, ShortcutSetItemModel? model) {
    if(model?.applianceType == ApplianceTypes.airConditioner) {
      return null;
    } else if (model?.applianceType == ApplianceTypes.oven) {
      if(model?.ovenRackType == OvenRackType.upperOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.UPPER_OVEN);
      } else if (model?.ovenRackType == OvenRackType.lowerOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.LOWER_OVEN);
      } else if (model?.ovenRackType == OvenRackType.leftOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.LEFT_SIDE_OVEN);
      } else if (model?.ovenRackType == OvenRackType.rightOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.RIGHT_SIDE_OVEN);
      }
    }

    return null;
  }

  String? _getMajorSetValueString(ShortcutSetItemModel? model) {
    if (model?.temp != null) {
      return '${model?.temp} °${model?.tempUnit?.substring(0, 1).toUpperCase()}';
    } else if (model?.mode != null) {
      return model?.mode;
    }

    return null;
  }

  List<List<String?>>? _getSettingsItems(BuildContext context, ShortcutSetItemModel? model) {
    List<List<String?>> overallList = [];

    if ((model?.temp?.length ?? 0) > 0) {
      overallList.add([
        LocaleUtil.getString(context, LocaleUtil.SHORTCUT_TEMPERATURE),
        '${model?.temp} °${model?.tempUnit?.substring(0, 1).toUpperCase()}'
      ]);
    }

    if ((model?.mode?.length ?? 0) > 0) {
      overallList.add([
        LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
        model?.mode
      ]);
    }

    if ((model?.fan?.length ?? 0) > 0) {
      overallList.add([
        LocaleUtil.getString(context, LocaleUtil.SHORTCUT_FAN),
        model?.fan
      ]);
    }

    return overallList;
  }
}