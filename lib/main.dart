import 'package:design/addactivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'addevent.dart';
import 'events.dart';
import 'functions.dart';
import 'values.dart';

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
      home: MyHomePage(),
      routes: {
        'add': (context) => AddEvent(),
        'event': (context) => Events(),
        'addact': (context) => AddActivity(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 230,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(w(37, context)),
                      bottomRight: Radius.circular(w(37, context))),
                  color: color[0],
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 9),
                    Expanded(
                        flex: 9,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 20,
                              child: SizedBox(),
                            ),
                            Expanded(
                              child: Builder(
                                builder: (BuildContext context) {
                                  return IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                      size: w(30, context),
                                    ),
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                  );
                                  //Scaffold.of(context).openDrawer();
                                },
                              ),
                              flex: 40,
                            ),
                            Expanded(
                              child: SizedBox(),
                              flex: 192,
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                  size: w(25, context),
                                ),
                                onPressed: () {},
                              ),
                              flex: 21,
                            ),
                            Expanded(
                              child: SizedBox(),
                              flex: 19,
                            ),
                            Expanded(
                              child: CircleAvatar(
                                radius: w(20, context),
                              ),
                              flex: 60,
                            ),
                            Expanded(
                              child: SizedBox(),
                              flex: 30,
                            )
                          ],
                        )),
                    Expanded(
                      flex: 8,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 9,
                        child: Row(
                          children: <Widget>[
                            Expanded(child: SizedBox(), flex: 31),
                            Expanded(
                                flex: 219,
                                child: Text(
                                  "Involve Explore Engage\nExecute",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: h(19, context)),
                                )),
                            Expanded(child: SizedBox(), flex: 30),
                            Expanded(
                                flex: 46,
                                child: Container(
                                  height: h(46, context),
                                  child: FlatButton(
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      size: h(20, context),
                                      color: color[0],
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'add');
                                    },
                                    shape: CircleBorder(
                                        side: BorderSide(color: Colors.white)),
                                  ),
                                )),
                            Expanded(flex: 50, child: SizedBox())
                          ],
                        )),
                    Expanded(child: SizedBox(), flex: 8)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 592,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 17),
                    Expanded(
                        flex: 38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              child: Text('All Events'),
                              onPressed: () {},
                              color: Color(0xFFFFD8CC),
                            ),
                            FlatButton(
                              child: Text('Upcoming'),
                              onPressed: () {},
                              color: Color(0xFFFFF0CC),
                            ),
                            FlatButton(
                              child: Text('Ongoing'),
                              onPressed: () {},
                              color: Color(0xFFCCEFF9),
                            ),
                          ],
                        )),
                    Expanded(
                      child: SizedBox(),
                      flex: 42,
                    ),
                    Expanded(
                        flex: 25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            DropdownButton(
                                value: 0,
                                items: [
                                  DropdownMenuItem(
                                    child: Text('Upcoming Date'),
                                    value: 0,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Vere etho date"),
                                    value: 1,
                                  )
                                ],
                                onChanged: (value) {}),
                            IconButton(
                              icon: Icon(Icons.grid_on),
                              onPressed: () {},
                            ),
                          ],
                        )),
                    Expanded(
                      child: SizedBox(),
                      flex: 39,
                    ),
                    Expanded(
                        flex: 436,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w(31, context),
                            vertical: 0,
                          ),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'event');
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(bottom: h(15, context)),
                                  height: h(58, context),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            w(13, context))),
                                    color: Colors.blue,
                                    child: Text('Hy'),
                                  ),
                                ),
                              );
                            },
                            itemCount: 17,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(left: w(34, context), right: w(34, context)),
          color: color[0],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SizedBox(),
                flex: 53,
              ),
              Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    child: Icon(Icons.arrow_back, size: h(38, context)),
                    color: color[0],
                  ),
                  flex: 38),
              Expanded(
                flex: 30,
                child: SizedBox(),
              ),
              Expanded(
                flex: 38,
                child: ListTile(
                  title: Text(
                    'About Us',
                    style: TextStyle(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
                ),
              ),
              Expanded(
                flex: 38,
                child: ListTile(
                  title: Text(
                    'IEEE Mace Web',
                    style: TextStyle(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
                ),
              ),
              Expanded(
                flex: 38,
                child: ListTile(
                  title: Text(
                    'Broadcast Letter',
                    style: TextStyle(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
                ),
              ),
              Expanded(
                flex: 60,
                child: SizedBox(),
              ),
              Expanded(
                flex: 50,
                child: Container(
                  margin: EdgeInsets.only(left: 9),
                  child: FlatButton(
                    color: Colors.white,
                    child: Text('Logout', style: TextStyle(color: color[0])),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                flex: 354,
                child: SizedBox(),
              ),
              Expanded(
                flex: 19,
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Created by IEEE Mace Team',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 101,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
