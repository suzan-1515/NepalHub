import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<ReactionDisposer> _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    var store = context.read<AuthenticationStore>();
    _setupObserver(store);
    super.initState();
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
        log('[LoginScreen] loing state changed: ${store.isLoggedIn} ${store.user != null}');
        if (store.isLoggedIn)
          context.read<NavigationService>().toHomeScreen(context);
      }),
    ];
  }

  Widget _buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInUp(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/icons/logo.png')),
            ),
          ),
        ),
        SizedBox(height: 16),
        Flexible(
            child: FadeInUp(
          child: Text(
            'Create an account to have full access',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        )),
      ],
    );
  }

  Widget _buildSignInButtons(AuthenticationStore authStore) {
    return FadeInLeft(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SignInButton(
              Buttons.Google,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16),
                right: Radius.circular(16),
              )),
              text: 'Continue with Google',
              onPressed: () {
                authStore.signInWithGoogle();
              },
            ),
            SizedBox(height: 8),
            SignInButton(
              Buttons.Facebook,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16),
                right: Radius.circular(16),
              )),
              text: 'Continue with Facebook',
              onPressed: () {
                authStore.signInWithFacebook();
              },
            ),
            SizedBox(height: 8),
            SignInButton(
              Buttons.Twitter,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16),
                right: Radius.circular(16),
              )),
              text: 'Continue with Twitter',
              onPressed: () {
                authStore.signInWithTwitter();
              },
            ),
            // SizedBox(height: 8),
            // OutlineButton(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.horizontal(
            //     left: Radius.circular(16),
            //     right: Radius.circular(16),
            //   )),
            //   onPressed: () {
            //     authStore.signInAnonymously();
            //   },
            //   child: Text('Continue as Guest'),
            // ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer<AuthenticationStore>(
            builder: (_, AuthenticationStore authStore, Widget child) {
          return Container(
            padding: const EdgeInsets.all(32.0),
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: Observer(
                builder: (_) {
                  return IgnorePointer(
                    ignoring: authStore.isLoading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: _buildHeader(),
                        ),
                        SizedBox(height: 16),
                        if (authStore.isLoading) Center(child: ProgressView()),
                        Expanded(
                          child: _buildSignInButtons(authStore),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
