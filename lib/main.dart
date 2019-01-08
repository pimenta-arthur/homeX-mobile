import 'package:flutter/material.dart';

void main() => runApp(HomeXApp());

class HomeXApp extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return new HomeXState();
    }
}

class HomeXState extends State<HomeXApp> {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("HomeX"),
          ),
          body: new Center(
            child: new CircularProgressIndicator(),
          ),
        ),
      );
    }
}