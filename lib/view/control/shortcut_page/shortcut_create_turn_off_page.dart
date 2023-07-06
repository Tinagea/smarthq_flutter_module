import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_create_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_review_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_create_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_review_model.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutCreateTurnOffPage extends StatefulWidget {
  @override
  _ShortcutCreateTurnOffPage createState() => _ShortcutCreateTurnOffPage();
}

class _ShortcutCreateTurnOffPage extends State<ShortcutCreateTurnOffPage> {

  late TextEditingController _textEditController;

  String _nickname = "";

  @override
  void initState() {
    super.initState();

    _textEditController = TextEditingController();
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutCreateTurnOffPage:deactivate');
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;
    int _maxLength = 15;

    Future.delayed(Duration.zero, () async {
      BlocProvider.of<ShortcutCreateCubit>(context).fetchApplianceType();
    });

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: ShortcutAppBar(
                title: LocaleUtil.getString(context, LocaleUtil.NEW_SHORTCUT)
            ).setNavigationAppBar(context: context),
            body: Column(
                children:[
                  Expanded(
                      child: ShortcutComponent.componentScrollView(
                          widgets:[
                            ShortcutComponent.componentSelectSectionTitle(
                                LocaleUtil.getString(context, LocaleUtil.NICKNAME)),
                            Padding(
                              padding: ShortcutComponent.componentDefaultPadding(),
                              child: TextField(
                                style: textStyle_size_16_color_white(),
                                decoration: InputDecoration(
                                  hintText: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_NICKNAME_HINT),
                                  hintStyle: textStyle_size_15_color_old_silver(),
                                  suffix: Text('${_nickname.length}/$_maxLength'),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                maxLength: _maxLength,
                                onChanged: (String value) {
                                  setState(() {
                                    _nickname = value;
                                  });
                                },
                                controller: _textEditController,
                              ),
                            ),
                            ShortcutComponent.componentSelectSectionTitle(
                                LocaleUtil.getString(context, LocaleUtil.REVIEW)),
                            BlocBuilder<ShortcutCreateCubit, ShortcutCreateState>(
                                builder: (context, state) {
                                  if (state is ShortcutCreateApplianceDetailLoaded) {
                                    return ShortcutComponent.componentShortDetails(
                                        context: context,
                                        title: state.applianceNickname,
                                        subTitle: _getSubTitleString(context, state.applianceType, state.ovenRackType),
                                        iconPath: _getApplianceIconPath(state.applianceType, state.ovenRackType),
                                        setText: LocaleUtil.getString(context, LocaleUtil.TURN_OFF),
                                        nickname: _nickname,
                                        items: [[
                                          LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                          LocaleUtil.getString(context, LocaleUtil.TURN_OFF)
                                        ]]);
                                  } else {
                                    return Container();
                                  }
                            }),
                          ])
                  ),
                  ShortcutComponent.componentBottomButton(
                      title: LocaleUtil.getString(context, LocaleUtil.SAVE),
                      clickedFunction: () {
                        geaLog.debug("ShortcutTurnOffPage: onSave");
                        BlocProvider.of<ShortcutCreateCubit>(context).saveTurnOffShortcut(
                            _nickname,
                            LocaleUtil.getString(context, LocaleUtil.TURN_OFF)
                        );
                      }
                  ),
                  Column(
                    children: _setBlocListeners()
                  )
                ]
            )
        )
    );
  }

  List<Widget> _setBlocListeners() {
    return [
      BlocListener<ShortcutCreateCubit, ShortcutCreateState>(
          listenWhen: (previous, current) {
            return (current is ShortcutCreateApplianceTypeLoaded);
          },
          listener: (context, state){
            final currentState = state as ShortcutCreateApplianceTypeLoaded;
            if(currentState.applianceType == ApplianceTypes.airConditioner ||
                currentState.applianceType == ApplianceTypes.oven) {
              BlocProvider.of<ShortcutCreateCubit>(context).fetchApplianceDetails(currentState.applianceType);
            }
          },
          child: Container()
      ),
      BlocListener<ShortcutCreateCubit, ShortcutCreateState>(
          listenWhen: (previous, current) {
            return (current is ShortcutCreateTurnOffSucceeded);
          },
          listener: (context, state){
            final currentState = state as ShortcutCreateTurnOffSucceeded;
            BlocProvider.of<ShortcutReviewCubit>(context).storeShortcut(null, currentState.model);
          },
          child: Container()
      ),
      BlocListener<ShortcutReviewCubit, ShortcutReviewState>(
          listenWhen: (previous, current){
            return (current is ShortcutReviewShortcutSavingSucceeded);
          },
          listener: (context, state){
            SystemNavigator.pop(animated:true);
          },
          child: Container()
      ),
    ];
  }

  String? _getApplianceIconPath(String? applianceType, String? ovenRackType) {
    if(applianceType == ApplianceTypes.airConditioner) {
      return ImagePath.SHORTCUT_APPLIANCE_TYPE_AC_SMALL;
    } else if (applianceType == ApplianceTypes.oven) {
      if(ovenRackType == OvenRackType.upperOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_UPPER_OVEN_SMALL;
      } else if (ovenRackType == OvenRackType.lowerOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_LOWER_OVEN_SMALL;
      } else if (ovenRackType == OvenRackType.leftOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_LEFT_OVEN_SMALL;
      } else if (ovenRackType == OvenRackType.rightOven.name) {
        return ImagePath.SHORTCUT_APPLIANCE_TYPE_RIGHT_OVEN_SMALL;
      }
    }

    return null;
  }

  String? _getSubTitleString(BuildContext context, String? applianceType, String? ovenRackType) {
    if(applianceType == ApplianceTypes.airConditioner) {
      return null;
    } else if (applianceType == ApplianceTypes.oven) {
      if(ovenRackType == OvenRackType.upperOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.UPPER_OVEN);
      } else if (ovenRackType == OvenRackType.lowerOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.LOWER_OVEN);
      } else if (ovenRackType == OvenRackType.leftOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.LEFT_SIDE_OVEN);
      } else if (ovenRackType == OvenRackType.rightOven.name) {
        return LocaleUtil.getString(context, LocaleUtil.RIGHT_SIDE_OVEN);
      }
    }

    return null;
  }
}