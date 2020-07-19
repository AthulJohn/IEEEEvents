import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../functions.dart';
import '../values.dart';
import 'login.dart';
import '../FIREBASE/database.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loged = false;
  FirebaseUser user;
  Future checkuser() async {
    loged = await logincheck();
    if (loged) {
      user = await FirebaseAuth.instance.currentUser();
    }
    setState(() {});
    // setState(()  {
    //   });
  }

  List<Event> events = [];
  @override
  Widget build(BuildContext context) {
    checkuser();
    return StreamProvider<List<Event>>.value(
        value: CloudService().events,
        child: Scaffold(
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
                                      //Scaffold.of(context).openDrawer();
                                    },
                                  ),
                                  flex: 40,
                                ),
                                Expanded(
                                  child: SizedBox(),
                                  flex: 192,
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: w(25, context),
                                    ),
                                    onPressed: () {},
                                  ),
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
                            flex: 9,
                            child: Row(
                              children: <Widget>[
                                Expanded(child: SizedBox(), flex: 31),
                                Expanded(
                                    flex: 219,
                                    child: Text(
                                      "Involve Explore Engage\nExecute",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: h(19, context)),
                                    )),
                                Expanded(child: SizedBox(), flex: 30),
                                Expanded(
                                    flex: 46,
                                    child: Container(
                                      height: h(46, context),
                                      child: FlatButton(
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          size: h(20, context),
                                          color: color[0],
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, 'add',
                                              arguments: getl(events));
                                        },
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.white)),
                                      ),
                                    )),
                                Expanded(flex: 50, child: SizedBox())
                              ],
                            )),
                        Expanded(child: SizedBox(), flex: 8)
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 592,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: SizedBox(), flex: 17),
                        Expanded(
                            flex: 38,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                FlatButton(
                                  child: Text('All Events'),
                                  onPressed: () {},
                                  color: Color(0xFFFFD8CC),
                                ),
                                FlatButton(
                                  child: Text('Upcoming'),
                                  onPressed: () {},
                                  color: Color(0xFFFFF0CC),
                                ),
                                FlatButton(
                                  child: Text('Ongoing'),
                                  onPressed: () {},
                                  color: Color(0xFFCCEFF9),
                                ),
                              ],
                            )),
                        Expanded(
                          child: SizedBox(),
                          flex: 42,
                        ),
                        Expanded(
                            flex: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                DropdownButton(
                                    value: 0,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('Upcoming Date'),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Vere etho date"),
                                        value: 1,
                                      )
                                    ],
                                    onChanged: (value) {}),
                                IconButton(
                                  icon: Icon(Icons.grid_on),
                                  onPressed: () {},
                                ),
                              ],
                            )),
                        Expanded(
                          child: SizedBox(),
                          flex: 39,
                        ),
                        Expanded(
                            flex: 436,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: w(31, context),
                                vertical: 0,
                              ),
                              child: Items(),
                            )),
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
  bool check = false;
  bool loginload = false;
  @override
  void initState() {
    // TODO: implement initState
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
                child: MaterialButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_back, size: h(38, context)),
                  color: color[0],
                ),
                flex: 38),
            Expanded(
              flex: 30,
              child: SizedBox(),
            ),
            Expanded(
              flex: 38,
              child: ListTile(
                title: Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            Expanded(
              flex: 38,
              child: ListTile(
                title: Text(
                  'IEEE Mace Web',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            Expanded(
              flex: 38,
              child: ListTile(
                title: Text(
                  'Broadcast Letter',
                  style: TextStyle(color: Colors.white),
                ),
                contentPadding: EdgeInsets.fromLTRB(9, 8, 0, 9),
              ),
            ),
            Expanded(
              flex: 60,
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
              flex: 354,
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
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Event> events = List();
  @override
  Widget build(BuildContext context) {
    events = Provider.of<List<Event>>(context);
    if (events != null)
      events.sort((a, b) => b.createdate.compareTo(a.createdate));
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print(events[index].name);
            Navigator.pushNamed(context, 'event', arguments: events[index]);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: h(15, context)),
            height: h(58, context),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w(13, context))),
              color: Colors.blue,
              child: Text('${events[index].name}'),
            ),
          ),
        );
      },
      itemCount: getl(events),
    );
  }
}
