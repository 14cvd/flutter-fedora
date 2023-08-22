import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_fedora/models/product_model.dart';

class SearchService {
  static Future<List<Product>> fetchItems(String data) async {
    var response =
        await Dio().get("https://dummyjson.com/products/search?q=${data}");
    if (response.statusCode == HttpStatus.ok) {
      var data = response.data["products"];

      if (data is List) {
        return data.map((e) => Product.fromJson(e)).toList();
      }
    }
    return [];
  }
}


//Fedora
