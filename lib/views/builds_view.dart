import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tiki_app_testing/blocs/build_info/build_info.dart';
import 'package:tiki_app_testing/widgets/build_item.dart';

class BuildsView extends StatefulWidget {
  @override
  _BuildsViewState createState() => _BuildsViewState();
}

class _BuildsViewState extends State<BuildsView> {
  BuildInfoBloc _buildInfoBloc;

  @override
  void initState() {
    super.initState();
    _buildInfoBloc = BlocProvider.of<BuildInfoBloc>(context);
    _buildInfoBloc.dispatch(FetchBuildInfo());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              Expanded(
                flex: 1,
                child: BlocBuilder<BuildInfoBloc, BuildInfoState>(
                    builder: (context, state) {
                  if (state is BuildInfoUninitialized) {
                    return Center(
                      child: SpinKitDoubleBounce(
                        color: Colors.blue,
                        size: 80,
                      ),
                    );
                  }

                  if (state is BuildInfoLoaded) {
                    if (state.builds.isEmpty) {
                      return Center(
                        child: Text('No builds available'),
                      );
                    } else {
                      return ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        itemCount: state.builds.length,
                        itemBuilder: (context, index) {
                          return BuildItem(
                            info: state.builds[index],
                            onTap: () => _buildInfoBloc.dispatch(
                              SelectBuild(state.builds[index]),
                            ),
                          );
                        },
                      );
                    }
                  }

                  if (state is BuildInfoError) {
                    return Center(
                      child: Text('There are some problems'),
                    );
                  }

                  return Container();
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
