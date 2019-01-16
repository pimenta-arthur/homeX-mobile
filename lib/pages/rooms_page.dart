import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homex_mobile/models/room_model.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({this.app});
  final FirebaseApp app;

  @override
  _RoomsPageState createState() => new _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
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

    _roomsRef.once().then(_onLoadRoomsOnce);

    _roomsRef.onChildAdded.listen(_onRoomAdded, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });

    _roomsRef.onChildRemoved.listen(_onRoomRemoved, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  _onLoadRoomsOnce(DataSnapshot snapshot) {
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

  _onRoomAdded(Event event) {
    if (!_isLoading) {
      print('Child added: ${event.snapshot.value}');

      Room room = new Room.fromSnapshot(event.snapshot);
      setState(() {
        _roomsMap[room.id] = room;
      });
    }
  }

  _onRoomRemoved(Event event) {
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
    // _roomsSubscription.cancel();
  }

  void _onPressedAddButton() {
    print("clicked on add button");
    print(_roomsMap.length);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFFFFFFFF),
          title: new Text("HomeX"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.add_circle),
              onPressed: _onPressedAddButton,
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
                        var room = _roomsMap.values.toList()[i];
                        var roomDevices = room.devices;
                        return new Card(
                          child: new Column(
                            children: <Widget>[
                              new ListTile(
                                title: new Text(room.name.toString()),
                                subtitle:
                                    new Text("${room.devices.length} devices"),
                                trailing: Icon(Icons.more_vert),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
        ));
  }
}
