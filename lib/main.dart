import 'dart:async';
import 'dart:convert';
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
  var _isLoading = true;
  DatabaseReference _roomsRef;
  String _userHub = "0013a2004065d594";
  StreamSubscription<Event> _roomsSubscription;
  Map _roomsMap = new Map<String, Room>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _roomsRef = database.reference().child("hubs/${_userHub}/rooms");

    _roomsRef.once().then(onLoadRoomsOnce);

    _roomsRef.onChildAdded.listen(onRoomAdded, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });

    _roomsRef.onChildRemoved.listen(onRoomRemoved, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  onLoadRoomsOnce(DataSnapshot snapshot) {
    print('Loading rooms at the first time: ${snapshot.value}');

    final map = new Map.from(snapshot.value);

    map.forEach((k, v) {
      Room room = new Room.fromJson(k, v);
      _roomsMap[room.id] = room;
    });

    setState(() {
      print("Finished loading rooms");
      _isLoading = false;
    });
  }

  onRoomAdded(Event event) {
    if (!_isLoading) {
      print('Child added: ${event.snapshot.value}');

      Room room = new Room.fromSnapshot(event.snapshot);
      setState(() {
        _roomsMap[room.id] = room;
      });
    }
  }

  onRoomRemoved(Event event) {
    if (!_isLoading) {
      print('Child removed: ${event.snapshot.value}');

      if (_roomsMap.containsKey(event.snapshot.key)) {
        setState(() {
          _roomsMap.remove(event.snapshot.key);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _roomsSubscription.cancel();
  }

  void onPressedAddButton() {
    print("clicked on add button");
    print(_roomsMap.length);
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
              child: _isLoading
                  ? new CircularProgressIndicator()
                  : new ListView.builder(
                      itemCount: _roomsMap.length,
                      itemBuilder: (context, i) {
                        return new Text("Row $i");
                      },
                    )),
        ));
  }
}
