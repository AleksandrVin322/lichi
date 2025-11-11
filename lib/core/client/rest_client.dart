import 'dart:convert';
import 'dart:io';

import '../dto/category.dart';
import '../dto/product.dart';

class RestClient {
  static const uriProductList = 'get_category_product_list';
  static const uriCategoryDetail = 'get_category_detail';
  final client = HttpClient();

  /// Получение списка товаров по категории.
  Future<List<Product>> getCategoryProductList({
    required String category,
    required int page,
  }) async {
    final url = _getUri(uriProductList);
    final body = {
      'shop': 2,
      'lang': 1,
      'category': category,
      'limit': 12,
      'page': page,
    };

    try {
      final jsonData = await _postRequest(url, body, client);

      return Product.fromJsonList(jsonData);
    } catch (_) {
      rethrow;
    }
  }

  /// Получение списка категорий товаров.
  Future<List<Category>> getCategoryDetail() async {
    final url = _getUri(uriCategoryDetail);
    const body = {'shop': 2, 'lang': 1, 'category': 'clothes'};

    try {
      final jsonData = await _postRequest(url, body, client);

      return Category.fromJsonList(jsonData);
    } catch (_) {
      rethrow;
    }
  }
}

/// Конвертация строки в url.
Uri _getUri(String path) {
  return Uri.parse('https://api.lichi.com/category/$path');
}

/// Post запрос.
Future<dynamic> _postRequest(
  Uri url,
  Map<String, dynamic> body,
  HttpClient client,
) async {
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
