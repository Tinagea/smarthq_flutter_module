import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/country_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/resources/storage/native_storage.dart';

class LaundrySelectTypeFnpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE)!.toUpperCase(),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).setNavigationAppBar(context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 20.h,
                  children: <Widget>[
                    Component.componentApplianceVerticalListTile(
                        context: context,
                        title: LocaleUtil.getString(context, LocaleUtil.WASHER)!,
                        imagePath: ImagePath.LAUNDRY_SELECTION_WASHER_FNP,
                        isLongIcon: true,
                        clickedFunction:() {
                          switch (RepositoryProvider.of<NativeStorage>(context).countryCode ?? CountryUtil.us) {
                            case CountryUtil.sg:
                              globals.subRouteName = Routes.WASHER_MODEL_1_GETTING_STARTED_FNP;
                              break;

                            default:
                              globals.subRouteName = Routes.WASHER_FRONT_1_DISPLAY_MODEL_SELECT_FNP;
                              break;
                          }
                          Navigator.of(context).pushNamed(Routes.WASHER_MAIN_NAVIGATOR);
                        }),
                    Component.componentApplianceVerticalListTile(
                        context: context,
                        title: LocaleUtil.getString(context, LocaleUtil.DRYER)!,
                        imagePath: ImagePath.LAUNDRY_SELECTION_DRYER_FNP,
                        isLongIcon: true,
                        clickedFunction:() {
                          switch (RepositoryProvider.of<NativeStorage>(context).countryCode ?? CountryUtil.us) {
                            case CountryUtil.gb:
                            case CountryUtil.ie:
                              globals.subRouteName = Routes.DRYER_MODEL_2_GETTING_STARTED_FNP;
                              break;

                            default:
                              globals.subRouteName = Routes.DRYER_FRONT_1_DISPLAY_MODEL_SELECT_FNP;
                              break;
                          }
                          Navigator.of(context).pushNamed(Routes.DRYER_MAIN_NAVIGATOR);
                        }),
                  ],
                ),
          ),
        ),
      ),
    );
  }

  Widget componentMainSelectImageButton({
    required BuildContext context,
    required String imageName,
    required String text,
    required EdgeInsets paddingInsets,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [
            Color.fromARGB(255, 32, 32, 34),
            Color.fromARGB(255, 48, 49, 52),
          ]),
          color: Color(0xFF303134),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: paddingInsets,
          child: Row(
            children: [
              SvgPicture.asset(imageName),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: textStyle_size_18_bold_color_white(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
