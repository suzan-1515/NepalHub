import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_detail_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/widgets/comment_bar_widget.dart';

import 'widgets/forex_graph.dart';

class ForexDetailScreen extends StatefulWidget {
  @override
  _ForexDetailScreenState createState() => _ForexDetailScreenState();
}

class _ForexDetailScreenState extends State<ForexDetailScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<ForexDetailStore>(context, listen: false);
    final metaStore = Provider.of<PostMetaStore>(context, listen: false);
    _setupObserver(store);
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
    super.dispose();
  }

  _showMessage(String message) {
    if (null != message)
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );
  }

  _showErrorDialog(APIException apiError) {
    if (null != apiError)
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return ApiErrorDialog(
            apiError: apiError,
          );
        },
      );
  }

  _setupObserver(store) {
    _disposers = [
      // Listens for error message
      autorun((_) {
        final String message = store.error;
        _showMessage(message);
      }),
      // Listens for API error
      autorun((_) {
        final APIException error = store.apiError;
        _showErrorDialog(error);
      })
    ];
  }

  Widget _buildContent(BuildContext context, ForexDetailStore store) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<List<ForexModel>>(
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
          } else {
            return Center(child: ProgressView());
          }
        },
      ),
    );
  }

  Widget _buildTodayStat(BuildContext context, ForexDetailStore store) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Buy: ${store.forex.buying} Sell: ${store.forex.selling}',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForexDetailStore>(
      builder: (_, ForexDetailStore store, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              color: Theme.of(context).backgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      BackButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      PageHeading(
                        title: store.forex.currency,
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        _buildTodayStat(context, store),
                        _buildContent(context, store),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Consumer4<AuthenticationStore, NavigationService,
                ShareService, PostMetaStore>(
              builder: (_, authenticationStore, navigationService, shareService,
                  metaStore, __) {
                return Observer(
                  builder: (_) {
                    return CommentBar(
                      userProfileImageUrl: authenticationStore.user.avatar,
                      commentsCount:
                          metaStore.postMeta?.commentCount?.toString() ?? '0',
                      likesCount:
                          metaStore.postMeta?.likeCount?.toString() ?? '0',
                      isLiked: metaStore.postMeta?.isUserLiked ?? false,
                      onCommentTap: () {
                        navigationService.onViewCommentsTapped(
                            context: context, title: 'Forex', postId: 'forex');
                      },
                      onLikeTap: (value) {
                        if (value) {
                          metaStore.removeLike().then((value) {
                            // store.feed.liked.value = !value;
                          });
                        } else {
                          metaStore.postLike().then((value) {
                            // store.feed.liked.value = value;
                          });
                        }
                      },
                      onShareTap: () {
                        if (store.forex != null)
                          shareService.share(
                              postId: store.forex.code,
                              title: store.forex.currency,
                              data:
                                  'Currency:${store.forex.currency}\nBuy: ${store.forex.buying}\nSell: ${store.forex.selling}\nLast updated: ${store.forex.addedDate}');
                        metaStore.postShare();
                      },
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
