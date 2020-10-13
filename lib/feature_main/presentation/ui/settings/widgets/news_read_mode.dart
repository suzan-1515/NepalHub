import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';

class NewsReadMode extends StatelessWidget {
  const NewsReadMode({Key key}) : super(key: key);

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
    final settingsBloc = context.bloc<SettingsCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          title: Text('Default'),
          dense: true,
          onChanged: (bool value) {
            context.bloc<SettingsCubit>().setNewsReadMode(0);
            Navigator.pop(context);
          },
          value: settingsBloc.settings.newsReadMode == 0,
        ),
        CheckboxListTile(
          title: Text('Summary'),
          dense: true,
          onChanged: (bool value) {
            context.bloc<SettingsCubit>().setNewsReadMode(1);
            Navigator.pop(context);
          },
          value: settingsBloc.settings.newsReadMode == 1,
        ),
        CheckboxListTile(
          title: Text('Full News'),
          dense: true,
          onChanged: (bool value) {
            context.bloc<SettingsCubit>().setNewsReadMode(2);
            Navigator.pop(context);
          },
          value: settingsBloc.settings.newsReadMode == 2,
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
