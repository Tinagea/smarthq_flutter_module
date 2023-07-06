import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/client_mysmarthq_entity/device_list_response.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';

enum ApplianceCategoryType {
  AIR_CONDITIONER,
  COOKING,
  DISHWASHER,
  DISH_DRAWER,
  REFRIGERATION,
  WATER_PRODUCTS,
  COUNTERTOP_APPLIANCES,
  LAUNDRY,
  GATEWAY
}

enum ApplianceType {
  WATER_HEATER,
  LAUNDRY_DRYER,
  LAUNDRY_WASHER,
  REFRIGERATOR,
  MICROWAVE,
  ADVANTIUM,
  DISHWASHER,
  DISH_DRAWER,
  OVEN,
  ELECTRIC_RANGE,
  GAS_RANGE,
  AIR_CONDITIONER,
  ELECTRIC_COOKTOP,
  PIZZA_OVEN,
  GAS_COOKTOP,
  SPLIT_AIR_CONDITIONER,
  HOOD,
  POE_WATER_FILTER,
  COOKTOP_STANDALONE,
  DELIVERY_BOX,
  ZONELINE,
  WATER_SOFTENER,
  PORTABLE_AIR_CONDITIONER,
  COMBINATION_WASHER_DRYER,
  DUAL_ZONE_WINE_CHILLER,
  BEVERAGE_CENTER,
  COFFEE_BREWER,
  OPAL_ICE_MAKER,
  IN_HOME_GROWER,
  DEHUMIDIFIER,
  UNDER_COUNTER_ICE_MAKER,
  TOASTER_OVEN,
  BUILT_IN_AC,
  ESPRESSO_COFFEE_MAKER,
  GRIND_BREW,
  GATEWAY,
  STAND_MIXER,
  UNDEFINED,
  APPL
}

enum ApplianceBrandTypes {
  brandTypeMonogram,
  brandTypeCafe,
  brandTypeProfile,
  brandTypeGea,
  brandTypeHaier,
  brandTypeMabe,
  brandTypeFisherAndPaykel,
  brandTypeFpaHaier,
}

extension ApplianceBrandTypesExtension on ApplianceBrandTypes {
  String get stringValue {
    switch (this) {
      case ApplianceBrandTypes.brandTypeMonogram:
        return "monogram";

      case ApplianceBrandTypes.brandTypeCafe:
        return "cafe";

      case ApplianceBrandTypes.brandTypeProfile:
        return "profile";

      case ApplianceBrandTypes.brandTypeGea:
        return "gea";

      case ApplianceBrandTypes.brandTypeHaier:
        return "haier";

      case ApplianceBrandTypes.brandTypeMabe:
        return "mabe";

      case ApplianceBrandTypes.brandTypeFisherAndPaykel:
        return "fisher and paykel";

      case ApplianceBrandTypes.brandTypeFpaHaier:
        return "fpa haier";
    }
  }

  static ApplianceBrandTypes fromStringValue(String? stringValue) {
    if (stringValue == null) {
      return ApplianceBrandTypes.brandTypeGea;
    }
    return ApplianceBrandTypes.values.firstWhere((e) => e.stringValue == stringValue);
  }
}

