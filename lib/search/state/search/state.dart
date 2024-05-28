import 'package:equatable/equatable.dart';

import '../../../models/geodatic_points_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final int progress;

  SearchLoading(this.progress);

  @override
  List<Object> get props => [progress];
}

class SearchSuccessful extends SearchState {
  final String searchQuery;
  final GeodaticPoint result;

  SearchSuccessful(this.searchQuery, this.result);

  @override
  List<Object> get props => [searchQuery];
}

class SearchFailed extends SearchState {
  final String errorMessage;

  SearchFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
