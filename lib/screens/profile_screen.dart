// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_fedora/constants/constant.dart';
import 'package:flutter_fedora/providers/user_provider.dart';
import 'package:flutter_fedora/screens/about_screen.dart';
import 'package:flutter_fedora/screens/favorite_screen.dart';
import 'package:flutter_fedora/screens/location_screen.dart';
import 'package:flutter_fedora/screens/my_order_screen.dart';
import 'package:provider/provider.dart';

import '../providers/theme_manager_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController imgPathController = TextEditingController();

  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final ThemeManager themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70,
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
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
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
                                      userProvider.imgPath =
                                          imgPathController.text;
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Done',
                                        style: TextStyle(
                                            color: Colors.green[800])),
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
                          )),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userProvider.firstName} ${userProvider.lastName}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.email,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()));
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.green[800]),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                )),
                            child: Text('Edit Profile',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(Icons.favorite_border),
                        title: Text('Favorite'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavoriteScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag_outlined),
                        title: Text('My Orders'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrderScreen()));
                        },
                      ),
                      buildDivider(),
                      ListTile(
                        leading: Icon(Icons.brightness_4_outlined),
                        title: Text('App Theme'),
                        trailing: Switch(
                          value: themeManager.isChange,
                          onChanged: (value) {
                            setState(() {
                              themeManager.isChange = value;
                              themeManager.setTheme(
                                  !value ? AppTheme.light : AppTheme.dark);
                            });
                          },
                        ),
                        // trailing: ToggleButtons(
                        //   isSelected: _selectedMode,
                        //   borderRadius: BorderRadius.circular(50),
                        //   constraints:
                        //       BoxConstraints(minWidth: 45, minHeight: 35),
                        //   onPressed: (index) {
                        //     setState(() {
                        //       for (var i = 0; i < _selectedMode.length; i++) {
                        //         _selectedMode[i] = i == index;
                        //       }
                        //     });
                        //   },
                        //   children: [
                        //     Icon(Icons.light_mode_outlined),
                        //     Icon(Icons.dark_mode_outlined),
                        //   ],
                        // )),
                      ),
                      ListTile(
                        leading: Icon(Icons.language_outlined),
                        title: Text('Language'),
                        trailing: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down_outlined),
                          underline: Container(
                              decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.green[800]!,
                              ),
                            ),
                          )),
                          value: _selectedLanguage,
                          items: [
                            DropdownMenuItem(
                              value: 'English',
                              child: Text('EN'),
                            ),
                            DropdownMenuItem(
                              value: 'Azərbaycanca',
                              child: Text('AZ'),
                            ),
                            DropdownMenuItem(
                              value: 'Türkçe',
                              child: Text('TR'),
                            ),
                          ],
                          onChanged: (item) {
                            setState(() {
                              _selectedLanguage = item!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                          leading: Icon(Icons.location_on_outlined),
                          title: Text('Location'),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocationScreen()));
                          }),
                      buildDivider(),
                      ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('About'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutScreen()));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        title: Text('Log Out'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('App version 1.0.0',
                              style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
