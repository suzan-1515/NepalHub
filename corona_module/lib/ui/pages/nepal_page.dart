import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/nepal_district_bloc/nepal_district_bloc.dart';
import '../../blocs/nepal_stats_bloc/nepal_stats_bloc.dart';
import '../styles/styles.dart';
import '../widgets/common/search_box.dart';
import '../widgets/indicators/busy_indicator.dart';
import '../widgets/indicators/empty_icon.dart';
import '../widgets/indicators/error_icon.dart';
import '../widgets/nepal_page/nepal_map_card.dart';
import '../widgets/nepal_page/nepal_stats_list.dart';

class NepalPage extends StatelessWidget {
  const NepalPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            const NepalMapCard(),
            SlidingUpPanel(
              color: AppColors.background,
              parallaxOffset: 0.3,
              isDraggable: true,
              backdropEnabled: true,
              parallaxEnabled: true,
              backdropTapClosesPanel: true,
              slideDirection: SlideDirection.UP,
              margin: EdgeInsets.zero,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              minHeight: 64.0,
              panelBuilder: _buildNepalStatsPanel,
            ),
            _buildDistrictSearchBox(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNepalStatsPanel(ScrollController sc) {
    return BlocBuilder<NepalStatsBloc, NepalStatsState>(
      builder: (context, state) {
        if (state is InitialNepalStatsState) {
          return const EmptyIcon();
        } else if (state is LoadedNepalStatsState) {
          return NepalStatsList(
            controller: sc,
            nepalStats: state.nepalStats,
          );
        } else if (state is ErrorNepalStatsState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildDistrictSearchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchBox(
        hintText: 'Search Districts',
        onChanged: (String value) {
          context.bloc<NepalDistrictBloc>()
            ..add(SearchDistrictEvent(
              searchTerm: value,
            ));
        },
      ),
    );
  }
}
