import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'blocs/app_bloc_delegate.dart';
import 'package:bloc/bloc.dart';

import 'package:tiki_app_testing/models/build_response.dart';
import 'utils/constants.dart';
import 'utils/styles.dart';

void main() {
  BlocSupervisor.delegate = AppBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Build Center',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> dataSource = [];
  bool isLoadingUrl = true;

  getDS() async {
    final response = await http.Client().get("${Constants.baseUrl}apps");

    print(response.statusCode);
    if (response.statusCode == 200) {
      final platform = Platform.isIOS ? "ios" : "android";
      final json = jsonDecode(response.body);
      List<BuildInfoSection> parsedData = (json[platform] as List)
          .map((item) => BuildInfoSection.fromJSON(item))
          .toList();
      List<BuildInfo> builds = [];
      parsedData.forEach((item) => builds.addAll(item.builds));
      setState(() {
        dataSource = List.from(builds);
      });
    }
    setState(() {
      isLoadingUrl = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getDS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightYellowColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Platform.isIOS ? 'iOS' : 'Android',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(117, 111, 106, 1),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        size: 30,
                        color: Color.fromRGBO(117, 111, 106, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    itemCount: dataSource.length,
                    itemBuilder: (context, index) => _buildItem(context, index),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.view_list, size: 30, color: Colors.blue),
                        Icon(Icons.link, size: 30, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isLoadingUrl,
              child: Center(
                child: SpinKitDoubleBounce(
                  color: Colors.blue,
                  size: 80,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _launchUrl(dataSource[index].link),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.only(left: 20, right: 10, top: 20, bottom: 20),
        decoration: BoxDecoration(
            color: _generateCellColor(dataSource[index].name),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(52, 152, 219, 0.5),
                  blurRadius: 10,
                  offset: Offset(0, 0)),
            ]),
        child: Text(
          "${dataSource[index].name}",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  _launchUrl(String url) async {
    setState(() {
      isLoadingUrl = true;
    });
    if (await canLaunch(url)) {
      await launch(url);
    }

    setState(() {
      isLoadingUrl = false;
    });
  }

  _generateCellColor(String name) {
    if (name.contains('TikiProject')) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }
}
