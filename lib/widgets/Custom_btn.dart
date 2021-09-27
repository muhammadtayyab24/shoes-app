import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool loading;

  CustomBtn({
    this.text,
    this.onPressed,
    this.outlineBtn,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;
    bool _loading = loading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _outlineBtn ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.symmetric(vertical: 12.0),
        child: Stack(
          children: [
            Visibility(
              visible: _loading ? false : true,
              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _outlineBtn ? Colors.black : Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: _loading,
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
