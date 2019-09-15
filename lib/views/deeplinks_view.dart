import 'package:flutter/material.dart';

import 'package:tiki_app_testing/widgets/header.dart';

class DeepLinksView extends StatefulWidget {
  @override
  _DeepLinksViewState createState() => _DeepLinksViewState();
}

class _DeepLinksViewState extends State<DeepLinksView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderView(),
        ],
      ),
    );
  }
}
