enum HoroscopeType {
  DAILY,
  WEEKLY,
  MONTHLY,
  YEARKY,
}

extension HoroscopeTypeParsing on String {
  HoroscopeType parseAsHoroscopeType() {
    switch (this) {
      case 'D':
        return HoroscopeType.DAILY;
      case 'W':
        return HoroscopeType.WEEKLY;
      case 'M':
        return HoroscopeType.MONTHLY;
      case 'Y':
        return HoroscopeType.YEARKY;
      default:
        throw Exception('Indefined type name');
    }
  }
}
