enum CommentThreadType {
  NEWS_FEED,
  FOREX,
  HOROSCOPE,
  STOCK,
  GOLD,
  VIDEO,
  TWEET,
  INSTAGRAM_POST
}

extension CommentThreadTypeX on CommentThreadType {
  String get value => this.toString().split('.').last.toLowerCase();
}

extension CommentThreadTypeParsingX on String {
  CommentThreadType get toCommentThreadType {
    switch (this) {
      case 'news_feed':
        return CommentThreadType.NEWS_FEED;
      case 'forex':
        return CommentThreadType.FOREX;
      case 'horoscope':
        return CommentThreadType.HOROSCOPE;
      case 'stock':
        return CommentThreadType.STOCK;
      case 'gold':
        return CommentThreadType.GOLD;
      case 'video':
        return CommentThreadType.VIDEO;
      case 'tweet':
        return CommentThreadType.TWEET;
      case 'instagram_post':
        return CommentThreadType.INSTAGRAM_POST;
      default:
        return null;
    }
  }
}
