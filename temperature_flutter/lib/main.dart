import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Temperature'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String temp = "Getting";
  var url = 'http://192.168.31.102:80/';
  var response;
  Future<void> _getTemp() async {
    response = await http.get(url);
    if (response.statusCode == 200) {
      temp = response.body;
      temp += " ° C";
    } else {
      temp = "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.teal),
            ),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              elevation: 5,
              shape: CircleBorder(),
              color: Colors.black45,
              shadowColor: Colors.black26,
              child: InkResponse(
                splashColor: Colors.blue,
                onTap: () {
                  setState(() {
                    _getTemp();
                  });
                },
                radius: 150,
                child: Container(
                  width: 300,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temp',
                        style: TextStyle(fontSize: 28, color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
