import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'logic/home_screen_store.dart';
import 'pages/pages.dart';

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
                  TopHeadlinesPage(),
                  EverythingPage(),
                  FavouritesPage(),
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
                  icon: Icon(FontAwesomeIcons.bolt),
                  title: Text('Top Headlines'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.globe),
                  title: Text('Everything'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.solidHeart),
                  title: Text('Favourites'),
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
