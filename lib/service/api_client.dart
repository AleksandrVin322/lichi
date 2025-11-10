import 'dart:convert';
import 'dart:io';

import '../entity/clothes.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Clothes>> getCategoryProductList() async {
    List<Clothes> products = [];
    var url = Uri.parse(
      'https://api.lichi.com/category/get_category_product_list',
    );
    const Map<String, dynamic> body = {
      'shop': 2,
      'lang': 1,
      'category': 'dresses',
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
      return Clothes.fromJson(productJson as Map<String, dynamic>);
    }).toList();
    return products;
  }
}
