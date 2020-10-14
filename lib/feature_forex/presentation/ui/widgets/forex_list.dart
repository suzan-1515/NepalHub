import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/latest/latest_forex_bloc.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_list_builder.dart';

class ForexList extends StatelessWidget {
  const ForexList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForexBloc, ForexState>(
      listener: (context, state) {
        if (state is ForexInitialState) {
          context.bloc<ForexBloc>().add(GetLatestForexEvent());
        } else if (state is ForexErrorState) {
          context.showMessage(state.message);
        } else if (state is ForexLoadErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) => !(current is ForexErrorState),
      builder: (context, state) {
        if (state is ForexLoadSuccessState) {
          return ForexListBuilder(
            data: state.forexList,
            defaultForex: state.defaultForex,
          );
        } else if (state is ForexEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        } else if (state is ForexLoadErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () => context.bloc<ForexBloc>().add(
                    GetLatestForexEvent(),
                  ),
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
