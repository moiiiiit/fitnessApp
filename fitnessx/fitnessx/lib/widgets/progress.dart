import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}


class Dependencies {

  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class Progress extends StatefulWidget{
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress>{
  static int _steps = 0;
  static int _goal=10000;
  static List<String> letters = ["Completed","Remaining"];
  static List<double> words = [_steps/1.0,_goal-_steps/1.0];
  Map<String, double> dataMapX = new Map.fromIterables(letters, words);
  final Dependencies dependencies = new Dependencies();
  
  @override
  void initState(){
    super.initState();
    var me = Firestore.instance.collection('users').document('mohitbhole').get();
  }
  
  void stopButtonPressed() {
    print("stop pressed" + dependencies.stopwatch.elapsedMilliseconds.toString());
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsedMilliseconds}");
        setState(() {
          _steps = _steps + dependencies.stopwatch.elapsed.inSeconds;
          letters = ["Completed","Remaining"];
          words = [_steps/1.0,_goal-_steps/1.0];
          dataMapX = new Map.fromIterables(letters, words);
        });
        print(_steps);
        dependencies.stopwatch.reset();
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.reset();
      }
    });
  }

  void startButtonPressed() {
    print("start pressed" + dependencies.stopwatch.elapsedMilliseconds.toString());
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return( StreamBuilder(
        stream: Firestore.instance.document('mohitbhole').snapshots(),
    builder: (context, snapshot) { return(Column(
            children: [
                  new Padding(padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Text("Walk more to beat your friends in the leaderboard" , style: TextStyle(fontSize: 15),),
                      Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20) ,child: Column(
                      children: [new Text(
                          "Time Elapsed: ${dependencies.stopwatch.elapsed}",
                          style: TextStyle(color: Colors.deepPurple ,fontWeight: FontWeight.w500, fontSize: 20)
                      ), Center(
                        child: Text(
                            "Steps: ${dependencies.stopwatch.elapsed.inSeconds}",
                            style: TextStyle(color: Colors.deepPurple ,fontWeight: FontWeight.w500, fontSize: 20)
                        )
                      )
                      ])),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
                          child: new Material(
                              color: Colors.white,
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color: Colors.purpleAccent,
                                    borderRadius: new BorderRadius.only(
                                        topLeft:  const  Radius.circular(20.0),
                                        topRight: const  Radius.circular(20.0),
                                        bottomLeft:  const  Radius.circular(20.0),
                                        bottomRight:  const  Radius.circular(20.0))
                                ),
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: (){startButtonPressed();},
                                    child: Padding(padding: EdgeInsets.all(10), child: Text(
                                        "Start/Pause Exercise",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    )),
                              )
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
                          child: new Material(
                          color: Colors.white,
                          child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: new BorderRadius.only(
                                    topLeft:  const  Radius.circular(20.0),
                                    topRight: const  Radius.circular(20.0),
                                    bottomLeft:  const  Radius.circular(20.0),
                                    bottomRight:  const  Radius.circular(20.0))
                            ),
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: (){stopButtonPressed();},
                                child: Padding(padding: EdgeInsets.all(10), child: Text(
                                    "Stop Exercise",
                                  style: TextStyle(color: Colors.white)
                                ),
                                )),
                          )
                          )
                      ),
                    ]
                    ),
                    Center(
                    child: Text(
                              "Keep up the good work!\n"
                                ,style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                                  textAlign: TextAlign.center,
                            )),
                    ])
                    ),

              new Padding(padding: EdgeInsets.fromLTRB(20,20,20,20),
                  child: new Material(
                      child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: new BorderRadius.only(
                                  topLeft:  const  Radius.circular(20.0),
                                  topRight: const  Radius.circular(20.0),
                                  bottomLeft:  const  Radius.circular(20.0),
                                  bottomRight:  const  Radius.circular(20.0))
                          ),
                          child:  Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  children: [
                                    Text("today's steps", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                                    PieChart(
                                      dataMap: dataMapX,
                                      legendFontColor: Colors.blueGrey[900],
                                      legendFontSize: 14.0,
                                      legendFontWeight: FontWeight.w500,
                                      animationDuration: Duration(milliseconds: 800),
                                      chartLegendSpacing: 32.0,
                                      chartRadius: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2.7,
                                      showChartValuesInPercentage: false,
                                      showChartValues: false,
                                      chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
                                    ),
                                  ])
                          )
                      )
                  )
              ),

            ]
    ));})
    );
  }
}