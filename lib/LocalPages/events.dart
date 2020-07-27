import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:design/LocalPages/gallery.dart';
import 'package:design/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:design/functions.dart';
import 'package:design/values.dart';
import 'package:provider/provider.dart';
import 'package:design/FIREBASE/database.dart';
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
    return StreamProvider<List<Event>>.value(
        value: CloudService().acts(event.name),
        child: Scaffold(
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
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(30)),
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
                child: SafeArea(
                    child: RoundButton(
                        color: color[0],
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onpressed: () {
                          Navigator.pop(context);
                        },
                        size: h(40, context))),
              )
            ],
          ),
        ));
  }
}

class ActList extends StatefulWidget {
  final Event event;
  ActList(this.event);
  @override
  _ActListState createState() => _ActListState();
}

class _ActListState extends State<ActList> {
  List<Event> activities;
  bool descac = false;
  bool delete = false, load = false, loading = false, loged = false;
  Future check() async {
    loged = await logincheck();
  }

  @override
  Widget build(BuildContext context) {
    check();
    activities = Provider.of<List<Event>>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext conxt, int ind) {
          // activities.sort(
          //   (a, b) => a.updatedate.compareTo(b.updatedate),
          // );
          if (ind == 1)
            return AnimatedSwitcher(
                transitionBuilder: (child, animation) =>
                    ScaleTransition(child: child, scale: animation),
                duration: Duration(milliseconds: 300),
                child: Container(
                    key: Key('$descac'),
                    child: descac
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.event.desc,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Container()));
          else if (ind == 0)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: InkWell(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Text('${widget.event.name}',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                              child: descac
                                  ? Icon(Icons.keyboard_arrow_up)
                                  : Icon(Icons.keyboard_arrow_down))
                        ],
                      ),
                      onTap: () {
                        if (descac)
                          setState(() {
                            descac = false;
                          });
                        else
                          setState(() {
                            descac = true;
                          });
                      },
                    ),
                  ),
                  Expanded(
                    flex: loged ? 4 : 0,
                    child: loged
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RoundButton(
                                size: w(40, context),
                                color: color[0],
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onpressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Update(
                                              widget.event, activities)));
                                },
                              ),
                              RoundButton(
                                size: w(40, context),
                                color: color[0],
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                                onpressed: () async {
                                  await showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return ModalProgressHUD(
                                          inAsyncCall: load,
                                          child: AlertDialog(
                                            title: Text('Confirm Delete'),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('No')),
                                              FlatButton(
                                                  onPressed: () async {
                                                    try {
                                                      setState(() {
                                                        load = true;
                                                        delete = true;
                                                      });
                                                      await CloudService().delet(
                                                          widget.event.name,
                                                          getl(widget.event
                                                                  .images) !=
                                                              0);
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    setState(() {
                                                      load = false;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Yes'))
                                            ],
                                          ),
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
                                  color: Colors.white,
                                ),
                                onpressed: () {
                                  Navigator.pushNamed(context, 'addact',
                                      arguments: [
                                        widget.event.name,
                                        getl(activities)
                                      ]);
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          return getl(activities) != 0
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (startToEnd) async {
                      bool val;
                      // if (widget.loged)
                      await showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return ModalProgressHUD(
                            inAsyncCall: loading,
                            child: AlertDialog(
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
                            ),
                          );
                        },
                      );
                      return val;
                    },
                    onDismissed: (startToEnd) {
                      // setState(() {
                      //   loading = true;
                      // });
                      CloudService()
                          .acdele(widget.event.name, activities[ind - 2].name);
                      // setState(() {
                      //   loading = false;
                      // });
                    },
                    background: Container(
                      color: Colors.white,
                      child: // true//////////////////////TODO
                          //?
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Icon(Icons.delete_outline,
                                size: 50, color: Colors.redAccent)
                          ]),
                    ),
                    // : Container()),
                    key: Key(''),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(30)),
                        width: w(305, context),
                        child: ConfigurableExpansionTile(
                          header: Container(
                            width: w(300, context),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              // child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      '${activities[ind - 2].name}',
                                      //  activities[ind].name,
                                      style: TextStyle(
                                          fontSize: 30, color: color[0]),
                                      // )
                                    ),
                                  )),
                            ),
                          ),
                          headerExpanded: Container(
                              width: w(305, context),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(30))),
                                // child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: Text(
                                        '${activities[ind - 2].name}',
                                        //  activities[ind].name,
                                        style: TextStyle(
                                            fontSize: 30, color: color[0]),
                                        // )
                                      ),
                                    )),
                              )),
                          children: <Widget>[
                            Container(
                              width: w(300, context),
                              color: Colors.grey,
                              child: Text(
                                activities[ind - 2].desc,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              width: w(300, context),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30))),
                              child: Text(
                                '\nCreated: ' +
                                    DateFormat('dd-MM-yyyy')
                                        .format(activities[ind - 2].createdate),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : activities != null
                  ? Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: h(120, context),
                            horizontal: 20,
                          ),
                          // child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Container(
                          //         height: h(200, context),
                          //         child: Image.asset('assets/cooking.gif',
                          //             fit: BoxFit.fitHeight,)),
                          child: ColorizeAnimatedTextKit(
                            pause: Duration(seconds: 0),
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            speed: Duration(milliseconds: 50),
                            textAlign: TextAlign.center,
                            colors: [
                              Colors.transparent,
                              color[0].withOpacity(0.6),
                              Colors.transparent,
                              color[0].withOpacity(0.3),
                              Colors.transparent
                            ],
                            textStyle: TextStyle(fontSize: 35, color: color[0]),
                            text: [
                              "Something Big is Cooking",
                              "but it's not yet ready!",
                              "Stay Tuned..."
                            ],
                          )
                          // Text(
                          //   "Something Big is Cooking, but it's not yet ready! Stay Tuned...",
                          //   textAlign: TextAlign.center,
                          //   ),
                          // ],
                          )) //)
                  : Center(
                      child: Container(
                        child: Text('Fetching Data.....'),
                      ),
                    );
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
