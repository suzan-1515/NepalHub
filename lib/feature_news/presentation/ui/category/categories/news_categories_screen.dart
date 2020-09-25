import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_category/news_category_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/category/categories/widgets/news_category_list.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCategoriesScreen extends StatefulWidget {
  @override
  _NewsCategoriesScreenState createState() => _NewsCategoriesScreenState();
}

class _NewsCategoriesScreenState extends State<NewsCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<NewsCategoryBloc>().add(GetCategories());
  }

  Widget _buildCategoryList() {
    return BlocConsumer<NewsCategoryBloc, NewsCategoryState>(
        listener: (context, state) {
      if (state is Error) {
        context.showMessage(state.message);
      }
    }, builder: (context, state) {
      if (state is LoadSuccess) {
        return NewsCategoryList(data: state.categories);
      } else if (state is Error) {
        return Center(
          child: ErrorDataView(
            onRetry: () {
              context.bloc<NewsCategoryBloc>().add(GetCategories());
            },
          ),
        );
      } else if (state is Empty) {
        return Center(
          child: EmptyDataView(
            text: state.message,
          ),
        );
      }
      return Center(child: ProgressView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Categories',
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: _buildCategoryList(),
        ),
      ),
    );
  }
}
