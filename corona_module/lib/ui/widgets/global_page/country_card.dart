import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/country_detail_bloc/country_detail_bloc.dart';
import '../../../core/models/country.dart';
import '../../pages/country_details_page.dart';
import '../../styles/app_text_styles.dart';
import '../../styles/styles.dart';
import '../common/country_stat_chart.dart';
import '../common/fade_animator.dart';
import '../common/label.dart';

class CountryCard extends StatelessWidget {
  final Country country;

  const CountryCard({
    @required this.country,
  }) : assert(country != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: GestureDetector(
        onTap: () => _navigateToDetailsPage(context),
        child: Container(
          height: 128.0,
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(top: 12.0, right: 12.0, bottom: 12.0),
          decoration: BoxDecoration(
            color: AppColors.dark,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 12.0),
              _buildGraph(),
              _buildStats(),
            ],
          ),
        ),
      ),
    );
  }

  Flexible _buildStats() {
    return Flexible(
      flex: 2,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Hero(
              tag: country.name,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  country.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.mediumLight,
                ),
              ),
            ),
          ),
          const Divider(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: _buildStatColumn(),
          ),
        ],
      ),
    );
  }

  Column _buildStatColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCount('Active', Colors.yellow, country.activeCases),
        const SizedBox(height: 8.0),
        _buildCount('Recovered', Colors.green, country.totalRecovered),
        const SizedBox(height: 8.0),
        _buildCount('Deaths', Colors.red, country.totalDeaths),
      ],
    );
  }

  Widget _buildCount(String label, Color color, int count) {
    return Row(
      children: <Widget>[
        Label(text: label, color: color),
        const Spacer(),
        Text(
          count.toString(),
          style: AppTextStyles.smallLight.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildGraph() {
    return Flexible(
      flex: 1,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CountryStatChart(
            active: country.activeCases,
            recovered: country.totalRecovered,
            deaths: country.totalDeaths,
          ),
          Container(
            height: 48.0,
            width: 48.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              'https://www.countryflags.io/${country.code}/flat/48.png',
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailsPage(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.bloc<CountryDetailBloc>()..add(GetCountryDetailEvent(country: country));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.bloc<CountryDetailBloc>(),
          child: CountryDetailsPage(
            country: country,
          ),
        ),
      ),
    );
  }
}
