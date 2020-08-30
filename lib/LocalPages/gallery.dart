import 'package:cached_network_image/cached_network_image.dart';
import 'package:design/Widgets/RoundButton.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'package:flutter/services.dart';
import '../functions.dart';
import '../Storage/database.dart';

class Gallery extends StatefulWidget {
  final name, theme;
  Gallery(this.name, this.theme);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<String> images, temp;
  bool menu = false;
  double current = 1;

  PageController cont = PageController(initialPage: 0);

  void getimages() async {
    temp = await CloudService().getimage(widget.name);
    if (this.mounted)
      setState(() {
        images = temp;
        menu = true;
      });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    getimages();
    cont.addListener(() {
      setState(() {
        current = cont.page + 1;
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color(0xFF04294F),
          title: Text('Gallery'),
        ),
        body: images == null
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        menu = menu ? false : true;
                      });
                    },
                    child: PageView.builder(
                      controller: cont,
                      itemCount: images.length == 0 ? 1 : images.length,
                      itemBuilder: (BuildContext context, int index) => Center(
                        child: index == 0
                            ? Hero(
                                tag: '0',
                                child: PhotoView(
                                  imageProvider: CachedNetworkImageProvider(
                                    widget.theme,
                                  ),
                                  initialScale:
                                      PhotoViewComputedScale.contained,
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.contained,
                                ),
                              )
                            : PhotoView(
                                imageProvider: CachedNetworkImageProvider(
                                  images[index],
                                ),
                                initialScale: PhotoViewComputedScale.contained,
                                minScale: PhotoViewComputedScale.contained,
                                maxScale: PhotoViewComputedScale.contained,
                              ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: menu ? 1 : 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RoundButton(
                                icon: Icon(Icons.keyboard_arrow_left),
                                size: 30,
                                onpressed: () {
                                  cont.previousPage(
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                                color: Colors.grey.withOpacity(0.5)),
                            RoundButton(
                                icon: Icon(Icons.keyboard_arrow_right),
                                size: 30,
                                onpressed: () {
                                  cont.nextPage(
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.fastLinearToSlowEaseIn);
                                },
                                color: Colors.grey.withOpacity(0.5)),
                          ],
                        ),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 15),
                            margin: EdgeInsets.symmetric(
                                horizontal: w(100, context)),
                            child: Text(images.length == 0
                                ? '${current.toInt()} / 1'
                                : '${current.toInt()} / ${images.length}'))
                      ],
                    ),
                  )
                ],
              ));
  }
}
