import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/comment_model.dart';
import 'package:samachar_hub/pages/comment/comment_store.dart';
import 'package:samachar_hub/pages/comment/widgets/comment_item.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/services.dart';
import 'package:samachar_hub/stores/stores.dart';

class CommentScreen extends StatefulWidget {
  final String postTitle;
  final String postId;

  const CommentScreen(
      {Key key, @required this.postTitle, @required this.postId})
      : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  // Reaction disposers
  List<ReactionDisposer> _disposers;
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    final store = Provider.of<CommentStore>(context, listen: false);
    _setupObserver(store);
    store.setPostId(widget.postId);
    store.setPostTitle(widget.postTitle);
    store.loadInitialData();
    Provider.of<PostMetaStore>(context, listen: false).loadPostMeta();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose reactions
    for (final d in _disposers) {
      d();
    }
    _textEditingController.dispose();
    super.dispose();
  }

  _showMessage(String message) {
    if (null != message)
      _scaffoldkey.currentState.showSnackBar(
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

  Widget _buildTitle(BuildContext context, CommentStore store) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Observer(
        builder: (_) {
          return Text(
            store.postTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          );
        },
      ),
    );
  }

  Widget _buildStatsCount(BuildContext context, CommentStore store) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Consumer<PostMetaStore>(
        builder: (_, PostMetaStore metaStore, Widget child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Observer(
                builder: (BuildContext context) {
                  return Text(
                    '${metaStore.postMeta?.commentCount ?? 0} Comments',
                    style: Theme.of(context).textTheme.bodyText2,
                  );
                },
              ),
              SizedBox(
                width: 8,
              ),
              Observer(
                builder: (_) {
                  return Text(
                    '${metaStore.postMeta?.likeCount ?? 0} Likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommentList(BuildContext context, CommentStore store) {
    return StreamBuilder<List<CommentModel>>(
        stream: store.dataStream,
        builder: (_, AsyncSnapshot<List<CommentModel>> snapshot) {
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
            return RefreshIndicator(
              onRefresh: () async {
                await store.refresh();
              },
              child: IncrementallyLoadingListView(
                loadMoreOffsetFromBottom: 2,
                hasMore: () => store.hasMoreData,
                itemBuilder: (_, int index) {
                  Widget itemWidget = CommentItem(
                      context: context,
                      data: snapshot.data[index],
                      store: store);
                  if (index == snapshot.data.length - 1 &&
                      store.hasMoreData &&
                      !store.isLoadingMore) {
                    return Column(
                      children: <Widget>[
                        itemWidget,
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProgressView(),
                        ),
                      ],
                    );
                  }
                  return itemWidget;
                },
                itemCount: () => snapshot.data.length,
                loadMore: () async {
                  return await store.loadMoreData(after: snapshot.data.last);
                },
              ),
            );
          } else {
            return Center(child: ProgressView());
          }
        });
  }

  Widget _buildList(CommentStore store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverToBoxAdapter(
            child: _buildTitle(context, store),
          ),
          SliverToBoxAdapter(
            child: _buildStatsCount(context, store),
          ),
        ],
        body: _buildCommentList(context, store),
      ),
    );
  }

  Widget _buildCommentInputBar(BuildContext context, CommentStore store) {
    return Consumer2<AuthenticationStore, NavigationService>(
      builder: (_, AuthenticationStore authStore,
          NavigationService navigationService, Widget child) {
        return Container(
          color: Theme.of(context).backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Observer(
            builder: (BuildContext context) {
              return Material(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).cardColor,
                      backgroundImage: authStore.isLoggedIn
                          ? NetworkImage(authStore.user.avatar)
                          : AssetImage('assets/images/user.png'),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      child: TextField(
                        onSubmitted: (value) {
                          _submitComment(context, store, authStore,
                              navigationService, value.trim());
                          _textEditingController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a comment'),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: Colors.lightBlue,
                      ),
                      onPressed: () {
                        _submitComment(
                            context,
                            store,
                            authStore,
                            navigationService,
                            _textEditingController.value.text.trim());
                        _textEditingController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  _submitComment(
      BuildContext context,
      CommentStore store,
      AuthenticationStore authStore,
      NavigationService navigationService,
      String comment) async {
    if (comment == null || comment.isEmpty) return;
    if (authStore.isLoggedIn) {
      return store.submitComment(comment: comment).then((value) {
        _showMessage('Comment posted.');
      });
    }
    navigationService.loginRedirect(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Consumer<CommentStore>(
            builder: (_, store, child) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      BackButton(
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      PageHeading(
                        title: 'Comments',
                      ),
                    ],
                  ),
                  Expanded(
                    child: _buildList(store),
                  ),
                  _buildCommentInputBar(context, store)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
