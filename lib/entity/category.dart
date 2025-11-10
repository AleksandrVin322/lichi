class Category {
  final String name;
  final String url;

  Category({required this.name, required this.url});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}
