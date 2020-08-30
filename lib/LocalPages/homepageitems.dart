import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../functions.dart';
import '../Storage/sqlite.dart';
import '../Storage/database.dart';
import '../values.dart';

final GlobalKey<_ItemsState> itemState = GlobalKey<_ItemsState>();

class Items extends StatefulWidget {
  final List<Event> eventss;
  final int sortval, select;
  final bool gridval, maceonly;
  Items(this.eventss, this.sortval, this.gridval, this.select, this.maceonly,
      {Key key})
      : super(key: key);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Event> events, unchangedevents;
  int select;
  bool mace, connection = true;

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
    connection = await testcon();
    unchangedevents = await CloudService().getevents();
    if (connection) disposetheApp(unchangedevents, widget.eventss);
    //setLocalEvents(unchangedevents, widget.eventss);
    events = unchangedevents;
    filter(3);
    sort(-1);
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    unchangedevents = widget.eventss;
    events = unchangedevents;
    filter(3);
    assign();
  }

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return getl(events) != 0
        ? // AnimatedSwitcher(
        //     switchInCurve: Curves.easeInCubic,
        //     switchOutCurve: Curves.easeInCubic,
        //     transitionBuilder: (Widget child, Animation<double> animation) {
        //       return FadeTransition(child: child, opacity: animation);
        //     },
        //     duration: Duration(seconds: 1),
        Stack(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment(0.0, -0.90),
                    colors: <Color>[Colors.transparent, color[2]],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropMaterialHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: GridView.builder(
                      controller: _controller,
                      padding: EdgeInsets.only(top: 12.0),
                      key: Key('${widget.gridval}'),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.gridval ? 2 : 1,
                        childAspectRatio: widget.gridval ? 1 : 4.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return HomeItem(
                          gridval: widget.gridval,
                          event: events[index],
                        );
                      },
                      itemCount: getl(events)),
                ),
              ),
              if (!connection)
                Align(
                  alignment: Alignment(0, 1),
                  child: //AnimatedCrossFade(
                      //firstChild:
                      Container(
                    decoration: BoxDecoration(
                        color: color[0],
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  // secondChild: Container(),
                  //       crossFadeState: connection
                  //           ? CrossFadeState.showSecond
                  //           : CrossFadeState.showFirst,
                  //       duration: Duration(seconds: 1)),
                )
            ],
          )
        : events == null
            ? Center(child: Container(child: Text('Fetching data...')))
            : (Container(
                child: Center(
                    child: Column(
                children: <Widget>[
                  Container(
                      height: h(300, context),
                      width: w(300, context),
                      child: Image.asset('assets/empty.gif')),
                  Text("There's Nothing Here...",
                      style: TextStyle(fontSize: h(30, context))),
                ],
              ))));
  }
}

class HomeItem extends StatelessWidget {
  final bool gridval;
  final Event event;
  HomeItem({this.gridval, this.event});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w(25, context)),
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.1,
              color: color[3],
              blurRadius: 5,
            )
          ]),
      key: Key('$gridval'),
      constraints: BoxConstraints(
        maxHeight: gridval ? 150 : 58,
      ),
      margin: EdgeInsets.only(
          bottom: h(15, context),
          left: gridval ? 5 : 11,
          right: gridval ? 5 : 11),
      height: gridval ? h(150, context) : h(58, context),
      child: InkWell(
        onTap: () async {
          await Navigator.pushNamed(context, 'event', arguments: event);
          //.whenComplete(() => assign());
        },
        child: Tooltip(
          message: event.name,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w(25, context))),
            color: color[2], //color[0].withOpacity(0.9),
            // Color(0xFF3b5f83)
            //     .withOpacity(0.8), //events[index].active == 1
            // ? events[index].done > 0
            //     ? Color(0xFFF0F0F0) //Color(0xFF6DD3F0)
            //     : Color(0xFFF0F0F0) //Color(0xFFFFCC51)
            // : Color(0xFFF0F0F0),
            child: gridval
                ? Column(children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w(16, context)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  '${event.theme}',
                                )
                                //  NetworkImage(
                                //     '${events[index].theme}')
                                ),
                            color: color[0]),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                            padding:
                                EdgeInsets.only(top: 5, right: 10, left: 10),
                            child: Text('${event.name}',
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: color[0],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                )))),
                    Expanded(
                        child: Container(
                            // padding: EdgeInsets.all(10),
                            child: Text(
                                event.active == 1
                                    ? event.done > 0 ? 'ONGOING' : 'UPCOMING'
                                    : 'COMPLETED',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: event.active == 1
                                      ? event.done > 0
                                          ? color[0].withOpacity(0.5)
                                          : color[4].withOpacity(0.8)
                                      : Colors.grey,
                                  fontSize: 11,
                                ))))
                  ])
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: w(15, context), vertical: h(13, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Align(
                        //   heightFactor: 1.5,
                        //   alignment: Alignment.centerLeft,
                        // child:
                        Text(
                          '${event.name}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: color[0],
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            // ),
                          ),
                        ),
                        SizedBox(width: w(10, context)),
                        Text(
                            event.active == 1
                                ? event.done > 0 ? 'ONGOING ' : 'UPCOMING'
                                : 'COMPLETED',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: event.active == 1
                                  ? event.done > 0
                                      ? color[0].withOpacity(0.5)
                                      : color[4].withOpacity(0.8)
                                  : Colors.grey,
                              fontSize: 11,
                            ))
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
