import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _searchedData = [];

  List<String> get searchedData {
    return _searchedData;
  }

  void addData(String value) {
    _searchedData.add(value);
  }

  void removeData(String value) {
    int index = _searchedData.indexOf(value);
    _searchedData.removeAt(index);
  }
}
