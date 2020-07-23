import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';
import 'package:samachar_hub/services/navigation_service.dart';

import 'widgets/forex_converter.dart';
import 'widgets/forex_graph.dart';

class ForexScreen extends StatefulWidget {
  @override
  _ForexScreenState createState() => _ForexScreenState();
}

class _ForexScreenState extends State<ForexScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = Provider.of<ForexStore>(context, listen: false);
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

  Widget _buildForexItem(
      BuildContext context, ForexModel data, ForexStore store) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.read<NavigationService>().toForexDetailScreen(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SvgPicture.network(
                'https://www.ashesh.com.np/forex/flag/${data.code}.svg',
                placeholderBuilder: (_) {
                  return Container(
                    width: 32,
                    height: 32,
                    color: Theme.of(context).cardColor,
                  );
                },
                width: 32,
                height: 32,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${data.currency} (${data.code})',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(
                data.unit.toString(),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.buying.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Text(data.selling.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              'Foreign Exchange',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(
              'Unit',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text('Buy', style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text('Sell', style: Theme.of(context).textTheme.subtitle1),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, ForexStore store) {
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
          return ListView.separated(
              itemCount: snapshot.data.length + 1,
              separatorBuilder: (_, index) {
                return Observer(
                  builder: (_) {
                    ForexModel defaultForex = store.defaultForex;
                    if (index == 1) {
                      if (defaultForex != null) {
                        return ForexConverter(
                            items: snapshot.data,
                            defaultForex: defaultForex,
                            store: store);
                      }
                    }
                    return Divider();
                  },
                );
              },
              itemBuilder: (_, index) {
                if (index == 0) return _buildHeader(context);
                return _buildForexItem(
                    context, snapshot.data[index - 1], store);
              });
        } else {
          return Center(child: ProgressView());
        }
      },
    );
  }

  Widget _buildDefaultCurrencyStat(BuildContext context, ForexStore store) {
    return Observer(
      builder: (_) {
        if (store.defaultForexTimeline != null &&
            store.defaultForexTimeline.isNotEmpty) {
          return ForexGraph(
            timeline: store.defaultForexTimeline,
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildContent(BuildContext context, ForexStore store) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(child: _buildDefaultCurrencyStat(context, store)),
        ],
        body: _buildList(context, store),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForexStore>(
      builder: (_, ForexStore store, __) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text('Forex'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  context
                      .read<NavigationService>()
                      .toSettingsScreen(context: context)
                      .whenComplete(() => store.retry());
                },
              ),
            ],
          ),
          body: SafeArea(
            child: _buildContent(context, store),
          ),
        );
      },
    );
  }
}
