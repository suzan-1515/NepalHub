import 'package:flutter/material.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/news_read_mode.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            dense: true,
            onTap: () {
              context.showBottomSheet(
                child: NewsReadMode(),
              );
            },
            title: Text(
              'Default news read mode',
              style:
                  Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
            ),
            subtitle: Text(
              'Switches between summark view or detail view when opening a particular news.',
              softWrap: true,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
