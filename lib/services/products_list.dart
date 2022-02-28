import 'dart:convert';

import 'package:selfscancorafluttergetx/models/product_model.dart';
import 'package:selfscancorafluttergetx/services/api.dart';

Future<List<ProductModel>> getProductList() async {
  final response = await getBasket();

  Map<String, dynamic> map = jsonDecode(response);

  List products = map["transactionSuccess"]["itemList"];

  List<ProductModel> productsList =
      products.map((jsonData) => ProductModel.fromJson(jsonData)).toList();

  return productsList;
}
