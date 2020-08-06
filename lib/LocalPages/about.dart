import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../values.dart';
import '../functions.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const maceurl = 'https://ieee.macehub.in/';
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          child: ListView(
            children: <Widget>[
              Text(
                'About IEEE',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'IEEE is the world’s largest professional association dedicated to advancing technological innovation and excellence for the benefit of humanity. IEEE and its members inspire a global community through its highly cited publications, conferences, technology standards, and professional and educational activities. IEEE is the trusted “voice” for engineering, computing and technology information around the globe.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'About IEEE Mace SB',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'IEEE student branch was established in MACE in the year 1988, since then it has always made a hallmark in different concentration levels of IEEE. IEEE SB at Mar Athanasius College of Engineering is one of the largest and promising student branches in Kerala. It is a dedicated partner to shape innovative and high-quality events. IEEE MACE SB offers access to technical innovation, cutting-edge information, and networking opportunities.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'For more about us, visit our Website...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: w(300, context),
                  child: FlatButton(
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: color[0],
                    child: Text(
                      'ieee.macehub.in',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () async {
                      if (await canLaunch(maceurl)) {
                        await launch(maceurl);
                      } else {
                        print("Error");
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}
