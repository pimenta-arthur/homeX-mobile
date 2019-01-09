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
  var _isLoading = true;

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text("HomeX"),
            actions: <Widget>[
              new IconButton(icon: new Icon(Icons.add_circle),
              onPressed: () {
                setState(() {
                  
                });
              },),
              new IconButton(icon: new Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _isLoading = false;     
                });
              },)
            ],
          ),
          body: new Center(
            child: _isLoading ? new CircularProgressIndicator() :
              new Text("finished loading..."), 
          ),
        ),
      );
    }
}

class HomeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new CircularProgressIndicator()
    );
  }
}