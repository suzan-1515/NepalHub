import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:samachar_hub/core/services/services.dart';
import 'package:samachar_hub/core/widgets/comment_bar_placeholder_widget.dart';
import 'package:samachar_hub/core/widgets/progress_widget.dart';
import 'package:samachar_hub/core/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/feature_auth/presentation/blocs/auth_bloc.dart';
import 'package:samachar_hub/feature_comment/domain/entities/thread_type.dart';
import 'package:samachar_hub/feature_forex/domain/entities/forex_entity.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/like_unlike/like_unlike_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/share/share_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/blocs/timeline/forex_timeline_bloc.dart';
import 'package:samachar_hub/feature_forex/presentation/ui/widgets/forex_graph.dart';
import 'package:samachar_hub/feature_forex/presentation/extensions/forex_extensions.dart';
import 'package:samachar_hub/feature_forex/utils/provider.dart';

class ForexDetailScreen extends StatelessWidget {
  final ForexEntity forexEntity;
  const ForexDetailScreen({Key key, @required this.forexEntity})
      : assert(forexEntity != null, 'Forex cannot be null.'),
        super(key: key);

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
      builder: (context, state) {
        if (state is ForexTimelineLoadSuccessState) {
          return ForexGraph(
            timeline: state.forexList,
          );
        } else if (state is ForexTimeLineLoadingState) {
          return Center(child: ProgressView());
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildTodayStat(BuildContext context) {
    return Text(
      'Buy: ${forexEntity.buying} Sell: ${forexEntity.selling}',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _buildCommentBar(BuildContext context) {
    final user = context.bloc<AuthBloc>().currentUser;
    final forexUIModel = context.bloc<ForexTimelineBloc>().forexUIModel;
    return BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
      builder: (context, state) {
        return CommentBar(
          likeCount: forexUIModel?.formattedLikeCount ?? '0',
          onCommentTap: () => GetIt.I.get<NavigationService>().toCommentsScreen(
              context: context,
              threadTitle: forexUIModel.forexEntity.currency.title,
              threadId: forexUIModel.forexEntity.id,
              threadType: CommentThreadType.FOREX),
          onShareTap: () {
            context.bloc<ShareBloc>().add(Share());
          },
          commentCount: forexUIModel?.formattedCommentCount ?? '0',
          isLiked: forexUIModel?.forexEntity?.isLiked ?? false,
          shareCount: forexUIModel?.formattedShareCount ?? '0',
          userAvatar: user?.avatar,
          onLikeTap: () {
            if (forexUIModel.forexEntity.isLiked) {
              forexUIModel.unlike();
              context.bloc<LikeUnlikeBloc>().add(UnlikeEvent());
            } else {
              forexUIModel.like();
              context.bloc<LikeUnlikeBloc>().add(LikeEvent());
            }
          },
        );
      },
    );
  }

  Widget _buildComment() {
    return BlocBuilder<ForexTimelineBloc, ForexTimelineState>(
      buildWhen: (previous, current) => !(current is ForexTimelineErrorState),
      builder: (context, state) {
        if (state is ForexTimelineLoadSuccessState) {
          return _buildCommentBar(context);
        }
        return const CommentBarPlaceholder();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ForexProvider.forexDetailBlocProvider(
      forexUIModel: forexEntity.toUIModel,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(forexEntity.currency.title),
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
                _buildTodayStat(context),
                _buildContent(context),
              ],
            )),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: _buildComment(),
        ),
      ),
    );
  }
}
