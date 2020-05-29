import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthenticationStore, NavigationService>(builder:
        (BuildContext context, AuthenticationStore authStore, navigationService,
            Widget child) {
      authStore
          .loginWithEmail(email: 'admin@gmail.com', password: '12345678')
          .then((value) {
        if (value) return navigationService.toHomeScreen(context);
      });
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Logging in...',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 8),
                  ProgressView(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
