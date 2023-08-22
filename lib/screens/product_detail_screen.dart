// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/get_single_a_prodcut.dart';
import 'package:flutter_fedora/models/sold_product.dart';
import 'package:flutter_fedora/providers/favorite_provider.dart';
import 'package:flutter_fedora/services/get_single_a_product_service.dart';
import 'package:flutter_fedora/widgets/product_details.dart';
import 'package:provider/provider.dart';

import '../providers/card_provider.dart';
import 'cart_page.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<GetSingleAProduct> product = [];
  int itemCount = 0;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    GetSingleAProductService.getSingleProductItem(widget.productId)
        .then((value) {
      setState(() {
        product = value;
      });
    });
  }

  void increaseItemCount() {
    setState(() {
      itemCount++;
      totalAmount += product[0].price;
    });
  }

  void decreaseItemCount() {
    setState(() {
      if (itemCount > 0) {
        itemCount--;
        totalAmount -= product[0].price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);
    final CardProvider cardProvider = Provider.of<CardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(Icons.shopping_bag_outlined)),
          Padding(
            padding: EdgeInsets.only(right: .0),
            child: IconButton(
              icon: favoriteProvider.isFavoriteProduct(widget.productId)
                  ? Icon(Icons.favorite, color: Colors.red)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                setState(() {
                  favoriteProvider.toogleFavoriteProduct(widget.productId);
                });
              },
            ),
          )
        ],
        title: const Center(child: Text('Product Details')),
      ),
      body: product.isNotEmpty
          ? ProductDetails(product: product[0])
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: product.isNotEmpty
          ? BottomAppBar(
              height: 125,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton.outlined(
                              onPressed: decreaseItemCount,
                              icon: const Icon(Icons.remove)),
                          const SizedBox(
                            width: 15,
                          ),
                          Text("$itemCount"),
                          const SizedBox(
                            width: 15,
                          ),
                          IconButton.outlined(
                              onPressed: () {
                                increaseItemCount();
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                      Text(
                        '\$${(totalAmount * (1 - product[0].discountPercentage / 100)).toStringAsFixed(2)}',
                        style:
                            const TextStyle(fontSize: 26, color: Colors.green),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cardProvider.addProduct(SoldProduct(
                          id: product[0].id,
                          price: product[0].price,
                          title: product[0].title,
                          count: itemCount,
                          imgPath: product[0].thumbnail));
                      SnackBar snackBar = SnackBar(
                        content: Text(
                            "${product[0].title} added to basket $itemCount"),
                        duration: const Duration(seconds: 2),
                      );
                      if (itemCount > 0)
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      itemCount = 0;
                      totalAmount = 0.0;
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(300, 25)),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.green,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Add to Basket",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
