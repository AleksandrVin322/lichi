import 'dart:convert';

import 'product_with_count.dart';

class Cart {
  final List<ProductWithCount> productCount;
  final int itemCount;
  final int sum;
  const Cart({required this.productCount, this.sum = 0, this.itemCount = 0});

  Map<String, dynamic> toJson() {
    return {
      'productCount': productCount.map((pwc) => pwc.toJson()).toList(),
      'itemCount': itemCount,
      'sum': sum,
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    final productCountList =
        (json['productCount'] as List<dynamic>?)
            ?.map((item) => ProductWithCount.fromJson(item))
            .toList() ??
        [];

    return Cart(
      productCount: productCountList,
      itemCount: json['itemCount'] as int? ?? 0,
      sum: json['sum'] as int? ?? 0,
    );
  }
  String toJsonString() {
    return json.encode(toJson());
  }

  factory Cart.fromJsonString(String jsonString) {
    return Cart.fromJson(json.decode(jsonString));
  }
}
