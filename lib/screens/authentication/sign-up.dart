import 'package:firstapp/screens/authentication/sign-in.dart';
import 'package:firstapp/screens/constant.dart';
import 'package:firstapp/widgets/Custom_btn.dart';
import 'package:firstapp/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool registerlaoding = false;

  String registeremail = "";
  String registerpassword = "";

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

  Future<String> createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registeremail, password: registerpassword);
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

  void register() async {
    setState(() {
      registerlaoding = true;
    });
    String addUser = await createAccount();
    if (addUser != null) {
      _alertDialog(addUser);
      setState(() {
        registerlaoding = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Text(
                  "Create New Account",
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
                      registeremail = value;
                    },
                    onSubmitted: (value) {
                      passwordFocusNode.requestFocus();
                    },
                    textinputaction: TextInputAction.next,
                  ),
                  CustonInput(
                    hintText: "Password",
                    onchanged: (value) {
                      registerpassword = value;
                    },
                    focusNode: passwordFocusNode,
                    onSubmitted: (value) {
                      register();
                    },
                    passwordfeild: true,
                  ),
                  CustomBtn(
                    text: "Register",
                    onPressed: () {
                      register();
                      // setState(() {
                      //   registerlaoding = true;
                      // });
                    },
                    loading: registerlaoding,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomBtn(
                text: "Bck To Login ",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signin(),
                    ),
                  );
                },
                outlineBtn: true,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
