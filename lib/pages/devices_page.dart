import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:homex_mobile/models/device_model.dart';
import 'package:homex_mobile/pages/device_row.dart';

class DevicesPage extends StatefulWidget {
  DevicesPage({this.app});
  final FirebaseApp app;

  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  var _isLoading = true;
  DatabaseReference _devicesRef;
  String _userHub = "0013a2004065d594";
  Map _devicesMap = new Map<String, Device>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _devicesRef = database.reference().child("hubs/${_userHub}/devices");

    _devicesRef.once().then(_onLoadDevicesOnce);

    // _devicesMap.onChildAdded.listen(_onRoomAdded, onError: (Object o) {
    //   final DatabaseError error = o;
    //   print('Error: ${error.code} ${error.message}');
    // });

    // _devicesMap.onChildRemoved.listen(_onRoomRemoved, onError: (Object o) {
    //   final DatabaseError error = o;
    //   print('Error: ${error.code} ${error.message}');
    // });
  }

  _onLoadDevicesOnce(DataSnapshot snapshot) {
    print('Loading rooms at the first time: ${snapshot.value}');

    final map = new Map.from(snapshot.value);

    map.forEach((k, v) {
      Device device = new Device.fromJson(k, v);
      _devicesMap[device.id] = device;
    });

    setState(() {
      print("Finished loading rooms");
      _isLoading = false;
    });
  }

  // _onRoomAdded(Event event) {
  //   if (!_isLoading) {
  //     print('Child added: ${event.snapshot.value}');

  //     Room room = new Room.fromSnapshot(event.snapshot);
  //     setState(() {
  //       _roomsMap[room.id] = room;
  //     });
  //   }
  // }

  // _onRoomRemoved(Event event) {
  //   if (!_isLoading) {
  //     print('Child removed: ${event.snapshot.value}');

  //     if (_roomsMap.containsKey(event.snapshot.key)) {
  //       setState(() {
  //         _roomsMap.remove(event.snapshot.key);
  //       });
  //     }
  //   }
  // }

  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
        child: Center(
          child: _isLoading 
          ? CircularProgressIndicator() 
          : SafeArea(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Text('Devices',
                      style: TextStyle(color: Colors.black, fontSize: 30)),
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 110),
                  child: ListView(
                    children: _devicesMap.values.map((device) => DeviceRow(deviceId: device.id,)).toList(),
                  ),
                )
              ],
            ),
          )
          // : SafeArea(
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       Text("Rooms",
          //                 style: TextStyle(color: Colors.black, fontSize: 30)),
          //       ListView(
          //         children: _devicesMap.values.map((device) => DeviceRow(deviceId: device.id,)).toList(),
          //       )
          //     ],
          //   ),
          // ),
        )
    );
  }
}