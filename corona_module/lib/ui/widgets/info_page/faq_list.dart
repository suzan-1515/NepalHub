import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/faq_bloc/faq_bloc.dart';
import '../../styles/styles.dart';
import '../indicators/busy_indicator.dart';
import '../indicators/empty_icon.dart';
import '../indicators/error_icon.dart';
import 'info_card.dart';


class FaqList extends StatelessWidget {
  const FaqList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqBloc, FaqState>(
      builder: (context, state) {
        if (state is InitialFaqState) {
          return const EmptyIcon();
        } else if (state is LoadedFaqState) {
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 64.0),
            separatorBuilder: (_, __) => const Divider(height: 0.0),
            itemCount: state.faqs.length,
            itemBuilder: (_, index) {
              final faq = state.faqs[index];
              return InfoCard(
                title: faq.question,
                subTitle: faq.answer,
                tag: faq.category,
                color: AppColors.accentColors[index % AppColors.accentColors.length],
              );
            },
          );
        } else if (state is ErrorFaqState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }
}
