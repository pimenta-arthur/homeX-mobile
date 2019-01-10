import 'package:flutter/material.dart';

void main() => runApp(HomeXApp());

class HomeXApp extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: new Home(),
      );
    }
}

class Home extends StatefulWidget {
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
        )
      );
    }
}