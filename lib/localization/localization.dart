import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =

    await rootBundle.loadString('locale/string_${locale.languageCode}.json');
    //await rootBundle.loadString('locale/string_en.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'es'].contains(locale.languageCode);

  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class LocaleUtil {
  static String? getString(BuildContext context, String value) {
    return AppLocalizations.of(context)?.translate(value);
  }

  static const YES = "yes";
  static const NO = "no";
  static const LETS_GET_STARTED = "lets_get_started";
  static const CONNECTED_PLUS_DESCRIPTION_1_TEXT_1 = "connected_plus_description_1_text_1";
  static const CONNECTED_PLUS_DESCRIPTION_1_TEXT_2 = "connected_plus_description_1_text_2";
  static const CONNECTED_PLUS_DESCRIPTION_1_TEXT_3 = "connected_plus_description_1_text_3";

  static const WIFI_STEPS_TEXT_1 = "wifi_steps_text_1";
  static const WIFI_STEPS_TEXT_1_2 = "wifi_steps_text_1_2";
  static const WIFI_STEPS_TEXT_1_3 = "wifi_steps_text_1_3";

  static const WIFI_STEPS_TEXT_2_1 = "wifi_steps_text_2_1";
  static const WIFI_STEPS_TEXT_2_2 = "wifi_steps_text_2_2";
  static const WIFI_STEPS_TEXT_2_3 = "wifi_steps_text_2_3";
  static const WIFI_STEPS_TEXT_2_4 = "wifi_steps_text_2_4";
  static const WIFI_STEPS_TEXT_2_5 = "wifi_steps_text_2_5";

  static const WIFI_STEPS_TEXT_2 = "connected_plus_description_1_text_3";
  static const PAGE_COMMUNICATING_CLOUD_1 = "page_communicating_cloud_1";
  static const PAGE_COMMUNICATING_CLOUD_2 = "page_communicating_cloud_2";
  static const PAGE_COMMUNICATING_CLOUD_3 = "page_communicating_cloud_3";
  static const PAGE_COMMUNICATING_CLOUD_DESCRIPTION_1 = "page_communicating_cloud_description_1";
  static const PAGE_COMMUNICATING_CLOUD_DESCRIPTION_2 = "page_communicating_cloud_description_2";
  static const PAGE_COMMUNICATING_CLOUD_DESCRIPTION_3 = "page_communicating_cloud_description_3";

  static const WIFI_NOT_SELECTABLE = "wifi_not_selectable";
  static const CONNECT_PLUS = "connect_plus";
  static const CONTINUE = "continue";
  static const CONNECT_PLUS_HOW_TO_URL = "connect_plus_how_to_url";
  static const ADD_APPLIANCE = "add_appliance";
  static const ADD_OTHER_NETWORK = "add_other_network";
  static const OTHER_NETWORK = "other_network";
  static const AUTO_CONNECT_NOT_SUPPORT = "auto_connect_not_support";
  static const AUTO_CONNECT_FAILED = "auto_connect_failed";
  static const AUTO_JOIN_FAILED_TRY_MANUALLY = "auto_join_failed_try_manually";
  static const DISPENSER_DESCRIPTION_1_TEXT_1 = "dispenser_description_1_text_1";
  static const NEXT = "next";
  static const DISPENSER_DESCRIPTION_2_TEXT_1 = "dispenser_description_2_text_1";
  static const DISPENSER_DESCRIPTION_3_TEXT_1 = "dispenser_description_3_text_1";
  static const ENTER_PASSWORD = "enter_password";
  static const AND = "and";

  static const DISPENSER_MODEL1_INSTRUCTION1 = "dispenser_model1_instruction1";
  static const DISPENSER_MODEL1_INSTRUCTION2 = "dispenser_model1_instruction2";
  static const DISPENSER_MODEL2_INSTRUCTION1 = "dispenser_model2_instruction1";
  static const DISPENSER_MODEL2_INSTRUCTION2 = "dispenser_model2_instruction2";
  static const DISPENSER_MODEL2_INSTRUCTION3 = "dispenser_model2_instruction3";
  static const DISPENSER_MODEL3_INSTRUCTION1 = "dispenser_model3_instruction1";
  static const DISPENSER_MODEL3_INSTRUCTION2 = "dispenser_model3_instruction2";
  static const DISPENSER_MODEL3_INSTRUCTION3 = "dispenser_model3_instruction3";

  static const WIFI_SETTING_EXPLAIN_1 = "wifi_setting_explain_1";
  static const WIFI_SETTING_EXPLAIN_2 = "wifi_setting_explain_2";
  static const WIFI_SETTING_EXPLAIN_3 = "wifi_setting_explain_3";
  static const WIFI_SETTING_EXPLAIN_4 = "wifi_setting_explain_4";
  static const WIFI_SETTING_EXPLAIN_5 = "wifi_setting_explain_5";
  static const WIFI_SETTING_EXPLAIN_6 = "wifi_setting_explain_6";

  static const SHOW_ME_HOW = "show_me_how";
  static const CHOOSE_HOME_NETWORK = "choose_home_network";
  static const ASK_JOIN_WIFI = "ask_join_wifi";
  static const JOIN_WIFI = "join_wifi";
  static const PICK_OTHER_WIFI = "pick_other_wifi";
  static const ENTER_PASSWORD_FOR = "enter_password_for";
  static const CONNECT = "connect";
  static const COULD_NOT_FIND_HOME_NETWORK = "could_not_find_home_network";
  static const SELECT_APPLIANCE = "select_appliance";
  static const WHICH_ONE_LOOK_LIKE = "which_one_look_like";
  static const LOCATE_LABEL_EXPLAIN_1 = "locate_label_explain_1";
  static const LOCATE_LABEL_EXPLAIN_2 = "locate_label_explain_2";
  static const LOCATE_LABEL_EXPLAIN_3 = "locate_label_explain_3";
  static const LOCATE_CONNECTED_APPLIANCE_1 = "locate_connected_appliance_1";
  static const LOCATE_CONNECTED_APPLIANCE_2 = "locate_connected_appliance_2";
  static const LOCATE_CONNECTED_APPLIANCE_3 = "locate_connected_appliance_3";
  static const LOCATE_THE_CONNECTED_APPLIANCE_LABEL = "locate_the_connected_appliance_label";
  static const BOTTOM_FREEZER_EXPLAIN = "bottom_freezer_explain";
  static const SIDE_BY_SIDE_EXPLAIN = "side_by_side_explain";
  static const SIDE_DOOR_DESCRIPTION_1_DIRECTION_1 = "side_door_description_1_direction_1";
  static const SIDE_DOOR_DESCRIPTION_1_DIRECTION_2 = "side_door_description_1_direction_2";
  static const ON_RIGHT_SIDE_WALL = "on_right_side_wall";
  static const ENTER_PASSWORD_TEXT_1 = "enter_password_text_1";
  static const ENTER_PASSWORD_TEXT_2 = "enter_password_text_2";
  static const ENTER_PASSWORD_TEXT_3 = "enter_password_text_3";
  static const ENTER_PASSWORD_TEXT_3_ALT = "enter_password_text_3_alt";
  static const FOUND_ON_YOUR_REFRIGERATOR_DISPLAY = "found_on_your_refrigerator_display";
  static const FOUND_ON_THE_BACK_OF_CONNECT_PLUS = "found_on_the_back_of_connect_plus";
  static const DEHUMIDIFIER_DESCRIPTION_TEXT_1 = "dehumidifier_description_text_1";
  static const DEHUMIDIFIER_DESCRIPTION_TEXT_2 = "dehumidifier_description_text_2";
  static const DEHUMIDIFIER_DESCRIPTION_TEXT_3 = "dehumidifier_description_text_3";
  static const DEHUMIDIFIER_DESCRIPTION_TEXT_4 = "dehumidifier_description_text_4";
  static const DEHUMIDIFIER_DESCRIPTION_TEXT_5 = "dehumidifier_description_text_5";
  static const CAN_NOT_FIND_PASSWORD_BUT_UPD_ID = "can_not_find_password_but_upd_id";
  static const DEHUMIDIFIER_LABEL_EXPLAIN = "dehumidifier_label_explain";
  static const DEHUMIDIFIER_PASSWORD_EXPLAIN = "dehumidifier_password_explain";
  static const CAN_NOT_FIND_LABEL_YOU_MIGHT_NEED_CONNECT_PLUS = "can_not_find_label_you_might_need_connect_plus";
  static const SOMETHING_WENT_WRONG = "something_went_wrong";
  static const WHAT_DO_YOU_SEE_APPLIANCE_CONTROL = "what_do_you_see_appliance_control";
  static const FLASHING = "flashing";
  static const SOLID = "solid";

  static const CONGRATULATIONS_YOUR_GATEWAY_IS_CONNECTED = "congratulations_your_gateway_is_connected";
  static const LETS_PAIR_YOUR_SENSORS_NEXT = "lets_pair_your_sensors_next";
  static const PAIR_SENSORS = "pair_sensors";
  static const String SOMETHING_WENT_WRONG_RELAUNCH_TEXT_1 = "something_went_wrong_relaunch_text_1";
  static const String SOMETHING_WENT_WRONG_RELAUNCH_TEXT_2 = "something_went_wrong_relaunch_text_2";
  static const String RELAUNCH_APP = "relaunch_app";
  static const String SOMETHING_WENT_WRONG_RETRY_TEXT_1 = "something_went_wrong_retry_text_1";
  static const String SOMETHING_WENT_WRONG_RETRY_TEXT_2 = "something_went_wrong_retry_text_2";
  static const String RETRY = "retry";
  static const String COMMISSIONING_SUCCESS_DETAIL_TEXT_1 = "commissioning_success_detail_text_1";
  static const String COMMISSIONING_SUCCESS_DETAIL_TEXT_2 = "commissioning_success_detail_text_2";
  static const String COMMISSIONING_SUCCESS_DETAIL_TEXT_3 = "commissioning_success_detail_text_3";
  static const String GET_STARTED = "get_started";
  static const String CONGRATULATIONS_YOU_ARE_ALL_SET = "congratulations_you_are_all_set";
  static const String LOCATE_FRIDGE_TEMP_CONTROL = "locate_fridge_temp_control";
  static const String HAVE_CONNECT_PLUS = "have_connect_plus";
  static const String PRESS_WIFI_CONNECT_BUTTON = "press_wifi_connect_button";
  static const String WILL_START_TO_FLASH = "will_start_to_flash";
  static const String CANT_FIND_THIS_BUTTON = "cant_find_this_button";
  static const String ICON_NOT_APPEARING = "icon_not_appearing";
  static const String COMMUNICATING_WITH_YOUR_APPLIANCE = "communicating_with_your_appliance";
  static const String CONNECTING_TO_YOUR_APPLIANCE = "connecting_to_your_appliance";
  static const String SEARCH_FOR_AVAILABLE_WIFI_NETWORK = "search_for_available_wifi_networks";
  static const String TRYING_TO_CONNECT_THE_APPLIANCE = "trying_to_connect_the_appliance";
  static const String RETRYING_TO_CONNECT_YOUR_APPLIANCE = "retrying_to_connect_your_appliance";
  static const String ACM_WRONG_PASSWORD_INFORMATION_TEXT = "you_may_have_entered_wrong_password";
  static const String WRONG_PASSWORD = "wrong_password";
  static const String DOES_YOUR_UNIT_HAS_BUILT_IN_WIF = "does_your_unit_have_built_in_wifi";
  static const String I_DONT_SEE_THIS_SCREEN = "i_dont_see_this_screen";
  static const String BACK_TO_HOME = "back_to_home";


  static const String DRIP_COFFEE_MAKER = "drip_coffee_maker";
  static const String ESPRESSO_MACHINE = "espresso_machine";

  static const String HOME_BUTTON = "home_button";
  static const String SETTINGS = "settings";
  static const String WIFI = "wifi";
  static const String GE_MODULE_XXXX = "ge_module_xxxx";
  static const String GE_MODULE_PREFIX = "ge_module_prefix";
  static const String GE_OVEN_PREFIX = "ge_oven_prefix";
  static const String APPS = "apps";
  static const String ICON = "icon";
  static const String SMART_NETWORK_SWITCH = "smart_network_switch";
  static const String ON_THE_DISPENSER = "on_the_dispenser";
  static const String ON_THE_SIDE_OF_DOOR = "on_the_side_of_door";
  static const String ON_TOP = "on_top";
  static const String TAP = "tap";
  static const String TURN_ON = "turn_on";
  static const String SELECT = "select";
  static const String SELECT_SECURITY_TYPE = "select_security_type";
  static const String ENTER_NETWORK_NAME = "enter_the_network_name";
  static const String SECURITY = "security";
  static const String ENTER_HOME_NETWORK_PASSWORD = "enter_home_network_password";
  static const String OK = "ok";
  static const String CANCEL = "cancel";
  static const String PASSWORD = "password";
  static const String NAME = "name";
  static const String ENTER_THE_PASSWORD_FOUND_ON_THE_LABEL = "enter_the_password_found_on_the_label";
  static const String APPLIANCE_NETWORK_INFO = "appliance_network_info";

  static const String ON_YOUR_COFFEE_MAKER_PRESS_AND_HOLD_THE = "on_your_coffee_maker_press_and_hold_the";
  static const String TEMPERATURE = "temperature";
  static const String AND_THE = "and_the";
  static const String AUTO_BREW = "auto_brew";
  static const String BUTTON_UNTIL_THE = "button_until_the";
  static const String ICON_FLASHES = "icon_flashes";
  static const String ON_THE_BOTTOM_OF_COFFEE_MAKER = "on_the_bottom_of_coffee_maker";
  static const String SHOW_ME_HOW_IPHONEX_PAGE1_DESCRIPTION = "show_me_how_iphonex_page1_description";
  static const String SHOW_ME_HOW_IPHONEX_PAGE5_DESCRIPTION = "show_me_how_iphonex_page5_description";
  static const String SHOW_ME_HOW_IPHONEX_PAGE6_DESCRIPTION = "show_me_how_iphonex_page6_description";

  static const String SHOW_ME_HOW_IPHONE_PAGE1_DESCRIPTION_1 = "show_me_how_iphone_page1_description_1";
  static const String SHOW_ME_HOW_IPHONE_PAGE1_DESCRIPTION_2 = "show_me_how_iphone_page1_description_2";
  static const String SHOW_ME_HOW_IPHONE_PAGE2_DESCRIPTION_1 = "show_me_how_iphone_page2_description_1";
  static const String SHOW_ME_HOW_IPHONE_PAGE2_DESCRIPTION_2 = "show_me_how_iphone_page2_description_2";
  static const String SHOW_ME_HOW_IPHONE_PAGE3_DESCRIPTION = "show_me_how_iphone_page3_description";
  static const String SHOW_ME_HOW_IPHONE_PAGE4_DESCRIPTION_1 = "show_me_how_iphone_page4_description_1";
  static const String SHOW_ME_HOW_IPHONE_PAGE4_DESCRIPTION_2 = "show_me_how_iphone_page4_description_2";
  static const String SHOW_ME_HOW_IPHONE_PAGE5_DESCRIPTION_1 = "show_me_how_iphone_page5_description_1";
  static const String SHOW_ME_HOW_IPHONE_PAGE5_DESCRIPTION_2 = "show_me_how_iphone_page5_description_2";
  static const String SHOW_ME_HOW_IPHONE_PAGE6_DESCRIPTION = "show_me_how_iphone_page6_description";

  static const String SHOW_ME_HOW_ANDROID_PAGE1_DESCRIPTION_1 = "show_me_how_iphone_page1_description_1";
  static const String SHOW_ME_HOW_ANDROID_PAGE1_DESCRIPTION_2 = "show_me_how_iphone_page1_description_2";
  static const String SHOW_ME_HOW_ANDROID_PAGE2_DESCRIPTION_1 = "show_me_how_iphone_page2_description_1";
  static const String SHOW_ME_HOW_ANDROID_PAGE2_DESCRIPTION_2 = "show_me_how_android_page2_description_2";
  static const String SHOW_ME_HOW_ANDROID_PAGE3_DESCRIPTION = "show_me_how_android_page3_description";
  static const String SHOW_ME_HOW_ANDROID_PAGE4_DESCRIPTION = "show_me_how_android_page4_description";
  static const String SHOW_ME_HOW_ANDROID_PAGE5_DESCRIPTION_1 = "show_me_how_android_page5_description_1";
  static const String SHOW_ME_HOW_ANDROID_PAGE5_DESCRIPTION_2 = "show_me_how_android_page5_description_2";
  static const String SHOW_ME_HOW_ANDROID_PAGE6_DESCRIPTION_1 = "show_me_how_android_page6_description_1";
  static const String SHOW_ME_HOW_ANDROID_PAGE6_DESCRIPTION_2 = "show_me_how_android_page6_description_2";

  static const String SECURITY_WARNING = "security_warning";
  static const String OOPS = "oops";
  static const String WPA_SECURITY_ERROR_MESSAGE = "this_wifi_network_does_not_use_industry_standard";
  static const String UNKNOWN_SECURITY_ERROR_MESSAGE = "this_wifi_network_is_unknown_security";
  static const String WRONG_WIFI_PASSWORD_MESSAGE = "you_may_have_typed_in_the_wrong_wifi_password";
  static const String OPEN_NETWORK_ERROR_MESSAGE = "you_are_trying_to_connect";
  static const String COMMISSIONING_STOP_MESSAGE = "stop_adding_appliance";

  static const String HOME_NETWORK_FIND_ERROR_TITLE = "home_network_find_error_title";
  static const String HOME_NETWORK_FIND_ERROR_MESSAGE = "home_network_find_error_message";

  static const String HOME_BLE_CONNECTION_ERROR_TITLE = "home_ble_connection_error_title";
  static const String HOME_BLE_CONNECTION_ERROR_MESSAGE = "home_ble_connection_error_message";

  static const String HOME_BLE_FAIL_TO_CONNECT_ERROR_TITLE = "home_ble_fail_to_connect_error_title";
  static const String HOME_BLE_FAIL_TO_CONNECT_ERROR_MESSAGE = "home_ble_fail_to_connect_error_message";

  static const String HOME_CHECK_MODULE_STATUS_TITLE = "home_check_module_status_title";
  static const String HOME_CHECK_MODULE_STATUS_MESSAGE = "home_check_module_status_message";

  static const String HOME_BLE_BLUETOOTH_ENABLE_ERROR_TITLE = "home_ble_bluetooth_enable_error_title";
  static const String HOME_BLE_BLUETOOTH_ENABLE_ERROR_MESSAGE = "home_ble_bluetooth_enable_error_message";

  static const String BLE_SCANNING_TEXT1 = "choose_your_appliance_type";
  static const String BLE_SCANNING_TEXT2 = "scanning_nearby_appliances";
  static const String BLE_SCANNING_TEXT3 = "couldnt_find_nearby_appliances";
  static const String BLE_SCANNING_TEXT4 = "turn_on_bluetooth_to_scan";
  static const String RESCAN = "rescan";
  static const String GO_TO_SETTING = "go_to_settings";
  static const String NEARBY = "nearby";

  static const String WINDOW_AIR_CONDITIONER = "window_air_conditioner";
  static const String PORTABLE_AIR_CONDITIONER = "portable_air_conditioner";
  static const String DUCTLESS_AIR_CONDITIONER = "ductless_air_conditioner";
  static const String ADVANTIUM = "advantium";
  static const String WALL_OVEN_KNOB = "wall_oven_knob";
  static const String WALL_OVEN_TOUCH_PAD = "wall_oven_touch_pad";
  static const String RANGE_OR_WALL_OVEN = "range_or_wall_oven";
  static const String RANGE = "range";
  static const String RANGE_KNOB = "range_knob";
  static const String HOOD = "hood";
  static const String MICROWAVE = "microwave";
  static const String INDUCTION_COOKTOP = "induction_cooktop";
  static const PRO_RANGE_2_4 = "pro_range_2_4";
  static const PRO_RANGE_7_0 = "pro_range_7_0";
  static const HEARTH_OVEN = "hearth_oven";
  static const GAS_COOKTOP = "gas_cooktop";
  static const DISHWASHER = "dishwasher";
  static const FRIDGE = "fridge";
  static const WINE_CENTER = "wine_center";
  static const BEVERAGE_CENTER = "beverage_center";
  static const COFFEE_MAKER = "coffee_maker";
  static const TOASTER_OVEN = "toaster_oven";
  static const CAFE_TOASTER_OVEN = "cafe_toaster_oven";
  static const PROFILE_TOASTER_OVEN = "profile_toaster_oven";
  static const OPAL_NUGGET_ICE_MAKER = "opal_nugget_ice_maker";
  static const COUNTER_TOP_TOASTER_OVEN = "counter_top_toaster_oven";
  static const ESPRESSO = "espresso";
  static const MANUAL_ESPRESSO = "manual_espresso";
  static const AUTO_ESPRESSO = "auto_espresso";
  static const ESPRESSO_DESCRIPTION_1 = "espresso_description_1";
  static const ESPRESSO_DESCRIPTION_1_1 = "espresso_description_1_1";
  static const ESPRESSO_DESCRIPTION_1_2 = "espresso_description_1_2";
  static const ESPRESSO_DESCRIPTION_2 = "espresso_description_2";
  static const ESPRESSO_DESCRIPTION_2_1 = "espresso_description_2_1";
  static const ESPRESSO_DESCRIPTION_2_2 = "espresso_description_2_2";
  static const WASHER = "washer";
  static const WASHER_LCD_DISPLAY = "washer_lcd_display";
  static const DRYER = "dryer";
  static const DRYER_LCD_DISPLAY = "dryer_lcd_display";
  static const LAUNDRY_CENTER = "laundry_center";
  static const LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_1 = "laundry_center_wifi_type_description_1";
  static const LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_2 = "laundry_center_wifi_type_description_2";
  static const LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_3 = "laundry_center_wifi_type_description_3";
  static const LAUNDRY_CENTER_WIFI_TYPE_DESCRIPTION_4 = "laundry_center_wifi_type_description_4";
  static const LAUNDRY_CENTER_PORTS_DESCRIPTION = "laundry_center_ports_description";
  static const LAUNDRY_CENTER_CONNECT_PLUS_SETUP_DESCRIPTION = "laundry_center_connect_plus_setup_description";
  static const LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS_DESCRIPTION = "laundry_center_no_wifi_connection_options_description";
  static const LAUNDRY_CENTER_CHECK_WEBSITE_DESCRIPTION = "laundry_center_check_website_description";
  static const LAUNDRY_CENTER_GEA_URL_DESCRIPTION = "laundry_center_gea_url_description";
  static const LAUNDRY_CENTER_GEA_URL = "laundry_center_gea_url";
  static const LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI_DESCRIPTION_1 = "laundry_center_setup_built_in_wifi_description_1";
  static const LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI_DESCRIPTION_2 = "laundry_center_setup_built_in_wifi_description_2";
  static const LAUNDRY_CENTER_SETUP_DRYER_DESCRIPTION_1 = "laundry_center_setup_dryer_description_1";
  static const LAUNDRY_CENTER_SETUP_DRYER_DESCRIPTION_2 = "laundry_center_setup_dryer_description_2";
  static const AIR_CONDITIONER = "air_conditioner";
  static const COOKING = "cooking";
  static const REFRIGERATION = "refrigeration";
  static const WATER_PRODUCTS = "water_products";
  static const COUNTERTOP_APPLIANCES = "countertop_appliances";
  static const LAUNDRY = "laundry";
  static const GATEWAY = "gateway";
  static const String RE_ENTER_PASSWORD = "re_enter_password";
  static const String YES_IT_HAS_BUILT_IN_WIFI = "yes_it_has_bulit_in_wifi";
  static const String HAVE_USB_WIFI_ADAPTER = "no_but_i_have_a_usb_wifi_adapter";
  static const String DISH_DRAWER = "dish_drawer";
  static const String OVEN_TOUCHSCREEN_MODEL = "oven_touchscreen_model";
  static const String DISH_DRAWER_TOP_CONTROL_PANEL = "dish_drawer_top_control_panel";
  static const String DISH_DRAWER_FRONT_CONTROL_PANEL = "dish_drawer_front_control_panel";
  static const String DISHWASHER_TOP_CONTROL_PANEL = "dishwasher_top_control_panel";
  static const String DISHWASHER_FRONT_CONTROL_PANEL = "dishwasher_front_control_panel";
  static const String WASHER_LCD_OR_DRYER_LCD = "washer_lcd_or_dryer_lcd";
  static const String WASHER_LED_DISPLAY = "washer_led_display";
  static const String DRYER_LED_DISPLAY = "dryer_led_display";
  static const String WASHER_LCD = "washer_lcd";
  static const String RANGE_TOUCHSCREEN_MODEL = "range_touchscreen_model";

  static const String INFORMATION_REFRIGERATION_LCD_DISPLAY = "your_refrigerator_has_this_lcd";
  static const String INFORMATION_REFRIGERATION_CAP_TOUCH = "your_refrigerator_has_this_touch";
  static const String INFORMATION_REFRIGERATION_CONNECT_PLUS = "you_have_a_connectplus";
  static const String INFORMATION_REFRIGERATION_INTERNAL_DISPENSE = "your_refrigerator_is_a_bottom_freezer_with_internal_dispenser";
  static const String INFORMATION_REFRIGERATION_SIDE_BY_SIDE = "your_refrigerator_is_side_by_side_with";
  static const String INFORMATION_REFRIGERATION_SIDE_BY_SIDE_NON_DISPENSE = "your_refrigerator_is_side_by_side_without";
  static const String INFORMATION_REFRIGERATION_FOUR_DOOR_BOTTOM_FREEZER = "your_refrigerator_is_a_quad_door";
  static const String INFORMATION_REFRIGERATION_INTERNAL_TEMPERATURE_CONTROL = "your_refrigerator_is_a_bottom_freezer_with_temperature_control";
  static const String INFORMATION_WALL_KNOB_OVEN = "the_oven_may_have_two";
  static const String INFORMATION_WALL_TOUCH_PAD_OVEN = "the_oven_does_not_have";
  static const String INFORMATION_RANGE_OR_WALL_LCD_DISPLAY_OVEN = "your_oven_has_lcd_touch_display";
  static const String INFORMATION_DUCTLESS_AIR_CONDITIONER = "ductless_air_conditioner";
  static const String INFORMATION_LAUNDRY_WASHER_LCD = "your_washer_has_an_lcd_display";
  static const String INFORMATION_DRYER_LCD = "your_dryer_has_an_lcd_display";
  static const String INFORMATION_REFRIGERATION_WINE_CENTER = "your_wine_center_has_this";
  static const String INFORMATION_REFRIGERATION_BEVERAGE_CENTER = "your_beverage_center_has_this_touch_display";
  static const String INFORMATION_DISH_DRAWER_FRONT_CONTROL_PANEL = "information_dish_drawer_front_control_panel";
  static const String INFORMATION_DISH_DRAWER_TOP_CONTROL_PANEL = "information_dish_drawer_top_control_panel";
  static const String INFORMATION_LAUNDRY_WASHER_OR_DRYER_LCD = "information_washer_or_dryer_lcd";
  static const String INFORMATION_LAUNDRY_DRYER_LED = "information_dryer_led";
  static const String INFORMATION_LAUNDRY_WASHER_LED = "information_washer_led";
  static const String INFORMATION_LAUNDRY_WASHER_LCD_FNP = "information_washer_lcd_fnp";

  //Beverage Center
  static const String BEVERAGE_CENTER_DESCRIPTION_TEXT_1 = "beverage_center_description_text_1";
  static const String BEVERAGE_CENTER_DESCRIPTION_TEXT_2 = "beverage_center_description_text_2";
  static const String BEVERAGE_CENTER_DESCRIPTION_TEXT_3 = "beverage_center_description_text_3";
  static const String BEVERAGE_CENTER_DESCRIPTION_TEXT_4 = "beverage_center_description_text_4";
  static const String BEVERAGE_CENTER_DESCRIPTION_TEXT_5 = "beverage_center_description_text_5";
  static const String BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_1 = "beverage_center_appliance_info_text_1";
  static const String BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_2 = "beverage_center_appliance_info_text_2";
  static const String BEVERAGE_CENTER_APPLIANCE_INFO_TEXT_3 = "beverage_center_appliance_info_text_3";

  //Wine Center
  static const String WINE_CENTER_DESCRIPTION_TEXT_1 = "wine_center_description_text_1";
  static const String WINE_CENTER_DESCRIPTION_TEXT_2 = "wine_center_description_text_2";
  static const String WINE_CENTER_DESCRIPTION_TEXT_3 = "wine_center_description_text_3";
  static const String WINE_CENTER_DESCRIPTION_TEXT_4 = "wine_center_description_text_4";
  static const String WINE_CENTER_DESCRIPTION_TEXT_5 = "wine_center_description_text_5";
  static const String WINE_CENTER_APPLIANCE_INFO_TEXT_1 = "wine_center_appliance_info_text_1";
  static const String WINE_CENTER_APPLIANCE_INFO_TEXT_2 = "wine_center_appliance_info_text_2";
  static const String WINE_CENTER_APPLIANCE_INFO_TEXT_3 = "wine_center_appliance_info_text_3";

  //Under Counter Ice Maker
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_1 = "under_counter_ice_maker_description_text_1";
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_2 = "under_counter_ice_maker_description_text_2";
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_3 = "under_counter_ice_maker_description_text_3";
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_4 = "under_counter_ice_maker_description_text_4";
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_5 = "under_counter_ice_maker_description_text_5";
  static const String UNDER_COUNTER_ICE_MAKER_DESCRIPTION_TEXT_6 = "under_counter_ice_maker_description_text_6";
  static const String UNDER_COUNTER_ICE_MAKER_APPLIANCE_INFO_TEXT_1 = "under_counter_ice_maker_appliance_info_text_1";
  static const String UNDER_COUNTER_ICE_MAKER_APPLIANCE_INFO_TEXT_2 = "under_counter_ice_maker_appliance_info_text_2";
  static const String UNDER_COUNTER_ICE_MAKER_APPLIANCE_INFO_TEXT_3 = "under_counter_ice_maker_appliance_info_text_3";

  //Hood
  static const HOOD_SELECT_OPTION_QUESTION = "Which option is shown on your hood?";
  static const HOOD_SEARCH_INFO_LABEL = "Please remove the filter or unlatch the bottom panel, and look for the Connect Appliance Info label.";

  static const COULD_NOT_CONNECT_TO_HOME_WIFE = "could_not_connect_to_home_wifi";

  //Toaster_Oven
  static const TOASTER_OVEN_LETS_GET_STARTED = "toaster_oven_lets_get_started_1";
  static const TOASTER_OVEN_SETUP_WILL_TAKE_ABOUT = "toaster_oven_setup_will_take_about_1";
  static const TOASTER_OVEN_TAP_THE = "toaster_oven_tap_the";
  static const TOASTER_OVEN_TEMP_TIME = "toaster_oven_temp_time_1";
  static const TOASTER_OVEN_AND_PUSH_THE = "toaster_oven_and_push_the_1";
  static const TOASTER_OVEN_KNOB_TO_SELECT = "toaster_oven_knob_to_select_1";
  static const TOASTER_OVEN_LOCATE_LABEL_EXPLAIN_3 = "toaster_oven_locate_label_explain_3";
  static const TOASTER_OVEN_WARM = "warm";
  static const TOASTER_OVEN_REHEAT = "reheat";
  static const TOASTER_OVEN_INSTRUCTIONS = "toaster_oven_instructions";


  static const String LAUNDRY_LOAD_LOCATION = "laundry_load_location";
  static const String LAUNDRY_FRONT_LOAD = "laundry_front_load";
  static const String LAUNDRY_TOP_LOAD = "laundry_top_load";
  static const String LAUNDRY_FRONT_LOAD_MATCHING = "laundry_front_load_matching";
  static const String LAUNDRY_TOP_LOAD_MATCHING = "laundry_top_load_matching";
  static const String DRYER_WHICH_ONE = "dryer_which_one";
  static const String WASHER_WHICH_ONE = "washer_which_one";
  static const String LAUNDRY_FRONT_1_WIFI_1 = "laundry_front_1_wifi_1";
  static const String LAUNDRY_FRONT_1_WIFI_2 = "laundry_front_1_wifi_2";
  static const String LAUNDRY_FRONT_1_WIFI_3 = "laundry_front_1_wifi_3";
  static const String LAUNDRY_FRONT_1_WIFI_4 = "laundry_front_1_wifi_4";
  static const String LAUNDRY_FRONT_1_WIFI_5 = "laundry_front_1_wifi_5";
  static const String LAUNDRY_FRONT_2_P1_WIFI = "laundry_front_2_p1_wifi";
  static const String LAUNDRY_FRONT_2_P2_WIFI = "laundry_front_2_p2_wifi";
  static const String LAUNDRY_TOP_1_P1_WIFI = "laundry_top_1_p1_wifi";
  static const String LAUNDRY_TOP_1_P2_WIFI = "laundry_top_1_p2_wifi";
  static const String LAUNDRY_TOP_2_P1_WIFI = "laundry_top_2_p1_wifi";
  static const String LAUNDRY_TOP_2_P1_1_WIFI = "laundry_top_2_p1_1_wifi";
  static const String LAUNDRY_TOP_2_P2_WIFI = "laundry_top_2_p2_wifi";
  static const String LAUNDRY_TOP_3_P1_WIFI = "laundry_top_1_p1_wifi";
  static const String LAUNDRY_TOP_3_P2_WIFI = "laundry_top_1_p2_wifi";
  static const String LAUNDRY_FRONT_2_STEP_2_1 = "laundry_front_2_step_2_1";
  static const String LAUNDRY_FRONT_2_STEP_2_2 = "laundry_front_2_step_2_2";
  static const String LAUNDRY_FRONT_2_STEP_2_3 = "laundry_front_2_step_2_3";

  //Opal
  static const String OPAL_SETUP_DESC_1 = "opal_setup_desc_1";
  static const String OPAL_SETUP_DESC_2 = "opal_setup_desc_2";
  static const String OPAL_SETUP_DESC_3 = "opal_setup_desc_3";
  static const String OPAL_SETUP_DESC_4 = "opal_setup_desc_4";
  static const String OPAL_SETUP_DESC_5 = "opal_setup_desc_5";
  static const String OPAL_SETUP_DESC_6 = "opal_setup_desc_6";
  static const String OPAL_SETUP_DESC_7 = "opal_setup_desc_7";
  static const String OPAL_PASSWORD_DESC_1 = "opal_password_desc_1";

  //Coffee_Maker
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_1 = "on_your_coffee_maker_press_and_hold_the";
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_2 = "temperature";
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_3 = "and_the";
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_4 = "auto_brew";
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_5 = "button_until_the";
  static const String COFFEE_MAKER_DESCRIPTION_TEXT_6 = "icon_flashes";
  static const String COFFEE_MAKER_APPLIANCE_INFO_TEXT = "on_the_bottom_of_coffee_maker";

  // Small Appliances
  static const String SMALL_APPLIANCES_PASSWORD_SETUP_DESC_1 = "small_appliances_password_setup_desc_1";
  static const String SMALL_APPLIANCES_PASSWORD_SETUP_DESC_2 = "small_appliances_password_setup_desc_2";
  static const String SMALL_APPLIANCES_PASSWORD_SETUP_DESC_3 = "small_appliances_password_setup_desc_3";

  static const String COULD_NOT_CONNEC_TO_HOME_WIFE = "could_not_connect_to_home_wifi";

  //Air Products
  static const String WINDOWS_AC = "windows_ac";
  static const String PORTABLE_AC = "portable_ac";
  static const String DUCTLESS_AC = "ductless_ac";
  static const String DEHUMIDIFIER = "dehumidifier";

  //Ductless AC
  static const String ON = "on";
  static const String REMOTE_CONTROLLER = "remote_controller";
  static const String PRESS = "press";
  static const String POWER = "power";
  static const String BUTTON_TO_TURN_ON_THE_UNIT = "button_to_turn_on_the_unit";
  static const String BUTTON_FOR_5_SECONDS = "button_for_5_seconds";
  static const String WIRED_CONTROLLER = "wired_controller";
  static const String SET_THE_UNIT_TO_COOL = "set_the_unit_to_cool";
  static const String USB_WIFI_DESCRIPTION = "usb_wifi_description";
  static const String FIND_NETWORK_AND_PASSWORD_ON_CONNECTED_APPLIANCE = "find_network_and_password_on_connected_applinace";
  static const String PLEASE_CHECK_USER_MANUAL = "please_check_user_manual";
  static const String WIFI_MODULE_IS_ALREADY_CONNECTED = "wifi_module_is_already_connected";
  static const String LEARN_MORE_ABOUT = "learn_more_about";
  static const String USB_WIFI_ADAPTER = "usb_wifi_adapter";

  //WindowAC
  static const String WINDOW_AC_SETUP_DESC_1 = "window_ac_setup_desc_1";
  static const String WINDOW_AC_SETUP_DESC_2 = "window_ac_setup_desc_2";
  static const String WINDOW_AC_SETUP_DESC_3 = "window_ac_setup_desc_3";
  static const String WINDOW_AC_SETUP_DESC_4 = "window_ac_setup_desc_4";
  static const String WINDOW_AC_SETUP_DESC_5 = "window_ac_setup_desc_5";
  static const String WINDOW_AC_SETUP_DESC_6 = "window_ac_setup_desc_6";
  static const String WINDOW_AC_SETUP_DESC_7 = "window_ac_setup_desc_7";
  static const String WINDOW_AC_SETUP_DESC_8 = "window_ac_setup_desc_8";
  static const String WINDOW_AC_SETUP_DESC_9 = "window_ac_setup_desc_9";
  static const String WINDOW_AC_SETUP_DESC_10 = "window_ac_setup_desc_10";
  static const String WINDOW_AC_SETUP_DESC_11 = "window_ac_setup_desc_11";
  static const String WINDOW_AC_SETUP_DESC_12 = "window_ac_setup_desc_12";
  static const String WINDOW_AC_SETUP_DESC_13 = "window_ac_setup_desc_13";
  static const String WINDOW_AC_SETUP_DESC_14 = "window_ac_setup_desc_14";
  static const String WINDOW_AC_SETUP_DESC_15 = "window_ac_setup_desc_15";
  static const String WINDOW_AC_SETUP_DESC_16 = "window_ac_setup_desc_16";
  static const String WINDOW_AC_SETUP_DESC_17 = "window_ac_setup_desc_17";
  static const String LIGHT_IS_NOT_BLINKING = "light_is_not_blinking";
  static const String LIGHT_IS_BLINKING = "light_is_blinking";
  static const String BACK = "back";

  //Portable AC
  static const String PORTABLE_AC_SETUP_DESC_1 = "portable_ac_setup_desc_1";
  static const String TIMER_HOLD_FOR_3_SEC = "timer_hold_for_3_sec";
  static const String WIFI_BUTTON = "wifi_button";
  static const String PORTABLE_AC_TIMER_DESC_1 = "portable_ac_timer_desc_1";
  static const String PORTABLE_AC_TIMER_DESC_2 = "portable_ac_timer_desc_2";
  static const String PORTABLE_AC_TIMER_DESC_3 = "portable_ac_timer_desc_3";
  static const String PORTABLE_AC_WIFI_DESC_1 = "portable_ac_wifi_desc_1";
  static const String PORTABLE_AC_APPLIANCE_INFO = "portable_ac_appliance_info";

  //Dishwasher
  static const String DISHWASHER_DESCRIPTION_TEXT_1 = "dishwasher_description_text_1";
  static const String DISHWASHER_DESCRIPTION_TEXT_2 = "dishwasher_description_text_2";
  static const String DISHWASHER_DESCRIPTION_TEXT_3 = "dishwasher_description_text_3";
  static const String DISHWASHER_DESCRIPTION_TEXT_4 = "dishwasher_description_text_4";
  static const String DISHWASHER_DESCRIPTION_TEXT_5 = "dishwasher_description_text_5";
  static const String DISHWASHER_DESCRIPTION_TEXT_6 = "dishwasher_description_text_6";
  static const String DISHWASHER_PASSWORD_INFO = "dishwasher_password_info";
  static const String DISHWASHER_APPLIANCE_INFO_TEXT_1 = "dishwasher_appliance_info_text_1";
  static const String DISHWASHER_APPLIANCE_INFO_TEXT_2 = "dishwasher_appliance_info_text_2";
  static const String DISHWASHER_APPLIANCE_INFO_TEXT_3 = "dishwasher_appliance_info_text_3";

  static const String IT_DOESNT_WORK_YOU_MIGHT_NEED = "it_doesn't_work_you_might_need";

  static const String CONNECT_PLUS_2 = "connect_plus_2";
  static const String HI_TEMP_WASH = "hi_temp_wash";

  // Gateway
  static const GATEWAY_DESCRIPTION_1 = "gateway_description_1";
  static const GATEWAY_DESCRIPTION_2 = "gateway_description_2";
  static const GATEWAY_PAIR_DESCRIPTION_1 = "gateway_pair_description_1";
  static const GATEWAY_PAIR_COMMUNICATING_CLOUD_1 = "gateway_pair_communicating_cloud_1";
  static const GATEWAY_PAIR_COMMUNICATING_DESCRIPTION_1 = "gateway_pair_communicating_description_1";
  static const GATEWAY_PAIR_FAILURE_DESCRIPTION_1 = "gateway_pair_failure_description_1";
  static const GATEWAY_FAIL_TO_START_PAIRING_ERROR_TITLE = "gateway_fail_to_start_pairing_error_title";
  static const GATEWAY_FAIL_TO_START_PAIRING_ERROR_MESSAGE = "gateway_fail_to_start_pairing_error_message";
  static const TRYING_TO_START_PAIRING = "trying_to_start_pairing";
  static const COMMUNICATING_WITH_CLOUD = "communicating_with_cloud";
  static const SENSOR_IS_PAIRED_1 = "sensor_is_paired_1";
  static const ENTER_A_NICKNAME_1 = "enter_a_nickname_1";
  static const PAIR_MORE_SENSORS_1 = "pair_more_sensors_1";
  static const DONE_PAIRING_1 = "done_pairing_1";
  static const GATEWAY_SELECT_PAIR_DESCRIPTION_1 = "would_you_like_your_sensor_to_pair_to";
  static const GATEWAY_LIST_SELECT_PAIR_DESCRIPTION_1 = "there_are_multiple_gateways_in_your_account";
  static const SELECT_GATEWAY_1 = "select_gateway_1";
  static const PAIR_TO_GATEWAY_1 = "pair_to_gateway_1";
  static const ADD_NEW_GATEWAY_1 = "+_add_new_gateway_1";
  static const ADD_A_NEW_GATEWAY_1 = "add_a_new_gateway_1";

  //Dishdrawer
  static const LOCATE_DISHDRAWER_CONTROL = "locate_dishdrawer_control";
  static const ON_FRONT_OF_DOOR = "on_front_of_door";
  static const INSIDE_TOP = "inside_top";
  static const THIS_IS_YOUR_CONTROL_PANEL = "this_is_your_control_panel";
  static const PRESS_AND_HOLD_FOR_3S = "press_and_hold_for_3s_until_the_indicator";
  static const SETTING = "Setting";
  static const NOW_PRESS_THIS_BUTTON_AGAIN_AND = "now_press_this_button_again_and_wifi_icon";
  static const DISHDRAWER_ENTERPASSWORD_TEXT_1 = "dd_enter_password_text_1";
  static const PRESS_AND_HOLD_FOR_4S = "press_and_hold_for_4s";
  static const PRESS_AND_HOLD_FOR_4S_AGAIN = "press_and_hold_for_4s_again";
  static const GO_TO_YOUR_DISHDRAWER_AND_OPEN_THE_DOOR = "go_to_your_dishdrawer_and_open_the_door";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_1_PART_1 = "dish_drawer_inside_top_instruction_1_part_1";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_1_PART_2 = "dish_drawer_inside_top_instruction_1_part_2";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_1_PART_3 = "dish_drawer_inside_top_instruction_1_part_3";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_1_PART_4 = "dish_drawer_inside_top_instruction_1_part_4";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_1_PART_5 = "dish_drawer_inside_top_instruction_1_part_5";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_1 = "dish_drawer_inside_top_instruction_2_part_1";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_2 = "dish_drawer_inside_top_instruction_2_part_2";
  static const DISH_DRAWER_INSIDE_TOP_INSTRUCTION_2_PART_3 = "dish_drawer_inside_top_instruction_2_part_3";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_1_PART_1 = "dish_drawer_on_front_of_door_instruction_1_part_1";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_1_PART_2 = "dish_drawer_on_front_of_door_instruction_1_part_2";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_1 = "dish_drawer_on_front_of_door_instruction_2_part_1";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_2 = "dish_drawer_on_front_of_door_instruction_2_part_2";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_3 = "dish_drawer_on_front_of_door_instruction_2_part_3";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_4 = "dish_drawer_on_front_of_door_instruction_2_part_4";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_5 = "dish_drawer_on_front_of_door_instruction_2_part_5";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_6 = "dish_drawer_on_front_of_door_instruction_2_part_6";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_2_PART_7 = "dish_drawer_on_front_of_door_instruction_2_part_7";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_1 = "dish_drawer_on_front_of_door_instruction_3_part_1";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_2 = "dish_drawer_on_front_of_door_instruction_3_part_2";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_3 = "dish_drawer_on_front_of_door_instruction_3_part_3";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_4 = "dish_drawer_on_front_of_door_instruction_3_part_4";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_INSTRUCTION_3_PART_5 = "dish_drawer_on_front_of_door_instruction_3_part_5";

  static const APPLIANCE = "appliance";
  static const OVEN = "oven";
  static const HOME_GROWER = "home_grower";
  static const UNDER_COUNTER_ICE_MAKER = "under_counter_ice_maker";
  static const ZONELINE = "zoneline";
  static const ELECTRIC_RANGE = "electric_range";
  static const GAS_RANGE = "gas_range";
  static const ELECTRIC_COOKTOP = "electric_cooktop";
  static const COMBO = "combo";
  static const EXPRESSO = "expresso";
  static const DELIVERY_BOX = "delivery_box";

  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_1 = "laundry_washer_fnp_front_1_remote_wifi_description_text_1";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_2 = "laundry_washer_fnp_front_1_remote_wifi_description_text_2";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_3 = "laundry_washer_fnp_front_1_remote_wifi_description_text_3";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_1 = "laundry_washer_fnp_front_2_remote_wifi_description_text_1";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_2 = "laundry_washer_fnp_front_2_remote_wifi_description_text_2";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_3 = "laundry_washer_fnp_front_2_remote_wifi_description_text_3";
  static const LAUNDRY_WASHER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_4 = "laundry_washer_fnp_front_2_remote_wifi_description_text_4";

  static const INTEGRATED_COLUMN_REFRIGERATOR_OR_FREEZER = "integrated_column_refrigerator_or_freezer";
  static const INTEGRATED_COLUMN_WINE_CABINET = "integrated_column_wine_cabinet";
  static const ACTIVE_SMART_REFRIGERATOR_FREEZER = "active_smart_refrigerator_freezer";
  static const QUAD_DOOR = "quad_door";

  static const COMBI_COMM_PAGE1_PART1 = "combi_comm_page1_part1";
  static const COMBI_COMM_PAGE1_PART2 = "combi_comm_page1_part2";
  static const COMBI_COMM_PAGE1_PART3 = "combi_comm_page1_part3";
  static const COMBI_COMM_PAGE1_PART4 = "combi_comm_page1_part4";
  static const COMBI_COMM_PAGE1_PART5 = "combi_comm_page1_part5";
  static const COMBI_COMM_PAGE1_PART6 = "combi_comm_page1_part6";
  static const COMBI_COMM_PAGE1_PART7 = "combi_comm_page1_part7";
  static const COMBI_COMM_PAGE1_PART8 = "combi_comm_page1_part8";
  static const COMBI_COMM_PAGE1_PART9 = "combi_comm_page1_part9";
  static const COMBI_COMM_PAGE1_PART10 = "combi_comm_page1_part10";
  static const COMBI_COMM_PAGE1_PART11 = "combi_comm_page1_part11";
  static const COMBI_COMM_PAGE1_PART12 = "combi_comm_page1_part12";

  // Wifi locker
  static const CONNECTING_THE_APPLIANCE_TO = "connecting_the_appliance_to";
  static const PICK_ANOTHER_WIFI = "pick_another_wifi";
  static const OR_YOU_CAN = "or_you_can";
  static const PASSWORD_CHANGED = "password_changed";
  static const MANAGE_SAVED_NETWORKS = "manage_saved_networks";
  static const SAVED_NETWORKS = "saved_networks";
  static const NO_SAVED_NETWORKS = "no_saved_networks";
  static const NETWORKS = "networks";
  static const SAVED = "saved";
  static const EDIT = "edit";
  static const EDIT_SAVED_NETWORK = "edit_saved_network";
  static const SAVE = "save";
  static const REMOVE_THIS_SAVED_NETWORK = "remove_this_saved_network";
  static const REMEMBER_THIS_NETWORK = "remember_this_network";
  static const NETWORK_REMOVED = "network_removed";
  static const NETWORK_REMOVED_EXPLAIN = "network_removed_explain";
  static const NO_BLE_NETWORK = "no_ble_network";
  static const SAVE_YOUR_WIFI_INFORMATION = "save_your_wifi_information";
  static const NO_NETWORK_SAVED = "no_network_saved";
  static const SAVE_A_NETWORK_WHEN_YOU_CONNECT = "save_network_when_you_connect";

  // Connect Plus
  static const CONNECT_PLUS_DISH_REMOVE_BOTTOM_TEXT = "connect_plus_dish_remove_bottom_text";

  //Cooking
  static const String WALL_OVEN = "wall_oven";
  static const String COOKTOP = "cooktop";
  static const String VENTILATION = "ventilation";

  //HearthOven
  static const HEARTH_OVEN_DESCRIPTION_TEXT_1 = "hearth_oven_description_text_1";
  static const HEARTH_OVEN_DESCRIPTION_TEXT_2 = "hearth_oven_description_text_2";
  static const HEARTH_OVEN_DESCRIPTION_TEXT_3 = "hearth_oven_description_text_3";
  static const HEARTH_OVEN_DESCRIPTION_TEXT_4 = "hearth_oven_description_text_4";
  static const HEARTH_OVEN_PREFERENCE_TEXT_1 = "hearth_oven_preference_text_1";
  static const HEARTH_OVEN_PREFERENCE_TEXT_2 = "hearth_oven_preference_text_2";
  static const HEARTH_OVEN_PREFERENCE_TEXT_3 = "hearth_oven_preference_text_3";
  static const HEARTH_OVEN_PREFERENCE_TEXT_4 = "hearth_oven_preference_text_4";
  static const HEARTH_OVEN_PREFERENCE_TEXT_5 = "hearth_oven_preference_text_5";
  static const HEARTH_OVEN_WIFI_TEXT_1 = "hearth_oven_wifi_text_1";
  static const HEARTH_OVEN_WIFI_TEXT_2 = "hearth_oven_wifi_text_2";
  static const HEARTH_OVEN_WIFI_TEXT_3 = "hearth_oven_wifi_text_3";
  static const HEARTH_OVEN_APPLIANCE_PASSWORD_INFO = "hearth_oven_password_info";

  //Cooktop
  static const String COOKTOP_INDCUTION_DESCRIPTION_TEXT_1 = "cooktop_induction_description_text_1";
  static const String COOKTOP_INDCUTION_DESCRIPTION_TEXT_2 = "cooktop_induction_description_text_2";
  static const String COOKTOP_INDCUTION_DESCRIPTION_TEXT_3 = "cooktop_induction_description_text_3";
  static const String COOKTOP_INDUCTION_ADD_TEXT_1 = "cooktop_induction_add_text_1";
  static const String COOKTOP_INDUCTION_ADD_TEXT_2 = "cooktop_induction_add_text_2";
  static const String COOKTOP_INDUCTION_ADD_TEXT_3 = "cooktop_induction_add_text_3";
  static const String COOKTOP_INDUCTION_ADD_TEXT_4 = "cooktop_induction_add_text_4";
  static const String COOKTOP_INDUCTION_ADD_TEXT_5 = "cooktop_induction_add_text_5";
  static const String COOKTOP_INDUCTION_OFF_TEXT_1 = "cooktop_induction_off_text_1";
  static const String COOKTOP_INDUCTION_OFF_TEXT_2 = "cooktop_induction_off_text_2";
  static const String COOKTOP_INDUCTION_OFF_TEXT_3 = "cooktop_induction_off_text_3";
  static const String COOKTOP_INDUCTION_OFF_TEXT_4 = "cooktop_induction_off_text_4";
  static const String COOKTOP_INDUCTION_OFF_TEXT_5 = "cooktop_induction_off_text_5";
  static const String COOKTOP_INDUCTION_APPLIANCE_INFO_TEXT = "cooktop_induction_appliance_info_text";

  static const String COOKTOP_GAS_DESCRIPTION_TEXT_1 = "cooktop_gas_description_text_1";
  static const String COOKTOP_GAS_DESCRIPTION_TEXT_2 = "cooktop_gas_description_text_2";
  static const String COOKTOP_GAS_DESCRIPTION_TEXT_3 = "cooktop_gas_description_text_3";
  static const String COOKTOP_GAS_DESCRIPTION_TEXT_4 = "cooktop_gas_description_text_4";
  static const String COOKTOP_GAS_DESCRIPTION_TEXT_5 = "cooktop_gas_description_text_5";
  static const String COOKTOP_GAS_STEP_1_TEXT_1 = "cooktop_gas_step_1_text_1";
  static const String COOKTOP_GAS_STEP_1_TEXT_2 = "cooktop_gas_step_1_text_2";
  static const String COOKTOP_GAS_STEP_1_TEXT_3 = "cooktop_gas_step_1_text_3";
  static const String COOKTOP_GAS_STEP_1_TEXT_4 = "cooktop_gas_step_1_text_4";
  static const String COOKTOP_GAS_STEP_1_TEXT_5 = "cooktop_gas_step_1_text_5";
  static const String COOKTOP_GAS_STEP_1_TEXT_6 = "cooktop_gas_step_1_text_6";
  static const String COOKTOP_GAS_STEP_2_TEXT_1 = "cooktop_gas_step_2_text_1";
  static const String COOKTOP_GAS_STEP_2_TEXT_2 = "cooktop_gas_step_2_text_2";
  static const String COOKTOP_GAS_STEP_2_TEXT_3 = "cooktop_gas_step_2_text_3";
  static const String COOKTOP_GAS_APPLIANCE_INFO_TEXT = "cooktop_gas_appliance_info_text";

  //Advantium
  static const String ADVANTIUM_DESCRIPTION_TEXT_1 = "advantium_description_text_1";
  static const String ADVANTIUM_DESCRIPTION_TEXT_2 = "advantium_description_text_2";
  static const String ADVANTIUM_DESCRIPTION_TEXT_3 = "advantium_description_text_3";
  static const String ADVANTIUM_DESCRIPTION_TEXT_4 = "advantium_description_text_4";
  static const String ADVANTIUM_DESCRIPTION_TEXT_5 = "advantium_description_text_5";
  static const String ADVANTIUM_PASSWORD_TEXT_1 = "advantium_password_text_1";
  static const String ADVANTIUM_PASSWORD_TEXT_2 = "advantium_password_text_2";
  static const String ADVANTIUM_PASSWORD_TEXT_3 = "advantium_password_text_3";

  //Microwave
  static const String MICROWAVE_DESCRIPTION_TEXT_1 = "microwave_description_text_1";
  static const String MICROWAVE_DESCRIPTION_TEXT_2 = "microwave_description_text_2";
  static const String MICROWAVE_DESCRIPTION_TEXT_3 = "microwave_description_text_3";
  static const String MICROWAVE_DESCRIPTION_TEXT_4 = "microwave_description_text_4";
  static const String MICROWAVE_APPLIANCE_INFO = "microwave_network_and_password_info";
  static const String MICROWAVE_APPLIANCE_PASSWORD_INFO = "microwave_password_info";

  //range
  static const RANGE_LCD_DESCRIPTION_TEXT_1 = "range_lcd_description_text_1";
  static const RANGE_LCD_DESCRIPTION_TEXT_2 = "range_lcd_description_text_2";
  static const RANGE_HAIER_KNOB_DESCRIPTION_TEXT_1 = "range_haier_knob_description_text_1";
  static const RANGE_HAIER_KNOB_DESCRIPTION_TEXT_2 = "range_haier_knob_description_text_2";
  static const RANGE_HAIER_KNOB_DESCRIPTION_TEXT_3 = "range_haier_knob_description_text_3";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_1 = "range_pro_range_description_text_1";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_2 = "range_pro_range_description_text_2";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_3 = "range_pro_range_description_text_3";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_4 = "range_pro_range_description_text_4";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_5 = "range_pro_range_description_text_5";
  static const RANGE_PRO_RANGE_DESCRIPTION_TEXT_6 = "range_pro_range_description_text_6";
  static const WHICH_BUTTON_DOES_YOUR_RANGE_HAS = "which_button_does_your_range_has";
  static const RANGE_REMOTE_ENABLE_BUTTON = "range_remote_enable_button";
  static const RANGE_WIFI_CONNECT_BUTTON = "range_wifi_connect_button";
  static const RANGE_SETTING_BUTTON = "range_setting_button";
  static const RANGE_REMOTE_ENABLE_DESCRIPTION_TEXT_1 = "range_remote_enable_description_text_1";
  static const RANGE_REMOTE_ENABLE_DESCRIPTION_TEXT_2 = "range_remote_enable_description_text_2";
  static const RANGE_REMOTE_ENABLE_DESCRIPTION_TEXT_3 = "range_remote_enable_description_text_3";
  static const RANGE_REMOTE_ENABLE_DESCRIPTION_TEXT_4 = "range_remote_enable_description_text_4";
  static const RANGE_WIFI_CONNECT_DESCRIPTION_TEXT_1 = "range_wifi_connect_description_text_1";
  static const RANGE_WIFI_CONNECT_DESCRIPTION_TEXT_2 = "range_wifi_connect_description_text_2";
  static const RANGE_WIFI_CONNECT_DESCRIPTION_TEXT_3 = "range_wifi_connect_description_text_3";
  static const RANGE_WIFI_CONNECT_DESCRIPTION_TEXT_4 = "range_wifi_connect_description_text_4";
  static const RANGE_SETTINGS_DESCRIPTION_TEXT_1 = "range_settings_description_text_1";
  static const RANGE_SETTINGS_DESCRIPTION_TEXT_2 = "range_settings_description_text_2";
  static const RANGE_SETTINGS_DESCRIPTION_TEXT_3 = "range_settings_description_text_3";
  static const RANGE_SETTINGS_DESCRIPTION_TEXT_4 = "range_settings_description_text_4";
  static const RANGE_SETTINGS_DESCRIPTION_TEXT_5 = "range_settings_description_text_5";
  static const RANGE_HAIER_KNOB_APPLIANCE_INFO = "range_haier_knob_appliance_info";
  static const PASSWORD_ON_CONNECTED_APPLIANCE_LABEL = "password_on_connected_appliance_label";

  // Wall oven
  static const String WALL_OVEN_SELECTION_TEXT_PRIMARY = "wall_oven_selection_text_primary";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_1 = "wall_oven_type_3_primary_desc_1";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_2 = "wall_oven_type_3_primary_desc_2";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_3 = "wall_oven_type_3_primary_desc_3";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_4 = "wall_oven_type_3_primary_desc_4";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_5 = "wall_oven_type_3_primary_desc_5";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_6 = "wall_oven_type_3_primary_desc_6";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_7 = "wall_oven_type_3_primary_desc_7";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_8 = "wall_oven_type_3_primary_desc_8";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_9 = "wall_oven_type_3_primary_desc_9";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_10 = "wall_oven_type_3_primary_desc_10";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_11 = "wall_oven_type_3_primary_desc_11";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_12 = "wall_oven_type_3_primary_desc_12";
  static const String WALL_OVEN_TYPE_3_PRIMARY_DESC_13 = "wall_oven_type_3_primary_desc_13";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_14 = "wall_oven_type_1_primary_desc_14";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_15 = "wall_oven_type_1_primary_desc_15";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_16 = "wall_oven_type_1_primary_desc_16";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_17 = "wall_oven_type_1_primary_desc_17";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_18 = "wall_oven_type_1_primary_desc_18";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_19 = "wall_oven_type_1_primary_desc_19";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_20 = "wall_oven_type_1_primary_desc_20";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_21 = "wall_oven_type_1_primary_desc_21";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_22 = "wall_oven_type_1_primary_desc_22";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_23 = "wall_oven_type_1_primary_desc_23";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_24 = "wall_oven_type_1_primary_desc_24";
  static const String WALL_OVEN_TYPE_1_PRIMARY_DESC_25 = "wall_oven_type_1_primary_desc_25";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_01 = "wall_oven_type_2_primary_desc_01";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_02 = "wall_oven_type_2_primary_desc_02";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_03 = "wall_oven_type_2_primary_desc_03";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_04 = "wall_oven_type_2_primary_desc_04";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_05 = "wall_oven_type_2_primary_desc_05";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_06 = "wall_oven_type_2_primary_desc_06";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_07 = "wall_oven_type_2_primary_desc_07";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_08 = "wall_oven_type_2_primary_desc_08";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_09 = "wall_oven_type_2_primary_desc_09";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_10 = "wall_oven_type_2_primary_desc_10";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_11 = "wall_oven_type_2_primary_desc_11";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_12 = "wall_oven_type_2_primary_desc_12";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_13 = "wall_oven_type_2_primary_desc_13";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_14 = "wall_oven_type_2_primary_desc_14";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_15 = "wall_oven_type_2_primary_desc_15";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_16 = "wall_oven_type_2_primary_desc_16";
  static const String WALL_OVEN_TYPE_2_PRIMARY_DESC_17 = "wall_oven_type_2_primary_desc_17";

  //Water products
  static const WATER_HEATER = "water_heater";
  static const WHOLE_HOME_WATER_FILTER = "whole_home_water_filter";
  static const HOUSEHOLD_WATER_SOFTENER = "household_water_softener";

  //Water Softener
  static const WATER_SOFTENER_DESCRIPTION_TEXT_1 = "water_softener_description_text_1";
  static const WATER_SOFTENER_DESCRIPTION_TEXT_2 = "water_softener_description_text_2";
  static const WATER_SOFTENER_DESCRIPTION_TEXT_3 = "water_softener_description_text_3";
  static const WATER_SOFTENER_APPLIANCE_INFO_TEXT_1 = "water_softener_appliance_info_text_1";
  static const WATER_SOFTENER_APPLIANCE_INFO_TEXT_2 = "water_softener_appliance_info_text_2";
  static const WATER_SOFTENER_APPLIANCE_INFO_TEXT_3 = "water_softener_appliance_info_text_3";

  //Water Heater
  static const WATER_HEATER_DESCRIPTION_TEXT_1 = "water_heater_description_text_1";
  static const WATER_HEATER_DESCRIPTION_TEXT_2 = "water_heater_description_text_2";
  static const WATER_HEATER_DESCRIPTION_TEXT_3 = "water_heater_description_text_3";
  static const WATER_HEATER_DESCRIPTION_TEXT_4 = "water_heater_description_text_4";
  static const WATER_HEATER_APPLIANCE_INFO_TEXT_1 = "water_heater_appliance_info_text_1";
  static const WATER_HEATER_APPLIANCE_INFO_TEXT_2 = "water_heater_appliance_info_text_2";
  static const WATER_HEATER_APPLIANCE_INFO_TEXT_3 = "water_heater_appliance_info_text_3";

  //Water Filter
  static const WATER_FILTER_DESCRIPTION_TEXT_1 = "water_filter_description_text_1";
  static const WATER_FILTER_DESCRIPTION_TEXT_2 = "water_filter_description_text_2";
  static const WATER_FILTER_DESCRIPTION_TEXT_3 = "water_filter_description_text_3";
  static const WATER_FILTER_APPLIANCE_INFO_TEXT_1 = "water_filter_appliance_info_text_1";
  static const WATER_FILTER_APPLIANCE_INFO_TEXT_2 = "water_filter_appliance_info_text_2";
  static const WATER_FILTER_APPLIANCE_INFO_TEXT_3 = "water_filter_appliance_info_text_3";


  static const String COOKTOP_ELECTRIC_DESCRIPTION_TEXT_1 = "cooktop_electric_description_text_1";
  static const String COOKTOP_ELECTRIC_DESCRIPTION_TEXT_2 = "cooktop_electric_description_text_2";
  static const String COOKTOP_ELECTRIC_DESCRIPTION_TEXT_3 = "cooktop_electric_description_text_3";
  static const String COOKTOP_ELECTRIC_DESCRIPTION_TEXT_4 = "cooktop_electric_description_text_4";

  //grind_brew
  static const String COFFEE_BREWER = "coffee_brewer";
  static const String GRIND_BREW = "grind_brew";
  static const String GRIND_BREW_ON_THE = "grind_brew_on_the";
  static const String GRIND_BREW_SETTINGS_BUTTON = "grind_brew_settings_button";
  static const String GRIND_BREW_USE_THE = "grind_brew_use_the";
  static const String GRIND_BREW_ARROW_BUTTON = "grind_brew_arrow_button";
  static const String GRIND_BREW_TO_NAVIGATE = "grind_brew_to_navigate";
  static const String GRIND_BREW_CHANGE_TO = "grind_brew_change_to";
  static const String GRIND_BREW_THE_SCREEN = "grind_brew_the_screen";
  static const String GRIND_BREW_BUTTON_NAMES = "grind_brew_button_names";
  static const String FOUND_ON_YOUR_GRIND_BREW_DISPLAY = "found_on_your_grind_brew_display";
  static const String GRIND_BREW_FAILED_DIALOG = "grind_brew_failed_dialog";

  //Stand Mixer
  static const STAND_MIXER = "stand_mixer";
  static const PROFILE_SMART_MIXER = "profile_smart_mixer";
  static const STAND_MIXER_SETUP_WILL_TAKE_ABOUT = "stand_mixer_setup_will_take_about_1";
  static const STAND_MIXER_LOCATE_LABEL_EXPLAIN_3 = "stand_mixer_locate_label_explain_3";
  static const STAND_MIXER_ROTATE_KNOB = "stand_mixer_rotate_knob";
  static const STAND_MIXER_PRESS_AND_HOLD = "stand_mixer_press_and_hold";
  static const STAND_MIXER_TO_BEGIN_COMMISSIONING = "stand_mixer_to_begin_commissioning";
  static const STAND_MIXER_IF_DONE_CORRECTLY_1 = "stand_mixer_if_done_correctly_1";
  static const STAND_MIXER_IF_DONE_CORRECTLY_2 = "stand_mixer_if_done_correctly_2";
  static const STAND_MIXER_SET_TO_REMOTE_ENABLED_POPUP = "stand_mixer_set_to_remote_enabled_popup";
  static const START = "start";
  static const CENTER_BUTTON = "center_button";
  static const FOR = "for";
  static const THREE_SECONDS = "three_seconds";
  static const LETS_START = "lets_start";
  static const SMARTSENSE_IS_A_SMART_HOME_APPLIANCE = "smartsense_is_a_smart_home_appliance";
  static const MY_FAVORITES = "my_favorites";
  static const ACCESSORIES_HACK = "accessories_hack";
  static const DIAGNOSTICS = "diagnostics";
  static const OFF = "off";
  static const REMOTE_ENABLED = "remote_enabled";
  static const MANUAL_MODE = "manual_mode";
  static const ADD_TIMER = "add_timer_1";
  static const MIX_TIME = "mix_time_1";
  static const SET = "set_1";
  static const SEC = "sec_1";
  static const MIN = "min_1";
  static const RETRIEVING_DATA = "retrieving_data";
  static const STAND_MIXER_FAILED_DIALOG = "stand_mixer_failed_dialog";
  static const TOASTER_OVEN_FAILED_DIALOG = "toaster_oven_failed_dialog";
  static const OFFLINE = "offline";

  //Recipe's
  static const STAND_MIXER_SMART_SENSE = "auto_sense";
  static const STAND_MIXER_SMART_SENSE_INFO_CARD_1 = "stand_mixer_smart_sense_info_card_1";
  static const STAND_MIXER_SMART_SENSE_INFO_CARD_2 = "stand_mixer_smart_sense_info_card_2";
  static const STAND_MIXER_SMART_SENSE_INFO_CARD_3 = "stand_mixer_smart_sense_info_card_3";
  static const STAND_MIXER_SMART_SENSE_INFO_CARD_4 = "stand_mixer_smart_sense_info_card_4";
  static const STAND_MIXER_GUIDED_INFO_CARD_1 = "stand_mixer_guided_info_card_1";
  static const STAND_MIXER_GUIDED_INFO_CARD_2 = "stand_mixer_guided_info_card_2";
  static const STAND_MIXER_GUIDED_INFO_CARD_3 = "stand_mixer_guided_info_card_3";
  static const STAND_MIXER_GUIDED_INFO_CARD_4 = "stand_mixer_guided_info_card_4";
  static const DISCOVER_RECIPES = "discover_recipes";
  static const AUTO_SENSE = "auto_sense";
  static const GUIDED = "guided";
  static const RECIPES = "recipes";
  static const AUTO_SENSE_DISCOVER_DESCRIPTION = "auto_sense_discover_description";
  static const STAND_MIXER_AUTO_SENSE_DISCOVER_DESCRIPTION =  "stand_mixer_auto_sense_discover_description";
  static const PROFILE_STAND_MIXER_AUTO_SENSE_DISCOVER_DESCRIPTION =  "profile_stand_mixer_auto_sense_discover_description";
  static const GUIDED_DISCOVER_DESCRIPTION = "guided_discover_description";
  static const GUIDED_DISCOVER_DESCRIPTION_STAND_MIXER = "guided_discover_description_stand_mixer";
  static const GUIDED_DISCOVER_DESCRIPTION_PROFILE_SMART_MIXER = "guided_discover_description_profile_smart_mixer";
  static const PROFILE_GUIDED_DISCOVER_DESCRIPTION_SPEEDCOOK = "profile_guided_discover_description_speedcook";
  static const GUIDED_DISCOVER_DESCRIPTION_SPEEDCOOK = "guided_discover_description_speedcook";
  static const WEIGH_INGREDIENT = "weigh_ingredient";
  static const SEND_TO_MIXER = "send_to_mixer";
  static const SENT_TO_MIXER = "sent_to_mixer";
  static const PRESS_CENTER_BUTTON_MIXER = "press_center_button_mixer";
  static const ATTACH_MIXING_BOWL = "attach_mixing_bowl";
  static const ESTIMATED_TIME = "estimated_time";
  static const SPEED = "speed";
  static const STEP = "step";
  static const WELL_DONE_CHEF = "well_done_chef";
  static const ENJOY_YOUR_WORK = "enjoy_your_work";
  static const FINISH = "finish";
  static const RECIPE_COMPLETE = "recipe_complete";
  static const SERVING_SIZE = "serving_size";
  static const ABOUT = "about";
  static const VIEW_STEPS = "view_steps";
  static const PREFERENCES = "preferences";
  static const INGREDIENTS = "ingredients";
  static const EQUIPMENT = "equipment";
  static const WHILE_MIXING = "while_mixing";
  static const STEP_COMPLETED = "step_completed";
  static const STEP_ALREADY_COMPLETE = "step_already_complete";
  static const UP_NEXT = "up_next";
  static const STEPS = "steps";
  static const PRESS_TO_WEIGH = "press_to_weigh";
  static const BEFORE_MIXING = "before_mixing";

  //ERRORS
  static const ERROR_DEFAULT = "error_default";
  static const ERROR_REASON_RECIPE_NOT_SUPPORTED = "error_reason_recipe_not_supported";
  static const ERROR_REASON_TRY_AGAIN = "error_reason_try_again";
  static const ERROR_REASON_APPLIANCE_FOOD_NOT_DETECTED = "error_reason_food_not_detected";
  static const ERROR_REASON_MICROWAVE_DOOR_IS_OPEN = "error_reason_microwave_door_is_open";
  static const ERROR_REASON_ADVANTIUM_DOOR_IS_OPEN = "error_reason_oven_door_is_open";
  static const ERROR_REASON_APPLIANCE_IS_BUSY = "error_reason_appliance_is_busy";
  static const ERROR_REASON_RECIPE_NOT_FOUND = "error_reason_recipe_not_found";
  static const ERROR_REASON_MICROWAVE_IS_RUNNING = "error_reason_microwave_is_running";
  static const ERROR_REASON_ADVANTIUM_IS_RUNNING = "error_reason_oven_is_running";
  static const ERROR_REASON_INVALID_OVEN_CAVITY = "error_reason_invalid_oven_cavity";
  static const ERROR_REASON_INVALID_SINGLE_OVEN_CAVITY = "error_reason_invalid_single_oven_cavity";
  static const ERROR_REASON_INVALID_CAVITY = "error_reason_invalid_cavity";
  static const ERROR_REASON_UNSUPPORTED_REQUEST = "error_reason_unsupported_request";
  static const ERROR_REASON_MIXER_ACTIVE = "error_reason_mixer_active";
  static const ERROR_REASON_APPLIANCE_OFFLINE = "error_reason_appliance_offline";
  static const GOT_IT = "got_it";
  static const COMPLETE = "complete";
  static const MIXING = "mixing";
  static const UNDEFINED = "undefined";
  static const ERROR = "error";

  static const MIX_TIMER = "mix_timer";

  //HAier AC
  static const HI_WALL_SPLIT = "hi_wall_split";
  static const DUCTED = "ducted";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_1 =
      "ac_built_in_getting_started_description_1";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_2 =
      "ac_built_in_getting_started_description_2";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_3 =
      "ac_built_in_getting_started_description_3";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_4 =
      "ac_built_in_getting_started_description_4";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_5 =
      "ac_built_in_getting_started_description_5";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_6 =
      "ac_built_in_getting_started_description_6";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_7 =
      "ac_built_in_getting_started_description_7";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_8 =
      "ac_built_in_getting_started_description_8";
  static const AC_BUILT_IN_GETTING_STARTED_DESCRIPTION_9 =
      "ac_built_in_getting_started_description_9";
  static const AC_WIFI_ADAPTER_GETTING_STARTED_DESCRIPTION_1 =
      "ac_wifi_adapter_getting_started_description_1";
  static const AC_WIFI_ADAPTER_GETTING_STARTED_DESCRIPTION_2 =
      "ac_wifi_adapter_getting_started_description_2";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_1 =
      "ac_wifi_adapter_enable_commissioning_description_1";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_2 =
      "ac_wifi_adapter_enable_commissioning_description_2";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_3 =
      "ac_wifi_adapter_enable_commissioning_description_3";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_4 =
      "ac_wifi_adapter_enable_commissioning_description_4";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_5 =
      "ac_wifi_adapter_enable_commissioning_description_5";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_6 =
      "ac_wifi_adapter_enable_commissioning_description_6";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_7 =
      "ac_wifi_adapter_enable_commissioning_description_7";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_8 =
      "ac_wifi_adapter_enable_commissioning_description_8";
  static const AC_WIFI_ADAPTER_ENABLE_COMMISSIONING_DESCRIPTION_9 =
      "ac_wifi_adapter_enable_commissioning_description_9";
  static const AC_LOCATE_LABEL_DESCRIPTION_1 = "ac_locate_label_description_1";
  static const ENTER_THE_PASSWORD_FOUND_ON_THE_LABEL_HAIER_AC = "enter_the_password_found_on_the_label_haier_ac";
  static const SETUP_WILL_TAKE_ABOUT_10_MIN_TEXT_HAIER_AC = "setup_will_take_about_10_min_text_haier_ac";
  static const DOES_YOUR_UNIT_HAVE_BUILT_IN_WIFI_TEXT_HAIER_AC = "does_your_unit_have_built_in_wifi_text_haier_ac";
  static const PLEASE_CHECK_USER_MANUAL_TEXT_HAIER_AC = "please_check_user_manual_text_haier_ac";
  static const YES_IT_HAS_BULIT_IN_WIFI_TEXT_HAIER_AC = "yes_it_has_bulit_in_wifi_text_haier_ac";
  static const NO_BUT_I_HAVE_A_USB_WIFI_ADAPTER_TEXT_HAIER_AC = "no_but_i_have_a_usb_wifi_adapter_text_haier_ac";

  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_1 = "cooking_range_fnp_model_1_instruction_part_1";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_2 = "cooking_range_fnp_model_1_instruction_part_2";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_3 = "cooking_range_fnp_model_1_instruction_part_3";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_4 = "cooking_range_fnp_model_1_instruction_part_4";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_5 = "cooking_range_fnp_model_1_instruction_part_5";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_6 = "cooking_range_fnp_model_1_instruction_part_6";
  static const COOKING_RANGE_FNP_MODEL_1_INSTRUCTION_PART_7 = "cooking_range_fnp_model_1_instruction_part_7";

  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_1 = "cooking_wall_oven_fnp_model_1_instruction_part_1";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_2 = "cooking_wall_oven_fnp_model_1_instruction_part_2";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_3 = "cooking_wall_oven_fnp_model_1_instruction_part_3";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_4 = "cooking_wall_oven_fnp_model_1_instruction_part_4";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_5 = "cooking_wall_oven_fnp_model_1_instruction_part_5";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_6 = "cooking_wall_oven_fnp_model_1_instruction_part_6";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_7 = "cooking_wall_oven_fnp_model_1_instruction_part_7";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_8 = "cooking_wall_oven_fnp_model_1_instruction_part_8";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_9 = "cooking_wall_oven_fnp_model_1_instruction_part_9";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_10 = "cooking_wall_oven_fnp_model_1_instruction_part_10";
  static const COOKING_WALL_OVEN_FNP_MODEL_1_INSTRUCTION_PART_11 = "cooking_wall_oven_fnp_model_1_instruction_part_11";
  static const COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_1 = "cooking_wall_oven_fnp_model_2_page_4_instruction_part_1";
  static const COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_2 = "cooking_wall_oven_fnp_model_2_page_4_instruction_part_2";
  static const COOKING_WALL_OVEN_FNP_MODEL_2_PAGE_4_INSTRUCTION_PART_3 = "cooking_wall_oven_fnp_model_2_page_4_instruction_part_3";
  static const ENTER_THE_PASSWORD_FOUND_ON_YOUR_WALL_OVEN_DISPLAY = "enter_the_password_found_on_your_wall_oven_display";
  static const READY = "ready";

  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_1_PART_1 = "cooking_wall_oven_haier_model_1_instruction_1_part_1";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_1_PART_2 = "cooking_wall_oven_haier_model_1_instruction_1_part_2";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_1 = "cooking_wall_oven_haier_model_1_instruction_2_part_1";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_2 = "cooking_wall_oven_haier_model_1_instruction_2_part_2";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_2_PART_3 = "cooking_wall_oven_haier_model_1_instruction_2_part_3";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_3_PART_1 = "cooking_wall_oven_haier_model_1_instruction_3_part_1";
  static const COOKING_WALL_OVEN_HAIER_MODEL_1_INSTRUCTION_3_PART_2 = "cooking_wall_oven_haier_model_1_instruction_3_part_2";
  static const ENSURE_THERE_IS_NO_COOKING_IN_PROGRESS = "ensure_there_is_no_cooking_in_progress";
  static const NOW_PRESS_THIS_BUTTON_AGAIN_AND_WIFI_ICON_WILL_FLASH = "now_press_this_button_again_and_wifi_icon_will_flash";

  static const WHICH_ONE_DESCRIBES_YOUR_WALL_OVEN = "Which_one_describes_your_wall_oven";
  static const TOUCH_YOUR_DISPLAY_TO_WAKE_IT_UP = "touch_your_display_to_wake_it_up";
  static const SELECT_SETTINGS_AND_GO_TO_WIFI_CONNECT = "select_settings_and_go_to_wifi_connect";
  static const ENTER_PASSWORD_WALL_OVEN_TFT = "enter_the_Password_found_on_your_wall_oven_display";
  static const CAN_NOT_FIND_PASSWORD = "can_not_find_password";
  static const SELECT_SETTINGS_AND_GO_TO = "select_settings_and_go_to";
  static const WI_FI_CONNECT = "wi-fi_connect";
  static const SET_UP = "set_up";
  static const ACCESS_THE = "access_the";
  static const AND_PRESS = "and_press";
  static const WI_FI_SETUP = "wi-fi_Setup";
  static const AND_FOLLOW_THE_INSTRUCTIONS = "and_follow_the_instructions";
  static const THEN_SELECT = "then_select";
  static const AND_PRESS_THE_DIAL_TO_CONNECT_YOUR_APPLIANCE = "and_press_the_dial_to_connect_your_appliance";

  static const DISHWASHER_BUILT_IN = "built_in";
  static const DISHWASHER_COMPACT = "compact";
  static const DROP_DOOR_DISHWASHER = "drop_door_dishwasher";
  static const CENTRAL_FRONT_OF_DOOR = "central_front_of_door";

  static const ENSURE_THERE_IS_NO_WASH_IN_PROGRESS = "ensure_there_is_no_wash_in_progress";

  static const DROP_DOOR_PASSWORD_LOCATION_TEXT_1 = "drop_door_password_location_text_1";

  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_1_PART_1 = "drop_door_central_front_of_door_haier_instruction_1_part_1";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_1_PART_2 = "drop_door_central_front_of_door_haier_instruction_1_part_2";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_2_PART_1 = "drop_door_central_front_of_door_haier_instruction_2_part_1";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_2_PART_2 = "drop_door_central_front_of_door_haier_instruction_2_part_2";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_2_PART_3 = "drop_door_central_front_of_door_haier_instruction_2_part_3";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_3_PART_1 = "drop_door_central_front_of_door_haier_instruction_3_part_1";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_3_PART_2 = "drop_door_central_front_of_door_haier_instruction_3_part_2";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_INSTRUCTION_3_PART_3 = "drop_door_central_front_of_door_haier_instruction_3_part_3";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_PASSWORD_LOCATION_TEXT_1 = "drop_door_central_front_of_door_haier_password_location_text_1";

  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_1 = "drop_door_fnp_instruction_1_part_1";
  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_2 = "drop_door_fnp_instruction_1_part_2";
  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_3 = "drop_door_fnp_instruction_1_part_3";
  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_4 = "drop_door_fnp_instruction_1_part_4";
  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_5 = "drop_door_fnp_instruction_1_part_5";
  static const DROP_DOOR_FNP_INSTRUCTION_1_PART_6 = "drop_door_fnp_instruction_1_part_6";

  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_1_PART_1 = "drop_door_inside_top_haier_instruction_1_part_1";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_1_PART_2 = "drop_door_inside_top_haier_instruction_1_part_2";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_2_PART_1 = "drop_door_inside_top_haier_instruction_2_part_1";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_2_PART_2 = "drop_door_inside_top_haier_instruction_2_part_2";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_2_PART_3 = "drop_door_inside_top_haier_instruction_2_part_3";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_3_PART_1 = "drop_door_inside_top_haier_instruction_3_part_1";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_3_PART_2 = "drop_door_inside_top_haier_instruction_3_part_2";
  static const DROP_DOOR_INSIDE_TOP_HAIER_INSTRUCTION_3_PART_3 = "drop_door_inside_top_haier_instruction_3_part_3";
  static const DROP_DOOR_INSIDE_TOP_HAIER_PASSWORD_LOCATION_TEXT_1 = "drop_door_inside_top_haier_password_location_text_1";

  static const SELECT_YOUR_APPLIANCE_S_BRAND = "select_your_appliance_s_brand";
  static const LOCATE_DISHWASHER_CONTROL = "locate_dishwasher_control";
  static const DISHWASHER_TYPE = "dishwasher_type";

  static const LAUNDRY_FRONT_2_STEP_3_DISPLAY_MODEL = "laundry_front_1_which_best_describes_your_display_fnp";

  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_1 = "laundry_dryer_fnp_front_1_remote_wifi_description_text_1";
  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_2 = "laundry_dryer_fnp_front_1_remote_wifi_description_text_2";
  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_1_DESCRIPTION_TEXT_3 = "laundry_dryer_fnp_front_1_remote_wifi_description_text_3";
  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_1 = "laundry_dryer_fnp_front_2_remote_wifi_description_text_1";
  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_2 = "laundry_dryer_fnp_front_2_remote_wifi_description_text_2";
  static const LAUNDRY_DRYER_FNP_FRONT_MODEL_2_DESCRIPTION_TEXT_3 = "laundry_dryer_fnp_front_2_remote_wifi_description_text_3";
  static const LAUNDRY_DRYER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_1 = "laundry_dryer_haier_front_1_remote_wifi_description_text_1";
  static const LAUNDRY_DRYER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_2 = "laundry_dryer_haier_front_1_remote_wifi_description_text_2";
  static const LAUNDRY_DRYER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_3 = "laundry_dryer_haier_front_1_remote_wifi_description_text_3";
  static const LAUNDRY_DRYER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_4 = "laundry_dryer_haier_front_1_remote_wifi_description_text_4";

  static const LAUNDRY_DRYER_FNP_FRONT_1_ENTER_PASSWORD_1 = "laundry_dryer_fnp_front_1_enter_password_1";
  static const LAUNDRY_DRYER_FNP_FRONT_1_ENTER_PASSWORD_2 = "laundry_dryer_fnp_front_1_enter_password_2";
  static const LAUNDRY_DRYER_FNP_FRONT_1_ENTER_PASSWORD_3 = "laundry_dryer_fnp_front_1_enter_password_3";
  static const LAUNDRY_DRYER_FNP_FRONT_2_ENTER_PASSWORD_1 = "laundry_dryer_fnp_front_2_enter_password_1";
  static const LAUNDRY_DRYER_FNP_FRONT_2_ENTER_PASSWORD_2 = "laundry_dryer_fnp_front_2_enter_password_2";
  static const LAUNDRY_DRYER_FNP_FRONT_2_ENTER_PASSWORD_3 = "laundry_dryer_fnp_front_2_enter_password_3";
  static const LAUNDRY_DRYER_HAIER_FRONT_1_ENTER_PASSWORD_1 = "laundry_dryer_haier_front_1_enter_password_1";
  static const LAUNDRY_DRYER_HAIER_FRONT_1_ENTER_PASSWORD_2 = "laundry_dryer_haier_front_1_enter_password_2";
  static const LAUNDRY_DRYER_HAIER_FRONT_1_ENTER_PASSWORD_3 = "laundry_dryer_haier_front_1_enter_password_3";

  static const LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_1 = "laundry_washer_haier_front_1_remote_wifi_description_text_1";
  static const LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_2 = "laundry_washer_haier_front_1_remote_wifi_description_text_2";
  static const LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_3 = "laundry_washer_haier_front_1_remote_wifi_description_text_3";
  static const LAUNDRY_WASHER_HAIER_FRONT_MODEL_1_DESCRIPTION_TEXT_4 = "laundry_washer_haier_front_1_remote_wifi_description_text_4";

  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_1 = "laundry_washer_haier_top_getting_started_description_1";
  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_2 = "laundry_washer_haier_top_getting_started_description_2";
  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_3 = "laundry_washer_haier_top_getting_started_description_3";
  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_4 = "laundry_washer_haier_top_getting_started_description_4";
  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_5 = "laundry_washer_haier_top_getting_started_description_5";
  static const LAUNDRY_WASHER_HAIER_TOP_GETTING_STARTED_DESCRIPTION_6 = "laundry_washer_haier_top_getting_started_description_6";

  static const LAUNDRY_WASHER_FNP_FRONT_1_ENTER_PASSWORD_1 = "laundry_washer_fnp_front_1_enter_password_1";
  static const LAUNDRY_WASHER_FNP_FRONT_1_ENTER_PASSWORD_2 = "laundry_washer_fnp_front_1_enter_password_2";
  static const LAUNDRY_WASHER_FNP_FRONT_1_ENTER_PASSWORD_3 = "laundry_washer_fnp_front_1_enter_password_3";
  static const LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_1 = "laundry_washer_fnp_front_2_enter_password_1";
  static const LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_2 = "laundry_washer_fnp_front_2_enter_password_2";
  static const LAUNDRY_WASHER_FNP_FRONT_2_ENTER_PASSWORD_3 = "laundry_washer_fnp_front_2_enter_password_3";
  static const LAUNDRY_WASHER_HAIER_FRONT_1_ENTER_PASSWORD_1 = "laundry_washer_haier_front_1_enter_password_1";
  static const LAUNDRY_WASHER_HAIER_FRONT_1_ENTER_PASSWORD_2 = "laundry_washer_haier_front_1_enter_password_2";
  static const LAUNDRY_WASHER_HAIER_FRONT_1_ENTER_PASSWORD_3 = "laundry_washer_haier_front_1_enter_password_3";

  static const IN_THE_MIDDLE = "in_the_middle";
  static const IN_THE_MIDDLE_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_1 = "in_the_middle_unlock_control_panel_instruction_part_1";
  static const IN_THE_MIDDLE_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_2 = "in_the_middle_unlock_control_panel_instruction_part_2";
  static const IN_THE_MIDDLE_TURN_ON_WIFI_PAIRING_INSTRUCTION_PART_1 = "in_the_middle_turn_on_wifi_pairing_instruction_part_1";
  static const IN_THE_MIDDLE_TURN_ON_WIFI_PAIRING_INSTRUCTION_PART_2 = "in_the_middle_turn_on_wifi_pairing_instruction_part_2";
  static const IN_THE_MIDDLE_LOCATE_THE_CONNECTED_APPLIANCE_LABEL = "in_the_middle_locate_the_connected_appliance_label";
  static const IN_THE_MIDDLE_LOWER_COMPARTMENT_LABEL_DESCRIPTION = "in_the_middle_lower_compartment_label_description";
  static const IN_THE_MIDDLE_WINE_CABINET_LABEL_DESCRIPTION = "in_the_middle_wine_cabinet_label_description";
  static const IN_THE_MIDDLE_LABEL_NOTE = "in_the_middle_label_note";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_1 = "on_top_unlock_control_panel_instruction_part_1";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_2 = "on_top_unlock_control_panel_instruction_part_2";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_3 = "on_top_unlock_control_panel_instruction_part_3";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_4 = "on_top_unlock_control_panel_instruction_part_4";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_5 = "on_top_unlock_control_panel_instruction_part_5";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_6 = "on_top_unlock_control_panel_instruction_part_6";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_7 = "on_top_unlock_control_panel_instruction_part_7";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_8 = "on_top_unlock_control_panel_instruction_part_8";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_9 = "on_top_unlock_control_panel_instruction_part_9";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_10 = "on_top_unlock_control_panel_instruction_part_10";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_11 = "on_top_unlock_control_panel_instruction_part_11";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_12 = "on_top_unlock_control_panel_instruction_part_12";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_13 = "on_top_unlock_control_panel_instruction_part_13";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_14 = "on_top_unlock_control_panel_instruction_part_14";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_15 = "on_top_unlock_control_panel_instruction_part_15";
  static const ON_TOP_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_16 = "on_top_unlock_control_panel_instruction_part_16";
  static const ON_TOP_LOCATE_THE_CONNECTED_APPLIANCE_LABEL = "on_top_locate_the_connected_appliance_label";
  static const ON_TOP_LOWER_COMPARTMENT_LABEL_DESCRIPTION = "on_top_lower_compartment_label_description";
  static const ON_TOP_LABEL_NOTE = "on_top_label_note";

  static const FRENCH_DOOR_BEHIND_DRAWER_ON_LOWER_FRAME = "french_door_behind_drawer";
  static const DOOR_2_MODELS_BEHIND_LOWER = "door_2_models_behind_lower";
  static const QUAD_DOOR_MODELS_ON_THE_RIGHT_SIDE = "quad_door_models_on_the_right_side";
  static const FRENCH_DOOR_MODELS_TITLE = "french_door_models_title";
  static const DOOR_2_MODELS_TITLE = "door_2_models_title";
  static const QUAD_DOOR_MODELS_TITLE = "quad_door_models_title";
  static const RIGHT_ON_WALL = "right_on_wall";
  static const RIGHT_ON_WALL_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_1 = "right_on_wall_unlock_control_panel_instruction_part_1";
  static const RIGHT_ON_WALL_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_2 = "right_on_wall_unlock_control_panel_instruction_part_2";
  static const RIGHT_ON_WALL_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_3 = "right_on_wall_unlock_control_panel_instruction_part_3";
  static const RIGHT_ON_WALL_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_4 = "right_on_wall_unlock_control_panel_instruction_part_4";
  static const RIGHT_ON_WALL_UNLOCK_CONTROL_PANEL_INSTRUCTION_PART_5 = "right_on_wall_unlock_control_panel_instruction_part_5";
  static const RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_1 = "right_on_wall_locate_label_explain_1";
  static const RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_2 = "right_on_wall_locate_label_explain_2";
  static const RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_3 = "right_on_wall_locate_label_explain_3";
  static const RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_4 = "right_on_wall_locate_label_explain_4";
  static const RIGHT_ON_WALL_LOCATE_LABEL_EXPLAIN_5 = "right_on_wall_locate_label_explain_5";
  static const ON_THE_TOP = "on_the_top";
  static const QUAD_DOOR_LABEL_NOTE = "quad_door_label_note";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_1 = "left_on_wall_locate_label_explain_1";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_2 = "left_on_wall_locate_label_explain_2";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_3 = "left_on_wall_locate_label_explain_3";
  static const WIFI_CONNECT = "wifi_connect";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_1_STEP2 = "left_on_wall_locate_label_explain_1_step2";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_2_STEP2 = "left_on_wall_locate_label_explain_2_step2";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_3_STEP2 = "left_on_wall_locate_label_explain_3_step2";
  static const LEFT_ON_WALL_LOCATE_LABEL_EXPLAIN_4_STEP2 = "left_on_wall_locate_label_explain_4_step2";
  static const QUAD_DOOR_MODELS = "quad_door_models";
  static const ON_THE_RIGHT_SIDE_OF_THE_MIDDLE_CROSS_RAIL = "on_the_right_side_of_the_middle_cross_rail";

  static const SELECT_THE_BRAND_OF_YOUR_APPLIANCE = "select_the_brand_of_your_appliance";

  static const String BLE_SCAN_TEXT_1 = "ble_scan_text_1";

  static const PAUSE = "pause";
  static const PAUSED = "paused";
  static const RESUME = "resume";
  static const REVERSE = "reverse";
  static const REMAINING = "remaining";
  static const STIR = "stir";
  static const PRESS_TO_START = "press_to_start";
  static const PRESS_TO_RESUME = "press_to_resume";
  static const CANCEL_MIXING = "cancel_mixing";

  static const DIALOG_ACTION_MORE_DETAILS = "dialog_action_more_details";
  static const DIALOG_ACTION_BUTTON_DISMISS = "dialog_action_button_dismiss";
  static const DIALOG_ACTION_BUTTON_OK = "dialog_action_button_ok";
  static const DIALOG_ACTION_BUTTON_GO_TO_LINK = "dialog_action_button_go_to_link";

  static const PRESS_WIFI_BUTTON = "press_wifi_button";
  static const RECIPE_BAKE = "recipe_bake";
  static const RECIPE_BAKING = "recipe_baking";
  static const SENT_TO_OVEN = "sent_to_oven";
  
  static const KING_ARTHUR_RECIPES = "king_arthur_recipes";

  static const SEND_TO_OVEN = "send_to_oven";
  static const REMINDER = "reminder";

  static const NO_HISTORY = "no_history";
  static const ACTIVE_STIR = "active_stir";
  static const ACTIVE_STIR_INFO = "active_stir_info";
  static const ACTIVE_STIR_DEACTIVATED = "active_stir_deactivated";
  static const ACTIVE_STIR_DEACTIVATED_INFO = "active_stir_deactivated_info";
  static const HOW_TO_VIDEOS = "how_to_videos";
  static const MIXER = "mixer";
  static const ACTION = "action";
  static const END = "end";
  static const SEND_NEW_SETTINGS = "send_new_settings";
  static const CLOSE = "close";
  static const IS_BUSY = "is_busy";

  static const NEW_SHORTCUT = "new_shortcut";
  static const EDIT_SHORTCUT = "edit_shortcut";
  static const SELECT_APPLIANCES = "select_appliances";
  static const SELECT_APPLIANCE_FOR_NEW_SHORTCUT = "select_appliance_for_a_new_shortcut";
  static const SELECT_APPLIANCE_FOR_CREATING_SHORTCUT = "select_appliance_for_creating_a_shortcut";
  static const SELECT_APPLIANCES_NEW_SHORTCUT_EXPLAIN = "select_appliance_new_shortcut_explain";
  static const CHOOSE_SHORTCUT_TYPE_FOR_WINDOW_AC = "choose_shortcut_type_for_window_ac";
  static const CHOOSE_SHORTCUT_TYPE_FOR_OVEN = "choose_shortcut_type_for_oven";
  static const WHICH_OVEN_SHORTCUT_DO_YOU_WANT_CREATE = "which_oven_shortcut_do_you_want_to_create";
  static const SET_WINDOW_AC = "set_window_ac";
  static const TURN_OFF_WINDOW_AC = "turn_off_window_ac";
  static const SET_OVEN = "set_oven";
  static const TURN_OFF_OVEN = "turn_off_oven";
  static const UPPER_OVEN = "upper_oven";
  static const LOWER_OVEN = "lower_oven";
  static const LEFT_SIDE_OVEN = "left_side_oven";
  static const RIGHT_SIDE_OVEN = "right_side_oven";
  static const NICKNAME = "nickname";
  static const SELECT_YOUR_SHORTCUT_SETTINGS = "select_your_shortcut_setting";
  static const SHORTCUT_MODE = "shortcut_mode";
  static const SHORTCUT_FAN = "shortcut_fan";
  static const SHORTCUT_TEMPERATURE = "shortcut_temperature";
  static const SHORTCUT_NICKNAME_HINT = "shortcut_nickname_hint";
  static const REVIEW = "review";
  static const SHORTCUT_SETTINGS = "shortcut_settings";
  static const TURN_OFF = "turn_off";
  static const SHORTCUT_OFFLINE_ALERT_TITLE = "the_appliance_is_offline";
  static const SHORTCUT_OFFLINE_ALERT_DESCRIPTION = "check_connection_for_shortcut";
  static const SHORTCUT_WAC_DRY_MODE = "dry_wac";
  static const SHORTCUT_WAC_TURBO_COOL_MODE = "turbo_cool_wac";
  static const SHORTCUT_WAC_FAN_ONLY_MODE = "fan_only_wac";
  static const SHORTCUT_GUIDANCE_STEP1 = "shortcut_guidance_step1";
  static const SHORTCUT_GUIDANCE_STEP2 = "shortcut_guidance_step2";
  static const SHORTCUT_GUIDANCE_STEP3 = "shortcut_guidance_step3";
  static const SKIP = "skip";
  static const CREATE_A_NEW_SHORTCUT = "create_a_new_shortcut";
  static const LATER = "later";
}
