import 'package:flutter/material.dart';
import '../values.dart';
import '../functions.dart';
import '../FIREBASE/database.dart';
import 'loadingpage.dart';

class Update extends StatefulWidget {
  final Event event;
  final List<Event> activities;
  Update(this.event, this.activities);
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  bool switchvalue, load = false;
  List<Event> activities;
  List<TextEditingController> desccontrol = [], namecontrol = [];
  Event addval;
  @override
  void initState() {
    super.initState();
    switchvalue =
        widget.event.active == 1 || widget.event.active == null ? true : false;
    activities = widget.activities ?? [];
    desccontrol.add(TextEditingController(text: widget.event.desc));
    for (int i = 0; i < activities.length; i++) {
      desccontrol.add(TextEditingController(text: activities[i].desc));
      namecontrol.add(TextEditingController(text: activities[i].name));
    }
    addval = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: SizedBox(), flex: 22),
                  Expanded(
                    flex: 38,
                    child: MaterialButton(
                      child: Icon(Icons.arrow_back, size: 38),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: SizedBox(),
                  ),
                  Expanded(
                      flex: 672,
                      child: ListView.builder(
                        itemCount: getl(activities) + 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.fromLTRB(30, 15, 30, 33),
                              child: index == 0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                          Container(
                                            height: 23,
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  'Event Active',
                                                  style:
                                                      TextStyle(fontSize: 16),
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
                                            child: Text('${addval.name}',
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
                                              onChanged: (value) {
                                                setState(() {
                                                  addval.desc = value;
                                                });
                                              },
                                              controller: desccontrol[0],
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
                                          ),
                                          Container(
                                              margin: EdgeInsets.all(10),
                                              height: 42,
                                              child: FlatButton(
                                                child: Text('Change'),
                                                onPressed: () {},
                                              )),
                                        ])
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${getl(activities) + 1 - index}',
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
                                          controller: namecontrol[index - 1],
                                          onChanged: (value) {
                                            setState(() {
                                              activities[index - 1].name =
                                                  value;
                                            });
                                          },
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
                                          controller: desccontrol[index],
                                          onChanged: (value) {
                                            setState(() {
                                              activities[index - 1].desc =
                                                  value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: InputBorder.none,
                                              fillColor: Color(0xFFEFEFEF)),
                                          maxLines: 4,
                                        ),
                                      ],
                                    ));
                        },
                      )),
                  Expanded(
                    flex: 60,
                    child: Container(
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: FlatButton(
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              load = true;
                              addval.active = switchvalue ? 1 : 0;
                            });
                            try {
                              await CloudService().editData(addval, activities);
                            } catch (e) {
                              print(e);
                            }
                            setState(() {
                              load = false;
                            });
                            Navigator.pop(context);
                          },
                          color: color[0],
                        )),
                  ),
                ],
              ),
            ),
          );
  }
}
