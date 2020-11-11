import 'dart:async';
import 'dart:developer';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:uni_links/uni_links.dart';

class DynamicLinkService {
  final BehaviorSubject<Uri> _linkSubject = BehaviorSubject<Uri>();

  Stream<Uri> get linkStream => _linkSubject.stream;

  StreamSubscription _deeplinkSubscription;

  DynamicLinkService() {
    _initLinks();
  }

  _initLinks() async {
    log('[DynamicLinkService] _initLinks');
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      log('[DynamicLinkService] Applink onLinkReceived');
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        log('[DynamicLinkService] Applink onLinkReceived: ${deepLink.toString()}');
        _linkSubject.add(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      log('[DynamicLinkService] onLinkError', error: e);
    });

    _deeplinkSubscription = getUriLinksStream().listen((Uri uri) {
      log('[DynamicLinkService] DeepLink onLinkReceived');

      if (uri != null) {
        log('[DynamicLinkService] DeepLink onLinkReceived: ${uri.toString()}');
        // _linkSubject.add(uri);
      }
    }, onError: (e) {
      log('[DynamicLinkService] DeepLink onLinkError', error: e);
    });

    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      Uri deepLink = data?.link;

      if (deepLink != null) {
        log('[DynamicLinkService] Applink onInitialLinkReceived: ${deepLink.toString()}');
        _linkSubject.add(deepLink);
      } else {
        deepLink = await getInitialUri();
        if (deepLink != null) {
          log('[DynamicLinkService] Deeplink onInitialLinkReceived: ${deepLink.toString()}');
          _linkSubject.add(deepLink);
        }
      }
    } catch (e) {
      log('[DynamicLinkService] Error on get initital link: ', error: e);
    }
  }

  dispose() {
    _linkSubject.close();
    _deeplinkSubscription?.cancel();
  }
}
