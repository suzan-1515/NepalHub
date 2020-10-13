import 'package:samachar_hub/feature_main/data/datasources/remote/home/remote_data_source.dart';
import 'package:samachar_hub/feature_main/domain/entities/home_entity.dart';
import 'package:samachar_hub/core/models/language.dart';
import 'package:samachar_hub/feature_main/domain/repositories/home/repository.dart';

class HomeRepository with Repository {
  final RemoteDataSource _remoteDataSource;

  HomeRepository(this._remoteDataSource);
  @override
  Future<HomeEntity> getHomeFeed({Language language}) {}
}
