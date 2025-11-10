// class LocalBd {
//   Future<void> addProduct(Product product) async {
//     final init = await SharedPreferences.getInstance();
//     final productJson = json.encode(product.toJson());
//     await init.setString('product_data', productJson);
//   }
// }
