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

extension FeedActivityEventParsing on String {
  FeedActivityEvent parseAsFeedActivityEvent() {
    switch (this) {
      case 'like':
        return FeedActivityEvent.Like;
      case 'share':
        return FeedActivityEvent.Share;
      case 'comment':
        return FeedActivityEvent.Comment;
      case 'bookmark':
        return FeedActivityEvent.Bookmark;
      case 'view':
        return FeedActivityEvent.View;
      default:
        throw Exception('Indefined event name');
    }
  }
}
