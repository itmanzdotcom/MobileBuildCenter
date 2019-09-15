import 'package:flutter/material.dart';
import 'dart:io';

import 'package:tiki_app_testing/models/build_response.dart';
import 'package:tiki_app_testing/utils/styles.dart';

class BuildItem extends StatelessWidget {
  final Function onTap;
  final Function onOpenQR;
  final BuildInfo info;

  BuildItem({this.onTap, this.info, this.onOpenQR});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: _generateBackgroundColor(info.name),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Styles.shadowColor,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 135,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${info.name}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _generateVersionColor(info.name),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      "${info.version}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onOpenQR,
              child: Container(
                padding: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _generateVersionColor(info.name),
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image(image: AssetImage('assets/qr-code.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _generateBackgroundColor(String name) {
    return Colors.white;
  }

  _generateVersionColor(String name) {
    bool isDev;
    if (Platform.isIOS) {
      isDev = name.toLowerCase().contains("tikidev");
    } else {
      isDev = !name.toLowerCase().contains("prod");
    }
    return isDev
        ? Color.fromRGBO(95, 39, 205, 1)
        : Color.fromRGBO(13, 92, 182, 1);
  }
}
