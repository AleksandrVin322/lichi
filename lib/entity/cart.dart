import 'product_count.dart';

class Cart {
  final List<ProductCount> productCount;
  final int itemCount;
  final int sum;
  const Cart({required this.productCount, this.sum = 0, this.itemCount = 0});
}
