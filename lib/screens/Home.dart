import 'package:firstapp/Tabs/HomeTab.dart';
import 'package:firstapp/Tabs/UserTab.dart';
import 'package:firstapp/Tabs/savedtab.dart';
import 'package:firstapp/Tabs/searchtab.dart';
import 'package:firstapp/widgets/bottomBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabpagecontroller;
  int _selectedPage = 0;

  @override
  void initState() {
    _tabpagecontroller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabpagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _tabpagecontroller,
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
              UserTab(),
            ],
          ),
        ),
        BottomBar(
          selectedPage: _selectedPage,
          tabPress: (num) {
            setState(() {
              _tabpagecontroller.animateToPage(num,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInCubic);
            });
          },
        ),
      ],
    )));
  }
}
