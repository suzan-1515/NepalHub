import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/models/app_error.dart';
import '../../core/models/faq.dart';
import '../../core/services/nepal_api_service.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final NepalApiService apiService;

  FaqBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(InitialFaqState());

  @override
  Stream<FaqState> mapEventToState(
    FaqEvent event,
  ) async* {
    if (event is GetFaqEvent) {
      yield LoadingFaqState();
      try {
        final List<Faq> faqs = await apiService.fetchFaqs(0);
        yield LoadedFaqState(
          faqs: faqs,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorFaqState(message: e.message);
      }
    }
  }
}
