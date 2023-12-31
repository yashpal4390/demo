// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, iterable_contains_unrelated_type, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:demo/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';

import 'const.dart';
import 'create_user.dart';
import 'splash_screen.dart';
import 'util.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        splash: (context) => SplashScreen(),
        home_page: (context) => UserListScreen(),
        create: (context) => CreateUser(),
        fav_page: (context) => FavoriteUser(),
      },
    ));

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchName = 'Bob';
  void _deleteUser(int index) {
    setState(() {
      userList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        shadowColor: Colors.white,
        leading: SizedBox(height: 2),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, fav_page);
              },
              icon: Icon(Icons.favorite_border)),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Search User'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: searchController,
                            decoration:
                                InputDecoration(labelText: 'Enter User Name'),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: InkWell(
                            child: Text('Search'),
                            onTap: () {
                              searchName=searchController.text;
                              if (userList.contains(searchName)){
                                print("Get");
                              } else {
                                print("Not Get");
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.search_sharp)),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.black,
                    backgroundImage: user.xFile != null
                        ? FileImage(
                            File(user.xFile?.path ?? ""),
                          )
                        : null,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Name :~   ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.fname,
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(width: 3),
                      Text(user.lname,
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 4),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Gender :~   ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.gender, style: fonts[index]),
                      SizedBox(width: 3),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text("E-Mail :~     ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.email, style: fonts[index]),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text("Mo. No :~    ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.phone, style: fonts[index]),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text("City :~           ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(user.address, style: fonts[index]),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text("Rating :~     ",
                          style: fonts[index]
                              .copyWith(fontWeight: FontWeight.bold)),
                      RatingBarIndicator(
                        rating: double.parse(user.rat as String),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 17.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 180),
                      InkWell(
                          onTap: () {
                            // ignore: dead_null_aware_expression
                            Share.share(user.fname ?? "");
                          },
                          child: Icon(Icons.share)),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if(fav)
                          favuserList.add(userList[index]);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            content: Text("Added to the Favorite"),
                            duration: Duration(seconds: 6),
                            backgroundColor: Colors.red,
                          ));
                        },
                        child: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, size: 40),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Add User'),
                        content: const Text(
                            "Are You Sure Want To Delete This User?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text("No")),
                          TextButton(
                            onPressed: () {
                              _deleteUser(index);
                              Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                  // _deleteUser(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.pushNamed(context, create);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
