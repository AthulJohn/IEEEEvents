import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: SizedBox(), flex: 22),
                Expanded(
                    child: FlatButton(
                      color: Color(0xFF04294F),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: CircleBorder(side: BorderSide()),
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    flex: 38),
                Expanded(child: SizedBox(), flex: 30),
                Expanded(child: Text('Event Name'), flex: 19),
                Expanded(child: SizedBox(), flex: 13),
                Expanded(
                    flex: 32,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: Color(0xFFEFEFEF)),
                    )),
                Expanded(flex: 24, child: SizedBox()),
                Expanded(flex: 19, child: Text('Event Description')),
                Expanded(
                  flex: 13,
                  child: SizedBox(),
                ),
                Expanded(
                    flex: 111,
                    child: TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: Color(0xFFEFEFEF)),
                    )),
                Expanded(flex: 32, child: SizedBox()),
                Expanded(flex: 19, child: Text('Event Date')),
                Expanded(flex: 13, child: SizedBox()),
                Expanded(
                    flex: 32,
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          border: InputBorder.none,
                          fillColor: Color(0xFFEFEFEF)),
                    )),
                Expanded(flex: 37, child: SizedBox()),
                Expanded(flex: 19, child: Text('Background Image')),
                Expanded(flex: 13, child: SizedBox()),
                Expanded(
                    flex: 49,
                    child: FlatButton(
                      color: Color(0xFFEFEFEF),
                      child: Text('Upload'),
                      onPressed: () {},
                    )),
                Expanded(flex: 51, child: SizedBox()),
                Expanded(
                    flex: 45,
                    child: FlatButton(
                      color: Color(0xFF04294F),
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                    )),
                Expanded(
                  flex: 175,
                  child: SizedBox(),
                )
              ],
            ),
          ),
        ));
  }
}
