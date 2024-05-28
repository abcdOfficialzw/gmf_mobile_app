import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/dimens.dart';
import '../../../utils/widgets/expanded_primary_button.dart';

class LocationLoadedPage extends StatelessWidget {
  const LocationLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: Dimens.spacing.medium),
          Text(
            "Location Loaded",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: Dimens.spacing.medium),
          const ExpandedPrimaryButton(
            "Continue",
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
