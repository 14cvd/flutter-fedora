import 'package:dio/dio.dart';
import 'package:flutter_fedora/models/product_model.dart';

class GetOfProductACategoryService {
  static Future<List<Product>> getOfProductCategoryItem(String name) async {
    var response =
        await Dio().get("https://dummyjson.com/products/category/$name");
    if (response.statusCode == 200) {
      var data = response.data["products"];
      if (data is List) {
        return data.map((e) => Product.fromJson(e)).toList();
      }
    }
    return [];
  }
}
