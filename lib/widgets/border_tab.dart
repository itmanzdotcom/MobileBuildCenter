import 'package:flutter/material.dart';

import 'package:tiki_app_testing/utils/styles.dart';

class BorderTab extends StatelessWidget {
  final bool isSelected;
  final String title;

  BorderTab({Key key, this.isSelected, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Styles.newTikiColor : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Styles.lightBlackColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
