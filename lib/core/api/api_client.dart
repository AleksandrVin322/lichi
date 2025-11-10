import 'dart:convert';
import 'dart:io';

import '../dto/category.dart';
import '../dto/product.dart';

class ApiClient {
  static const uriProductList = 'get_category_product_list';
  static const uriCategoryDetail = 'get_category_detail';

  /// POST запрос для получения списка товаров по категории.
  Future<List<Product>> getCategoryProductList({
    /// Категория товара.
    required String category,

    /// Страница для пагинации.
    required int page,
  }) async {
    final url = _getUri(uriProductList);
    final Map<String, dynamic> body = {
      'shop': 2,
      'lang': 1,
      'category': category,
      'limit': 12,
      'page': page,
    };
    try {
      final jsonData = await _postRequest(url, body);
      return Product.fromJsonList(jsonData);
    } catch (_) {
      rethrow;
    }
  }

  /// POST запрос для получения списка категорий товаров.
  Future<List<Category>> getCategoryDetail() async {
    final url = _getUri(uriCategoryDetail);
    const Map<String, dynamic> body = {
      'shop': 2,
      'lang': 1,
      'category': 'clothes',
    };
    try {
      final jsonData = await _postRequest(url, body);
      return Category.fromJsonList(jsonData);
    } catch (_) {
      rethrow;
    }
  }
}

/// Сборщик url.
Uri _getUri(String path) {
  final url = Uri.parse('https://api.lichi.com/category/$path');
  return url;
}

/// Метод для POST запроса с декодированием.
Future<dynamic> _postRequest(Uri url, Map<String, dynamic> body) async {
  final client = HttpClient();
  final request = await client.postUrl(url);
  request.headers.add('Content-type', 'application/json; charset=UTF-8');
  request.write(jsonEncode(body));
  final response = await request.close();
  final data = await response
      .transform(utf8.decoder)
      .toList()
      .then((value) => value.join());
  final jsonData = jsonDecode(data);
  return jsonData;
}
