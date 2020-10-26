enum ThreadType {
  NEWS_FEED,
  FOREX,
  HOROSCOPE,
  STOCK,
  GOLD,
  VIDEO,
  TWEET,
  COMMENT,
  INSTAGRAM_POST
}

extension ThreadTypeX on ThreadType {
  String get value => this.toString().split('.').last.toLowerCase();
}

extension ThreadTypeParsingX on String {
  ThreadType get toThreadType {
    switch (this) {
      case 'news_feed':
        return ThreadType.NEWS_FEED;
      case 'forex':
        return ThreadType.FOREX;
      case 'horoscope':
        return ThreadType.HOROSCOPE;
      case 'stock':
        return ThreadType.STOCK;
      case 'gold':
        return ThreadType.GOLD;
      case 'video':
        return ThreadType.VIDEO;
      case 'tweet':
        return ThreadType.TWEET;
      case 'instagram_post':
        return ThreadType.INSTAGRAM_POST;
      case 'comment':
        return ThreadType.COMMENT;
      default:
        return null;
    }
  }
}
