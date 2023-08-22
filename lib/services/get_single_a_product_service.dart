import 'package:dio/dio.dart';
import 'package:flutter_fedora/models/get_single_a_prodcut.dart';

class GetSingleAProductService {
  static Future<List<GetSingleAProduct>> getSingleProductItem(int id) async {
    var response = await Dio().get("https://dummyjson.com/products/$id");
    if (response.statusCode == 200) {
      var data = response.data;

      return [GetSingleAProduct.fromJson(data)];
    }

    return [];
  }
}
