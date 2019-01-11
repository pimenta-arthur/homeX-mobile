import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homex_mobile/models/room_model.dart';

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
    home: new HomePage(app: app),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> {
  DatabaseReference _roomsRef;
  String _userHub = "0013a2004065d594";
  StreamSubscription<Event> _roomsSubscription;

  static Map _roomsMap = new Map<String, Room>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    _roomsRef = database.reference().child("hubs/${_userHub}/rooms");
    _roomsSubscription = _roomsRef.onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');

      String key = event.snapshot.key;
      Map propsMap = new Map<String, dynamic>.from(event.snapshot.value);

      Room room = new Room.fromJson(key, propsMap);
      _roomsMap[room.key] = room;

    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');  
    });
  }

  @override
  void dispose() {
    super.dispose();
    _roomsSubscription.cancel();
  }

  void onPressedAddButton() {
    print("clicked on add button");
    print(_roomsMap);
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
