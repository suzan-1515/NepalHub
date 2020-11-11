import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_auth/presentation/ui/login_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/main/main_screen.dart';

import 'widgets/splash_view.dart';

class SplashScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState)
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainScreen.ROUTE_NAME,
            (route) => false,
          );
        else if (state is AuthErrorState)
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.ROUTE_NAME,
            (route) => false,
          );
      },
      child: SplashView(),
    );
  }
}
