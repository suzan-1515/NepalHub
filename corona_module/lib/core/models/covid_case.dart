import 'package:meta/meta.dart';

class CovidCase {
  final int id;
  final int age;
  final double lat;
  final double lng;
  final String gender;
  final String reportedOn;
  final String recoveredOn;
  final String deathOn;

  const CovidCase({
    @required this.id,
    @required this.age,
    @required this.lat,
    @required this.lng,
    @required this.gender,
    @required this.reportedOn,
    @required this.recoveredOn,
    @required this.deathOn,
  })  : assert(id != null),
        assert(lat != null),
        assert(lng != null),
        assert(reportedOn != null);

  CovidCase copyWith({
    int id,
    int age,
    double lat,
    double lng,
    String gender,
    String reportedOn,
    String recoveredOn,
    String deathOn,
  }) {
    return CovidCase(
      id: id ?? this.id,
      age: age ?? this.age,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      gender: gender ?? this.gender,
      reportedOn: reportedOn ?? this.reportedOn,
      recoveredOn: recoveredOn ?? this.recoveredOn,
      deathOn: deathOn ?? this.deathOn,
    );
  }

  static CovidCase fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CovidCase(
      id: map['id'],
      age: map['age'],
      lat: (map['point']['coordinates'][1] as num).toDouble(),
      lng: (map['point']['coordinates'][0] as num).toDouble(),
      gender: map['gender'],
      reportedOn: map['reportedOn'],
      recoveredOn: map['recoveredOn'],
      deathOn: map['deathOn'],
    );
  }

  @override
  String toString() {
    return 'DistrictCase(id: $id, age: $age, lat: $lat, lng: $lng, gender: $gender, reportedOn: $reportedOn, recoveredOn: $recoveredOn, deathOn: $deathOn)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CovidCase &&
        o.id == id &&
        o.age == age &&
        o.lat == lat &&
        o.lng == lng &&
        o.gender == gender &&
        o.reportedOn == reportedOn &&
        o.recoveredOn == recoveredOn &&
        o.deathOn == deathOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        age.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        gender.hashCode ^
        reportedOn.hashCode ^
        recoveredOn.hashCode ^
        deathOn.hashCode;
  }
}
