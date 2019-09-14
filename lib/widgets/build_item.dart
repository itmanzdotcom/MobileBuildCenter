import 'package:flutter/material.dart';

import 'package:tiki_app_testing/models/build_response.dart';

class BuildItem extends StatelessWidget {
  final Function onTap;
  final BuildInfo info;

  BuildItem({this.onTap, this.info});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: _generateBackgroundColor(info.name),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: _generateShadowColor(info.name),
                  blurRadius: 10,
                  offset: Offset(0, 0)),
            ]),
        child: Text(
          "${info.name}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  _generateBackgroundColor(String name) {
    return Colors.blue;
  }

  _generateShadowColor(String name) {
    return Color.fromRGBO(52, 152, 219, 0.5);
  }
}
