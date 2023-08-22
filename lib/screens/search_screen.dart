// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/providers/search_provider.dart';
import 'package:flutter_fedora/widgets/search_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    List<String> items = searchProvider.searchedData;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search product...',
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (controller.text.isNotEmpty) {
                          searchProvider.addData(controller.text);
                        }
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      size: 35,
                    )),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2)),
              ),
              onEditingComplete: () {
                setState(() {
                  if (controller.text.isNotEmpty) {
                    searchProvider.addData(controller.text);
                  }
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            items.isNotEmpty
                ? Text(
                    'Recent Searches',
                    style: TextStyle(fontSize: 18),
                  )
                : Text('No recent searches'),
            controller.text.isEmpty
                ? recentSearchs(items, searchProvider, controller)
                : SearchWidget(data: controller.text),
          ],
        ),
      ),
    );
  }

  Widget recentSearchs(List<String> items, SearchProvider searchProvider,
      TextEditingController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.watch_later_outlined,
              color: Colors.grey,
            ),
            title: Text(items[index]),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  searchProvider.removeData(items[index]);
                });
              },
              icon: Icon(Icons.close),
            ),
          );
        },
      ),
    );
  }
}
