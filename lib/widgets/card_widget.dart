import 'package:flutter/material.dart';
import 'package:flutter_fedora/methods/methods.dart';

class CardWidget extends StatelessWidget {
  final String imgPath;
  final String title;
  final String subtitle;
  final int price;
  const CardWidget(
      {super.key,
      required this.imgPath,
      required this.title,
      required this.subtitle,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imgPath,
            fit: BoxFit.cover,
            height: 150,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          capitalize(subtitle),
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        Text(
          price.toString() + '\$',
          style: TextStyle(fontSize: 20, color: Colors.green[800]),
        ),
      ],
    );
  }
}
