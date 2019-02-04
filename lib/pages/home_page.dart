import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Hi Arthur,",
              style: TextStyle(color: Colors.black, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Text(
              "Welcome HomeX",
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                // color: Colors.lightBlue,
                height: 120,
                width: screen.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.lightBlue),
                child: Text('Colocar algo aqui'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Rooms",
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "See all",
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Living Room"),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Badroom"),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("Kitchen"),
                      ),
                    ),
                  ],
                ))
          ],
        )));
  }
}
