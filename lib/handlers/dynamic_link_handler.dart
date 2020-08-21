import 'dart:developer';

import 'package:samachar_hub/services/dynamic_link_service.dart';

class DynamicLinkHandler {
  final DynamicLinkService _dynamicLinkService;

  DynamicLinkHandler(this._dynamicLinkService) {
    log('[DynamicLinkHandler] DynamicLinkHandler');
    this._dynamicLinkService.linkStream.listen((event) {
      log('[DynamicLinkHandler] link received: ${event.path}');
    });
  }
}
