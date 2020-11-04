import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list_builder.dart';
import 'package:samachar_hub/core/extensions/view.dart';

class NewsCategoryList extends StatefulWidget {
  const NewsCategoryList({
    Key key,
  }) : super(key: key);

  @override
  _NewsCategoryListState createState() => _NewsCategoryListState();
}

class _NewsCategoryListState extends State<NewsCategoryList> {
  Completer<void> _refreshCompleter;
  NewsCategoryBloc _newsCategoryBloc;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _newsCategoryBloc = context.bloc<NewsCategoryBloc>();
    _newsCategoryBloc.add(GetCategories());
  }

  @override
  void dispose() {
    _refreshCompleter?.complete();
    super.dispose();
  }

  Future<void> _onRefresh() {
    _newsCategoryBloc.add(RefreshCategories());
    return _refreshCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
      cubit: _newsCategoryBloc,
      listenWhen: (previous, current) =>
          !(current is NewsCategoryLoadingState) &&
          !(current is NewsCategoryRefreshingState),
      listener: (context, state) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
        if (state is NewsCategoryLoadErrorState) {
          context.showMessage(state.message);
        } else if (state is NewsCategoryErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) =>
          !(current is NewsCategoryErrorState) &&
          !(current is NewsCategoryRefreshingState),
      builder: (context, state) {
        if (state is NewsCategoryLoadSuccessState) {
          return NewsCategoryListBuilder(
            data: state.categories,
            onRefresh: _onRefresh,
          );
        } else if (state is NewsCategoryLoadErrorState) {
          return Center(
            child: ErrorDataView(
              onRetry: () {
                _newsCategoryBloc.add(GetCategories());
              },
            ),
          );
        } else if (state is NewsCategoryLoadEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
