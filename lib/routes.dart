import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = "/";
  static const String search = "/search";
  static const String confirmation = "/confirmation";
}

class FadeRoute extends PageRouteBuilder {
  final Widget widget;
  FadeRoute({this.widget})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return new FadeTransition(
        opacity: new Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: child,
      );
    },
  );
}