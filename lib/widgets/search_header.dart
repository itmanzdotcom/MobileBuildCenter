import 'package:flutter/material.dart';

import 'package:tiki_app_testing/utils/styles.dart';
import 'package:tiki_app_testing/utils/constants.dart';

class SearchHeader extends StatefulWidget {
  final Function(String) onSearchTextChange;

  SearchHeader({Key key, this.onSearchTextChange}) : super(key: key);

  @override
  _SearchHeaderState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    Future.delayed(Duration(microseconds: 100), () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Hero(
                  tag: Constants.headerMainButtonKey,
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Styles.lightBlackColor,
                  ),
                ),
              ),
              Text(
                'Search',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Styles.lightBlackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    focusNode: _focusNode,
                    onChanged: (text) => widget.onSearchTextChange(text),
                    decoration: InputDecoration.collapsed(hintText: Constants.searchHint),
                  ),
                ),
                Icon(
                  Icons.search,
                  size: 20,
                  color: Styles.lightBlackColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

