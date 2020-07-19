import 'package:flutter/material.dart';
import 'package:samachar_hub/domain/sort.dart';

class SortBySelector extends StatefulWidget {
  const SortBySelector({
    Key key,
    @required this.selectedValue,
    @required this.onChanged,
  }) : super(key: key);

  final SortBy selectedValue;
  final Function(SortBy) onChanged;

  @override
  _SortBySelectorState createState() => _SortBySelectorState();
}

class _SortBySelectorState extends State<SortBySelector> {
  SortBy selectedValue = SortBy.RECENT;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<SortBy>(
        isExpanded: true,
        value: selectedValue,
        items: <DropdownMenuItem<SortBy>>[
          DropdownMenuItem(
            value: SortBy.RECENT,
            child: Text('Recent'),
          ),
          DropdownMenuItem(
            value: SortBy.RELEVANCE,
            child: Text('Relevance'),
          ),
          DropdownMenuItem(
            value: SortBy.POPULAR,
            child: Text('Popular'),
          ),
        ],
        onChanged: (SortBy value) {
          widget.onChanged(value);
          setState(() {
            selectedValue = value;
          });
        },
      ),
    );
  }
}
