import 'package:design/Storage/database.dart';
import 'package:design/LocalPages/addactivity.dart';
import 'package:design/LocalPages/addevent.dart';
import 'package:design/LocalPages/events.dart';
import 'package:design/LocalPages/homepage.dart';
import 'package:design/LocalPages/start.dart';
import 'package:design/Storage/message.dart';
import 'package:design/Storage/sqlite.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:design/values.dart';
import 'package:flutter/services.dart';
import 'LocalPages/about.dart';
import 'package:design/functions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  PushNotificationsManager().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return DynamicTheme(
    //     defaultBrightness: Brightness.light,
    //     data: (brightness) => new ThemeData(
    //           fontFamily: 'Lato',
    //           primaryColor: Color(0xFF04294F),
    //           visualDensity: VisualDensity.adaptivePlatformDensity,
    //           primarySwatch: Colors.indigo,
    //           brightness: brightness,
    //         ),
    //     themedWidgetBuilder: (context, theme) {
    return MaterialApp(
      title: 'IEEE Events',
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: Color(0xFF04294F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //darkTheme: ThemeData(brightness: Brightness.dark),
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
    // });
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget tobereturned = Start();
  List<Event> events = [];
  bool connection;
  Future assign() async {
    await openLocalStorage();
    //connection = await testcon();
    //if (connection) {
    events = await getEventsFromLocal();
    await Future.delayed(Duration(milliseconds: 4000));
    setState(() {
      tobereturned = MyHomePage(events);
    });
    //} else {}
  }

  @override
  void initState() {
    super.initState();
    assign();
  }

  @override
  void dispose() {
    closedb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //if (first) assign();
    return tobereturned;
  }
}
