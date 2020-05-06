import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/pages/home/home_screen_store.dart';
import 'package:samachar_hub/pages/pages.dart';
import 'package:samachar_hub/pages/widgets/news_category_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

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
                onPageChanged: homeStore.setPage,
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
              onTap: _pageController.jumpToPage,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