// ApplianceSubType is used to move to the native(iOS, Android) commissioning page.
// Therefore, there are not all appliance types.
// ApplianceSubType should be reduced if native commissioning changes to Flutter in the future.
enum ApplianceSubType {
  windowAirConditioner,
  portableAirConditioner,
  ductlessAirConditioner,
  dehumidifier,
  advantium,
  wallOvenKnob,
  wallOvenTouchPad,
  rangeOrWallOvenLCDDisplay,
  range,
  rangeKnob,
  proRange24,
  proRange70,
  microwave,
  inductionCooktop,
  hearthOven,
  gasCooktop,
  dishwasher,
  wineCenter,
  toasterOven,
  beverageCenter,
  underCounterIceMaker,
  waterHeater,
  wholeHomeWaterFilter,
  householdWaterSoftener,
  coffeeMaker,
  opalNuggetIceMaker,
  fnpOvenTouchscreenModel,
  fnpRangesTouchscreenModel,
  fnpDishDrawerTopControlPanel,
  fnpDishDrawerFrontControlPanel,
  fnpDryerLcdOrWasherLcd,
  fnpWasherLcd,
  fnpWasherLed,
  fnpDryerLed,
  fnpIntegratedColumnRefrigeratorOrFreezer,
  fnpIntegratedColumnWineCabinet,
  fnpActiveSmartRefrigeratorFreezer,
  fnpQuadDoor,
}
extension ApplianceSubTypeExtension on ApplianceSubType {
  String get value {
    switch (this) {
      case ApplianceSubType.windowAirConditioner:
        return "windowAirConditioner";
      case ApplianceSubType.portableAirConditioner:
        return "portableAirConditioner";
      case ApplianceSubType.ductlessAirConditioner:
        return "ductlessAirConditioner";
      case ApplianceSubType.dehumidifier:
        return "dehumidifier";
      case ApplianceSubType.advantium:
        return "advantium";
      case ApplianceSubType.wallOvenKnob:
        return "wallOvenKnob";
      case ApplianceSubType.wallOvenTouchPad:
        return "wallOvenTouchPad";
      case ApplianceSubType.rangeOrWallOvenLCDDisplay:
        return "rangeOrWallOvenLCDDisplay";
      case ApplianceSubType.range:
        return "range";
      case ApplianceSubType.rangeKnob:
        return "rangeKnob";
      case ApplianceSubType.proRange24:
        return "proRange24";
      case ApplianceSubType.proRange70:
        return "proRange70";
      case ApplianceSubType.microwave:
        return "microwave";
      case ApplianceSubType.inductionCooktop:
        return "inductionCooktop";
      case ApplianceSubType.hearthOven:
        return "hearthOven";
      case ApplianceSubType.gasCooktop:
        return "gasCooktop";
      case ApplianceSubType.dishwasher:
        return "dishwasher";
      case ApplianceSubType.wineCenter:
        return "wineCenter";
      case ApplianceSubType.beverageCenter:
        return "beverageCenter";
      case ApplianceSubType.underCounterIceMaker:
        return "underCounterIceMaker";
      case ApplianceSubType.waterHeater:
        return "waterHeater";
      case ApplianceSubType.wholeHomeWaterFilter:
        return "wholeHomeWaterFilter";
      case ApplianceSubType.householdWaterSoftener:
        return "householdWaterSoftener";
      case ApplianceSubType.coffeeMaker:
        return "coffeeMaker";
      case ApplianceSubType.opalNuggetIceMaker:
        return "opalNuggetIceMaker";
      case ApplianceSubType.fnpOvenTouchscreenModel:
        return "fnpOvenTouchscreenModel";
      case ApplianceSubType.fnpRangesTouchscreenModel:
        return "fnpRangesTouchscreenModel";
      case ApplianceSubType.fnpDishDrawerTopControlPanel:
        return "fnpDishDrawerTopControlPanel";
      case ApplianceSubType.fnpDishDrawerFrontControlPanel:
        return "fnpDishDrawerFrontControlPanel";
      case ApplianceSubType.fnpDryerLcdOrWasherLcd:
        return "fnpDryerLcdOrWasherLcd";
      case ApplianceSubType.fnpWasherLcd:
        return "fnpWasherLcd";
      case ApplianceSubType.fnpWasherLed:
        return "fnpWasherLed";
      case ApplianceSubType.fnpDryerLed:
        return "fnpDryerLed";
      case ApplianceSubType.fnpIntegratedColumnRefrigeratorOrFreezer:
        return "fnpIntegratedColumnRefrigeratorOrFreezer";
      case ApplianceSubType.fnpIntegratedColumnWineCabinet:
        return "fnpIntegratedColumnWineCabinet";
      case ApplianceSubType.fnpActiveSmartRefrigeratorFreezer:
        return "fnpActiveSmartRefrigeratorFreezer";
      case ApplianceSubType.fnpQuadDoor:
        return "fnpQuadDoor";
      case ApplianceSubType.toasterOven:
        return "toasterOven";
    }
  }
}

/// The type strings are from cloud, no need to be translated.
/// The strings' formats are from cloud, don't change it.
abstract class ApplianceTypes {
  static const waterHeater = "Water Heater";
  static const clothDryer = "Clothes Dryer";
  static const clothWasher = "Clothes Washer";
  static const refrigerator = "Refrigerator";
  static const microwave = "Microwave";
  static const advantium = "Advantium";
  static const dishwasher = "Dishwasher";
  static const fpDishDrawer = "FP DishDrawer";
  static const oven = "Oven";
  static const electricRange = "Electric Range";
  static const electric = "Electric Cooktop";
  static const gasRange = "Gas Range";
  static const airConditioner = "Air Conditioner";
  static const inductionCooktop = "Induction Cooktop";
  static const pizzaOven = "Pizza Oven";
  static const gasCooktop = "Gas Cooktop";
  static const hood = "Hood";
  static const waterFilter = "Water Filter";
  static const splitAirConditioner = "Split Air Conditioner";
  static const deliveryBox = "Delivery Box";
  static const zoneline = "Zoneline";
  static const waterSoftener = "Water Softener";
  static const portableAc = "Portable AC";
  static const throughWallAc = "Through Wall AC";
  static const combinationWasherDryer = "Combination Washer Dryer";
  static const dualZoneWineChiller = "Dual Zone Wine Chiller";
  static const beverageCenter = "Beverage Center";
  static const coffeeBrewer = "Coffee Brewer";
  static const opalNuggetIceMaker = "Opal Nugget Ice Maker";
  static const toasterOven = "Toaster Oven";
  static const inHomeGrower = "In-Home Grower";
  static const dehumidifier = "Dehumidifier";
  static const underCounterIceMaker = "Under Counter Ice Maker";
  static const espressoCoffeeMaker = "Espresso Coffee Maker";
  static const standMixer = "Stand Mixer";
  static const appl = "Appl";
  static const unknown = "Unknown";
}

class ApplianceCategoryModel {
  String applianceCategoryName;
  String commissioningImagePath;
  List<ApplianceModel>? applianceModelList;

  ApplianceCategoryModel(this.applianceCategoryName, this.commissioningImagePath, this.applianceModelList);
}

class FnpApplianceCategoryModel extends ApplianceCategoryModel {
  final List<String> availableMarkets;

