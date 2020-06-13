import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import '../../core/models/app_error.dart';
import '../../core/models/country.dart';
import '../../core/services/global_api_service.dart';

part 'country_event.dart';
part 'country_state.dart';

enum CountryFilterType { Confirmed, Active, Recovered, Deaths }

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GlobalApiService apiService;
  List<Country> _countries = [];
  CountryFilterType _filterType = CountryFilterType.Confirmed;

  CountryBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  Stream<Transition<CountryEvent, CountryState>> transformEvents(
    Stream<CountryEvent> events,
    TransitionFunction<CountryEvent, CountryState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      transitionFn,
    );
  }

  @override
  CountryState get initialState => InitialCountryState();

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is GetCountryEvent) yield* _mapGetCountryToState();
    if (event is SearchCountryEvent) yield* _mapSearchCountryToState(event);
    if (event is FilterCountryEvent) yield* _mapFilterCountryToState(event.filterType);
  }

  Stream<CountryState> _mapGetCountryToState() async* {
    yield LoadingCountryState();
    try {
      _countries = await apiService.fetchCountries();
      _countries = _countries.where((c) => c.isValid).toList();
      yield LoadedCountryState(
        filterType: _filterType,
        allCountries: _countries,
        searchedCountries: null,
      );
    } on AppError catch (e) {
      print(e.error);
      yield ErrorCountryState(message: e.message);
    }
  }

  Stream<CountryState> _mapSearchCountryToState(SearchCountryEvent event) async* {
    if (event.searchTerm.isEmpty) {
      yield LoadedCountryState(
        filterType: _filterType,
        allCountries: _countries,
        searchedCountries: null,
      );
      return;
    }

    final List<Country> searchedCountries = _countries
        .where((c) => c.name.toLowerCase().contains(event.searchTerm.toLowerCase()))
        .toList();

    if (searchedCountries.isEmpty) {
      yield LoadedCountryState(
        filterType: _filterType,
        allCountries: _countries,
        searchedCountries: [],
      );
    }
    yield LoadedCountryState(
      filterType: _filterType,
      allCountries: _countries,
      searchedCountries: searchedCountries,
    );
  }

  Stream<CountryState> _mapFilterCountryToState(CountryFilterType filterType) async* {
    _filterType = filterType;
    yield LoadedCountryState(
      filterType: _filterType,
      allCountries: _countries,
      searchedCountries: (state as LoadedCountryState).searchedCountries,
    );
  }
}
