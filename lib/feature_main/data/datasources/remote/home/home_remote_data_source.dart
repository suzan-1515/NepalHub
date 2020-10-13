import 'package:samachar_hub/feature_main/data/datasources/remote/home/remote_data_source.dart';
import 'package:samachar_hub/feature_main/data/services/home/remote_service.dart';

class HomeRemoteDataSource with RemoteDataSource {
  final RemoteService _remoteService;

  HomeRemoteDataSource(this._remoteService);
}