  FnpApplianceCategoryModel(
      applianceCategoryName,
      commissioningImagePath,
      List<FnpApplianceModel> applianceModelList,
      this.availableMarkets,
      ) : super(applianceCategoryName, commissioningImagePath, applianceModelList);
}

class ApplianceModel {
  ApplianceType applianceType;
  String? applianceName;
  bool isInformation;

  ApplianceModel(this.applianceType, this.applianceName, this.isInformation);
}

class FnpApplianceModel extends ApplianceModel {
  final List<String> availableMarkets;

  FnpApplianceModel(
    ApplianceType applianceType,
    String? applianceName,
    bool isInformation,
    this.availableMarkets,
  ) : super(applianceType, applianceName, isInformation);
}

enum AddApplianceMenuState {
  SHOW_SCANNING_MENU,
  GO_TO_SETTING_MENU,
  SHOW_LIST_MENU,
  SHOW_RESCAN_MENU,
  SHOW_RESCAN_MENU_WITHOUT_BUTTON,
}

class ApplianceErd {
  static const WATER_HEATER              = "00";
  static const LAUNDRY_DRYER             = "01";
  static const LAUNDRY_WASHER            = "02";
  static const REFRIGERATOR              = "03";
  static const MICROWAVE                 = "04";
  static const ADVANTIUM                 = "05";
  static const DISHWASHER                = "06";
  static const OVEN                      = "07";
  static const ELECTRIC_RANGE            = "08";
  static const GAS_RANGE                 = "09";
  static const AIR_CONDITIONER           = "0a";
  static const ELECTRIC_COOKTOP          = "0b";
  static const PIZZA_OVEN                = "0c";
  static const GAS_COOKTOP               = "0d";
  static const SPLIT_AIR_CONDITIONER     = "0e";
  static const HOOD                      = "0f";
  static const POE_WATER_FILTER          = "10";
  static const COOKTOP_STANDALONE        = "11";
  static const DELIVERY_BOX              = "12";
  static const ZONELINE                  = "14";
  static const WATER_SOFTENER            = "15";
  static const PORTABLE_AIR_CONDITIONER  = "16";
  static const COMBINATION_WASHER_DRYER  = "17";
  static const DUAL_ZONE_WINE_CHILLER    = "18";
  static const BEVERAGE_CENTER           = "19";
  static const COFFEE_BREWER             = "1a";
  static const OPAL_ICE_MAKER            = "1b";
  static const IN_HOME_GROWER            = "1c";
  static const DEHUMIDIFIER              = "1d";
  static const UNDER_COUNTER_ICE_MAKER   = "1e";
  static const BUILT_IN_AC               = "1f";
  static const DISH_DRAWER               = "20";
  static const ESPRESSO                  = "21";
  static const TOASTER_OVEN              = "22";
  static const GATEWAY                   = "25";
  static const STAND_MIXER               = "26";
  static const UNDEFINED                 = "ff";
  static const APPL                      = "APPL";
  
