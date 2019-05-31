import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import './pages/exercise_page.dart';
import './pages/friends_page.dart';
import './pages/map_page.dart';
import './widgets/login.dart';
import './widgets/badges.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() =>
  runApp(MaterialApp(home: MainApp()));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    Login loginPage = new Login();
    Badge badgePage = new Badge();
    return Scaffold(
        appBar: PreferredSize(
            child: GradientAppBar(
              backgroundColorStart: Colors.purpleAccent,
              backgroundColorEnd: Colors.deepPurple,
              centerTitle: true,
              title: Text( _page==0 ? "goal" : ( _page==1 ? "leaderboard" : "nearby friends"),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w400,
                  )),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.person, size: 35,),
                  tooltip: 'login',
                  onPressed: () {
                    loginPage.loginOverlay(context);
                    print('Login overlay opened.');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, size: 35,),
                  tooltip: 'badges',
                  onPressed: () {
                    badgePage.badgeOverlay(context);
                    print('Badges overlay opened.');
                  },
                ),
              ],
        ), preferredSize: Size.fromHeight(70.0)),
        body: Container(
              child: _page==0 ? ExercisePage() : ( _page==1 ? FriendsPage() : ProfilePage())
          ),

      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.fitness_center, size: 35, color: Colors.deepPurple,),
          Icon(Icons.people_outline, size: 35, color: Colors.deepPurple,),
          Icon(Icons.map, size: 35, color: Colors.deepPurple,),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.pink[50],
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