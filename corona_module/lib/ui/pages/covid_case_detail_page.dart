import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

import '../../core/models/covid_case.dart';
import '../styles/styles.dart';
import '../widgets/common/map_card.dart';
import '../widgets/common/scale_animator.dart';


class CovidCaseDetailPage extends StatelessWidget {
  final CovidCase covidCase;
  final Color color;

  const CovidCaseDetailPage({
    @required this.covidCase,
    @required this.color,
  })  : assert(covidCase != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          _buildBackgroundMap(),
          _buildIndividualStats(),
        ],
      ),
    );
  }

  Widget _buildIndividualStats() {
    return ScaleAnimator(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, top: 120.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              covidCase.gender == 'male' ? LineAwesomeIcons.male : LineAwesomeIcons.female,
              size: 40.0,
              color: color,
            ),
            const SizedBox(height: 12.0),
            if (covidCase.age != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  '${covidCase.age.toString()} years',
                  style: AppTextStyles.mediumLight,
                ),
              ),
            if (covidCase.reportedOn != null)
              _buildDate(
                'Reported On :',
                covidCase.reportedOn,
                Colors.blue,
              ),
            if (covidCase.deathOn != null)
              _buildDate(
                'Died On :',
                covidCase.deathOn,
                Colors.red,
              ),
            if (covidCase.recoveredOn != null)
              _buildDate(
                'Recovered On :',
                covidCase.recoveredOn,
                Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDate(String label, String date, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.mediumLight.copyWith(color: color),
        ),
        const SizedBox(height: 8.0),
        Text(
          date,
          style: AppTextStyles.extraLargeLight.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildBackgroundMap() {
    return Container(
      foregroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.background,
            AppColors.background.withOpacity(0.8),
            AppColors.background.withOpacity(0.6),
            AppColors.background.withOpacity(0.4),
            AppColors.background.withOpacity(0.2),
            Colors.transparent,
          ],
          stops: [0.0, 0.3, 0.5, 0.6, 0.7, 1.0],
        ),
      ),
      child: MapCard(
        interactive: true,
        zoom: 15.0,
        minZoom: 12.0,
        maxZoom: 16.0,
        nePanBoundary: LatLng(covidCase.lat + 0.03, covidCase.lng + 0.03),
        swPanBoundary: LatLng(covidCase.lat - 0.03, covidCase.lng - 0.03),
        center: LatLng(covidCase.lat + 0.0025, covidCase.lng - 0.0012),
        searchLocation: () => null,
        markerLayerBuilder: () {
          return MarkerLayerOptions(
            markers: [
              Marker(
                height: 100.0,
                width: 100.0,
                point: LatLng(covidCase.lat, covidCase.lng),
                builder: (context) => ScaleAnimator(
                  duration: 1200,
                  child: Image.asset(
                    'lib/assets/images/marker.png',
                    color: color,
            package: 'corona_module',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
