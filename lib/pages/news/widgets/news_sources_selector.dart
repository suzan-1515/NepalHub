import 'package:flutter/material.dart';

class NewsSourcesSelector extends StatefulWidget {
  const NewsSourcesSelector({
    Key key,
    @required this.selectedValue,
    @required this.onChanged,
    @required this.options,
  }) : super(key: key);

  final String selectedValue;
  final Map<String, String> options;
  final Function(String) onChanged;

  @override
  _NewsSourcesSelectorState createState() => _NewsSourcesSelectorState();
}

class _NewsSourcesSelectorState extends State<NewsSourcesSelector> {
  String selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        items: widget.options.entries
            .map((e) => DropdownMenuItem<String>(
                  value: e.key,
                  child: Text(e.value),
                ))
            .toList(),
        onChanged: (String value) {
          setState(() {
            selectedValue = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