  static ApplianceType getApplianceType(String applianceErd) {
    ApplianceType type = ApplianceType.UNDEFINED;
    var applianceErdLower = applianceErd.toLowerCase();

    if (applianceErdLower == ApplianceErd.WATER_HEATER) {
      type = ApplianceType.WATER_HEATER;
    }
    else if (applianceErdLower == ApplianceErd.LAUNDRY_DRYER) {
      type = ApplianceType.LAUNDRY_DRYER;
    }
    else if (applianceErdLower == ApplianceErd.LAUNDRY_WASHER) {
      type = ApplianceType.LAUNDRY_WASHER;
    }
    else if (applianceErdLower == ApplianceErd.REFRIGERATOR) {
      type = ApplianceType.REFRIGERATOR;
    }
    else if (applianceErdLower == ApplianceErd.MICROWAVE) {
      type = ApplianceType.MICROWAVE;
    }
    else if (applianceErdLower == ApplianceErd.ADVANTIUM) {
      type = ApplianceType.ADVANTIUM;
    }
    else if (applianceErdLower == ApplianceErd.DISHWASHER) {
      type = ApplianceType.DISHWASHER;
    }
    else if (applianceErdLower == ApplianceErd.OVEN) {
      type = ApplianceType.OVEN;
    }
    else if (applianceErdLower == ApplianceErd.ELECTRIC_RANGE) {
      type = ApplianceType.ELECTRIC_RANGE;
    }
    else if (applianceErdLower == ApplianceErd.GAS_RANGE) {
      type = ApplianceType.GAS_RANGE;
    }
    else if (applianceErdLower == ApplianceErd.AIR_CONDITIONER) {
      type = ApplianceType.AIR_CONDITIONER;
    }
    else if (applianceErdLower == ApplianceErd.ELECTRIC_COOKTOP) {
      type = ApplianceType.ELECTRIC_COOKTOP;
    }
    else if (applianceErdLower == ApplianceErd.PIZZA_OVEN) {
      type = ApplianceType.PIZZA_OVEN;
    }
    else if (applianceErdLower == ApplianceErd.GAS_COOKTOP) {
      type = ApplianceType.GAS_COOKTOP;
    }
    else if (applianceErdLower == ApplianceErd.SPLIT_AIR_CONDITIONER) {
      type = ApplianceType.SPLIT_AIR_CONDITIONER;
    }
    else if (applianceErdLower == ApplianceErd.HOOD) {
      type = ApplianceType.HOOD;
    }
    else if (applianceErdLower == ApplianceErd.POE_WATER_FILTER) {
      type = ApplianceType.POE_WATER_FILTER;
    }
    else if (applianceErdLower == ApplianceErd.COOKTOP_STANDALONE) {
      type = ApplianceType.COOKTOP_STANDALONE;
    }
    else if (applianceErdLower == ApplianceErd.DELIVERY_BOX) {
      type = ApplianceType.DELIVERY_BOX;
    }
    else if (applianceErdLower == ApplianceErd.ZONELINE) {
      type = ApplianceType.ZONELINE;
    }
    else if (applianceErdLower == ApplianceErd.WATER_SOFTENER) {
      type = ApplianceType.WATER_SOFTENER;
    }
    else if (applianceErdLower == ApplianceErd.PORTABLE_AIR_CONDITIONER) {
      type = ApplianceType.PORTABLE_AIR_CONDITIONER;
    }
    else if (applianceErdLower == ApplianceErd.COMBINATION_WASHER_DRYER) {
      type = ApplianceType.COMBINATION_WASHER_DRYER;
    }
    else if (applianceErdLower == ApplianceErd.DUAL_ZONE_WINE_CHILLER) {
      type = ApplianceType.DUAL_ZONE_WINE_CHILLER;
    }
    else if (applianceErdLower == ApplianceErd.BEVERAGE_CENTER) {
      type = ApplianceType.BEVERAGE_CENTER;
    }
    else if (applianceErdLower == ApplianceErd.COFFEE_BREWER) {
      type = ApplianceType.COFFEE_BREWER;
    }
    else if (applianceErdLower == ApplianceErd.OPAL_ICE_MAKER) {
      type = ApplianceType.OPAL_ICE_MAKER;
    }
    else if (applianceErdLower == ApplianceErd.IN_HOME_GROWER) {
      type = ApplianceType.IN_HOME_GROWER;
    }
    else if (applianceErdLower == ApplianceErd.DEHUMIDIFIER) {
      type = ApplianceType.DEHUMIDIFIER;
    }
    else if (applianceErdLower == ApplianceErd.UNDER_COUNTER_ICE_MAKER) {
      type = ApplianceType.UNDER_COUNTER_ICE_MAKER;
    }
    else if (applianceErdLower == ApplianceErd.TOASTER_OVEN) {
      type = ApplianceType.TOASTER_OVEN;
    }
    else if (applianceErdLower == ApplianceErd.BUILT_IN_AC) {
      type = ApplianceType.BUILT_IN_AC;
    }
    else if (applianceErdLower == ApplianceErd.DISH_DRAWER) {
      type = ApplianceType.DISH_DRAWER;
    }
    else if (applianceErdLower == ApplianceErd.ESPRESSO) {
      type = ApplianceType.ESPRESSO_COFFEE_MAKER;
    }
    else if (applianceErdLower == ApplianceErd.GATEWAY) {
      type = ApplianceType.GATEWAY;
    }
    else if (applianceErdLower == ApplianceErd.STAND_MIXER) {
      type = ApplianceType.STAND_MIXER;
    }
    else if (applianceErdLower == ApplianceErd.UNDEFINED) {
      type = ApplianceType.UNDEFINED;
    }
    else if (applianceErd.toUpperCase() == ApplianceErd.APPL) {
      type = ApplianceType.APPL;
    }

    return type;
  }

