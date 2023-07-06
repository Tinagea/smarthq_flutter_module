import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/models/models.dart';

enum IconSizeType {
  SMALL,
  MEDIUM
}

class ApplianceStringManager {
  static getImagePath(ApplianceType? applianceType, IconSizeType sizeType) {
    var imagePath = '';

    switch (applianceType) {
      case ApplianceType.ADVANTIUM:
        imagePath = ImagePath.TYPE_ADVANTIUM_ICON_SMALL;
        break;
      case ApplianceType.BEVERAGE_CENTER:
        imagePath = ImagePath.TYPE_BEVERAGE_ICON_SMALL;
        break;
      case ApplianceType.COFFEE_BREWER:
        imagePath = ImagePath.TYPE_COFFEE_MAKER_ICON_SMALL;
        break;
      case ApplianceType.GAS_COOKTOP:
        imagePath = ImagePath.TYPE_COOKTOP_ICON_SMALL;
        break;
      case ApplianceType.DEHUMIDIFIER:
        imagePath = ImagePath.TYPE_DEHUMIDIFIER_ICON_SMALL;
        break;
      case ApplianceType.DISHWASHER:
        imagePath = ImagePath.TYPE_DISHWASHER_ICON_SMALL;
        break;
      case ApplianceType.DISH_DRAWER:
        imagePath = ImagePath.TYPE_DISH_DRAWER_ICON_SMALL;
        break;
      case ApplianceType.LAUNDRY_DRYER:
        imagePath = ImagePath.TYPE_DRYER_ICON_SMALL;
        break;
      case ApplianceType.SPLIT_AIR_CONDITIONER:
        imagePath = ImagePath.TYPE_DFS_ICON_SMALL;
        break;
      case ApplianceType.OPAL_ICE_MAKER:
        imagePath = ImagePath.TYPE_ICE_MAKER_ICON_SMALL;
        break;
      case ApplianceType.MICROWAVE:
        imagePath = ImagePath.TYPE_MICROWAVE_ICON_SMALL;
        break;
      case ApplianceType.PORTABLE_AIR_CONDITIONER:
        imagePath = ImagePath.TYPE_PAC_ICON_SMALL;
        break;
      case ApplianceType.ELECTRIC_RANGE:
        imagePath = ImagePath.TYPE_RANGE_ICON_SMALL;
        break;
      case ApplianceType.REFRIGERATOR:
        imagePath = ImagePath.TYPE_REFRIGERATOR_ICON_SMALL;
        break;
      case ApplianceType.HOOD:
        imagePath = ImagePath.TYPE_HOOD_ICON_SMALL;
        break;
      case ApplianceType.OVEN:
        imagePath = ImagePath.TYPE_WALL_OVEN_ICON_SMALL;
        break;
      case ApplianceType.PIZZA_OVEN:
        imagePath = ImagePath.TYPE_PIZZA_ICON_SMALL;
        break;
      case ApplianceType.LAUNDRY_WASHER:
        imagePath = ImagePath.TYPE_WASHER_ICON_SMALL;
        break;
      case ApplianceType.POE_WATER_FILTER:
        imagePath = ImagePath.TYPE_WATER_FILTER_ICON_SMALL;
        break;
      case ApplianceType.WATER_SOFTENER:
        imagePath = ImagePath.TYPE_WATER_SOFTENER_ICON_SMALL;
        break;
      case ApplianceType.WATER_HEATER:
        imagePath = ImagePath.TYPE_WATER_HEATER_ICON_SMALL;
        break;
      case ApplianceType.AIR_CONDITIONER:
        imagePath = ImagePath.TYPE_WAC_ICON_SMALL;
        break;
      case ApplianceType.BUILT_IN_AC:
        imagePath = ImagePath.TYPE_WAC_ICON_SMALL;
        break;
      case ApplianceType.DISH_DRAWER:
        imagePath = ImagePath.TYPE_DISH_DRAWER_ICON_SMALL;
        break;
      case ApplianceType.DUAL_ZONE_WINE_CHILLER:
        imagePath = ImagePath.TYPE_WINE_CHILLER_ICON_SMALL;
        break;
      case ApplianceType.GAS_RANGE:
        imagePath = ImagePath.TYPE_GAS_RANGE_ICON_SMALL;
        break;
      case ApplianceType.GATEWAY:
        imagePath = ImagePath.TYPE_GATEWAY_ICON_SMALL;
        break;
      case ApplianceType.TOASTER_OVEN:
        imagePath = ImagePath.PROFILE_TOASTER_OVEN_ICON;
        break;
      case ApplianceType.ELECTRIC_COOKTOP:
        imagePath = ImagePath.TYPE_COOKTOP_ICON_SMALL;
        break;
      case ApplianceType.GAS_COOKTOP:
        imagePath = ImagePath.TYPE_COOKTOP_ICON_SMALL;
        break;
      case ApplianceType.COOKTOP_STANDALONE:
        imagePath = ImagePath.TYPE_COOKTOP_ICON_SMALL;
        break;
      case ApplianceType.COMBINATION_WASHER_DRYER:
        imagePath = ImagePath.TYPE_COMBI_ICON_SMALL;
        break;
      case ApplianceType.STAND_MIXER:
        imagePath = ImagePath.TYPE_STAND_MIXER_ICON_SMALL;
        break;
      default:
        imagePath = ImagePath.TYPE_DEFAULT_ADD_APPLIANCE_ICON;
        break;
    }
    return imagePath;
  }

  static getCategoryImagePath(ApplianceCategoryType applianceCategoryType) {
    var imagePath = '';

    switch (applianceCategoryType) {
      case ApplianceCategoryType.AIR_CONDITIONER:
        imagePath = ImagePath.TYPE_AIR_CONDITIONER;
        break;
      case ApplianceCategoryType.COOKING:
        imagePath = ImagePath.TYPE_COOKING;
        break;
      case ApplianceCategoryType.DISHWASHER:
        imagePath = ImagePath.TYPE_DISHWASHER;
        break;
      case ApplianceCategoryType.DISH_DRAWER:
        imagePath = ImagePath.TYPE_DISHWASHER;
        break;
      case ApplianceCategoryType.REFRIGERATION:
        imagePath = ImagePath.TYPE_REFRIGERATION;
        break;
      case ApplianceCategoryType.WATER_PRODUCTS:
        imagePath = ImagePath.TYPE_WATER_PRODUCT;
        break;
      case ApplianceCategoryType.COUNTERTOP_APPLIANCES:
        imagePath = ImagePath.TYPE_COUNTERTOP;
        break;
      case ApplianceCategoryType.LAUNDRY:
        imagePath = ImagePath.TYPE_LAUNDRY;
        break;
      case ApplianceCategoryType.GATEWAY:
        imagePath = ImagePath.TYPE_LEAKAGE_SENSOR;
        break;
      default:
        break;
    }

    return imagePath;
  }
}
