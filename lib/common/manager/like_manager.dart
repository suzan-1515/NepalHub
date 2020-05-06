import 'package:flutter/material.dart';
import 'package:samachar_hub/data/feed_activity_event.dart';

import 'managers.dart';

class LikeManager extends FeedActivityManager {
  LikeManager(
      {@required authenticationManager,
      @required analyticsService,
      @required activityService})
      : super(authenticationManager, analyticsService,
            activityService, FeedActivityEvent.Like);
}
