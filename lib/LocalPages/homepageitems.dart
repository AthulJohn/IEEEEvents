import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../functions.dart';
import '../FIREBASE/database.dart';
import '../values.dart';

final GlobalKey<_ItemsState> itemState = GlobalKey<_ItemsState>();

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
        ? // AnimatedSwitcher(
        //     switchInCurve: Curves.easeInCubic,
        //     switchOutCurve: Curves.easeInCubic,
        //     transitionBuilder: (Widget child, Animation<double> animation) {
        //       return FadeTransition(child: child, opacity: animation);
        //     },
        //     duration: Duration(seconds: 1),
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, -0.90),
                colors: <Color>[Colors.transparent, Colors.white],
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
                  padding: EdgeInsets.only(top: 10.0),
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
                          color: color[0].withOpacity(0.9),
                          // Color(0xFF3b5f83)
                          //     .withOpacity(0.8), //events[index].active == 1
                          // ? events[index].done > 0
                          //     ? Color(0xFFF0F0F0) //Color(0xFF6DD3F0)
                          //     : Color(0xFFF0F0F0) //Color(0xFFFFCC51)
                          // : Color(0xFFF0F0F0),
                          child: widget.gridval
                              ? Column(children: <Widget>[
                                  Expanded(
                                    flex: 5,
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
                                      flex: 2,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5, right: 10, left: 10),
                                          child: Text('${events[index].name}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              )))),
                                  Expanded(
                                      child: Container(
                                          // padding: EdgeInsets.all(10),
                                          child: Text(
                                              events[index].active == 1
                                                  ? events[index].done > 0
                                                      ? 'ongoing'
                                                      : 'upcoming'
                                                  : 'completed',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: events[index].active == 1
                                                    ? events[index].done > 0
                                                        ? Color(0xFFff823a)
                                                        : Color(0xFF2aa666)
                                                    : Colors.grey,
                                                fontSize: 13,
                                              ))))
                                ])
                              : Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: w(15, context),
                                          vertical: 8),
                                      child: Align(
                                        heightFactor: 1.5,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${events[index].name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 5,
                                        bottom: 5,
                                        child: Text(
                                            events[index].active == 1
                                                ? events[index].done > 0
                                                    ? 'ongoing          '
                                                    : 'upcoming          '
                                                : 'completed          ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: events[index].active == 1
                                                  ? events[index].done > 0
                                                      ? Color(0xFFff823a)
                                                      : Color(0xFF2aa666)
                                                  : Colors.grey,
                                              fontSize: 13,
                                            )))
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                  itemCount: getl(events)),
            ),
          )
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
