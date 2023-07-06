
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/models/brand_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/commissioning_util.dart';
import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_brand_selection_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/dialog_manager.dart';
import 'package:smarthq_flutter_module/view/common/styles.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/manager/appliance_string_manager.dart';

import 'common_widget/custom_richtext.dart';
import 'common_widget/loading_dialog.dart';

typedef ApplianceCategoryTypeCallBack = Function(ApplianceCategoryType type);

class AddAppliancePage extends StatefulWidget {
  AddAppliancePage({Key? key}) : super(key: key);

  _AddAppliancePage createState() => _AddAppliancePage();
}

class _AddAppliancePage extends State<AddAppliancePage> {

  late LoadingDialog _loadingDialog;

  //temporary array
  final nearbyApplianceName = ['Refrigerator', 'range', 'Microwave'];
  final nearbyApplianceImagePath = [
    ApplianceType.REFRIGERATOR,
    ApplianceType.ELECTRIC_RANGE,
    ApplianceType.MICROWAVE];

  bool _isInitialized = false;
  String _countryCode = CountryUtil.us;

  late List<ApplianceModel> airConditionerList;
  late List<ApplianceModel> cookingList;
  late List<ApplianceModel> dishwasherList;
  late List<ApplianceModel> refrigerationList;
  late List<ApplianceModel> waterProductList;
  late List<ApplianceModel> counterAppliancesList;
  late List<ApplianceModel> laundryList;
  late Map<ApplianceCategoryType, ApplianceCategoryModel> commissioningApplianceCategory;
  late Map<ApplianceCategoryType, FnpApplianceCategoryModel> _commissioningApplianceCategoryFnp;
  late Map<ApplianceCategoryType, ApplianceCategoryModel> _filteredCommissioningApplianceCategory;

  @override
  void initState() {
    geaLog.debug('AddAppliancePage:initState');
    _loadingDialog = LoadingDialog();

    Future.delayed(Duration.zero, () {
      var cubit = BlocProvider.of<BleCommissioningCubit>(context);
      cubit.actionDirectBleGetSearchedBeaconList();
    });

    super.initState();
  }

