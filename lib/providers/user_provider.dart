import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
   Future<void> addData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_firstName, _firstName);
    await prefs.setString(_lastName, _lastName);
    await prefs.setString(_email, _email);
  }

  String _firstName = 'User';
  String _lastName = 'Name';
  String _email = 'example@gmail.com';
  String _imgPath =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80';

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get imgPath => _imgPath;

  set firstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  set lastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set imgPath(String imgPath) {
    _imgPath = imgPath;
    notifyListeners();
  }
}
