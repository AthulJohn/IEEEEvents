import 'package:flutter/material.dart';
import 'functions.dart';
import 'values.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              background:
                  Container() //tImage('')) // NetworkImage('event.theme'))
              ),
        ),
        SliverList(
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
                      Text('Event', style: TextStyle(fontSize: 22)),
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
                                //Navigator.pushNamed(context, 'add');
                              },
                              shape: CircleBorder(
                                  side: BorderSide(color: color[0])),
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
                                Navigator.pushNamed(context, 'addact');
                              },
                              shape: CircleBorder(side: BorderSide()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              return Padding(
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
                          trailing: Text(''),
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
                              // activities[ind].desc +
                              "\nEvent Date: " // +
                              //     dfmat(activities[ind].updatedate, false)
                              ,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[600]),
                            ),
                            Text(
                              '\nCreated: ' //+
                              //dfmat(activities[ind].createdate, true)
                              ,
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ]),
                    ),
                  ),
                ),
              );
            },
            childCount: 10,
          ),
        )
      ],
    ));
  }
}
