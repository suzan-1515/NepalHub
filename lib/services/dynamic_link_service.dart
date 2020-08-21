import 'dart:async';
import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  final StreamController<Uri> _linkController = StreamController<Uri>();

  Stream<Uri> get linkStream => _linkController.stream;

  DynamicLinkService() {
    _initLinks();
  }

  _initLinks() async {
    log('[DynamicLinkService] _initLinks');
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      log('[DynamicLinkService] onLinkReceived');
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        log('[DynamicLinkService] onLinkReceived: ${deepLink.toString()}');
        _linkController.add(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      log('[DynamicLinkService] onLinkError', error: e);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      log('[DynamicLinkService] onInitialLinkReceived: ${deepLink.toString()}');
      _linkController.add(deepLink);
    }
  }

  dispose() {
    _linkController.close();
  }
}
