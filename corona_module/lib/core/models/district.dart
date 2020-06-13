import 'package:flutter/foundation.dart';


import 'covid_case.dart';

class District {
  final int id;
  final String title;
  final int province;
  final double lat;
  final double lng;
  final List<CovidCase> cases;

  const District({
    @required this.id,
    @required this.title,
    @required this.province,
    @required this.lat,
    @required this.lng,
    @required this.cases,
  })  : assert(id != null),
        assert(title != null),
        assert(province != null),
        assert(lat != null),
        assert(lng != null),
        assert(cases != null);

  District copyWith({
    int id,
    String title,
    int province,
    double lat,
    double lng,
    List<CovidCase> cases,
  }) {
    return District(
      id: id ?? this.id,
      title: title ?? this.title,
      province: province ?? this.province,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      cases: cases ?? this.cases,
    );
  }

  static District fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return District(
      id: map['id'],
      title: map['title'],
      province: map['province'],
      lat: (map['centroid']['coordinates'][1] as num).toDouble(),
      lng: (map['centroid']['coordinates'][0] as num).toDouble(),
      cases: List<CovidCase>.from(map['covid_cases']?.map((x) => CovidCase.fromMap(x))),
    );
  }

  @override
  String toString() {
    return 'District(id: $id, title: $title, province: $province, lat: $lat, lng: $lng, cases: $cases)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is District &&
        o.id == id &&
        o.title == title &&
        o.province == province &&
        o.lat == lat &&
        o.lng == lng &&
        listEquals(o.cases, cases);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        province.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        cases.hashCode;
  }
}
