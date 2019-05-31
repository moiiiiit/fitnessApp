import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return (StreamBuilder(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return(Center(child: Text("uh-oh! the entries are\nstill loading...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),));
        } else {
          return Padding( padding: EdgeInsets.fromLTRB(0,20,0,0),
              child: ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot entry = snapshot.data.documents[index];
              String rank = (index+1).toString();
              String name =entry['name'];
              String steps = entry['053019'].toString();
              print("DATA: " + name + steps);
              return (new Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      color: Colors.purple[50],
                      elevation: 1.0,
                      child: Center(child:Padding( padding: EdgeInsets.all(10),
                        child: Text("$rank.    $name:               $steps steps", style: TextStyle(fontSize: 15))
                      ))
                    ),
                  )

              ));
            }
          ));
        }
      },
    ));
  }
}
