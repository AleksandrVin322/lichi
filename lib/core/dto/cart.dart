import 'dart:convert';

import 'product.dart';

/// Сущность для корзины с товарами.
class Cart {
  /// [Map] в которой хранятся товары и их количество.
  final Map<Product, int> products;

  /// Количество товаров в корзине.
  final int itemCount;

  /// Общая сумма товаров в корзине.
  final int totalSum;

  /// Конструктор [Cart].
  const Cart({required this.products, this.totalSum = 0, this.itemCount = 0});

  Map<String, dynamic> toJson() {
    return {
      'products': _productsToJson(products),
      'itemCount': itemCount,
      'sum': totalSum,
    };
  }

  static List<Map<String, dynamic>> _productsToJson(
    Map<Product, int> products,
  ) {
    return products.entries.map((entry) {
      return {'product': entry.key.toJson(), 'count': entry.value};
    }).toList();
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      products: _productsFromJson(json['products']),
      itemCount: json['itemCount'] as int? ?? 0,
      totalSum: json['sum'] as int? ?? 0,
    );
  }

  static Map<Product, int> _productsFromJson(List<dynamic>? jsonList) {
    final products = <Product, int>{};
    if (jsonList != null) {
      for (final item in jsonList) {
        final product = Product.fromJsonMap(item['product']);
        final count = item['count'] as int;
        products[product] = count;
      }
    }
    return products;
  }

  String toJsonString() {
    return json.encode(toJson());
  }

  factory Cart.fromJsonString(String jsonString) {
    return Cart.fromJson(json.decode(jsonString));
  }
}
