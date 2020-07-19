import 'package:design/LocalPages/addactivity.dart';
import 'package:design/LocalPages/addevent.dart';
import 'package:design/LocalPages/appload.dart';
import 'package:design/LocalPages/events.dart';
import 'package:design/LocalPages/homepage.dart';
import 'package:design/LocalPages/update.dart';
import 'package:design/functions.dart';
import 'package:design/values.dart';
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
  Future assign() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      tobereturned = MyHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    assign();
    return tobereturned;
  }
}
