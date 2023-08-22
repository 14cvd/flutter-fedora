// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/sold_product.dart';
import 'package:flutter_fedora/providers/card_provider.dart';
import 'package:flutter_fedora/screens/adress_section.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    final CardProvider cardProvider = Provider.of<CardProvider>(context);
    final List<SoldProduct> items = cardProvider.items;
    int totalPrice = 0;

    for (SoldProduct e in items) {
      totalPrice += e.count * e.price;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            )),
        title: const Text(
          'Cart Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isClicked = !isClicked;
                });
              },
              icon: Icon(Icons.delete, color: Colors.white, size: 30)),
        ],
      ),
      body: items.isNotEmpty
          ? Container(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  SoldProduct product = items[index];
                  return ListTile(
                    leading: Image.network(product.imgPath,
                        width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(product.title),
                    subtitle: Text('${product.price.toStringAsFixed(2)}\$'),
                    trailing: isClicked
                        ? IconButton(
                            onPressed: () {
                              cardProvider.removeProduct(product);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.green[900],
                            ))
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.squareMinus,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (product.count > 1) {
                                      cardProvider.decreaseItemCount(product);
                                      totalPrice -= product.price;
                                    }
                                  });
                                },
                              ),
                              Text('${product.count}'),
                              IconButton(
                                icon: const FaIcon(
                                  FontAwesomeIcons.squarePlus,
                                ),
                                onPressed: () {
                                  setState(() {
                                    cardProvider.increaseItemCount(product);
                                    totalPrice += product.price;
                                  });
                                },
                              ),
                            ],
                          ),
                  );
                },
              ),
            )
          : Center(
              child: Text('Your cart is empty.'),
            ),
      bottomNavigationBar: items.isNotEmpty
          ? BottomAppBar(
              height: 110,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${totalPrice.toStringAsFixed(2)}\$',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdressSee()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 18)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
