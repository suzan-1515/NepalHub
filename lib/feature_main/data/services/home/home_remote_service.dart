import 'package:samachar_hub/core/network/http_manager/http_manager.dart';
import 'package:samachar_hub/feature_main/data/services/home/remote_service.dart';

class HomeRemoteService with RemoteService {
  final HttpManager _httpManager;

  HomeRemoteService(this._httpManager);
}
