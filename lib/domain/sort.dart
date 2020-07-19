enum SortBy { RECENT, RELEVANCE, POPULAR }

extension SortByX on SortBy {
  String get value => this.toString().split('.').last.toLowerCase();
}
