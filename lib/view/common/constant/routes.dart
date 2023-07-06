class Routes {
  static const _BASE_COMMISSIONING_ROUTE_PATH = "commissioning/";
  static const ADD_APPLIANCE_PAGE = _BASE_COMMISSIONING_ROUTE_PATH + "add_appliance_page";
  static const SELECT_APPLIANCE_PAGE = _BASE_COMMISSIONING_ROUTE_PATH + "select_appliance_page";

  //Connect_Plus
  static const _CONNECT_PLUS_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "connect_plus/";
  static const CONNECT_PLUS_MAIN_NAVIGATOR = "/" + _CONNECT_PLUS_ROUTE_PATH;
  static const CONNECT_PLUS_STARTED_PAGE = _CONNECT_PLUS_ROUTE_PATH + "connect_plus_started_page";
  static const CONNECT_PLUS_ENTER_PASSWORD_PAGE = _CONNECT_PLUS_ROUTE_PATH + "connect_plus_enter_password_page";
  static const CONNECT_PLUS_DISH_REMOVE_BOTTOM_PAGE = _CONNECT_PLUS_ROUTE_PATH + "connect_plus_dish_remove_bottom_page";
  static const CONNECT_PLUS_COMMISSIONING_SUCCESS= _CONNECT_PLUS_ROUTE_PATH + "success_page";
  static const CONNECT_PLUS_COMMISSIONING_SUCCESS_DETAIL = _CONNECT_PLUS_ROUTE_PATH + "success_detail_page";
  static const CONNECT_PLUS_COMMISSIONING_WRONG = _CONNECT_PLUS_ROUTE_PATH + "something_wrong_page";
  static const CONNECT_PLUS_COMMISSIONING_WRONG_RETRY = _CONNECT_PLUS_ROUTE_PATH + "something_wrong_retry_page";
  static const CONNECT_PLUS_COMMISSIONING_WRONG_RELAUNCH = _CONNECT_PLUS_ROUTE_PATH + "something_wrong_relaunch_page";

  //Common
  static const _COMMON_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "common/";
  static const COMMON_MAIN_NAVIGATOR = "/" + _COMMON_ROUTE_PATH;
  static const COMMON_RECIPE_ROUTE_PATH = "recipes/";
  static const COMMON_NAVIGATE_PAGE = _COMMON_ROUTE_PATH + "common_navigate_page";
  static const COMMON_MAIN_WRONG_PAGE = _COMMON_ROUTE_PATH + "commissioning_wrong_page";
  static const COMMON_WRONG_PASSWORD_PAGE = _COMMON_ROUTE_PATH + "commissioning_wrong_password_page";
  static const COMMON_MAIN_WRONG_RELAUNCH_PAGE = _COMMON_ROUTE_PATH + "commissioning_wrong_relaunch_page";
  static const COMMON_MAIN_WRONG_RETRY_PAGE = _COMMON_ROUTE_PATH + "commissioning_wrong_retry_page";
  static const COMMON_MAIN_SUCCESS_DETAIL_PAGE = _COMMON_ROUTE_PATH + "commissioning_success_detail_page";
  static const COMMON_MAIN_SUCCESS_PAGE = _COMMON_ROUTE_PATH + "commissioning_success_page";
  static const COMMON_COMMUNICATION_CLOUD_PAGE = _COMMON_ROUTE_PATH + "commissioning_communication_cloud";
  static const COMMON_CHOOSE_HOME_NETWORK_PAGE = _COMMON_ROUTE_PATH + "commissioning_choose_home_network_page";
  static const COMMON_CHOOSE_HOME_NETWORK_LIST_PAGE = _COMMON_ROUTE_PATH + "commissioning_choose_home_network_list_page";
  static const COMMON_ENTER_PASSWORD_PAGE = _COMMON_ROUTE_PATH + "commissioning_enter_password_page";
  static const COMMON_CHOOSE_WIFI_CONNECTION_PAGE = _COMMON_ROUTE_PATH + "commissioning_wifi_connection_page";
  static const COMMON_ADD_OTHER_NETWORK_PAGE = _COMMON_ROUTE_PATH + "add_other_network_page";
  static const COMMON_BLE_WRONG_PASSWORD_PAGE = _COMMON_ROUTE_PATH + "commissioning_ble_wrong_password_page";
  static const COMMON_CONNECTING_SAVED_NETWORK = _COMMON_ROUTE_PATH + "commissioning_connect_saved_network_page";
  static const COMMON_SAVED_NETWORK_LIST = _COMMON_ROUTE_PATH + "commissioning_saved_network_list";
  static const COMMON_EDIT_SAVED_NETWORK_PAGE = _COMMON_ROUTE_PATH + "commissioning_edit_saved_network";
  static const COMMON_WRONG_NETWORK_PASSWORD_PAGE = _COMMON_ROUTE_PATH + "commissioning_wrong_network_password_page";

  // Dialog
  static const _DIALOG_ROUTE_PATH = "dialog/";
  static const DIALOG_ROOT_BACKGROUND = _DIALOG_ROUTE_PATH + "root_background";
  static const DIALOG_PUSH_NOTIFICATION = _DIALOG_ROUTE_PATH + "push_notification";

  // Push Notification
  static const _PUSH_NOTIFICATION_ROUTE_PATH = "push_notification/";
  static const PUSH_NOTIFICATION_ALERT_DETAILS_PAGE = _PUSH_NOTIFICATION_ROUTE_PATH + "alert_details";

  // Dishwasher
  static const _DISHWASHER_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "dishwasher/";
  static const DISHWASHER_MAIN_NAVIGATOR = "/" + _DISHWASHER_ROUTE_PATH;
  static const DISHWASHER_DESCRIPTION1_MODEL1 = _DISHWASHER_ROUTE_PATH + "description1";
  static const DISHWASHER_DESCRIPTION2_MODEL2 = _DISHWASHER_ROUTE_PATH + "description2";
  static const DISHWASHER_DESCRIPTION3_MODEL3 = _DISHWASHER_ROUTE_PATH + "description3";
  static const DISHWASHER_HOME = _DISHWASHER_ROUTE_PATH + "dishwasher_getting_started_page";
  static const DISHWASHER_COMPACT = _DISHWASHER_ROUTE_PATH + "dishwasher_compact_page";
  static const _DISH_DRAWER_ROUTE_PATH = _DISHWASHER_ROUTE_PATH + "dish_drawer/";
  static const DISH_DRAWER_MAIN_NAVIGATOR = "/" + _DISH_DRAWER_ROUTE_PATH;
  static const DISH_DRAWER_LOCATE_CONTROL = _DISH_DRAWER_ROUTE_PATH + "locate_dish_drawer_control";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_STEP1_PATH = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_on_front_of_door_step1";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_STEP2_PATH = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_on_front_of_door_step2";
  static const DISH_DRAWER_ON_FRONT_OF_DOOR_STEP3_PATH = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_on_front_of_door_step3";
  static const DISH_DRAWER_INSIDE_TOP_STEP1 = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_inside_top_step1";
  static const DISH_DRAWER_INSIDE_TOP_STEP2 = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_inside_top_step2";
  static const DISH_DRAWER_ENTER_PASSWORD_PAGE = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_enter_password_page";
  static const DISH_DRAWER_LOCATE_PASSWORD_PAGE = _DISH_DRAWER_ROUTE_PATH + "dish_drawer_locate_password_page";

  // F&P Dishwasher
  static const DISHWASHER_SELECT_TYPE = _DISHWASHER_ROUTE_PATH + "dishwasher_select_type";
  static const DROP_DOOR_ROUTE_PATH = _DISHWASHER_ROUTE_PATH + "drop_door/";
  static const DROP_DOOR_MAIN_NAVIGATOR = "/" + DROP_DOOR_ROUTE_PATH;
  static const DROP_DOOR_LOCATE_CONTROL_FNP = DROP_DOOR_ROUTE_PATH + "locate_drop_door_control_fnp";
  static const DROP_DOOR_FNP_STEP1 = DROP_DOOR_ROUTE_PATH + "drop_door_fnp_step1";
  static const DROP_DOOR_FNP_STEP2 = DROP_DOOR_ROUTE_PATH + "drop_door_fnp_step2";
  static const DROP_DOOR_FNP_STEP3 = DROP_DOOR_ROUTE_PATH + "drop_door_fnp_step3";
  static const DROP_DOOR_LOCATE_CONTROL_HAIER = DROP_DOOR_ROUTE_PATH + "locate_drop_door_control_haier";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP1 = DROP_DOOR_ROUTE_PATH + "drop_door_central_front_of_door_haier_step1";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP2 = DROP_DOOR_ROUTE_PATH + "drop_door_central_front_of_door_haier_step2";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP3 = _DISH_DRAWER_ROUTE_PATH + "drop_door_central_front_of_door_haier_step3";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP4 = DROP_DOOR_ROUTE_PATH + "drop_door_central_front_of_door_haier_step4";
  static const DROP_DOOR_CENTRAL_FRONT_OF_DOOR_HAIER_STEP5 = DROP_DOOR_ROUTE_PATH + "drop_door_central_front_of_door_haier_step5";
  static const DROP_DOOR_INSIDE_TOP_SELECT_BRAND_TYPE = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_select_brand_type";
  static const DROP_DOOR_INSIDE_TOP_HAIER_STEP1 = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_haier_step1";
  static const DROP_DOOR_INSIDE_TOP_HAIER_STEP2 = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_haier_step2";
  static const DROP_DOOR_INSIDE_TOP_HAIER_STEP3 = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_haier_step3";
  static const DROP_DOOR_INSIDE_TOP_HAIER_STEP4 = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_haier_step4";
  static const DROP_DOOR_INSIDE_TOP_HAIER_STEP5 = DROP_DOOR_ROUTE_PATH + "drop_door_inside_top_haier_step5";

  // Air products
  static const _AIR_PRODUCT_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "air_products/";
  static const AIR_PRODUCTS_SELECTION_PAGE = _AIR_PRODUCT_ROUTE_PATH + "air_product_type_chooser";
  static const _DUCTLESS_AC_ROUTE_PATH = _AIR_PRODUCT_ROUTE_PATH + "ductless_ac/";
  static const DUCTLESS_MAIN_NAVIGATOR = "/" + _DUCTLESS_AC_ROUTE_PATH;
  static const DUCTLESS_USB_WIFI_MAIN_NAVIGATOR = "/" + _DUCTLESS_AC_ROUTE_PATH;
  static const DUCTLESS_AC_APPLIANCE_SELECTION_PAGE = _DUCTLESS_AC_ROUTE_PATH + "page_ductless_ac_select_type";
  static const DUCTLESS_AC_BUILT_IN_WIFI_DESC_PAGE_1 = _DUCTLESS_AC_ROUTE_PATH + "page_ductless_ac_built_in_wifi_description_1";
  static const DUCTLESS_AC_USB_WIFI_DESCRIPTION_PAGE = _DUCTLESS_AC_ROUTE_PATH + "page_ductless_ac_usb_wifi_description";
  static const DUCTLESS_AC_APPLIANCE_INFO_PAGE = _DUCTLESS_AC_ROUTE_PATH + "ductless_ac_appliance_info_page";
  static const DUCTLESS_AC_APPLIANCE_PASSWORD_INFO_PAGE = _DUCTLESS_AC_ROUTE_PATH + "ductless_ac_appliance_password_info_page";
  static const _WINDOW_AC_ROUTE_PATH = _AIR_PRODUCT_ROUTE_PATH + "window_ac/";
  static const WINDOW_AC_MAIN_NAVIGATOR = "/" + _WINDOW_AC_ROUTE_PATH;
  static const WINDOW_AC_PAGE_1 = _WINDOW_AC_ROUTE_PATH + "windowACHome";
  static const WINDOW_AC_PAGE_2 = _WINDOW_AC_ROUTE_PATH + "windowACInfo";
  static const WINDOW_AC_PAGE_3 = _WINDOW_AC_ROUTE_PATH + "windowACPassword";
  static const WINDOW_AC_PAGE_4 = _WINDOW_AC_ROUTE_PATH + "windowACWifiNotBlinking";
  static const WINDOW_AC_PAGE_5 = _WINDOW_AC_ROUTE_PATH + "windowACCall";
  static const _PORTABLE_AC_ROUTE_PATH = _AIR_PRODUCT_ROUTE_PATH + "portable_ac/";
  static const PORTABLE_AC_MAIN_NAVIGATOR = _PORTABLE_AC_ROUTE_PATH;
  static const PORTABLE_AC_APPLIANCE_SELECTION_PAGE = _PORTABLE_AC_ROUTE_PATH + "page_potable_ac_select_type";
  static const PORTABLE_AC_TIMER_DESCRIPTION = _PORTABLE_AC_ROUTE_PATH + "1_model1_description";
  static const PORTABLE_AC_WIFI_DESCRIPTION = _PORTABLE_AC_ROUTE_PATH + "2_model1_description";
  static const PORTABLE_AC_APPLIANCE_INFO = _PORTABLE_AC_ROUTE_PATH + "3_description";
  static const PORTABLE_AC_APPLIANCE_PASSWORD = _PORTABLE_AC_ROUTE_PATH + "4_description";
  static const _DEHUMIDIFIER_ROUTE_PATH = _AIR_PRODUCT_ROUTE_PATH + "dehumidifier/";
  static const DEHUMIDIFIER_MAIN_NAVIGATOR = "/" + _DEHUMIDIFIER_ROUTE_PATH;
  static const DEHUMIDIFIER_DESCRIPTION1 = _DEHUMIDIFIER_ROUTE_PATH + "description1";
  static const DEHUMIDIFIER_DESCRIPTION2 = _DEHUMIDIFIER_ROUTE_PATH + "description2";
  static const DEHUMIDIFIER_COMMISSIONING_ENTER_PASSWORD = _DEHUMIDIFIER_ROUTE_PATH + "enterpassword";

  // Haier Air products
  static const _HAIER_AC_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "split_ac_haier/";
  static const HAIER_AC_MAIN_NAVIGATOR = _HAIER_AC_ROUTE_PATH;
  static const HAIER_AC_APPLIANCE_CHOOSE_MODEL_PAGE = _HAIER_AC_ROUTE_PATH + "choose_ac_model_haier_page";
  static const HAIER_AC_APPLIANCE_WIFI_TYPE_SELECTION_PAGE = _HAIER_AC_ROUTE_PATH + "select_ac_wifi_type_haier_page";
  static const HAIER_AC_APPLIANCE_BUILT_IN_WIFI_DESCRIPTION_PAGE = _HAIER_AC_ROUTE_PATH + "page_haier_ac_built_in_wifi_description";
  static const HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_ONE = _HAIER_AC_ROUTE_PATH + "page_haier_ac_usb_wifi_description_1";
  static const HAIER_AC_APPLIANCE_USB_WIFI_DESCRIPTION_PAGE_TWO = _HAIER_AC_ROUTE_PATH + "page_haier_ac_usb_wifi_description_2";
  static const HAIER_AC_APPLIANCE_INFO_PAGE = _HAIER_AC_ROUTE_PATH + "haier_ac_appliance_info_page";
  static const HAIER_AC_APPLIANCE_PASSWORD_PAGE = _HAIER_AC_ROUTE_PATH + "haier_ac_appliance_password_page";

  // Cooking
  static const _COOKING_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "cooking/";
  static const COOKING_APPLIANCE_SELECTION_PAGE = _COOKING_ROUTE_PATH + "page_cooking_appliances_selection_type";
  static const _COOKTOP_ROUTE_PATH = _COOKING_ROUTE_PATH + "cooktop/";
  static const COOKTOP_MAIN_NAVIGATOR = _COOKTOP_ROUTE_PATH;
  static const COOKTOP_SELECT = _COOKTOP_ROUTE_PATH + "page_cooktop_selection_type";
  static const COOKTOP_INDUCTION_DESCRIPTION = _COOKTOP_ROUTE_PATH + "page_cooktop_induction_description";
  static const COOKTOP_INDUCTION_ADD = _COOKTOP_ROUTE_PATH + "page_cooktop_induction_add";
  static const COOKTOP_INDUCTION_OFF = _COOKTOP_ROUTE_PATH + "page_cooktop_induction_off";
  static const COOKTOP_GAS_DESCRIPTION = _COOKTOP_ROUTE_PATH + "page_cooktop_gas_description";
  static const COOKTOP_GAS_STEP_2 = _COOKTOP_ROUTE_PATH + "page_cooktop_gas_step_1";
  static const COOKTOP_GAS_STEP_3 = _COOKTOP_ROUTE_PATH + "page_cooktop_gas_step_2";
  static const COOKTOP_GAS_APPLIANCE_INFO = _COOKTOP_ROUTE_PATH + "page_cooktop_gas_appliance_info";
  static const COOKTOP_GAS_PASSWORD_INFO = _COOKTOP_ROUTE_PATH + "page_cooktop_gas_password_info";
  static const COOKTOP_APPLIANCE_INFO_GAS = _COOKTOP_ROUTE_PATH + "page_cooktop_appliance_info";
  static const COOKTOP_APPLIANCE_INFO_INDUCTION = _COOKTOP_ROUTE_PATH + "page_cooktop_appliance_info_1";
  static const COOKTOP_APPLIANCE_INFO_ELECTRIC = _COOKTOP_ROUTE_PATH + "page_cooktop_appliance_info_2";
  static const COOKTOP_PASSWORD_INFO = _COOKTOP_ROUTE_PATH + "page_cooktop_password_info";
  static const COOKTOP_ELECTRIC_DESCRIPTION = _COOKTOP_ROUTE_PATH + "page_cooktop_electric_description";
  static const _ADVANTIUM_ROUTE_PATH = _COOKING_ROUTE_PATH + "advantium/";
  static const ADVANTIUM_MAIN_NAVIGATOR = _ADVANTIUM_ROUTE_PATH;
  static const ADVANTIUM_NAVIGATE_PAGE = _ADVANTIUM_ROUTE_PATH + "advantium_navigate_page";
  static const ADVANTIUM_DESCRIPTION = _ADVANTIUM_ROUTE_PATH + "page_microwave_description";
  static const ADVANTIUM_PASSWORD_INFO = _ADVANTIUM_ROUTE_PATH + "page_advantium_password_info";
  static const ADVANTIUM_PASSWORD_INFO_1 = _ADVANTIUM_ROUTE_PATH+"page_advantium_password_info_1";
  static const _MICROWAVE_ROUTE_PATH = _COOKING_ROUTE_PATH + "microwave";
  static const MICROWAVE_MAIN_NAVIGATOR = "/" + _MICROWAVE_ROUTE_PATH;
  static const MICROWAVE_DESCRIPTION = _MICROWAVE_ROUTE_PATH + "page_microwave_description";
  static const MICROWAVE_APPLIANCE_INFO = _MICROWAVE_ROUTE_PATH + "page_microwave_appliance_info";
  static const MICROWAVE_PASSWORD_INFO = _MICROWAVE_ROUTE_PATH + "page_microwave_password_info";
  static const _HEARTH_OVEN_ROUTE_PATH = _COOKING_ROUTE_PATH + "hearth_oven/";
  static const HEARTH_OVEN_MAIN_NAVIGATOR = _HEARTH_OVEN_ROUTE_PATH;
  static const HEARTH_OVEN_DESCRIPTION = _HEARTH_OVEN_ROUTE_PATH + "page_hearth_oven_description";
  static const HEARTH_OVEN_PREFERENCES = _HEARTH_OVEN_ROUTE_PATH + "page_hearth_oven_preferences";
  static const HEARTH_OVEN_WIFI = _HEARTH_OVEN_ROUTE_PATH + "page_hearth_oven_wifi";
  static const HEARTH_OVEN_PASSWORD_INFO = _HEARTH_OVEN_ROUTE_PATH + "page_microwave_password_info";
  static const _RANGE_ROUTE_PATH = _COOKING_ROUTE_PATH + "range/";
  static const RANGE_MAIN_NAVIGATOR = _RANGE_ROUTE_PATH;
  static const RANGE_NAVIGATE_PAGE = _RANGE_ROUTE_PATH + "range_navigate_page";
  static const RANGE_SELECT = _RANGE_ROUTE_PATH + "page_range_selection_type";
  static const RANGE_LCD_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_lcd_description";
  static const RANGE_HAIER_KNOB_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_haier_knob_description";
  static const RANGE_PRO_RANGE_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_pro_range_description";
  static const RANGE_TOUCH_BUTTONS_SELECTION_TYPE = _RANGE_ROUTE_PATH + "page_range_touch_buttons_selection_type";
  static const RANGE_REMOTE_ENABLE_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_remote_enable_description";
  static const RANGE_WIFI_CONNECT_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_wifi_connect_description";
  static const RANGE_SETTINGS_DESCRIPTION = _RANGE_ROUTE_PATH + "page_range_settings_description";
  static const RANGE_HAIER_KNOB_APPLIANCE_INFO = _RANGE_ROUTE_PATH + "page_range_haier_knob_appliance_info";
  static const RANGE_HAIER_KNOB_APPLIANCE_PASSWORD_INFO = _RANGE_ROUTE_PATH + "page_range_haier_knob_appliance_password_info";
  static const RANGE_PRO_RANGE_PASSWORD_INFO = _RANGE_ROUTE_PATH + "page_range_pro_range_password";
  static const RANGE_LCD_APPLIANCE_INFO = _RANGE_ROUTE_PATH + "page_range_lcd_appliance_info";
  static const RANGE_LCD_SELECT_TYPE_PAGE = _RANGE_ROUTE_PATH + "range_lcd_select_type_page";
  static const RANGE_LCD_FOLLOW_APPLIANCE_INSTRUCTION_PAGE = _RANGE_ROUTE_PATH + "range_lcd_follow_appliance_instruction_page";
  static const RANGE_LCD_PASSWORD_INFO = _RANGE_ROUTE_PATH + "page_range_lcd_password_info";
  static const RANGE_LCD_PASSWORD_INFO_2 = _RANGE_ROUTE_PATH + "page_range_lcd_password_info_2";
  static const RANGE_TYPE_TWO_COMMON_APPLIANCE_INFO = _RANGE_ROUTE_PATH + "page_range_type_two_common_appliance_info";
  static const RANGE_TYPE_TWO_COMMON_PASSWORD_INFO = _RANGE_ROUTE_PATH + "page_range_type_two_common_password_info";
  static const RANGE_REMOTE_ENABLE_PASSWORD_PAGE = _RANGE_ROUTE_PATH + "page_range_remote_enable_password";
  static const RANGE_REMOTE_ENABLE_APPLIANCE_INFO = _RANGE_ROUTE_PATH + "page_range_remote_enable_appliance_info";
  static const _WALL_OVEN_ROUTE_PATH = _COOKING_ROUTE_PATH + "wall_oven/";
  static const WALL_OVEN_MAIN_NAVIGATOR = "/" + _WALL_OVEN_ROUTE_PATH;
  static const WALL_OVEN_NAVIGATE_PAGE = _WALL_OVEN_ROUTE_PATH + "wall_oven_navigate_page";
  static const WALL_OVEN_SELECTOR_PRIMARY = _WALL_OVEN_ROUTE_PATH + "wall_oven_selection_page_primary";
  static const WALL_OVEN_PRIMARY_TYPE_3_PAGE_1 = _WALL_OVEN_ROUTE_PATH + "wall_oven_knob_page_1";
  static const WALL_OVEN_PRIMARY_TYPE_3_PAGE_2 = _WALL_OVEN_ROUTE_PATH + "wall_oven_knob_page_2";
  static const WALL_OVEN_PRIMARY_TYPE_3_PAGE_3 = _WALL_OVEN_ROUTE_PATH + "wall_oven_knob_page_3";
  static const WALL_OVEN_PRIMARY_TYPE_3_PAGE_PASSWORD = _WALL_OVEN_ROUTE_PATH + "wall_oven_knob_page_password";
  static const WALL_OVEN_PRIMARY_TYPE_1_PAGE_1 = _WALL_OVEN_ROUTE_PATH + "wall_oven_lcd_page_1";
  static const WALL_OVEN_PRIMARY_TYPE_1_PAGE_2 = _WALL_OVEN_ROUTE_PATH + "wall_oven_lcd_page_2";
  static const WALL_OVEN_PRIMARY_TYPE_1_PAGE_3 = _WALL_OVEN_ROUTE_PATH + "wall_oven_lcd_page_3";
  static const WALL_OVEN_PRIMARY_TYPE_1_PAGE_PASSWORD_1 = _WALL_OVEN_ROUTE_PATH + "wall_oven_lcd_page_password";
  static const WALL_OVEN_PRIMARY_TYPE_1_PAGE_PASSWORD_2 = _WALL_OVEN_ROUTE_PATH + "wall_oven_lcd_page_password1";
  static const WALL_OVEN_SELECTOR_TYPE_2 = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_selection_page_type_two";
  static const WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_ONE = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_page_1_type_1";
  static const WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_TWO = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_page_1_type_2";
  static const WALL_OVEN_PRIMARY_TYPE_2_PAGE_ONE_THREE = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_page_1_type_3";
  static const WALL_OVEN_PRIMARY_TYPE_2_PAGE_TWO = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_page_2";
  static const WALL_OVEN_PRIMARY_TYPE_2_PAGE_PASSWORD = _WALL_OVEN_ROUTE_PATH + "wall_oven_with_buttons_page_password";
  static const WALL_OVEN_PRIMARY_TYPE_2_REMOTE_ENABLE_PASSWORD = _WALL_OVEN_ROUTE_PATH + "page_wall_oven_remote_enable_password";
  static const _HOOD_ROUTE_PATH = _COOKING_ROUTE_PATH + "hood/";
  static const HOOD_MAIN_NAVIGATOR = "/" + _HOOD_ROUTE_PATH;
  static const HOOD_MODEL_SELECT = _HOOD_ROUTE_PATH + "hood_model_select";
  static const HOOD_DESCRIPTION2_MODEL1 = HOOD_MAIN_NAVIGATOR + "2_model1_description";
  static const HOOD_DESCRIPTION2_MODEL2 = HOOD_MAIN_NAVIGATOR + "2_model_2_description";
  static const HOOD_DESCRIPTION3_MODEL1 = HOOD_MAIN_NAVIGATOR + "3_model1_description";
  static const HOOD_COMMISSIONING_ENTER_PASSWORD = HOOD_MAIN_NAVIGATOR + "5_enter_password";

  // F&P Cooking
  static const COOKING_SELECT_FNP_NAVIGATOR = _COOKING_ROUTE_PATH + "select_fnp_appliance";
  static const _RANGE_ROUTE_PATH_FNP = _COOKING_ROUTE_PATH + "range_fnp/";
  static const RANGE_MAIN_FNP_NAVIGATOR = "/" + _RANGE_ROUTE_PATH_FNP;
  static const RANGE_FNP_GETTING_STARTED = _RANGE_ROUTE_PATH_FNP + "getting_started";
  static const RANGE_FNP_ENTER_PASSWORD = _RANGE_ROUTE_PATH_FNP + "enter_password";
  static const _WALL_OVEN_ROUTE_PATH_FNP = _COOKING_ROUTE_PATH + "wall_oven_fnp/";
  static const WALL_OVEN_MAIN_FNP_NAVIGATOR = "/" + _WALL_OVEN_ROUTE_PATH_FNP;
  static const WALL_OVEN_MODEL_SELECTION_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "1_description_fnp";
  static const WALL_OVEN_MODEL_1_STEP_1_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model1_1_description_fnp";
  static const WALL_OVEN_MODEL_1_STEP_2_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model1_2_description_fnp";
  static const WALL_OVEN_MODEL_2_STEP_1_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model2_1_description_fnp";
  static const WALL_OVEN_MODEL_2_STEP_2_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model2_2_description_fnp";
  static const WALL_OVEN_MODEL_2_STEP_3_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model2_3_description_fnp";
  static const WALL_OVEN_MODEL_2_STEP_4_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model2_4_description_fnp";
  static const WALL_OVEN_MODEL_2_STEP_5_FNP = _WALL_OVEN_ROUTE_PATH_FNP + "model2_5_description_fnp";
  static const String COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_1 = _WALL_OVEN_ROUTE_PATH_FNP + "haier_model_1_step1";
  static const String COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_2 = _WALL_OVEN_ROUTE_PATH_FNP + "haier_model_1_step2";
  static const String COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_3 = _WALL_OVEN_ROUTE_PATH_FNP + "haier_model_1_step3";
  static const String COOKING_WALL_OVEN_HAIER_MODEL_1_STEP_4 = _WALL_OVEN_ROUTE_PATH_FNP + "haier_model_1_step4";

  // Countertops
  static const _COUNTERTOPS_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "countertops/";
  static const COUNTER_TOP_APPLIANCE_SELECTION_PAGE = _COUNTERTOPS_ROUTE_PATH + "page_counter_top_appliances_selection_type";
  static const BREW_APPLIANCE_SELECTION_PAGE = _COUNTERTOPS_ROUTE_PATH + "page_brew_appliances_selection_type";
  static const _ESPRESSO_ROUTE_PATH = _COUNTERTOPS_ROUTE_PATH + "espresso/";
  static const ESPRESSO_SELECT_NAVIGATOR = _ESPRESSO_ROUTE_PATH + "select_espresso_type";
  static const _ESPRESSO_MANUAL_ROUTE_PATH = _ESPRESSO_ROUTE_PATH + "manual/";
  static const ESPRESSO_MANUAL_NAVIGATOR = "/" + _ESPRESSO_MANUAL_ROUTE_PATH;
  static const ESPRESSO_MANUAL_ONE = _ESPRESSO_MANUAL_ROUTE_PATH + "espresso_manual_one";
  static const ESPRESSO_MANUAL_TWO = _ESPRESSO_MANUAL_ROUTE_PATH + "espresso_manual_two";
  static const ESPRESSO_MANUAL_THREE = _ESPRESSO_MANUAL_ROUTE_PATH + "espresso_manual_three";
  static const _ESPRESSO_AUTO_ROUTE_PATH = _ESPRESSO_ROUTE_PATH + "auto/";
  static const ESPRESSO_AUTO_NAVIGATOR = "/" + _ESPRESSO_AUTO_ROUTE_PATH;
  static const ESPRESSO_AUTO_ONE = _ESPRESSO_AUTO_ROUTE_PATH + "espresso_auto_one";
  static const ESPRESSO_AUTO_TWO = _ESPRESSO_AUTO_ROUTE_PATH + "espresso_auto_two";
  static const ESPRESSO_AUTO_THREE = _ESPRESSO_AUTO_ROUTE_PATH + "espresso_auto_three";
  static const _OPAL_ROUTE_PATH = _COUNTERTOPS_ROUTE_PATH + "opal/";
  static const OPAL_MAIN_NAVIGATOR = "/" + _OPAL_ROUTE_PATH;
  static const OPAL_DESCRIPTION_VIEW_1 = _OPAL_ROUTE_PATH + "description1";
  static const OPAL_DESCRIPTION_VIEW_2 = _OPAL_ROUTE_PATH + "description2";
  static const OPAL_DESCRIPTION_VIEW_3 = _OPAL_ROUTE_PATH + "description3";
  static const _COFFEEMAKER_ROUTE_PATH = _COUNTERTOPS_ROUTE_PATH + "coffee_maker/";
  static const COFFEEMAKER_MAIN_NAVIGATOR = "/" + _COUNTERTOPS_ROUTE_PATH;
  static const COFFEEMAKER_DESCRIPTION1_MODEL1 = _COFFEEMAKER_ROUTE_PATH + "1_description";
  static const COFFEEMAKER_DESCRIPTION2_MODEL2 = _COFFEEMAKER_ROUTE_PATH + "2_description";
  static const COFFEEMAKER_DESCRIPTION3_MODEL3 = _COFFEEMAKER_ROUTE_PATH + "coffee_maker_enter_password";
  static const _TOASTER_OVEN_ROUTE_PATH = _COUNTERTOPS_ROUTE_PATH + "toaster_oven/";
  static const TOASTER_OVEN_MAIN_NAVIGATOR = "/" + _TOASTER_OVEN_ROUTE_PATH;
  static const TOASTER_OVEN_DESCRIPTION1_MODEL = _TOASTER_OVEN_ROUTE_PATH + "1_model_description";
  static const _STAND_MIXER_ROUTE_PATH = _COUNTERTOPS_ROUTE_PATH + "stand_mixer/";
  static const STAND_MIXER_MAIN_NAVIGATOR = "/" + _STAND_MIXER_ROUTE_PATH;
  static const STAND_MIXER_COMMISSIONING_STEP_1_PAGE = _STAND_MIXER_ROUTE_PATH + "stand_mixer_commissioning_step_1_page";
  static const STAND_MIXER_COMMISSIONING_STEP_2_PAGE = _STAND_MIXER_ROUTE_PATH + "stand_mixer_commissioning_step_2_page";
  static const STAND_MIXER_COMMISSIONING_ENTER_PASSWORD_STEP_PAGE = _STAND_MIXER_ROUTE_PATH + "stand_mixer_enter_password_step_page";
  static const TOASTER_OVEN_SELECT_NAVIGATOR = _TOASTER_OVEN_ROUTE_PATH+ "select_toaster_oven_type";
  static const _TOASTER_OVEN_CAFE_ROUTE_PATH = _TOASTER_OVEN_ROUTE_PATH + "cafe_toaster_oven/";
  static const _TOASTER_OVEN_PROFILE_ROUTE_PATH = _TOASTER_OVEN_ROUTE_PATH + "profile_toaster_oven/";
  static const TOASTER_OVEN_CAFE_NAVIGATOR = "/" + _TOASTER_OVEN_CAFE_ROUTE_PATH;
  static const TOASTER_OVEN_PROFILE_NAVIGATOR = "/" + _TOASTER_OVEN_PROFILE_ROUTE_PATH;
  static const TOASTER_OVEN_CAFE_DESCRIPTION1_MODEL = _TOASTER_OVEN_CAFE_ROUTE_PATH + "1_model_description";
  static const TOASTER_OVEN_DESCRIPTION2_MODEL = _TOASTER_OVEN_CAFE_ROUTE_PATH + "2_model_description";
  static const TOASTER_OVEN_COMMISSIONING_ENTER_PASSWORD = _TOASTER_OVEN_CAFE_ROUTE_PATH + "3_enter_password";
  static const TOASTER_OVEN_PROFILE_DESCRIPTION1_MODEL = _TOASTER_OVEN_PROFILE_ROUTE_PATH + "1_model_description";

  //Laundry
  static const LAUNDRY_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "laundry/";
  static const LAUNDRY_WASHER_DRYER_SELECT = LAUNDRY_ROUTE_PATH + "/washer_dryer_select";
  static const _WASHER_ROUTE_PATH = LAUNDRY_ROUTE_PATH + "washer/";
  static const WASHER_MAIN_NAVIGATOR = "/" + _WASHER_ROUTE_PATH;
  static const WASHER_LOAD_LOCATION = _WASHER_ROUTE_PATH + "load_location";
  static const WASHER_TOP_LOAD = _WASHER_ROUTE_PATH + "washer_top";
  static const WASHER_FRONT_LOAD = _WASHER_ROUTE_PATH + "washer_front";
  static const WASHER_TOP_MODEL2 = _WASHER_ROUTE_PATH + "washer_top_model2";
  static const WASHER_FRONT_MODEL1 = _WASHER_ROUTE_PATH + "washer_front_model1";
  static const WASHER_FRONT_MODEL2_STEP1 = _WASHER_ROUTE_PATH + "washer_front_model2_step1";
  static const WASHER_FRONT_MODEL2_STEP2 = _WASHER_ROUTE_PATH + "washer_front_model2_step2";
  static const WASHER_TOP_MODEL1 = _WASHER_ROUTE_PATH + "washer_top_model1";
  static const WASHER_TOP_MODEL3 = _WASHER_ROUTE_PATH + "washer_top_model3";
  static const WASHER_TOP_PASSWORD = _WASHER_ROUTE_PATH + "washer_top_password";
  static const WASHER_FRONT_2_PASSWORD = _WASHER_ROUTE_PATH + "washer_front_2_password";
  static const WASHER_FRONT_1_PASSWORD = _WASHER_ROUTE_PATH + "washer_front_1_password";
  static const _DRYER_ROUTE_PATH = LAUNDRY_ROUTE_PATH + "dryer/";
  static const DRYER_MAIN_NAVIGATOR = "/" + _DRYER_ROUTE_PATH;
  static const DRYER_LOAD_LOCATION = _DRYER_ROUTE_PATH + "load_location";
  static const DRYER_TOP_LOAD = _DRYER_ROUTE_PATH + "dryer_top";
  static const DRYER_FRONT_LOAD = _DRYER_ROUTE_PATH + "dryer_front";
  static const DRYER_FRONT_MODEL1 = _DRYER_ROUTE_PATH + "dryer_front_model1";
  static const DRYER_FRONT_MODEL2_STEP1 = _DRYER_ROUTE_PATH + "dryer_front_model2_step1";
  static const DRYER_FRONT_MODEL2_STEP2 = _DRYER_ROUTE_PATH + "dryer_front_model2_step2";
  static const DRYER_TOP_MODEL1 = _DRYER_ROUTE_PATH + "dryer_top_model1";
  static const DRYER_TOP_MODEL2 = _DRYER_ROUTE_PATH + "dryer_top_model2";
  static const DRYER_TOP_MODEL3 = _DRYER_ROUTE_PATH + "dryer_top_model3";
  static const DRYER_FRONT_1_PASSWORD = _DRYER_ROUTE_PATH + "dryer_front_1_password";
  static const DRYER_FRONT_2_PASSWORD = _DRYER_ROUTE_PATH + "dryer_front_2_password";
  static const DRYER_TOP_PASSWORD = _DRYER_ROUTE_PATH + "dryer_top_password";

  static const COMBI_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "combi/";
  static const COMBI_MAIN_NAVIGATOR = "/" + COMBI_ROUTE_PATH;
  static const COMBI_DESCRIPTION1 = COMBI_MAIN_NAVIGATOR + "1_description";
  static const COMBI_PASSWORD = COMBI_MAIN_NAVIGATOR + "2_password";

  static const LAUNDRY_CENTER_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "laundry_center/";
  static const LAUNDRY_CENTER_MAIN_NAVIGATOR = "/" + LAUNDRY_CENTER_ROUTE_PATH;
  static const LAUNDRY_CENTER_SELECT_WIFI_TYPE = LAUNDRY_CENTER_ROUTE_PATH + "laundry_center_wifi_type";
  static const LAUNDRY_CENTER_SELECT_EXTERNAL_WIFI_OPTION = LAUNDRY_CENTER_ROUTE_PATH + "laundry_center_external_wifi_option";
  static const LAUNDRY_CENTER_CONNECT_PLUS_SETUP = LAUNDRY_CENTER_ROUTE_PATH + "laundry_center_connect_plus_setup";
  static const LAUNDRY_CENTER_NO_WIFI_CONNECTION_OPTIONS = LAUNDRY_CENTER_ROUTE_PATH + "laundry_center_no_wifi_connection_options";
  static const LAUNDRY_CENTER_SETUP_BUILT_IN_WIFI = LAUNDRY_CENTER_ROUTE_PATH + "built_in_wifi";
  static const LAUNDRY_CENTER_ENTER_PASSWORD = LAUNDRY_CENTER_ROUTE_PATH + "enter_password";

  // F&P Laundry
  static const LAUNDRY_SELECT_TYPE_FNP = LAUNDRY_ROUTE_PATH + "select_laundry_type_fnp";
  static const LAUNDRY_SELECT_TYPE_HAIER = LAUNDRY_ROUTE_PATH + "select_laundry_type_haier";

  static const _WASHER_FNP_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "laundry_washer_fisher_and_paykel/";
  static const _WASHER_FNP_FRONT_LOAD = _WASHER_FNP_ROUTE_PATH + "front/";
  static const WASHER_FRONT_1_DISPLAY_MODEL_SELECT_FNP = _WASHER_FNP_FRONT_LOAD + "washer_front_load_display_model_select_fnp";
  static const WASHER_MODEL_1_GETTING_STARTED_FNP = _WASHER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_1";
  static const WASHER_MODEL_2_GETTING_STARTED_FNP = _WASHER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_2";
  static const WASHER_MODEL_1_PASSWORD_FNP = _WASHER_FNP_FRONT_LOAD + "4_front_model1_password_fnp";
  static const WASHER_MODEL_2_PASSWORD_FNP = _WASHER_FNP_FRONT_LOAD + "4_front_model2_password_fnp";

  static const _DRYER_FNP_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "laundry_dryer_fisher_and_paykel/";
  static const _DRYER_FNP_FRONT_LOAD = _DRYER_FNP_ROUTE_PATH + "front/";
  static const DRYER_FRONT_1_DISPLAY_MODEL_SELECT_FNP = _DRYER_FNP_FRONT_LOAD + "2_front_load_display_model_select_fnp";
  static const DRYER_MODEL_1_GETTING_STARTED_FNP = _DRYER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_1";
  static const DRYER_MODEL_2_GETTING_STARTED_FNP = _DRYER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_2";
  static const DRYER_MODEL_1_PASSWORD_FNP = _DRYER_FNP_FRONT_LOAD + "4_front_model1_password_fnp";
  static const DRYER_MODEL_2_PASSWORD_FNP = _DRYER_FNP_FRONT_LOAD + "4_front_model2_password_fnp";

  static const DRYER_MODEL_1_GETTING_STARTED_HAIER = _DRYER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_3";
  static const DRYER_MODEL_1_PASSWORD_HAIER = _DRYER_FNP_FRONT_LOAD + "4_front_model1_password_haier";

  static const WASHER_HAIER_SELECT_LOAD_LOCATION = _BASE_COMMISSIONING_ROUTE_PATH + "washer_haier_select_load_location";
  static const _WASHER_TOP_LOAD_FNP = _WASHER_FNP_ROUTE_PATH + "top/";
  static const WASHER_TOP_LOAD_GETTING_STARTED_HAIER = _WASHER_TOP_LOAD_FNP + "3_front_remote_wifi_connection_3";
  static const WASHER_TOP_LOAD_PASSWORD_HAIER = _WASHER_TOP_LOAD_FNP + "4_front_model2_password_haier";
  static const WASHER_FRONT_LOAD_GETTING_STARTED_HAIER = _WASHER_FNP_FRONT_LOAD + "3_front_remote_wifi_connection_3";
  static const WASHER_FRONT_LOAD_PASSWORD_HAIER = _WASHER_FNP_FRONT_LOAD + "4_front_model2_password_haier";

  // Refrigeration
  static const _REFRIGERATION_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "refrigeration/";
  static const REFRIGERATOR_SELECT_NAVIGATOR = _REFRIGERATION_ROUTE_PATH + "page_refrigerator_select_type";
  static const FRIDGE_SELECT_NAVIGATOR = _REFRIGERATION_ROUTE_PATH + "select_display";
  static const _FRIDGE_ROUTE_PATH = _REFRIGERATION_ROUTE_PATH + "fridge/";
  static const _DISPENSER_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "dispenser/";
  static const DISPENSER_MAIN_NAVIGATOR = "/" + _DISPENSER_ROUTE_PATH;
  static const DISPENSER_MODEL_SELECT = _DISPENSER_ROUTE_PATH + "dispenser_model_select";
  static const DISPENSER_DESCRIPTION2_MODEL1 = _DISPENSER_ROUTE_PATH + "description2_model1";
  static const DISPENSER_DESCRIPTION2_MODEL2 = _DISPENSER_ROUTE_PATH + "description2_model2";
  static const DISPENSER_DESCRIPTION2_MODEL3 = _DISPENSER_ROUTE_PATH + "description2_model3";
  static const DISPENSER_DESCRIPTION3_MODEL1 = _DISPENSER_ROUTE_PATH + "description3_model1";
  static const DISPENSER_DESCRIPTION3_MODEL2 = _DISPENSER_ROUTE_PATH + "description3_model2";
  static const DISPENSER_DESCRIPTION3_MODEL3 = _DISPENSER_ROUTE_PATH + "description3_model3";
  static const DISPENSER_COMMISSIONING_ENTER_PASSWORD1 = _DISPENSER_ROUTE_PATH + "enterpassword1";
  static const DISPENSER_COMMISSIONING_ENTER_PASSWORD2 = _DISPENSER_ROUTE_PATH + "enterpassword2";
  static const _ON_TOP_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "on_top/";
  static const ON_TOP_MAIN_NAVIGATOR = "/" + _ON_TOP_ROUTE_PATH;
  static const ON_TOP_DESCRIPTION1 = _ON_TOP_ROUTE_PATH + "description1";
  static const ON_TOP_DESCRIPTION2_MODEL1 = _ON_TOP_ROUTE_PATH + "description2_model1";
  static const ON_TOP_DESCRIPTION2_MODEL2 = _ON_TOP_ROUTE_PATH + "description2_model2";
  static const ON_TOP_DESCRIPTION2_MODEL3 = _ON_TOP_ROUTE_PATH + "description2_model3";
  static const ON_TOP_DESCRIPTION3_MODEL1 = _ON_TOP_ROUTE_PATH + "description3_model1";
  static const ON_TOP_DESCRIPTION3_MODEL2 = _ON_TOP_ROUTE_PATH + "description3_model2";
  static const ON_TOP_COMMISSIONING_ENTER_PASSWORD = _ON_TOP_ROUTE_PATH + "enterpassword";
  static const _SIDE_DOOR_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "side_door/";
  static const SIDE_DOOR_MAIN_NAVIGATOR = "/" + _SIDE_DOOR_ROUTE_PATH;
  static const SIDE_DOOR_DESCRIPTION1 = _SIDE_DOOR_ROUTE_PATH + "description1";
  static const SIDE_DOOR_DESCRIPTION2 = _SIDE_DOOR_ROUTE_PATH + "description2";
  static const SIDE_DOOR_COMMISSIONING_ENTER_PASSWORD = _SIDE_DOOR_ROUTE_PATH + "enterpassword";
  static const _BEVERAGE_CENTER_ROUTE_PATH = _REFRIGERATION_ROUTE_PATH + "beverage_center/";
  static const BEVERAGE_CENTER_MAIN_NAVIGATOR = _BEVERAGE_CENTER_ROUTE_PATH;
  static const BEVERAGE_CENTER_NAVIGATE_PAGE = _BEVERAGE_CENTER_ROUTE_PATH + "beverage_center_navigate_page";
  static const BEVERAGE_CENTER_DESCRIPTION = _BEVERAGE_CENTER_ROUTE_PATH + "page_beverage_center_description";
  static const BEVERAGE_CENTER_APPLIANCE_INFO = _BEVERAGE_CENTER_ROUTE_PATH + "page_beverage_center_appliance_info";
  static const BEVERAGE_CENTER_COMMISSIONING_ENTER_PASSWORD = _BEVERAGE_CENTER_ROUTE_PATH + "page_beverage_center_password";
  static const _WINE_CENTER_ROUTE_PATH = _REFRIGERATION_ROUTE_PATH + "wine_center/";
  static const WINE_CENTER_MAIN_NAVIGATOR = _WINE_CENTER_ROUTE_PATH;
  static const WINE_CENTER_NAVIGATE_PAGE = _WINE_CENTER_ROUTE_PATH + "wine_center_navigate_page";
  static const WINE_CENTER_DESCRIPTION = _WINE_CENTER_ROUTE_PATH + "page_wine_center_description";
  static const WINE_CENTER_APPLIANCE_INFO = _WINE_CENTER_ROUTE_PATH + "page_wine_center_appliance_info";
  static const WINE_CENTER_COMMISSIONING_ENTER_PASSWORD = _WINE_CENTER_ROUTE_PATH + "page_wine_center_password";
  static const _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH = _REFRIGERATION_ROUTE_PATH + "under_counter_icemaker/";
  static const UNDER_COUNTER_ICE_MAKER_MAIN_NAVIGATOR = _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH;
  static const UNDER_COUNTER_ICE_MAKER_NAVIGATE_PAGE = _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH + "under_counter_icemaker_navigate_page";
  static const UNDER_COUNTER_ICE_MAKER_DESCRIPTION = _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH + "page_under_counter_icemaker_description";
  static const UNDER_COUNTER_ICE_MAKER_APPLIANCE_INFO = _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH + "page_under_counter_icemaker_appliance_info";
  static const UNDER_COUNTER_ICE_MAKER_COMMISSIONING_ENTER_PASSWORD = _UNDER_COUNTER_ICE_MAKER_ROUTE_PATH + "page_under_counter_icemaker_password";

  // F&P Refrigerator
  static const FRIDGE_SELECT_NAVIGATOR_FNP = _FRIDGE_ROUTE_PATH + "select_display_fnp";
  static const ON_TOP_DESCRIPTION2_FNP_MODEL3 = _ON_TOP_ROUTE_PATH + "description2_fnp_model3";
  static const ON_TOP_DESCRIPTION3_FNP_MODEL3 = _ON_TOP_ROUTE_PATH + "description3_fnp_model3";
  static const ON_TOP_COMMISSIONING_FNP_ENTER_PASSWORD = _ON_TOP_ROUTE_PATH + "fnp_enter_password";
  static const _IN_THE_MIDDLE_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "in_the_middle/";
  static const IN_THE_MIDDLE_MAIN_NAVIGATOR = "/" + _IN_THE_MIDDLE_ROUTE_PATH;
  static const IN_THE_MIDDLE_STEP1 = _IN_THE_MIDDLE_ROUTE_PATH + "step1";
  static const IN_THE_MIDDLE_STEP2 = _IN_THE_MIDDLE_ROUTE_PATH + "step2";
  static const IN_THE_MIDDLE_STEP3 = _IN_THE_MIDDLE_ROUTE_PATH + "step3";
  static const IN_THE_MIDDLE_STEP4 = _IN_THE_MIDDLE_ROUTE_PATH + "step4";
  static const _RIGHT_ON_WALL_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "inside_right/";
  static const RIGHT_ON_WALL_MAIN_NAVIGATOR = "/" + _RIGHT_ON_WALL_ROUTE_PATH;
  static const RIGHT_ON_WALL_DESCRIPTION1 = _RIGHT_ON_WALL_ROUTE_PATH + "description1";
  static const RIGHT_ON_WALL_DESCRIPTION2_MODEL1 = _RIGHT_ON_WALL_ROUTE_PATH + "description2_model1";
  static const RIGHT_ON_WALL_DESCRIPTION3_MODEL1 = _RIGHT_ON_WALL_ROUTE_PATH + "description3_model1";
  static const RIGHT_ON_WALL_COMMISSIONING_ENTER_PASSWORD = _RIGHT_ON_WALL_ROUTE_PATH + "enterpassword";
  static const RIGHT_ON_WALL_COMMISSIONING_SHOW_TYPE = _RIGHT_ON_WALL_ROUTE_PATH + "model1_show_panel_type";
  static const _LEFT_ON_WALL_ROUTE_PATH = _FRIDGE_ROUTE_PATH + "inside_left/";
  static const LEFT_ON_WALL_MAIN_NAVIGATOR = "/" + _LEFT_ON_WALL_ROUTE_PATH;
  static const LEFT_ON_WALL_DESCRIPTION2_MODEL1 = _LEFT_ON_WALL_ROUTE_PATH + "description2_model1";
  static const LEFT_ON_WALL_DESCRIPTION3_MODEL1 = _LEFT_ON_WALL_ROUTE_PATH + "description3_model1";
  static const LEFT_ON_WALL_DESCRIPTION4_MODEL1 = _LEFT_ON_WALL_ROUTE_PATH + "description4_model1";
  static const LEFT_ON_WALL_COMMISSIONING_ENTER_PASSWORD = _LEFT_ON_WALL_ROUTE_PATH + "enterpassword";

  // Water Products
  static const _WATER_PRODUCTS_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "water_products/";
  static const WATER_PRODUCTS_SELECTION_PAGE = _WATER_PRODUCTS_ROUTE_PATH + "page_water_products_selection_type";
  static const WATER_PRODUCTS_MAIN_NAVIGATOR = '/' + _WATER_PRODUCTS_ROUTE_PATH;
  static const WATER_SOFTENER_DESCRIPTION = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_softener_description";
  static const WATER_SOFTENER_APPLIANCE_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_softener_appliance_info";
  static const WATER_SOFTENER_PASSWORD_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_softener_password_info";
  static const WATER_HEATER_DESCRIPTION = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_heater_description";
  static const WATER_HEATER_APPLIANCE_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_heater_appliance_info";
  static const WATER_HEATER_PASSWORD_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_heater_password_info";
  static const WATER_FILTER_DESCRIPTION = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_filter_description";
  static const WATER_FILTER_APPLIANCE_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_filter_appliance_info";
  static const WATER_FILTER_PASSWORD_INFO = WATER_PRODUCTS_MAIN_NAVIGATOR + "page_water_filter_password_info";

  //Gateway
  static const GATEWAY_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "gateway/";
  static const GATEWAY_MAIN_NAVIGATOR = "/" + GATEWAY_ROUTE_PATH;
  static const GATEWAY_NAVIGATE_PAGE = GATEWAY_ROUTE_PATH + "gateway_navigate_page";
  static const GATEWAY_SELECT_GATEWAY_PAGE = GATEWAY_ROUTE_PATH + "select_gateway_page";
  static const GATEWAY_SELECT_GATEWAY_LIST_PAGE = GATEWAY_ROUTE_PATH + "select_gateway_list_page";
  static const GATEWAY_STARTED_PAGE = GATEWAY_ROUTE_PATH + "started_page";
  static const GATEWAY_DESCRIPTION_PAGE = GATEWAY_ROUTE_PATH + "description_page";
  static const GATEWAY_PAIR_SENSOR_DESCRIPTION_PAGE = GATEWAY_ROUTE_PATH + "pair_sensor_description_page";
  static const GATEWAY_PAIR_SENSOR_PAIRING_PAGE = GATEWAY_ROUTE_PATH + "pair_sensor_pairing_page";
  static const GATEWAY_PAIR_SENSOR_SUCCESS_PAGE = GATEWAY_ROUTE_PATH + "pair_sensor_success_page";
  static const GATEWAY_PAIR_SENSOR_FAILURE_PAGE = GATEWAY_ROUTE_PATH + "pair_sensor_failure_page";

  //ShowMeHow
  static const _SHOW_ME_HOW_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "show_me_how/";
  static const SHOW_ME_HOW_MAIN_NAVIGATOR = "/" + _SHOW_ME_HOW_ROUTE_PATH;
  static const SHOW_ME_HOW_MAIN_IPHONE = _SHOW_ME_HOW_ROUTE_PATH + "iphone";
  static const SHOW_ME_HOW_MAIN_ANDROID = _SHOW_ME_HOW_ROUTE_PATH + "android";
  static const SHOW_ME_HOW_MAIN_IPHONEX = _SHOW_ME_HOW_ROUTE_PATH + "iphonex";

  static const BLE_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "ble/";

  // Brand Selection
  static const BRAND_SELECTION = _BASE_COMMISSIONING_ROUTE_PATH + "brand_selection";

  // Shortcut
  static const _SHORTCUT_COMMON_ROUTE_PATH = _BASE_CONTROL_ROUTE_PATH + "shortcut/";
  static const SHORTCUT_MAIN_NAVIGATOR = "/" + _SHORTCUT_COMMON_ROUTE_PATH;
  static const SHORTCUT_ENTRY_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_entry_page";
  static const SHORTCUT_SELECT_OVEN_TYPE_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_select_oven_type_page";
  static const SHORTCUT_SELECT_TYPE_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_select_type_page";
  static const SHORTCUT_CREATE_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_create_page";
  static const SHORTCUT_REVIEW_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_review_page";
  static const SHORTCUT_TURN_OFF_PAGE = _SHORTCUT_COMMON_ROUTE_PATH + "shortcut_turn_off_page";

  /// Related to Status Screen Routes from Here -----------------------------
  static const _BASE_CONTROL_ROUTE_PATH = "control/";

  //Common Control
  static const _CONTROL_COMMON_ROUTE_PATH = _BASE_CONTROL_ROUTE_PATH + "common/";
  static const CONTROL_COMMON_NOTIFICATION_SETTING = _CONTROL_COMMON_ROUTE_PATH + "notification_setting/";

  //Stand Mixer
  static const _STAND_MIXER_CONTROL_ROUTE_PATH = _BASE_CONTROL_ROUTE_PATH + "stand_mixer/";
  static const STAND_MIXER_CONTROL_MAIN_NAVIGATOR = "/" + _STAND_MIXER_CONTROL_ROUTE_PATH;
  static const STAND_MIXER_CONTROL_NAVIGATE_PAGE = _STAND_MIXER_CONTROL_ROUTE_PATH + "stand_mixer_control_navigate_page";
  static const STAND_MIXER_CONTROL_PAGE = _STAND_MIXER_CONTROL_ROUTE_PATH + "control_page";
  static const STAND_MIXER_ADD_TIMER_PAGE = _STAND_MIXER_CONTROL_ROUTE_PATH + "add_timer_page";

  //Recipe's
  static const String RECIPE_MAIN_NAVIGATOR = "/" + COMMON_RECIPE_ROUTE_PATH;
  static const String RECIPE_DICOVER_PAGE = COMMON_RECIPE_ROUTE_PATH + "recipe_discover_screen";
  static const String RECIPE_DETAILS_PAGE = COMMON_RECIPE_ROUTE_PATH + "recipe_detail_screen";
  static const String RECIPE_ADD_INGREDIENT_ARCHETYPE = COMMON_RECIPE_ROUTE_PATH + "archetypes/recipe_archetype_measure_screen";
  static const String RECIPE_MIXING_ARCHETYPE = COMMON_RECIPE_ROUTE_PATH + "archetypes/recipe_archetype_mixing_screen";
  static const String RECIPE_MIXING_TIMER_ARCHETYPE = COMMON_RECIPE_ROUTE_PATH + "archetypes/recipe_archetype_cook_mix_timer_screen";
  static const String RECIPE_OVEN_ARCHETYPE = COMMON_RECIPE_ROUTE_PATH + "archetypes/recipe_archetype_oven_screen";
  static const String RECIPE_FINISH_ARCHETYPE = COMMON_RECIPE_ROUTE_PATH + "archetypes/recipe_archetype_finish_screen";

  //Grind Brew
  static const GRIND_BREW_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "grind_brew/";
  static const GRIND_BREW_MAIN_NAVIGATOR = "/" + GRIND_BREW_ROUTE_PATH;
  static const GRIND_BREW_DESCRIPTION_MODEL = GRIND_BREW_ROUTE_PATH + "grind_brew_description_model";
  static const GRIND_BREW_ENTER_PASSWORD = GRIND_BREW_ROUTE_PATH + "grind_brew_enter_password";

  //flavourly
  static const FLAVOURLY_ROUTE_PATH = _BASE_COMMISSIONING_ROUTE_PATH + "flavourly/";
  static const FLAVOURLY_MAIN_NAVIGATOR = "/" + FLAVOURLY_ROUTE_PATH;
  static const String FLAVOURLY_SPLASH_SCREEN = FLAVOURLY_ROUTE_PATH + "splash_screen";
  static const String FLAVOURLY_HOME_SCREEN = FLAVOURLY_ROUTE_PATH + "home_screen";
  static const String FLAVOURLY_UNIVERSAL_GENERATOR = FLAVOURLY_ROUTE_PATH + "universal_generator";
  static const String FLAVOURLY_MENU_DETAILS_PAGE = FLAVOURLY_ROUTE_PATH + "menu_details_page";

}
