import 'package:firebase_database/firebase_database.dart';

class Room {
  String key;
  String name; 
  String color; 
  List<String> devices;

  Room({this.key, this.name, this.color, this.devices});

  Room.fromJson(String key, Map<String, dynamic> json) {
    this.key = key;
    this.name = json['name'];
    this.color = json['color'];
    this.devices = List<String>.from(json['devices'].keys);
  }

  Room.fromSnapshot(DataSnapshot snapshot) {
    this.key = snapshot.key;
    this.name = snapshot.value['name'];
    this.color = snapshot.value['color'];
    this.devices = List<String>.from(snapshot.value['devices'].keys);
  }
}