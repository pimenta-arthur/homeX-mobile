import 'package:flutter/material.dart';

class DevicesPage extends StatefulWidget {
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  var _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
        child: Center(
          child: _isLoading ? CircularProgressIndicator() : CircularProgressIndicator(),
        )
    );
  }
}