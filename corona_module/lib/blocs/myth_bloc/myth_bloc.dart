import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/models/app_error.dart';
import '../../core/models/myth.dart';
import '../../core/services/nepal_api_service.dart';

part 'myth_event.dart';
part 'myth_state.dart';

class MythBloc extends Bloc<MythEvent, MythState> {
  final NepalApiService apiService;

  MythBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(InitialMythState());

  @override
  Stream<MythState> mapEventToState(
    MythEvent event,
  ) async* {
    if (event is GetMythEvent) {
      yield LoadingMythState();
      try {
        final List<Myth> myths = await apiService.fetchMyths(0);
        yield LoadedMythState(
          myths: myths,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorMythState(message: e.message);
      }
    }
  }
}
