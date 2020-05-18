import 'package:intl/intl.dart';

class CoronaWorldwideApiResponse {
  final int updated;
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

  CoronaWorldwideApiResponse(
      {this.updated,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.affectedCountries});

  factory CoronaWorldwideApiResponse.fromJson(Map<String, dynamic> json) {
    return CoronaWorldwideApiResponse(
      updated: json['updated'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['active'],
      critical: json['critical'],
      casesPerOneMillion: json['casesPerOneMillion'].toDouble(),
      deathsPerOneMillion: json['deathsPerOneMillion'].toDouble(),
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion'].toDouble(),
      affectedCountries: json['affectedCountries'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['tests'] = this.tests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    data['affectedCountries'] = this.affectedCountries;
    return data;
  }

  String get formatedUpdatedDate {
    var fomattedDate = 'N/A';
    try {
      fomattedDate = DateFormat.yMEd()
          .add_jms()
          .format(DateTime.fromMillisecondsSinceEpoch(updated));
    } catch (e) {}

    return fomattedDate;
  }
}

class CoronaCountrySpecificApiResponse {
  final int updated;
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

  CoronaCountrySpecificApiResponse(
      {this.updated,
      this.country,
      this.countryInfo,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.continent});

  factory CoronaCountrySpecificApiResponse.fromJson(Map<String, dynamic> json) {
    return CoronaCountrySpecificApiResponse(
      updated: json['updated'],
      country: json['country'],
      countryInfo: json['countryInfo'] != null
          ? new CountryInfo.fromJson(json['countryInfo'])
          : null,
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['active'],
      critical: json['critical'],
      casesPerOneMillion: json['casesPerOneMillion'].toDouble(),
      deathsPerOneMillion: json['deathsPerOneMillion'].toDouble(),
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion'].toDouble(),
      continent: json['continent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['country'] = this.country;
    if (this.countryInfo != null) {
      data['countryInfo'] = this.countryInfo.toJson();
    }
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['tests'] = this.tests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    data['continent'] = this.continent;
    return data;
  }

  String get formatedUpdatedDate {
    var fomattedDate = 'N/A';
    try {
      fomattedDate = DateFormat.yMEd()
          .add_jms()
          .format(DateTime.fromMillisecondsSinceEpoch(updated));
    } catch (e) {}

    return fomattedDate;
  }
}

class CountryInfo {
  final int id;
  final String iso2;
  final String iso3;
  final int lat;
  final int long;
  final String flag;

  CountryInfo({this.id, this.iso2, this.iso3, this.lat, this.long, this.flag});

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      id: json['_id'],
      iso2: json['iso2'],
      iso3: json['iso3'],
      lat: json['lat'],
      long: json['long'],
      flag: json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['flag'] = this.flag;
    return data;
  }
}
