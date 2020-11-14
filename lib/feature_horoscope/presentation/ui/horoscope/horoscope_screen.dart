import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';

import 'widgets/horoscope_list.dart';

class HoroscopeScreen extends StatefulWidget {
  static const String ROUTE_NAME = '/horoscope';

  @override
  _HoroscopeScreenState createState() => _HoroscopeScreenState();
}

class _HoroscopeScreenState extends State<HoroscopeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabs = <Tab>[
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.DAILY), text: 'Daily'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.WEEKLY), text: 'Weekly'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.MONTHLY), text: 'Monthly'),
    Tab(key: ValueKey<HoroscopeType>(HoroscopeType.YEARLY), text: 'Yearly'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Horoscope'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.ROUTE_NAME);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TabBar(
                controller: _tabController,
                tabs: _tabs,
                isScrollable: true,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    HoroscopeProvider.horoscopeBlocProvider(
                      type: HoroscopeType.DAILY,
                      child: const HoroscopeList(),
                    ),
                    HoroscopeProvider.horoscopeBlocProvider(
                      type: HoroscopeType.WEEKLY,
                      child: const HoroscopeList(),
                    ),
                    HoroscopeProvider.horoscopeBlocProvider(
                      type: HoroscopeType.MONTHLY,
                      child: const HoroscopeList(),
                    ),
                    HoroscopeProvider.horoscopeBlocProvider(
                      type: HoroscopeType.YEARLY,
                      child: const HoroscopeList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