  static String getApplianceName(String applianceErd, BuildContext context) {
    geaLog.debug('getApplianceName: $applianceErd');
    var name = LocaleUtil.getString(context, LocaleUtil.APPLIANCE)!;
    var applianceErdLower = applianceErd.toLowerCase();

    if (applianceErdLower == ApplianceErd.WATER_HEATER) {
      name = LocaleUtil.getString(context, LocaleUtil.WATER_HEATER)!;
    }
    else if (applianceErdLower == ApplianceErd.LAUNDRY_DRYER) {
      name = LocaleUtil.getString(context, LocaleUtil.DRYER)!;
    }
    else if (applianceErdLower == ApplianceErd.LAUNDRY_WASHER) {
      name = LocaleUtil.getString(context, LocaleUtil.WASHER)!;
    }
    else if (applianceErdLower == ApplianceErd.REFRIGERATOR) {
      name = LocaleUtil.getString(context, LocaleUtil.FRIDGE)!;
    }
    else if (applianceErdLower == ApplianceErd.MICROWAVE) {
      name = LocaleUtil.getString(context, LocaleUtil.MICROWAVE)!;
    }
    else if (applianceErdLower == ApplianceErd.ADVANTIUM) {
      name = LocaleUtil.getString(context, LocaleUtil.ADVANTIUM)!;
    }
    else if (applianceErdLower == ApplianceErd.DISHWASHER) {
      name = LocaleUtil.getString(context, LocaleUtil.DISHWASHER)!;
    }
    else if (applianceErdLower == ApplianceErd.OVEN) {
      name = LocaleUtil.getString(context, LocaleUtil.OVEN)!;
    }
    else if (applianceErdLower == ApplianceErd.ELECTRIC_RANGE) {
      name = LocaleUtil.getString(context, LocaleUtil.ELECTRIC_RANGE)!;
    }
    else if (applianceErdLower == ApplianceErd.GAS_RANGE) {
      name = LocaleUtil.getString(context, LocaleUtil.GAS_RANGE)!;
    }
    else if (applianceErdLower == ApplianceErd.AIR_CONDITIONER) {
      name = LocaleUtil.getString(context, LocaleUtil.AIR_CONDITIONER)!;
    }
    else if (applianceErdLower == ApplianceErd.ELECTRIC_COOKTOP) {
      name = LocaleUtil.getString(context, LocaleUtil.ELECTRIC_COOKTOP)!;
    }
    else if (applianceErdLower == ApplianceErd.PIZZA_OVEN) {
      name = LocaleUtil.getString(context, LocaleUtil.HEARTH_OVEN)!;
    }
    else if (applianceErdLower == ApplianceErd.GAS_COOKTOP) {
      name = LocaleUtil.getString(context, LocaleUtil.GAS_COOKTOP)!;
    }
    else if (applianceErdLower == ApplianceErd.SPLIT_AIR_CONDITIONER) {
      name = LocaleUtil.getString(context, LocaleUtil.DUCTLESS_AIR_CONDITIONER)!;
    }
    else if (applianceErdLower == ApplianceErd.HOOD) {
      name = LocaleUtil.getString(context, LocaleUtil.HOOD)!;
    }
    else if (applianceErdLower == ApplianceErd.POE_WATER_FILTER) {
      name = LocaleUtil.getString(context, LocaleUtil.WHOLE_HOME_WATER_FILTER)!;
    }
    else if (applianceErdLower == ApplianceErd.COOKTOP_STANDALONE) {
      name = LocaleUtil.getString(context, LocaleUtil.INDUCTION_COOKTOP)!;
    }
    else if (applianceErdLower == ApplianceErd.DELIVERY_BOX) {
      name = LocaleUtil.getString(context, LocaleUtil.DELIVERY_BOX)!;
    }
    else if (applianceErdLower == ApplianceErd.ZONELINE) {
      name = LocaleUtil.getString(context, LocaleUtil.ZONELINE)!;
    }
    else if (applianceErdLower == ApplianceErd.WATER_SOFTENER) {
      name = LocaleUtil.getString(context, LocaleUtil.HOUSEHOLD_WATER_SOFTENER)!;
    }
    else if (applianceErdLower == ApplianceErd.PORTABLE_AIR_CONDITIONER) {
      name = LocaleUtil.getString(context, LocaleUtil.PORTABLE_AIR_CONDITIONER)!;
    }
    else if (applianceErdLower == ApplianceErd.COMBINATION_WASHER_DRYER) {
      name = LocaleUtil.getString(context, LocaleUtil.COMBO)!;
    }
    else if (applianceErdLower == ApplianceErd.DUAL_ZONE_WINE_CHILLER) {
      name = LocaleUtil.getString(context, LocaleUtil.WINE_CENTER)!;
    }
    else if (applianceErdLower == ApplianceErd.BEVERAGE_CENTER) {
      name = LocaleUtil.getString(context, LocaleUtil.BEVERAGE_CENTER)!;
    }
    else if (applianceErdLower == ApplianceErd.COFFEE_BREWER) {
      name = LocaleUtil.getString(context, LocaleUtil.COFFEE_MAKER)!;
    }
    else if (applianceErdLower == ApplianceErd.OPAL_ICE_MAKER) {
      name = LocaleUtil.getString(context, LocaleUtil.OPAL_NUGGET_ICE_MAKER)!;
    }
    else if (applianceErdLower == ApplianceErd.IN_HOME_GROWER) {
      name = LocaleUtil.getString(context, LocaleUtil.HOME_GROWER)!;
    }
    else if (applianceErdLower == ApplianceErd.DEHUMIDIFIER) {
      name = LocaleUtil.getString(context, LocaleUtil.DEHUMIDIFIER)!;
    }
    else if (applianceErdLower == ApplianceErd.UNDER_COUNTER_ICE_MAKER) {
      name = LocaleUtil.getString(context, LocaleUtil.UNDER_COUNTER_ICE_MAKER)!;
    }
    else if (applianceErdLower == ApplianceErd.BUILT_IN_AC) {
      name = LocaleUtil.getString(context, LocaleUtil.AIR_CONDITIONER)!;
    }
    else if (applianceErdLower == ApplianceErd.DISH_DRAWER) {
      name = LocaleUtil.getString(context, LocaleUtil.DISH_DRAWER)!;
    }
    else if (applianceErdLower == ApplianceErd.ESPRESSO) {
      name = LocaleUtil.getString(context, LocaleUtil.EXPRESSO)!;
    }
    else if (applianceErdLower == ApplianceErd.TOASTER_OVEN) {
      name = LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN)!;
    }
    else if (applianceErdLower == ApplianceErd.GATEWAY) {
      name = LocaleUtil.getString(context, LocaleUtil.GATEWAY)!;
    }
    else if (applianceErdLower == ApplianceErd.STAND_MIXER) {
      name = LocaleUtil.getString(context, LocaleUtil.STAND_MIXER)!;
    }
    else if (applianceErdLower == ApplianceErd.UNDEFINED) {
      name = LocaleUtil.getString(context, LocaleUtil.APPLIANCE)!;
    }
    else if (applianceErd.toUpperCase() == ApplianceErd.APPL) {
      name = LocaleUtil.getString(context, LocaleUtil.APPLIANCE)!;
    }

