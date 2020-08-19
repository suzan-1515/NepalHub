import 'package:flutter/material.dart';
import 'package:samachar_hub/pages/settings/settings_store.dart';

class NewsReadMode extends StatelessWidget {
  final SettingsStore store;

  const NewsReadMode({
    Key key,
    @required this.store,
  }) : super(key: key);

  Widget _buildTitle(BuildContext context) {
    return Text(
      'News read mode',
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildModes(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: Text('Default'),
          dense: true,
          onChanged: (bool value) {
            store.newsReadMode = 0;
            Navigator.pop(context);
          },
          value: store.newsReadMode == 0,
        ),
        CheckboxListTile(
          title: Text('Summary'),
          dense: true,
          onChanged: (bool value) {
            store.newsReadMode = 1;
            Navigator.pop(context);
          },
          value: store.newsReadMode == 1,
        ),
        CheckboxListTile(
          title: Text('Full News'),
          dense: true,
          onChanged: (bool value) {
            store.newsReadMode = 2;
            Navigator.pop(context);
          },
          value: store.newsReadMode == 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(context),
          SizedBox(height: 16),
          _buildModes(context),
        ],
      ),
    );
  }
}
