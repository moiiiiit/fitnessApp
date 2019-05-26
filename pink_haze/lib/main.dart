import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './pages/exercise_page.dart';
import './pages/friends_page.dart';
import './pages/profile_page.dart';

void main() => runApp(MaterialApp(home: MainApp()));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text('Sample Code'),
//        ),

        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 140.0,
                backgroundColor: Color(0xff00e676),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text( _page==0 ? "GOAL" : ( _page==1 ? "FRIENDS" : "PROFILE"),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                    background: Image.asset(
                      "images/Image001.jpg",
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fitWidth,
                    )),
              ),
            ];
          },
          body: Container(
            child: _page==0 ? ExercisePage() : ( _page==1 ? FriendsPage() : ProfilePage())
          )//_page==0 ? "GOAL" : ( _page==1 ? "FRIENDS" : "PROFILE",
        ),

        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: 70.0,
          items: <Widget>[
            Icon(Icons.fitness_center, size: 30),
            Icon(Icons.people_outline, size: 30),
            Icon(Icons.person_outline, size: 30),
          ],
          color: Color(0xffb9f6ca),
          buttonBackgroundColor: Color(0xff00e676),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
    );
  }
}