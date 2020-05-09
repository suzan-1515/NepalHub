import 'package:samachar_hub/data/api/response/forex_api_response.dart';
import 'package:samachar_hub/data/dto/forex_dto.dart';

class ForexMapper {
  static Forex fromApi(ForexApiResponse response) {
    return Forex(
        id: response.id,
        date: response.date,
        type: response.type,
        code: response.code,
        currency: response.currency,
        unit: response.unit,
        buying: response.buying,
        selling: response.selling,
        source: response.source,
        sourceUrl: response.sourceUrl,
        addedDate: response.addedDate);
  }
}
