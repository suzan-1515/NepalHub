import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/app_error.dart';
import '../models/country.dart';
import '../models/timeline_data.dart';
import 'api_service.dart';

class GlobalApiService extends ApiService {
  static const String COVID_API_BASE = 'https://covidapi.info/api/v1/';
  static const String CORONA_TRACKER_BASE = 'https://api.coronatracker.com/';

  Future<List<TimelineData>> fetchGlobalTimeline() async {
    try {
      http.Response res = await http.get(COVID_API_BASE + 'global/count');
      final Map<String, dynamic> resMap = jsonDecode(res.body)['result'];
      final List<Map<String, dynamic>> timelineList = flattenTimelineMap(resMap);
      return timelineList.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load timeline data!",
        error: e.toString(),
      );
    }
  }

  Future<List<Country>> fetchCountries() async {
    try {
      http.Response res = await http.get(CORONA_TRACKER_BASE + 'v3/stats/worldometer/country');
      final resMap = jsonDecode(res.body);
      return (resMap as List).map((m) => Country.fromMap(m as Map<String, dynamic>)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load countries!",
        error: e.toString(),
      );
    }
  }

  Future<List<TimelineData>> fetchCountryTimeline(String code) async {
    try {
      http.Response res = await http.get(COVID_API_BASE + 'country/$code');
      final Map<String, dynamic> resMap = jsonDecode(res.body)['result'];
      final List<Map<String, dynamic>> timelineList = flattenTimelineMap(resMap);
      return timelineList.map((m) => TimelineData.fromMap(m)).toList();
    } catch (e) {
      throw AppError(
        message: "Couldn't load country timeline data!",
        error: e.toString(),
      );
    }
  }
}
