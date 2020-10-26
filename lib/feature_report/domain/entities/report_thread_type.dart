enum ReportThreadType {
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

extension ReportThreadTypeX on ReportThreadType {
  String get value => this.toString().split('.').last.toLowerCase();
}

extension ReportThreadTypeParsingX on String {
  ReportThreadType get toReportThreadType {
    switch (this) {
      case 'news_feed':
        return ReportThreadType.NEWS_FEED;
      case 'forex':
        return ReportThreadType.FOREX;
      case 'horoscope':
        return ReportThreadType.HOROSCOPE;
      case 'stock':
        return ReportThreadType.STOCK;
      case 'gold':
        return ReportThreadType.GOLD;
      case 'video':
        return ReportThreadType.VIDEO;
      case 'tweet':
        return ReportThreadType.TWEET;
      case 'instagram_post':
        return ReportThreadType.INSTAGRAM_POST;
      case 'comment':
        return ReportThreadType.COMMENT;
      default:
        return null;
    }
  }
}
