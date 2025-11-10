import 'product.dart';

class ProductWithCount {
  final Product product;
  int count;

  ProductWithCount({required this.product, this.count = 0});

  Map<String, dynamic> toJson() {
    return {'product': product.toJson(), 'count': count};
  }

  factory ProductWithCount.fromJson(Map<String, dynamic> json) {
    return ProductWithCount(
      product: Product.fromJsonMap(json['product']),
      count: json['count'] as int? ?? 0,
    );
  }
}
