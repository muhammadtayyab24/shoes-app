import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/authentication/sign-up.dart';
import 'package:firstapp/screens/constant.dart';
import 'package:firstapp/widgets/Custom_btn.dart';
import 'package:firstapp/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool loginlaoding = false;
  String loginemail = "";
  String loginpassword = "";

  FocusNode passwordFocusNode;
  @override
  void initState() {
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordFocusNode.dispose();
    super.dispose();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _alertDialog(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginemail, password: loginpassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void login() async {
    setState(() {
      loginlaoding = true;
    });
    String addUser = await loginAccount();
    if (addUser != null) {
      _alertDialog(addUser);
      setState(() {
        loginlaoding = false;
      });
    }
  }

  // Future<void> _alertDialog() async {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Text("Error"),
  //           content: Container(
  //             child: Text("there is some error"),
  //           ),
  //           actions: [
  //             FlatButton(
  //               child: Text("close"),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          "Welcome Here \n Login To Your Account",
                          textAlign: TextAlign.center,
                          style: Constant.BoldHeading,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Column(
                        children: [
                          CustonInput(
                            hintText: "Email",
                            onchanged: (value) {
                              loginemail = value;
                            },
                            onSubmitted: (value) {
                              passwordFocusNode.requestFocus();
                            },
                            textinputaction: TextInputAction.next,
                          ),
                          CustonInput(
                            hintText: "Password",
                            onchanged: (value) {
                              loginpassword = value;
                            },
                            focusNode: passwordFocusNode,
                            onSubmitted: (value) {
                              login();
                            },
                            passwordfeild: true,
                          ),
                          CustomBtn(
                            text: "Login",
                            onPressed: () {
                              login();
                            },
                            loading: loginlaoding,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomBtn(
                        text: "Create New Account",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup(),
                            ),
                          );
                        },
                        outlineBtn: true,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
