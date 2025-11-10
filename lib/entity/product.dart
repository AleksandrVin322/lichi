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

  factory Product.fromJson(Map<String, dynamic> json) {
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
}
