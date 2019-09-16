import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tiki_app_testing/blocs/blocs.dart';
import 'package:tiki_app_testing/utils/styles.dart';
import 'package:tiki_app_testing/widgets/search_header.dart';
import 'package:tiki_app_testing/widgets/build_item.dart';
import 'package:tiki_app_testing/utils/constants.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchBloc _searchBloc;
  BuildInfoBloc _buildInfoBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _buildInfoBloc = BlocProvider.of<BuildInfoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.lightYellowColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchHeader(
                onSearchTextChange: (text) => _onSearchTextChange(text),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoaded) {
                      return Text(
                        "${Constants.searchResultTitle} (${state.builds.length})",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Styles.lightBlackColor,
                        ),
                      );
                    }

                    if (state is SearchLoading) {
                      return Text(
                        Constants.searchLoadingTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Styles.lightBlackColor,
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(
                        child: SpinKitDoubleBounce(
                          color: Colors.blue,
                          size: 80,
                        ),
                      );
                    }

                    if (state is SearchLoaded) {
                      if (state.builds.isEmpty) {
                        return Center(
                          child: Text('No matching build name or version'),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          itemCount: state.builds.length,
                          itemBuilder: (context, index) => BuildItem(
                            info: state.builds[index],
                            onTap: () => _buildInfoBloc.dispatch(
                              SelectBuild(state.builds[index]),
                            ),
                          ),
                        );
                      }
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSearchTextChange(String text) {
    print(text);
    if (_buildInfoBloc.currentState is BuildInfoLoaded) {
      _searchBloc.dispatch(SearchBuilds(text, (_buildInfoBloc.currentState as BuildInfoLoaded).builds));
    }
  }
}
