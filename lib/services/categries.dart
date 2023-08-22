import 'package:dio/dio.dart';

import '../models/category_model.dart';

class CategoryGet {
  final Dio dio = Dio();
  Future<List<String>> fetchCategoryItem() async {
    List<String> items = [];
    var url =
        await dio.get<String>("https://dummyjson.com/products/categories");
    if (url.statusCode == 200) {
      var categories = categoryFromJson(url.data!);

      return categories;
    }
    return items;
  }
}
