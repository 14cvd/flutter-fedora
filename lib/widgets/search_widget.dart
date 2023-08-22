// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/models/product_model.dart';
import 'package:flutter_fedora/services/search_service.dart';

import '../screens/product_detail_screen.dart';

class SearchWidget extends StatelessWidget {
  final String data;
  const SearchWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SearchService.fetchItems(data),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<Product> products = snapshot.data;
        return Expanded(
          child: products.isNotEmpty
              ? ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                      productId: products[index].id,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                products[index].thumbnail,
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
                                    products[index].title,
                                    style: TextStyle(fontSize: 18),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "${products[index].price.toString()}\$",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    products[index].category.toString(),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: Text('No data found')),
        );
      },
    );
  }
}
