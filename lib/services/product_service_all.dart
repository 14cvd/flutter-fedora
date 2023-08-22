import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_fedora/models/product_model.dart';

class ProductService {
  static Future<List<Product>> fetchItems() async {
    var response = await Dio().get("https://dummyjson.com/products");
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
