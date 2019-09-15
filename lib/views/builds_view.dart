import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tiki_app_testing/utils/constants.dart';
import 'package:tiki_app_testing/blocs/build_info/build_info.dart';
import 'package:tiki_app_testing/widgets/build_item.dart';
import 'package:tiki_app_testing/widgets/header.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderView(),
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
                  child: Text(Constants.errorNotificationStr),
                );
              }

              return Container();
            }),
          ),
        ],
      ),
    );
  }
}
