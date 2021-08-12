import 'package:flutter/material.dart';
// packages
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';// for future dark mode
import 'package:line_awesome_flutter/line_awesome_flutter.dart'; // for future dark mode
//flutter inbuilt
import 'package:flutter/rendering.dart';
//custom made
import 'filters.dart';
import 'drawer.dart';
import '../functions.dart';
import '../values.dart';
import '../Widgets/RoundButton.dart';
import '../Storage/sqlite.dart';
import 'homepageitems.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage(this.events);
  final List<Event> events;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loged = false,
      grid = true,
      view = false,
      filter = false,
      sort = false,
      all = true,
      upcoming = false,
      ongoing = false,
      open = false,
      maceonly = true;
  int dropvalue = 0;
  FirebaseUser user;
  Future checkuser() async {
    loged = await logincheck();
    if (loged) {
      user = await FirebaseAuth.instance.currentUser();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkuser();
  }

  update(bool login) {
    setState(() {
      loged = login;
    });
    checkuser();
  }

  @override
  Widget build(BuildContext context) {
    // checkacti("Single Day Webinars");
    return Scaffold(
      backgroundColor: color[2],
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 230,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      color: color[0],
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(w(37, context)),
                      bottomRight: Radius.circular(w(37, context))),
                  color: Color(0xFF04294F),
                ),
                child: Column(
                  children: <Widget>[
                    const Expanded(child: SizedBox(), flex: 9),
                    Expanded(
                        flex: 9,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
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
                                },
                              ),
                              flex: 40,
                            ),
                            const Expanded(
                              child: SizedBox(),
                              flex: 232,
                            ),
                            if (loged)
                              Expanded(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    user == null
                                        ? 'A'
                                        : user.email[0].toUpperCase(),
                                    style: TextStyle(color: color[0]),
                                  ),
                                ),
                                // : Container(
                                //     height: w(60, context),
                                //     width: w(60, context),
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //           image: AssetImage(
                                //               'assets/profile.png'),
                                //           fit: BoxFit.fill),
                                //       shape: BoxShape.circle,
                                //       //  borderRadius: BorderRadius.circular(
                                //       //     w(20, context)),
                                //     ),
                                //   ),
                                flex: 40,
                              ),
                            Expanded(
                              child: SizedBox(),
                              flex: loged ? 30 : 70,
                            )
                          ],
                        )),
                    const Expanded(
                      flex: 8,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 11,
                        child: Row(
                          children: <Widget>[
                            const Expanded(child: SizedBox(), flex: 31),
                            Expanded(
                                flex: 239,
                                child: Text(
                                  "Involve Explore Engage\nExecute",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: h(25, context)),
                                )),
                            const Expanded(child: SizedBox(), flex: 30),
                            Expanded(
                              flex: 46,
                              // child: Container(
                              //   height: h(46, context),
                              child: loged
                                  ? RoundButton(
                                      color: Colors.white,
                                      onpressed: () async {
                                        await Navigator.pushNamed(
                                                context, 'add')
                                            .whenComplete(() => itemState
                                                .currentState
                                                .assign());
                                      },
                                      icon: Icon(Icons.add),
                                      size: w(50, context),
                                    )
                                  : Container(),
                            ),
                            const Expanded(flex: 30, child: SizedBox())
                          ],
                        )),
                    const Expanded(child: SizedBox(), flex: 6)
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 592,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: w(10, context)),

                    Row(
                      children: <Widget>[
                        Spacer(),
                        Container(
                          child: Row(
                            children: <Widget>[
                              RoundButton(
                                elevation: 0,
                                size: w(40, context),
                                color: view ? color[0] : Colors.transparent,
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: view ? color[1] : color[0],
                                ),
                                onpressed: () {
                                  setState(() {
                                    view = !view;
                                    filter = false;
                                    sort = false;
                                  });
                                },
                              ),
                              RoundButton(
                                elevation: 0,
                                size: w(40, context),
                                color: filter ? color[0] : Colors.transparent,
                                icon: Icon(
                                  LineAwesomeIcons.filter,
                                  color: filter ? color[1] : color[0],
                                ),
                                onpressed: () {
                                  setState(() {
                                    filter = !filter;
                                    view = false;
                                    sort = false;
                                  });
                                },
                              ),
                              RoundButton(
                                elevation: 0,
                                size: w(40, context),
                                color: sort ? color[0] : Colors.transparent,
                                icon: Icon(
                                  Icons.sort_by_alpha,
                                  //size: w(20, context),
                                  color: sort ? color[1] : color[0],
                                ),
                                onpressed: () {
                                  setState(() {
                                    sort = !sort;
                                    filter = false;
                                    view = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: w(30, context),
                        )
                      ],
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 300),
                      crossFadeState: filter
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Column(
                        children: <Widget>[
                          Filters(
                              all: all,
                              upcoming: upcoming,
                              ongoing: ongoing,
                              onall: () {
                                setState(() {
                                  upcoming = false;
                                  ongoing = false;
                                  all = true;
                                });
                                itemState.currentState.filter(0);
                              },
                              onupcoming: () {
                                setState(() {
                                  upcoming = true;
                                  ongoing = false;
                                  all = false;
                                });
                                itemState.currentState.filter(1);
                              },
                              onongoing: () {
                                setState(() {
                                  upcoming = false;
                                  ongoing = true;
                                  all = false;
                                });
                                itemState.currentState.filter(2);
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'All Organisers',
                                  style: TextStyle(
                                      fontSize: !maceonly ? 17 : 15,
                                      color: !maceonly
                                          ? Color(0xFF04294F)
                                          : Colors.grey,
                                      fontWeight: !maceonly
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    maceonly = false;
                                  });
                                  itemState.currentState.filter(4);
                                },
                                color: Color(0xFFFFF0CC)
                                    .withOpacity(!maceonly ? 1 : 0.5),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Mace Only',
                                  style: TextStyle(
                                      fontSize: maceonly ? 17 : 15,
                                      color: maceonly
                                          ? Color(0xFF04294F)
                                          : Colors.grey,
                                      fontWeight: maceonly
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    maceonly = true;
                                  });
                                  itemState.currentState.filter(5);
                                },
                                color: Color(0xFFFFF0CC)
                                    .withOpacity(maceonly ? 1 : 0.5),
                              ),
                            ],
                          ),
                        ],
                      ),
                      secondChild: Container(),
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 300),
                      crossFadeState: view
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      firstChild: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'List View',
                              style: TextStyle(
                                  fontSize: !grid ? 17 : 15,
                                  color:
                                      !grid ? Color(0xFF04294F) : Colors.grey,
                                  fontWeight: !grid
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                grid = false;
                              });
                            },
                            color:
                                Color(0xFFFFD8CC).withOpacity(!grid ? 1 : 0.5),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Grid View',
                              style: TextStyle(
                                  fontSize: grid ? 17 : 15,
                                  color: grid ? Color(0xFF04294F) : Colors.grey,
                                  fontWeight: grid
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                grid = true;
                              });
                            },
                            color:
                                Color(0xFFFFF0CC).withOpacity(grid ? 1 : 0.5),
                          ),
                        ],
                      ),
                      secondChild: Container(),
                    ),
                    AnimatedCrossFade(
                      duration: Duration(milliseconds: 300),
                      crossFadeState: sort
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      // color: color[0],
                      firstChild: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'By Name',
                              style: TextStyle(
                                  fontSize: dropvalue == 1 ? 17 : 15,
                                  color: dropvalue == 1
                                      ? Color(0xFF04294F)
                                      : Colors.grey,
                                  fontWeight: dropvalue == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                dropvalue = 1;
                              });
                              itemState.currentState.sort(1);
                            },
                            color: Color(0xFFFFD8CC)
                                .withOpacity(dropvalue == 1 ? 1 : 0.5),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'By Last Updated',
                              style: TextStyle(
                                  fontSize: dropvalue == 0 ? 17 : 15,
                                  color: dropvalue == 0
                                      ? Color(0xFF04294F)
                                      : Colors.grey,
                                  fontWeight: dropvalue == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                dropvalue = 0;
                              });
                              itemState.currentState.sort(0);
                            },
                            color: Color(0xFFFFF0CC)
                                .withOpacity(dropvalue == 0 ? 1 : 0.5),
                          ),
                        ],
                      ),
                      secondChild: Container(),
                    ),
                    // Expanded(
                    //   child: SizedBox(),
                    //   flex: 10,
                    // ),
                    Expanded(
                      //height: h(399, context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: h(10, context),
                          horizontal: w(20, context),
                        ),
                        child: Items(widget.events, dropvalue, grid,
                            all ? 0 : upcoming ? 1 : 2, maceonly,
                            key: itemState),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerObjects(loged, update),
    );
  }
}
