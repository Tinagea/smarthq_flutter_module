import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smarthq_flutter_module/resources/repositories/data_item/notification_history_item.dart';
import 'package:smarthq_flutter_module/utils/common_util.dart';
import 'package:smarthq_flutter_module/view/commissioning/common_widget/component.dart';
import 'package:smarthq_flutter_module/view/common/constant/image_path.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';
import 'package:intl/intl.dart';

class NotificationHistoryComponents {

  static Widget createCard({
    required NotificationHistoryItem item,
    required void Function() onTapMoreDetails,
  }) {
    final pushTitle = item.pushTitle;
    final pushText = item.pushText;

    // original date time (utc)
    final dateTimeString = item.commandDateTime;
    final dateTime = DateTime.parse(dateTimeString!);

    // displayed date string (device locale)
    final dateTimeLocal = dateTime.toLocal();
    final displayDateFormat = DateFormat('MMM d h:mma');
    final displayDateString = displayDateFormat.format(dateTimeLocal);

    final hasTitle = !CommonUtil.isEmptyString(pushTitle);
    final hasDetails = (item.detailsState == NotificationHistoryDetailsButtonStatus.shouldShow);
    final shouldShowLoading = (item.detailsState == NotificationHistoryDetailsButtonStatus.loading);

    final List<Widget> widgets = [];
    if (hasTitle) {
      // has title
      // title
      final stackView = Stack(
        children: [
          Text(
            pushTitle!,
            style: textStyle_size_15_bold_color_white()
          ),
          if (shouldShowLoading) _addLoadingView()
        ],
      );
      widgets.add(stackView);
      // date
      widgets.add(Text(
        displayDateString,
        style: textStyle_size_14_light_color_grey(),
      ));

      // divider
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: Container(
            height: 1.h,
            color: Colors.grey,
          ),
        ),
      );
      // description
      widgets.add(Text(
        pushText!,
        style: textStyle_size_14_light_color_white(),
      ));
    } else {
      // no title
      // date
      final stackView = Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              displayDateString,
              style: textStyle_size_14_light_color_grey(),
            ),
          ),
          if (shouldShowLoading) _addLoadingView()
        ],
      );
      widgets.add(stackView);
      // description
      widgets.add(
        Text(
          pushText!,
          style: textStyle_size_14_light_color_white(),
        ),
      );
    }

    // details button
    if (hasDetails) {
      widgets.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTapMoreDetails,
        child: Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Details",
                style: textStyle_size_15_bold_color_white(),
              ),
              Spacer(),
              Image.asset(ImagePath.NAVIGATE_NEXT_ICON, height: 14.h)
            ],
          ),
        ),
      ));
    } else {
      widgets.add(Container(height: 8.0.h));
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: Component.componentApplianceSelectBoxDecorate(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  static Widget _addLoadingView() {
    return Container(
      height: 18.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(colorDeepPurple()),
            ),
            height: 13,
            width: 13,
          ),
        ],
      ),
    );
  }

  static Widget getDefaultText(String str) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        str,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  static Widget createLoadingIndicator() {
    return Center(
        child: CircularProgressIndicator(color: Colors.purple,));
  }
}
