import 'package:flutter/widgets.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:samachar_hub/core/services/services.dart';

class ShareService {
  final AnalyticsService _analyticsService;

  ShareService(this._analyticsService);
  Future share(
      {@required String threadId,
      @required String data,
      String contentType}) async {
    if (data == null || data.isEmpty) return;
    return FlutterShareMe()
        .shareToSystem(msg: '$data\n\nCredits: NepalHub')
        .then((value) => _analyticsService.logShare(
            postId: threadId, contentType: contentType, method: 'open'));
  }

  Future shareToFacebook(
      {@required String threadId,
      @required String title,
      @required String url,
      String contentType}) async {
    if (url == null || url.isEmpty) return;
    return FlutterShareMe().shareToFacebook(msg: title, url: url).then(
        (value) => _analyticsService.logShare(
            postId: threadId, contentType: contentType, method: 'facebook'));
  }

  Future shareToTwitter(
      {@required String threadId,
      @required String title,
      @required String url,
      String contentType}) async {
    if (url == null || url.isEmpty) return;
    return FlutterShareMe().shareToTwitter(msg: title, url: url).then((value) =>
        _analyticsService.logShare(
            postId: threadId, contentType: contentType, method: 'twitter'));
  }

  Future shareToWhatsApp(
      {@required String threadId,
      @required String data,
      String contentType}) async {
    if (data == null || data.isEmpty) return;
    return FlutterShareMe().shareToWhatsApp(msg: data).then((value) =>
        _analyticsService.logShare(
            postId: threadId, contentType: contentType, method: 'whatsapp'));
  }
}
