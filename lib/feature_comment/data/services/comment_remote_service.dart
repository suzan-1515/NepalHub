import 'package:flutter/foundation.dart';
import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_comment/data/services/remote_service.dart';
import 'package:samachar_hub/core/extensions/api_paging.dart';

class CommentRemoteService with RemoteService {
  static const DELETE = '/comments';
  static const UPDATE = '/comments';
  static const LIKE = '/comments/like';
  static const FETCH = '/comments';
  static const POST = '/comments';

  final HttpManager _httpManager;

  CommentRemoteService(this._httpManager);
  @override
  Future deleteComment(
      {@required String commentId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$DELETE/$commentId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future fetchComments(
      {@required String threadId,
      @required String threadType,
      @required int page,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> query = {
      'thread_id': threadId,
      'thread_type': threadType,
      '_start': page.start.toString(),
      '_limit': page.limit.toString(),
      '_sort': 'updated_at:DESC',
    };
    var call =
        await _httpManager.get(path: FETCH, headers: headers, query: query);

    return call;
  }

  @override
  Future likeComment(
      {@required String commentId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$commentId';
    var call = await _httpManager.post(path: path, headers: headers);

    return call;
  }

  @override
  Future postComment(
      {@required String threadId,
      @required String threadType,
      @required String comment,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'thread_id': threadId,
      'thread_type': threadType,
      'comment': comment,
    };
    var call =
        await _httpManager.post(path: POST, headers: headers, body: body);

    return call;
  }

  @override
  Future unlikeComment(
      {@required String commentId, @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    var path = '$LIKE/$commentId';
    var call = await _httpManager.delete(url: path, headers: headers);

    return call;
  }

  @override
  Future updateComment(
      {@required String commentId,
      @required String comment,
      @required String token}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'comment': comment,
    };
    var path = '$UPDATE/$commentId';
    var call = await _httpManager.put(url: path, headers: headers, body: body);

    return call;
  }
}
