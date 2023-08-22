import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/sold_product.dart';

class OrderProvider extends ChangeNotifier {
  List<SoldProduct> _soldProducts = [];

  List<SoldProduct> get soldProducts => _soldProducts;

  void addProduct(List<SoldProduct> product) {
    _soldProducts.addAll(product);
    notifyListeners();
  }
}
