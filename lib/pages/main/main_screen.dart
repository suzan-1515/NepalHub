import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/category/categories_page.dart';
import 'package:samachar_hub/repository/corona_repository.dart';
import 'package:samachar_hub/pages/following/following_screen.dart';
import 'package:samachar_hub/pages/home/home_screen.dart';
import 'package:samachar_hub/pages/more_menu/more_menu_screen.dart';
import 'package:samachar_hub/repository/repositories.dart';
import 'package:samachar_hub/services/dynamic_link_service.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/main/main_store.dart';
import 'package:samachar_hub/stores/stores.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

// Reaction disposers
  List<ReactionDisposer> _disposers;
  StreamSubscription _dynamicLinkSubscription;

  @override
  void initState() {
    final store = context.read<MainStore>();
    store.selectedPage = 0;
    _setupObserver(store);
    super.initState();
    _initDynamicLinks();
  }

  _setupObserver(MainStore store) {
    _disposers = [
      autorun((_) {
        _pageController.jumpToPage(store.selectedPage);
      }),
    ];
  }

  _initDynamicLinks() {
    _dynamicLinkSubscription =
        context.read<DynamicLinkService>().linkStream.listen((event) {
      log('[MainScreen] dybamic link received: ${event.path}');
      if (event.path.contains('horoscope')) {
        log('[MainScreen] Navigate to horocope screen');
        context.read<NavigationService>().toHoroscopeScreen(context);
      } else if (event.path.contains('forex')) {
        log('[MainScreen] Navigate to forex screen');
        context.read<NavigationService>().toForexScreen(context);
      }
    }, onError: (e) {
      log('[MainScreen] already subscribed');
    }, cancelOnError: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Store
        ProxyProvider4<NewsRepository, ForexRepository, HoroscopeRepository,
            CoronaRepository, HomeStore>(
          update: (_, _newsRepository, _forexRepository, _horoscopeRepository,
                  _coronaRepository, __) =>
              HomeStore(_newsRepository, _horoscopeRepository, _forexRepository,
                  _coronaRepository),
        ),
        ProxyProvider<NewsRepository, NewsCategoryScreenStore>(
          update: (_, _newsRepository, __) =>
              NewsCategoryScreenStore(_newsRepository),
          dispose: (context, categoriesStore) => categoriesStore.dispose(),
        ),
        ProxyProvider<NewsRepository, FollowingStore>(
          update: (_, _newsRepository, __) => FollowingStore(_newsRepository),
          dispose: (context, value) => value.dispose(),
        ),
        ProxyProvider<PreferenceService, MoreMenuStore>(
          update: (_, preferenceService, __) =>
              MoreMenuStore(preferenceService),
        ),
      ],
      child: Consumer<MainStore>(
        builder: (_, MainStore homeStore, Widget child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: SafeArea(
              child: Center(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => {},
                  children: <Widget>[
                    HomeScreen(),
                    NewsCategoriesPage(),
                    FollowingPage(),
                    MoreMenuScreen(),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            bottomNavigationBar: Observer(
              builder: (_) => BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedItemColor: Theme.of(context).indicatorColor,
                backgroundColor: Theme.of(context).backgroundColor,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.home),
                    title: Text('For You'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.globe),
                    title: Text('Discover'),
                  ),
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
                currentIndex: homeStore.selectedPage,
                onTap: homeStore.setPage,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    _dynamicLinkSubscription?.cancel();
    super.dispose();
  }
}
