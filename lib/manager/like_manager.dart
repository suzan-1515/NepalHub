import 'package:flutter/material.dart';
import 'package:samachar_hub/data/feed_activity_event.dart';
import 'package:samachar_hub/manager/feed_activity_manager.dart';

class LikeManager extends FeedActivityManager {
  LikeManager(
      {@required authenticationManager,
      @required analyticsService,
      @required activityService})
      : super(authenticationManager, analyticsService,
            activityService, FeedActivityEvent.Like);
}
