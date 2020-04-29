enum FeedActivityEvent {
  Like,
  Share,
  Comment,
  Bookmark,
  View,
}

extension EnumParsing on FeedActivityEvent {
  String asString() {
    return this.toString().split('.').last.toLowerCase();
  }
}
