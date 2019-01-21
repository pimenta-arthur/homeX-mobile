import 'package:flutter/material.dart';

class DeviceRow extends StatefulWidget {
  final String deviceId;
  DeviceRow({this.deviceId});

  _DeviceRowState createState() => _DeviceRowState();
}

class _DeviceRowState extends State<DeviceRow> {
  bool _value = true;

  _onValueChanged(bool value) => setState(() {
    _value = value;
    print("Value changed: $value");
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.devices),
      title: Text(widget.deviceId),
      trailing: Switch(
          value: _value, 
          onChanged: _onValueChanged,
          activeColor: Colors.blue,
        ),
    );
  }
}