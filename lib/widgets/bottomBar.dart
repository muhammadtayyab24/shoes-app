import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int selectedPage;
  final Function(int) tabPress;
  BottomBar({this.selectedPage, this.tabPress});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    selectedTab = widget.selectedPage ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1.0,
            )
          ]),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomBtn(
              imagePath: "assets/images/bottom-home-b.png",
              selected: selectedTab == 0 ? true : false,
              onpressed: () {
                setState(() {
                  widget.tabPress(0);
                });
              },
            ),
            BottomBtn(
              imagePath: "assets/images/search-icon1.png",
              selected: selectedTab == 1 ? true : false,
              onpressed: () {
                setState(() {
                  widget.tabPress(1);
                });
              },
            ),
            BottomBtn(
              imagePath: "assets/images/search-icon1.png",
              selected: selectedTab == 2 ? true : false,
              onpressed: () {
                setState(() {
                  widget.tabPress(2);
                });
              },
            ),
            BottomBtn(
              imagePath: "assets/images/search-icon1.png",
              selected: selectedTab == 3 ? true : false,
              onpressed: () {
                setState(() {
                  widget.tabPress(3);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBtn extends StatelessWidget {
  final String imagePath;
  final bool selected;
  final Function onpressed;
  BottomBtn({this.imagePath, this.selected, this.onpressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 22.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _selected
                    // ignore: deprecated_member_use
                    ? Theme.of(context).accentColor
                    : Colors.transparent),
          ),
        ),
        child: Image(
          height: 26,
          width: 26,
          // ignore: deprecated_member_use
          color: _selected ? Theme.of(context).accentColor : Colors.black,
          image: AssetImage(
            imagePath ?? "assets/images/save-bottom.png",
          ),
        ),
      ),
    );
  }
}
