import 'package:flutter/material.dart';
// packages
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';// for future dark mode
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart'; // for future dark mode
//flutter inbuilt
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
//custom made
import '../functions.dart';
import '../values.dart';
import 'login.dart';
import '../FIREBASE/database.dart';
import '../Widgets/RoundButton.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loged = false,
      grid = false,
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

  List<Event> events = [];
  @override
  Widget build(BuildContext context) {
    checkuser();
    return StreamProvider<List<Event>>.value(
        value: CloudService().events,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                                    },
                                  ),
                                  flex: 40,
                                ),
                                Expanded(
                                  child: SizedBox(),
                                  flex: 192,
                                ),
                                Expanded(
                                  child: SizedBox(),
                                  flex: 21,
                                ),
                                Expanded(
                                  child: SizedBox(),
                                  flex: 19,
                                ),
                                Expanded(
                                  child: loged
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            user.email[0].toUpperCase(),
                                            style: TextStyle(color: color[0]),
                                          ),
                                        )
                                      : Container(
                                          height: w(60, context),
                                          width: w(60, context),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/profile.png'),
                                                fit: BoxFit.fill),
                                            shape: BoxShape.circle,
                                            //  borderRadius: BorderRadius.circular(
                                            //     w(20, context)),
                                          ),
                                        ),
                                  flex: 40,
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
                            flex: 11,
                            child: Row(
                              children: <Widget>[
                                Expanded(child: SizedBox(), flex: 31),
                                Expanded(
                                    flex: 239,
                                    child: Text(
                                      // child: RichText(
                                      //   text:TextSpan(children: [TextSpan(text: 'I',style:TextStyle(fontSize:h(22, context),fontWeight: FontWeight.w900,
                                      //       color: Colors.white, )),TextSpan(text:'NVOLVE ',style:TextStyle(fontSize:h(20, context),fontWeight: FontWeight.w600,
                                      //       color: Colors.white, )),TextSpan(text: 'E',style:TextStyle(fontSize:h(22, context),fontWeight: FontWeight.w900,
                                      //       color: Colors.white, )),TextSpan(text:'XPLORE ',style:TextStyle(fontSize:h(20, context),fontWeight: FontWeight.w600,
                                      //       color: Colors.white, )),TextSpan(text: 'E',style:TextStyle(fontSize:h(22, context),fontWeight: FontWeight.w900,
                                      //       color: Colors.white, )),TextSpan(text:'NGAGE ',style:TextStyle(fontSize:h(20, context),fontWeight: FontWeight.w600,
                                      //       color: Colors.white, )),TextSpan(text: '\nE',style:TextStyle(fontSize:h(22, context),fontWeight: FontWeight.w900,
                                      //       color: Colors.white, )),TextSpan(text:'XECUTE ',style:TextStyle(fontSize:h(20, context),fontWeight: FontWeight.w600,
                                      //       color: Colors.white, )),])
                                      "Involve Explore Engage\nExecute",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: h(22, context)),
                                    )),
                                Expanded(child: SizedBox(), flex: 30),
                                Expanded(
                                  flex: 46,
                                  // child: Container(
                                  //   height: h(46, context),
                                  child: loged
                                      ? RoundButton(
                                          color: Colors.white,
                                          onpressed: () {
                                            Navigator.pushNamed(context, 'add',
                                                arguments: getl(events));
                                          },
                                          icon: Icon(Icons.add),
                                          size: w(50, context),
                                        )
                                      : Container(),
                                ),
                                Expanded(flex: 30, child: SizedBox())
                              ],
                            )),
                        Expanded(child: SizedBox(), flex: 6)
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
                        //
                        // Expanded(
                        //   child: SizedBox(),
                        //   flex: 15,
                        // ),
                        // Expanded(
                        //     flex: 40,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: <Widget>[
                        //         DropdownButton(
                        //             iconEnabledColor: Colors.black,
                        //             underline: Container(),
                        //             value: dropvalue,
                        //             items: [
                        //               DropdownMenuItem(
                        //                 child: Text('Last Updated'),
                        //                 value: 0,
                        //               ),
                        //               DropdownMenuItem(
                        //                 child: Text("Name"),
                        //                 value: 1,
                        //               ),
                        //               // DropdownMenuItem(
                        //               //   child: Text("Most Recent"),
                        //               //   value: 2,
                        //               // )
                        //             ],
                        //             onChanged: (value) {
                        //               setState(() {
                        //                 dropvalue = value;
                        //               });
                        //             }),
                        //         FlatButton(
                        //           color: maceonly ? Colors.blue : Colors.pink,
                        //           child:
                        //               maceonly ? Text('MaceOnly') : Text("all"),
                        //           onPressed: () {
                        //             setState(() {
                        //               maceonly = !maceonly;
                        //             });
                        //           },
                        //         ),
                        //         RoundButton(
                        //           elevation: 0,
                        //           color: Colors.transparent,
                        //           icon: grid
                        //               ? Icon(Icons.list)
                        //               : Icon(LineAwesomeIcons.table),
                        //           size: w(50, context),
                        //           onpressed: () {
                        //             setState(() {
                        //               if (grid)
                        //                 grid = false;
                        //               else
                        //                 grid = true;
                        //             });
                        //           },
                        //         ),
                        //       ],
                        //     )),
                        Row(
                          children: <Widget>[
                            Spacer(),
                            // AnimatedCrossFade(
                            //   duration: Duration(milliseconds: 300),
                            //   crossFadeState: open
                            //       ? CrossFadeState.showFirst
                            //       : CrossFadeState.showSecond,
                            //   // color: color[0],
                            //   firstChild:
                            Container(
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RoundButton(
                                    elevation: 0,
                                    size: w(40, context),
                                    color: view ? color[0] : Colors.transparent,
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: view ? Colors.white : color[0],
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
                                    color:
                                        filter ? color[0] : Colors.transparent,
                                    icon: Icon(
                                      LineAwesomeIcons.filter,
                                      color: filter ? Colors.white : color[0],
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
                                      color: sort ? Colors.white : color[0],
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
                            //   secondChild: Container(),
                            // ),
                            // AnimatedIconButton(
                            //   duration: Duration(milliseconds: 300),
                            //   size: 25,
                            //   startBackgroundColor: color[0],
                            //   endBackgroundColor: Colors.white,
                            //   endIcon: Icon(
                            //     Icons.close,
                            //     color: color[0],
                            //   ),
                            //   startIcon: Icon(
                            //     Icons.more_vert,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       view = false;
                            //       filter = false;
                            //       sort = false;
                            //       open = !open;
                            //     });
                            //   },
                            // ),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'All Events',
                                      style: TextStyle(
                                          fontSize: all ? 17 : 15,
                                          color: all ? color[0] : Colors.grey,
                                          fontWeight: all
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        upcoming = false;
                                        ongoing = false;
                                        all = true;
                                      });
                                    },
                                    color: Color(0xFFFFD8CC)
                                        .withOpacity(all ? 1 : 0.5),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Upcoming',
                                      style: TextStyle(
                                          fontSize: upcoming ? 17 : 15,
                                          color:
                                              upcoming ? color[0] : Colors.grey,
                                          fontWeight: upcoming
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        upcoming = true;
                                        ongoing = false;
                                        all = false;
                                      });
                                    },
                                    color: Color(0xFFFFF0CC)
                                        .withOpacity(upcoming ? 1 : 0.5),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Ongoing',
                                      style: TextStyle(
                                          fontSize: ongoing ? 17 : 15,
                                          color:
                                              ongoing ? color[0] : Colors.grey,
                                          fontWeight: ongoing
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        upcoming = false;
                                        ongoing = true;
                                        all = false;
                                      });
                                    },
                                    color: Color(0xFFCCEFF9)
                                        .withOpacity(ongoing ? 1 : 0.5),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'All Organisers',
                                      style: TextStyle(
                                          fontSize: !maceonly ? 17 : 15,
                                          color: !maceonly
                                              ? color[0]
                                              : Colors.grey,
                                          fontWeight: !maceonly
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        maceonly = false;
                                      });
                                    },
                                    color: Color(0xFFFFD8CC)
                                        .withOpacity(!maceonly ? 1 : 0.5),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      'Mace Only',
                                      style: TextStyle(
                                          fontSize: maceonly ? 17 : 15,
                                          color:
                                              maceonly ? color[0] : Colors.grey,
                                          fontWeight: maceonly
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        maceonly = true;
                                      });
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
                                      color: !grid ? color[0] : Colors.grey,
                                      fontWeight: !grid
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    grid = false;
                                  });
                                },
                                color: Color(0xFFFFD8CC)
                                    .withOpacity(!grid ? 1 : 0.5),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Grid View',
                                  style: TextStyle(
                                      fontSize: grid ? 17 : 15,
                                      color: grid ? color[0] : Colors.grey,
                                      fontWeight: grid
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    grid = true;
                                  });
                                },
                                color: Color(0xFFFFF0CC)
                                    .withOpacity(grid ? 1 : 0.5),
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
                                          ? color[0]
                                          : Colors.grey,
                                      fontWeight: dropvalue == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dropvalue = 1;
                                  });
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
                                          ? color[0]
                                          : Colors.grey,
                                      fontWeight: dropvalue == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    dropvalue = 0;
                                  });
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
                              horizontal: w(31, context),
                            ),
                            child: Items(dropvalue, grid,
                                all ? 0 : upcoming ? 1 : 2, maceonly),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          drawer: DrawerObjects(loged),
        ));
  }
}

