import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/services/preference_service.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_horoscope/presentation/blocs/horoscope/horoscope_bloc.dart';
import 'package:samachar_hub/feature_horoscope/presentation/ui/widgets/horoscope_list_builder.dart';

class HoroscopeList extends StatelessWidget {
  const HoroscopeList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HoroscopeBloc, HoroscopeState>(
      listener: (context, state) {
        if (state is HoroscopeErrorState) {
          context.showMessage(state.message);
        } else if (state is HoroscopeLoadErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) => !(current is HoroscopeErrorState),
      builder: (context, state) {
        if (state is HoroscopeLoadSuccessState) {
          return HoroscopeListBuilder(
            horoscopeUIModel: state.horoscope,
            defaultSignIndex: state.defaultSignIndex,
          );
        } else if (state is HoroscopeEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        } else if (state is HoroscopeLoadErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () => context.bloc<HoroscopeBloc>().add(
                    GetHoroscopeEvent(
                        defaultSignIndex: context
                            .repository<PreferenceService>()
                            .defaultZodiac),
                  ),
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
