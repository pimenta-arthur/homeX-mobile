import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homex_mobile/models/room_model.dart';
import 'package:homex_mobile/pages/device_row.dart';

class DetailPage extends StatefulWidget {
  final Room room;
  DetailPage({this.room});

  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              color: Colors.blue,
              height: 150,
              width: screen.width,
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BackButton(color: Colors.white,)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.room.name,
                          style: TextStyle(color: Colors.white, fontSize: 30)),
                          Text("${widget.room.devices.length.toString()} devices",
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 140),
            child: ListView(
              children: widget.room.devices.map((deviceId) => DeviceRow(deviceId: deviceId,)).toList(),
            ),
          )
        ],
      ),
    );
  }
}
