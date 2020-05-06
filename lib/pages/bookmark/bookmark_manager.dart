import 'package:flutter/material.dart';
import 'package:samachar_hub/common/manager/managers.dart';
import 'package:samachar_hub/data/feed_activity_event.dart';

class BookmarkManager extends FeedActivityManager {
  BookmarkManager(
      {@required authenticationManager,
      @required analyticsService,
      @required activityService})
      : super(authenticationManager, analyticsService,
            activityService, FeedActivityEvent.Bookmark);
}
