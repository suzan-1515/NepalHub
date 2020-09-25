enum Language { NEPALI, ENGLISH }

extension LanguageX on Language {
  String get value => this.toString().split('.')[0].toLowerCase();
}

extension LanguageParsingX on String {
  Language get toLanguage =>
      (this == 'nepali') ? Language.NEPALI : Language.ENGLISH;
}
