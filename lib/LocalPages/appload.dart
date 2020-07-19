import 'package:design/functions.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MainLoad extends StatefulWidget {
  @override
  _MainLoadState createState() => _MainLoadState();
}

class _MainLoadState extends State<MainLoad> {
  String waiting = '';
  Future increase() async {
    await Future.delayed(
      Duration(
        milliseconds: 2250,
      ),
    );
    setState(() {
      waiting = '_';
    });
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        waiting = '.  ' + waiting;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    increase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '>>>',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w(20, context),
                  ),
                ),
                TypewriterAnimatedTextKit(
                    isRepeatingAnimation: false,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: w(15, context),
                        fontFamily: 'bitfont'),
                    text: ['Mace_Events.run()'],
                    speed: Duration(milliseconds: 75))
              ],
            ),
            Text(
              '$waiting',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: w(20, context),
                  fontFamily: 'bitfont'),
            )
          ],
        ));
  }
}
