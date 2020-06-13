import 'package:meta/meta.dart';

class TimelineData {
  final int confirmed;
  final int deaths;
  final int recovered;
  final String date;

  TimelineData({
    @required this.confirmed,
    @required this.deaths,
    @required this.recovered,
    @required this.date,
  })  : assert(confirmed != null),
        assert(deaths != null),
        assert(recovered != null),
        assert(date != null);

  TimelineData copyWith({
    int cases,
    int deaths,
    int recovered,
    String date,
  }) {
    return TimelineData(
      confirmed: cases ?? this.confirmed,
      deaths: deaths ?? this.deaths,
      recovered: recovered ?? this.recovered,
      date: date ?? this.date,
    );
  }

  static TimelineData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TimelineData(
      confirmed: map['confirmed'],
      deaths: map['deaths'],
      recovered: map['recovered'],
      date: map['date'],
    );
  }

  @override
  String toString() {
    return 'CountData(cases: $confirmed, deaths: $deaths, recovered: $recovered, date: $date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TimelineData &&
        o.confirmed == confirmed &&
        o.deaths == deaths &&
        o.recovered == recovered &&
        o.date == date;
  }

  @override
  int get hashCode {
    return confirmed.hashCode ^ deaths.hashCode ^ recovered.hashCode ^ date.hashCode;
  }
}
