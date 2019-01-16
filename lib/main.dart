import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homex_mobile/models/room_model.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
    // theme: ThemeData(
    //   primaryColor: Colors.black,
    //   textTheme: TextTheme(
    //     body1: TextStyle(color: Colors.black)
    //   )
    // ),
    home: App(app: app),
  ));
}

class App extends StatefulWidget {
  App({this.app});
  final FirebaseApp app;
  _AppState createState() => _AppState(app: app);
}

class _AppState extends State<App> {
  _AppState({this.app});
  final FirebaseApp app;

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();

    _widgetOptions = [
      Text('Index 0: Home'),
      RoomsPage(app: app),
      Text('Index 1: Devices'),
      Text('Index 3: Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(OMIcons.home, color: Colors.black),
                title: Text('Home', style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.dashboard, color: Colors.black),
                title: Text('Rooms', style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: Icon(OMIcons.settingsInputAntenna, color: Colors.black),
                title: Text('Devices', style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: Icon(
                  OMIcons.accountCircle,
                  color: Colors.black,
                ),
                title: Text('Profile', style: TextStyle(color: Colors.black)))
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

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
    // _roomsSubscription.cancel();
  }

  void onPressedAddButton() {
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
