import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_edit_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_edit_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_model.dart';
import 'package:smarthq_flutter_module/resources/channels/routing_parameter/routing_parameter_body.dart';
import 'package:smarthq_flutter_module/services/shortcut_service.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutEditPage extends StatefulWidget {
  final RoutingParameterBodyShortcut? routingParameter;
  ShortcutEditPage({
    Key? key, required this.routingParameter,
  }): super(key: key);

  @override
  _ShortcutEditPage createState() => _ShortcutEditPage(
      routingParameter: this.routingParameter);
}

class _ShortcutEditPage extends State<ShortcutEditPage> {
  RoutingParameterBodyShortcut? _routingParameter;
  ShortcutSetListModel? _currentModel;

  _ShortcutEditPage({RoutingParameterBodyShortcut? routingParameter}) {
    _routingParameter = routingParameter;
  }

  late TextEditingController _textEditController;

  int _nicknameLength = 0;
  String? _selectedMode = "";
  String? _selectedTempUnit = "";
  String? _selectedTemp = "";
  String? _selectedFan = "";

  @override
  void initState() {
    super.initState();

    _textEditController = TextEditingController();

    Future.delayed(Duration.zero, () async {
      BlocProvider.of<ShortcutEditCubit>(context).getSelectedShortcut(_routingParameter?.key);
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutEditPage:deactivate');
  }

  @override
  void dispose() {
    super.dispose();

    _textEditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ContextUtil.instance.setRoutingContext = context;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: ShortcutAppBar(
                title: LocaleUtil.getString(context, LocaleUtil.EDIT_SHORTCUT),
                leftBtnFunction: () {
                  SystemNavigator.pop(animated: true);
                },
                rightImagePath: ImagePath.NAVIGATE_REMOVE_ICON,
                rightBtnFunction: () {
                  BlocProvider.of<ShortcutEditCubit>(context).removeCurrentShortcut(_routingParameter?.key);
                }
            ).setNavigationAppBar(context: context),
            body: Column(
              children:[
                Expanded(
                    child: ShortcutComponent.componentScrollView(
                        widgets:[
                          ShortcutComponent.componentSelectSectionTitle(
                              LocaleUtil.getString(context, LocaleUtil.NICKNAME)),
                          StatefulBuilder(
                            builder: (context, setState) {
                              int _maxLength = 15;
                              return Padding(
                                padding: ShortcutComponent.componentDefaultPadding(),
                                child: TextField(
                                  style: textStyle_size_16_color_white(),
                                  decoration: InputDecoration(
                                    hintText: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_NICKNAME_HINT),
                                    hintStyle: textStyle_size_15_color_old_silver(),
                                    suffix: Text('$_nicknameLength/$_maxLength'),
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
                                      _nicknameLength = value.length;
                                    });
                                  },
                                  controller: _textEditController,
                                ),
                              );
                            }
                          ),
                          ShortcutComponent.componentSelectSectionTitle(
                              LocaleUtil.getString(context, LocaleUtil.SELECT_YOUR_SHORTCUT_SETTINGS)),
                          BlocBuilder<ShortcutEditCubit, ShortcutEditState>(
                              builder: (context, state) {
                                if (state is ShortcutEditOvenDataLoaded) {
                                  return Wrap(
                                      runSpacing: 20,
                                      children:[
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_MODE_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                            items: state.modeItems,
                                            selected: _selectedMode,
                                            visible: true,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed Oven Mode value: $value");
                                              BlocProvider.of<ShortcutEditCubit>(context).fetchAvailableOvenTemps(
                                                  _routingParameter?.key,
                                                  value,
                                                  state.modeItems
                                              );
                                              _selectedMode = value;
                                            }),
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_TEMP_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_TEMPERATURE),
                                            items: state.tempItems,
                                            selected: _selectedTemp,
                                            tempUnit: state.tempUnit,
                                            visible: true,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed Oven Temp value: $value");
                                              _selectedTemp = value;
                                            })
                                      ]
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                          BlocBuilder<ShortcutEditCubit, ShortcutEditState>(
                              builder: (context, state) {
                                if (state is ShortcutEditAcDataLoaded) {

                                  if (state.tempItems != null) {
                                    _selectedTempUnit = state.tempUnit;
                                    if (_selectedTemp == null) {
                                      _selectedTemp = state.tempItems?[0];
                                    }
                                  } else {
                                    _selectedTempUnit = null;
                                    _selectedTemp = null;
                                  }

                                  if (state.fanItems != null) {
                                    if (_selectedFan == null) {
                                      _selectedFan = state.fanItems?[0];
                                    }
                                  } else {
                                    _selectedFan = null;
                                  }
                                  return Wrap(
                                      runSpacing: 20,
                                      children:[
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_MODE_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                            items: state.modeItems,
                                            selected: _selectedMode,
                                            visible: true,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed AC Mode value: $value");
                                              BlocProvider.of<ShortcutEditCubit>(context).fetchAvailableAcTempsFans(
                                                  _routingParameter?.key,
                                                  value,
                                                  state.modeItems,
                                                  context
                                              );
                                              _selectedMode = value;
                                            }),
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_TEMP_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_TEMPERATURE),
                                            items: (state.tempItems != null)? state.tempItems : [],
                                            tempUnit: state.tempUnit,
                                            visible: (state.tempItems != null)? true : false,
                                            selected: _selectedTemp,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed AC Temp value: $value");
                                              _selectedTemp = value;
                                            }),
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_FAN_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_FAN),
                                            items: ((state.fanItems?.length ?? 0) > 0)? state.fanItems : [],
                                            selected: _selectedFan,
                                            visible: ((state.fanItems?.length ?? 0) > 0)? true : false,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed AC Fan value: $value");
                                              _selectedFan = value;
                                            })
                                      ]
                                  );
                                } else {
                                  return Container();
                                }
                              }),

                          BlocBuilder<ShortcutEditCubit, ShortcutEditState>(
                              builder: (context, state){
                                if (state is ShortcutEditSavedTurnOffShortcut) {
                                  return Visibility(
                                    visible: true,
                                    child: ShortcutComponent.componentShortDetails(
                                        context: context,
                                        title: state.model?.item?.nickname,
                                        subTitle: _getSubTitleString(context, state.model?.item?.applianceType, state.model?.item?.ovenRackType),
                                        iconPath: _getApplianceIconPath(state.model?.item?.applianceType, state.model?.item?.ovenRackType),
                                        setText: LocaleUtil.getString(context, LocaleUtil.TURN_OFF),
                                        nickname: "",
                                        items: [[
                                          LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                          LocaleUtil.getString(context, LocaleUtil.TURN_OFF)
                                        ]]),
                                  );
                                } else {
                                  return Container();
                                }
                              }
                          ),
                          Column(
                              children: _setBlocListeners()
                          )
                        ]
                    )
                ),
                ShortcutComponent.componentBottomButton(
                    title: LocaleUtil.getString(context, LocaleUtil.NEXT),
                    clickedFunction: () {
                      _postSelectedShortcut();
                    }),
              ]
            )
        )
    );
  }

  List<Widget> _setBlocListeners() {
    return [
      BlocListener<ShortcutEditCubit, ShortcutEditState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEditSavedShortcut);
          },
          listener: (context, state){
            final currentState = state as ShortcutEditSavedShortcut;
            _currentModel = currentState.model;
            _textEditController.text = currentState.model?.item?.shortcutName ?? "";
            setState(() {
              _nicknameLength = _textEditController.text.length;
            });
            _selectedMode = currentState.model?.item?.mode;
            _selectedTemp = currentState.model?.item?.temp;
            _selectedTempUnit = currentState.model?.item?.tempUnit;
            _selectedFan = currentState.model?.item?.fan;

            BlocProvider.of<ShortcutEditCubit>(context).fetchAvailableItems(_routingParameter?.key, context);
          },
          child: Container()
      ),
      BlocListener<ShortcutEditCubit, ShortcutEditState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEditSavedTurnOffShortcut);
          },
          listener: (context, state){
            final currentState = state as ShortcutEditSavedTurnOffShortcut;
            _currentModel = currentState.model;
            _textEditController.text = currentState.model?.item?.shortcutName ?? "";
            setState(() {
              _nicknameLength = _textEditController.text.length;
            });
            _selectedMode = currentState.model?.item?.mode;
          },
          child: Container()
      ),
      BlocListener<ShortcutEditCubit, ShortcutEditState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEditRemoveSucceeded);
          },
          listener: (context, state){
            SystemNavigator.pop(animated: true);
          },
          child: Container()
      ),
      BlocListener<ShortcutEditCubit, ShortcutEditState>(
          listenWhen: (previous, current) {
            return (current is ShortcutEditTurnOffSucceeded);
          },
          listener: (context, state){
            SystemNavigator.pop(animated: true);
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

  void _postSelectedShortcut() {
    if(_currentModel?.item?.shortcutType == ShortcutType.shortcutTypeMode.name) {
      geaLog.debug("ShortcutEditPage: onNextButton - updateMode ${_textEditController.text}, $_selectedMode, $_selectedTempUnit, $_selectedTemp, $_selectedFan");
      BlocProvider.of<ShortcutEditCubit>(context).saveCurrentShortcut(
          _currentModel?.shortcutId,
          _currentModel?.item?.jid,
          _currentModel?.item?.nickname,
          _currentModel?.item?.applianceType,
          _currentModel?.item?.ovenRackType,
          _textEditController.text,
          _currentModel?.item?.shortcutType,
          _selectedMode,
          _selectedTempUnit,
          _selectedTemp,
          _selectedFan);
      Navigator.of(context).pushNamed(Routes.SHORTCUT_REVIEW_PAGE);
    } else if (_currentModel?.item?.shortcutType == ShortcutType.shortcutTypeTurnOff.name) {
      geaLog.debug("ShortcutEditPage: onNextButton - updateTurnOff ${_textEditController.text}");
      BlocProvider.of<ShortcutEditCubit>(context).saveTurnOffShortcut(
          _currentModel?.shortcutId,
          _currentModel?.item?.jid,
          _currentModel?.item?.nickname,
          _currentModel?.item?.applianceType,
          _currentModel?.item?.ovenRackType,
          _textEditController.text,
          _currentModel?.item?.shortcutType,
          LocaleUtil.getString(context, LocaleUtil.TURN_OFF));
    }
  }
}