    return name;
  }

  static String getApplianceErd(ApplianceType applianceType) {
    String erdValue = ApplianceErd.WATER_HEATER;

    if (applianceType == ApplianceType.WATER_HEATER) {
      erdValue = ApplianceErd.WATER_HEATER;
    }
    else if (applianceType == ApplianceType.LAUNDRY_DRYER) {
      erdValue = ApplianceErd.LAUNDRY_DRYER;
    }
    else if (applianceType == ApplianceType.LAUNDRY_WASHER) {
      erdValue = ApplianceErd.LAUNDRY_WASHER;
    }
    else if (applianceType == ApplianceType.REFRIGERATOR) {
      erdValue = ApplianceErd.REFRIGERATOR;
    }
    else if (applianceType == ApplianceType.MICROWAVE) {
      erdValue = ApplianceErd.MICROWAVE;
    }
    else if (applianceType == ApplianceType.ADVANTIUM) {
      erdValue = ApplianceErd.ADVANTIUM;
    }
    else if (applianceType == ApplianceType.DISHWASHER) {
      erdValue = ApplianceErd.DISHWASHER;
    }
    else if (applianceType == ApplianceType.OVEN) {
      erdValue = ApplianceErd.OVEN;
    }
    else if (applianceType == ApplianceType.ELECTRIC_RANGE) {
      erdValue = ApplianceErd.ELECTRIC_RANGE;
    }
    else if (applianceType == ApplianceType.GAS_RANGE) {
      erdValue = ApplianceErd.GAS_RANGE;
    }
    else if (applianceType == ApplianceType.AIR_CONDITIONER) {
      erdValue = ApplianceErd.AIR_CONDITIONER;
    }
    else if (applianceType == ApplianceType.ELECTRIC_COOKTOP) {
      erdValue = ApplianceErd.ELECTRIC_COOKTOP;
    }
    else if (applianceType == ApplianceType.PIZZA_OVEN) {
      erdValue = ApplianceErd.PIZZA_OVEN;
    }
    else if (applianceType == ApplianceType.GAS_COOKTOP) {
      erdValue = ApplianceErd.GAS_COOKTOP;
    }
    else if (applianceType == ApplianceType.SPLIT_AIR_CONDITIONER) {
      erdValue = ApplianceErd.SPLIT_AIR_CONDITIONER;
    }
    else if (applianceType == ApplianceType.HOOD) {
      erdValue = ApplianceErd.HOOD;
    }
    else if (applianceType == ApplianceType.POE_WATER_FILTER) {
      erdValue = ApplianceErd.POE_WATER_FILTER;
    }
    else if (applianceType == ApplianceType.COOKTOP_STANDALONE) {
      erdValue = ApplianceErd.COOKTOP_STANDALONE;
    }
    else if (applianceType == ApplianceType.DELIVERY_BOX) {
      erdValue = ApplianceErd.DELIVERY_BOX;
    }
    else if (applianceType == ApplianceType.ZONELINE) {
      erdValue = ApplianceErd.ZONELINE;
    }
    else if (applianceType == ApplianceType.WATER_SOFTENER) {
      erdValue = ApplianceErd.WATER_SOFTENER;
    }
    else if (applianceType == ApplianceType.PORTABLE_AIR_CONDITIONER) {
      erdValue = ApplianceErd.PORTABLE_AIR_CONDITIONER;
    }
    else if (applianceType == ApplianceType.COMBINATION_WASHER_DRYER) {
      erdValue = ApplianceErd.COMBINATION_WASHER_DRYER;
    }
    else if (applianceType == ApplianceType.DUAL_ZONE_WINE_CHILLER) {
      erdValue = ApplianceErd.DUAL_ZONE_WINE_CHILLER;
    }
    else if (applianceType == ApplianceType.BEVERAGE_CENTER) {
      erdValue = ApplianceErd.BEVERAGE_CENTER;
    }
    else if (applianceType == ApplianceType.COFFEE_BREWER) {
      erdValue = ApplianceErd.COFFEE_BREWER;
    }
    else if (applianceType == ApplianceType.OPAL_ICE_MAKER) {
      erdValue = ApplianceErd.OPAL_ICE_MAKER;
    }
    else if (applianceType == ApplianceType.IN_HOME_GROWER) {
      erdValue = ApplianceErd.IN_HOME_GROWER;
    }
    else if (applianceType == ApplianceType.DEHUMIDIFIER) {
      erdValue = ApplianceErd.DEHUMIDIFIER;
    }
    else if (applianceType == ApplianceType.UNDER_COUNTER_ICE_MAKER) {
      erdValue = ApplianceErd.UNDER_COUNTER_ICE_MAKER;
    }
    else if (applianceType == ApplianceType.TOASTER_OVEN) {
      erdValue = ApplianceErd.TOASTER_OVEN;
    }
    else if (applianceType == ApplianceType.BUILT_IN_AC) {
      erdValue = ApplianceErd.BUILT_IN_AC;
    }
    else if (applianceType == ApplianceType.DISH_DRAWER) {
      erdValue = ApplianceErd.DISH_DRAWER;
    }
    else if (applianceType == ApplianceType.ESPRESSO_COFFEE_MAKER) {
      erdValue = ApplianceErd.ESPRESSO;
    }
    else if (applianceType == ApplianceType.TOASTER_OVEN) {
      erdValue = ApplianceErd.TOASTER_OVEN;
    }
    else if (applianceType == ApplianceType.GATEWAY) {
      erdValue = ApplianceErd.GATEWAY;
    }
    else if (applianceType == ApplianceType.STAND_MIXER) {
      erdValue = ApplianceErd.STAND_MIXER;
    }
    else if (applianceType == ApplianceType.UNDEFINED) {
      erdValue = ApplianceErd.UNDEFINED;
    }
    else if (applianceType == ApplianceType.APPL) {
      erdValue = ApplianceErd.APPL;
    }

    return erdValue;
  }

  static String? getSubType(ApplianceType applianceType, BuildContext context, String? applianceName) {

    String? subType;
    if (applianceName == LocaleUtil.getString(context, LocaleUtil.WINDOW_AIR_CONDITIONER)) {
      subType = ApplianceSubType.windowAirConditioner.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.PORTABLE_AIR_CONDITIONER)) {
      subType = ApplianceSubType.portableAirConditioner.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.DUCTLESS_AIR_CONDITIONER)) {
      subType = ApplianceSubType.ductlessAirConditioner.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.DEHUMIDIFIER)) {
      subType = ApplianceSubType.dehumidifier.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.ADVANTIUM)) {
      subType = ApplianceSubType.advantium.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_KNOB)) {
      subType = ApplianceSubType.wallOvenKnob.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.WALL_OVEN_TOUCH_PAD)) {
      subType = ApplianceSubType.wallOvenTouchPad.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.RANGE_OR_WALL_OVEN)) {
      subType = ApplianceSubType.rangeOrWallOvenLCDDisplay.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.RANGE)) {
      subType = ApplianceSubType.range.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.RANGE_KNOB)) {
      subType = ApplianceSubType.rangeKnob.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.PRO_RANGE_2_4)) {
      subType = ApplianceSubType.proRange24.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.PRO_RANGE_7_0)) {
      subType = ApplianceSubType.proRange70.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.MICROWAVE)) {
      subType = ApplianceSubType.microwave.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.INDUCTION_COOKTOP)) {
      subType = ApplianceSubType.inductionCooktop.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.HEARTH_OVEN)) {
      subType = ApplianceSubType.hearthOven.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.GAS_COOKTOP)) {
      subType = ApplianceSubType.gasCooktop.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.DISHWASHER)) {
      subType = ApplianceSubType.dishwasher.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.WINE_CENTER)) {
      subType = ApplianceSubType.wineCenter.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.BEVERAGE_CENTER)) {
      subType = ApplianceSubType.beverageCenter.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.UNDER_COUNTER_ICE_MAKER)) {
      subType = ApplianceSubType.underCounterIceMaker.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.WATER_HEATER)) {
      subType = ApplianceSubType.waterHeater.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.WHOLE_HOME_WATER_FILTER)) {
      subType = ApplianceSubType.wholeHomeWaterFilter.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.HOUSEHOLD_WATER_SOFTENER)) {
      subType = ApplianceSubType.householdWaterSoftener.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.COFFEE_MAKER)) {
      subType = ApplianceSubType.coffeeMaker.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.OPAL_NUGGET_ICE_MAKER)) {
      subType = ApplianceSubType.opalNuggetIceMaker.value;
    }
    else if (applianceName == LocaleUtil.getString(context, LocaleUtil.TOASTER_OVEN)) {
      subType = ApplianceSubType.toasterOven.value;
    }
    else if(applianceType == ApplianceType.OVEN && applianceName == LocaleUtil.getString(context, LocaleUtil.OVEN_TOUCHSCREEN_MODEL)) {
      return ApplianceSubType.fnpOvenTouchscreenModel.value;
    }
    else if(applianceType == ApplianceType.OVEN && applianceName == LocaleUtil.getString(context, LocaleUtil.RANGE_TOUCHSCREEN_MODEL)) {
      return ApplianceSubType.fnpRangesTouchscreenModel.value;
    }
    else if(applianceType == ApplianceType.DISH_DRAWER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.DISH_DRAWER_TOP_CONTROL_PANEL)) {
      return ApplianceSubType.fnpDishDrawerTopControlPanel.value;
    }
    else if(applianceType == ApplianceType.DISH_DRAWER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.DISH_DRAWER_FRONT_CONTROL_PANEL)) {
      return ApplianceSubType.fnpDishDrawerFrontControlPanel.value;
    }
    else if(applianceType == ApplianceType.LAUNDRY_WASHER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.WASHER_LCD_OR_DRYER_LCD)) {
      return ApplianceSubType.fnpDryerLcdOrWasherLcd.value;
    }
    else if(applianceType == ApplianceType.LAUNDRY_WASHER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.WASHER_LCD)) {
      return ApplianceSubType.fnpWasherLcd.value;
    }
    else if(applianceType == ApplianceType.LAUNDRY_WASHER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.WASHER_LED_DISPLAY)) {
      return ApplianceSubType.fnpWasherLed.value;
    }
    else if(applianceType == ApplianceType.LAUNDRY_DRYER && applianceName == LocaleUtil.getString(
        context, LocaleUtil.DRYER_LED_DISPLAY)) {
      return ApplianceSubType.fnpDryerLed.value;
    }
    else if(applianceType == ApplianceType.REFRIGERATOR && applianceName == LocaleUtil.getString(
        context, LocaleUtil.INTEGRATED_COLUMN_REFRIGERATOR_OR_FREEZER)) {
      return ApplianceSubType.fnpIntegratedColumnRefrigeratorOrFreezer.value;
    }
    else if(applianceType == ApplianceType.REFRIGERATOR && applianceName == LocaleUtil.getString(
        context, LocaleUtil.INTEGRATED_COLUMN_WINE_CABINET)) {
      return ApplianceSubType.fnpIntegratedColumnWineCabinet.value;
    }
    else if(applianceType == ApplianceType.REFRIGERATOR && applianceName == LocaleUtil.getString(
        context, LocaleUtil.ACTIVE_SMART_REFRIGERATOR_FREEZER)) {
      return ApplianceSubType.fnpActiveSmartRefrigeratorFreezer.value;
    }
    else if(applianceType == ApplianceType.REFRIGERATOR && applianceName == LocaleUtil.getString(
        context, LocaleUtil.QUAD_DOOR)) {
      return ApplianceSubType.fnpQuadDoor.value;
    }
    else {
      subType = applianceName;
    }

    return subType;
  }

  static ApplianceCategoryType getApplianceCategoryType(ApplianceType? applianceType) {
    ApplianceCategoryType categoryType = ApplianceCategoryType.COOKING;

    switch(applianceType) {
      case ApplianceType.AIR_CONDITIONER:
      case ApplianceType.PORTABLE_AIR_CONDITIONER:
      case ApplianceType.SPLIT_AIR_CONDITIONER:
      case ApplianceType.DEHUMIDIFIER:
      case ApplianceType.BUILT_IN_AC:
        categoryType = ApplianceCategoryType.AIR_CONDITIONER;
        break;

      case ApplianceType.ADVANTIUM:
      case ApplianceType.OVEN:
      case ApplianceType.ELECTRIC_RANGE:
      case ApplianceType.HOOD:
      case ApplianceType.MICROWAVE:
      case ApplianceType.COOKTOP_STANDALONE:
      case ApplianceType.PIZZA_OVEN:
      case ApplianceType.GAS_COOKTOP:
        categoryType = ApplianceCategoryType.COOKING;
        break;

      case ApplianceType.DISH_DRAWER:
      case ApplianceType.DISHWASHER:
        categoryType = ApplianceCategoryType.DISHWASHER;
        break;

      case ApplianceType.REFRIGERATOR:
      case ApplianceType.DUAL_ZONE_WINE_CHILLER:
      case ApplianceType.BEVERAGE_CENTER:
        categoryType = ApplianceCategoryType.REFRIGERATION;
        break;

      case ApplianceType.WATER_HEATER:
      case ApplianceType.POE_WATER_FILTER:
      case ApplianceType.WATER_SOFTENER:
        categoryType = ApplianceCategoryType.WATER_PRODUCTS;
        break;

      case ApplianceType.COFFEE_BREWER:
      case ApplianceType.TOASTER_OVEN:
      case ApplianceType.OPAL_ICE_MAKER:
      case ApplianceType.ESPRESSO_COFFEE_MAKER:
      case ApplianceType.STAND_MIXER:
        categoryType = ApplianceCategoryType.COUNTERTOP_APPLIANCES;
        break;

      case ApplianceType.LAUNDRY_WASHER:
      case ApplianceType.LAUNDRY_DRYER:
        categoryType = ApplianceCategoryType.LAUNDRY;
        break;

      case ApplianceType.GATEWAY:
        categoryType = ApplianceCategoryType.GATEWAY;
        break;

      default:
        break;
    }

    return categoryType;
  }
}

class ApplianceState extends Equatable {
  final int? seedValue;
  final bool? isModelValidated;
  final ApplianceType? applianceType;
  final DevicePresence? appliancePresence;

  ApplianceState({
    this.seedValue,
    this.isModelValidated,
    this.applianceType,
    this.appliancePresence
  });

  @override
  List<Object?> get props => [
    seedValue,
    isModelValidated,
    applianceType,
    appliancePresence
  ];

  @override
  String toString() => "ApplianceState {"
      "seedValue: $seedValue\n"
      "isModelValidated: $isModelValidated\n"
      "applianceType: $applianceType\n"
      "appliancePresence: $appliancePresence\n"
      "}";

  ApplianceState copyWith({
    int? seedValue,
    bool? isModelValidated,
    ApplianceType? applianceType,
    DevicePresence? appliancePresence
  }) {
    return ApplianceState(
      seedValue: seedValue ?? this.seedValue,
      isModelValidated: isModelValidated ?? this.isModelValidated,
      applianceType: applianceType ?? this.applianceType,
      appliancePresence: appliancePresence ?? this.appliancePresence
    );
  }
}
