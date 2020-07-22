import 'package:design/functions.dart';
import 'package:flutter/material.dart';

class CosLoad extends StatefulWidget {
  @override
  _CosLoadState createState() => _CosLoadState();
}

class _CosLoadState extends State<CosLoad> {
  bool con;
  Widget toreturn = Container();
  void check() async {
    con = await testcon();
    if (!con) {
      setState(() {
        toreturn = Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Oops!, It looks like there is no connection. Please Try Again',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    check();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 300,
                child: Image.asset('assets/IEEE.gif', fit: BoxFit.contain)),
            toreturn,
          ],
        ));
  }
}
