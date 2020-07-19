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
            body: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
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
                background: Image(
                    image: NetworkImage('${event.theme}'), fit: BoxFit.cover),
              ),
            ),
            ActList(event),
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
  List<Event> activities = [];
  bool delete = false, load = false;
  @override
  Widget build(BuildContext context) {
    activities = Provider.of<List<Event>>(context);
    print('act=$activities');
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext conxt, int ind) {
          // activities.sort(
          //   (a, b) => a.updatedate.compareTo(b.updatedate),
          // );
          if (ind == 0)
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${widget.event.name}', style: TextStyle(fontSize: 22)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: h(46, context),
                        child: FlatButton(
                          color: Colors.white,
                          child: Icon(
                            Icons.edit,
                            size: h(20, context),
                            color: color[0],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Update(widget.event, activities)));
                          },
                          shape:
                              CircleBorder(side: BorderSide(color: color[0])),
                        ),
                      ),
                      Container(
                        height: h(46, context),
                        child: FlatButton(
                          color: color[0],
                          child: Icon(
                            Icons.delete_outline,
                            size: h(20, context),
                            color: Colors.white,
                          ),
                          onPressed: () async {
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
                                                    .delet(widget.event.name);
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
                          shape: CircleBorder(side: BorderSide()),
                        ),
                      ),
                      Container(
                        height: h(46, context),
                        child: FlatButton(
                          color: color[0],
                          child: Icon(
                            Icons.add,
                            size: h(20, context),
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'addact', arguments: [
                              widget.event.name,
                              getl(activities)
                            ]);
                          },
                          shape: CircleBorder(side: BorderSide()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          return activities != null
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
                                  onPressed: () {
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
                      //      CloudService().acdele(event.name, activities[ind].name);
                    },
                    // background: Container(
                    //     color: Colors.white38,
                    //     child: widget.loged
                    //         ? Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //                 Icon(Icons.delete_outline,
                    //                     size: 50, color: Colors.redAccent)
                    //               ])
                    //         : Container()),
                    key: Key(''),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                            trailing: Text('${activities[ind - 1].name}'),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(25.0, 0, 8, 0),
                              child: Center(
                                  child: Text(
                                '',
                                //  activities[ind].name,
                                style: TextStyle(
                                    fontSize: 30, color: Colors.redAccent),
                              )),
                            ),
                            children: <Widget>[
                              Text(
                                activities[ind - 1].desc +
                                    "\nEvent Date: " +
                                    "${activities[ind - 1].updatedate}",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                              Text(
                                '\nCreated: ' +
                                    '${activities[ind - 1].createdate}',
                                style: TextStyle(color: Colors.grey[500]),
                              )
                            ]),
                      ),
                    ),
                  ),
                )
              : Container();
        },
        childCount: getl(activities) + 1,
      ),
    );
  }
}
