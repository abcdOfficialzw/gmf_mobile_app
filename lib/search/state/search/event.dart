abstract class SearchEvent {}

class SearchStarted extends SearchEvent {
  final String query;
  final String projection;

  SearchStarted({required this.query, required this.projection});
}

class SearchFound extends SearchEvent {
  final String query;

  SearchFound(this.query);
}

class SearchNotFound extends SearchEvent {}
