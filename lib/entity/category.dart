class Category {
  final String name;
  final String url;

  Category({required this.name, required this.url});

  static List<Category> fromJsonList(Map<String, dynamic> json) {
    final aMenuList = json['api_data']['aMenu'] as List<dynamic>;
    return aMenuList.map((aMenuList) {
      return Category._parseJson(aMenuList as Map<String, dynamic>);
    }).toList();
  }

  factory Category._parseJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}
