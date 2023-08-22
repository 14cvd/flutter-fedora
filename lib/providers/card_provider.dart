import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/sold_product.dart';

class CardProvider with ChangeNotifier {
  List<SoldProduct> _items = [];

  List<SoldProduct> get items {
    return [..._items];
  }

  void addProduct(SoldProduct product) {
    if (_items.indexWhere((element) => element.id == product.id) == -1) {
      _items.add(product);
    } else {
      int index = _items.indexWhere((element) => element.id == product.id);
      _items[index].count += product.count;
    }
    notifyListeners();
  }

  void removeProduct(SoldProduct product) {
    int index = _items.indexWhere((element) => element.id == product.id);
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void increaseItemCount(SoldProduct product) {
    int index = _items.indexWhere((element) => element.id == product.id);
    _items[index].count++;
    notifyListeners();
  }

  void decreaseItemCount(SoldProduct product) {
    int index = _items.indexWhere((element) => element.id == product.id);
    if (_items[index].count > 0) {
      _items[index].count--;
    }
    notifyListeners();
  }
}
