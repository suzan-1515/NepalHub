import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samachar_hub/core/widgets/comment_bar_placeholder_widget.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/timeline/gold_silver_timeline_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/blocs/view/view_bloc.dart';
import 'package:samachar_hub/feature_gold/presentation/models/gold_silver_model.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/widgets/latest_price_info.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/widgets/price_timeline.dart';
import 'package:samachar_hub/feature_gold/presentation/ui/details/widgets/gold_silver_comment.dart';
import 'package:samachar_hub/feature_gold/utils/provider.dart';
import 'package:samachar_hub/core/extensions/view.dart';
import 'package:scoped_model/scoped_model.dart';

class GoldSilverDetailScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/gold-silver-detail';

  const GoldSilverDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoldSilverUIModel goldSilverUIModel =
        ModalRoute.of(context).settings.arguments;
    return GoldSilverProvider.goldSilverDetailBlocProvider(
      goldSilver: goldSilverUIModel.entity,
      child: ScopedModel<GoldSilverUIModel>(
        model: goldSilverUIModel,
        child: MultiBlocListener(
          listeners: [
            BlocListener<GoldSilverTimelineBloc, GoldSilverTimelineState>(
              listener: (context, state) {
                if (state is GoldSilverTimelineLoadErrorState) {
                  context.showMessage(state.message);
                } else if (state is GoldSilverTimelineErrorState) {
                  context.showMessage(state.message);
                }
              },
              listenWhen: (previous, current) =>
                  !(current is GoldSilverTimeLineLoadingState),
            ),
            BlocListener<LikeUnlikeBloc, LikeUnlikeState>(
              listener: (context, state) {
                if (state is LikedState) {
                  ScopedModel.of<GoldSilverUIModel>(context).entity =
                      state.goldSilver;
                } else if (state is UnlikedState) {
                  ScopedModel.of<GoldSilverUIModel>(context).entity =
                      state.goldSilver;
                }
              },
            ),
            BlocListener<ShareBloc, ShareState>(
              listener: (context, state) {
                if (state is ShareSuccess) {
                  ScopedModel.of<GoldSilverUIModel>(context).entity =
                      state.goldSilver;
                }
              },
            ),
            BlocListener<ViewBloc, ViewState>(
              listener: (context, state) {
                if (state is ViewSuccess) {
                  ScopedModel.of<GoldSilverUIModel>(context).entity =
                      state.goldSilver;
                }
              },
            ),
          ],
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(goldSilverUIModel.entity.category.title),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    const LatestPriceInfo(),
                    SizedBox(
                      height: 8,
                    ),
                    const PriceTimeline(),
                  ],
                )),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child:
                  BlocBuilder<GoldSilverTimelineBloc, GoldSilverTimelineState>(
                buildWhen: (previous, current) =>
                    (current is GoldSilverTimelineInitialState) ||
                    (current is GoldSilverTimelineLoadSuccessState),
                builder: (context, state) {
                  if (state is GoldSilverTimelineLoadSuccessState) {
                    return const GoldSilverComment();
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
