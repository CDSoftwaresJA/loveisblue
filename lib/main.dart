import 'package:loveisblue/pages/splash.dart';
import 'package:loveisblue/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Themes themes = Themes();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(localizationsDelegates: [
      DefaultMaterialLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ], debugShowCheckedModeBanner: false, home: Splash());
  }
}
