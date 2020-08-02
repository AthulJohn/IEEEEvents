import 'package:flutter/material.dart';
import '../FIREBASE/database.dart';
import 'loadingpage.dart';
import '../Widgets/RoundButton.dart';
import '../functions.dart';
import '../values.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool load = false;
  Event addval =
      Event(0, '', '', DateTime.now(), DateTime.now(), '', [], 0, mace: false);
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null)
      setState(() {
        _image = File(pickedFile.path);
        addval.images.add(_image);
      });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex: 22),
                    Expanded(
                        child: RoundButton(
                            color: color[0],
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onpressed: () {
                              Navigator.pop(context);
                            },
                            size: h(50, context)),
                        flex: 38),
                    Expanded(child: SizedBox(), flex: 30),
                    Expanded(child: Text('Event Name'), flex: 19),
                    Expanded(child: SizedBox(), flex: 13),
                    Expanded(
                        flex: 32,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              addval.name = value;
                            });
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
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
                          onChanged: (value) {
                            setState(() {
                              addval.desc = value;
                            });
                          },
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFEFEFEF)),
                        )),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(
                        flex: 19,
                        child: Row(
                          children: <Widget>[
                            Text('Event by MACE'),
                            Checkbox(
                                value: addval.mace,
                                onChanged: (val) {
                                  setState(() {
                                    addval.mace = val;
                                  });
                                })
                          ],
                        )),
                    // Expanded(
                    //     flex: 32,
                    //     child: Container(child:Row(children: <Widget>[IconButton(icon: Icon(Icons.calendar_today), onPressed: null),Text(addval.updatedate)],),),TextField(
                    //       decoration: InputDecoration(
                    //           filled: true,
                    //           border: InputBorder.none,
                    //           fillColor: Color(0xFFEFEFEF)),
                    //     )),
                    Expanded(flex: 37, child: SizedBox()),
                    Expanded(
                      flex: 150,
                      child: Stack(children: <Widget>[
                        addval.images.length == 0
                            ? Center(
                                child: Text(
                                    'Add Images here,\nTap on the camera to add an image.\nDelete an Image by tapping the image.\nThe first Image you add will be considered as title Image',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[400])))
                            : Container(),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: GridView(
                              padding: EdgeInsets.all(8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              children: [
                                for (int i = 0; i < addval.images.length; i++)
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    // height: 30,
                                    child: Stack(
                                      children: <Widget>[
                                        Image.file(addval.images[i],
                                            fit: BoxFit.cover),
                                        Container(
                                          child: IconButton(
                                              color: Colors.white,
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: Colors.white70,
                                                size: 40,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  addval.images.removeAt(i);
                                                });
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: getImage,
                                    child: Icon(Icons.add_a_photo, size: 50))
                              ],
                            )),
                      ]),
                    ),
                    // Expanded(flex: 19, child: Text('Background Image')),
                    // Expanded(flex: 13, child: SizedBox()),
                    // Expanded(
                    //     flex: 49,
                    //     child: Row(
                    //       children: <Widget>[
                    //         FlatButton(
                    //           color: Color(0xFFEFEFEF),
                    //           child: Text('Upload'),
                    //           onPressed: getImage,
                    //         ),
                    //         Text('')
                    //       ],
                    //     )),
                    Expanded(flex: 24, child: SizedBox()),
                    Expanded(
                      flex: 45,
                      child: Builder(builder: (BuildContext ctxt) {
                        return FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xFF04294F),
                          child: Text('Submit',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            bool con = await testcon();
                            if (con) {
                              setState(() {
                                load = true;
                              });
                              try {
                                await CloudService(
                                        index: (ModalRoute.of(context)
                                                .settings
                                                .arguments)
                                            .toString())
                                    .updateData(
                                        addval.name,
                                        addval.desc,
                                        addval.createdate,
                                        addval.updatedate,
                                        ModalRoute.of(context)
                                            .settings
                                            .arguments,
                                        addval.images,
                                        addval.mace);
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
                        );
                      }),
                    ),
                    Expanded(
                      flex: 25,
                      child: SizedBox(),
                    )
                  ],
                ),
              ),
            ));
  }
}
