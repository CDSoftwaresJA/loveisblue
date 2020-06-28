import 'package:loveisblue/pages/settings.dart';
import 'package:loveisblue/providers/animation.dart';
import 'package:loveisblue/providers/seekchange.dart';
import 'package:loveisblue/providers/switch.dart';
import 'package:loveisblue/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../navigator.dart';
import 'amors.dart';
import 'community.dart';
import 'profile.dart';

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  static Themes themes = Themes();
  SwitchState switchState;
  List<Widget> _widgetOptions = <Widget>[
    Community(),
    Amors(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AnimationProvider()),
      ],
      child: Profile(),
    ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SeekChange()),
      ],
      child: Settings(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    switchState = Provider.of<SwitchState>(context, listen: true);
    Nav.context = context;
    return loadUI();
  }

  loadUI() {
    return Stack(
      children: <Widget>[
        CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: CupertinoTabBar(
            border: Border.all(width: 0.2),
            backgroundColor: Colors.white24,
            iconSize: 25,
            activeColor: Hexcolor("#3870FF"),
            inactiveColor: themes.textColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  child: Icon(Icons.settings),
                ),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                return Container(child: _widgetOptions[index]);
              },
            );
          },
        ),
        Positioned(
            top: 25,
            child: Tooltip(
              message: "Click here to enable loveisblue",
              child: CupertinoSwitch(
                activeColor: Hexcolor("#3870FF"),
                onChanged: (state) {
                  switchState.setValue(state);
                },
                value: switchState.state,
              ),
            )),
      ],
    );
  }
}
