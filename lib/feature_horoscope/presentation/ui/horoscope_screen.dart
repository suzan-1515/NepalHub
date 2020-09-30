import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/usecases/usecase.dart';
import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/dislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_daily_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_monthly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_weekly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/get_yearly_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/like_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/share_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/undislike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/unlike_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/domain/usecases/view_horoscope_use_case.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/widgets/horoscope_list.dart';

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

  UseCase _getDailyHoroscopeUseCase;
  UseCase _getWeeklyHoroscopeUseCase;
  UseCase _getMonthlyHoroscopeUseCase;
  UseCase _getYearlyHoroscopeUseCase;
  UseCase _likeHoroscopeUseCase;
  UseCase _unlikeHoroscopeUseCase;
  UseCase _dislikeHoroscopeUseCase;
  UseCase _undislikeHoroscopeUseCase;
  UseCase _shareHoroscopeUseCase;
  UseCase _viewHoroscopeUseCase;

  HoroscopeBloc _dailyHoroscopeBloc;
  HoroscopeBloc _weeklyHoroscopeBloc;
  HoroscopeBloc _monthlyHoroscopeBloc;
  HoroscopeBloc _yearlyHoroscopeBloc;

  @override
  void initState() {
    super.initState();
    _getDailyHoroscopeUseCase = context.repository<GetDailyHoroscopeUseCase>();
    _getWeeklyHoroscopeUseCase =
        context.repository<GetWeeklyHoroscopeUseCase>();
    _getMonthlyHoroscopeUseCase =
        context.repository<GetMonthlyHoroscopeUseCase>();
    _getYearlyHoroscopeUseCase =
        context.repository<GetYearlyHoroscopeUseCase>();
    _likeHoroscopeUseCase = context.repository<LikeHoroscopeUseCase>();
    _unlikeHoroscopeUseCase = context.repository<UnlikeHoroscopeUseCase>();
    _dislikeHoroscopeUseCase = context.repository<DislikeHoroscopeUseCase>();
    _undislikeHoroscopeUseCase =
        context.repository<UndislikeHoroscopeUseCase>();
    _shareHoroscopeUseCase = context.repository<ShareHoroscopeUseCase>();
    _viewHoroscopeUseCase = context.repository<ViewHoroscopeUseCase>();

    _dailyHoroscopeBloc = HoroscopeBloc(
      getDailyHoroscopeUseCase: _getDailyHoroscopeUseCase,
      getMonthlyHoroscopeUseCase: _getMonthlyHoroscopeUseCase,
      getWeeklyHoroscopeUseCase: _getWeeklyHoroscopeUseCase,
      getYearlyHoroscopeUseCase: _getYearlyHoroscopeUseCase,
      type: HoroscopeType.DAILY,
    );
    _weeklyHoroscopeBloc = HoroscopeBloc(
      getDailyHoroscopeUseCase: _getDailyHoroscopeUseCase,
      getMonthlyHoroscopeUseCase: _getMonthlyHoroscopeUseCase,
      getWeeklyHoroscopeUseCase: _getWeeklyHoroscopeUseCase,
      getYearlyHoroscopeUseCase: _getYearlyHoroscopeUseCase,
      type: HoroscopeType.WEEKLY,
    );
    _monthlyHoroscopeBloc = HoroscopeBloc(
      getDailyHoroscopeUseCase: _getDailyHoroscopeUseCase,
      getMonthlyHoroscopeUseCase: _getMonthlyHoroscopeUseCase,
      getWeeklyHoroscopeUseCase: _getWeeklyHoroscopeUseCase,
      getYearlyHoroscopeUseCase: _getYearlyHoroscopeUseCase,
      type: HoroscopeType.MONTHLY,
    );
    _yearlyHoroscopeBloc = HoroscopeBloc(
      getDailyHoroscopeUseCase: _getDailyHoroscopeUseCase,
      getMonthlyHoroscopeUseCase: _getMonthlyHoroscopeUseCase,
      getWeeklyHoroscopeUseCase: _getWeeklyHoroscopeUseCase,
      getYearlyHoroscopeUseCase: _getYearlyHoroscopeUseCase,
      type: HoroscopeType.YEARLY,
    );
  }

  Widget _buildBody() {
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
                BlocProvider<HoroscopeBloc>(
                  create: (context) => _dailyHoroscopeBloc,
                  child: HoroscopeList(),
                ),
                BlocProvider<HoroscopeBloc>(
                  create: (context) => _weeklyHoroscopeBloc,
                  child: HoroscopeList(),
                ),
                BlocProvider<HoroscopeBloc>(
                  create: (context) => _monthlyHoroscopeBloc,
                  child: HoroscopeList(),
                ),
                BlocProvider<HoroscopeBloc>(
                  create: (context) => _yearlyHoroscopeBloc,
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