class DrawerObjects extends StatefulWidget {
  final bool loged;
  DrawerObjects(this.loged);
  @override
  _DrawerObjectsState createState() => _DrawerObjectsState();
}

class _DrawerObjectsState extends State<DrawerObjects> {
  final String maceurl = 'https://ieee.macehub.in/';
  final String newsurl =
      ' https://issuu.com/melvinchooranolil/docs/ieee_mace_sb_official_newsletter_-_the_broadcast__';
  bool check = false;
  bool loginload = false;
  @override
  void initState() {
    super.initState();
    check = widget.loged;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                child: RoundButton(
                  size: h(50, context),
                  onpressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: h(24, context),
                    color: color[0],
                  ),
                  color: Colors.white,
                ),
                flex: 38),
            Expanded(
              flex: 30,
              child: SizedBox(),
            ),
            Expanded(
              flex: 58,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, 'about');
                },
                title: Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            Expanded(
              flex: 58,
              child: ListTile(
                onTap: () async {
                  if (await canLaunch(maceurl)) {
                    await launch(maceurl);
                  } else {
                    print("Error");
                  }
                },
                title: Text(
                  'IEEE Mace Web',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            Expanded(
              flex: 58,
              child: ListTile(
                onTap: () async {
                  if (await canLaunch(newsurl)) {
                    await launch(newsurl);
                  } else {
                    print("Error");
                  }
                },
                title: Text(
                  'NewsLetter',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            // Expanded(
            //   flex: 50,
            //   child: SizedBox(),
            // ),
            // Expanded(
            //     flex: 50,
            //     // child: Row(
            //     //   children: <Widget>[
            //     //     Text('Dark Mode'),
            //     child: LiteRollingSwitch(
            //       value: darktheme,
            //       textOn: 'Light',
            //       textOff: 'Dark',
            //       colorOn: Colors.lightBlue,
            //       colorOff: Colors.black,
            //       iconOff: LineAwesomeIcons.moon,
            //       iconOn: LineAwesomeIcons.sun,
            //       onChanged: (val) {
            //         darktheme = val;
            //       },
            //     )
            //     //   ],
            //     // ),
            //     ),
            Expanded(
              flex: 80,
              child: SizedBox(),
            ),
            Expanded(
              flex: 50,
              child: Container(
                margin: EdgeInsets.only(left: 9),
                child: ModalProgressHUD(
                  inAsyncCall: loginload,
                  child: FlatButton(
                    color: Colors.white,
                    child: check
                        ? Text('Log Out', style: TextStyle(color: color[0]))
                        : Text('Login', style: TextStyle(color: color[0])),
                    onPressed: check
                        ? () async {
                            setState(() {
                              loginload = true;
                            });
                            try {
                              FirebaseAuth.instance.signOut();
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              loginload = false;
                              check = false;
                            });
                          }
                        : () async {
                            Navigator.pop(context);
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return LoginDialog();
                                });
                          },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 274,
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
    );
  }
}

class Items extends StatefulWidget {
  final int sortval, select;
  final bool gridval, maceonly;
  Items(this.sortval, this.gridval, this.select, this.maceonly);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Event> events = List();
  void assign() {
    if (events != null) {
      if (widget.maceonly) {
        if (widget.select == 1)
          setState(() {
            events = events
                .where((event) =>
                    event.active == 1 && event.done == 0 && event.mace ?? false)
                .toList();
          });
        else if (widget.select == 2)
          setState(() {
            events = events.where((event) {
              return event.active == 1 && event.done > 0 && event.mace ?? false;
            }).toList();
          });
        else
          setState(() {
            events = events.where((event) {
              return event.mace ?? false;
            }).toList();
          });
      } else {
        if (widget.select == 1)
          setState(() {
            events = events
                .where((event) => event.active == 1 && event.done == 0)
                .toList();
          });
        else if (widget.select == 2)
          setState(() {
            events = events.where((event) {
              return event.active == 1 && event.done > 0;
            }).toList();
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    events = Provider.of<List<Event>>(context);
    if (events != null)
      widget.sortval == 0
          ? events.sort((a, b) => b.updatedate.compareTo(a.updatedate))
          : events.sort((a, b) => a.name.compareTo(b.name));
    assign();
    return getl(events) != 0
        ? AnimatedSwitcher(
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(child: child, opacity: animation);
            },
            duration: Duration(seconds: 1),
            child: GridView.builder(
                padding: EdgeInsets.only(top: 0.0),
                key: Key('${widget.gridval}'),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.gridval ? 2 : 1,
                  childAspectRatio: widget.gridval ? 1 : 4.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'event',
                          arguments: events[index]);
                    },
                    child: Container(
                      key: Key('${widget.gridval}'),
                      constraints: BoxConstraints(
                        maxHeight: widget.gridval ? 150 : 58,
                      ),
                      margin: EdgeInsets.only(bottom: h(15, context)),
                      height: widget.gridval ? h(150, context) : h(58, context),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(w(13, context))),
                        color: events[index].active == 1
                            ? events[index].done > 0
                                ? Color(0xFF6DD3F0)
                                : Color(0xFFFFCC51)
                            : Color(0xFFF0F0F0),
                        child: widget.gridval
                            ? Column(children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            w(13, context)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              '${events[index].theme}',
                                            )
                                            //  NetworkImage(
                                            //     '${events[index].theme}')
                                            ),
                                        color: color[0]),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text('${events[index].name}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ))))
                              ])
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w(15, context), vertical: 8),
                                child: Align(
                                  heightFactor: 1.5,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${events[index].name}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                },
                itemCount: getl(events)))
        : events == null
            ? Center(child: Container(child: Text('Fetching data...')))
            : (Container(
                child: Center(
                    child: Column(
                children: <Widget>[
                  Container(
                      height: h(300, context),
                      child: Image.asset('assets/empty.gif')),
                  Text("There's Nothing Here...",
                      style: TextStyle(fontSize: h(30, context))),
                ],
              ))));
  }
}
