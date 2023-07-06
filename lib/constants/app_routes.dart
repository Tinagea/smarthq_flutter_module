import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthq_flutter_module/cubits/dialog/push_notification/push_notification_cubit.dart';
import 'package:smarthq_flutter_module/resources/channels/dialog_parameter/dialog_parameter_body.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/toaster_oven/toaster_oven_select_type_page.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthq_flutter_module/services/life_cycle_service.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/details/push_notification_alert_details_page.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/push_notification_dialog.dart';
import 'package:smarthq_flutter_module/view/dialog/push_notification/root_background_dialog.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/laundry_center_navigator.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_review_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_select_oven_type_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_select_type_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_create_page.dart';
import 'package:smarthq_flutter_module/view/control/shortcut_page/shortcut_create_turn_off_page.dart';
import 'package:smarthq_flutter_module/view/main_router.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/commissioning/add_appliance_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/select_appliance_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/gateway_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/hood_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/toaster_oven_cafe_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/commissioning_common_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/connect_plus_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dispenser_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dryer_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/washer_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/espresso_auto_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/espresso_manual_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/ontop_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/show_me_how_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/sidedoor_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/combi_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/advantium_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/beverage_center_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/coffee_maker_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/cooktop_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dehumidifier_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dishwahser_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/ductless_ac_built_in_wifi_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/hearth_oven_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/microwave_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/opal_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/portable_ac_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/window_ac_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/range_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/wall_oven_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/under_counter_icemaker_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/wine_center_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/water_products_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/stand_mixer_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/grind_brew_navigator.dart';

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge/fridge_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooking_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/air_products/air_conditioner_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/countertops_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/espresso/espresso_select_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/refrigeration_select_type_page.dart';

// control
import 'package:smarthq_flutter_module/view/control/navigator_page/stand_mixer_control_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/toaster_oven_profile_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/countertops/coffee_maker/coffee_maker_select_type_page.dart';

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/cooking/cooking_select_type_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/dishwasher/select_dishwasher_type_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dishwasher_dish_drawer_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/dishwasher_drop_door_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_appliance_type_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/laundry/laundry_appliance_type_haier_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/in_the_middle_fridge_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/right_on_wall_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/left_on_wall_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/refrigeration/fridge_select_type_fnp_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/haier_ac_navigator.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_page/commissioning_brand_selection_page.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/range_navigator_fnp.dart';
import 'package:smarthq_flutter_module/view/commissioning/navigator_page/wall_oven_navigator_fnp.dart';
import 'package:smarthq_flutter_module/view/recipes/navigator/recipe_navigator.dart';

import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_select_type_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_create_cubit.dart';
import 'package:smarthq_flutter_module/cubits/shortcut/shortcut_review_cubit.dart';

