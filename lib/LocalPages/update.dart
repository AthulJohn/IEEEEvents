import 'package:flutter/material.dart';
import '../values.dart';
import '../functions.dart';
import '../FIREBASE/database.dart';
import 'loadingpage.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  List<String> temp, images;
  List<int> removed = [];
  List<File> added = [];
  void getimages() async {
    temp = await CloudService().getimage(widget.event.name);
    if (this.mounted)
      setState(() {
        images = temp;
      });
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null)
      setState(() {
        _image = File(pickedFile.path);
        added.add(_image);
      });
  }

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
    getimages();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
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
                        itemCount: getl(activities) + 2,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.fromLTRB(30, 15, 30, 33),
                              child: index == getl(activities) + 1
                                  ? Container(height: h(180, context))
                                  : index == 0
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
                                                      style: TextStyle(
                                                          fontSize: 16),
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
                                                    style: TextStyle(
                                                        fontSize: 32)),
                                              ),
                                              Container(
                                                height: 15,
                                                child: SizedBox(),
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
                                                height: 10,
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                height: 110,
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
                                                      fillColor:
                                                          Color(0xFFEFEFEF)),
                                                  maxLines: 4,
                                                ),
                                              ),
                                              Container(
                                                height: 10,
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                height: 22,
                                                child: Text(
                                                  'Images',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 10,
                                                child: SizedBox(),
                                              ),
                                              Container(
                                                height: 100,
                                                child: Stack(children: <Widget>[
                                                  getl(images) + getl(added) ==
                                                          0
                                                      ? Center(
                                                          child: Text(
                                                              'Add Images here,\nTap on the camera to add an image.\nDelete an Image by tapping the image.\nThe forst Image you add will be considered as title Image',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      400])))
                                                      : Container(),
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: GridView(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    4),
                                                        children: [
                                                          for (int i = 0;
                                                              i < getl(images);
                                                              i++)
                                                            Container(
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child: Image.network(
                                                                          images[
                                                                              i],
                                                                          fit: BoxFit
                                                                              .cover),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child: IconButton(
                                                                          color: Colors.white,
                                                                          icon: Icon(
                                                                            Icons.delete_outline,
                                                                            color:
                                                                                Colors.white70,
                                                                            size:
                                                                                30,
                                                                          ),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              removed.add(i);
                                                                              images.removeAt(i);
                                                                            });
                                                                          }),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          for (int i = 0;
                                                              i < getl(added);
                                                              i++)
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(8),
                                                              child: Stack(
                                                                children: <
                                                                    Widget>[
                                                                  Image.file(
                                                                      added[i],
                                                                      fit: BoxFit
                                                                          .cover),
                                                                  Container(
                                                                    child: IconButton(
                                                                        color: Colors.white,
                                                                        icon: Icon(
                                                                          Icons
                                                                              .delete_outline,
                                                                          color:
                                                                              Colors.white70,
                                                                          size:
                                                                              40,
                                                                        ),
                                                                        onPressed: () {
                                                                          setState(
                                                                              () {
                                                                            added.removeAt(i);
                                                                          });
                                                                        }),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          FlatButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              onPressed:
                                                                  getImage,
                                                              child: Icon(
                                                                  Icons
                                                                      .add_a_photo,
                                                                  size: 50))
                                                        ],
                                                      )),
                                                ]),
                                              )
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
                                              controller:
                                                  namecontrol[index - 1],
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
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Activity Date',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 13,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFEFEFEF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              width: w(151, context),
                                              child: Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.calendar_today,
                                                        size: 15),
                                                    onPressed: () async {
                                                      activities[index - 1]
                                                          .updatedate = await showDatePicker(
                                                              context: context,
                                                              initialEntryMode:
                                                                  DatePickerEntryMode
                                                                      .calendar,
                                                              initialDate:
                                                                  activities[
                                                                          index -
                                                                              1]
                                                                      .updatedate,
                                                              firstDate:
                                                                  DateTime(
                                                                      2018),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100)) ??
                                                          activities[index - 1]
                                                              .updatedate;
                                                      setState(() {});
                                                    },
                                                  ),
                                                  Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(activities[
                                                                index - 1]
                                                            .updatedate),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ));
                        },
                      )),
                  Expanded(
                    flex: 60,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 5, 0, 5),
                      child: Builder(builder: (BuildContext ctxt) {
                        return FlatButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            bool con = await testcon();
                            if (con) {
                              setState(() {
                                load = true;
                                addval.active = switchvalue ? 1 : 0;
                              });
                              try {
                                await CloudService().editData(
                                    addval, activities, added, removed);
                              } catch (e) {
                                print(e);
                              }
                              setState(() {
                                load = false;
                              });
                              Navigator.pop(context);
                            } else {
                              Scaffold.of(ctxt).showSnackBar(SnackBar(
                                  content:
                                      Text('Oops!, Poor Internet Connection')));
                            }
                          },
                          color: color[0],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
