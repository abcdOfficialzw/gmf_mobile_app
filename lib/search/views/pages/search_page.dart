import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geodetic_monument_finder/location/views/pages/map_page.dart';
import 'package:geodetic_monument_finder/search/views/pages/search_not_found_page.dart';

import '../../../database/database.dart';
import '../../../models/geodatic_points_model.dart';
import '../../../utils/constants/dimens.dart';

import '../../state/search/bloc.dart';
import '../../state/search/event.dart';
import '../../state/search/state.dart';
import 'search_results_page.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _monumentSearchTextController =
      TextEditingController();

  final FocusNode _monumentSearchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    List<GeodaticPoint> geoPoints =
        Database.geodaticPoints.map((e) => GeodaticPoint.fromJson(e)).toList();
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MapPage(
                      longitude: "31.053028",
                      latitude: "-17.824858",
                      locationName: "Harare",
                      cases: geoPoints.length,
                      markers: geoPoints)));
            },
            child: Icon(Icons.location_on),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.padding.normal)
                .copyWith(
                    top: Dimens.padding.extremePadding,
                    bottom: Dimens.padding.extremePadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimens.spacing.extremeSpacing),
                  SvgPicture.asset(
                    "assets/landing_illustration.svg",
                    height: 200,
                  ),
                  SizedBox(height: Dimens.spacing.extremeSpacing),
                  Text("Search for a monument",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: Dimens.spacing.large),
                  TextField(
                    controller: _monumentSearchTextController,
                    focusNode: _monumentSearchFocusNode,
                    decoration: InputDecoration(
                      hintText: "Enter monument number",
                      contentPadding: EdgeInsets.all(Dimens.padding.large),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimens.borderRadius.normal),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: Dimens.spacing.large),
                  SizedBox(height: Dimens.spacing.small),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => BlocProvider(
                            create: (context) => SearchBloc(),
                            child: BlocBuilder<SearchBloc, SearchState>(
                              builder: (context, state) {
                                return CupertinoActionSheet(
                                  title: const Text("Projection"),
                                  message: const Text(
                                      "Select the projection you would like for your results"),
                                  actions: [
                                    CupertinoActionSheetAction(
                                      isDefaultAction: true,
                                      onPressed: () {
                                        // context.read<SearchBloc>().add(
                                        //       SearchStarted(
                                        //           query:
                                        //               _monumentSearchTextController
                                        //                   .text,
                                        //           projection: "GAUSS"),
                                        //     );
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsPage(
                                                      searchQuery:
                                                          _monumentSearchTextController
                                                              .text
                                                              .trim(),
                                                      projection: "GAUSS",
                                                    )));
                                      },
                                      child: const Text("GAUSS"),
                                    ),
                                    CupertinoActionSheetAction(
                                      isDefaultAction: false,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsPage(
                                                      searchQuery:
                                                          _monumentSearchTextController
                                                              .text,
                                                      projection: "WGS84",
                                                    )));
                                      },
                                      child: const Text("WGS84"),
                                    ),
                                    CupertinoActionSheetAction(
                                      isDefaultAction: false,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultsPage(
                                                      searchQuery:
                                                          _monumentSearchTextController
                                                              .text,
                                                      projection: "UTM",
                                                    )));
                                      },
                                      child: const Text("UTM"),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text("Search"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
