import 'package:firstapp/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustonInput extends StatelessWidget {
  final String hintText;
  final Function(String) onchanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textinputaction;
  final bool passwordfeild;

  CustonInput({
    this.hintText,
    this.onchanged,
    this.onSubmitted,
    this.focusNode,
    this.textinputaction,
    this.passwordfeild,
  });

  @override
  Widget build(BuildContext context) {
    bool _passwordfield = passwordfeild ?? false;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onchanged,
        onSubmitted: onSubmitted,
        textInputAction: textinputaction,
        obscureText: _passwordfield,
        decoration: InputDecoration(
            hintText: hintText ?? "input",
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            )),
        style: Constant.Regularheading,
      ),
    );
  }
}
