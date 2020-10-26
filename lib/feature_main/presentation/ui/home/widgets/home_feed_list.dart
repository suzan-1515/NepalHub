import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/home/home_cubit.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/main/main_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/home/widgets/home_list_builder.dart';

class HomeFeedList extends StatefulWidget {
  const HomeFeedList({
    Key key,
  }) : super(key: key);

  @override
  _HomeFeedListState createState() => _HomeFeedListState();
}

class _HomeFeedListState extends State<HomeFeedList> {
  Completer<void> _refreshCompleter;
  ScrollController _scrollController;
  HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _scrollController = ScrollController();
    _homeCubit = context.bloc<HomeCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> _onRefresh() {
    _homeCubit.refreshHomeFeed(
        defaultForexCurrencyCode:
            context.bloc<SettingsCubit>().settings.defaultForexCurrency);
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listenWhen: (previous, current) =>
          current is MainNavItemSelectionChangedState,
      listener: (context, state) {
        if (state is MainNavItemSelectionChangedState) {
          if (state.currentIndex == 0 &&
              state.previousIndex == state.currentIndex) {
            _scrollToTop();
          }
        }
      },
      child: BlocConsumer<HomeCubit, HomeState>(
          cubit: _homeCubit,
          listener: (context, state) {
            if (!(state is HomeLoadingState)) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
            if (state is HomeLoadErrorState) {
              context.showMessage(state.message);
            } else if (state is HomeErrorState) {
              context.showMessage(state.message);
            }
          },
          buildWhen: (previous, current) => !(current is HomeErrorState),
          builder: (context, state) {
            if (state is HomeLoadSuccessState) {
              return HomeListBuilder(
                data: state.homeModel,
                onRefresh: _onRefresh,
                scrollController: _scrollController,
              );
            } else if (state is HomeEmptyState) {
              return Center(
                child: EmptyDataView(
                  text: state.message,
                ),
              );
            } else if (state is HomeLoadErrorState) {
              return Center(
                child: ErrorDataView(
                  onRetry: () => _homeCubit.getHomeFeed(
                      defaultForexCurrencyCode: context
                          .bloc<SettingsCubit>()
                          .settings
                          .defaultForexCurrency),
                ),
              );
            }
            return Center(child: ProgressView());
          }),
    );
  }
}
