class Product {
  final int price;
  final List<String> photos;
  final String name;
  final List<String> formatPrice;
  final String? size;

  Product({
    required this.price,
    required this.photos,
    required this.formatPrice,
    required this.name,
    required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final photosJson = json['photos'] as List<dynamic>? ?? [];
    final photoUrls = photosJson
        .map((photo) => photo['big'] as String? ?? '')
        .where((url) => url.isNotEmpty)
        .toList();
    final formatPriceJson = json['format_price'] as List<dynamic>? ?? [];
    final formatPriceList = formatPriceJson
        .map((item) => item.toString())
        .toList();

    return Product(
      price: json['price'] as int? ?? 0,
      photos: photoUrls,
      formatPrice: formatPriceList,
      name: json['name'] as String? ?? '',
      size: null,
    );
  }
}
