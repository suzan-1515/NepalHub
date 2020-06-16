import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    var store = Provider.of<AuthenticationStore>(context, listen: false);
    _setupObserver(store);
    store.silentSignIn();
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
        _showMessage(message);
      }),
      autorun((_) {
        final bool isLoggedIn = store.isLoggedIn;
        _navigateToHome(isLoggedIn);
      }),
    ];
  }

  _navigateToHome(bool isLoggedIn) {
    if (isLoggedIn)
      Provider.of<NavigationService>(context, listen: false)
          .toHomeScreen(context);
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationStore>(
        builder: (_, AuthenticationStore authStore, Widget child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: Observer(
                builder: (_) {
                  return IgnorePointer(
                    ignoring: authStore.isLoading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (authStore.isLoading) ProgressView(),
                        SignInButton(
                          Buttons.Google,
                          text: 'Continue with Google',
                          onPressed: () {
                            authStore.signInWithGoogle();
                          },
                        ),
                        SizedBox(height: 8),
                        SignInButton(
                          Buttons.Facebook,
                          text: 'Continue with Facebook',
                          onPressed: () {},
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
