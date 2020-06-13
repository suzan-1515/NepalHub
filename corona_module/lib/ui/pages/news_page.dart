import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_coverflow/simple_coverflow.dart';

import '../../blocs/news_bloc/news_bloc.dart';
import '../styles/styles.dart';
import '../widgets/indicators/busy_indicator.dart';
import '../widgets/indicators/empty_icon.dart';
import '../widgets/indicators/error_icon.dart';
import '../widgets/news_page/news_card.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    context.bloc<NewsBloc>()..add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'NEWS',
          maxLines: 3,
          style: AppTextStyles.extraLargeLight.copyWith(
            fontSize: 32.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, bottom: 80.0),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is InitialNewsState) {
              return const EmptyIcon();
            } else if (state is LoadedNewsState) {
              return _buildNewsList(state);
            } else if (state is ErrorNewsState) {
              return ErrorIcon(message: state.message);
            } else {
              return const BusyIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildNewsList(LoadedNewsState state) {
    return CoverFlow(
      dismissibleItems: false,
      viewportFraction: 0.85,
      itemCount: state.news.length,
      itemBuilder: (context, index) => NewsCard(
        news: state.news[index],
        color: AppColors.accentColors[index % AppColors.accentColors.length],
      ),
    );
  }
}
