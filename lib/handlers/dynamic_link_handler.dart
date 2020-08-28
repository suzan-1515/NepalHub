import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/dynamic_link_service.dart';
import 'package:samachar_hub/services/navigation_service.dart';

class DynamicLinkHandler {
  final DynamicLinkService _dynamicLinkService;

  DynamicLinkHandler(this._dynamicLinkService) {
    log('[DynamicLinkHandler] DynamicLinkHandler');
  }

  init(BuildContext context) {
    this._dynamicLinkService.linkStream.listen((event) {
      log('[DynamicLinkHandler] link received: ${event.path}');
      if (event.path.contains('horoscope')) {
        log('[DynamicLinkHandler] Navigate to horocope screen');
        context.read<NavigationService>().toHoroscopeScreen(context);
      } else if (event.path.contains('forex')) {
        log('[DynamicLinkHandler] Navigate to forex screen');
        context.read<NavigationService>().toForexScreen(context);
      }
    });
  }
}
