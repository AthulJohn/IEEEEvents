import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class Event {
  int index;
  String name;
  DateTime createdate;
  DateTime updatedate;
  String desc;
  String theme;
  int active;
  List<File> images;
  Event(this.index, this.name, this.desc, this.createdate, this.updatedate,
      this.theme, this.images,
      {this.active = 0});
}

Future<bool> logincheck() async {
  FirebaseUser user;
  var _auth = FirebaseAuth.instance;
  user = await _auth.currentUser();
  if (user != null)
    return true;
  else
    return false;
}

double h(double no, context) {
  return no * (MediaQuery.of(context).size.height) / 812;
}

double w(double no, context) {
  return no * (MediaQuery.of(context).size.width) / 375;
}

Future<bool> testcon() async {
  {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      // print('Executed');
      return false;
    }
  }
  return false;
}

int getl(List lst) {
  if (lst == null)
    return 0;
  else
    return lst.length;
}