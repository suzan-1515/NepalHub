import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/forex/forex_detail_store.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';
import 'package:samachar_hub/utils/extensions.dart';

import 'widgets/forex_graph.dart';

class ForexDetailScreen extends StatefulWidget {
  @override
  _ForexDetailScreenState createState() => _ForexDetailScreenState();
}

class _ForexDetailScreenState extends State<ForexDetailScreen> {
  List<ReactionDisposer> _disposers;
  final ValueNotifier<bool> likeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> likeCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> commentCountNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    final store = context.read<ForexDetailStore>();
    final metaStore = context.read<PostMetaStore>();
    _setupObserver(store, metaStore);
    store.loadData();
    metaStore.loadPostMeta();
    metaStore.postView();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    likeNotifier.dispose();
    likeCountNotifier.dispose();
    commentCountNotifier.dispose();
    super.dispose();
  }

  _setupObserver(store, metaStore) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        if (message != null) context.showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        if (error != null) context.showErrorDialog(error);
      }),
      autorun((_) {
        final PostMetaModel metaModel = metaStore.postMeta;
        _updateMeta(metaModel);
      }),
    ];
  }

  void _updateMeta(PostMetaModel metaModel) {
    if (metaModel.isUserLiked != null)
      this.likeNotifier.value = metaModel.isUserLiked;
    if (metaModel.likeCount != null)
      this.likeCountNotifier.value = metaModel.likeCount;
    if (metaModel.commentCount != null)
      this.commentCountNotifier.value = metaModel.commentCount;
  }

  Widget _buildContent(BuildContext context, ForexDetailStore store) {
    return StreamBuilder<List<ForexModel>>(
      stream: store.dataStream,
      builder: (_, AsyncSnapshot<List<ForexModel>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: ErrorDataView(
              onRetry: () => store.retry(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: EmptyDataView(),
            );
          }
          return ForexGraph(timeline: snapshot.data);
        }
        return Center(child: ProgressView());
      },
    );
  }

  Widget _buildTodayStat(BuildContext context, ForexDetailStore store) {
    return Text(
      'Buy: ${store.forex.buying} Sell: ${store.forex.selling}',
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ForexDetailStore, PostMetaStore>(
      builder: (_, ForexDetailStore store, PostMetaStore metaStore, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text(store.forex.currency),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  context
                      .read<NavigationService>()
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
                  _buildTodayStat(context, store),
                  _buildContent(context, store),
                ],
              )),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Consumer<AuthenticationStore>(
              builder: (_, authenticationStore, __) {
                return Observer(
                  builder: (_) {
                    return IgnorePointer(
                      ignoring: metaStore.postMeta == null,
                      child: CommentBar(
                        userProfileImageUrl: authenticationStore.user.avatar,
                        commentCountNotifier: this.commentCountNotifier,
                        likeCountNotifier: this.likeCountNotifier,
                        likeNotifier: this.likeNotifier,
                        onCommentTap: () {
                          context.read<NavigationService>().toCommentsScreen(
                              context: context,
                              title: 'Forex',
                              postId: 'forex');
                        },
                        onLikeTap: (value) {
                          likeNotifier.value = !value;
                          if (value) {
                            metaStore.removeLike().catchError((value) {
                              likeNotifier.value = value;
                            });
                          } else {
                            metaStore.postLike().catchError((value) {
                              likeNotifier.value = value;
                            });
                          }
                        },
                        onShareTap: () {
                          if (store.forex != null)
                            context.read<ShareService>().share(
                                postId: store.forex.code,
                                title: store.forex.currency,
                                data:
                                    'Currency:${store.forex.currency}\nBuy: ${store.forex.buying}\nSell: ${store.forex.selling}\nLast updated: ${store.forex.addedDate}');
                          metaStore.postShare();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
