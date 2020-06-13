part of 'faq_bloc.dart';

@immutable
abstract class FaqState {}

class InitialFaqState extends FaqState {}

class LoadingFaqState extends FaqState {}

class LoadedFaqState extends FaqState {
  final List<Faq> faqs;

  LoadedFaqState({
    @required this.faqs,
  }) : assert(faqs != null);
}

class ErrorFaqState extends FaqState {
  final String message;

  ErrorFaqState({
    @required this.message,
  }) : assert(message != null);
}
