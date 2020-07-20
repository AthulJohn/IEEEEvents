import 'package:design/LocalPages/addactivity.dart';
import 'package:design/LocalPages/addevent.dart';
import 'package:design/LocalPages/appload.dart';
import 'package:design/LocalPages/events.dart';
import 'package:design/LocalPages/homepage.dart';
import 'LocalPages/about.dart';
import 'package:design/functions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: Color(0xFF04294F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        'add': (context) => AddEvent(),
        'event': (context) => Events(),
        'addact': (context) => AddActivity(),
        'about': (context) => About(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget tobereturned = MainLoad();
  bool first = true;
  bool connection;
  Future assign() async {
    connection = await testcon();
    if (connection) {
      first = false;
      await Future.delayed(Duration(milliseconds: 5500));
      setState(() {
        tobereturned = MyHomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (first) assign();
    return tobereturned;
  }
}
