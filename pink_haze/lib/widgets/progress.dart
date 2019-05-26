import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';

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


  void stopButtonPressed() {
    print("stop pressed" + dependencies.stopwatch.elapsedMilliseconds.toString());
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsedMilliseconds}");
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
    return(
        Column(
            children: [new Padding(padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  child: new Material(
                  color: Colors.white,
                  child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey[200],
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
                                Text("Steps", style: TextStyle(fontWeight: FontWeight.w600)),
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
                  new Padding(padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      Container(
                      child: Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 20) ,child:
                      new Text(
                        "Time Elapsed: ${dependencies.stopwatch.elapsed}",
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)
                      ))
                      ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(20.0,0.0,20.0,20.0),
                          child: new Material(
                              color: Colors.white,
                              child: new Container(
                                decoration: new BoxDecoration(
                                    color: Color(0xff00e676),
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
                                        "Start/Pause Exercise"
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
                                color: Color(0xff00e676),
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
                                    "Stop Exercise"
                                ),
                                )),
                          )
                          )
                      ),
                    ]
    ),
                    Center(
                    child: Text(
    "Keep up the good work!\nExercise more to beat your friends in the leaderboard"
        ,style: TextStyle(fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
    )),
    ])
    )]
    )
    );
  }
}