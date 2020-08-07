import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:samachar_hub/data/api/api.dart';
import 'package:samachar_hub/pages/forex/widgets/forex_list.dart';
import 'package:samachar_hub/services/navigation_service.dart';
import 'package:samachar_hub/stores/stores.dart';
import 'package:samachar_hub/utils/extensions.dart';

import 'widgets/forex_graph.dart';

class ForexScreen extends StatefulWidget {
  @override
  _ForexScreenState createState() => _ForexScreenState();
}

class _ForexScreenState extends State<ForexScreen> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    final store = context.read<ForexStore>();
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

  _setupObserver(store) {
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
      })
    ];
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
          SliverToBoxAdapter(
            child: _buildDefaultCurrencyStat(context, store),
          ),
        ],
        body: ForexList(context: context, store: store),
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
