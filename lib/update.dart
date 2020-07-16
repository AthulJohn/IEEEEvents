import 'package:flutter/material.dart';
import 'functions.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool switchvalue = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Expanded(child: SizedBox(), flex: 22),
        Expanded(
          flex: 38,
          child: MaterialButton(
            child: Icon(Icons.arrow_back, size: 38),
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 15,
          child: SizedBox(),
        ),
        Expanded(
            flex: 732,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 33),
                    child: index == 0
                        ? Column(children: <Widget>[
                            Container(
                              height: 23,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Event Active',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Switch(
                                    value: switchvalue,
                                    onChanged: (value) {
                                      setState(() {
                                        switchvalue = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 15,
                              child: SizedBox(),
                            ),
                            Container(
                              height: 44,
                              child: Text('Macthon',
                                  style: TextStyle(fontSize: 32)),
                            ),
                            Container(
                              height: 22,
                              child: Text(
                                'Event Description',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              height: 15,
                              child: SizedBox(),
                            ),
                            Container(
                              height: 144,
                              child: TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Color(0xFFEFEFEF)),
                                maxLines: 4,
                              ),
                            ),
                            Container(
                              height: 20,
                              child: SizedBox(),
                            ),
                            Container(
                              height: 42,
                              child: Row(
                                children: <Widget>[
                                  Text('Event Background'),
                                  FlatButton(
                                    child: Text('Change'),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            )
                          ])
                        : Column(
                            children: <Widget>[
                              Text(
                                '6',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Activity Title',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Color(0xFFEFEFEF)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Activity Description',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 13,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: Color(0xFFEFEFEF)),
                                maxLines: 4,
                              ),
                            ],
                          ));
              },
            ))
      ],
    ));
  }
}
