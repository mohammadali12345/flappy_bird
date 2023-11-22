import 'package:flutter/material.dart';


class MyBird extends StatelessWidget {
  final birdYaxis;
  final double birdWidth;
  final double birdHedight;


  MyBird({this.birdYaxis,required this.birdWidth,required this.birdHedight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2 *birdYaxis + birdHedight) / (2 - birdHedight)),


        child:Image.asset(
          'lib/images/flappybird.png',
          width: MediaQuery.of(context).size.height * birdWidth,
          height: MediaQuery.of(context).size.height * 3/4 * birdHedight,
          fit: BoxFit.fill,
    )
    );
  }
}
