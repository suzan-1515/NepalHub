import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';


import '../../ui/widgets/common/ui_helper.dart';

class LauncherService {
  Future<void> launchPhone(BuildContext context, String phone) async {
    String phoneNumber = phone.split(',').first;
    if (await canLaunch('tel:$phoneNumber')) {
      await launch('tel:$phoneNumber');
    } else {
      UiHelper.showMessage(context, 'Cannot open phone!');
    }
  }

  Future<void> launchEmail(BuildContext context, String email) async {
    String emailAddress = 'mailto:$email';
    if (await canLaunch(emailAddress)) {
      await launch(emailAddress);
    } else {
      UiHelper.showMessage(context, 'Cannot open email!');
    }
  }

  Future<void> launchWebsite(BuildContext context, String website) async {
    final url = website.contains('http') ? website : 'http:$website';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      UiHelper.showMessage(context, 'Cannot open website!');
    }
  }
}
