import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class ForexApiResponse {
  ForexApiResponse({
    @required this.id,
    @required this.date,
    @required this.type,
    @required this.code,
    @required this.currency,
    @required this.unit,
    @required this.buying,
    @required this.selling,
    @required this.source,
    @required this.sourceUrl,
    @required this.addedDate,
    @required this.rawData,
  });

  final int id;
  final DateTime date;
  final Type type;
  final String code;
  final String currency;
  final int unit;
  final double buying;
  final double selling;
  final Source source;
  final String sourceUrl;
  final DateTime addedDate;
  final Map<String, dynamic> rawData;

  ForexApiResponse copyWith({
    int id,
    DateTime date,
    Type type,
    String code,
    String currency,
    int unit,
    double buying,
    double selling,
    Source source,
    String sourceUrl,
    DateTime addedDate,
    Map<String, dynamic> rawData,
  }) =>
      ForexApiResponse(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        code: code ?? this.code,
        currency: currency ?? this.currency,
        unit: unit ?? this.unit,
        buying: buying ?? this.buying,
        selling: selling ?? this.selling,
        source: source ?? this.source,
        sourceUrl: sourceUrl ?? this.sourceUrl,
        addedDate: addedDate ?? this.addedDate,
        rawData: rawData ?? this.rawData,
      );

  factory ForexApiResponse.fromRawJson(String str) =>
      ForexApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForexApiResponse.fromJson(Map<String, dynamic> json) =>
      ForexApiResponse(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        type: typeValues.map[json["type"]],
        code: json["code"],
        currency: json["currency"],
        unit: json["unit"],
        buying: json["buying"].toDouble(),
        selling: json["selling"].toDouble(),
        source: sourceValues.map[json["source"]],
        sourceUrl: json["source_url"],
        addedDate: DateTime.parse(json["added_date"]),
        rawData: json,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "type": typeValues.reverse[type],
        "code": code,
        "currency": currency,
        "unit": unit,
        "buying": buying,
        "selling": selling,
        "source": sourceValues.reverse[source],
        "source_url": sourceUrl,
        "added_date":
            "${addedDate.year.toString().padLeft(4, '0')}-${addedDate.month.toString().padLeft(2, '0')}-${addedDate.day.toString().padLeft(2, '0')}",
      };
}

enum Source { NEPAL_RASTRA_BANK }

final sourceValues =
    EnumValues({"Nepal Rastra Bank": Source.NEPAL_RASTRA_BANK});

enum Type { FIXED, OPEN }

final typeValues = EnumValues({"fixed": Type.FIXED, "open": Type.OPEN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
