import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/store/trending_news_store.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/news_compact_view.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';

class TrendingNewsSection extends StatefulWidget {
  @override
  _TrendingNewsSectionState createState() => _TrendingNewsSectionState();
}

class _TrendingNewsSectionState extends State<TrendingNewsSection> {
  final ValueNotifier<int> _currentCorousel = ValueNotifier<int>(0);

  @override
  void initState() {
    Provider.of<TrendingNewsStore>(context, listen: false).loadPreviewData();
    super.initState();
  }

  @override
  void dispose() {
    _currentCorousel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrendingNewsStore>(
      builder: (BuildContext context, TrendingNewsStore store, Widget child) {
        return StreamBuilder<List<Feed>>(
            stream: store.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) return EmptyDataView();
                List<Widget> widgets = List<Widget>.generate(
                  snapshot.data.length,
                  (index) => NewsCompactView(snapshot.data[index]),
                );

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SectionHeadingView(
                      title: 'Trending News',
                      subtitle: 'Current trending stories around you',
                      onTap: (){
                        
                      },
                    ),
                    CarouselSlider(
                        items: widgets,
                        options: CarouselOptions(
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              _currentCorousel.value = index;
                            })),
                    ValueListenableBuilder(
                      valueListenable: _currentCorousel,
                      builder: (BuildContext context, int value, Widget child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                            widgets.length,
                            (index) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: value == index
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
                );
              }
              return SizedBox.shrink();
            });
      },
    );
  }
}
