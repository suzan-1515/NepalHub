import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/dynamic_link_service.dart';
import 'package:samachar_hub/services/navigation_service.dart';

class DynamicLinkHandler {
  final DynamicLinkService _dynamicLinkService;
  final BuildContext context;

  DynamicLinkHandler(this._dynamicLinkService, this.context) {
    log('[DynamicLinkHandler] DynamicLinkHandler');
    this._dynamicLinkService.linkStream.listen((event) {
      log('[DynamicLinkHandler] link received: ${event.path}');
      if (event.path.contains('horoscope')) {
        context.read<NavigationService>().toHoroscopeScreen(context);
      } else if (event.path.contains('forex')) {
        context.read<NavigationService>().toForexScreen(context);
      }
    });
  }
}
