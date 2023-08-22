// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Location'),
          centerTitle: true,
        ),
        body: Column(
          children: List.generate(
              4,
              (index) => ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text('Location $index'),
                    subtitle: Text('Address $index'),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  )),
        ));
  }
}