import '../view/commissioning/navigator_page/flavourly_navigator.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = {
    '/': (context) => MainRouter(lifeCycleService: GetIt.I.get<LifeCycleService>()),

    /// COMMISSIONING SCREEN NAVIGATORS
    Routes.ADD_APPLIANCE_PAGE: (context) => AddAppliancePage(),
    Routes.SELECT_APPLIANCE_PAGE: (context) => SelectAppliancePage(),
    Routes.FRIDGE_SELECT_NAVIGATOR: (context) => PageFridgeSelectType(),
    Routes.LAUNDRY_ROUTE_PATH: (context) => PageLaundrySelectType(),
    Routes.WASHER_MAIN_NAVIGATOR: (context) => WasherNavigator(),
    Routes.DRYER_MAIN_NAVIGATOR: (context) => DryerNavigator(),
    Routes.ESPRESSO_SELECT_NAVIGATOR:(context)=> PageEspressoSelectType(),
    Routes.TOASTER_OVEN_SELECT_NAVIGATOR:(context)=> PageToasterOvenSelectType(),
    Routes.CONNECT_PLUS_MAIN_NAVIGATOR: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as ScreenArgs;
      return ConnectPlusNavigator(args.applianceType);
    },
    Routes.DISPENSER_MAIN_NAVIGATOR: (context) => DispenserNavigator(),
    Routes.ON_TOP_MAIN_NAVIGATOR: (context) => OnTopNavigator(),
    Routes.SIDE_DOOR_MAIN_NAVIGATOR: (context) => SidedoorNavigator(),
    Routes.SHOW_ME_HOW_MAIN_NAVIGATOR: (context) => ShowMeHowNavigator(),
    Routes.COMMON_MAIN_NAVIGATOR: (context) => CommissioningCommonNavigator(),
    Routes.TOASTER_OVEN_CAFE_NAVIGATOR: (context) => ToasterOvenCafeNavigator(),
    Routes.TOASTER_OVEN_PROFILE_NAVIGATOR: (context) => ToasterOvenProfileNavigator(),
    Routes.ESPRESSO_MANUAL_NAVIGATOR: (context) => EspressoManualNavigator(),
    Routes.ESPRESSO_AUTO_NAVIGATOR: (context) => EspressoAutoNavigator(),
    Routes.HOOD_MAIN_NAVIGATOR: (context) => HoodNavigator(),
    Routes.COMBI_MAIN_NAVIGATOR: (context) => CombiNavigator(),
    Routes.LAUNDRY_CENTER_MAIN_NAVIGATOR: (context) => LaundryCenterNavigator(),
    Routes.GATEWAY_MAIN_NAVIGATOR: (context) {
      GatewayNavigatorArgs? args;
      var argument = ModalRoute.of(context)?.settings.arguments;
      if (argument != null) {
        args = ModalRoute.of(context)?.settings.arguments as GatewayNavigatorArgs;
      }
      return GatewayNavigator(args);
    },
    Routes.DEHUMIDIFIER_MAIN_NAVIGATOR: (context) => DehumidifierNavigator(),
    Routes.COUNTER_TOP_APPLIANCE_SELECTION_PAGE: (context)=> PageCounterTopApplianceSelectDisplay(),
    Routes.BREW_APPLIANCE_SELECTION_PAGE: (context)=> PageBrewApplianceSelectDisplay(),
    Routes.DISHWASHER_MAIN_NAVIGATOR: (context) => DishwasherNavigator(),
    Routes.OPAL_MAIN_NAVIGATOR: (context) => OpalCommonNavigator(),
    Routes.COFFEEMAKER_MAIN_NAVIGATOR: (context) => CoffeeMakerNavigator(),
    Routes.DUCTLESS_MAIN_NAVIGATOR: (context) => DuctlessACNavigator(),
    Routes.AIR_PRODUCTS_SELECTION_PAGE: (context) => AirApplianceTypePage(),
    Routes.WINDOW_AC_MAIN_NAVIGATOR: (context) => WindowsACNavigator(),
    Routes.PORTABLE_AC_MAIN_NAVIGATOR: (context) => PortableAcNavigator(),
    Routes.WATER_PRODUCTS_MAIN_NAVIGATOR: (context) => WaterProductsNavigator(),
    Routes.COOKING_APPLIANCE_SELECTION_PAGE: (context) => CookingApplianceTypePage(),
    Routes.COOKTOP_MAIN_NAVIGATOR: (context) => CooktopInductionNavigator(),
    Routes.MICROWAVE_MAIN_NAVIGATOR: (context) => MicrowaveNavigator(),
    Routes.WALL_OVEN_MAIN_NAVIGATOR: (context) => WallOvenNavigator(),
    Routes.HEARTH_OVEN_MAIN_NAVIGATOR: (context) => HearthOvenNavigator(),
    Routes.RANGE_MAIN_NAVIGATOR: (context) => RangeNavigator(),
    Routes.ADVANTIUM_MAIN_NAVIGATOR: (context) => AdvantiumNavigator(),

    Routes.REFRIGERATOR_SELECT_NAVIGATOR: (context) => RefrigeratorApplianceTypePage(),
    Routes.BEVERAGE_CENTER_MAIN_NAVIGATOR: (context) => BeverageCenterNavigator(),
    Routes.WINE_CENTER_MAIN_NAVIGATOR: (context) => WineCenterNavigator(),
    Routes.UNDER_COUNTER_ICE_MAKER_MAIN_NAVIGATOR: (context) => UnderCounterIcemakerNavigator(),
    Routes.STAND_MIXER_MAIN_NAVIGATOR: (context) => StandMixerNavigator(),
    Routes.FRIDGE_SELECT_NAVIGATOR_FNP: (context) => FridgeSelectTypeFnpPage(),
    Routes.BRAND_SELECTION: (context) {
      final args = ModalRoute.of(context)?.settings.arguments as BrandSelectionArgs;

      return CommissioningBrandSelectionPage(
        userCountryCode: args.userCountryCode,
        selectedType: args.selectedType,
      );
    },
    Routes.HAIER_AC_MAIN_NAVIGATOR: (context) => HaierACNavigator(),
    Routes.COOKING_SELECT_FNP_NAVIGATOR: (context) => CookingSelectTypeFnpPage(),
    Routes.RANGE_MAIN_FNP_NAVIGATOR: (context) => RangeNavigatorFnp(),
    Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR: (context) => WallOvenNavigatorFnp(),
    Routes.DISHWASHER_SELECT_TYPE: (context) => SelectDishwasherType(),
    Routes.DISH_DRAWER_MAIN_NAVIGATOR: (context) => DishwasherDishDrawerNavigator(),
    Routes.DROP_DOOR_MAIN_NAVIGATOR: (context) => DishwasherDropDoorNavigator(),
    Routes.LAUNDRY_SELECT_TYPE_FNP: (context) => LaundrySelectTypeFnpPage(),
    Routes.LAUNDRY_SELECT_TYPE_HAIER: (context) => LaundrySelectTypeHaierPage(),
    Routes.IN_THE_MIDDLE_MAIN_NAVIGATOR: (context) => InTheMiddleFridgeNavigator(),
    Routes.RIGHT_ON_WALL_MAIN_NAVIGATOR: (context) => RightOnWallNavigator(),
    Routes.LEFT_ON_WALL_MAIN_NAVIGATOR: (context) => LeftOnWallNavigator(),
    Routes.FLAVOURLY_MAIN_NAVIGATOR: (context) => FlavourlyCommonNavigator(),

    /// Push Notification Related
    Routes.PUSH_NOTIFICATION_ALERT_DETAILS_PAGE: (context) {
      PushNotificationAlertDetailsArgs arguments = ModalRoute.of(context)?.settings.arguments as PushNotificationAlertDetailsArgs;
      return PushNotificationAlertDetailsPage(arguments:arguments);
    },

    /// CONTROL SCREEN NAVIGATORS
    Routes.STAND_MIXER_CONTROL_MAIN_NAVIGATOR: (context) => StandMixerControlNavigator(),

    ///RECIPE SCREEN NAVIGATORS
    Routes.RECIPE_MAIN_NAVIGATOR: (context) {
      RecipeFilterArguments? args;
      var argument = ModalRoute.of(context)?.settings.arguments;
      if (argument != null) {
        args = ModalRoute.of(context)?.settings.arguments as RecipeFilterArguments;
      }
      return RecipeNavigator(args);
    },

    Routes.GRIND_BREW_MAIN_NAVIGATOR: (context) => GrindBrewNavigator(),

    /// Shortcuts Pages - create cubit and page at the same time.
    Routes.SHORTCUT_SELECT_TYPE_PAGE: (context) => BlocProvider(
        create: (context) =>
            GetIt.I.get<ShortcutSelectTypeCubit>(),
        child: ShortcutSelectTypePage()),

    Routes.SHORTCUT_SELECT_OVEN_TYPE_PAGE: (context) => BlocProvider(
        create: (context) =>
            GetIt.I.get<ShortcutSelectTypeCubit>(),
        child: ShortcutSelectOvenTypePage()),

    Routes.SHORTCUT_CREATE_PAGE: (context) => BlocProvider(
        create: (context) =>
            GetIt.I.get<ShortcutCreateCubit>(),
        child: ShortcutCreatePage(),
        lazy: false
    ),

    Routes.SHORTCUT_REVIEW_PAGE: (context) => BlocProvider(
        create: (context) =>
            GetIt.I.get<ShortcutReviewCubit>(),
        child: ShortcutReviewPage()
    ),

    Routes.SHORTCUT_TURN_OFF_PAGE: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<ShortcutCreateCubit>.value(
            value: GetIt.I.get<ShortcutCreateCubit>(),
          ),
          BlocProvider<ShortcutReviewCubit>.value(
            value: GetIt.I.get<ShortcutReviewCubit>(),
          )],

        child: ShortcutCreateTurnOffPage()),


  };


  /// DIALOG (SECONDARY FLUTTER ENGINE - PUSH NOTIFICATIONS)
  static Route<dynamic> generateRouteForDialog(RouteSettings settings) {

    switch (settings.name) {
      case Routes.DIALOG_ROOT_BACKGROUND:
        return PageRouteBuilder(
          opaque: false,
          settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments),
          pageBuilder: (_, __, ___) => RootBackgroundDialog(),
        );

      case Routes.DIALOG_PUSH_NOTIFICATION:
      DialogParameterBodyPushNotification dialogParameter =
        settings.arguments as DialogParameterBodyPushNotification;
        return PageRouteBuilder(
          opaque: false,
          settings: RouteSettings(
              name: settings.name,
              arguments: settings.arguments),
          pageBuilder: (_, __, ___) =>
              BlocProvider(
                  create: (BuildContext context) {
                    return GetIt.I.get<PushNotificationCubit>();
                  },
                  child: PushNotificationDialog(parameter: dialogParameter))
        );
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }

  static final routesForDialog = {

    Routes.PUSH_NOTIFICATION_ALERT_DETAILS_PAGE: (context) {
      PushNotificationAlertDetailsArgs arguments = ModalRoute.of(context)?.settings.arguments as PushNotificationAlertDetailsArgs;
      return PushNotificationAlertDetailsPage(arguments:arguments);
    },
  };

}
