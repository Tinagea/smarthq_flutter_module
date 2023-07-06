import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/models/brand_model.dart';
import 'package:smarthq_flutter_module/models/models.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class RoutingUtil {
  /// Convenience method for routing based on brand, category/appliance and country code.
  static void handleBrandRouting({
    required BuildContext context,
    required ApplianceBrandTypes brandType,
    required SelectedType selectedType,
    required String userCountryCode,
    bool replace = false,
  }) {
    switch (brandType) {
      case ApplianceBrandTypes.brandTypeFisherAndPaykel:
        resolveFnpRoute(
          context: context,
          selectedType: selectedType,
          userCountryCode: userCountryCode,
          replace: replace,
        );
        break;

      case ApplianceBrandTypes.brandTypeFpaHaier:
        resolveFpaHaierRoute(
          context: context,
          selectedType: selectedType,
          userCountryCode: userCountryCode,
          replace: replace,
        );
        break;

      default:
        resolveGeRoute(
          context: context,
          selectedType: selectedType,
          replace: replace,
        );
        break;
    }
  }

  /// Convenience method for routing F&P categories/appliances to their pages.
  static void resolveFnpRoute({
    required BuildContext context,
    required SelectedType selectedType,
    required String userCountryCode,
    bool replace = false,
  }) {
    if (selectedType is SelectedApplianceType) {
      switch (selectedType.applianceType) {
        case ApplianceType.OVEN:
          globals.subRouteName = Routes.WALL_OVEN_MODEL_SELECTION_FNP;
          _navigateToRoute(
            context: context,
            routePath: Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.LAUNDRY_WASHER:
          switch (userCountryCode) {
            case CountryUtil.sg:
              globals.subRouteName = Routes.WASHER_MODEL_1_GETTING_STARTED_FNP;
              break;

            default:
              globals.subRouteName = Routes.WASHER_FRONT_1_DISPLAY_MODEL_SELECT_FNP;
              break;
          }
          _navigateToRoute(
            context: context,
            routePath: Routes.WASHER_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.LAUNDRY_DRYER:
          switch (userCountryCode) {
            case CountryUtil.gb:
            case CountryUtil.ie:
              globals.subRouteName = Routes.DRYER_MODEL_2_GETTING_STARTED_FNP;
              break;

            default:
              globals.subRouteName = Routes.DRYER_FRONT_1_DISPLAY_MODEL_SELECT_FNP;
              break;
          }
          _navigateToRoute(
            context: context,
            routePath: Routes.DRYER_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.REFRIGERATOR:
          _navigateToRoute(
            context: context,
            routePath: Routes.FRIDGE_SELECT_NAVIGATOR_FNP,
            replace: replace,
          );
          break;

        case ApplianceType.DISH_DRAWER:
          _navigateToRoute(
            context: context,
            routePath: Routes.DISH_DRAWER_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.DISHWASHER:
          globals.subRouteName = Routes.DROP_DOOR_FNP_STEP1;
          _navigateToRoute(
            context: context,
            routePath: Routes.DROP_DOOR_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        default:
          resolveFnpRoute(
            context: context,
            selectedType: SelectedCategoryType(
              selectedType.applianceCategoryType,
              selectedType.subCategoryTypes,
            ),
            userCountryCode: userCountryCode,
            replace: replace,
          );
          break;
      }
    } else {
      switch (selectedType.applianceCategoryType) {
        case ApplianceCategoryType.COOKING:
          if ([CountryUtil.us, CountryUtil.ca].contains(userCountryCode)) {
            _navigateToRoute(
              context: context,
              routePath: Routes.COOKING_SELECT_FNP_NAVIGATOR,
              replace: replace,
            );
          } else {
            // Temporarily directing to wall oven flow since ventilation is not ready yet
            globals.subRouteName = Routes.WALL_OVEN_MODEL_SELECTION_FNP;
            _navigateToRoute(
              context: context,
              routePath: Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR,
              replace: replace,
            );
          }
          break;

        case ApplianceCategoryType.LAUNDRY:
          _navigateToRoute(
            context: context,
            routePath: Routes.LAUNDRY_SELECT_TYPE_FNP,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.REFRIGERATION:
          _navigateToRoute(
            context: context,
            routePath: Routes.FRIDGE_SELECT_NAVIGATOR_FNP,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.DISHWASHER:
          if ([CountryUtil.us, CountryUtil.ca, CountryUtil.au, CountryUtil.nz, CountryUtil.sg].contains(userCountryCode)) {
            _navigateToRoute(
              context: context,
              routePath: Routes.DISHWASHER_SELECT_TYPE,
              replace: replace,
            );
          } else {
            _navigateToRoute(
              context: context,
              routePath: Routes.DISH_DRAWER_MAIN_NAVIGATOR,
              replace: replace,
            );
          }
          break;

        default:
          _navigateToRoute(
            context: context,
            routePath: Routes.SELECT_APPLIANCE_PAGE,
            replace: replace,
            arguments: selectedType.subCategoryTypes,
          );
          break;
      }
    }
  }

  /// Convenience method for routing Haier categories/appliances to their pages.
  static void resolveFpaHaierRoute({
    required BuildContext context,
    required SelectedType selectedType,
    required String userCountryCode,
    bool replace = false,
  }) {
    if (selectedType is SelectedApplianceType) {
      switch (selectedType.applianceType) {
        case ApplianceType.OVEN:
          globals.subRouteName = Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_1;
          _navigateToRoute(
            context: context,
            routePath: Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.SPLIT_AIR_CONDITIONER:
        case ApplianceType.BUILT_IN_AC:
          globals.subRouteName = Routes.HAIER_AC_APPLIANCE_WIFI_TYPE_SELECTION_PAGE;
          _navigateToRoute(
            context: context,
            routePath: Routes.HAIER_AC_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.LAUNDRY_WASHER:
          globals.subRouteName = Routes.WASHER_FRONT_LOAD_GETTING_STARTED_HAIER;
          _navigateToRoute(
            context: context,
            routePath: Routes.WASHER_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.DISHWASHER:
          globals.subRouteName = Routes.DROP_DOOR_LOCATE_CONTROL_HAIER;
          _navigateToRoute(
            context: context,
            routePath: Routes.DROP_DOOR_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.LAUNDRY_DRYER:
          globals.subRouteName = Routes.DRYER_MODEL_1_GETTING_STARTED_HAIER;
          _navigateToRoute(
            context: context,
            routePath: Routes.DRYER_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceType.REFRIGERATOR:
          globals.subRouteName = Routes.LEFT_ON_WALL_DESCRIPTION2_MODEL1;
          _navigateToRoute(
            context: context,
            routePath: Routes.LEFT_ON_WALL_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        default:
          resolveFpaHaierRoute(
            context: context,
            selectedType: SelectedCategoryType(
              selectedType.applianceCategoryType,
              selectedType.subCategoryTypes,
            ),
            userCountryCode: userCountryCode,
            replace: replace,
          );
          break;
      }
    } else {
      switch (selectedType.applianceCategoryType) {
        case ApplianceCategoryType.COOKING:
          globals.subRouteName = Routes.COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_1;
          _navigateToRoute(
            context: context,
            routePath: Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.AIR_CONDITIONER:
          globals.subRouteName = Routes.HAIER_AC_APPLIANCE_CHOOSE_MODEL_PAGE;
          _navigateToRoute(
            context: context,
            routePath: Routes.HAIER_AC_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.DISHWASHER:
          globals.subRouteName = Routes.DROP_DOOR_LOCATE_CONTROL_HAIER;
          _navigateToRoute(
            context: context,
            routePath: Routes.DROP_DOOR_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.LAUNDRY:
          _navigateToRoute(
            context: context,
            routePath: Routes.LAUNDRY_SELECT_TYPE_HAIER,
            replace: replace,
          );
          break;

        case ApplianceCategoryType.REFRIGERATION:
          globals.subRouteName = Routes.LEFT_ON_WALL_DESCRIPTION2_MODEL1;
          _navigateToRoute(
            context: context,
            routePath: Routes.LEFT_ON_WALL_MAIN_NAVIGATOR,
            replace: replace,
          );
          break;

        default:
          _navigateToRoute(
            context: context,
            routePath: Routes.SELECT_APPLIANCE_PAGE,
            replace: replace,
            arguments: selectedType.subCategoryTypes,
          );
          break;
      }
    }
  }

  /// Convenience method for routing GEA categories/appliances to their pages. Currently
  /// holds a copy of [AddAppliance.navigateToRoute] and
  /// [AddAppliance.navigateToRouteByCategory].
  static void resolveGeRoute({
    required BuildContext context,
    required SelectedType selectedType,
    bool replace = false,
  }) {
    if (selectedType is SelectedApplianceType) {
      if (selectedType.applianceType == ApplianceType.REFRIGERATOR) {
        _navigateToRoute(context: context, routePath: Routes.FRIDGE_SELECT_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.DUAL_ZONE_WINE_CHILLER) {
        globals.subRouteName = Routes.WINE_CENTER_DESCRIPTION;
        _navigateToRoute(context: context, routePath: Routes.WINE_CENTER_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.BEVERAGE_CENTER) {
        globals.subRouteName = Routes.BEVERAGE_CENTER_DESCRIPTION;
        _navigateToRoute(context: context, routePath: Routes.BEVERAGE_CENTER_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.UNDER_COUNTER_ICE_MAKER) {
        globals.subRouteName = Routes.UNDER_COUNTER_ICE_MAKER_DESCRIPTION;
        _navigateToRoute(context: context, routePath: Routes.UNDER_COUNTER_ICE_MAKER_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.ESPRESSO_COFFEE_MAKER) {
        _navigateToRoute(context: context, routePath: Routes.ESPRESSO_SELECT_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.HOOD) {
        _navigateToRoute(context: context, routePath: Routes.HOOD_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceType == ApplianceType.ELECTRIC_COOKTOP || selectedType.applianceType == ApplianceType.GAS_COOKTOP || selectedType.applianceType == ApplianceType.COOKTOP_STANDALONE) {
        _navigateToRoute(context: context, routePath: Routes.COOKTOP_MAIN_NAVIGATOR, replace: replace);
      } else {
        resolveGeRoute(context: context, selectedType: SelectedCategoryType(selectedType.applianceCategoryType, selectedType.subCategoryTypes), replace: replace);
      }
    } else {
      if (selectedType.applianceCategoryType == ApplianceCategoryType.LAUNDRY) {
        _navigateToRoute(context: context, routePath: Routes.LAUNDRY_ROUTE_PATH, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.DISHWASHER) {
        _navigateToRoute(context: context, routePath: Routes.DISHWASHER_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.COUNTERTOP_APPLIANCES) {
        _navigateToRoute(context: context, routePath: Routes.COUNTER_TOP_APPLIANCE_SELECTION_PAGE, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.COOKING) {
        _navigateToRoute(context: context, routePath: Routes.COOKING_APPLIANCE_SELECTION_PAGE, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.AIR_CONDITIONER) {
        _navigateToRoute(context: context, routePath: Routes.FLAVOURLY_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.WATER_PRODUCTS) {
        _navigateToRoute(context: context, routePath: Routes.WATER_PRODUCTS_MAIN_NAVIGATOR, replace: replace);
      } else if (selectedType.applianceCategoryType == ApplianceCategoryType.REFRIGERATION) {
        _navigateToRoute(context: context, routePath: Routes.REFRIGERATOR_SELECT_NAVIGATOR, replace: replace);
      } else {
        _navigateToRoute(context: context, routePath: Routes.SELECT_APPLIANCE_PAGE, replace: replace, arguments: selectedType.subCategoryTypes);
      }
    }
  }

  /// Method used for routing to a new page. If [replace] is passed current route will
  /// be replaced.
  static void _navigateToRoute({
    required BuildContext context,
    required String routePath,
    required bool replace,
    Object? arguments,
  }) {
    if (replace) {
      Navigator.of(context).pushReplacementNamed(routePath, arguments: arguments);
    } else {
      Navigator.of(context).pushNamed(routePath, arguments: arguments);
    }
  }
}
