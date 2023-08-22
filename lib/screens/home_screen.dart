// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/methods/methods.dart';
import 'package:flutter_fedora/services/categries.dart';
import 'package:flutter_fedora/services/get_of_product_a_category_service.dart';
import 'package:flutter_fedora/services/product_service_all.dart';
import 'package:flutter_fedora/widgets/product_widget.dart';

import 'cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> categories = [];
  late TabController _tabController;
  String _appTitle = "Shopping App";

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    List<String> fetchedCategories = await CategoryGet().fetchCategoryItem();
    setState(() {
      categories = fetchedCategories;
      _tabController =
          TabController(length: categories.length + 1, vsync: this);
      _tabController.addListener(_updateTitle);
    });
  }

  void _updateTitle() {
    if (_tabController.index != 0) {
      setState(() {
        _appTitle = capitalize(categories[_tabController.index - 1]);
      });
    } else {
      setState(() {
        _appTitle = "Shopping App";
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_updateTitle);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return categories.isNotEmpty
        ? DefaultTabController(
            length: categories.length + 1,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(_appTitle),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartPage()));
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[800]),
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    unselectedLabelColor: Colors.grey[600],
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      Tab(text: "All"),
                      ...categories
                          .map<Widget>((e) => Tab(
                                text: capitalize(e),
                              ))
                          .toList()
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ProductWidget(
                      future: ProductService.fetchItems(),
                    ),
                    ...categories
                        .map(
                          (e) => ProductWidget(
                            future: GetOfProductACategoryService
                                .getOfProductCategoryItem(e),
                          ),
                        )
                        .toList()
                  ],
                )),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(_appTitle),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              ],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
