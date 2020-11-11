import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/forex_screen.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/gold_silver_screen.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/horoscope/horoscope_screen.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/main/main_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/home_screen.dart';
import 'package:samachar_hub/feature_main/presentation/ui/more_menu/more_menu_screen.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen_preloader.dart';
import 'package:samachar_hub/feature_news/presentation/ui/following/following_screen.dart';

class MainScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/main';

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
        GetIt.I.get<DynamicLinkService>().linkStream.listen((event) {
      log('[MainScreen] dynamic link received: ${event.path}');
      if (event.pathSegments.first == 'horoscope') {
        log('[MainScreen] Navigate to horocope screen');
        Navigator.pushNamed(context, HoroscopeScreen.ROUTE_NAME);
      } else if (event.pathSegments.first == 'forex') {
        log('[MainScreen] Navigate to forex screen');
        Navigator.pushNamed(context, ForexScreen.ROUTE_NAME);
      } else if (event.pathSegments.first == 'gold-silver') {
        log('[MainScreen] Navigate to gold-silver screen');
        Navigator.pushNamed(context, GoldSilverScreen.ROUTE_NAME);
      } else if (event.pathSegments.first == 'news-detail') {
        log('[MainScreen] Navigate to news detail screen');
        if (event.pathSegments.length > 1)
          Navigator.pushNamed(context, NewsDetailScreenPreloader.ROUTE_NAME,
              arguments: event.pathSegments[1]);
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
              context.read<MainCubit>().navItemSelected(index);
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
