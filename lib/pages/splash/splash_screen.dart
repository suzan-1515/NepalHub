import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/services/in_app_messaging_service.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/services/preference_service.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

import 'widgets/splash_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = context.read<AuthenticationStore>();
    _setupObserver(store);
    super.initState();
    final prefs = context.read<PreferenceService>();
    if (prefs.isFirstOpen) prefs.isFirstOpen = false;
    Future.delayed(Duration(seconds: 2), () => store.silentSignIn());
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      autorun((_) {
        if (store.isLoggedIn != null) if (store.isLoggedIn) {
          this.context.read<NavigationService>().toHomeScreen(context);
        } else {
          this.context.read<NavigationService>().toLoginScreen(context);
        }
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<InAppMessagingService>(
          create: (_) => InAppMessagingService(),
        ),
        ProxyProvider<AnalyticsService, ShareService>(
          update: (_, _analyticsService, __) => ShareService(_analyticsService),
        ),
      ],
      child: SplashView(),
    );
  }
}
