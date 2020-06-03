import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/data/models/forex_model.dart';
import 'package:samachar_hub/pages/forex/forex_graph.dart';
import 'package:samachar_hub/pages/forex/forex_store.dart';
import 'package:samachar_hub/pages/widgets/api_error_dialog.dart';
import 'package:samachar_hub/pages/widgets/empty_data_widget.dart';
import 'package:samachar_hub/pages/widgets/error_data_widget.dart';
import 'package:samachar_hub/pages/widgets/page_heading_widget.dart';
import 'package:samachar_hub/pages/widgets/progress_widget.dart';

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
      Scaffold.of(context).showSnackBar(
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
      child: ListTile(
        onTap: () {},
        leading: SvgPicture.network(
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
        title: Text(
          '${data.currency} (${data.code})',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              data.unit.toString(),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(width: 8),
            Text(data.buying.toString(),
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(width: 8),
            Text(data.selling.toString(),
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
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
            itemCount: snapshot.data.length,
            separatorBuilder: (_, index) => Divider(),
            itemBuilder: (_, index) =>
                _buildForexItem(context, snapshot.data[index], store),
          );
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

  Widget _buildCurrencyConverter(BuildContext context, ForexStore store) {
    return Container(height: 100, child: Placeholder());
  }

  Widget _buildContent(BuildContext context, ForexStore store) {
    return NestedScrollView(
      headerSliverBuilder: (_, __) => [
        SliverToBoxAdapter(child: _buildDefaultCurrencyStat(context, store)),
        SliverToBoxAdapter(child: _buildCurrencyConverter(context, store)),
      ],
      body: _buildList(context, store),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Consumer<ForexStore>(
          builder: (_, ForexStore store, __) {
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
                        title: 'Forex',
                      ),
                    ],
                  ),
                  Expanded(
                    child: _buildContent(context, store),
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
