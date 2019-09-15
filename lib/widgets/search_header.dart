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
      padding: EdgeInsets.only(left: 20, right: 25, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close,
              size: 30,
              color: Styles.lightBlackColor,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      focusNode: _focusNode,
                      decoration:
                          InputDecoration.collapsed(hintText: Constants.searchHint),
                      onChanged: (text) => widget.onSearchTextChange(text),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                    color: Styles.lightBlackColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
