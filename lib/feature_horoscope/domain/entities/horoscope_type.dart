enum HoroscopeType { DAILY, WEEKLY, MONTHLY, YEARLY }

extension HoroscopeTypeX on HoroscopeType {
  String get value => this.toString().split('.')[1].toLowerCase();
}

extension HoroscopeTypeParsingX on String {
  HoroscopeType get toHoroscopeType {
    switch (this) {
      case 'daily':
        return HoroscopeType.DAILY;
      case 'weekly':
        return HoroscopeType.WEEKLY;
        break;
      case 'monthly':
        return HoroscopeType.MONTHLY;
      case 'yearly':
        return HoroscopeType.YEARLY;
        break;
      default:
        throw Exception('Unknow horoscope type.');
    }
  }
}
