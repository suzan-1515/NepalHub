import 'package:flutter/widgets.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:share/share.dart';

class ShareService {
  final AnalyticsService _analyticsService;

  ShareService(this._analyticsService);
  Future share(
      {@required String postId,
      @required String title,
      @required String data}) {
    if (null != data) {
      try {
        return Share.share(data, subject: title)
            .then((value) => _analyticsService.logShare(postId: postId));
      } on Exception {
        return Future.error(Exception('Invalid data. Cannot share this data.'),);
      }
    }

    return Future.error(Exception('Invalid data. Cannot share this data.'));
  }
}
