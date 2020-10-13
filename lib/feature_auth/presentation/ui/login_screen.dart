import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_auth/utils/providers.dart';

class LoginScreen extends StatelessWidget {
  Widget _buildHeader(BuildContext context) {
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

  Widget _buildSignInButtons(BuildContext context) {
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
                context.bloc<AuthBloc>().add(LoginWithGoogleEvent());
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
                context.bloc<AuthBloc>().add(LoginWithFacebookEvent());
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
                context.bloc<AuthBloc>().add(LoginWithTwitterEvent());
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
    return AuthProviders.authBlocProvider(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          padding: const EdgeInsets.all(32.0),
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthErrorState) {
                  context.showMessage(state.message);
                } else if (state is AuthSuccessState) {
                  context.repository<NavigationService>().toHomeScreen(context);
                }
              },
              buildWhen: (previous, current) => !(current is AuthSuccessState),
              builder: (context, state) {
                return IgnorePointer(
                  ignoring: state is AuthLoadingState,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: _buildHeader(context),
                      ),
                      SizedBox(height: 16),
                      if (state is AuthLoadingState)
                        Center(child: ProgressView()),
                      Expanded(
                        child: _buildSignInButtons(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
