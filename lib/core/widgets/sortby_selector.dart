import 'package:flutter/material.dart';
import 'package:samachar_hub/feature_news/domain/models/sort.dart';

class SortBySelector extends StatelessWidget {
  const SortBySelector({
    Key key,
    @required this.selectedValue,
    @required this.onChanged,
  }) : super(key: key);

  final SortBy selectedValue;
  final Function(SortBy) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<SortBy>(
        isExpanded: true,
        value: selectedValue,
        items: <DropdownMenuItem<SortBy>>[
          DropdownMenuItem(
            value: SortBy.RECENT,
            child: Text(
              'Recent',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          DropdownMenuItem(
            value: SortBy.RELEVANCE,
            child: Text(
              'Relevance',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          DropdownMenuItem(
            value: SortBy.POPULAR,
            child: Text(
              'Popular',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
