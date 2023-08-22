// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController imgPathController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final TextEditingController firstNameController =
        TextEditingController(text: userProvider.firstName);
    final TextEditingController lastNameController =
        TextEditingController(text: userProvider.lastName);
    final TextEditingController emailController =
        TextEditingController(text: userProvider.email);
    final TextEditingController imgPathController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              userProvider.firstName = firstNameController.text;
              userProvider.lastName = lastNameController.text;
              userProvider.email = emailController.text;
              Navigator.of(context).pop();
              UserProvider().addData();
            },
            icon: Icon(Icons.check, color: Colors.green[800]),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(userProvider.imgPath),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        AlertDialog alertDialog = AlertDialog(
                          title: Text('Enter image URL'),
                          content: TextField(
                            controller: imgPathController,
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel',
                                  style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () {
                                userProvider.imgPath = imgPathController.text;
                                Navigator.of(context).pop();
                              },
                              child: Text('Done',
                                  style: TextStyle(color: Colors.green[800])),
                            ),
                          ],
                        );
                        showDialog(
                            context: context,
                            builder: (context) => alertDialog);
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Information',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your first name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.green[800]!, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your last name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.green[800]!, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.green[800]!, width: 2),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
