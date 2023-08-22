import 'package:flutter/material.dart';

class GetSingleProduct extends StatefulWidget {
  const GetSingleProduct({super.key, required this.name, required this.desc});
  final int name;
  final String desc;

  @override
  State<GetSingleProduct> createState() => _GetSingleProductState();
}

class _GetSingleProductState extends State<GetSingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(widget.desc),
    ));
  }
}
