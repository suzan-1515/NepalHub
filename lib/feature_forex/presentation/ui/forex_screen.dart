import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_forex_timeline_use_case.dart';
import 'package:samachar_hub/feature_forex/domain/usecases/get_latest_forex_use_case.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_graph.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_list.dart';

class ForexScreen extends StatefulWidget {
  @override
  _ForexScreenState createState() => _ForexScreenState();
}

class _ForexScreenState extends State<ForexScreen> {
  Widget _buildDefaultCurrencyStat(BuildContext context) {
    return BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
      cubit: ForexTimelineBloc(
        getForexTimelineUseCase: context.repository<GetForexTimelineUseCase>(),
        currencyId:
            context.repository<PreferenceService>().defaultForexCurrency,
      ),
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
    return BlocProvider<ForexBloc>(
      create: (context) => ForexBloc(
        getLatestForexUseCase: context.repository<GetLatestForexUseCase>(),
      )..add(GetLatestForexEvent(
          defaultCurrencyId:
              context.repository<PreferenceService>().defaultForexCurrency)),
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
