import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:design/values.dart';

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Center(
          //   child: Image.asset(
          //     'assets/onyx(3).png',
          //     fit: BoxFit.contain,
          //   ),
          // ),
          Container(),
          Container(
            child: TextLiquidFill(
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 90),
              text: "IEEE",
              boxBackgroundColor: Colors.white,
              loadDuration: Duration(milliseconds: 4000),
              waveColor: color[0],
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color[0]),
          ),
          // child: ColorizeAnimatedTextKit(
          //   // pause: Duration(seconds: 0),
          //   speed: Duration(milliseconds: 500),
          //   textAlign: TextAlign.center,
          //   colors: [
          //     Colors.white,
          //     color[0].withOpacity(0.6),
          //     Colors.transparent,
          //   ],
          //   textStyle: TextStyle(fontSize: 100, color: color[0]),
          //   text: ["IEEE", "events"],
          // ),
        ],
      ),
    );
  }
}
