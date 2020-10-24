import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_graph.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_list.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class ForexScreen extends StatelessWidget {
  Widget _buildDefaultCurrencyStat(BuildContext context) {
    return BlocBuilder<ForexBloc, ForexState>(
      buildWhen: (previous, current) =>
          (current is ForexInitialState || current is ForexLoadSuccessState),
      builder: (context, state) {
        if (state is ForexLoadSuccessState) {
          return ForexProvider.forexTimelineBlocProvider(
            forexUIModel: state.defaultForex,
            child: BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
              builder: (context, state) {
                if (state is ForexTimelineLoadSuccessState) {
                  return ForexGraph(
                    timeline: state.forexList,
                  );
                } else if (state is ForexTimeLineLoadingState) {
                  return Center(child: ProgressView());
                }
                return SizedBox.shrink();
              },
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(
            child: _buildDefaultCurrencyStat(context),
          ),
        ],
        body: const ForexList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.bloc<SettingsCubit>();
    return ForexProvider.forexBlocProvider(
      defaultCurrencyCode: settingsCubit.settings.defaultForexCurrency,
      child: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) =>
            current is SettingsDefaultForexCurrencyChangedState,
        listener: (context, state) {
          if (state is SettingsDefaultForexCurrencyChangedState) {
            context
                .bloc<ForexBloc>()
                .add(RefreshLatestForexEvent(defaultCurrencyCode: state.value));
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text('Forex'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  GetIt.I
                      .get<NavigationService>()
                      .toSettingsScreen(context: context);
                },
              ),
            ],
          ),
          body: SafeArea(
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }
}
