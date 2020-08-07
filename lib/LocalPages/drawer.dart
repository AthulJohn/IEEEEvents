import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../values.dart';
import '../functions.dart';
import '../Widgets/RoundButton.dart';

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
