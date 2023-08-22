// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/product_model.dart';
import 'package:flutter_fedora/screens/product_detail_screen.dart';
import 'package:flutter_fedora/widgets/card_widget.dart';

class ProductWidget extends StatelessWidget {
  final Future future;
  const ProductWidget({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> products = snapshot.data;
        return GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: .7),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: CardWidget(
                imgPath: products[index].thumbnail,
                title: products[index].title,
                subtitle: products[index].category,
                price: products[index].price,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(productId: products[index].id)),
                );
              },
            );
          },
        );
      },
    );
  }
}
