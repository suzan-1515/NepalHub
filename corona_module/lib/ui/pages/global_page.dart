import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../blocs/country_bloc/country_bloc.dart';
import '../styles/styles.dart';
import '../widgets/common/pill.dart';
import '../widgets/global_page/country_list.dart';
import '../widgets/global_page/global_map_card.dart';
import '../widgets/global_page/global_stats_tile.dart';


class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  double panelPos = 0.0;
  final double panelHeight = 90.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            const GlobalMapCard(),
            _buildFilterButton(),
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
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: panelHeight,
              onPanelSlide: (value) => setState(() {
                panelPos = value;
              }),
              panelBuilder: (sc) => _buildPanel(sc),
            ),
            Transform.translate(
              offset: Offset(-panelPos * MediaQuery.of(context).size.width, 0.0),
              child: GlobalStatsTile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Positioned(
      right: 10.0,
      bottom: panelHeight + 10.0,
      child: Transform.translate(
        offset: Offset(panelPos * MediaQuery.of(context).size.width, 0.0),
        child: CircleAvatar(
          child: PopupMenuButton<CountryFilterType>(
              icon: Icon(Icons.filter_list),
              onSelected: (filterType) {
                context.bloc<CountryBloc>().add(FilterCountryEvent(filterType: filterType));
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: CountryFilterType.Confirmed,
                    child: Text(
                      'Confirmed',
                      style: AppTextStyles.smallDark.copyWith(color: Colors.blue),
                    ),
                  ),
                  PopupMenuItem(
                    value: CountryFilterType.Active,
                    child: Text(
                      'Active',
                      style: AppTextStyles.smallDark.copyWith(color: Colors.yellow),
                    ),
                  ),
                  PopupMenuItem(
                    value: CountryFilterType.Recovered,
                    child: Text(
                      'Recovered',
                      style: AppTextStyles.smallDark.copyWith(color: Colors.green),
                    ),
                  ),
                  PopupMenuItem(
                    value: CountryFilterType.Deaths,
                    child: Text(
                      'Deaths',
                      style: AppTextStyles.smallDark.copyWith(color: Colors.red),
                    ),
                  ),
                ];
              }),
        ),
      ),
    );
  }

  Widget _buildPanel(ScrollController sc) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 4.0),
        const Pill(),
        Expanded(
          child: CountryList(controller: sc),
        ),
      ],
    );
  }
}
