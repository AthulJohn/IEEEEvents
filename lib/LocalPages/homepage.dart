import 'package:flutter/material.dart';
// packages
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
//import 'package:lite_rolling_switch/lite_rolling_switch.dart';// for future dark mode
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart'; // for future dark mode
//flutter inbuilt
import 'package:flutter/rendering.dart';
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

  final GlobalKey<_ItemsState> _itemState = GlobalKey<_ItemsState>();
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
    return Scaffold(
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
                                      onpressed: () async {
                                        await Navigator.pushNamed(
                                                context, 'add')
                                            .whenComplete(() => _itemState
                                                .currentState
                                                .assign());
                                        // _itemState.currentState.assign();
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
                                color: filter ? color[0] : Colors.transparent,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
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
                                  _itemState.currentState.filter(0);
                                },
                                color: Color(0xFFFFD8CC)
                                    .withOpacity(all ? 1 : 0.5),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Upcoming',
                                  style: TextStyle(
                                      fontSize: upcoming ? 17 : 15,
                                      color: upcoming ? color[0] : Colors.grey,
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
                                  _itemState.currentState.filter(1);
                                },
                                color: Color(0xFFFFF0CC)
                                    .withOpacity(upcoming ? 1 : 0.5),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Ongoing',
                                  style: TextStyle(
                                      fontSize: ongoing ? 17 : 15,
                                      color: ongoing ? color[0] : Colors.grey,
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
                                  _itemState.currentState.filter(2);
                                },
                                color: Color(0xFFCCEFF9)
                                    .withOpacity(ongoing ? 1 : 0.5),
                              ),
                            ],
                          ),
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
                                      color: !maceonly ? color[0] : Colors.grey,
                                      fontWeight: !maceonly
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    maceonly = false;
                                  });
                                  _itemState.currentState.filter(4);
                                },
                                color: Color(0xFFFFD8CC)
                                    .withOpacity(!maceonly ? 1 : 0.5),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  'Mace Only',
                                  style: TextStyle(
                                      fontSize: maceonly ? 17 : 15,
                                      color: maceonly ? color[0] : Colors.grey,
                                      fontWeight: maceonly
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                                onPressed: () {
                                  setState(() {
                                    maceonly = true;
                                  });
                                  _itemState.currentState.filter(5);
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
                                  color:
                                      dropvalue == 1 ? color[0] : Colors.grey,
                                  fontWeight: dropvalue == 1
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                dropvalue = 1;
                              });
                              _itemState.currentState.sort(1);
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
                                  color:
                                      dropvalue == 0 ? color[0] : Colors.grey,
                                  fontWeight: dropvalue == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                            onPressed: () {
                              setState(() {
                                dropvalue = 0;
                              });
                              _itemState.currentState.sort(0);
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
                            all ? 0 : upcoming ? 1 : 2, maceonly,
                            key: _itemState),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      drawer: DrawerObjects(loged, update),
    );
  }
}

class DrawerObjects extends StatefulWidget {
  final bool loged;
  final ValueChanged<bool> parents;
  DrawerObjects(this.loged, this.parents);
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
                            widget.parents(false);
                          }
                        : () async {
                            Navigator.pop(context);
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return LoginDialog(widget.parents);
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
  Items(this.sortval, this.gridval, this.select, this.maceonly, {Key key})
      : super(key: key);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Event> events, unchangedevents;
  int select;
  bool mace;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    assign();
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void filter(int ind) {
    if (ind < 3)
      select = ind;
    else
      select = widget.select;
    if (ind == 4)
      mace = false;
    else if (ind == 5)
      mace = true;
    else
      mace = widget.maceonly;
    if (unchangedevents != null) {
      if (mace) {
        if (select == 1)
          setState(() {
            events = unchangedevents
                .where((event) =>
                    event.active == 1 && event.done == 0 && event.mace ?? false)
                .toList();
          });
        else if (select == 2)
          setState(() {
            events = unchangedevents.where((event) {
              return event.active == 1 && event.done > 0 && event.mace ?? false;
            }).toList();
          });
        else
          setState(() {
            events = unchangedevents.where((event) {
              return event.mace ?? false;
            }).toList();
          });
      } else {
        if (select == 1)
          setState(() {
            events = unchangedevents
                .where((event) => event.active == 1 && event.done == 0)
                .toList();
          });
        else if (select == 2)
          setState(() {
            events = unchangedevents.where((event) {
              return event.active == 1 && event.done > 0;
            }).toList();
          });
        else
          setState(() {
            events = unchangedevents;
          });
      }
      sort(-1);
    }
  }

  void sort(int val) {
    if (val < 0) val = widget.sortval;
    if (events != null)
      val == 0
          ? events.sort((a, b) => b.updatedate.compareTo(a.updatedate))
          : events.sort((a, b) => a.name.compareTo(b.name));
  }

  void assign() async {
    unchangedevents = await CloudService().getevents();
    events = unchangedevents;
    filter(3);
    sort(-1);
  }

  @override
  void initState() {
    super.initState();
    assign();
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return getl(events) != 0
        ? AnimatedSwitcher(
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(child: child, opacity: animation);
            },
            duration: Duration(seconds: 1),
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: GridView.builder(
                  controller: _controller,
                  padding: EdgeInsets.only(top: 0.0),
                  key: Key('${widget.gridval}'),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.gridval ? 2 : 1,
                    childAspectRatio: widget.gridval ? 1 : 4.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () async {
                        await Navigator.pushNamed(context, 'event',
                                arguments: events[index])
                            .whenComplete(() => assign());
                      },
                      child: Container(
                        key: Key('${widget.gridval}'),
                        constraints: BoxConstraints(
                          maxHeight: widget.gridval ? 150 : 58,
                        ),
                        margin: EdgeInsets.only(bottom: h(15, context)),
                        height:
                            widget.gridval ? h(150, context) : h(58, context),
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
                  itemCount: getl(events)),
            ))
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
