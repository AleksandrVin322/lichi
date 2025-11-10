import 'package:shared_preferences/shared_preferences.dart';

import '../entity/cart.dart';

class SharedPreferencesApi {
  static const String _cartKey = 'cart_data';

  Future<void> saveCart(Cart cart) async {
    try {
      final init = await SharedPreferences.getInstance();

      final cartJson = cart.toJsonString();
      await init.setString(_cartKey, cartJson);
    } on () {
      rethrow;
    }
  }

  Future<Cart> loadCart() async {
    try {
      final init = await SharedPreferences.getInstance();
      final cartJson = init.getString(_cartKey);
      if (cartJson != null && cartJson.isNotEmpty) {
        return Cart.fromJsonString(cartJson);
      } else {
        return const Cart(productCount: []);
      }
    } on () {
      rethrow;
    }
  }
}
