import 'package:flutter/material.dart';

class LeaderBoard extends StatefulWidget{
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard>{

  @override
  Widget build(BuildContext context) {
    return(
        Column(
            children: [new Padding(padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: new Material(
                    color: Colors.white,
                    child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.cyan[100],
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
                                  Text("Leaderboard", style: TextStyle(fontWeight: FontWeight.w600))
                                ])
                        )
                    )
                )
            ),
            new Padding(padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                                  Row(
                                  children: [Padding(padding: EdgeInsets.symmetric(horizontal: 10),child :Text("1.", style: TextStyle(fontWeight: FontWeight.w600))),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),child :Text("You", style: TextStyle(fontWeight: FontWeight.w600))),
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 100),child :Text("9000 steps", style: TextStyle(fontWeight: FontWeight.w600)))
                                  ]
                                  )
                                ])
                        )
                    )
                )
            ),
                    ])
    );
  }
}