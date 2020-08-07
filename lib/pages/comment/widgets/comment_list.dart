import 'package:flutter/material.dart';
import 'package:samachar_hub/data/models/models.dart';
import 'package:samachar_hub/pages/comment/widgets/comment_item.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/stores/comment/comment_store.dart';
import 'package:samachar_hub/widgets/incrementally_loading_listview.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key key,
    @required this.context,
    @required this.store,
  }) : super(key: key);

  final BuildContext context;
  final CommentStore store;

  @override
  Widget build(BuildContext context) {
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
                child: EmptyDataView(
                  text: 'Comments has not been posted yet. Comment below.',
                ),
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
                  Widget itemWidget = CommentListItem(
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
}
