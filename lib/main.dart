import 'package:covid19_app/Screen/DetailScreen.dart';
import 'package:covid19_app/Screen/regionalScreen.dart';
import 'package:flutter/material.dart';

import './Screen/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // fontFamily: 'Anton',
          primaryColor: Colors.deepOrangeAccent[100]),
      home: HomePage(),
      routes: {
        '/regionalScreen': (context) => RegionalDataScreen(),
        '/DetailScreen': (context) => DetailScreen()
      },
    );
  }
}
