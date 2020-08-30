// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:design/LocalPages/gallery.dart';
import 'package:design/Widgets/RoundButton.dart';
// import 'loadingpage.dart';
import 'package:flutter/material.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:design/functions.dart';
import 'package:design/values.dart';
import '../Storage/sqlite.dart';
// import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:design/Storage/database.dart';
import 'package:intl/intl.dart';
import 'update.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class Events extends StatefulWidget {
  // final Event event;
  // Events(this.event);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final ScrollController scrollController = ScrollController();
  List activities = [];
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                leading: Container(),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(74),
                        bottomLeft: Radius.circular(74))),
                expandedHeight: 200,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  title: Text(
                    // event.name,
                    '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  background: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(_createRoute(event.name, event.theme));
                    },
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      child: Hero(
                        tag: '0',
                        child: CachedNetworkImage(
                            imageUrl: event.theme, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              ActList(event),
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
                child: RoundButton(
                    color: color[0],
                    icon: Icon(Icons.arrow_back, color: color[1]),
                    onpressed: () {
                      Navigator.pop(context);
                    },
                    size: h(40, context))),
          )
        ],
      ),
    );
  }
}

class ActList extends StatefulWidget {
  final Event event;
  ActList(this.event);
  @override
  _ActListState createState() => _ActListState();
}

class _ActListState extends State<ActList> {
  List<Event> activities, localactivities;
  bool descac = false, open = false;
  bool delete = false, loading = false, loged = false;
  String errortext = '';
  void getfromlocal() async {
    loged = await logincheck();
    localactivities =
        await activitiesFromStorage(widget.event.name.replaceAll(' ', 'Þ'));
    activities = localactivities;
  }

  void check() async {
    if (await testcon())
      activities =
          await CloudService().getactivities(widget.event.name); //.then((val) {
    //   setState(() {});
    //   return;
    // });
    if (activities != null)
      activities.sort(
        (a, b) => a.updatedate.compareTo(b.updatedate),
      );
    if (this.mounted) setState(() {});
    await disposeActivities(widget.event.name.replaceAll(' ', 'Þ'),
        localactivities ?? [], activities ?? []);
  }

  @override
  void initState() {
    super.initState();
    getfromlocal();
  }

