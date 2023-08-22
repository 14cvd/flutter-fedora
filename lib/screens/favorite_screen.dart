// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_fedora/models/get_single_a_prodcut.dart';
import 'package:flutter_fedora/providers/favorite_provider.dart';
import 'package:flutter_fedora/services/get_single_a_product_service.dart';

import 'product_detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context);
    final List<int> favoriteProducts = favoriteProvider.favoriteProducts;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Favorite'),
          centerTitle: true,
          actions: [
            if (favoriteProducts.isNotEmpty)
              IconButton(
                onPressed: () {
                  AlertDialog alert = AlertDialog(
                    title: Text("Remove All Favorite"),
                    content:
                        Text("Are you sure you want to remove all favorite?"),
                    actions: [
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          setState(() {
                            favoriteProvider.removeAllFavoriteProduct();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
                icon: Icon(Icons.delete_rounded),
              )
          ],
        ),
        body: ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: GetSingleAProductService.getSingleProductItem(
                  favoriteProducts[index]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                GetSingleAProduct product = snapshot.data[0];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                  productId: product.id,
                                )));
                  },
                  child: ListTile(
                    leading: Image.network(
                      product.thumbnail,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title,
                        style: TextStyle(fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    subtitle: Text("${product.price.toString()}\$",
                        style: TextStyle(fontSize: 16)),
                    trailing: IconButton(
                      icon: favoriteProducts.contains(product.id)
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          favoriteProducts.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            );
            // return Column(
            //   children: [
            //     Text(favoriteProducts[index].toString()),
            //     IconButton(
            //         onPressed: () {
            //           setState(() {
            //             favoriteProducts.removeAt(index);
            //           });
            //         },
            //         icon: Icon(Icons.delete))
            //   ],
            // );
          },
        ));
  }
}
