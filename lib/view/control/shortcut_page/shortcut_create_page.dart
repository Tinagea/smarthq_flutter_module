import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_create_cubit.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/appliance_model.dart';
import 'package:smarthq_flutter_module/models/shortcut/shortcut_create_model.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_app_bar.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/common_widget/shortcut_component.dart';

class ShortcutCreatePage extends StatefulWidget {
  @override
  _ShortcutCreatePage createState() => _ShortcutCreatePage();
}

class _ShortcutCreatePage extends State<ShortcutCreatePage> {

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
      BlocProvider.of<ShortcutCreateCubit>(context).fetchApplianceType();
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    geaLog.debug('ShortcutCreatePage:deactivate');
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
                title: LocaleUtil.getString(context, LocaleUtil.NEW_SHORTCUT)
            ).setNavigationAppBar(context: context),
            body: Column(
              children:[
                BlocListener<ShortcutCreateCubit, ShortcutCreateState>(
                    listenWhen: (previous, current) {
                      return (current is ShortcutCreateApplianceTypeLoaded);
                    },
                    listener: (context, state){
                      final currentState = state as ShortcutCreateApplianceTypeLoaded;
                      if(currentState.applianceType == ApplianceTypes.airConditioner ||
                          currentState.applianceType == ApplianceTypes.oven) {
                        BlocProvider.of<ShortcutCreateCubit>(context).fetchAvailableItems(currentState.applianceType, context);
                      }
                    },
                    child: Container()
                ),
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
                          BlocBuilder<ShortcutCreateCubit, ShortcutCreateState>(
                              builder: (context, state) {
                                if (state is ShortcutCreateOvenDataLoaded) {
                                  _selectedTempUnit = state.tempUnit;
                                  if (_selectedMode == "") {
                                    _selectedMode = state.modeItems?[0];
                                  }
                                  _selectedTemp = state.tempItems?[0];

                                  return Wrap(
                                      runSpacing: 20,
                                      children:[
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_MODE_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                            items: state.modeItems,
                                            visible: true,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed Oven Mode value: $value");
                                              BlocProvider.of<ShortcutCreateCubit>(context).fetchAvailableOvenTemps(
                                                  value,
                                                  state.modeItems
                                              );
                                              _selectedMode = value;
                                            }),
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_TEMP_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_TEMPERATURE),
                                            items: state.tempItems,
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
                          BlocBuilder<ShortcutCreateCubit, ShortcutCreateState>(
                              builder: (context, state) {
                                if (state is ShortcutCreateAcDataLoaded) {
                                  if (_selectedMode == "" || _selectedMode == null) {
                                    _selectedMode = state.modeItems?[0];
                                  }

                                  if (state.tempItems != null) {
                                    _selectedTempUnit = state.tempUnit;
                                    if (_selectedTemp == "" || _selectedMode == null) {
                                      _selectedTemp = state.tempItems?[0];
                                    }
                                  } else {
                                    _selectedTempUnit = null;
                                    _selectedTemp = null;
                                  }

                                  if (state.fanItems != null) {
                                    _selectedFan = state.fanItems?[0];
                                  } else {
                                    _selectedFan = null;
                                  }

                                  return Wrap(
                                      runSpacing: 20,
                                      children:[
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_MODE_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_MODE),
                                            selected: state.selectedMode,
                                            items: state.modeItems,
                                            visible: true,
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed AC Mode value: $value");
                                              BlocProvider.of<ShortcutCreateCubit>(context).fetchAvailableAcTempsFans(
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
                                            onValueChanged: (value) {
                                              geaLog.debug("Changed AC Temp value: $value");
                                              _selectedTemp = value;
                                            }),
                                        ShortcutComponent.componentSettingsPicker(
                                            iconImagePath: ImagePath.SHORTCUT_SETTINGS_FAN_ICON,
                                            title: LocaleUtil.getString(context, LocaleUtil.SHORTCUT_FAN),
                                            items: (state.fanItems != null)? state.fanItems : [],
                                            visible: (state.fanItems != null)? true : false,
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
                        ]
                    )
                ),
                ShortcutComponent.componentBottomButton(
                    title: LocaleUtil.getString(context, LocaleUtil.NEXT),
                    clickedFunction: () {
                      geaLog.debug("ShortcutCreatePage: onNextButton ${_textEditController.text}, $_selectedMode, $_selectedTempUnit, $_selectedTemp, $_selectedFan");
                      BlocProvider.of<ShortcutCreateCubit>(context).saveSelectedShortcut(
                          _textEditController.text,
                          _selectedMode,
                          _selectedTempUnit,
                          _selectedTemp,
                          _selectedFan);
                      Navigator.of(context).pushNamed(Routes.SHORTCUT_REVIEW_PAGE);
                    }),
              ]
            )
        )
    );
  }
}