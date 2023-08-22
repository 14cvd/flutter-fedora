import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<int> _favoriteProducts = [];

  List<int> get favoriteProducts => _favoriteProducts;

  void toogleFavoriteProduct(int productId) {
    if (_favoriteProducts.contains(productId)) {
      _favoriteProducts.remove(productId);
    } else {
      _favoriteProducts.add(productId);
    }
    notifyListeners();
  }

  bool isFavoriteProduct(int productId) {
    return _favoriteProducts.contains(productId);
  }

  void removeAllFavoriteProduct() {
    _favoriteProducts.clear();
    notifyListeners();
  }
}
