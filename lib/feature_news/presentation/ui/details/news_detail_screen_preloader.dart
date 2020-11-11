import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_main/presentation/ui/splash/widgets/splash_view.dart';
import 'package:samachar_hub/feature_news/presentation/blocs/news_detail/news_detail_bloc.dart';
import 'package:samachar_hub/feature_news/presentation/ui/details/news_detail_screen.dart';
import 'package:samachar_hub/feature_news/presentation/extensions/news_extensions.dart';
import 'package:samachar_hub/feature_news/utils/provider.dart';

class NewsDetailScreenPreloader extends StatelessWidget {
  static const String ROUTE_NAME = '/news-detail-preloader';
  @override
  Widget build(BuildContext context) {
    final String feedId = ModalRoute.of(context).settings.arguments;
    return NewsProvider.detailBlocProvider(
      feedId: feedId,
      child: Scaffold(
        body: BlocListener<NewsDetailBloc, NewsDetailState>(
          listener: (context, state) {
            if (state is NewsDetailLoadSuccessState) {
              Navigator.pushReplacementNamed(
                  context, NewsDetailScreen.ROUTE_NAME,
                  arguments: state.feed.toUIModel);
            } else if (state is NewsDetailErrorState) {
              Navigator.pop(context);
            }
          },
          child: const SplashView(),
        ),
      ),
    );
  }
}
