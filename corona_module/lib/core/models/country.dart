import 'package:flutter/foundation.dart';

import 'timeline_data.dart';


class Country {
  final String code;
  final String name;
  final double lat;
  final double lng;
  final int totalConfirmed;
  final int totalDeaths;
  final int totalRecovered;
  final int totalCritical;
  final int dailyConfirmed;
  final int dailyDeaths;
  final int confirmedPerMillion;
  final List<TimelineData> timeline;
  int get activeCases => totalConfirmed - totalDeaths - totalRecovered;

  Country({
    @required this.code,
    @required this.name,
    @required this.lat,
    @required this.lng,
    @required this.totalConfirmed,
    @required this.totalDeaths,
    @required this.totalRecovered,
    @required this.totalCritical,
    @required this.dailyConfirmed,
    @required this.dailyDeaths,
    @required this.confirmedPerMillion,
    @required this.timeline,
  })  : assert(code != null),
        assert(name != null),
        assert(lat != null),
        assert(lng != null),
        assert(totalConfirmed != null),
        assert(totalDeaths != null),
        assert(totalRecovered != null),
        assert(totalCritical != null),
        assert(dailyConfirmed != null),
        assert(dailyDeaths != null),
        assert(confirmedPerMillion != null),
        assert(timeline != null);

  bool get isValid =>
      code != 'Error' && lat != -1.0 && lng != -1.0 && totalConfirmed > 0 && activeCases >= 0;

  Country copyWith({
    String code,
    String name,
    double lat,
    double lng,
    int totalConfirmed,
    int totalDeaths,
    int totalRecovered,
    int totalCritical,
    int dailyConfirmed,
    int dailyDeaths,
    int confirmedPerMillion,
    List<TimelineData> timeline,
  }) {
    return Country(
      code: code ?? this.code,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      totalConfirmed: totalConfirmed ?? this.totalConfirmed,
      totalDeaths: totalDeaths ?? this.totalDeaths,
      totalRecovered: totalRecovered ?? this.totalRecovered,
      totalCritical: totalCritical ?? this.totalCritical,
      dailyConfirmed: dailyConfirmed ?? this.dailyConfirmed,
      dailyDeaths: dailyDeaths ?? this.dailyDeaths,
      confirmedPerMillion: confirmedPerMillion ?? this.confirmedPerMillion,
      timeline: timeline ?? this.timeline,
    );
  }

  static Country fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Country(
      code: map['countryCode'] ?? 'Error',
      name: map['country'],
      lat: map['lat'] == null ? -1.0 : (map['lat'] as num).toDouble(),
      lng: map['lng'] == null ? -1.0 : (map['lng'] as num).toDouble(),
      totalConfirmed: map['totalConfirmed'],
      totalDeaths: map['totalDeaths'],
      totalRecovered: map['totalRecovered'],
      totalCritical: map['totalCritical'],
      dailyConfirmed: map['dailyConfirmed'],
      dailyDeaths: map['dailyDeaths'],
      confirmedPerMillion: map['totalConfirmedPerMillionPopulation'] ?? 0,
      timeline: map.containsKey('timeline')
          ? List<TimelineData>.from(map['timeline']?.map((x) => TimelineData.fromMap(x)))
          : [],
    );
  }

  @override
  String toString() {
    return 'Country(code: $code, name: $name, lat: $lat, lng: $lng, totalConfirmed: $totalConfirmed, totalDeaths: $totalDeaths, totalRecovered: $totalRecovered, totalCritical: $totalCritical, activeCases: $activeCases, dailyConfirmed: $dailyConfirmed, dailyDeaths: $dailyDeaths, confirmedPerMillion: $confirmedPerMillion, timeline: $timeline)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Country &&
        o.code == code &&
        o.name == name &&
        o.lat == lat &&
        o.lng == lng &&
        o.totalConfirmed == totalConfirmed &&
        o.totalDeaths == totalDeaths &&
        o.totalRecovered == totalRecovered &&
        o.totalCritical == totalCritical &&
        o.activeCases == activeCases &&
        o.dailyConfirmed == dailyConfirmed &&
        o.dailyDeaths == dailyDeaths &&
        o.confirmedPerMillion == confirmedPerMillion &&
        listEquals(o.timeline, timeline);
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        totalConfirmed.hashCode ^
        totalDeaths.hashCode ^
        totalRecovered.hashCode ^
        totalCritical.hashCode ^
        activeCases.hashCode ^
        dailyConfirmed.hashCode ^
        dailyDeaths.hashCode ^
        confirmedPerMillion.hashCode ^
        timeline.hashCode;
  }
}
