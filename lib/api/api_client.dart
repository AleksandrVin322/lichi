import 'dart:convert';
import 'dart:io';

import '../entity/category.dart';
import '../entity/product.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Product>> getCategoryProductList(String category) async {
    List<Product> products = [];
    var url = Uri.parse(
      'https://api.lichi.com/category/get_category_product_list',
    );
    final Map<String, dynamic> body = {
      'shop': 2,
      'lang': 1,
      'category': category,
      'limit': 12,
      'page': 1,
    };
    final request = await client.postUrl(url);
    request.headers.add('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(body));
    final response = await request.close();
    final data = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final jsonData = jsonDecode(data);
    final aProductList = jsonData['api_data']['aProduct'] as List<dynamic>;
    products = aProductList.map((productJson) {
      return Product.fromJson(productJson as Map<String, dynamic>);
    }).toList();
    return products;
  }

  Future<List<Category>> getCategoryDetail() async {
    List<Category> category = [];
    var url = Uri.parse('https://api.lichi.com/category/get_category_detail');
    const Map<String, dynamic> body = {
      'shop': 2,
      'lang': 1,
      'category': 'clothes',
    };
    final request = await client.postUrl(url);
    request.headers.add('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(body));
    final response = await request.close();
    final data = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join());
    final jsonData = jsonDecode(data);
    final aProductList = jsonData['api_data']['aMenu'] as List<dynamic>;
    category = aProductList.map((productJson) {
      return Category.fromJson(productJson as Map<String, dynamic>);
    }).toList();
    return category;
  }
}
