import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeManager extends ChangeNotifier {
  late ThemeData _currentTheme = lightTheme();
  bool isChange = false;

  ThemeData get currentTheme => _currentTheme;

  void setTheme(AppTheme theme) {
    _currentTheme = theme == AppTheme.light ? lightTheme() : darkTheme();
    notifyListeners();
  }

  ThemeData darkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.dark(),
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green[400],
        unselectedItemColor: Colors.grey[100],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
