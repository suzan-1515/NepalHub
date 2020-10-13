part of 'main_cubit.dart';

abstract class MainState extends Equatable {
  final int previousIndex;
  final int currentIndex;
  const MainState({@required this.currentIndex, @required this.previousIndex});

  @override
  List<Object> get props => [previousIndex, currentIndex];
}

class MainInitialState extends MainState {
  const MainInitialState(
      {@required int currentIndex, @required int previousIndex})
      : super(currentIndex: currentIndex, previousIndex: previousIndex);
}

class MainNavItemSelectionChangedState extends MainState {
  MainNavItemSelectionChangedState(
      {@required int currentIndex, @required int previousIndex})
      : super(currentIndex: currentIndex, previousIndex: previousIndex);
}
