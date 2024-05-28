import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../utils/constants/dimens.dart';

class LocationLoadingPage extends StatelessWidget {
  const LocationLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/loading.svg',
            height: 200,
          ),
          SizedBox(height: Dimens.spacing.medium),
          Text(
            "Loading Location...",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: Dimens.spacing.medium),
          const CircularProgressIndicator.adaptive(),
        ],
      )),
    );
  }
}
