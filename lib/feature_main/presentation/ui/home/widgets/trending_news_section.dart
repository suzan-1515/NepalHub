import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/feature_main/presentation/models/home/trending_news_model.dart';
import 'package:samachar_hub/feature_main/presentation/ui/widgets/section_heading.dart';
import 'package:samachar_hub/feature_news/presentation/ui/widgets/news_compact_view.dart';

class TrendingNewsSection extends StatefulWidget {
  final TrendingNewsUIModel trendingNewsUIModel;
  const TrendingNewsSection({Key key, @required this.trendingNewsUIModel})
      : super(key: key);
  @override
  _TrendingNewsSectionState createState() => _TrendingNewsSectionState();
}

class _TrendingNewsSectionState extends State<TrendingNewsSection> {
  final ValueNotifier<int> _currentCarouselIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentCarouselIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List<Widget>.generate(
      widget.trendingNewsUIModel.feeds.length,
      (index) =>
          NewsCompactView(feedUIModel: widget.trendingNewsUIModel.feeds[index]),
    );

    return FadeInUp(
      duration: Duration(milliseconds: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SectionHeading(
            title: 'Trending News',
            subtitle: 'Current trending stories around you',
            onTap: () =>
                GetIt.I.get<NavigationService>().toTrendingNews(context),
          ),
          CarouselSlider(
              items: widgets,
              options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: _currentCarouselIndex.value,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 10),
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    _currentCarouselIndex.value = index;
                  })),
          ValueListenableBuilder(
            valueListenable: _currentCarouselIndex,
            builder: (_, int carouselIndex, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widgets.length,
                  (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: carouselIndex == index
                            ? Color.fromRGBO(0, 0, 0, 0.9)
                            : Color.fromRGBO(0, 0, 0, 0.4),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
