import 'package:flutter/material.dart';
import 'package:samachar_hub/data/api/response/corona_api_response.dart';

class CoronaWorldwide {
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final double casesPerOneMillion;
  final double deathsPerOneMillion;
  final int tests;
  final double testsPerOneMillion;
  final int affectedCountries;
  final String lastUpdated;

  CoronaWorldwide(
      {@required this.cases,
      @required this.todayCases,
      @required this.deaths,
      @required this.todayDeaths,
      @required this.recovered,
      @required this.active,
      @required this.critical,
      @required this.casesPerOneMillion,
      @required this.deathsPerOneMillion,
      @required this.tests,
      @required this.testsPerOneMillion,
      @required this.affectedCountries,
      @required this.lastUpdated});

}

class CoronaCountrySpecific {
  final String updated;
  final String country;
  final CountryInfo countryInfo;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final double casesPerOneMillion;
  final double deathsPerOneMillion;
  final int tests;
  final double testsPerOneMillion;
  final String continent;

  CoronaCountrySpecific(
      {@required this.updated,
      @required this.country,
      @required this.countryInfo,
      @required this.cases,
      @required this.todayCases,
      @required this.deaths,
      @required this.todayDeaths,
      @required this.recovered,
      @required this.active,
      @required this.critical,
      @required this.casesPerOneMillion,
      @required this.deathsPerOneMillion,
      @required this.tests,
      @required this.testsPerOneMillion,
      @required this.continent});
}
