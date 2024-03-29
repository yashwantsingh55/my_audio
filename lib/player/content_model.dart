class ContentModel {
  String contentId;
  String contentName;
  String contentType;
  Images images;
  List<dynamic> preview;
  List<ContentDescription> contentDescription;
  List<dynamic> video;
  Audio audio;
  Location location;
  String parentId;
  String nextContentId;

  ContentModel({
    required this.contentId,
    required this.contentName,
    required this.contentType,
    required this.images,
    required this.preview,
    required this.contentDescription,
    required this.video,
    required this.audio,
    required this.location,
    required this.parentId,
    required this.nextContentId,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      contentId: json['contentId'],
      contentName: json['contentName'],
      contentType: json['contentType'],
      images: Images.fromJson(json['images']),
      preview: json['preview'],
      contentDescription: List<ContentDescription>.from(
          json['contentDescription']
              .map((x) => ContentDescription.fromJson(x))),
      video: json['video'],
      audio: Audio.fromJson(json['audio']),
      location: Location.fromJson(json['location']),
      parentId: json['parentId'],
      nextContentId: json['nextContentId'],
    );
  }
}

class Images {
  String icon;
  String landscape;
  String portrait;

  Images({
    required this.icon,
    required this.landscape,
    required this.portrait,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      icon: json['icon'],
      landscape: json['landscape'],
      portrait: json['portrait'],
    );
  }
}

class ContentDescription {
  String small;
  String large;
  String languageCode;

  ContentDescription({
    required this.small,
    required this.large,
    required this.languageCode,
  });

  factory ContentDescription.fromJson(Map<String, dynamic> json) {
    return ContentDescription(
      small: json['small'],
      large: json['large'],
      languageCode: json['languageCode'],
    );
  }
}

class Audio {
  String url;
  String format;
  List<dynamic> script;

  Audio({
    required this.url,
    required this.format,
    required this.script,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      url: json['url'],
      format: json['format'],
      script: json['script'],
    );
  }
}

class Location {
  String latitude;
  String longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}




