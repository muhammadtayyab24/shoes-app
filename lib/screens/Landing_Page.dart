import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/Home.dart';
import 'package:firstapp/screens/authentication/sign-in.dart';
// import 'package:firstapp/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error : ${snapshot.error}"),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${streamSnapshot.error}"),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User _user = streamSnapshot.data;
                  if (_user == null) {
                    return Signin();
                  } else {
                    return HomePage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text("checking authentication..."),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Text("Loading"),
          ),
        );
      },
    );
  }
}
