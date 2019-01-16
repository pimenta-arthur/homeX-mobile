import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class App extends StatefulWidget {
  App({this.app});
  final FirebaseApp app;
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // TabController controller;
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = [
    Text('Index 0: Home'),
    Text('Index 1: Business'),
    Text('Index 2: School'),
    Text('Index 3: bla'),
  ];

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
                icon: Icon(OMIcons.accountCircle, color: Colors.black, ),
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
