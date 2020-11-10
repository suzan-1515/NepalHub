import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/empty_data_widget.dart';
import 'package:samachar_hub/core/widgets/error_data_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/latest/latest_gold_silver_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/gold_silver/widgets/gold_silver_list_builder.dart';

class GoldSilverList extends StatefulWidget {
  const GoldSilverList({
    Key key,
  }) : super(key: key);

  @override
  _GoldSilverListState createState() => _GoldSilverListState();
}

class _GoldSilverListState extends State<GoldSilverList> {
  @override
  void initState() {
    super.initState();
    context.read<GoldSilverBloc>().add(GetLatestGoldSilverEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoldSilverBloc, GoldSilverState>(
      listener: (context, state) {
        if (state is GoldSilverErrorState) {
          context.showMessage(state.message);
        } else if (state is GoldSilverLoadErrorState) {
          context.showMessage(state.message);
        }
      },
      buildWhen: (previous, current) => !(current is GoldSilverErrorState),
      builder: (context, state) {
        if (state is GoldSilverLoadSuccessState) {
          return GoldSilverListBuilder(
            data: state.goldSilverList,
          );
        } else if (state is GoldSilverEmptyState) {
          return Center(
            child: EmptyDataView(
              text: state.message,
            ),
          );
        } else if (state is GoldSilverLoadErrorState) {
          return Center(
            child: ErrorDataView(
              message: state.message,
              onRetry: () => context
                  .read<GoldSilverBloc>()
                  .add(GetLatestGoldSilverEvent()),
            ),
          );
        }
        return Center(child: ProgressView());
      },
    );
  }
}
