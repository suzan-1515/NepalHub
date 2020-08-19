import 'package:flutter/widgets.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:samachar_hub/services/services.dart';

class ShareService {
  final AnalyticsService _analyticsService;

  ShareService(this._analyticsService);
  Future share(
      {@required String postId,
      @required String data,
      String contentType}) async {
    if (data == null || data.isEmpty) return;
    return FlutterShareMe().shareToSystem(msg: data).then((value) =>
        _analyticsService.logShare(
            postId: postId, contentType: contentType, method: 'open'));
  }

  Future shareToFacebook(
      {@required String postId,
      @required String title,
      @required String url,
      String contentType}) async {
    if (url == null || url.isEmpty) return;
    return FlutterShareMe().shareToFacebook(msg: title, url: url).then(
        (value) => _analyticsService.logShare(
            postId: postId, contentType: contentType, method: 'facebook'));
  }

  Future shareToTwitter(
      {@required String postId,
      @required String title,
      @required String url,
      String contentType}) async {
    if (url == null || url.isEmpty) return;
    return FlutterShareMe().shareToTwitter(msg: title, url: url).then((value) =>
        _analyticsService.logShare(
            postId: postId, contentType: contentType, method: 'twitter'));
  }

  Future shareToWhatsApp(
      {@required String postId,
      @required String data,
      String contentType}) async {
    if (data == null || data.isEmpty) return;
    return FlutterShareMe().shareToWhatsApp(msg: data).then((value) =>
        _analyticsService.logShare(
            postId: postId, contentType: contentType, method: 'whatsapp'));
  }
}
