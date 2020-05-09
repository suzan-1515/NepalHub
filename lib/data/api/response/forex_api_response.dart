class ForexApiResponse {
  final int id;
  final String date;
  final String type;
  final String code;
  final String currency;
  final int unit;
  final int buying;
  final double selling;
  final String source;
  final String sourceUrl;
  final String addedDate;

  ForexApiResponse(
      {this.id,
      this.date,
      this.type,
      this.code,
      this.currency,
      this.unit,
      this.buying,
      this.selling,
      this.source,
      this.sourceUrl,
      this.addedDate});

  factory ForexApiResponse.fromJson(Map<String, dynamic> json) {
    return ForexApiResponse(
      id: json['id'],
      date: json['date'],
      type: json['type'],
      code: json['code'],
      currency: json['currency'],
      unit: json['unit'],
      buying: json['buying'],
      selling: json['selling'],
      source: json['source'],
      sourceUrl: json['source_url'],
      addedDate: json['added_date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['type'] = this.type;
    data['code'] = this.code;
    data['currency'] = this.currency;
    data['unit'] = this.unit;
    data['buying'] = this.buying;
    data['selling'] = this.selling;
    data['source'] = this.source;
    data['source_url'] = this.sourceUrl;
    data['added_date'] = this.addedDate;
    return data;
  }
}
