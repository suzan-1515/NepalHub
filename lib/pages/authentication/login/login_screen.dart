import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/manager/managers.dart';
import 'package:samachar_hub/common/service/navigation_service.dart';
import 'package:samachar_hub/common/store/auth_store.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthenticationController, AuthenticationStore,
            NavigationService>(
        builder: (BuildContext context, AuthenticationController authController,
            AuthenticationStore authStore, navigationService, Widget child) {
      authController
          .loginWithEmail(email: 'admin@gmail.com', password: '12345678')
          .then((value) {
        authStore.setUser(authController.currentUser);
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
