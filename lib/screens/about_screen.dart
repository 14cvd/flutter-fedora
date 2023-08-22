// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final List<List<String>> teamMembers = [
    ['Ragsana', 'assets/image/ragsana.png'],
    ['Cavid', 'assets/image/cavid.png'],
    ['Murad', 'assets/image/murad.jpeg'],
    ['Polad', 'assets/image/polad.jpg'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              'Our Team Members',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Wrap(
              runSpacing: 10,
              spacing: 10,
              children: teamMembers.map((member) {
                return SizedBox(
                  width: 180,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.green[800],
                            backgroundImage: AssetImage(member[1]),
                          ),
                        ),
                        Text(
                          member[0],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[800],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Our Mission',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)),
            Text(
                'Our mission is to provide the best service to our customers. \nWe are always ready to help you.',
                style: TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }
}
