import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color clr;
  Loading({Key key,@required this.clr});
  @override
  Widget build(BuildContext context) {
    return Container(
      color:clr,
      child:Center(
        child:SpinKitChasingDots(
          color:Colors.white,
          size:50.0
        )
      )
    );
  }
}

class Mainload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:200,
            minHeight: 200,
            maxWidth:300
          ),
          child: Image.asset('assets/appicon.png',fit:BoxFit.fill)),
        SizedBox(height:20),
      Text('MACE Events',style:TextStyle(decoration:TextDecoration.none,fontSize:40,color:Colors.black,fontFamily: 'Font1',)),
      ],)
    );
  }
}