import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/news_model.dart';
import 'package:samachar_hub/data/models/sort.dart';
import 'package:samachar_hub/pages/news/widgets/news_sources_selector.dart';
import 'package:samachar_hub/widgets/sortby_selector.dart';

class NewsFilterView extends StatelessWidget {
  NewsFilterView({
    Key key,
    @required this.sources,
    @required this.onSourceChanged,
    @required this.onSortChanged,
    this.initialSortBy,
    this.initialSource,
  }) : super(key: key) {
    _initSourceOptions();
  }

  final List<NewsSource> sources;
  final Function(NewsSource) onSourceChanged;
  final Function(SortBy) onSortChanged;
  final SortBy initialSortBy;
  final NewsSource initialSource;

  final Map<String, String> sourceOptions = {};

  _initSourceOptions() {
    this.sourceOptions.clear();
    this.sourceOptions['all'] = 'All Sources';
    this.sources?.forEach(
          (element) => this.sourceOptions[element.code] = element.name,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                      width: 0.5, color: Theme.of(context).dividerColor),
                ),
              ),
              child: NewsSourcesSelector(
                onChanged: (value) {
                  final changedSourceModel = sources?.firstWhere(
                    (element) => element.code == value,
                    orElse: null,
                  );
                  if (changedSourceModel != null)
                    onSourceChanged(changedSourceModel);
                },
                options: this.sourceOptions,
                selectedValue: initialSource?.code ?? 'all',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SortBySelector(
                selectedValue: initialSortBy ?? SortBy.RELEVANCE,
                onChanged: onSortChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
