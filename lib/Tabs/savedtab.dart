import 'package:firstapp/widgets/Custom_action_bar.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: Text("saved Tab"),
          ),
        ),
        CustomActionBar(
          title: "Saved",
        ),
      ],
    );
  }
}
