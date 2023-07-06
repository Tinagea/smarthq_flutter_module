

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/models/dialog/push_notification/alert/details/push_notification_alert_details_model.dart';
import 'package:smarthq_flutter_module/resources/network/rest_api/entity/brand_contents_entity/alert_content_response.dart';

abstract class PushNotificationAlertDetailsMaker {

  static String makeKeyFrom(
      String countryCode, String languageCode,
      String deviceType, String alertType) {
    return '$countryCode$languageCode$deviceType$alertType';
  }

  static List<ContentItem> makeContentItemsFrom(AlertContentResponse response) {
    final contentsItems = <ContentItem>[];
    response.content?.forEach((item) {
      final contentItemType = ContentItemType.getTypeFrom(strValue: item.type!);
      switch(contentItemType) {
        case ContentItemType.titleText:
          contentsItems.add(ContentItemTitleText(text: item.text));
          break;
        case ContentItemType.text:
          contentsItems.add(ContentItemText(text: item.text));
          break;
        case ContentItemType.gap:
          contentsItems.add(ContentItemGap());
          break;
        case ContentItemType.image:
          if (item.image != null) {
            contentsItems.add(ContentItemImage(
                image: _mapImageAssetToUrl(item.image!)));
          }
          break;
        case ContentItemType.imageLink:
          if (item.image != null) {
            contentsItems.add(ContentItemImageLink(
                image: _mapImageAssetToUrl(item.image!),
                link: item.link));
          }
          break;
        case ContentItemType.unknown:
          contentsItems.add(ContentItemUnknown());
          break;
      }
    });

    return contentsItems;
  }

  static String? _mapImageAssetToUrl(String image) {
    return "${BuildEnvironment.config.brandContentsHost}/$image";
  }
}