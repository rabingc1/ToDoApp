import 'package:flutter/material.dart';

import 'Screens/homepage.dart';


void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'ToDo CURD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


