import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/latest/latest_gold_silver_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/timeline/gold_silver_timeline_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_graph.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_list.dart';
import 'package:samachar_hub/feature_gold/utils/provider.dart';

class GoldSilverScreen extends StatelessWidget {
  static Future navigate(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoldSilverProvider.goldSilverBlocProvider(
              child: GoldSilverScreen()),
        ));
  }

  Widget _buildDefaultTypeGraph(BuildContext context) {
    return BlocBuilder<GoldSilverBloc, GoldSilverState>(
      buildWhen: (previous, current) => (current is GoldSilverInitialState ||
          current is GoldSilverLoadSuccessState),
      builder: (context, state) {
        if (state is GoldSilverLoadSuccessState) {
          return GoldSilverProvider.goldSilverTimelineBlocProvider(
            goldSilver: state.defaultGoldSilver,
            child: BlocBuilder<GoldSilverTimelineBloc, GoldSilverTimelineState>(
              builder: (context, state1) {
                if (state1 is GoldSilverTimelineLoadSuccessState) {
                  return GoldSilverGraph(
                    timeline: state1.goldSilverList,
                  );
                } else if (state1 is GoldSilverTimeLineLoadingState) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Gold/Silver'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _buildDefaultTypeGraph(context),
              ),
            ],
            body: const GoldSilverList(),
          ),
        ),
      ),
    );
  }
}