  @override
  void deactivate() {
    geaLog.debug('AddAppliancePage:deactivate');
    _loadingDialog.close(context);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    geaLog.debug('AddAppliancePage:build');
    ContextUtil.instance.setRoutingContext = context;

    if (!_isInitialized) {
      _isInitialized = true;
      _initApplianceAndCategory(context);
      _initApplianceAndCategoryFnp(context);

      _countryCode = RepositoryProvider.of<NativeStorage>(context).countryCode ?? CountryUtil.us;

    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CommonAppBar(
            title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
            subTitle: LocaleUtil.getString(context, LocaleUtil.BLE_SCANNING_TEXT1),
            leftBtnFunction: () {

              BlocProvider.of<BleCommissioningCubit>(context).actionBleStopScanning();

              BlocProvider.of<CommissioningCubit>(context).initState();
              BlocProvider.of<BleCommissioningCubit>(context).initState();

              Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);

              SystemNavigator.pop(animated: true);
              BlocProvider.of<CommissioningCubit>(context).actionMoveToNativeBackPage();
            },
        ).setNavigationAppBar(context: context),
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Builder(builder: (BuildContext context) {
                    _initFilterApplianceCategories(_countryCode);
                    return ListView(
                      children: <Widget>[
                        Column(
                          children: setBlocListeners(),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
                                bloc: BlocProvider.of<BleCommissioningCubit>(context),
                                buildWhen: (previous, current) {
                                  return (current.stateType == BleCommissioningStateType.SCAN_RESULT) ||
                                      (current.stateType == BleCommissioningStateType.INITIAL);
                                },
                                builder: (context, state) {
                                  return Visibility(
                                    visible: (state.menuState != null) ? (state.menuState == AddApplianceMenuState.SHOW_LIST_MENU) : false,
                                    child: Column(
                                      children: [
                                        BaseComponent.heightSpace(20.h),
                                        //not fixed
                                        componentImageTextSelectListView(
                                            mainTitle: LocaleUtil.getString(context, LocaleUtil.NEARBY)!.toUpperCase(),
                                            applianceName: state.menuDataApplianceNames,
                                            //nearbyApplianceName,
                                            applianceType: state.menuDataApplianceTypes,
                                            buttonTitle: LocaleUtil.getString(context, LocaleUtil.CONNECT)!,
                                            btnFunction: (index) {
                                              BlocProvider.of<BleCommissioningCubit>(context).actionBleStartConnection(index);
                                              return;
                                            },
                                            marginInsets: EdgeInsets.symmetric(horizontal: 16.w)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              BaseComponent.heightSpace(10.h),
                              componentImageTextSelectGridView(
                                mainTitle: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
                                marginInsets: EdgeInsets.symmetric(horizontal: 16.w),
                                userCountryCode: _countryCode,
                              )
                            ],
                          ),
                        ),
                        BaseComponent.heightSpace(20.h)
                      ],
                    );
                  })
                ),
              ],
            ),
          ),
        ),
      ));
  }

  Widget componentImageTextSelectListView({
    required String mainTitle,
    required List<String>? applianceName,
    required List<ApplianceType>? applianceType,
    required String buttonTitle,
    required Function()? btnFunction(int),
    EdgeInsets marginInsets = EdgeInsets.zero
  }) {
    return Container(
      margin: marginInsets,
      child: ExpansionTile(
        title:
          Row(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(mainTitle,
                    style: textStyle_size_16_bold_color_white()),
              ),
              BaseComponent.widthSpace(10.w),
              BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
                bloc: BlocProvider.of<BleCommissioningCubit>(context),
                buildWhen: (previous, current) {
                  return (current.stateType == BleCommissioningStateType.SHOW_SCAN_INDICATOR);
                },
                builder: (context, state) {
                  return Visibility(
                    visible: (state.showNearbyIndicator != null ) ? state.showNearbyIndicator! : false,
                    child: Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),
                      ),
                      height: 12.h,
                      width: 12.w,
                    ),
                  );
                },
              ),
            ],
          ),
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: (applianceName != null) ? applianceName.length : 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CustomRichText.customApplianceListCell(
                        textSpanList: <TextSpan>[
                          TextSpan(
                              text: applianceName![index],
                              style: textStyle_size_16_bold_color_white())
                        ],
                        imagePath: ApplianceStringManager.getImagePath(
                            applianceType?[index],
                            IconSizeType.SMALL),
                        buttonTitle: buttonTitle,
                        btnFunction: () {
                          btnFunction(index);
                        }
                    ),
                    BaseComponent.heightSpace(10.h),
                  ],
                );
              }),
        ],
        initiallyExpanded: true,
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
      ),
    );
  }

  Widget componentImageTextSelectGridView({
    required String mainTitle,
    EdgeInsets marginInsets = EdgeInsets.zero,
    required String userCountryCode}) {

      return Container(
        margin: marginInsets,
        child: Column(
          children: <Widget>[
            BaseComponent.heightSpace(13.h),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(mainTitle.toUpperCase(),
                    style: textStyle_size_16_bold_color_white()),
              ),
            ),
            BaseComponent.heightSpace(13.h),
            new GridView.count(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              children: new List<Widget>.generate(
                  _filteredCommissioningApplianceCategory.length, (index) {
                ApplianceCategoryType key =
                  _filteredCommissioningApplianceCategory.keys.elementAt(index);
                ApplianceCategoryModel value =
                  _filteredCommissioningApplianceCategory[key]!;
                return Component.componentApplianceGridListTile(
                    context: context,
                    title: value.applianceCategoryName,
                    imagePath: ApplianceStringManager.getCategoryImagePath(key),
                    clickedFunction: (){
                      navigateToRouteByCategory(context, key, value, userCountryCode);
                      stopScanAndClearList();
                    });
              }),
            ),
          ],
        ),
      );
  }

  List<Widget> setBlocListeners() {
    return [
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.NETWORK_STATUS_DISCONNECT
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          _loadingDialog.close(context);
          _loadingDialog.show(
              context,
              LocaleUtil.getString(context, LocaleUtil.RETRYING_TO_CONNECT_YOUR_APPLIANCE));

          var bleCubit = BlocProvider.of<BleCommissioningCubit>(context);
          bleCubit.actionRetryPairing();
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.RETRY_PAIRING_RESULT
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {

          if (state.isSuccess == true) {
            _loadingDialog.close(context);

            globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
            stopScanAndClearList();
          }
          else {
            DialogManager().showBleDisconnectedDialog(context: context, onYesPressed: () {});
          }
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SHOW_CLOUD_LOADING
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.COMMUNICATING_WITH_CLOUD));
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.HIDE_CLOUD_LOADING);
        },
        listener: (context, state) {
          _loadingDialog.close(context);
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SHOW_PAIRING_LOADING
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          _loadingDialog.show(context, LocaleUtil.getString(context, LocaleUtil.TRYING_TO_CONNECT_THE_APPLIANCE));
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.HIDE_PAIRING_LOADING);
        },
        listener: (context, state) {
          _loadingDialog.close(context);
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.FAIL_TO_CONNECT
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          DialogManager().showBleFailToConnectDialog(context: context);
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return ((current.stateType == BleCommissioningStateType.START_PAIRING_ACTION1_RESULT) ||
              (current.stateType == BleCommissioningStateType.START_PAIRING_ACTION3_RESULT))
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent);
        },
        listener: (context, state) {
          geaLog.debug('state.isSuccess: ${state.isSuccess}, state.applianceType: ${state.applianceType}');

          if (state.isSuccess == true) {
            globals.subRouteName = Routes.COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE;
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
            stopScanAndClearList();
          }
          else {
            navigateToRoute(context, state.applianceType!, _countryCode);
            stopScanAndClearList();
          }
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return ((current.stateType == BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_LIST_PAGE
              || current.stateType == BleCommissioningStateType.MOVE_TO_GATEWAY_STARTED_PAGE
              || current.stateType == BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_PAGE)
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          if (state.stateType == BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_LIST_PAGE) {
            globals.subRouteName = Routes.GATEWAY_SELECT_GATEWAY_LIST_PAGE;
          }
          else if (state.stateType == BleCommissioningStateType.MOVE_TO_GATEWAY_STARTED_PAGE) {
            globals.subRouteName = Routes.GATEWAY_STARTED_PAGE;
          }
          else if (state.stateType == BleCommissioningStateType.MOVE_TO_SELECT_GATEWAY_PAGE) {
            globals.subRouteName = Routes.GATEWAY_SELECT_GATEWAY_PAGE;
          }
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.GATEWAY_MAIN_NAVIGATOR);
        },
        child: Container(),
      ),
      BlocListener<BleCommissioningCubit, BleCommissioningState>(
        listenWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.MOVE_TO_CATEGORY_PAGE
              && (ModalRoute.of(context) != null && ModalRoute.of(context)!.isCurrent));
        },
        listener: (context, state) {
          navigateToRoute(context, state.applianceType!, _countryCode);
          stopScanAndClearList();
        },
        child: Container(),
      ),
      BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
        bloc: BlocProvider.of<BleCommissioningCubit>(context),
        buildWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SCAN_RESULT) ||
              (current.stateType == BleCommissioningStateType.INITIAL);
        },
        builder: (context, state) {
          return Visibility(
            visible: (state.menuState != null)
                ? (state.menuState == AddApplianceMenuState.SHOW_SCANNING_MENU)
                : true,
            child: Component.componentMainScanLoading(
                title: LocaleUtil.getString(context, LocaleUtil.BLE_SCANNING_TEXT2)!),
          );
        },
      ),
      BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
        bloc: BlocProvider.of<BleCommissioningCubit>(context),
        buildWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SCAN_RESULT) ||
              (current.stateType == BleCommissioningStateType.INITIAL);
        },
        builder: (context, state) {
          return Visibility(
            visible: (state.menuState != null)
                ? (state.menuState == AddApplianceMenuState.SHOW_RESCAN_MENU ||
                state.menuState == AddApplianceMenuState.SHOW_RESCAN_MENU_WITHOUT_BUTTON)
                : false,
            child: Component.componentNotice(
                title: LocaleUtil.getString(context, LocaleUtil.BLE_SCANNING_TEXT3)!,
                showButton: (state.menuState != null)
                    ? (state.menuState == AddApplianceMenuState.SHOW_RESCAN_MENU)
                    : true,
                buttonTitle: LocaleUtil.getString(context, LocaleUtil.RESCAN)!.toUpperCase(),
                marginInsets: EdgeInsets.symmetric(horizontal: 29.w),
                btnFunction: () {
                  BlocProvider.of<BleCommissioningCubit>(context).actionBleStartAllScanning();
                }),
          );
        },
      ),
      BlocBuilder<BleCommissioningCubit, BleCommissioningState>(
        bloc: BlocProvider.of<BleCommissioningCubit>(context),
        buildWhen: (previous, current) {
          return (current.stateType == BleCommissioningStateType.SCAN_RESULT) ||
              (current.stateType == BleCommissioningStateType.INITIAL);
        },
        builder: (context, state) {
          return Visibility(
            visible: (state.menuState != null)
                ? (state.menuState == AddApplianceMenuState.GO_TO_SETTING_MENU)
                : false,
            child: Component.componentNotice(
                title: LocaleUtil.getString(context, LocaleUtil.BLE_SCANNING_TEXT4)!,
                showButton: true,
                buttonTitle: LocaleUtil.getString(context, LocaleUtil.GO_TO_SETTING)!.toUpperCase(),
                marginInsets: EdgeInsets.symmetric(horizontal: 29.w),
                btnFunction: () {
                  CommissioningUtil.openBluetoothSetting(context: context);
                }),
          );
        },
      ),
    ];
  }

  void navigateToRoute(
      BuildContext context,
      ApplianceType applianceType,
      String userCountryCode) {
    geaLog.debug("navigateToRoute: $applianceType");

    if (applianceType == ApplianceType.OVEN) {
      ApplianceCategoryType categoryType = ApplianceErd.getApplianceCategoryType(applianceType);
      ApplianceCategoryModel categoryModel = _filteredCommissioningApplianceCategory[categoryType]!;
      geaLog.debug('ApplianceCategoryModel: $categoryModel');

      Navigator.pushNamed(
        context,
        Routes.BRAND_SELECTION,
        arguments: BrandSelectionArgs(
          userCountryCode,
          SelectedApplianceType(applianceType, categoryType, categoryModel),
        ),
      );
    } else if (applianceType == ApplianceType.REFRIGERATOR) {
      Navigator.of(context).pushNamed(Routes.FRIDGE_SELECT_NAVIGATOR);
    } else if (applianceType == ApplianceType.DUAL_ZONE_WINE_CHILLER) {
      globals.subRouteName = Routes.WINE_CENTER_DESCRIPTION;
      Navigator.of(context).pushNamed(Routes.WINE_CENTER_MAIN_NAVIGATOR);
    } else if (applianceType == ApplianceType.BEVERAGE_CENTER) {
      globals.subRouteName = Routes.BEVERAGE_CENTER_DESCRIPTION;
      Navigator.of(context).pushNamed(Routes.BEVERAGE_CENTER_MAIN_NAVIGATOR);
    } else if (applianceType == ApplianceType.UNDER_COUNTER_ICE_MAKER) {
      globals.subRouteName = Routes.UNDER_COUNTER_ICE_MAKER_DESCRIPTION;
      Navigator.of(context).pushNamed(Routes.UNDER_COUNTER_ICE_MAKER_MAIN_NAVIGATOR);
    } else if (applianceType == ApplianceType.ESPRESSO_COFFEE_MAKER) {
      Navigator.of(context).pushNamed(Routes.ESPRESSO_SELECT_NAVIGATOR);
    } else if (applianceType == ApplianceType.HOOD) {
      Navigator.of(context).pushNamed(Routes.HOOD_MAIN_NAVIGATOR);
    }
    else if (applianceType == ApplianceType.ELECTRIC_COOKTOP ||
             applianceType == ApplianceType.GAS_COOKTOP ||
             applianceType == ApplianceType.COOKTOP_STANDALONE) {
      Navigator.of(context).pushNamed(Routes.COOKTOP_MAIN_NAVIGATOR);
    } else if (applianceType == ApplianceType.COMBINATION_WASHER_DRYER) {
      globals.subRouteName = Routes.COMBI_DESCRIPTION1;
      Navigator.of(context).pushNamed(Routes.COMBI_MAIN_NAVIGATOR);
    }
    else if (applianceType == ApplianceType.COFFEE_BREWER ||
             applianceType == ApplianceType.GRIND_BREW) {
      Navigator.of(context).pushNamed(Routes.BREW_APPLIANCE_SELECTION_PAGE);
    }
    else if (applianceType == ApplianceType.STAND_MIXER) {
      Navigator.of(context).pushNamed(Routes.STAND_MIXER_MAIN_NAVIGATOR);
    }
    else {
      ApplianceCategoryType categoryType = ApplianceErd.getApplianceCategoryType(applianceType);
      ApplianceCategoryModel categoryModel = _filteredCommissioningApplianceCategory[categoryType]!;
      geaLog.debug('ApplianceCategoryModel: $categoryModel');

      navigateToRouteByCategory(context, categoryType, categoryModel, userCountryCode);
    }
  }

  void navigateToRouteByCategory(
      BuildContext context,
      ApplianceCategoryType categoryType,
      ApplianceCategoryModel categoryModel,
      String userCountryCode) {

    if (CountryUtil.fnpOnlyCountries().contains(userCountryCode)) {
      // Show brand selection for countries that only have F&P. For all other
      // countries show brand selection selectively.
      Navigator.pushNamed(
        context,
        Routes.BRAND_SELECTION,
        arguments: BrandSelectionArgs(
          userCountryCode,
          SelectedCategoryType(categoryType, categoryModel),
        ),
      );
    } else if (categoryType == ApplianceCategoryType.LAUNDRY) {
      Navigator.of(context).pushNamed(Routes.LAUNDRY_ROUTE_PATH);
    } else if (categoryType == ApplianceCategoryType.DISHWASHER) {
      if (CountryUtil.allFnpCountries.contains(userCountryCode)) {
        Navigator.pushNamed(
          context,
          Routes.BRAND_SELECTION,
          arguments: BrandSelectionArgs(
            userCountryCode,
            SelectedCategoryType(categoryType, categoryModel),
          ),
        );
      } else {
        Navigator.of(context).pushNamed(Routes.DISHWASHER_MAIN_NAVIGATOR);
      }
    } else if (categoryType == ApplianceCategoryType.COUNTERTOP_APPLIANCES) {
      Navigator.of(context).pushNamed(Routes.COUNTER_TOP_APPLIANCE_SELECTION_PAGE);
    } else if (categoryType == ApplianceCategoryType.COOKING) {
      if (CountryUtil.allFnpCountries.contains(userCountryCode)) {
        Navigator.pushNamed(
          context,
          Routes.BRAND_SELECTION,
          arguments: BrandSelectionArgs(
            userCountryCode,
            SelectedCategoryType(categoryType, categoryModel),
          ),
        );
      } else {
        Navigator.of(context).pushNamed(Routes.COOKING_APPLIANCE_SELECTION_PAGE);
      }
    } else if (categoryType == ApplianceCategoryType.AIR_CONDITIONER) {
      Navigator.of(context).pushNamed(Routes.FLAVOURLY_MAIN_NAVIGATOR);
    } else if (categoryType == ApplianceCategoryType.WATER_PRODUCTS) {
      Navigator.of(context).pushNamed(Routes.WATER_PRODUCTS_MAIN_NAVIGATOR);
    } else if (categoryType == ApplianceCategoryType.REFRIGERATION) {
      if (CountryUtil.allFnpCountries.contains(userCountryCode)) {
        Navigator.pushNamed(
          context,
          Routes.BRAND_SELECTION,
          arguments: BrandSelectionArgs(
            userCountryCode,
            SelectedCategoryType(categoryType, categoryModel),
          ),
        );
      } else {
        Navigator.of(context).pushNamed(Routes.REFRIGERATOR_SELECT_NAVIGATOR);
      }
    } else if (categoryType == ApplianceCategoryType.GATEWAY) {
      if (BuildEnvironment.hasFeature(featureType: EnvFeatureType.gateway)) {
        BlocProvider.of<BleCommissioningCubit>(context).checkGatewayStartScreen();
      }
    } else {
      Navigator.of(context).pushNamed(Routes.SELECT_APPLIANCE_PAGE, arguments: categoryModel);
    }
  }

  void stopScanAndClearList() {
    BlocProvider.of<BleCommissioningCubit>(context).actionBleStopScanning();
    BlocProvider.of<BleCommissioningCubit>(context).actionClearScanningList();
  }

  /// Filter Appliance Categories by user location and initialize
  /// [_filteredCommissioningApplianceCategory]. For US/CA all categories are shown.
  void _initFilterApplianceCategories(
    String userCountryCode,
  ) {
    if (CountryUtil.allGeCountries.contains(userCountryCode)) {
      // For countries with GE appliances, show all the appliance categories
      _filteredCommissioningApplianceCategory = commissioningApplianceCategory;
    } else {
      // For countries with F&P appliances only, filter categories
      final Map<ApplianceCategoryType, ApplianceCategoryModel> filteredApplianceCategories = Map();
      // Start filtering by location
      for (var applianceCategoryType in _commissioningApplianceCategoryFnp.keys) {
        FnpApplianceCategoryModel applianceCategory = _commissioningApplianceCategoryFnp[applianceCategoryType]!;
        if (applianceCategory.availableMarkets.contains(userCountryCode)) {
          List<FnpApplianceModel> filteredApplianceList = List.empty(growable: true);
          // Filter appliance list inside category
          for (var applianceModel in applianceCategory.applianceModelList!) {
            FnpApplianceModel fnpApplianceModel = applianceModel as FnpApplianceModel;
            if (fnpApplianceModel.availableMarkets.contains(userCountryCode)) {
              filteredApplianceList.add(fnpApplianceModel);
            }
          }

          filteredApplianceCategories[applianceCategoryType] = FnpApplianceCategoryModel(
            applianceCategory.applianceCategoryName,
            applianceCategory.commissioningImagePath,
            filteredApplianceList,
            applianceCategory.availableMarkets,
          );
        }
      }

      _filteredCommissioningApplianceCategory = filteredApplianceCategories;
    }
  }

  void _initApplianceAndCategory(BuildContext context) {
    this.airConditionerList = [
      ApplianceModel(ApplianceType.AIR_CONDITIONER, LocaleUtil.getString(context, LocaleUtil.WINDOW_AIR_CONDITIONER), false),
      ApplianceModel(ApplianceType.PORTABLE_AIR_CONDITIONER, LocaleUtil.getString(context, LocaleUtil.PORTABLE_AIR_CONDITIONER), false),
      ApplianceModel(ApplianceType.SPLIT_AIR_CONDITIONER, LocaleUtil.getString(context, LocaleUtil.DUCTLESS_AIR_CONDITIONER), true),
      ApplianceModel(ApplianceType.DEHUMIDIFIER, LocaleUtil.getString(context, LocaleUtil.DEHUMIDIFIER), false)
    ];

    this.cookingList = [
      ApplianceModel(ApplianceType.ADVANTIUM, LocaleUtil.getString(context, LocaleUtil.ADVANTIUM), false),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_KNOB), true),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TOUCH_PAD), true),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.RANGE_OR_WALL_OVEN), true),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.RANGE), false),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.RANGE_KNOB), false),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.PRO_RANGE_2_4), false),
      ApplianceModel(ApplianceType.OVEN, LocaleUtil.getString(context, LocaleUtil.PRO_RANGE_7_0), false),
      ApplianceModel(ApplianceType.HOOD, LocaleUtil.getString(context, LocaleUtil.HOOD), false),
      ApplianceModel(ApplianceType.MICROWAVE, LocaleUtil.getString(context, LocaleUtil.MICROWAVE), false),
      ApplianceModel(ApplianceType.COOKTOP_STANDALONE, LocaleUtil.getString(context, LocaleUtil.INDUCTION_COOKTOP), false),
      ApplianceModel(ApplianceType.PIZZA_OVEN, LocaleUtil.getString(context, LocaleUtil.HEARTH_OVEN), false),
      ApplianceModel(ApplianceType.GAS_COOKTOP, LocaleUtil.getString(context, LocaleUtil.GAS_COOKTOP), false),
      ApplianceModel(ApplianceType.GAS_COOKTOP, LocaleUtil.getString(context, LocaleUtil.HAVE_CONNECT_PLUS), false)
    ];

    this.dishwasherList = [
      ApplianceModel(ApplianceType.DISHWASHER, LocaleUtil.getString(context, LocaleUtil.DISHWASHER), false)
    ];

    this.refrigerationList = [
      ApplianceModel(ApplianceType.REFRIGERATOR, LocaleUtil.getString(context, LocaleUtil.FRIDGE), false),
      ApplianceModel(ApplianceType.DUAL_ZONE_WINE_CHILLER, LocaleUtil.getString(context, LocaleUtil.WINE_CENTER), true),
      ApplianceModel(ApplianceType.BEVERAGE_CENTER, LocaleUtil.getString(context, LocaleUtil.BEVERAGE_CENTER), true),
      ApplianceModel(ApplianceType.UNDER_COUNTER_ICE_MAKER, LocaleUtil.getString(context, LocaleUtil.UNDER_COUNTER_ICE_MAKER), false),
    ];

    this.waterProductList = [
      ApplianceModel(ApplianceType.WATER_HEATER, LocaleUtil.getString(context, LocaleUtil.WATER_HEATER), false),
      ApplianceModel(ApplianceType.POE_WATER_FILTER, LocaleUtil.getString(context, LocaleUtil.WHOLE_HOME_WATER_FILTER), false),
      ApplianceModel(ApplianceType.WATER_SOFTENER, LocaleUtil.getString(context, LocaleUtil.HOUSEHOLD_WATER_SOFTENER), false)
    ];

    this.counterAppliancesList = [
      ApplianceModel(ApplianceType.COFFEE_BREWER, LocaleUtil.getString(context, LocaleUtil.COFFEE_MAKER), false),
      ApplianceModel(ApplianceType.OPAL_ICE_MAKER, LocaleUtil.getString(context, LocaleUtil.OPAL_NUGGET_ICE_MAKER), false),
      ApplianceModel(ApplianceType.ESPRESSO_COFFEE_MAKER, LocaleUtil.getString(context, LocaleUtil.ESPRESSO), false),
      ApplianceModel(ApplianceType.TOASTER_OVEN, LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN), false),
      ApplianceModel(ApplianceType.GRIND_BREW, LocaleUtil.getString(context, LocaleUtil.GRIND_BREW), false),
    ];

    this.laundryList = [
      ApplianceModel(ApplianceType.LAUNDRY_WASHER, LocaleUtil.getString(context, LocaleUtil.WASHER), false),
      ApplianceModel(ApplianceType.LAUNDRY_WASHER, LocaleUtil.getString(context, LocaleUtil.WASHER_LCD_DISPLAY), true),
      ApplianceModel(ApplianceType.LAUNDRY_DRYER, LocaleUtil.getString(context, LocaleUtil.DRYER), false),
      ApplianceModel(ApplianceType.LAUNDRY_DRYER, LocaleUtil.getString(context, LocaleUtil.DRYER_LCD_DISPLAY), true),
      ApplianceModel(ApplianceType.COMBINATION_WASHER_DRYER, LocaleUtil.getString(context, LocaleUtil.COMBO), true)
    ];

    this.commissioningApplianceCategory = {
      ApplianceCategoryType.AIR_CONDITIONER: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.AIR_CONDITIONER)!, ImagePath.CATEGORY_AIR_CONDITIONER_PATH, this.airConditionerList),
      ApplianceCategoryType.COOKING: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.COOKING)!, ImagePath.CATEGORY_COOKING_PATH, this.cookingList),
      ApplianceCategoryType.DISHWASHER: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.DISHWASHER)!, ImagePath.CATEGORY_DISHWASHING_PATH, this.dishwasherList),
      ApplianceCategoryType.REFRIGERATION: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.REFRIGERATION)!, ImagePath.CATEGORY_REFRIGERATION_PATH, this.refrigerationList),
      ApplianceCategoryType.WATER_PRODUCTS: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.WATER_PRODUCTS)!, ImagePath.CATEGORY_DISHWASHING_PATH, this.waterProductList),
      ApplianceCategoryType.COUNTERTOP_APPLIANCES: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.COUNTERTOP_APPLIANCES)!, ImagePath.CATEGORY_COUNTERTOP_PATH, this.counterAppliancesList),
      ApplianceCategoryType.LAUNDRY: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.LAUNDRY)!, ImagePath.CATEGORY_LAUNDRY_PATH, this.laundryList),
      if (BuildEnvironment.hasFeature(featureType: EnvFeatureType.gateway))
        ApplianceCategoryType.GATEWAY: ApplianceCategoryModel(LocaleUtil.getString(context, LocaleUtil.GATEWAY)!, ImagePath.CATEGORY_GATEWAY_PATH, null),

    };
  }

  void _initApplianceAndCategoryFnp(BuildContext context) {
    this._commissioningApplianceCategoryFnp = {
      ApplianceCategoryType.REFRIGERATION: FnpApplianceCategoryModel(
        LocaleUtil.getString(context, LocaleUtil.REFRIGERATION)!,
        ImagePath.CATEGORY_REFRIGERATION_PATH,
        [],
        CountryUtil.allFnpCountries,
      ),
      ApplianceCategoryType.COOKING: FnpApplianceCategoryModel(
        LocaleUtil.getString(context, LocaleUtil.COOKING)!,
        ImagePath.CATEGORY_COOKING_PATH,
        [],
        CountryUtil.allFnpCountries,
      ),
      ApplianceCategoryType.DISHWASHER: FnpApplianceCategoryModel(
        LocaleUtil.getString(context, LocaleUtil.DISHWASHER)!,
        ImagePath.CATEGORY_DISHWASHING_PATH,
        [],
        CountryUtil.allFnpCountries,
      ),
      ApplianceCategoryType.LAUNDRY: FnpApplianceCategoryModel(
        LocaleUtil.getString(context, LocaleUtil.LAUNDRY)!,
        ImagePath.CATEGORY_LAUNDRY_PATH,
        [],
        [
          CountryUtil.au,
          CountryUtil.nz,
          CountryUtil.sg,
          CountryUtil.gb,
          CountryUtil.ie,
        ],
      ),
      ApplianceCategoryType.AIR_CONDITIONER: FnpApplianceCategoryModel(
        LocaleUtil.getString(context, LocaleUtil.AIR_CONDITIONER)!,
        ImagePath.CATEGORY_AIR_CONDITIONER_PATH,
        [
          FnpApplianceModel(
            ApplianceType.SPLIT_AIR_CONDITIONER,
            LocaleUtil.getString(context, LocaleUtil.AIR_CONDITIONER),
            false,
            [CountryUtil.au, CountryUtil.nz],
          ),
        ],
        [CountryUtil.au, CountryUtil.nz],
      ),
    };
  }

}
