import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/common_widget/info_dialog.dart';

//create a dialog box

class SmartSenseInfoCard extends StatefulWidget {
  final bool isAuto;
  SmartSenseInfoCard({required this.isAuto});

  @override
  _SmartSenseInfoCardState createState() => _SmartSenseInfoCardState();
}

class _SmartSenseInfoCardState extends State<SmartSenseInfoCard> {
  List<String> imageUrls = [
    ImagePath.AUTO_SENSE_INFO_0,
    ImagePath.AUTO_SENSE_INFO_1,
    ImagePath.AUTO_SENSE_INFO_2,
    ImagePath.AUTO_SENSE_INFO_3,
  ];

  @override
  Widget build(BuildContext context) {
    List<String> imageDescriptions = [];
    if (widget.isAuto){
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SMART_SENSE_INFO_CARD_1)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SMART_SENSE_INFO_CARD_2)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SMART_SENSE_INFO_CARD_3)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_SMART_SENSE_INFO_CARD_4)!);
    } else {
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_GUIDED_INFO_CARD_1)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_GUIDED_INFO_CARD_2)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_GUIDED_INFO_CARD_3)!);
      imageDescriptions.add(LocaleUtil.getString(context, LocaleUtil.STAND_MIXER_GUIDED_INFO_CARD_4)!);
    }
    return InfoDialog(
        title: [LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)!, LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)!, LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)!, LocaleUtil.getString(context, LocaleUtil.AUTO_SENSE)!],
        imageURIs: imageUrls,
        subText: imageDescriptions,
        cardCount: imageUrls.length,
        imageSizes: [Size(175.h, 175.w),Size(175.h, 175.w),Size(175.h, 175.w), Size(175.h, 175.w)], subTextStyle: textStyle_size_14_color_raisin_black()

    );
  }
}