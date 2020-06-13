import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import '../../core/models/app_error.dart';
import '../../core/models/hospital.dart';
import '../../core/services/nepal_api_service.dart';


part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final NepalApiService apiService;
  List<Hospital> _hospitals;

  HospitalBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  Stream<Transition<HospitalEvent, HospitalState>> transformEvents(
    Stream<HospitalEvent> events,
    TransitionFunction<HospitalEvent, HospitalState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      transitionFn,
    );
  }

  @override
  HospitalState get initialState => InitialHospitalState();

  @override
  Stream<HospitalState> mapEventToState(
    HospitalEvent event,
  ) async* {
    if (event is GetHospitalEvent) {
      yield* _mapGetHospitalToState();
    }
    if (event is SearchHospitalEvent) {
      yield* _mapSearchHospitalToState(event);
    }
  }

  Stream<HospitalState> _mapGetHospitalToState() async* {
    yield LoadingHospitalState();
    try {
      _hospitals = await apiService.fetchHospitals(0);
      _hospitals = _hospitals.where((h) => h.isValid).toList();
      yield LoadedHospitalState(hospitals: _hospitals);
    } on AppError catch (e) {
      print(e.error);
      yield ErrorHospitalState(message: e.message);
    }
  }

  Stream<HospitalState> _mapSearchHospitalToState(SearchHospitalEvent event) async* {
    if (event.searchTerm.isEmpty) {
      yield LoadedHospitalState(hospitals: _hospitals);
    }
    yield LoadingHospitalState();

    final List<Hospital> searchedHospitals = _hospitals
        .where((h) => h.name.toLowerCase().contains(event.searchTerm.toLowerCase()))
        .toList();

    if (searchedHospitals.isEmpty) {
      yield InitialHospitalState();
    }
    yield LoadedHospitalState(hospitals: searchedHospitals);
  }
}
