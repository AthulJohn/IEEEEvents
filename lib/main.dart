import 'package:design/LocalPages/addactivity.dart';
import 'package:design/LocalPages/addevent.dart';
import 'package:design/LocalPages/events.dart';
import 'package:design/LocalPages/homepage.dart';
import 'package:design/LocalPages/start.dart';
import 'package:flutter/services.dart';
import 'LocalPages/about.dart';
import 'package:design/functions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IEEE Events',
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: Color(0xFF04294F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        'add': (context) => AddEvent(),
        'event': (context) => Events(),
        'addact': (context) => AddActivity(),
        'about': (context) => About(),
        //'gallery':(context) => Gallery(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget tobereturned = Start();
  bool first = true;
  bool connection;
  Future assign() async {
    connection = await testcon();
    if (connection) {
      first = false;
      await Future.delayed(Duration(milliseconds: 4000));
      setState(() {
        tobereturned = MyHomePage();
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    if (first) assign();
    return tobereturned;
  }
}
