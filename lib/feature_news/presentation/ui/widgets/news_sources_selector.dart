import 'package:flutter/material.dart';

class NewsSourcesSelector extends StatelessWidget {
  const NewsSourcesSelector({
    Key key,
    @required this.selectedValue,
    @required this.onChanged,
    @required this.selections,
  }) : super(key: key);

  final String selectedValue;
  final Map<String, String> selections;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(
          'All Sources',
          style: Theme.of(context).textTheme.caption,
        ),
        items: selections.entries
            .map((e) => DropdownMenuItem<String>(
                  value: e.key,
                  child: Text(
                    e.value,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
