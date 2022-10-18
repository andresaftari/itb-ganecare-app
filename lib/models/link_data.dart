class LinkData {
  String title;
  String url;
  String description;

  LinkData({
    required this.title,
    required this.description,
    required this.url,
  });

  factory LinkData.fromJson(json) => LinkData(
        title: json['title'] ?? 'No Title',
        url: json['url'] ?? '',
        description: json['description'] ?? 'No description',
      );
}
