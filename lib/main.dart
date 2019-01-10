import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'homex-db',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:723851736195:android:282ded12e0a45d06',
            gcmSenderID: '723851736195',
            databaseURL: 'https://homex-6e369.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:723851736195:android:282ded12e0a45d06',
            apiKey: 'AIzaSyAW0nGt3ypZGVIC3p-A0uk102KTgWNUE-g',
            databaseURL: 'https://homex-6e369.firebaseio.com',
          ),
  );
  runApp(MaterialApp(
    title: 'HomeX App',
    home: Home(app: app),
  ));
}

class Home extends StatefulWidget {
  Home({this.app});
  final FirebaseApp app;

  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  void onPressedAddButton() {
    print("clicked on add button");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("HomeX"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.add_circle),
              onPressed: onPressedAddButton,
            )
          ],
        ),
        body: new Container(
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        ));
  }
}
