/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;


class CookingSelectTypeFnpPage extends StatelessWidget {
  final Iterable<CookingAppliance> appliances = List.unmodifiable([
    CookingAppliance(
      id: 1,
      imagePath: ImagePath.COOKING_APPLIANCE_TYPE_WALL_OVEN_SVG,
      name: LocaleUtil.WALL_OVEN,
      availableCountries: List.unmodifiable(CountryUtil.allFnpCountries),
    ),
    CookingAppliance(
      id: 2,
      imagePath: ImagePath.COOKING_APPLIANCE_TYPE_RANGE_SVG,
      name: LocaleUtil.RANGE,
      availableCountries: List.unmodifiable([CountryUtil.ca, CountryUtil.us]),
    ),
    // Removed for the next release
    // CookingAppliance(
    //   id: 3,
    //   imagePath: ImagePath.COOKING_APPLIANCE_TYPE_VENTILATION_SVG,
    //   name: LocaleUtil.VENTILATION,
    //   availableCountries: List.unmodifiable(CountryUtil.allCountries),
    // ),
  ]);

  CookingSelectTypeFnpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   Iterable<CookingAppliance> filteredAppliances = _filterAppliances(
        RepositoryProvider.of<NativeStorage>(context).countryCode ??
            CountryUtil.us,
        appliances);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!
              .toUpperCase(),
          leftBtnFunction: () {
            Navigator.of(context).pop();
          },
        ).setNavigationAppBar(context: context),
        body: GridView.builder(
              itemCount: filteredAppliances.length,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemBuilder: (context, index) {
                var appliance = filteredAppliances.elementAt(index);
                return ApplianceTypeGridTile(
                  appliance.imagePath,
                  LocaleUtil.getString(context, appliance.name)!,
                  () => navigateToAppliance(context, appliance.id),
                );
              },
            ),
      ),
    );
  }

  Iterable<CookingAppliance> _filterAppliances(
      String? userCountryCode, Iterable<CookingAppliance> allAppliances) {
    List<CookingAppliance> result = List.empty(growable: true);
    for (var appliance in allAppliances) {
      if (userCountryCode == null ||
          appliance.availableCountries.contains(userCountryCode)) {
        result.add(appliance);
      }
    }
    return List.unmodifiable(result);
  }

  navigateToAppliance(BuildContext context, int id) {
    switch (id) {
      case 1:
        globals.subRouteName = Routes.WALL_OVEN_MODEL_SELECTION_FNP;
        Navigator.pushNamed(context, Routes.WALL_OVEN_MAIN_FNP_NAVIGATOR);
        break;

      case 2:
        globals.subRouteName = Routes.RANGE_FNP_GETTING_STARTED;
        Navigator.pushNamed(context, Routes.RANGE_MAIN_FNP_NAVIGATOR);
        break;
    }
  }
}

class ApplianceTypeGridTile extends StatelessWidget {
  final String _imagePath;
  final String _applianceName;
  final Function() _onTap;

  const ApplianceTypeGridTile(this._imagePath, this._applianceName, this._onTap,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 32, 32, 34),
                Color.fromARGB(255, 48, 49, 52)
              ]),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        child: InkWell(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment(0, 0.25),
                  child: FractionallySizedBox(
                    child: SvgPicture.asset(
                      _imagePath,
                      width: 68.w,
                    ),
                  ),
                ),
              ),
              Text(
                _applianceName,
                style: textStyle_size_15_bold_color_white(),
                textAlign: TextAlign.center,
              ),
              BaseComponent.heightSpace(19.h)
            ],
          ),
          onTap: _onTap,
        ),
      ),
    );
  }
}

class CookingAppliance {
  final int id;
  final String imagePath;
  final String name;
  final Iterable<String> availableCountries;

  CookingAppliance(
      {required this.id,
      required this.imagePath,
      required this.name,
      required this.availableCountries});
}
