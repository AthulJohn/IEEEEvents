import 'package:flutter/material.dart';
import 'package:design/values.dart';
import 'package:design/functions.dart';
import '../FIREBASE/database.dart';
import 'loadingpage.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  bool datecheck = false, firsttry = true, load = false;
  Event addval = Event(0, '', '', DateTime.now(), DateTime.now(), '', []);
  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                          onChanged: (value) {
                            setState(() {
                              addval.name = value;
                            });
                          },
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
                        onChanged: (value) {
                          setState(() {
                            addval.desc = value;
                          });
                        },
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
                                  onPressed: () async {
                                    addval.updatedate = await showDatePicker(
                                        context: context,
                                        initialEntryMode:
                                            DatePickerEntryMode.calendar,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2018),
                                        lastDate: DateTime(2100));
                                    if (addval.updatedate == null)
                                      addval.updatedate = DateTime.now();
                                    setState(() {
                                      datecheck = false;
                                      firsttry = false;
                                    });
                                  },
                                ),
                                Text(
                                  firsttry
                                      ? ''
                                      : '${addval.updatedate.day}-${addval.updatedate.month}-${addval.updatedate.year}',
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
                                firsttry = false;
                                datecheck = value;
                                if (value) addval.updatedate = DateTime.now();
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
                      flex: 32,
                      child: SizedBox(),
                    ),
                    Expanded(
                      child: FlatButton(
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                        color: color[0],
                        onPressed: () async {
                          setState(() {
                            load = true;
                          });
                          List name = ModalRoute.of(context).settings.arguments;

                          setState(() {
                            addval.index = name[1];
                            addval.createdate = DateTime.now();
                          });
                          try {
                            await CloudService(index: name[0]).updateDate(
                              name[0],
                              DateTime.now(),
                            );
                            await CloudService(index: (name[0])).updateactivity(
                                addval.name,
                                addval.desc,
                                addval.createdate,
                                addval.index,
                                addval.updatedate);
                          } catch (e) {
                            print(e);
                          }
                          setState(() {
                            load = false;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      flex: 32,
                    ),
                    Expanded(
                      flex: 164,
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
            ),
          );
  }
}
