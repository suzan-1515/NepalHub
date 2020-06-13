import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

import 'timeline_data.dart';

class NepalStats {
  final int total;
  final int positive;
  final int negative;
  final int isolation;
  final int quarantine;
  final int recovered;
  final int deaths;
  final int testedRdt;
  final List<TimelineData> timeline;
  int get active => positive - recovered - deaths;

  NepalStats({
    @required this.total,
    @required this.positive,
    @required this.negative,
    @required this.isolation,
    @required this.quarantine,
    @required this.recovered,
    @required this.deaths,
    @required this.testedRdt,
    @required this.timeline,
  })  : assert(total != null),
        assert(positive != null),
        assert(negative != null),
        assert(isolation != null),
        assert(quarantine != null),
        assert(recovered != null),
        assert(deaths != null),
        assert(testedRdt != null),
        assert(timeline != null);

  NepalStats copyWith({
    int total,
    int positive,
    int negative,
    int isolation,
    int quarantine,
    int recovered,
    int deaths,
    int pendingResult,
    List<TimelineData> timeline,
  }) {
    return NepalStats(
      total: total ?? this.total,
      positive: positive ?? this.positive,
      negative: negative ?? this.negative,
      isolation: isolation ?? this.isolation,
      quarantine: quarantine ?? this.quarantine,
      recovered: recovered ?? this.recovered,
      deaths: deaths ?? this.deaths,
      testedRdt: pendingResult ?? this.testedRdt,
      timeline: timeline ?? this.timeline,
    );
  }

  static NepalStats fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return NepalStats(
      total: map['tested_total'],
      positive: map['tested_positive'],
      negative: map['tested_negative'],
      isolation: map['in_isolation'],
      quarantine: map['quarantined'],
      recovered: map['recovered'],
      deaths: map['deaths'],
      testedRdt: map['tested_rdt'],
      timeline: map.containsKey('timeline')
          ? List<TimelineData>.from(map['timeline']?.map((x) => TimelineData.fromMap(x)))
          : [],
    );
  }

  @override
  String toString() {
    return 'NepalStats(total: $total, positive: $positive, negative: $negative, isolation: $isolation, quarantine: $quarantine, recovered: $recovered, deaths: $deaths, pendingResult: $testedRdt, timeline: $timeline)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NepalStats &&
        o.total == total &&
        o.positive == positive &&
        o.negative == negative &&
        o.isolation == isolation &&
        o.quarantine == quarantine &&
        o.recovered == recovered &&
        o.deaths == deaths &&
        o.testedRdt == testedRdt &&
        listEquals(o.timeline, timeline);
  }

  @override
  int get hashCode {
    return total.hashCode ^
        positive.hashCode ^
        negative.hashCode ^
        isolation.hashCode ^
        quarantine.hashCode ^
        recovered.hashCode ^
        deaths.hashCode ^
        testedRdt.hashCode ^
        timeline.hashCode;
  }
}
