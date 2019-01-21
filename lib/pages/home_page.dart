import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Hi Arthur,",
                style: TextStyle(color: Colors.black, fontSize: 30),
                textAlign: TextAlign.center,
            ),
            Text("Welcome HomeX", style: TextStyle(fontSize: 10), textAlign: TextAlign.center,),
            // Card(
            //   child: ListTile(
            //     title: Text("Someting here"),
            //   )
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: Card(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.vertical(
            //       top: Radius.circular(8.0), bottom: Radius.circular(8.0)),
            //       child: Image.network("https://brightsign.zendesk.com/hc/user_images/c0tt451u2Q5pwbwMii6n_Q.png",
            //         fit: BoxFit.fitWidth),
            //     )
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Rooms", textAlign: TextAlign.left,),
                  Text("See all", textAlign: TextAlign.right,)
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
              )
            )
          ],
        )));
  }
}
