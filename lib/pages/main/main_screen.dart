import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/category/categories_page.dart';
import 'package:samachar_hub/pages/following/following_screen.dart';
import 'package:samachar_hub/pages/home/home_screen.dart';
import 'package:samachar_hub/pages/more_menu/more_menu_screen.dart';
import 'package:samachar_hub/stores/stores.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

// Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<HomeStore>();
    _setupObserver(store);
    super.initState();
  }

  _setupObserver(HomeStore store) {
    _disposers = [
      autorun((_) {
        _pageController.jumpToPage(store.selectedPage);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStore>(
      builder: (_, HomeStore homeStore, Widget child) {
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
                  // SettingsPage(),
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
                  title: Text('Categories'),
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
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    super.dispose();
  }
}
