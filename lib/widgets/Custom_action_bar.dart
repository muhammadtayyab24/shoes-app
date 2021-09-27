import 'package:firstapp/screens/constant.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final bool backarrow;
  final String title;
  final bool hastitle;
  CustomActionBar({this.backarrow, this.title, this.hastitle});

  @override
  Widget build(BuildContext context) {
    bool _backarrow = backarrow ?? false;
    bool _hastitle = hastitle ?? true;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.6),
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
        ),
      ),
      padding: EdgeInsets.only(
        top: 24.0,
        left: 24.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_backarrow)
            Container(
              alignment: Alignment.center,
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Icon(
                Icons.arrow_back,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          if (_hastitle)
            Text(
              title ?? "Action Bar",
              style: Constant.BoldHeading,
            ),
          Container(
            alignment: Alignment.center,
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
            child: Text("0",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }
}
