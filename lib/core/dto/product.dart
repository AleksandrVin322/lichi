/// Сущность для товаров.
class Product {
  /// Цена товара.
  final int price;

  /// Массив с фотографиями товара.
  final List<String> photos;

  /// Имя товара.
  final String name;

  /// Массив содержащий разные записи цены товара.
  final List<String> formatPrice;

  /// Массив содержащий возможные цвета товара.
  final List<String> colors;

  /// Размер товара.
  final String? size;

  /// Конструктор [Product].
  Product({
    required this.price,
    required this.photos,
    required this.formatPrice,
    required this.name,
    required this.size,
    required this.colors,
  });

  /// Метод для извлечения JSON.
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

  /// Метод для извлечения из database.
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

  /// Метод для создания JSON.
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          size == other.size;

  @override
  int get hashCode => name.hashCode ^ size.hashCode;
}
