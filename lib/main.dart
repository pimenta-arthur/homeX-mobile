import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homex_mobile/pages/home_page.dart';
import 'package:homex_mobile/pages/rooms_page.dart';
import 'package:homex_mobile/pages/devices_page.dart';
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
  runApp(App(app: app));
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
      // não precisa passar a variável app no construtor para funcionar a conexão com o firebase
      HomePage(),
      RoomsPage(app: app),
      DevicesPage(app: app),
      Text('Index 3: Profile'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeX',
      home: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          // body: Center(
          //   child: _widgetOptions.elementAt(_selectedIndex),
          // ),
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
                  title:
                      Text('Devices', style: TextStyle(color: Colors.black))),
              BottomNavigationBarItem(
                  icon: Icon(
                    OMIcons.accountCircle,
                    color: Colors.black,
                  ),
                  title: Text('Profile', style: TextStyle(color: Colors.black)))
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          )),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
