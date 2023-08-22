// ignore_for_file: prefer_final_fields
// ignore: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/providers/user_provider.dart';
import 'package:flutter_fedora/screens/product_icon_screen.dart';
import 'package:provider/provider.dart';

import 'providers/card_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/order_provider.dart';
import 'providers/search_provider.dart';
import 'providers/theme_manager_provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CardProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeManager(),
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: themeManager.currentTheme,
              home: const IconScreen(),
            );
          },
        ),
      ),
    );
  }
}
