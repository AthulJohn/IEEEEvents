import 'package:flutter/material.dart';

double h(double no, context) {
  return no * (MediaQuery.of(context).size.height) / 812;
}

double w(double no, context) {
  return no * (MediaQuery.of(context).size.width) / 375;
}
