import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geodetic_monument_finder/database/database_helper.dart';
import '../../../models/geodatic_points_model.dart';
import '../../../services/networking_service.dart';
import '../../../utils/constants/app_urls.dart';
import 'event.dart';
import 'state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchStarted>((event, emit) async {
      print("Search Started");
      print(state);
      emit(SearchLoading(10));
      GeodaticPoint? result =
          await DatabaseHelper.getPoint(monumentName: event.query);

      if (result != null) {
        return emit(SearchSuccessful(event.query, result));
      }
      emit(SearchFailed("Monument ${event.query} not found"));
      print(state);
    });
    on<SearchNotFound>((event, emit) async {
      emit(SearchFailed("Monument not found"));
    });
  }
}
