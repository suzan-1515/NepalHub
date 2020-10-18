import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/main/main_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/home_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/more_menu/more_menu_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/following_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  StreamSubscription _dynamicLinkSubscription;

  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  _initDynamicLinks() {
    _dynamicLinkSubscription =
        context.repository<DynamicLinkService>().linkStream.listen((event) {
      log('[MainScreen] dybamic link received: ${event.path}');
      if (event.path.contains('horoscope')) {
        log('[MainScreen] Navigate to horocope screen');
        context.repository<NavigationService>().toHoroscopeScreen(context);
      } else if (event.path.contains('forex')) {
        log('[MainScreen] Navigate to forex screen');
        context.repository<NavigationService>().toForexScreen(context);
      }
    }, onError: (e) {
      log('[MainScreen] already subscribed');
    }, cancelOnError: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SafeArea(
          child: Center(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) => {},
              children: <Widget>[
                HomeScreen(),
                FollowingScreen(),
                MoreMenuScreen(),
              ],
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
        bottomNavigationBar: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {
            if (state is MainNavItemSelectionChangedState) {
              this._pageController.jumpToPage(state.currentIndex);
            }
          },
          builder: (context, state) => BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).backgroundColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                title: Text('For You'),
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(FontAwesomeIcons.globe),
              //   title: Text('Discover'),
              // ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidHeart),
                title: Text('Following'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userAlt),
                title: Text('Me'),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.bloc<MainCubit>().navItemSelected(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _dynamicLinkSubscription?.cancel();
    super.dispose();
  }
}
