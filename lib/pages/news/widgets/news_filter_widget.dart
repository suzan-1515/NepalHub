import 'package:flutter/material.dart';

class NewsFilter extends StatelessWidget {
  const NewsFilter({
    Key key,
  }) : super(key: key);

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
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'all',
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: 'all',
                      child: Text('All Sources'),
                    ),
                    DropdownMenuItem(
                      value: 'ONK',
                      child: Text('Online Khabar'),
                    ),
                  ],
                  onChanged: (String value) {},
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: 'recent',
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: 'recent',
                      child: Text('Recent'),
                    ),
                    DropdownMenuItem(
                      value: 'relevance',
                      child: Text('Relevance'),
                    ),
                  ],
                  onChanged: (String value) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
