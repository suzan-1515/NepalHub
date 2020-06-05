import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_detail_store.dart';
import 'package:samachar_hub/pages/forex/forex_graph.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

class ForexDetailScreen extends StatefulWidget {
  @override
  _ForexDetailScreenState createState() => _ForexDetailScreenState();
}

class _ForexDetailScreenState extends State<ForexDetailScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<ForexDetailStore>(context, listen: false);
    _setupObserver(store);
    store.loadData();

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
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer<ForexDetailStore>(
          builder: (_, ForexDetailStore store, __) {
            return Container(
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
            );
          },
        ),
      ),
    );
  }
}
