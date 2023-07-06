import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_heater/water_heater_locate_label_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_heater/water_heater_getting_started_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_heater/water_heater_appliance_password_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_products_select_type_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_filter/water_filter_locate_label_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_filter/water_filter_getting_started_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_filter/water_filter_appliance_password_page.dart' as WaterProduct;

import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_softener/water_softener_locate_label_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_softener/water_softener_getting_started_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/commissioning/appliance_page/water_products/water_softener/water_softener_appliance_password_page.dart' as WaterProduct;
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WaterProductsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Navigator(
        initialRoute: Routes.WATER_PRODUCTS_SELECTION_PAGE,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case Routes.WATER_PRODUCTS_SELECTION_PAGE:
              builder = (BuildContext _) => WaterProduct.PageWaterProductsSelectType();
              break;
              case Routes.WATER_SOFTENER_DESCRIPTION:
              builder = (BuildContext _) => WaterProduct.WaterSoftenerDescription();
              break;
            case Routes.WATER_SOFTENER_APPLIANCE_INFO:
              builder = (BuildContext _) => WaterProduct.WaterSoftenerApplianceInfo();
              break;
            case Routes.WATER_SOFTENER_PASSWORD_INFO:
              builder = (BuildContext _) => WaterProduct.WaterSoftenerPasswordInfo();
              break;
            case Routes.WATER_HEATER_DESCRIPTION:
              builder = (BuildContext _) => WaterProduct.WaterHeaterDescription();
              break;
            case Routes.WATER_HEATER_APPLIANCE_INFO:
              builder = (BuildContext _) => WaterProduct.WaterHeaterApplianceInfo();
              break;
            case Routes.WATER_HEATER_PASSWORD_INFO:
              builder = (BuildContext _) => WaterProduct.WaterHeaterPasswordInfo();
              break;
            case Routes.WATER_FILTER_DESCRIPTION:
              builder = (BuildContext _) => WaterProduct.WaterFilterDescription();
              break;
            case Routes.WATER_FILTER_APPLIANCE_INFO:
              builder = (BuildContext _) => WaterProduct.WaterFilterApplianceInfo();
              break;
            case Routes.WATER_FILTER_PASSWORD_INFO:
              builder = (BuildContext _) => WaterProduct.WaterFilterPasswordInfo();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}