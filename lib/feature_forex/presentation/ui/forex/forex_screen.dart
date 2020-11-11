import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_graph.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex/widgets/forex_list.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/settings_page.dart';

class ForexScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/forex';
  Widget _buildDefaultCurrencyStat() {
    return BlocBuilder<ForexBloc, ForexState>(
      buildWhen: (previous, current) =>
          (current is ForexInitialState || current is ForexLoadSuccessState),
      builder: (context, state) {
        if (state is ForexLoadSuccessState) {
          return ForexProvider.forexTimelineBlocProvider(
            forexUIModel: state.defaultForex,
            child: BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (previous, current) =>
                  current is SettingsDefaultForexCurrencyChangedState,
              listener: (context, state1) {
                if (state1 is SettingsDefaultForexCurrencyChangedState) {
                  var forex = state.forexList.firstWhere(
                      (element) => element.entity.currency.code == state1.value,
                      orElse: () => state.defaultForex);
                  context
                      .read<ForexTimelineBloc>()
                      .add(RefreshForexTimelineEvent(forex: forex.entity));
                }
              },
              child: BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
                builder: (context, state1) {
                  if (state1 is ForexTimelineLoadSuccessState) {
                    return ForexGraph(
                      timeline: state1.forexList,
                    );
                  } else if (state1 is ForexTimeLineLoadingState) {
                    return Center(child: ProgressView());
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ForexProvider.forexBlocProvider(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Forex'),
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
            padding: const EdgeInsets.all(8.0),
            child: NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverToBoxAdapter(
                  child: _buildDefaultCurrencyStat(),
                ),
              ],
              body: const ForexList(),
            ),
          ),
        ),
      ),
    );
  }
}
