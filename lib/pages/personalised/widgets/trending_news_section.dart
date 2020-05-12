import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/common/store/trending_news_store.dart';
import 'package:samachar_hub/data/dto/dto.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/pages/widgets/section_heading.dart';

class TrendingNewsSection extends StatefulWidget {
  @override
  _TrendingNewsSectionState createState() => _TrendingNewsSectionState();
}

class _TrendingNewsSectionState extends State<TrendingNewsSection>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    Provider.of<TrendingNewsStore>(context, listen: false).loadPreviewData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<TrendingNewsStore>(
      builder: (BuildContext context, TrendingNewsStore store, Widget child) {
        return StreamBuilder<List<Feed>>(
            stream: store.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) return EmptyDataView();
                Size size = MediaQuery.of(context).size;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SectionHeadingView(
                      title: 'Trending News',
                      subtitle: 'Current trending stories around you',
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: List<Widget>.generate(snapshot.data.length,
                              (int index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: size.width / 2.5,
                                height: (size.width / 2.5) * 1.2,
                                child: Text(snapshot.data[index].title),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Center(child: ProgressView());
            });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
