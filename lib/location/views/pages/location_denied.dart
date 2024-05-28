import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/dimens.dart';
import '../../../utils/widgets/expanded_primary_button.dart';

class LocationDeniedPage extends StatelessWidget {
  const LocationDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(Dimens.padding.normal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/error.svg',
              height: 200,
            ),
            SizedBox(height: Dimens.spacing.medium),
            Text(
              "Location Permissions Denied",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: Dimens.spacing.medium),
            Text(
              "This App needs location permissions to function properly. Please allow location permissions to continue.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: Dimens.spacing.extremeSpacing),
            ExpandedPrimaryButton("Allow Location Permissions",
                onPressed: () => print("Retry Location Request")),
          ],
        ),
      ),
    );
  }
}
