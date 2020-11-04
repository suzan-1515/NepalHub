import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:samachar_hub/core/models/language.dart';

import 'package:samachar_hub/feature_horoscope/domain/entities/horoscope_type.dart';

const HOROSCOPE_SIGNS = {
  Language.ENGLISH: [
    'Aries',
    'Taurus',
    'Gemini',
    'Cancer',
    'Leo',
    'Virgo',
    'Libra',
    'Scorpio',
    'Sagittarius',
    'Capricorn',
    'Aquarius',
    'Pisces',
  ],
  Language.NEPALI: [
    'मेष',
    'वृष',
    'मिथुन',
    'कर्कट',
    'सिंह',
    'कन्या',
    'तुला',
    'वृश्चिक',
    'धनु',
    'मकर',
    'कुम्भ',
    'मीन',
  ],
};
const HOROSCOPE_ICONS = [
  'https://www.ashesh.com.np/rashifal/images/1@2x.png',
  'https://www.ashesh.com.np/rashifal/images/2@2x.png',
  'https://www.ashesh.com.np/rashifal/images/3@2x.png',
  'https://www.ashesh.com.np/rashifal/images/4@2x.png',
  'https://www.ashesh.com.np/rashifal/images/5@2x.png',
  'https://www.ashesh.com.np/rashifal/images/6@2x.png',
  'https://www.ashesh.com.np/rashifal/images/7@2x.png',
  'https://www.ashesh.com.np/rashifal/images/8@2x.png',
  'https://www.ashesh.com.np/rashifal/images/9@2x.png',
  'https://www.ashesh.com.np/rashifal/images/10@2x.png',
  'https://www.ashesh.com.np/rashifal/images/11@2x.png',
  'https://www.ashesh.com.np/rashifal/images/12@2x.png',
];

class HoroscopeEntity extends Equatable {
  HoroscopeEntity({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.publishedAt,
    @required this.type,
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
    @required this.createdAt,
    @required this.updatedAt,
    @required this.isLiked,
    @required this.isCommented,
    @required this.isShared,
    @required this.isViewed,
    @required this.commentCount,
    @required this.likeCount,
    @required this.shareCount,
    @required this.viewCount,
  });

  final String id;
  final String title;
  final String author;
  final DateTime publishedAt;
  final HoroscopeType type;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isLiked;
  final bool isCommented;
  final bool isShared;
  final bool isViewed;
  final int commentCount;
  final int likeCount;
  final int shareCount;
  final int viewCount;

  HoroscopeEntity copyWith({
    String id,
    String title,
    String author,
    DateTime publishedAt,
    HoroscopeType type,
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
    DateTime createdAt,
    DateTime updatedAt,
    bool isLiked,
    bool isCommented,
    bool isShared,
    bool isViewed,
    int commentCount,
    int likeCount,
    int shareCount,
    int viewCount,
  }) =>
      HoroscopeEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        publishedAt: publishedAt ?? this.publishedAt,
        type: type ?? this.type,
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
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isLiked: isLiked ?? this.isLiked,
        isCommented: isCommented ?? this.isCommented,
        isShared: isShared ?? this.isShared,
        isViewed: isViewed ?? this.isViewed,
        commentCount: commentCount ?? this.commentCount,
        likeCount: likeCount ?? this.likeCount,
        shareCount: shareCount ?? this.shareCount,
        viewCount: viewCount ?? this.viewCount,
      );

  @override
  List<Object> get props => [
        id,
        title,
        author,
        publishedAt,
        type,
        aries,
        taurus,
        gemini,
        cancer,
        leo,
        virgo,
        libra,
        scorpio,
        sagittarius,
        capricorn,
        aquarius,
        pisces,
        createdAt,
        updatedAt,
        isLiked,
        isCommented,
        isShared,
        isViewed,
        commentCount,
        likeCount,
        shareCount,
        viewCount
      ];

  String get formattedDate => DateFormat('dd MMMM, yyyy').format(publishedAt);

  @override
  bool get stringify => true;
}
