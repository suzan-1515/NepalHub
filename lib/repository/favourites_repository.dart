import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/data/mappers/mappers.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/data/models/user_model.dart';
import 'package:samachar_hub/repository/post_meta_repository.dart';
import 'package:samachar_hub/services/favourites_firestore_service.dart';
import 'package:samachar_hub/services/services.dart';

class FavouritesRepository {
  final FavouritesFirestoreService _favouritesService;
  final AnalyticsService _analyticsService;
  final PreferenceService _preferenceService;

  static const int DATA_LIMIT = 20;

  FavouritesRepository(this._favouritesService,
      this._analyticsService, this._preferenceService);

  
}
