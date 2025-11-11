import 'package:shared_preferences/shared_preferences.dart';

import '../dto/cart.dart';

class DatabaseClient {
  static const String _cartKey = 'cart_data';

  /// Сохранение корзины в локальную базу данных.
  Future<void> saveCart(Cart cart) async {
    try {
      final init = await SharedPreferences.getInstance();

      final cartJson = cart.toJsonString();
      await init.setString(_cartKey, cartJson);
    } catch (_) {
      rethrow;
    }
  }

  /// Загрузка корзины из локальной базы данных.
  Future<Cart> loadCart() async {
    try {
      final init = await SharedPreferences.getInstance();
      final cartJson = init.getString(_cartKey);
      if (cartJson != null && cartJson.isNotEmpty) {
        return Cart.fromJsonString(cartJson);
      } else {
        return const Cart(products: {});
      }
    } catch (_) {
      rethrow;
    }
  }
}
