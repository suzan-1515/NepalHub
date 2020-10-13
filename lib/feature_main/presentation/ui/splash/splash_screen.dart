import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/navigation_service.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_auth/utils/providers.dart';

import 'widgets/splash_view.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProviders.authBlocProvider(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitialState) {
            Future.delayed(
              Duration(seconds: 2),
              () => context.bloc<AuthBloc>().add(AutoLoginEvent()),
            );
          } else if (state is AuthSuccessState)
            context.repository<NavigationService>().toHomeScreen(context);
          else if (state is AuthErrorState)
            context.repository<NavigationService>().toLoginScreen(context);
        },
        child: SplashView(),
      ),
    );
  }
}
