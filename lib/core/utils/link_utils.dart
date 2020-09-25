import 'package:url_launcher/url_launcher.dart';

class LinkUtils {
  static Future openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception(
          'Cannot open this link in external browser. Change news read mode to summary mode in settings and try again.');
    }
  }
}
