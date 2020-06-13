import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/myth_bloc/myth_bloc.dart';
import '../../styles/styles.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';
import 'info_card.dart';

class MythList extends StatelessWidget {
  const MythList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MythBloc, MythState>(
      builder: (context, state) {
        if (state is InitialMythState) {
          return const EmptyIcon();
        } else if (state is LoadedMythState) {
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 64.0),
            separatorBuilder: (_, __) => const Divider(height: 0.0),
            itemCount: state.myths.length,
            itemBuilder: (_, index) {
              final myth = state.myths[index];
              return InfoCard(
                title: myth.myth,
                subTitle: myth.reality,
                tag: myth.sourceName,
                color: AppColors.accentColors[index % AppColors.accentColors.length],
              );
            },
          );
        } else if (state is ErrorMythState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }
}
