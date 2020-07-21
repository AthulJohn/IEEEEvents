import 'package:design/Appload/apploadcos.dart';
import 'package:design/Appload/apploadcs.dart';
import 'Appload/apploadcs.dart';
import 'dart:math';
import 'package:flutter/material.dart';

List<Color> color = [Color(0xFF04294F)];
Random rand = Random();
List loads = [
  [MainLoad(), 5500],
  [CosLoad(), 6400]
];
int no = rand.nextInt(loads.length);
Widget homeWidget = loads[no][0];
int dura = loads[no][1];
