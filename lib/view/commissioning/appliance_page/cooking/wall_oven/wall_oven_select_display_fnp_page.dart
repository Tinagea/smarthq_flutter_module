import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

class WallOvenSelectDisplayFnpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CommonAppBar(
          title: LocaleUtil.getString(context, LocaleUtil.SELECT_APPLIANCE),
          leftBtnFunction: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).setNavigationAppBar(context: context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Component.componentUpperDescriptionText(LocaleUtil.getString(context, LocaleUtil.WHICH_ONE_DESCRIBES_YOUR_WALL_OVEN)!),
              ModelSelectionCard(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.WALL_OVEN_MODEL_1_STEP_1_FNP);
                },
                imagePath: ImagePath.COOKING_WALL_OVEN_CONTROLLER1,
              ),
              BaseComponent.heightSpace(16.h),
              ModelSelectionCard(
                imagePath: ImagePath.COOKING_WALL_OVEN_CONTROLLER2,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.WALL_OVEN_MODEL_1_STEP_1_FNP);
                },
              ),
              BaseComponent.heightSpace(16.h),
              ModelSelectionCard(
                imagePath: ImagePath.COOKING_WALL_OVEN_CONTROLLER3,
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.WALL_OVEN_MODEL_2_STEP_1_FNP);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModelSelectionCard extends StatelessWidget {
  const ModelSelectionCard({Key? key, required this.imagePath, required this.onTap}) : super(key: key);

  final String imagePath;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 182.h,
        decoration: Component.commonCardBackgroundDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
        child: Center(child: SvgPicture.asset(imagePath)),
      ),
    );
  }
}
