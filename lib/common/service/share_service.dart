import 'package:flutter/widgets.dart';
import 'package:share/share.dart';

class ShareService {
  Future share({@required String title, @required String data}) {
    if (null != data) {
      try {
        return Share.share(data, subject: title);
      } on Exception catch (e) {
        return Future.error(Exception('Invalid data. Cannot share this data.'));
      }
    }

    return Future.error(Exception('Invalid data. Cannot share this data.'));
  }
}
