import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_main/presentation/blocs/settings/settings_cubit.dart';
import 'package:samachar_hub/feature_main/presentation/ui/settings/widgets/settings_list.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (previous, current) =>
                (current is SettingsInitialState) ||
                (current is SettingsLoadSuccess),
            builder: (context, state) {
              if (state is SettingsLoadSuccess) {
                return SettingsList(settings: state.settingsEntity);
              }
              return Center(
                child: ProgressView(),
              );
            },
          ),
        ),
      ),
    );
  }
}
