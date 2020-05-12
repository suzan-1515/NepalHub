class HoroscopeApiResponse {
  final String copyright;
  final List<Np> np;

  HoroscopeApiResponse({this.copyright, this.np});

  factory HoroscopeApiResponse.fromJson(Map<String, dynamic> json) {
    return HoroscopeApiResponse(
      copyright: json['copyright'],
      np: (json['np'] as List)?.map((v) => Np.fromJson(v)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['copyright'] = this.copyright;
    if (this.np != null) {
      data['np'] = this.np.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Np {
  String type;
  String title;
  String author;
  String lang;
  String aries;
  String taurus;
  String gemini;
  String cancer;
  String leo;
  String virgo;
  String libra;
  String scorpio;
  String sagittarius;
  String capricorn;
  String aquarius;
  String pisces;
  String todate;

  Np(
      {this.type,
      this.title,
      this.author,
      this.lang,
      this.aries,
      this.taurus,
      this.gemini,
      this.cancer,
      this.leo,
      this.virgo,
      this.libra,
      this.scorpio,
      this.sagittarius,
      this.capricorn,
      this.aquarius,
      this.pisces,
      this.todate});

  Np.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    author = json['author'];
    lang = json['lang'];
    aries = json['aries'];
    taurus = json['taurus'];
    gemini = json['gemini'];
    cancer = json['cancer'];
    leo = json['leo'];
    virgo = json['virgo'];
    libra = json['libra'];
    scorpio = json['scorpio'];
    sagittarius = json['sagittarius'];
    capricorn = json['capricorn'];
    aquarius = json['aquarius'];
    pisces = json['pisces'];
    todate = json['todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['author'] = this.author;
    data['lang'] = this.lang;
    data['aries'] = this.aries;
    data['taurus'] = this.taurus;
    data['gemini'] = this.gemini;
    data['cancer'] = this.cancer;
    data['leo'] = this.leo;
    data['virgo'] = this.virgo;
    data['libra'] = this.libra;
    data['scorpio'] = this.scorpio;
    data['sagittarius'] = this.sagittarius;
    data['capricorn'] = this.capricorn;
    data['aquarius'] = this.aquarius;
    data['pisces'] = this.pisces;
    data['todate'] = this.todate;
    return data;
  }
}
