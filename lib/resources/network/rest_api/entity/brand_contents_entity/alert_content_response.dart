
class AlertContentResponse {
  String? version;
  String? title;
  List<Content>? content;

  AlertContentResponse({this.version, this.title, this.content});

  AlertContentResponse.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    title = json['title'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = this.version;
    data['title'] = this.title;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? type;
  String? text;
  String? image;
  String? link;

  Content({this.type, this.text, this.image, this.link});

  Content.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    text = json['text'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = this.type;
    data['text'] = this.text;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}

