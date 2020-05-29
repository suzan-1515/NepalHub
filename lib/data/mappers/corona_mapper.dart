import 'package:samachar_hub/data/api/response/corona_api_response.dart';
import 'package:samachar_hub/data/models/models.dart';

class CoronaMapper {
  static CoronaWorldwideModel fromWorldwideApi(CoronaWorldwideApiResponse response) {
    return CoronaWorldwideModel(
        cases: response.cases,
        todayCases: response.todayCases,
        deaths: response.deaths,
        todayDeaths: response.todayDeaths,
        recovered: response.recovered,
        active: response.active,
        critical: response.critical,
        casesPerOneMillion: response.casesPerOneMillion,
        deathsPerOneMillion: response.deathsPerOneMillion,
        tests: response.tests,
        testsPerOneMillion: response.testsPerOneMillion,
        affectedCountries: response.affectedCountries,
        lastUpdated: response.formatedUpdatedDate);
  }

  static CoronaCountrySpecificModel fromCountryApi(
      CoronaCountrySpecificApiResponse response) {
    return CoronaCountrySpecificModel(
        country: response.country,
        continent: response.continent,
        countryInfo: response.countryInfo,
        cases: response.cases,
        todayCases: response.todayCases,
        deaths: response.deaths,
        todayDeaths: response.todayDeaths,
        recovered: response.recovered,
        active: response.active,
        critical: response.critical,
        casesPerOneMillion: response.casesPerOneMillion,
        deathsPerOneMillion: response.deathsPerOneMillion,
        tests: response.tests,
        testsPerOneMillion: response.testsPerOneMillion,
        updated: response.formatedUpdatedDate);
  }
}
