import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/pages.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

// Reaction disposers
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<HomeScreenStore>(context, listen: false);
    _setupObserver(store);
    super.initState();
  }

  _setupObserver(HomeScreenStore store) {
    _disposers = [
      autorun((_) {
        _pageController.jumpToPage(store.selectedPage);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenStore>(
      builder: (BuildContext context, HomeScreenStore homeStore, Widget child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Center(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => {},
                children: <Widget>[
                  PersonalisedPage(),
                  CategoriesPage(),
                  BookmarkPage(),
                  SettingsPage(),
                ],
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
          bottomNavigationBar: Observer(
            builder: (_) => BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: Theme.of(context).backgroundColor,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.user),
                  title: Text('For You'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.globe),
                  title: Text('Categories'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidHeart),
                  title: Text('Bookmarks'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.cog),
                  title: Text('Settings'),
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
