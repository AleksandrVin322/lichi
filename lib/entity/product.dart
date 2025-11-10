class Product {
  final int price;
  final List<String> photos;
  final String name;
  final List<String> formatPrice;
  final List<String> colors;
  final String? size;

  Product({
    required this.price,
    required this.photos,
    required this.formatPrice,
    required this.name,
    required this.size,
    required this.colors,
  });

  static List<Product> fromJsonList(Map<String, dynamic> json) {
    final aProductList = json['api_data']['aProduct'] as List<dynamic>? ?? [];
    return aProductList.map((productJson) {
      return Product._parseJson(productJson as Map<String, dynamic>);
    }).toList();
  }

  factory Product._parseJson(Map<String, dynamic> json) {
    final photosJson = json['photos'] as List<dynamic>? ?? [];
    final photoUrls = photosJson
        .map((photo) => photo['thumbs']['384_512'] as String? ?? '')
        .where((url) => url.isNotEmpty)
        .toList();
    final formatPriceJson = json['format_price'] as List<dynamic>? ?? [];
    final formatPriceList = formatPriceJson
        .map((item) => item.toString())
        .toList();
    final colorsCurrentJson =
        json['colors']['current']['value'] as String? ?? '';
    final colorsOtherJson = json['colors']['other'] as List<dynamic>? ?? [];
    final colorsOtherValues = colorsOtherJson
        .map((color) => color['value'] as String? ?? '')
        .toList();
    final colorsAllValues = [...colorsOtherValues];
    colorsAllValues.insert(0, colorsCurrentJson);
    return Product(
      price: json['price'] as int? ?? 0,
      photos: photoUrls,
      formatPrice: formatPriceList,
      name: json['name'] as String? ?? '',
      size: null,
      colors: colorsAllValues,
    );
  }

  factory Product.fromJsonMap(Map<String, dynamic> json) {
    return Product(
      price: json['price'] as int? ?? 0,
      photos: List<String>.from(json['photos'] ?? []),
      name: json['name'] as String? ?? '',
      formatPrice: List<String>.from(json['format_price'] ?? []),
      colors: List<String>.from(json['colors'] ?? []),
      size: json['size'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'photos': photos,
      'name': name,
      'format_price': formatPrice,
      'colors': colors,
      'size': size,
    };
  }
}
