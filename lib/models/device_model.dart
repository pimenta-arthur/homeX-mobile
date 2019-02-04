import 'package:firebase_database/firebase_database.dart';

class Device {
  String id;
  String name;
  String macAddress;
  String nwkAddress;
  String roomId; 
  String type;

  Device({this.id, this.name, this.macAddress, this.nwkAddress, this.roomId, this.type});

  Device.fromJson(String id, Map<dynamic, dynamic> json) {
    this.id = id;
    this.name = json['name'];
    this.macAddress = json['macAddress'];
    this.nwkAddress = json['nwkAddress'];
    this.roomId = json['roomId'];
    this.type = json['type'].toString();
  }

  Device.fromSnapshot(DataSnapshot snapshot) {
    this.id = snapshot.key;
    this.name = snapshot.value['name'];
    this.macAddress = snapshot.value['macAddress'];
    this.nwkAddress = snapshot.value['nwkAddress'];
    this.roomId = snapshot.value['roomId'];
    this.type = snapshot.value['type'].toString();
  }
}