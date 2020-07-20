import 'package:design/functions.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MainLoad extends StatefulWidget {
  @override
  _MainLoadState createState() => _MainLoadState();
}

class _MainLoadState extends State<MainLoad> {
  List rotate = ['|', '/', '-', '\\'];
  List<TextSpan> waiting = [];
  bool conection = false;
  Future increase() async {
    await Future.delayed(
      Duration(
        milliseconds: 2600,
      ),
    );
    for (int i = 0; i <= 10; i++) {
      setState(() {
        waiting = [
          TextSpan(
              text: '\n>>>Loading [${i * 10 + (10 - i)}%]  ${rotate[(i) % 4]}',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: w(15, context),
                  fontFamily: 'bitfont'))
        ];
      });
      await Future.delayed(Duration(milliseconds: 100));
    }
    conection = await testcon();

    if (conection) {
      setState(() {
        waiting += [
          TextSpan(
              text: '\n\n>>>\n\n>>>BUILD SUCCESS\n\n>>>\n\n>>>WELCOME!',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: w(15, context),
                  fontFamily: 'bitfont'))
        ];
      });
    } else {
      setState(() {
        waiting += [
          TextSpan(
              text:
                  "\n\n>>>\n\n>>>CONNECTION LOST!\n\n>>>\n\n>>>Please check your phone's internet connection and try again... ",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: w(15, context),
                  fontFamily: 'bitfont'))
        ];
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
                      fontSize: w(
                        15,
                        context,
                      ),
                      fontFamily: 'bitfont'),
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
            RichText(
              text: TextSpan(children: waiting),
            )
          ],
        ));
  }
}
