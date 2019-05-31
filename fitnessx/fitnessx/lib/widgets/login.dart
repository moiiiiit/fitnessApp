import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget{
  loginOverlay(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Login();
    }
    );
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  String signInState = "not signed in";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();



  Future<FirebaseUser> _signIn() async{
    print("Login button pressed.");

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);

    if(user.displayName!=null){
      setState(() {
        signInState = "SIGNED IN!\nHello, " + user.displayName +"!";
      });
    }
    else{
      setState(() {
        signInState = "not signed in";
      });
    }
    print("signed in " + user.displayName);

    print("Username" + user.displayName);
    return(user);
  }

  void _signout(){
    googleSignIn.signOut();
    print("User has signed out");
    setState(() {
      signInState = "not signed in";
    });
  }

  @override
  Widget build(BuildContext context) {
    return(
        Column(
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  "status: $signInState",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
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
                            onTap: (){_signIn().then((FirebaseUser user)=>(print(user))).catchError((e)=>print(e));},
                            child: Padding(padding: EdgeInsets.all(10), child: Text(
                                "login with google",
                                  style: TextStyle(color: Colors.white),
                            ),
                            )),
                      )
                  )
            ),
            ])
    );
  }
}