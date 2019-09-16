import 'package:flutter/material.dart';

import 'package:tiki_app_testing/utils/styles.dart';

class HeroButton extends StatelessWidget {
  final Function onTap;
  final String tag;
  final IconData icon;
  final Color color;

  HeroButton({
    Key key,
    @required this.tag,
    @required this.onTap,
    @required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: tag,
        child: Icon(
          icon,
          size: 30,
          color: color ?? Styles.lightBlackColor,
        ),
      ),
    );
  }
}
