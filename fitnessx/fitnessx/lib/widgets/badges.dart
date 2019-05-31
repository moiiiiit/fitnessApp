import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Badge extends StatefulWidget {
  badgeOverlay(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Badge();
    }
    );
  }

  @override
  _BadgeState createState() => _BadgeState();
}

class _BadgeState extends State<Badge> {
  @override
  Widget build(BuildContext context) {
    return (StreamBuilder(
      stream: Firestore.instance.collection('rewards').snapshots(),
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
                    String desc = entry['desc'];
                    print("DATA: " + name + desc);
                    return (new Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Material(
                              color: Colors.purple[50],
                              elevation: 1.0,
                              child: Center(child:Padding( padding: EdgeInsets.all(10),
                                  child: Text("$rank.    $name:\n$desc", style: TextStyle(fontSize: 15))
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
