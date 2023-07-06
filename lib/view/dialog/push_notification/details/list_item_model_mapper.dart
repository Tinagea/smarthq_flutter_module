import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';
import 'package:smarthq_flutter_module/view/common/text_style/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PushDetailWidgetMapper {
  static List<Widget> mapContentItemsToWidgets(
    BuildContext context,
    List<ContentItem> contentItems,
  ) {
    return contentItems.map((contentItem) {
      var contentItemType = contentItem.contentItemType;
      switch (contentItemType) {
        case ContentItemType.imageLink:
          final typedContainerItem = contentItem as ContentItemImageLink;
          return wrapPadding(
            child: GestureDetector(
              child: Image.network(typedContainerItem.image ?? ""),
              onTap: () async {
                final url = typedContainerItem.link;
                if (url != null) {
                  final uri = Uri.parse(url);
                  await launchUrl(uri);
                }
              },
            ),
          );
        case ContentItemType.titleText:
          final typedContainerItem = contentItem as ContentItemTitleText;
          return wrapPadding(
            padding: EdgeInsets.only(top: 16.0),
            child: Container(
              child: Text(
                typedContainerItem.text ?? "",
                style: textStyle_size_20_bold_color_white(),
              ),
            ),
          );
        case ContentItemType.image:
          final typedContainerItem = contentItem as ContentItemImage;
          return wrapPadding(
            child: Container(
              child: Image.network(typedContainerItem.image ?? ""),
            ),
          );
        case ContentItemType.gap:
          return wrapPadding(
              padding: EdgeInsets.only(
                  top: 16.0, left: 8.0, right: 8.0, bottom: 0.0),
              child: Container());
        case ContentItemType.text:
          final typedContainerItem = contentItem as ContentItemText;
          return wrapPadding(
            child: Container(
              child: Text(
                typedContainerItem.text ?? "",
                style: textStyle_size_14_color_white(),
              ),
            ),
          );
        default:
          return Container();
      }
    }).toList();
  }

  static Widget wrapPadding({
    Widget? child,
    EdgeInsets padding =
        const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
  }) {
    return Padding(padding: padding, child: child);
  }
}