  @override
  Widget build(BuildContext context) {
    check();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext conxt, int ind) {
          if (ind == 1)
            return AnimatedCrossFade(
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeOut,
              crossFadeState:
                  descac ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 200),
              firstChild: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: w(28, context)),
                child: Builder(builder: (BuildContext ctxt) {
                  return Linkify(
                    text: widget.event.desc,
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) {
                        await launch(link.url);
                      } else {
                        Scaffold.of(ctxt).showSnackBar(SnackBar(
                            content: Text('Could not launch the url !')));
                      }
                    },
                    style: TextStyle(fontSize: 18, color: color[5]),
                  );
                }),
              ),
              secondChild: Container(),
            );
          else if (ind == 0)
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: w(28, context),
              ),
              child: Container(
                //height: h(50, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      // flex: 6,
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Text('${widget.event.name}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            if (!loged)
                              Expanded(
                                  child: descac
                                      ? Icon(Icons.keyboard_arrow_up)
                                      : Icon(Icons.keyboard_arrow_down))
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            descac = !descac;
                          });
                        },
                      ),
                    ),
                    if (loged)
                      // Expanded(
                      //   flex: open ? 8 : 1,
                      //   child:
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 300),
                        crossFadeState: open
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        // color: color[0],
                        firstChild: Container(
                          child: Row(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundButton(
                                size: w(40, context),
                                color: color[0],
                                icon: Icon(
                                  Icons.edit,
                                  color: color[1],
                                ),
                                onpressed: () async {
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Update(
                                              widget.event, activities)));
                                  setState(() {});
                                },
                              ),
                              RoundButton(
                                size: w(40, context),
                                color: color[0],
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: color[1],
                                ),
                                onpressed: () async {
                                  await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Confirm Delete\n$errortext',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('No')),
                                            FlatButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    // load = true;
                                                    delete = true;
                                                  });
                                                  try {
                                                    await CloudService().delet(
                                                        widget.event.name);
                                                  } catch (e) {
                                                    setState(() {
                                                      errortext = e;
                                                    });
                                                  }
                                                  // setState(() {
                                                  //   load = false;
                                                  // });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Yes'))
                                          ],
                                        );
                                      });
                                  if (delete) {
                                    delete = false;
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              RoundButton(
                                size: w(40, context),
                                color: color[0],
                                icon: Icon(
                                  Icons.add,
                                  size: w(20, context),
                                  color: color[1],
                                ),
                                onpressed: () async {
                                  await Navigator.pushNamed(context, 'addact',
                                      arguments: [
                                        widget.event.name,
                                        getl(activities),
                                        widget.event.lind
                                      ]);
                                  check();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ),
                        secondChild: Container(),
                      ),
                    if (loged)
                      AnimatedIconButton(
                        duration: Duration(milliseconds: 300),
                        size: 22,
                        startBackgroundColor: open ? color[1] : color[0],
                        endBackgroundColor: open ? color[0] : color[1],
                        endIcon: open
                            ? Icon(
                                Icons.keyboard_arrow_left,
                                color: color[1],
                              )
                            : Icon(
                                Icons.close,
                                color: color[0],
                              ),
                        startIcon: open
                            ? Icon(
                                Icons.close,
                                color: color[0],
                              )
                            : Icon(
                                Icons.keyboard_arrow_left,
                                color: color[1],
                              ),
                        onPressed: () {
                          setState(() {
                            open = !open;
                          });
                        },
                      ),
                  ],
                ),
              ),
            );
          return getl(activities) != 0
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Dismissible(
                    key: Key('${activities[ind - 2].index}'),
                    direction: loged
                        ? DismissDirection.startToEnd
                        : DismissDirection.endToStart,
                    confirmDismiss: (startToEnd) async {
                      bool val;
                      if (loged)
                        await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        val = false;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No')),
                                FlatButton(
                                    onPressed: () async {
                                      setState(() {
                                        val = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes'))
                              ],
                            );
                          },
                        );
                      return val;
                    },
                    onDismissed: (startToEnd) {
                      CloudService().acdele(widget.event.name,
                          activities[ind - 2].index, widget.event.done);
                    },
                    background: Container(
                      color: color[2],
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (loged)
                              Icon(Icons.delete_outline,
                                  size: 50, color: Colors.redAccent)
                          ]),
                    ),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13)),
                        width: w(330, context),
                        child: ConfigurableExpansionTile(
                          header: Container(
                            width: w(330, context),
                            child: Card(
                              color: Color(0xFF04294F),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  // child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${activities[ind - 2].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                        // ),
                                      ),
                                      SizedBox(
                                        width: w(20, context),
                                      ),
                                      if (activities[ind - 2]
                                                  .updatedate
                                                  .difference(DateTime.now())
                                                  .inDays ==
                                              0 &&
                                          activities[ind - 2].updatedate.day ==
                                              DateTime.now().day)
                                        Text(
                                          'Today',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xFFFFCC51)),
                                        )
                                      else if (activities[ind - 2]
                                                  .updatedate
                                                  .difference(DateTime.now())
                                                  .inDays <
                                              3 &&
                                          activities[ind - 2].updatedate.day ==
                                              DateTime.now().day + 1)
                                        Text(
                                          'Tomorrow',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xFF5DC3E0)),
                                        )
                                      else
                                        Text(
                                          '${activities[ind - 2].updatedate.day} ${DateFormat('MMM').format(activities[ind - 2].updatedate).toUpperCase()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.grey[400]),
                                        )
                                    ],
                                  )),
                            ),
                          ),
                          headerExpanded: Container(
                              margin: EdgeInsets.only(top: 0),
                              width: w(330, context),
                              child: Card(
                                color: color[0],
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(13))),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${activities[ind - 2].name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: w(20, context),
                                        ),
                                        if (activities[ind - 2]
                                                    .updatedate
                                                    .difference(DateTime.now())
                                                    .inDays ==
                                                0 &&
                                            activities[ind - 2]
                                                    .updatedate
                                                    .day ==
                                                DateTime.now().day)
                                          Text(
                                            'Today',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFFFFCC51)),
                                          )
                                        else if (activities[ind - 2]
                                                    .updatedate
                                                    .difference(DateTime.now())
                                                    .inDays <
                                                3 &&
                                            activities[ind - 2]
                                                    .updatedate
                                                    .day ==
                                                DateTime.now().day + 1)
                                          Text(
                                            'Tomorrow',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF5DC3E0)),
                                          )
                                        else
                                          Text(
                                            '${activities[ind - 2].updatedate.day} ${DateFormat('MMM').format(activities[ind - 2].updatedate).toUpperCase()}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Colors.grey[400]),
                                          )
                                      ],
                                    )),
                              )),
                          children: <Widget>[
                            Container(
                              width: w(320, context),
                              color:
                                  Color(0xFF3b5f83).withOpacity(0.4), //color[0]
                              //.withOpacity(0.2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Text(
                                            '${activities[ind - 2].updatedate.day}',
                                            style: TextStyle(
                                              fontFamily: 'quicksand',
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat('MMM').format(activities[ind - 2].updatedate).toUpperCase()}\n${activities[ind - 2].updatedate.year}',
                                          //   style: TextStyle(
                                          //     fontSize: 15,
                                          //   ),
                                          // ),
                                          // Text(
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontFamily: 'quicksand',
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child:
                                        Builder(builder: (BuildContext ctxt) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Linkify(
                                          text: activities[ind - 2].desc,
                                          onOpen: (link) async {
                                            if (await canLaunch(link.url)) {
                                              await launch(link.url);
                                            } else {
                                              Scaffold.of(ctxt).showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Could not launch the url !')));
                                            }
                                          },
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      );
                                    }),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: <Widget>[
                                  //     Icon(Icons.calendar_today),
                                  //     Text(
                                  //       'Date:' +
                                  //           DateFormat('dd-MM-yyyy').format(
                                  //               activities[ind - 2].updatedate),
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(fontSize: 18),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              width: w(320, context),
                              decoration: BoxDecoration(
                                  color: Color(0xFF3b5f83)
                                      .withOpacity(0.4), //Color(0xFFC4C4C4),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30))),
                              child: Text(
                                '\nCreated: ' +
                                    DateFormat('dd-MM-yyyy')
                                        .format(activities[ind - 2].createdate),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Nothing(activities != null);
        },
        childCount: getl(activities) == 0 ? 3 : getl(activities) + 2,
      ),
    );
  }
}

Route _createRoute(String name, String theme) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        Gallery(name, theme),
    transitionDuration: Duration(milliseconds: 750),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, -1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Nothing extends StatelessWidget {
  final bool actnull;
  Nothing(this.actnull);
  @override
  Widget build(BuildContext context) {
    return actnull
        ? Center(
            child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: h(120, context),
                  horizontal: 20,
                ),
                child: Text(
                  'Something Big is Cooking 🥘',
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ))) //)
        : Center(
            child: Container(
              child: Text('Fetching Data.....'),
            ),
          );
  }
}
