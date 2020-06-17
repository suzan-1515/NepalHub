import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/global_api_service.dart';
import 'core/services/launcher_service.dart';
import 'core/services/nepal_api_service.dart';
import 'core/services/podcast_player_service.dart';
import 'ui/pages/nav_page.dart';
import 'ui/styles/app_colors.dart';

class CoronaApp extends StatelessWidget {
  CoronaApp() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LauncherService>(create: (_) => LauncherService()),
        RepositoryProvider<NepalApiService>(create: (_) => NepalApiService()),
        RepositoryProvider<GlobalApiService>(create: (_) => GlobalApiService()),
        RepositoryProvider<PodcastPlayerService>(
            create: (_) => PodcastPlayerService()),
      ],
      // child: NavPage(),
      child: Theme(
        isMaterialAppTheme: true,
        data: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          iconTheme: IconThemeData(color: AppColors.primary),
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: AppColors.primary,
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          brightness: Brightness.dark,
          primaryColor: AppColors.primary,
          accentColor: AppColors.primary,
          fontFamily: 'Sen',
        ),
        child: NavPage(),
        
      ),
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   title: 'Covid19 Info',
      //   theme: ThemeData(
      //     scaffoldBackgroundColor: AppColors.background,
      //     iconTheme: IconThemeData(color: AppColors.primary),
      //     appBarTheme: AppBarTheme(
      //       brightness: Brightness.dark,
      //       color: AppColors.primary,
      //       iconTheme: IconThemeData(color: AppColors.primary),
      //     ),
      //     brightness: Brightness.dark,
      //     primaryColor: AppColors.primary,
      //     accentColor: AppColors.primary,
      //     fontFamily: 'Sen',
      //   ),
      //   home: NavPage(),
      // ),
    );
  }
}
