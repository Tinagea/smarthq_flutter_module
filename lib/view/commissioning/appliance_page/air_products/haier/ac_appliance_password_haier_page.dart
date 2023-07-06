import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/cubits/commissioning_cubit.dart';
import 'package:smarthq_flutter_module/globals.dart' as globals;
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/app_bar.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/base_component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/custom_richtext.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';

class AcAppliancePasswordHaierPage extends StatefulWidget {
  AcAppliancePasswordHaierPage({Key? key}) : super(key: key);

  _AcAppliancePasswordHaierPageState createState() => _AcAppliancePasswordHaierPageState();
}

class _AcAppliancePasswordHaierPageState extends State<AcAppliancePasswordHaierPage> {
  TextFieldStatus _passwordTextFieldStatus = TextFieldStatus.empty;

  FocusNode _passwordFocusNode = FocusNode();

  ScrollController _scrollController = new ScrollController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _passwordFocusNode.addListener(() {
      if (_passwordFocusNode.hasFocus) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: LocaleUtil.getString(context, LocaleUtil.ADD_APPLIANCE)).setNavigationAppBar(context: context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: <Widget>[
                    BaseComponent.heightSpace(16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      child: Component.componentMainImage(context, ImagePath.HAIER_AC_PASSWORD),
                    ),
                    CustomRichText.customSpanListTextBoxCenter(
                      textSpanList: <TextSpan>[
                        TextSpan(text: LocaleUtil.getString(context, LocaleUtil.ENTER_THE_PASSWORD_FOUND_ON_THE_LABEL_HAIER_AC), style: textStyle_size_18_color_white()),
                      ],
                    ),
                    BaseComponent.heightSpace(48.h),
                    Component.componentDescriptionText(text: LocaleUtil.getString(context, LocaleUtil.ENTER_PASSWORD)!, marginInsets: EdgeInsets.symmetric(horizontal: 28.w), textAlignment: TextAlign.center),
                    Component.componentPincodeTextfield(context, _passwordFocusNode, (textFieldStatus) {
                      setState(() {
                        _passwordTextFieldStatus = textFieldStatus;
                      });
                    }, (textValue) {
                      BlocProvider.of<CommissioningCubit>(context).keepACMPassword(textValue);
                    }),
                  ],
                ),
              ),
              Component.componentBottomButton(
                isEnabled: _passwordTextFieldStatus == TextFieldStatus.equalToMaxLength,
                title: LocaleUtil.getString(context, LocaleUtil.CONTINUE)!,
                onTapButton: () {
                  BlocProvider.of<CommissioningCubit>(context).actionSaveAcmPassword();
                  globals.subRouteName = Routes.COMMON_CHOOSE_WIFI_CONNECTION_PAGE;
                  Navigator.of(context, rootNavigator: true).pushNamed(Routes.COMMON_MAIN_NAVIGATOR);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
