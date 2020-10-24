import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/navigation_service.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';

import 'widgets/splash_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<AuthBloc>().add(AutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState)
          GetIt.I.get<NavigationService>().toHomeScreen(context);
        else if (state is AuthErrorState)
          GetIt.I.get<NavigationService>().toLoginScreen(context);
      },
      child: SplashView(),
    );
  }
}
