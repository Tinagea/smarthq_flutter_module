/*
 * Copyright GE Appliances, a Haier Company (Confidential). All rights reserved.
 */

/// Content Items
enum ContentItemType {
  imageLink('imageLink'),
  titleText('titleText'),
  image('image'),
  gap('gap'),
  text('text'),
  unknown('unknown');

  const ContentItemType(this.strValue);

  final String strValue;

  factory ContentItemType.getTypeFrom({required String strValue}) {
    return ContentItemType.values.firstWhere(
            (value) => value.strValue == strValue,
        orElse: () => ContentItemType.unknown);
  }
}

abstract class ContentItem {
  ContentItem(this.contentItemType);

  late ContentItemType contentItemType;

  ContentItem.fromJson(Map<String, dynamic> json) {
    var type = json['contentItemType'];
    this.contentItemType = ContentItemType.getTypeFrom(strValue: type);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contentItemType'] = this.contentItemType.strValue;
    return data;
  }

  factory ContentItem.makeFromJson(Map<String, dynamic> json) {
    ContentItem? item;
    final itemType = json['contentItemType'];
    final type = ContentItemType.getTypeFrom(strValue: itemType);
    switch (type) {
      case ContentItemType.titleText:
        item = ContentItemTitleText.fromJson(json);
        break;
      case ContentItemType.text:
        item = ContentItemText.fromJson(json);
        break;
      case ContentItemType.image:
        item = ContentItemImage.fromJson(json);
        break;
      case ContentItemType.gap:
        item = ContentItemGap.fromJson(json);
        break;
      case ContentItemType.imageLink:
        item = ContentItemImageLink.fromJson(json);
        break;
      case ContentItemType.unknown:
        item = ContentItemUnknown.fromJson(json);
        break;
    }
    return item;
  }
}

class ContentItemImageLink extends ContentItem {
  ContentItemImageLink({this.image, this.link,})
      : super(ContentItemType.imageLink);

  late String? image;
  late String? link;

  ContentItemImageLink.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    image = json['image'];
    link = json['link'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}

class ContentItemTitleText extends ContentItem {
  ContentItemTitleText({this.text})
      : super(ContentItemType.titleText);
  late String? text;

  ContentItemTitleText.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    text = json['text'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['text'] = this.text;
    return data;
  }
}

class ContentItemImage extends ContentItem {
  ContentItemImage({this.image})
      : super(ContentItemType.image);
  late String? image;

  ContentItemImage.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    image = json['image'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['image'] = this.image;
    return data;
  }
}

class ContentItemGap extends ContentItem {
  ContentItemGap()
      : super(ContentItemType.gap);

  ContentItemGap.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

class ContentItemText extends ContentItem {
  ContentItemText({this.text})
      : super(ContentItemType.text);
  late String? text;

  ContentItemText.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    text = json['text'];
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['text'] = this.text;
    return data;
  }
}

class ContentItemUnknown extends ContentItem {
  ContentItemUnknown()
      : super(ContentItemType.unknown);

  ContentItemUnknown.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}
