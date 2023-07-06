import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class FridgeInsideRightLocateLabelFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE),
        ).setNavigationAppBar(context: context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Component.componentMainImageWithPadding(
                      context,
                      ImagePath.RIGHT_ON_WALL_APPLIANCE_INFORMATION_PASSWORD_1,
                      EdgeInsets.all(10)),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: Text(
                            LocaleUtil.getString(
                              context,
                              LocaleUtil.LOCATE_THE_CONNECTED_APPLIANCE_LABEL,
                            )!,
                            style: textStyle_size_20_color_white(),
                          ),
                        ),
                        _getFnPFridgePanelTypeCard(
                          image: ImagePath.FRIDGE_FRENCH_DOOR,
                          title: LocaleUtil.getString(
                            context,
                            LocaleUtil.FRENCH_DOOR_MODELS_TITLE,
                          )!,
                          subtitle: LocaleUtil.getString(
                            context,
                            LocaleUtil.FRENCH_DOOR_BEHIND_DRAWER_ON_LOWER_FRAME,
                          )!,
                        ),
                        _getFnPFridgePanelTypeCard(
                          image: ImagePath.RIGHT_ON_WALL_2_DOOR,
                          title: LocaleUtil.getString(
                            context,
                            LocaleUtil.DOOR_2_MODELS_TITLE,
                          )!,
                          subtitle: LocaleUtil.getString(
                            context,
                            LocaleUtil.DOOR_2_MODELS_BEHIND_LOWER,
                          )!,
                        ),
                        _getFnPFridgePanelTypeCard(
                          image: ImagePath.RIGHT_ON_WALL_QUAD_DOOR,
                          title: LocaleUtil.getString(
                            context,
                            LocaleUtil.QUAD_DOOR_MODELS_TITLE,
                          )!,
                          subtitle: LocaleUtil.getString(
                            context,
                            LocaleUtil.QUAD_DOOR_MODELS_ON_THE_RIGHT_SIDE,
                          )!,
                        ),
                      ],
                    ),
                  ),
                  Component.componentBottomButton(
                    isEnabled: true,
                    title: LocaleUtil.getString(context, LocaleUtil.NEXT)!,
                    onTapButton: () {
                      Navigator.of(context).pushNamed(
                          Routes.RIGHT_ON_WALL_COMMISSIONING_ENTER_PASSWORD);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFnPFridgePanelTypeCard(
      {required String image,
      required String title,
      required String subtitle}) {
    return SizedBox(
      width: double.infinity,
      height: 120.h,
      child: Card(
        color: Colors.grey[900],
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SvgPicture.asset(image),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: title,
                            style: textStyle_size_18_bold_color_white(),
                          ),
                          TextSpan(
                            text: subtitle,
                            style: textStyle_size_18_normal400_color_white(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
