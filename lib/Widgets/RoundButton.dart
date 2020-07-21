import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color color;
  final VoidCallback onpressed;
  RoundButton({this.icon, this.size = 50, this.onpressed, this.color});
  @override
  Widget build(BuildContext context) {
    // return Material(
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(20),
    //     onTap: () {},
    //     splashColor: Colors.blue,
    //     highlightColor: Colors.blue,
    //     child: Container(
    //       height: size,
    //       width: size,
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(20),
    //         border: Border.all(color: Colors.grey),
    //       ),
    //       child: Center(
    //         child: icon,
    //       ),
    //     ),
    //   ),
    // );
    return RawMaterialButton(
      fillColor: color ?? Colors.white,
      constraints: BoxConstraints.tight(Size(size, size)),
      splashColor: Colors.white,
      child: icon,
      onPressed: onpressed,
      shape: CircleBorder(), //CircleBorder(),
    );
  }
}
