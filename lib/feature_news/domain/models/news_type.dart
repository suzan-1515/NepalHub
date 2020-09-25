enum NewsType { TRENDING, RECENT, LATEST, LOCAL, BREAKING }

extension NewsTypeX on NewsType {
  String get value => this.toString().split('.').last.toLowerCase();
}

extension NewsTypeParsingX on String {
  NewsType get toNewsType {
    switch (this) {
      case 'trending':
        return NewsType.TRENDING;
      case 'recent':
        return NewsType.RECENT;
      case 'latest':
        return NewsType.LATEST;
      case 'breaking':
        return NewsType.BREAKING;
      default:
        return null;
    }
  }
}
