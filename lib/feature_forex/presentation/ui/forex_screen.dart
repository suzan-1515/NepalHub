import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_graph.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_list.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';

class ForexScreen extends StatelessWidget {
  Widget _buildDefaultCurrencyStat(BuildContext context) {
    return BlocBuilder<ForexBloc, ForexState>(
      buildWhen: (previous, current) =>
          (current is ForexInitialState || current is ForexLoadSuccessState),
      builder: (context, state) {
        if (state is ForexLoadSuccessState) {
          return ForexProvider.forexTimelineBlocProvider(
            currencyId: state.defaultForex.forexEntity.currency.id,
            child: BlocConsumer<ForexTimelineBloc, ForexTimelineState>(
              listener: (context, state) {
                if (state is ForexTimelineInitialState) {
                  context
                      .bloc<ForexTimelineBloc>()
                      .add(GetForexTimelineEvent());
                }
              },
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
        body: ForexList(),
      ),
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
                context
                    .repository<NavigationService>()
                    .toSettingsScreen(context: context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: _buildContent(context),
        ),
      ),
    );
  }
}
