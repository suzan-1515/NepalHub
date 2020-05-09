import 'package:samachar_hub/data/api/response/corona_api_response.dart';
import 'package:samachar_hub/data/dto/dto.dart';

class CoronaMapper {
  static CoronaWorldwide fromWorldwideApi(CoronaWorldwideApiResponse response) {
    return CoronaWorldwide(
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

  static CoronaCountrySpecific fromCountryApi(
      CoronaCountrySpecificApiResponse response) {
    return CoronaCountrySpecific(
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
