import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:design/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:design/functions.dart';
import 'package:design/values.dart';
import 'package:provider/provider.dart';
import 'package:design/FIREBASE/database.dart';
import 'update.dart';

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
                    background: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      child: Image(
                          image: NetworkImage('${event.theme}'),
                          fit: BoxFit.cover),
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
        )));
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
                                style: TextStyle(fontSize: 28)),
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
                                size: w(50, context),
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
                                size: w(50, context),
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
                                                      });
                                                      await CloudService()
                                                          .delet(widget
                                                              .event.name);
                                                      delete = true;
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(25.0, 0, 8, 0),
                              child: Center(
                                  child: Text(
                                '${activities[ind - 2].name}',
                                //  activities[ind].name,
                                style: TextStyle(fontSize: 30, color: color[0]),
                              )),
                            ),
                            children: <Widget>[
                              Text(
                                activities[ind - 2].desc +
                                    "\nEvent Date: " +
                                    "${activities[ind - 2].updatedate}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                              Text(
                                '\nCreated: ' +
                                    '${activities[ind - 2].createdate}',
                                style: TextStyle(color: Colors.grey[500]),
                              )
                            ]),
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
                            textStyle: TextStyle(fontSize: 40, color: color[0]),
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
