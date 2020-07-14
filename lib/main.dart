import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'addevent.dart';

void main() {
  runApp(MyApp());
  // SystemChrome.setEnabledSystemUIOverlays([]);
}

List<Color> color = [Color(0xFF04294F)];

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
      routes: {'add': (context) => AddEvent()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double h(double no) {
    return no * (MediaQuery.of(context).size.height) / 812;
  }

  double w(double no) {
    return no * (MediaQuery.of(context).size.width) / 375;
  }

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
                      bottomLeft: Radius.circular(w(37)),
                      bottomRight: Radius.circular(w(37))),
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
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: w(30),
                                ),
                                onPressed: () {},
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
                                  size: w(25),
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
                                radius: w(20),
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
                                      fontSize: h(19)),
                                )),
                            Expanded(child: SizedBox(), flex: 30),
                            Expanded(
                                flex: 46,
                                child: Container(
                                  height: h(46),
                                  child: FlatButton(
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      size: h(20),
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
                            horizontal: w(31),
                            vertical: 0,
                          ),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: h(15)),
                                height: h(58),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(w(13))),
                                  color: Colors.blue,
                                  child: Text('Hy'),
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
    );
  }
}
