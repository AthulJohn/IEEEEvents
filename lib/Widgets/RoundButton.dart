import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color color;
  final VoidCallback onpressed;
  final double elevation;
  RoundButton(
      {this.icon, this.size = 50, this.onpressed, this.color, this.elevation});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: elevation ?? 3,
      fillColor: color ?? Colors.white,
      constraints: BoxConstraints.tight(Size(size, size)),
      splashColor: Colors.white,
      child: icon,
      onPressed: onpressed,
      shape: CircleBorder(), //CircleBorder(),
    );
  }
}
