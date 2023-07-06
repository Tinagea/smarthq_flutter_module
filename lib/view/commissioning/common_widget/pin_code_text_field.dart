import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smarthq_flutter_module/view/common/formatter/upper_case_text_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';

class CommissioningPassword {
  Widget getPinCodeTextField({
    var context: BuildContext,
    var onChanged: Function,
    var onCompleted: Function,
    required FocusNode focusNode,
    required TextEditingController textEditingController
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
      child: Form(
        child: PinCodeTextField(
          appContext: context,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          focusNode: focusNode,
          controller: textEditingController,
          autoDisposeControllers: false,
          length: 8,
          textCapitalization: TextCapitalization.characters,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5.r),
              fieldHeight: 35.h,
              fieldWidth: 30.w,
              activeColor: Colors.white),
          animationDuration: Duration(milliseconds: 300),
          inputFormatters: [
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp('[B C D F G H J K L M N P Q R S T V W X Y Z b c d f g h j k l m n p q r s t v w x y z]')),
            FilteringTextInputFormatter.deny(RegExp(' '))
          ],
          backgroundColor: Colors.transparent,
          enableActiveFill: false,
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (text) {
            // geaLog.debug("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }


  Widget getPinCodeTextFieldNoMargin({
    var context: BuildContext,
    var onChanged: Function,
    var onCompleted: Function,
    required FocusNode focusNode,
    required TextEditingController textEditingController
  }) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Form(
          child: PinCodeTextField(
            appContext: context,
            textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            focusNode: focusNode,
            controller: textEditingController,
            autoDisposeControllers: false,
            length: 8,
            textCapitalization: TextCapitalization.characters,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                borderRadius: BorderRadius.circular(5.r),
                fieldHeight: 35.h,
                fieldWidth: 30.w,
                activeColor: Colors.white),
            animationDuration: Duration(milliseconds: 300),
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp('[B C D F G H J K L M N P Q R S T V W X Y Z b c d f g h j k l m n p q r s t v w x y z]')),
              FilteringTextInputFormatter.deny(RegExp(' '))
            ],
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            onCompleted: onCompleted,
            onChanged: onChanged,
            beforeTextPaste: (text) {
              // geaLog.debug("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
        ),
      ),
    );
  }
  Widget getGEModuleNameTextField({
    var context: BuildContext,
    var title: String,
    var onChanged: Function,
    var onCompleted: Function,
    required FocusNode focusNode,
    required TextEditingController textEditingController
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
      child: Row(
          children: [
            Component.componentDescriptionText(text: title),
            Expanded(
              child: Form(
                child: PinCodeTextField(
                  appContext: context,
                  textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  focusNode: focusNode,
                  controller: textEditingController,
                  autoDisposeControllers: false,
                  length: 4,
                  textCapitalization: TextCapitalization.characters,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      borderRadius: BorderRadius.circular(5.r),
                      fieldHeight: 35.h,
                      fieldWidth: 30.w,
                      activeColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                    FilteringTextInputFormatter.allow(RegExp('[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0]')),
                    FilteringTextInputFormatter.deny(RegExp(' '))
                  ],
                  backgroundColor: Colors.transparent,
                  enableActiveFill: false,
                  onCompleted: onCompleted,
                  onChanged: onChanged,
                  beforeTextPaste: (text) {
                    // geaLog.debug("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),)
          ]
      ),
    );
  }
  Widget getPinCodeTextField1({
    var context: BuildContext,
    var onChanged: Function,
    var onCompleted: Function,
    required TextEditingController textEditingController
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
      child: Form(
        child: PinCodeTextField(
          appContext: context,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          controller: textEditingController,
          autoDisposeControllers: false,
          length: 8,
          textCapitalization: TextCapitalization.characters,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5.r),
              fieldHeight: 35.h,
              fieldWidth: 30.w,
              activeColor: Colors.white),
          animationDuration: Duration(milliseconds: 300),
          inputFormatters: [
            UpperCaseTextFormatter(),
            FilteringTextInputFormatter.allow(RegExp('[B C D F G H J K L M N P Q R S T V W X Y Z b c d f g h j k l m n p q r s t v w x y z]')),
            FilteringTextInputFormatter.deny(RegExp(' '))
          ],
          backgroundColor: Colors.transparent,
          enableActiveFill: false,
          onCompleted: onCompleted,
          onChanged: onChanged,
          beforeTextPaste: (text) {
            // geaLog.debug("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}