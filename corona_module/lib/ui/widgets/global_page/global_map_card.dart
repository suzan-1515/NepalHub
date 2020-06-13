import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/country_bloc/country_bloc.dart';
import '../../../blocs/country_detail_bloc/country_detail_bloc.dart';
import '../../../core/models/country.dart';
import '../../../core/services/global_api_service.dart';
import '../../pages/country_details_page.dart';
import '../common/map_card.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';

class GlobalMapCard extends StatelessWidget {
  const GlobalMapCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is InitialCountryState) {
          return const EmptyIcon();
        } else if (state is LoadedCountryState) {
          return _buildMap(state);
        } else if (state is ErrorCountryState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildMap(LoadedCountryState state) {
    return MapCard(
      zoom: 3.0,
      minZoom: 2.0,
      maxZoom: 6.0,
      markerLayerBuilder: () => _buildMarkers(state),
      searchLocation: () {
        if (!state.shouldShowAllCountries && !state.isSearchEmpty)
          return LatLng(
            state.searchedCountries.first.lat,
            state.searchedCountries.first.lng,
          );
        return null;
      },
    );
  }

  MarkerLayerOptions _buildMarkers(LoadedCountryState state) {
    return MarkerLayerOptions(
      markers: state.allCountries.map(
        (c) {
          int metric;
          Color color;

          switch (state.filterType) {
            case CountryFilterType.Confirmed:
              metric = c.totalConfirmed;
              color = Colors.blue;
              break;
            case CountryFilterType.Active:
              metric = c.activeCases;
              color = Colors.yellow;
              break;
            case CountryFilterType.Recovered:
              metric = c.totalRecovered;
              color = Colors.green;
              break;
            case CountryFilterType.Deaths:
              metric = c.totalDeaths;
              color = Colors.red;
              break;

            default:
          }

          double diameter = (math.sqrt(metric.toDouble()) / 8.0).clamp(8.0, 120.0);
          return Marker(
            height: diameter,
            width: diameter,
            point: LatLng(c.lat, c.lng),
            builder: (context) => GestureDetector(
              onTap: () => _navigateToDetailsPage(context, c),
              child: CircleAvatar(
                backgroundColor: state.isCountryInSearch(c)
                    ? Colors.deepPurple.withOpacity(0.4)
                    : color.withOpacity(0.4),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  void _navigateToDetailsPage(BuildContext context, Country country) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => CountryDetailBloc(
            apiService: context.repository<GlobalApiService>(),
          )..add(GetCountryDetailEvent(country: country)),
          child: CountryDetailsPage(
            country: country,
          ),
        ),
      ),
    );
  }
}
