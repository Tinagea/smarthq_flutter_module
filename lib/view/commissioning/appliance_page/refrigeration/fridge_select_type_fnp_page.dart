import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';

class FridgeSelectTypeFnpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CommonAppBar(
              title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)!
                  .toUpperCase(),
              leftBtnFunction: () {
                Navigator.of(context, rootNavigator: true).pop();
              }).setNavigationAppBar(context: context),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: _buildFnPFridgeTypeList(
                  context: context, userCountryCode: RepositoryProvider.of<NativeStorage>(context).countryCode ?? CountryUtil.us),
            ),
          )),
    );
  }

  Widget _buildFnPFridgeTypeList(
      {required BuildContext context, String? userCountryCode}) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10.w,
      children: <Widget>[
        Component.componentUpperDescriptionText(LocaleUtil.getString(
            context, LocaleUtil.LOCATE_FRIDGE_TEMP_CONTROL)!),
        _getFnPFridgeTypeCard(
          context: context,
          image: ImagePath.FRIDGE_MAIN_SELECT_IMAGE3_FNP,
          title: LocaleUtil.getString(context, LocaleUtil.ON_THE_TOP)!,
          userLocale: userCountryCode,
          onTap: () {
            // Initial route saved in globals
            globals.subRouteName = Routes.ON_TOP_DESCRIPTION2_FNP_MODEL3;
            Navigator.pushNamed(context, Routes.ON_TOP_MAIN_NAVIGATOR);
          },
        ),
        _getFnPFridgeTypeCard(
          context: context,
          image: ImagePath.FRIDGE_MAIN_SELECT_IN_THE_MIDDLE,
          title: LocaleUtil.getString(context, LocaleUtil.IN_THE_MIDDLE)!,
          userLocale: userCountryCode,
          onTap: () {
            print("Click ${Routes.IN_THE_MIDDLE_MAIN_NAVIGATOR}");
            Navigator.pushNamed(context, Routes.IN_THE_MIDDLE_MAIN_NAVIGATOR);
          },
        ),
        _getFnPFridgeTypeCard(
          context: context,
          image: ImagePath.FRIDGE_MAIN_SELECT_RIGHT_ON_WALL,
          title: LocaleUtil.getString(context, LocaleUtil.RIGHT_ON_WALL)!,
          userLocale: userCountryCode,
          onTap: () {
            print("Click ${Routes.RIGHT_ON_WALL_MAIN_NAVIGATOR}");
            // Set sub route for CommonNavigator to use
            globals.subRouteName = Routes.RIGHT_ON_WALL_DESCRIPTION2_MODEL1;
            Navigator.pushNamed(context, Routes.RIGHT_ON_WALL_MAIN_NAVIGATOR);
          },
        ),
        BaseComponent.heightSpace(20.h)
      ],
    );
  }

  Widget _getFnPFridgeTypeCard({
    required BuildContext context,
    String image = '',
    required String title,
    List<String>? limitedCountries,
    required String? userLocale,
    required Function() onTap,
  }) {
    if (limitedCountries == null || limitedCountries.contains(userLocale)) {
      return SizedBox(
        width: double.infinity,
        height: 182.h,
        child: Card(
          color: Colors.grey[900],
          child: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Row(
                children: [
                  if (image != '') SvgPicture.asset(image),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: textStyle_size_18_bold_color_white()),
                    ),
                  )
                ],
              ),
            ),
            onTap: onTap,
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
