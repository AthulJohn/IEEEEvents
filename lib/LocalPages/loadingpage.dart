import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../values.dart';
import '../functions.dart';

class Loading extends StatelessWidget {
  final List<String> toshow = [
    'did you know that IEEE publishes approximately 200 transactions, journals, and magazines.',
    'did you know that IEEE has over 1,200 active standards and more than 650 standards under development.',
    'There are more than 419,000 IEEE members in over 160 countries',
    'did you know that IEEE publishes nearly a third of the world’s technical literature in electrical engineering, computer science, and electronics',
    'did you know that in the 1980s, an IBM computer wasn’t considered 100% compatible unless it could run Microsoft Flight Simulator',
    'did you know that the first computer mouse was invented by Doug Engelbart in around 1964 and was made of wood.',
    'did you know that Google actually have a "Wedding Planner" site.',
    'did you know that every minute, 300 hours of video are uploaded on YouTube.',
    'did you know that Apple makes their employees work on fake projects until they can be trusted.',
    'did you know that Twitter, Wikipedia, and AOL IM all crashed at 3:15pm the day Michael Jackson died.',
    'did you know that the word engineer comes from a Latin word meaning ‘cleverness’.',
    'did you know that the Mechanical Engineering branch in Engineering is called as Father, Mother, and King of all braches.',
    'did you know that Petroleum Engineering is the highest paid job in India and around the globe?',
    'did you know that Civil Engineering is the oldest branch of Engineering.',
    'did you know that Engineering is heavily involved in sports.',
    'did you know that the Engineers in Canada receive an Iron Ring to remind them to have humility. It is in memory of a bridge that collapsed twice due to incorrect calculations involving iron.'
  ];
  final Random rand = Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: color[0],
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '...Please Wait...\nSome processes may take more time',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: 15),
            ),
            SizedBox(height: h(20, context)),
            SpinKitDoubleBounce(
              color: Colors.white,
              size: h(100, context),
            ),
            SizedBox(
              height: h(20, context),
            ),
            Text(
              'By the Way, ${toshow[rand.nextInt(toshow.length)]}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20,
              ),
            )
          ]),
    );
  }
}
