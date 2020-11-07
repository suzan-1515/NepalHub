import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_placeholder_widget.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/models/forex_model.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/widgets/forex_comment.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/widgets/latest_rate_info.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/forex_detail/widgets/rate_timeline.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class ForexDetailScreen extends StatelessWidget {
  final ForexUIModel forexUIModel;
  const ForexDetailScreen({Key key, @required this.forexUIModel})
      : assert(forexUIModel != null, 'Forex cannot be null.'),
        super(key: key);

  static Future navigate(
      {@required BuildContext context, @required ForexUIModel forexUIModel}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForexDetailScreen(
            forexUIModel: forexUIModel,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ForexProvider.forexDetailBlocProvider(
      forex: forexUIModel.entity,
      child: ScopedModel<ForexUIModel>(
        model: forexUIModel,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ForexTimelineBloc, ForexTimelineState>(
              listener: (context, state) {
                if (state is ForexTimelineLoadErrorState) {
                  context.showMessage(state.message);
                } else if (state is ForexTimelineErrorState) {
                  context.showMessage(state.message);
                }
              },
              listenWhen: (previous, current) =>
                  !(current is ForexTimeLineLoadingState),
            ),
            BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
              listener: (context, state) {
                if (state is LikedState) {
                  ScopedModel.of<ForexUIModel>(context).entity = state.forex;
                } else if (state is UnlikedState) {
                  ScopedModel.of<ForexUIModel>(context).entity = state.forex;
                }
              },
            ),
            BlocListener<ShareBloc, ShareState>(
              listener: (context, state) {
                if (state is ShareSuccess) {
                  ScopedModel.of<ForexUIModel>(context).entity = state.forex;
                }
              },
            ),
            BlocListener<ViewBloc, ViewState>(
              listener: (context, state) {
                if (state is ViewSuccess) {
                  ScopedModel.of<ForexUIModel>(context).entity = state.forex;
                }
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(forexUIModel.entity.currency.title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    GetIt.I
                        .get<NavigationService>()
                        .toSettingsScreen(context: context);
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    const LatestRateInfo(),
                    SizedBox(
                      height: 8,
                    ),
                    const RateTimeline(),
                  ],
                )),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
                buildWhen: (previous, current) =>
                    (current is ForexTimelineInitialState) ||
                    (current is ForexTimelineLoadSuccessState),
                builder: (context, state) {
                  if (state is ForexTimelineLoadSuccessState) {
                    return const ForexComment();
                  }
                  return const CommentBarPlaceholder();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
