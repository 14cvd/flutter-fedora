import 'package:flutter/material.dart';
import 'package:flutter_fedora/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/sold_product.dart';
import '../providers/order_provider.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    final List<SoldProduct> soldProducts = orderProvider.soldProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
      ),
      body: ListView.builder(
        itemCount: soldProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            productId: soldProducts[index].id,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      soldProducts[index].imgPath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          soldProducts[index].title,
                          style: TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          "${soldProducts[index].price.toString()}\$",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "x${soldProducts[index].count.toString()}",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
