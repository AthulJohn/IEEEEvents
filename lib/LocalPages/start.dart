import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:design/functions.dart';
import '../values.dart';

// import 'package:design/values.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  // bool conn = true;
  // void checkConnection() async {
  //   conn = await testcon();
  //   setState(() {
  //     conn = conn;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   checkConnection();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color[2],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 18,
            child: SizedBox(),
          ),
          Expanded(
            flex: 17,
            child: Text(
              'IEEE\nEvents',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: h(80, context),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: SizedBox(),
          ),
          Expanded(
            flex: 3, // conn ? 3 : 10,
            // child: AnimatedCrossFade(
            //   duration: Duration(milliseconds: 500),
            //   crossFadeState:
            //       conn ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            //   secondChild: Container(
            //     margin: EdgeInsets.symmetric(horizontal: w(30, context)),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
            //         Icon(
            //           Icons.error,
            //           color: Colors.red,
            //         ),
            //         Text(
            //           'Oops, Looks like you are not having good internet connection. Please try after sometime.',
            //           textAlign: TextAlign.center,
            //         )
            //       ],
            //     ),
            //   ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Joy of ',
                  style: TextStyle(
                    fontSize: h(25, context),
                  ),
                ),
                Container(
                  width: w(135, context),
                  child: RotateAnimatedTextKit(
                      totalRepeatCount: 1,
                      textStyle: TextStyle(
                        fontSize: h(25, context),
                      ),
                      pause: Duration(microseconds: 0),
                      duration: Duration(
                        milliseconds: 625,
                      ),
                      text: [
                        '',
                        'Involvement',
                        'Exploration',
                        'Engagement',
                        'Execution',
                        'Volunteering',
                      ]),
                )
              ],
            ),
          ),
          //),
          Expanded(child: SizedBox(), flex: 12) // conn ? 12 : 5)
        ],
      ),
    );
  }
}
