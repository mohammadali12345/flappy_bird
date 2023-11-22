import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/barriers.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis=0;
  double time=0;
  double height=0;
  double gravity =-4.9;
  double velocity=2.5;
  double initialHeight =birdYaxis;
  double birdWidth =0.1;
  double birdHeight=0.1;
  bool gameHasStarted =false;


  static List<double> barrierX = [1, 1 + 1.5, 1 + 2.0, 2 + 3.5];
  static double barrierWidth = 0.25;
  List<List<double>> barrierHieght = [
    [0.6, 0.4],
    [0.3, 0.7],
    [0.5, 0.5],
    [0.4, 0.6],
  ];

  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight= birdYaxis;
    });
  }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder:( BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(7),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),

              )
            ],
          );

    });
  }
  void jump(){
    setState(() {
      time=0;
      initialHeight=birdYaxis;

    });





  }

  void startGame(){
    gameHasStarted =true;
    Timer.periodic(Duration(milliseconds: 50),(timer) {


      height = gravity * time * time + velocity * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });




      if (birdIsDead()) {
        timer.cancel();
         _showDialog();
       }
      moveMap();
      time +=0.04;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.03;
      });
    }
  }


  bool birdIsDead(){
    if (birdYaxis < -1 || birdYaxis > 1) {

      return true;

    }
    for(int i=0;i<barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdYaxis <= -1 + barrierHieght[i][0] ||
              birdYaxis + birdHeight >= 1 - barrierHieght[i][1])) {
        return true;
      }
    }
      return false;

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted? jump : startGame,
      child:Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child:Container(
              color: Colors.blue,
              child: Center(
                child:Stack(
                    children: [
                      MyBird(
                        birdYaxis: birdYaxis,
                          birdWidth: birdWidth,
                          birdHedight: birdHeight,
                      ),
                      Container(
                        alignment: Alignment(0,-0.5),
                        child: Text(
                          gameHasStarted ?'':
                          'T A P  T O  P L A Y'
                          ,
                          style: TextStyle(
                          color:Colors.white,
                            fontSize: 20,
                          ),),
                      ),
                      // MyCoverScreen(gameHasStarted:gameHasStarted),


                      //top barrier 0
                      MyBarrier(
                          barrierX:barrierX[0],
                          barrierWidth: barrierWidth,
                          barrierHeight: barrierHieght[0][0],
                          isThisBottomBarrier:false,
                      ),
                      //bottom barrier 0
                      MyBarrier(
                        barrierX:barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[0][1],
                        isThisBottomBarrier:true,
                      ),
                      //top 1
                      MyBarrier(
                        barrierX:barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[1][0],
                        isThisBottomBarrier:false,
                      ),
                      //bottom 1
                      MyBarrier(
                        barrierX:barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[1][1],
                        isThisBottomBarrier:true,
                      ),
                      //top 2
                      MyBarrier(
                        barrierX:barrierX[2],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[2][0],
                        isThisBottomBarrier:false,
                      ),

                      //bottom 2
                      MyBarrier(
                        barrierX:barrierX[2],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[2][1],
                        isThisBottomBarrier:true,
                      ),
                      //top 3
                      MyBarrier(
                        barrierX:barrierX[3],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[3][0],
                        isThisBottomBarrier:false,
                      ),
                      //bottom 3
                      MyBarrier(
                        barrierX:barrierX[3],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHieght[3][1],
                        isThisBottomBarrier:true,
                      ),
                    ],

              ),
            ),
            ),
          ),

          //   )
          // ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SCORE",style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(height: 20,),
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 35)),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BEST",style: TextStyle(color: Colors.white,fontSize: 20)),
                    SizedBox(height: 20,),
                    Text("10",style: TextStyle(color: Colors.white,fontSize: 35)),
                  ],
                )
              ],),
            ),
          ),
        ],
      ),
    ),)
    ;
  }
}
