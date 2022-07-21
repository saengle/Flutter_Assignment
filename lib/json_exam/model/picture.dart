class Picture {
  final String tags;
  final String previewURL;

  Picture({
    required this.previewURL,
    required this.tags
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}