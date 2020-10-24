import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/widgets/horoscope_list.dart';
import 'package:samachar_hub/feature_horoscope/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class HoroscopeScreen extends StatefulWidget {
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

  Widget _buildBody() {
    final settings = context.bloc<SettingsCubit>().settings;
    return Padding(
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
                  child: HoroscopeList(),
                ),
                HoroscopeProvider.horoscopeBlocProvider(
                  type: HoroscopeType.WEEKLY,
                  child: HoroscopeList(),
                ),
                HoroscopeProvider.horoscopeBlocProvider(
                  type: HoroscopeType.MONTHLY,
                  child: HoroscopeList(),
                ),
                HoroscopeProvider.horoscopeBlocProvider(
                  type: HoroscopeType.YEARLY,
                  child: HoroscopeList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
              context
                  .repository<NavigationService>()
                  .toSettingsScreen(context: context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }
}
