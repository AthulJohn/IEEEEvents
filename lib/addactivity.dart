import 'package:flutter/material.dart';
import 'values.dart';
import 'functions.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  bool datecheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.fromLTRB(25, 0, 39, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 22, child: SizedBox()),
            Expanded(
              flex: 38,
              child: MaterialButton(
                child: Icon(
                  Icons.arrow_back,
                  size: h(38, context),
                ),
                onPressed: () {},
              ),
            ),
            Expanded(
              flex: 48,
              child: SizedBox(),
            ),
            Expanded(
              flex: 25,
              child: Text(
                'Activity Title',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 13,
              child: SizedBox(),
            ),
            Expanded(
                flex: 36,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      fillColor: Color(0xFFEFEFEF)),
                )),
            Expanded(
              flex: 20,
              child: SizedBox(),
            ),
            Expanded(
              flex: 25,
              child: Text(
                'Activity Description',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 13,
              child: SizedBox(),
            ),
            Expanded(
              flex: 144,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    fillColor: Color(0xFFEFEFEF)),
                maxLines: 4,
              ),
            ),
            Expanded(
              flex: 32,
              child: SizedBox(),
            ),
            Expanded(
              flex: 25,
              child: Text(
                'Date',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 13,
              child: SizedBox(),
            ),
            Expanded(
              flex: 36,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Color(0xFFEFEFEF),
                    width: 151,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.calendar_today, size: 15),
                          onPressed: () {
                            setState(() {
                              datecheck = false;
                            });
                          },
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Checkbox(
                    onChanged: (value) {
                      setState(() {
                        datecheck = value;
                      });
                    },
                    activeColor: color[0],
                    value: datecheck,
                  ),
                  Text(
                    'Use Current Date',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 228,
              child: SizedBox(),
            ),
            Expanded(
              flex: 27,
              child: Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Mace Events | IEEE Mace',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFC2C2C2),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Expanded(
              flex: 55,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
