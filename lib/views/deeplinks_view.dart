import 'package:flutter/material.dart';

import 'package:tiki_app_testing/widgets/header.dart';
import 'package:tiki_app_testing/widgets/border_tab.dart';

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
          SizedBox(height: 15),
          Container(
            height: 30,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return BorderTab(
                    title: 'Remote',
                    isSelected: true,
                  );
                }
                return BorderTab(
                  title: 'Local',
                  isSelected: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
