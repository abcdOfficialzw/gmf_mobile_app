import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geodetic_monument_finder/search/views/pages/search_page.dart';
import 'package:geodetic_monument_finder/utils/widgets/expanded_primary_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../services/networking_service.dart';
import '../../../utils/constants/app_urls.dart';
import '../../../utils/constants/dimens.dart';
import '../../state/search/bloc.dart';
import '../../state/search/event.dart';
import '../../state/search/state.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage(
      {super.key, required this.searchQuery, required this.projection});

  final String searchQuery;
  final String projection;

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchBloc>().add(SearchStarted(
        query: widget.searchQuery, projection: widget.projection));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text("Monument ${widget.searchQuery} : ${widget.projection}"),
          ),
          body: Padding(
            padding: EdgeInsets.all(Dimens.padding.normal)
                .copyWith(bottom: Dimens.padding.extremePadding),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (state is SearchInitial) ...[
                      SvgPicture.asset(
                        "assets/undraw_fast_loading_re_8oi3.svg",
                        height: 300,
                      ),
                      SizedBox(height: Dimens.spacing.normal),
                      Text(
                        "Preparing to Search....",
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                    if (state is SearchLoading) ...[
                      Center(
                        child: Card(
                          child: SizedBox(
                              width: 200,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator.adaptive(),
                                  SizedBox(
                                    height: Dimens.spacing.small,
                                  ),
                                  Text(
                                      "Searching for ${widget.searchQuery} with projection ${widget.projection}...")
                                ],
                              )),
                        ),
                      ),
                    ],
                    if (state is SearchSuccessful) ...[
                      Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () {
                                print("Image : ${state.result.monumentImage}");
                              },
                              title: Text(state.result.monumentName.toString()),
                              trailing: const Text("Monument Name"),
                            ),
                            for (var key in state.result
                                .toJson()[
                                    "${widget.projection.toLowerCase()}points"]
                                .keys)
                              ListTile(
                                title: Text(state.result
                                    .toJson()[
                                        "${widget.projection.toLowerCase()}points"]
                                        [key]
                                    .toString()),
                                trailing: Text(key.toString().toUpperCase()),
                              ),
                            ListTile(
                              title: Text(state.result
                                  .toJson()["condition"]
                                  .toString()),
                              trailing: const Text("CONDITION"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimens.spacing.normal,
                      ),
                      Image.network(
                        state.result.monumentImage!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                      Spacer(),
                      SizedBox(height: Dimens.spacing.normal),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SearchPage()));
                                },
                                child: const Text("Done"),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.spacing.normal,
                            ),
                            FilledButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.error)),
                              onPressed: () {
                                reportMonument({
                                  required String condition,
                                  required String monumentId,
                                }) {
                                  NetworkingService().makeHttpCall(
                                    method: "POST",
                                    url: "${AppUrls.BASE_URL}/reports",
                                    body: {
                                      "condition": condition,
                                      "monument_id": monumentId,
                                    },
                                  ).then((value) {
                                    Navigator.of(context).pop();

                                    if (value.status == "success") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(value.message!)));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(value.message!)));
                                    }
                                  });
                                }

                                showModalBottomSheet(
                                    showDragHandle: true,
                                    context: context,
                                    builder: (context) => Container(
                                          padding: EdgeInsets.all(
                                              Dimens.padding.normal),
                                          child: Column(
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  "If you notice that the condition of the monument is not as stated, you can report the condition to the admin.",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Dimens.spacing.normal,
                                              ),
                                              ExpandedPrimaryButton(
                                                  "Report Damaged Monument",
                                                  backgroundColor: Colors.red,
                                                  borderColor: Colors.red,
                                                  onPressed: () {
                                                reportMonument(
                                                    condition: "DAMAGED",
                                                    monumentId: state.result.id
                                                        .toString());
                                              }),
                                              SizedBox(
                                                height: Dimens.spacing.normal,
                                              ),
                                              ExpandedPrimaryButton(
                                                  "Report Missing Monument",
                                                  backgroundColor: Colors.amber,
                                                  borderColor: Colors.amber,
                                                  onPressed: () {
                                                reportMonument(
                                                    condition: "MISSING",
                                                    monumentId: state.result.id
                                                        .toString());
                                              }),
                                            ],
                                          ),
                                        ));
                              },
                              child: const Text("Report Condition"),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (state is SearchFailed) ...[
                      Center(
                        child: SvgPicture.asset(
                          "assets/undraw_access_denied_re_awnf.svg",
                          height: 200,
                        ),
                      ),
                      SizedBox(
                        height: Dimens.spacing.normal,
                      ),
                      Text(
                        "Monument not found!!",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: Dimens.spacing.large,
                      ),
                      Text("Would you like request this monument to be added?",
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(
                        height: Dimens.spacing.veryLarge,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: FilledButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          showDragHandle: true,
                                          context: context,
                                          builder: (context) => Column(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Inorder to request a monument to be added to the Geodatic Monument database, you need to contact an admin",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.call),
                                                    title: const Text(
                                                        "Call +263787980222"),
                                                    onTap: () {},
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.email),
                                                    title: const Text(
                                                        "Email admin@monuments.co.zw"),
                                                    onTap: () {},
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: const Text("Request Addition")),
                              ),
                            ),
                            SizedBox(
                              width: Dimens.spacing.normal,
                            ),
                            Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                  //color: Theme.of(context).colorScheme.error,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchPage()));
                                    },
                                    icon: Icon(Icons.close,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)))
                          ],
                        ),
                      )
                    ]
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
