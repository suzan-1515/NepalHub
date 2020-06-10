
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class HoroscopeApiResponse {
    HoroscopeApiResponse({
        @required this.copyright,
        @required this.np,
    });

    final String copyright;
    final List<Np> np;

    HoroscopeApiResponse copyWith({
        String copyright,
        List<Np> np,
    }) => 
        HoroscopeApiResponse(
            copyright: copyright ?? this.copyright,
            np: np ?? this.np,
        );

    factory HoroscopeApiResponse.fromRawJson(String str) => HoroscopeApiResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HoroscopeApiResponse.fromJson(Map<String, dynamic> json) => HoroscopeApiResponse(
        copyright: json["copyright"],
        np: List<Np>.from(json["np"].map((x) => Np.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "copyright": copyright,
        "np": List<dynamic>.from(np.map((x) => x.toJson())),
    };
}

class Np {
    Np({
        @required this.type,
        @required this.title,
        @required this.author,
        @required this.lang,
        @required this.aries,
        @required this.taurus,
        @required this.gemini,
        @required this.cancer,
        @required this.leo,
        @required this.virgo,
        @required this.libra,
        @required this.scorpio,
        @required this.sagittarius,
        @required this.capricorn,
        @required this.aquarius,
        @required this.pisces,
        @required this.todate,
    });

    final String type;
    final String title;
    final String author;
    final String lang;
    final String aries;
    final String taurus;
    final String gemini;
    final String cancer;
    final String leo;
    final String virgo;
    final String libra;
    final String scorpio;
    final String sagittarius;
    final String capricorn;
    final String aquarius;
    final String pisces;
    final DateTime todate;

    Np copyWith({
        String type,
        String title,
        String author,
        String lang,
        String aries,
        String taurus,
        String gemini,
        String cancer,
        String leo,
        String virgo,
        String libra,
        String scorpio,
        String sagittarius,
        String capricorn,
        String aquarius,
        String pisces,
        DateTime todate,
    }) => 
        Np(
            type: type ?? this.type,
            title: title ?? this.title,
            author: author ?? this.author,
            lang: lang ?? this.lang,
            aries: aries ?? this.aries,
            taurus: taurus ?? this.taurus,
            gemini: gemini ?? this.gemini,
            cancer: cancer ?? this.cancer,
            leo: leo ?? this.leo,
            virgo: virgo ?? this.virgo,
            libra: libra ?? this.libra,
            scorpio: scorpio ?? this.scorpio,
            sagittarius: sagittarius ?? this.sagittarius,
            capricorn: capricorn ?? this.capricorn,
            aquarius: aquarius ?? this.aquarius,
            pisces: pisces ?? this.pisces,
            todate: todate ?? this.todate,
        );

    factory Np.fromRawJson(String str) => Np.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    String get formattedDate => DateFormat('dd MMM, yyyy').format(todate);

    factory Np.fromJson(Map<String, dynamic> json) => Np(
        type: json["type"],
        title: json["title"],
        author: json["author"],
        lang: json["lang"],
        aries: json["aries"],
        taurus: json["taurus"],
        gemini: json["gemini"],
        cancer: json["cancer"],
        leo: json["leo"],
        virgo: json["virgo"],
        libra: json["libra"],
        scorpio: json["scorpio"],
        sagittarius: json["sagittarius"],
        capricorn: json["capricorn"],
        aquarius: json["aquarius"],
        pisces: json["pisces"],
        todate: DateTime.parse(json["todate"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "author": author,
        "lang": lang,
        "aries": aries,
        "taurus": taurus,
        "gemini": gemini,
        "cancer": cancer,
        "leo": leo,
        "virgo": virgo,
        "libra": libra,
        "scorpio": scorpio,
        "sagittarius": sagittarius,
        "capricorn": capricorn,
        "aquarius": aquarius,
        "pisces": pisces,
        "todate": "${todate.year.toString().padLeft(4, '0')}-${todate.month.toString().padLeft(2, '0')}-${todate.day.toString().padLeft(2, '0')}",
    };
}
