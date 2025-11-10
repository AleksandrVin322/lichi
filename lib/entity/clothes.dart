class Clothes {
  final int price;
  final List<String> photos;
  final String name;
  final List<String> formatPrice;

  Clothes({
    required this.price,
    required this.photos,
    required this.formatPrice,
    required this.name,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    final photosJson = json['photos'] as List<dynamic>? ?? [];
    final photoUrls = photosJson
        .map((photo) => photo['big'] as String? ?? '')
        .where((url) => url.isNotEmpty)
        .toList();
    final formatPriceJson = json['format_price'] as List<dynamic>? ?? [];
    final formatPriceList = formatPriceJson
        .map((item) => item.toString())
        .toList();

    return Clothes(
      price: json['price'] as int? ?? 0,
      photos: photoUrls,
      formatPrice: formatPriceList,
      name: json['name'] as String? ?? '',
    );
  }
}
