import 'package:flutter/cupertino.dart';

Route createRoute(Widget menu) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => menu,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
